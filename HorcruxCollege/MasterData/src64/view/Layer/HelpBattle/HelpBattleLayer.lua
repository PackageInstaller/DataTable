local HelpBattleLayer = class("HelpBattleLayer", (require("view.Layer.BaseUILayer")))
local l2utils = require("controller.l2utils")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "HelpBattleLayer/"
local var_0_5 = require("controller.l2utils")

require("view/Sprite/GirlSprite")

function HelpBattleLayer:ctor()
	HelpBattleLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/help_battle/help_battle_manager"):getInstance()
end

function HelpBattleLayer:create(arg_2_1)
	local var_2_0 = HelpBattleLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function HelpBattleLayer:onEnter()
	HelpBattleLayer.super.onEnter(self)
	self.manager:requestInfo()
end

function HelpBattleLayer:onExit()
	HelpBattleLayer.super.onExit(self)
end

function HelpBattleLayer:init(arg_5_1)
	self.manager:updateGoNum()
	self.manager:setParam(arg_5_1)
	self:initLayer()

	return true
end

function HelpBattleLayer:initLayer()
	self:setContentSize(cc.size(GameDisplay.width, 640))

	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	var_0_5:captureScreenGaussBlur(function(arg_7_0)
		var_6_0:addChild(arg_7_0)

		local var_7_0 = TempWidget:CreateTempImg("mainScenebg/base_formation_layer_bg.png", var_6_0, 0)

		var_7_0:setContentSize(cc.size(var_6_0:size().w, 640))
		var_7_0:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

		function var_7_0.afterLoadSuccess(arg_8_0)
			var_7_0:setContentSize(cc.size(var_6_0:size().w, 640))
			var_7_0:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)
		end

		var_7_0:_addEvent(function()
			return
		end)

		local var_7_1 = TempWidget:CreateTempImg(var_0_4 .. "tips.png", var_7_0)

		var_7_1:align(cc.p(0.5, 0.5), var_7_0:size().w / 2, var_7_0:size().h / 2 + 240)

		local var_7_2 = TempWidget:CreateTempImg(var_0_4 .. "career1.png", var_7_0)

		var_7_2:align(cc.p(0.5, 0.5), var_7_0:size().w / 2, var_7_1:pos().y + 20)

		self._careerIcon = var_7_2

		local var_7_3 = TempWidget:CreateTempLabel(L_HELP_BATTLE[self.manager:getSelectCareer()] .. L_HELP_BATTLE[100], FONT_NAME, 40, var_7_0)

		var_7_3:align(cc.p(0.5, 0.5), var_7_0:size().w / 2, var_7_1:pos().y)
		var_7_3:_setColor("feee79")

		self._arrayNameText = var_7_3

		local var_7_4 = TempWidget:CreateTempListView(var_7_0)

		var_7_4:setDirection(ccui.ListViewDirection.horizontal)
		var_7_4:setContentSize(cc.size(var_7_0:size().w - 20, 220))
		var_7_4:align(cc.p(0.5, 1), var_7_0:size().w / 2, var_7_1:pos().y - var_7_1:size().h / 2 - 20)

		self._list = var_7_4

		self:initList()

		local var_7_5 = TempWidget:CreateTempImg(var_0_4 .. "panel.png", var_7_0)

		var_7_5:align(cc.p(0.5, 1), var_7_4:pos().x, var_7_4:pos().y - var_7_4:size().h - 20)

		self._panel = var_7_5

		self:initPanel()

		local var_7_6 = TempWidget:CreateTempListView(var_7_0)

		var_7_6:align(cc.p(0.5, 1), var_7_0:size().w / 2, var_7_5:pos().y - var_7_5:size().h - 10)
		var_7_6:setDirection(ccui.ListViewDirection.horizontal)
		var_7_6:setContentSize(var_7_4:size().w, 42)

		self._careerList = var_7_6

		self:initCareerList()

		local var_7_7 = TempWidget:CreateTempBtn("public/button/public_button_normal_y.png", var_7_0)

		var_7_7:align(cc.p(0.5, 0), var_7_0:size().w / 2, 5)

		self._goBtn = var_7_7

		local var_7_8 = TempWidget:CreateTempLabel(L_HELP_BATTLE[120], FONT_NAME, 30, var_7_7:getVirtualRenderer())

		var_7_8:center()
		var_7_8:_setColor("0f0f0f")
		self:initListener()
	end)
