PopServantBreakout = class("PopServantBreakout", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local var_0_9 = require("data.total_skill_data")
local model_data = require("data.model_data")
local core_data = require("data.core_data")
local var_0_12 = "role/"

require("view.Sprite.ItemSprite")

local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")

local function var_0_15(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_2_0), checknumber(var_2_1))
end

function PopServantBreakout:getOffset(arg_3_1, arg_3_2)
	local var_3_1

	if arg_3_2 then
		var_3_1 = self.displayType == "preview" and cc.p(model_data[arg_3_1].database_offset_x + HIDEGIRLPOS.x, model_data[arg_3_1].database_offset_y + HIDEGIRLPOS.y) or cc.p((model_data[arg_3_1].breakout_offset_x or database_equip_offset_x or 0) + 55, nil + 200)
	else
		var_3_1 = model_data[arg_3_1].mainmidpos and var_0_15(model_data[arg_3_1].mainmidpos) or cc.p(320, -50)
		offset = model_data[arg_3_1].mainmidoffset and var_0_15(model_data[arg_3_1].mainmidoffset) or cc.p(0, 0)
		var_3_1.x = var_3_1.x + offset.x
		var_3_1.y = var_3_1.y + offset.y
	end

	if model_data[arg_3_1].is_big_role_image == 1 then
		var_3_1.x = 0
		var_3_1.y = 0
	end

	return var_3_1
end

function PopServantBreakout.getSkinScale(arg_4_0, arg_4_1)
	return model_data[arg_4_1].is_big_role_image or 0.8
end

function PopServantBreakout.create(arg_5_0, arg_5_1)
	local var_5_0 = PopServantBreakout.new()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function PopServantBreakout:init(arg_6_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_servant_breakout.json" or "Pop_servant_breakout.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setAnchorPoint(cc.p(0.5, 0.5))
	self.layout:setBackGroundImage(DATABASEBG)
	self.layout:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.layout)

	self.mask = ccui.Layout:create()

	self.mask:setContentSize(cc.size(640, GameDisplay.height))
	self.mask:setAnchorPoint(cc.p(0.5, 0.5))
	self.mask:setBackGroundImage("mainScenebg/blur_mask.png")
	self.mask:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.mask)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_18")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self:ActionofAccess(self.rootpanel)

	self.msg = arg_6_1 or {}
	self.goto_back_system_id = arg_6_1.goto_back_system_id
	self.servantid = arg_6_1.servantid
	self.surecallback = arg_6_1.surecallback
	self.up_type = arg_6_1.up_type or 1
	self.activity = true
	self.skill_bottom = ccui.Helper:seekWidgetByName(self.rootLayer, "skill_bottom")
	self.image_Role = ccui.Helper:seekWidgetByName(self.rootLayer, "role")

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_7_0()
			LayerManager:removePopLayer(self.__queueindex)
		end

		self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			if var_7_0 then
				var_7_0()
			end
		end)))
	end)

	self.sureBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")

	self.sureBtn:setLocalZOrder(1)
	self.sureBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.sureBtn.goldFlag then
			global_ShowBlockWords(L_GOLD_LACK)
			LayerManager:pushInLayer("HandOfMidasLayer", {
				callback = function()
					self:updateUI(arg_6_1)
				end
			})

			return
		end

		if not self.sureBtn.satisfied then
			global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)

			return
		end

		if core_manager:getServantCoreRank(self.servantid) >= #CLASS_TYPE_ID then
			global_ShowBlockWords(L_SERVANT_BREAKOUT_MSG.Times_Limit)

			return
		end

		if self.surecallback then
			self.surecallback(function(arg_12_0)
				if not self.activity then
					return
				end

				if arg_12_0 == 1 then
					self.hideActions.shrinkVertical(self, function()
						self.activity = false

						LayerManager:removePopLayer(self.__queueindex)
					end)
				end

				arg_10_0:setBright(true)
			end)
		end
	end)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleCompoundOneKey))
	Utility:registerNodeEvent(self)
	self:updateUI(arg_6_1)
end

function PopServantBreakout.onExit(arg_14_0)
	LocalEvent:removeEvent(arg_14_0)
end

