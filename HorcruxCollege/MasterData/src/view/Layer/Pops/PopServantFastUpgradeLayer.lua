PopServantFastUpgradeLayer = class("PopServantFastUpgradeLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local L2Actor = require("view.Sprite.L2Actor")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local core_manager = require("controller.core_manager")
local souls_manager = require("controller.souls_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local l2utils = require("controller.l2utils")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_13 = 5
local var_0_14 = "role/"

function PopServantFastUpgradeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantFastUpgradeLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopServantFastUpgradeLayer:init(arg_3_1)
	self.servants = arg_3_1.servantsInfos
	self.old_infos = arg_3_1.old_infos
	self.cur_idx = 1
	self.touchFlag = false

	self:initUI()
end

function PopServantFastUpgradeLayer:initUI(arg_4_1)
	self.rootpanel = ccui.ImageView:create("PopServantFastUpgradeLayer/bg.png", var_0_0)

	self.rootpanel:setAnchorPoint(0, 0)
	self.rootpanel:setPositionY(-GameDisplay.fix_y)
	self.rootpanel:setTouchEnabled(true)
	self.rootpanel:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.touchFlag then
			return
		end

		if self.cur_idx < var_0_13 and self.cur_idx < #self.servants then
			self:updateUpgradeShow()
		elseif self.cur_idx == var_0_13 or self.cur_idx == #self.servants then
			self.cur_idx = self.cur_idx + 1

			self:initShowPanel()
		else
			self:exit()
		end
	end)
	self:addChild(self.rootpanel, 1)
	self:playUpgradeAni()
end

function PopServantFastUpgradeLayer:playUpgradeAni(arg_6_1)
	local var_6_0 = self:getOffset(servant_data[self.servants[1].servantid].modelid, 1)
	local var_6_1 = model_data[servant_data[self.servants[1].servantid].modelid].database_girl_scale or 1
	local var_6_2 = ccui.ImageView:create(var_0_14 .. model_data[servant_data[self.servants[1].servantid].modelid].role_image .. ".png")

	var_6_2:setPosition(var_6_0)
	var_6_2:setScale(var_6_1)
	self.rootpanel:addChild(var_6_2, 1)
	l2utils:shaderDarkPicNode(var_6_2:getVirtualRenderer(), {
		z = 0.1,
		x = 0.1,
		y = 0.1
	})

	self.roleShadowImg = var_6_2

	local var_6_3 = ccui.ImageView:create(var_0_14 .. model_data[servant_data[self.servants[1].servantid].modelid].role_image .. ".png")

	var_6_3:setPosition(var_6_0)
	var_6_3:setScale(var_6_1)
	var_6_3:setVisible(false)
	self.rootpanel:addChild(var_6_3, 3)

	self.roleImg = var_6_3

	var_6_3:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function(...)
		self.touchFlag = true

		var_6_2:setVisible(false)
		var_6_3:setVisible(true)
		var_6_3:setOpacity(0)
		var_6_3:runAction(cc.FadeTo:create(0.2, 120))
	end)))

	local var_6_4 = L2Skeleton:create("spine/ui/girl_upgrade/ui_xia_ceng.json", "spine/ui/girl_upgrade/ui_xia_ceng.atlas")

	var_6_4:refreshSkeleton()
	var_6_4:setPosition(cc.p(320, 568))
	var_6_4:play("animation", false)
	self.rootpanel:addChild(var_6_4, 2)

	local var_6_5 = L2Skeleton:create("spine/ui/girl_upgrade/ui_shang_ceng.json", "spine/ui/girl_upgrade/ui_shang_ceng.atlas")

	var_6_5:refreshSkeleton()
	var_6_5:setPosition(cc.p(320, 568))
	var_6_5:play("animation", false)
	self.rootpanel:addChild(var_6_5, 4)
	self.rootpanel:runAction(cc.Sequence:create(cc.DelayTime:create(1.6), cc.CallFunc:create(function()
		self:updateLabel()
	end)))
end