end

function HelpBattleLayer:initListener()
	self._goBtn:_addEvent(function()
		LayerManager:pushInLayer("HelpBattleFormationLayer", {
			selectCareer = self.manager:getSelectCareer()
		})
	end)
	self._root:_addEvent(function()
		LayerManager:removePopLayer()
	end)
end

function HelpBattleLayer:initList()
	self._list:setItemsMargin(5)

	local var_13_0 = cc.size(self._list:size().w / 5, self._list:size().h)

	for iter_13_0 = 1, self.manager.ADD_NUM do
		local var_13_1 = TempWidget:CreateTempLayout()

		var_13_1:setContentSize(var_13_0)
		var_13_1:_addEvent(function()
			local var_14_0, var_14_1 = self.manager:isLock(iter_13_0)

			if not var_14_0 then
				global_ShowBlockWords(var_14_1.tips)

				return
			end

			LayerManager:pushInLayer("HelpBattleFormationLayer", {
				selectCareer = self.manager:getSelectCareer()
			})
		end)

		local var_13_2 = TempWidget:CreateTempImg(var_0_4 .. "role_null_bg.png", var_13_1)

		var_13_2:setScale9Enabled(true)
		var_13_2:setCapInsets(cc.rect(0, 0, var_13_2:size().w, var_13_2:size().h))
		var_13_2:setContentSize(cc.size(var_13_1:size().w - 5, var_13_2:size().h))
		var_13_2:center()

		local var_13_3 = GirlSprite:create({
			initType = "helpBattleStyle"
		})

		var_13_3:setScale(0.92)
		var_13_1:addChild(var_13_3)
		var_13_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_13_3:setPosition(cc.p(var_13_1:size().w / 2 + 2, var_13_1:size().h / 2))

		local var_13_4 = TempWidget:CreateTempLayout(var_13_1)

		var_13_4:setContentSize(var_13_2:size())
		var_13_4:_setBack()
		var_13_4:setBackGroundColor(cc.c3b(0, 0, 0))
		var_13_4:setBackGroundColorOpacity(100)
		var_13_4:align(cc.p(0.5, 0.5), var_13_1:size().w / 2, var_13_1:size().h / 2)
		TempWidget:CreateTempImg(var_0_4 .. "lock_img.png", var_13_4):align(cc.p(0.5, 1), var_13_4:size().w / 2, var_13_4:size().h / 2 + 50)

		local var_13_5 = TempWidget:CreateTempLabel("", FONT_NAME, 25, var_13_4)

		var_13_5:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_13_5:center()

		function var_13_1._update()
			local var_15_0 = self.manager:getServants(self.manager:getSelectCareer())

			if var_15_0[iter_13_0] then
				var_13_3:update(var_15_0[iter_13_0])
				var_13_3:setVisible(true)
			else
				var_13_3:setVisible(false)
			end

			local var_15_1, var_15_2 = self.manager:isLock(iter_13_0)

			var_13_4:setVisible(not var_15_1)

			if not var_15_1 then
				var_13_5:setString(var_15_2.text)
			end
		end

		var_13_1._update()
		self._list:pushBackCustomItem(var_13_1)
	end
end

function HelpBattleLayer:initPanel()
	local var_16_0 = TempWidget:CreateTempLabel(L_HELP_BATTLE[101], FONT_NAME, 20, self._panel)

	var_16_0:align(cc.p(1, 0.5), 115, self._panel:size().h - 58)

	local var_16_1 = TempWidget:CreateTempLabel(L_HELP_BATTLE[102], FONT_NAME, 20, self._panel)

	var_16_1:align(cc.p(1, 0.5), 115, var_16_0:pos().y - 35)

	local var_16_2 = TempWidget:CreateTempLabel("atk", FONT_NAME, 20, self._panel)

	var_16_2:_setColor("feee79")
	var_16_2:align(cc.p(0.5, 0.5), self._panel:size().w / 2, var_16_0:pos().y)

	self._atkText = var_16_2

	local var_16_3 = TempWidget:CreateTempLabel("hp", FONT_NAME, 20, self._panel)

	var_16_3:_setColor("feee79")
	var_16_3:align(cc.p(0.5, 0.5), self._panel:size().w / 2, var_16_1:pos().y)

	self._hpText = var_16_3

	self:updatePanel()