function PopServantBreakout:updateUI(arg_15_1)
	local var_15_0 = core_manager:getServantCoreRank(self.servantid)
	local var_15_2 = core_manager:getCoreLv(self.servantid)
	local var_15_3 = global_get_servant_skin(self.servantid)

	ccui.Helper:seekWidgetByName(self.rootLayer, "break_times"):setFontSize(20)

	local var_15_4 = self.up_type == 1 and var_15_0 or var_15_0 - SERVANT_CORE_BREAK_MAX

	ccui.Helper:seekWidgetByName(self.rootLayer, "break_times"):setPositionX(82)
	ccui.Helper:seekWidgetByName(self.rootLayer, "break_times"):setString(L_CORE_UP_DES[self.up_type] .. " " .. string.format(L_SOULS_BREAK_TIMES, var_15_4))

	if var_15_0 >= #CLASS_TYPE_ID or core_manager:isCoreMax(self.servantid) then
		self:setMaxBreak()
	else
		self:setGirl()
		self:setAttr(arg_15_1)
		self:setMaterial(arg_15_1)

		if self.up_type == 1 and model_data[servant_data[self.servantid].modelid]["ex_" .. var_15_0 + 1] then
			self:setSkillInfo(arg_15_1)
		else
			local var_15_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "skill_bottom")
			local var_15_6 = core_data[playermodel.cores[self.servantid].coreid].original_intensify_level + core_manager:getCoreCurRankTotalLv(var_15_0)
			local var_15_7 = cc.Label:createWithTTF(L_CORE_ADVANCE_DES .. var_15_6 .. "→" .. tostring(core_manager:getCoreCurRankTotalLv(var_15_0 + 1) + var_15_6), FONT_DES, 32)

			var_15_7:setAnchorPoint(cc.p(0.5, 0.5))
			var_15_7:setPosition(var_15_5:getContentSize().width / 2, var_15_5:getContentSize().height / 2 - 10)
			var_15_7:setColor(cc.c3b(245, 245, 247))
			var_15_5:addChild(var_15_7)
			var_15_7:setVisible(false)

			if self.uitype == 2 then
				self.sureBtn:getChildByName("Label_btnText"):setString(L_CORE_ADVANCE_NAME)
			end
		end
	end
end

function PopServantBreakout:setGirl()
	local var_16_0 = self:getOffset(servant_data[self.servantid].modelid, 0.8)

	self.image_Role:loadTexture(var_0_12 .. model_data[servant_data[self.servantid].modelid].role_image .. ".png")
	self.image_Role:setScale((self:getSkinScale(servant_data[self.servantid].modelid)))
	self.image_Role:setPosition(cc.p(var_16_0.x, var_16_0.y))
end

function PopServantBreakout:setMaxGirl()
	local var_17_0 = self:getOffset(servant_data[self.servantid].modelid, 1)

	self.image_Role:loadTexture(var_0_12 .. model_data[servant_data[self.servantid].modelid].role_image .. ".png")
	self.image_Role:setPosition(cc.p(var_17_0.x, var_17_0.y - 50))
end

function PopServantBreakout:setAttr(arg_18_1)
	if arg_18_1.labels and arg_18_1.labels[1] then
		local var_18_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "need_lv")

		var_18_0:setString(arg_18_1.labels[1].name .. arg_18_1.labels[1].newvalue)
		var_18_0:setVisible(false)
	end

	if arg_18_1.labels and arg_18_1.labels[3] then
		local var_18_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "attack")

		var_18_1:setString(arg_18_1.labels[3].name .. arg_18_1.labels[3].newvalue)

		if arg_18_1.labels[3].newvalue == "+0" then
			var_18_1:setVisible(false)
		end
	end

	if arg_18_1.labels and arg_18_1.labels[4] then
		local var_18_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "blood")

		var_18_2:setString(arg_18_1.labels[4].name .. arg_18_1.labels[4].newvalue)

		if arg_18_1.labels[4].newvalue == "+0" then
			var_18_2:setVisible(false)
		end
	end
end