function PopServantFastUpgradeLayer:updateLabel()
	local var_9_0, var_9_1, var_9_2 = playermodel:getServantInfo(self.servants[self.cur_idx].servantid)
	local var_9_3 = {
		{
			text = L_HORCRUX_BREAK_LIMIT.Aptitude_Str[1],
			value1 = self.old_infos[self.servants[self.cur_idx].servantid].old_contract,
			value2 = var_9_0
		},
		{
			text = L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2],
			value1 = self.old_infos[self.servants[self.cur_idx].servantid].Damage,
			value2 = var_9_2
		},
		{
			text = L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3],
			value1 = self.old_infos[self.servants[self.cur_idx].servantid].Hp,
			value2 = var_9_1
		}
	}

	if not self.rootpanel:getChildByName("text1") then
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_4 = 760
			local var_9_5 = 80
			local var_9_6 = ccui.Text:create(iter_9_1.text, FONT_DES, 28)
			local var_9_7 = iter_9_0 == 1 and cc.c3b(255, 192, 0) or cc.c3b(255, 255, 255)

			var_9_6:setColor(var_9_7)
			var_9_6:setPositionX(240)
			var_9_6:setPositionY(var_9_4 + 80 - iter_9_0 * var_9_5)
			var_9_6:setOpacity(0)
			var_9_6:runAction(cc.Sequence:create(cc.DelayTime:create(iter_9_0 * 0.2), cc.Spawn:create(cc.FadeIn:create(0.3))))
			self.rootpanel:addChild(var_9_6, 5)
			var_9_6:setName("text" .. iter_9_0)

			local var_9_8 = ccui.Text:create(iter_9_1.value1, FONT_DES, 28)

			var_9_8:setColor(var_9_7)
			var_9_8:setPositionX(330)
			var_9_8:setPositionY(var_9_4 + 80 - iter_9_0 * var_9_5)
			var_9_8:setOpacity(0)
			var_9_8:runAction(cc.Sequence:create(cc.DelayTime:create(iter_9_0 * 0.2), cc.FadeIn:create(0.3)))
			self.rootpanel:addChild(var_9_8, 5)
			var_9_8:setName("textValue" .. iter_9_0)

			local var_9_9 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

			var_9_9:setPositionX(390)
			var_9_9:setPositionY(var_9_4 + 80 - iter_9_0 * var_9_5)
			var_9_9:setOpacity(0)
			var_9_9:runAction(cc.Sequence:create(cc.DelayTime:create(iter_9_0 * 0.2), cc.FadeIn:create(0.3)))
			self.rootpanel:addChild(var_9_9, 5)
			var_9_9:setName("Image_Arrow" .. iter_9_0)

			local var_9_10 = ccui.Text:create(iter_9_1.value2, FONT_DES, 28)

			var_9_10:setColor(var_9_7)
			var_9_10:setPositionX(450)
			var_9_10:setPositionY(var_9_4 + 80 - iter_9_0 * var_9_5)
			var_9_10:setOpacity(0)
			var_9_10:runAction(cc.Sequence:create(cc.DelayTime:create(iter_9_0 * 0.2), cc.FadeIn:create(0.3)))
			self.rootpanel:addChild(var_9_10, 5)
			var_9_10:setName("curValue" .. iter_9_0)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(var_9_3) do
			local var_9_11 = self.rootpanel:getChildByName("text" .. iter_9_2)
			local var_9_12 = self.rootpanel:getChildByName("textValue" .. iter_9_2)
			local var_9_13 = self.rootpanel:getChildByName("Image_Arrow" .. iter_9_2)
			local var_9_14 = self.rootpanel:getChildByName("curValue" .. iter_9_2)

			var_9_11:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function()
				var_9_11:setString(iter_9_3.text)
			end), cc.FadeIn:create(0.3)))
			var_9_12:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function()
				var_9_12:setString(iter_9_3.value1)
			end), cc.FadeIn:create(0.3)))
			var_9_13:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.FadeIn:create(0.3)))
			var_9_14:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function()
				var_9_14:setString(iter_9_3.value2)
			end), cc.FadeIn:create(0.3)))
		end
	end
end

function PopServantFastUpgradeLayer:updateUpgradeShow()
	self.cur_idx = self.cur_idx + 1
	self.touchFlag = false

	local var_13_0 = model_data[servant_data[self.servants[self.cur_idx].servantid].modelid].role_image
	local var_13_1 = self:getOffset(servant_data[self.servants[self.cur_idx].servantid].modelid, 1)
	local var_13_2 = model_data[servant_data[self.servants[self.cur_idx].servantid].modelid].database_girl_scale or 1

	self.roleImg:runAction(cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function(...)
		self.roleImg:loadTexture(var_0_14 .. var_13_0 .. ".png")
		self.roleImg:setPosition(var_13_1)
		self.roleImg:setScale(var_13_2)
		self.roleImg:setVisible(true)
		self.roleImg:setOpacity(0)
	end), cc.FadeTo:create(0.2, 120), cc.CallFunc:create(function()
		self.touchFlag = true
	end)))
	self:updateLabel()
end