end

function HelpBattleLayer:initCareerList()
	local var_17_0 = self._careerList
	local var_17_1 = self.manager:getCareerInfo()
	local var_17_2 = self.manager:getSelectCareer()
	local var_17_3 = cc.size(145, self._careerList:size().h)

	self._careerBtns = {}
	self._careerTexts = {}

	local var_17_4 = 1

	for iter_17_0 = 1, #var_17_1 do
		local var_17_5 = var_17_1[iter_17_0].name
		local var_17_6 = var_17_1[iter_17_0].career
		local var_17_7 = TempWidget:CreateTempLayout()

		var_17_7:setContentSize(var_17_3)

		local var_17_8 = TempWidget:CreateTempBtn((var_17_6 == var_17_2 or nil) and (var_0_4 .. "select_on.png" or var_0_4 .. "select_off.png"), var_17_7)

		var_17_8:center()
		var_17_8:_addEvent(function()
			local var_18_0 = self.manager:getSelectCareer()

			if var_18_0 ~= var_17_6 then
				self.manager:setSelectCareer(var_17_6)
				self._careerBtns[var_18_0]:loadTextureNormal(var_0_4 .. "select_off.png", var_0_3)
				self._careerBtns[var_17_6]:loadTextureNormal(var_0_4 .. "select_on.png", var_0_3)
				self._careerTexts[var_18_0]:_setColor("f0f0f0")
				self._careerTexts[var_17_6]:_setColor("0f0f0f")
				self:selectCareerChanged()
			end
		end)

		self._careerBtns[var_17_6] = var_17_8

		local var_17_9 = TempWidget:CreateTempLabel(var_17_5, FONT_NAME, 25, var_17_8:getVirtualRenderer())

		var_17_9:_setColor(var_17_6 == var_17_2 and "0f0f0f" or "f0f0f0")
		var_17_9:center()

		self._careerTexts[var_17_6] = var_17_9

		self._careerList:pushBackCustomItem(var_17_7)

		if var_17_6 == var_17_2 then
			var_17_4 = iter_17_0
		end
	end

	performWithDelay(self._careerList, function()
		var_17_0:jumpToIndex(var_17_4)
	end, 0.016666666666666666)
end

function HelpBattleLayer:updateLayer()
	self:updateList()
	self:updateArrayNameText()
	self:updatePanel()
end

function HelpBattleLayer:updateRed()
	return
end

function HelpBattleLayer:updateArrayNameText()
	local var_22_0 = self.manager:getSelectCareer()

	self._arrayNameText:setString(L_HELP_BATTLE[var_22_0] .. L_HELP_BATTLE[100])
	self._careerIcon:loadTexture(var_0_4 .. "career" .. var_22_0 .. ".png", var_0_3)
end

function HelpBattleLayer:updateList()
	local var_23_0 = self._list:getChildren()

	for iter_23_0 = 1, #var_23_0 do
		var_23_0[iter_23_0]._update()
	end
end

function HelpBattleLayer:selectCareerChanged()
	self:updateList()
	self:updateArrayNameText()
	self:updatePanel()
end

function HelpBattleLayer:updatePanel()
	local var_25_0 = self.manager:getBonus(self.manager:getSelectCareer())

	self._atkText:setString(var_25_0.value.damage)
	self._hpText:setString(var_25_0.value.hp)
end

function HelpBattleLayer:updateGirlList()
	local var_26_0 = self._list:getChildren()

	for iter_26_0 = 1, #var_26_0 do
		var_26_0[iter_26_0]._update()
	end

	self:updatePanel()
end

return HelpBattleLayer