function PopServantBreakout:setMaterial(arg_19_1)
	ccui.Helper:seekWidgetByName(self.rootpanel, "ListView_38"):removeAllChildren()

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_1.materials) do
		table.insert(var_19_0, {
			itemid = iter_19_1.id,
			needNum = iter_19_1.neednum,
			ownNum = iter_19_1.ownnum
		})
	end

	ccui.Helper:seekWidgetByName(self.rootpanel, "ListView_38"):removeAllChildren()

	local var_19_1 = false

	for iter_19_2, iter_19_3 in pairs(var_19_0) do
		if iter_19_3.needNum > iter_19_3.ownNum then
			var_19_1 = true
		end

		local var_19_3 = ccui.Helper:seekWidgetByName(self.rootpanel, "Panel_costItem")
		local var_19_4 = var_19_3:clone()
		local var_19_5 = ItemSmallSprite:createSmallItem(iter_19_3.itemid, iter_19_3.ownNum, iter_19_3.needNum, self.goto_back_system_id)

		var_19_5.setScale(var_19_3, 0.7)
		var_19_5:setInfoTouchEvent(true)
		var_19_5:setPosition(cc.p(var_19_4:getContentSize().width / 2 + 30, var_19_4:getContentSize().height / 2))
		var_19_4:addChild(var_19_5)
		var_19_4:setName("Panel_costItem" .. iter_19_2)
		ccui.Helper:seekWidgetByName(self.rootpanel, "ListView_38"):setItemsMargin(50)
		ccui.Helper:seekWidgetByName(self.rootpanel, "ListView_38"):pushBackCustomItem(var_19_4)
	end

	if var_19_1 then
		self.sureBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)

		self.sureBtn.satisfied = false
	else
		self.sureBtn:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)

		self.sureBtn.satisfied = true
	end

	if core_manager:isCoreMax(self.servantid) then
		ccui.Helper:seekWidgetByName(self.rootpanel, "panel_cost"):setVisible(false)
		self.sureBtn:setVisible(false)
	else
		if playermodel.gold < arg_19_1.gold_cost then
			self.sureBtn.goldFlag = true

			self.sureBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)

			self.sureBtn.satisfied = false

			ccui.Helper:seekWidgetByName(self.rootpanel, "Label_cost"):setColor(cc.c3b(255, 88, 155))
		else
			self.sureBtn.goldFlag = false

			self.sureBtn:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)

			self.sureBtn.satisfied = true

			ccui.Helper:seekWidgetByName(self.rootpanel, "Label_cost"):setColor(cc.c3b(217, 255, 253))
		end

		ccui.Helper:seekWidgetByName(self.rootpanel, "Label_cost"):setString(global_trans_number(arg_19_1.gold_cost))
	end
end

function PopServantBreakout:setMaxBreak()
	self:setMaxGirl()
	ccui.Helper:seekWidgetByName(self.rootLayer, "material_bottom"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cost"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "attack"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "blood"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(false)
	self.skill_bottom:setPositionY(self.skill_bottom:getPositionY() - 250)
	self.skill_bottom:getChildByName("MaxLabel"):setVisible(true)
	self.skill_bottom:getChildByName("MaxLabel"):setString(L_CLICK_BLANK_EXIT)
	self.skill_bottom:getChildByName("MaxLabel"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 64), cc.FadeTo:create(0.8, 192))))

	local var_20_0 = ccui.Text:create(L_SOULS_ADVANCE_MAX, FONT_DES, 24)

	var_20_0:setColor(cc.c3b(255, 209, 2))
	var_20_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_0:setPosition(cc.p(350, 170))
	self.skill_bottom:addChild(var_20_0, 5)
end

function PopServantBreakout:setSkillInfo(arg_21_1)
	local var_21_0 = core_manager:getServantCoreRank(self.servantid) + 1

	if not model_data[servant_data[self.servantid].modelid]["ex_" .. var_21_0] then
		var_21_0 = var_21_0 - 1
	end

	local var_21_1 = model_data[servant_data[self.servantid].modelid]["ex_" .. var_21_0]

	;(function()
		local var_22_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "skill_bottom")
		local var_22_3 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_0)

		var_22_3:setPosition(cc.p(88, 83))
		var_22_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_2:addChild(var_22_3)

		local var_22_4 = ccui.ImageView:create("skill_new/skill/ex" .. var_21_0 .. ".png", var_0_0)

		var_22_4:setScale(0.88)
		var_22_4:setPosition(cc.p(88, 83))
		var_22_2:addChild(var_22_4)

		if var_21_0 == 1 then
			local var_22_5 = ccui.Layout:create()

			var_22_5:setContentSize(var_22_3:getContentSize())
			var_22_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_22_5:setBackGroundColor(cc.c3b(0, 0, 0))
			var_22_5:setBackGroundColorOpacity(200)
			var_22_5:setPosition(cc.p(88, 83))
			var_22_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_22_2:addChild(var_22_5)

			local var_22_6 = ccui.ImageView:create("public/currency/lock.png", var_0_0)

			var_22_6:setPosition(cc.p(88, 83))
			var_22_6:setAnchorPoint(cc.p(0.5, 0.5))
			var_22_2:addChild(var_22_6)
		end

		local var_22_7 = cc.Label:createWithTTF(var_0_9[var_21_1].name, FONT_DES, 24)

		var_22_7:setAnchorPoint(cc.p(0, 0.5))
		var_22_7:setPosition(cc.p(151, 116))
		var_22_2:addChild(var_22_7)

		local var_22_8 = RichTextPro:create()

		var_22_8:setMaxWidth(420)
		var_22_8:setSize(20)
		var_22_8:setColor(cc.c3b(220, 251, 241))
		var_22_8:setLineSpace(0)
		var_22_8:setText((transSkillDesToRichText(var_0_9[var_21_1].description)))
		var_22_8:setName("richText")
		var_22_8:setPosition(cc.p(150, 106))
		var_22_2:addChild(var_22_8)
	end)()