function PopServantFastUpgradeLayer:initShowPanel(arg_16_1)
	self.rootpanel:removeAllChildren()

	self.title = ccui.ImageView:create("PopServantFastUpgradeLayer/title.png", var_0_0)

	self.rootpanel:addChild(self.title)
	self.title:setAnchorPoint(0.5, 1)
	self.title:setPosition(320, GameDisplay.height - 30)

	self.servantsView = cc.TableView:create(cc.size(600, 880 + GameDisplay.fix_y))

	self.servantsView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.servantsView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.servantsView:setAnchorPoint(cc.p(0, 0))
	self.servantsView:setPosition(20, 150)
	self.servantsView:setDelegate()
	self.rootpanel:addChild(self.servantsView, 2)
	self.servantsView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 600, 300
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.servantsView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell()

		if not var_17_0 then
			var_17_0 = cc.TableViewCell:create()

			local var_17_1 = self:createSp(arg_17_1)

			var_17_1:setName("sp")
			var_17_0:addChild(var_17_1)
		end

		var_17_0:getChildByName("sp").update(arg_17_1)

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.servantsView:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = math.floor(#self.servants / 5)

		if #self.servants % 5 == 0 then
			return var_19_0
		else
			return var_19_0 + 1
		end
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.servantsView:reloadData()

	local var_16_0 = ccui.Layout:create()

	var_16_0:setContentSize(cc.size(600, 880 + GameDisplay.fix_y))
	var_16_0:setPosition(20, 150)
	var_16_0:setTouchEnabled(true)
	self.rootpanel:addChild(var_16_0)
end

function PopServantFastUpgradeLayer.createSp(arg_20_0, arg_20_1)
	local var_20_0 = ccui.ImageView:create("PopServantFastUpgradeLayer/listbg.png", var_0_0)

	var_20_0:setAnchorPoint(0, 0)
	var_20_0:setPosition(0, 150)

	for iter_20_0 = 1, 5 do
		local var_20_1 = TempWidget:CreateTempBtn("PopServantFastUpgradeLayer/role_bg2.png")

		var_20_1:loadTexturePressed("PopServantFastUpgradeLayer/role_bg2.png")
		var_20_1:loadTextureDisabled("PopServantFastUpgradeLayer/role_bg2.png")
		var_20_1:setAnchorPoint(0, 0)
		var_20_1:setSwallowTouches(false)
		var_20_1:setName("sp" .. iter_20_0)
		var_20_1:setPosition(112 * iter_20_0 - 100, 20)
		var_20_0:addChild(var_20_1)

		local var_20_2 = ccui.ImageView:create("PopServantFastUpgradeLayer/contract_icon.png", var_0_0)

		var_20_2:setPosition(var_20_1:getContentSize().width / 2, -90)
		var_20_2:setName("contract_icon")
		var_20_1:addChild(var_20_2)

		local var_20_3 = cc.Label:createWithTTF("", FONT_W5, 25)

		var_20_3:setColor(cc.c3b(83, 151, 199))
		var_20_3:setPosition(var_20_1:getContentSize().width / 2, -40)
		var_20_3:setName("old_contract")
		var_20_1:addChild(var_20_3)

		local var_20_4 = cc.Label:createWithTTF("", FONT_W5, 25)

		var_20_4:setColor(cc.c3b(218, 99, 239))
		var_20_4:setPosition(var_20_1:getContentSize().width / 2, -140)
		var_20_4:setName("cur_contract")
		var_20_1:addChild(var_20_4)

		if arg_20_1 < 4 then
			var_20_1:setOpacity(0)
			var_20_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * (arg_20_1 * 5 + iter_20_0)), cc.FadeIn:create(0.05)))
		end
	end

	function var_20_0.update(arg_21_0)
		for iter_21_0 = 1, 5 do
			local var_21_0 = var_20_0:getChildByName("sp" .. iter_21_0)

			var_21_0:removeChildByName("roleIcon")

			if arg_20_0.servants[arg_21_0 * 5 + iter_21_0] then
				var_21_0:setVisible(true)

				local var_21_2 = ccui.ImageView:create(ROLE_PORTRAIT_PATH .. model_data[servant_data[arg_20_0.servants[arg_21_0 * 5 + iter_21_0].servantid].modelid].portrait_image .. ".png")

				var_21_2:setScale(0.9)
				var_21_2:setPosition(var_21_0:getContentSize().width / 2, var_21_0:getContentSize().height / 2)
				var_21_2:setName("roleIcon")
				var_21_0:addChild(var_21_2, 1)
				var_21_0:getChildByName("old_contract"):setString(arg_20_0.old_infos[arg_20_0.servants[arg_21_0 * 5 + iter_21_0].servantid].old_contract)
				var_21_0:getChildByName("cur_contract"):setString(arg_20_0.old_infos[arg_20_0.servants[arg_21_0 * 5 + iter_21_0].servantid].old_contract + arg_20_0.servants[arg_21_0 * 5 + iter_21_0].contract_count)
			else
				var_21_0:setVisible(false)
			end
		end
	end

	return var_20_0
end

function PopServantFastUpgradeLayer:exit()
	if self.servantsView then
		self.servantsView:setVisible(false)
	end

	self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopServantFastUpgradeLayer.getOffset(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0
	local var_24_1

	if false then
		var_24_0 = model_data[arg_24_1].shadow_girl_offset_x or 0
		var_24_1 = model_data[arg_24_1].shadow_girl_offset_y or 0
	else
		var_24_0 = model_data[arg_24_1].upgrade_offset_x or model_data[arg_24_1].database_girl_offset_x or 0
		var_24_1 = model_data[arg_24_1].upgrade_offset_y or model_data[arg_24_1].database_girl_offset_y or 0

		hx_print("modelid:" .. arg_24_1 .. " " .. model_data[arg_24_1].name .. " 使用偏移 upgrade_offset_x or database_girl_offset_x = " .. (var_24_0 or 0) .. " upgrade_offset_y or database_girl_offset_y = " .. (var_24_1 or 0), CONSOLE_COLOR_GREEN)
	end

	return (cc.p(var_24_0 + 320, var_24_1 + GameDisplay.height / 2))
end