end

function PopServantBreakout:showSkillInfo()
	local var_23_0 = global_get_servant_skin(self.servantid)
	local var_23_1 = core_manager:getServantCoreRank(self.servantid) + 1

	if not model_data[var_23_0]["ex_" .. var_23_1] then
		var_23_1 = var_23_1 - 1
	end

	local var_23_2 = model_data[var_23_0]["ex_" .. var_23_1]
	local var_23_3 = ccui.Layout:create()

	var_23_3:setTouchEnabled(true)
	var_23_3:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_23_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_3:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_23_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_23_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_23_3:setBackGroundColorOpacity(120)
	var_23_3:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_23_3:runAction(cc.RemoveSelf:create())
	end)
	;(function()
		local var_25_0 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_0)

		var_25_0:setPosition(cc.p(320, 672))
		var_25_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_23_3:addChild(var_25_0)

		local var_25_1 = ccui.Layout:create()

		var_25_1:setContentSize(cc.size(500, 124))
		var_25_1:setAnchorPoint(cc.p(0, 0))
		var_25_1:setPosition(cc.p(70, 600))
		var_25_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_25_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_25_1:setBackGroundColorOpacity(0)
		var_23_3:addChild(var_25_1, 2)

		local var_25_2 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_0)

		var_25_2:setPosition(cc.p(58, 63))
		var_25_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_1:addChild(var_25_2)

		local var_25_3 = ccui.ImageView:create("skill_new/skill/ex" .. var_23_1 .. ".png", var_0_0)

		var_25_3:setScale(0.88)
		var_25_3:setPosition(cc.p(58, 63))
		var_25_1:addChild(var_25_3)

		local var_25_4 = cc.Label:createWithTTF(var_0_9[var_23_2].name, FONT_DES, 24)

		var_25_4:setAnchorPoint(cc.p(0, 0.5))
		var_25_4:setPosition(cc.p(121, 96))
		var_25_1:addChild(var_25_4)

		if var_0_9[var_23_2].cd then
			local var_25_5 = cc.Label:createWithTTF(L_SIKILL_CD .. var_0_9[var_23_2].cd .. "s", FONT_DES, 20)

			var_25_5:setAnchorPoint(cc.p(1, 0.5))
			var_25_5:setPosition(cc.p(473, 96))
			var_25_1:addChild(var_25_5)
		end

		local var_25_6 = transSkillDesToRichText(var_0_9[var_23_2].description)
		local var_25_7 = RichTextPro:create()

		var_25_7:setMaxWidth(380)
		var_25_7:setSize(20)
		var_25_7:setColor(cc.c3b(220, 251, 241))
		var_25_7:setLineSpace(0)
		var_25_7:setText(var_25_6)
		var_25_7:setName("richText")
		var_25_7:setPosition(cc.p(120, 86))
		var_25_1:addChild(var_25_7)
	end)()
	self.rootLayer:addChild(var_23_3)
end

function PopServantBreakout.ActionofAccess(arg_26_0, arg_26_1)
	arg_26_1:setOpacity(0)
	arg_26_1:setScale(1)
	arg_26_1:runAction((cc.Sequence:create(cc.FadeIn:create(0.5))))
end

function PopServantBreakout:exit()
	self.activity = false

	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopServantBreakout:handleCompoundOneKey()
	for iter_29_0, iter_29_1 in pairs(self.msg.materials or {}) do
		iter_29_1.ownnum = item_manager:getItemNumber(iter_29_1.id)
	end

	self:setMaterial(self.msg)
end
