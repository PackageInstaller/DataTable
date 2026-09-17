local HelpBattleFormationLayer = class("HelpBattleFormationLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = string.format
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "HelpBattleFormationLayer/"

require("view/Sprite/GirlSprite")

local TableViewEx = require("view/Sprite/TableViewEx")
local var_0_6 = require("controller/help_battle/help_battle_manager"):getInstance()
local var_0_7 = {
	[4] = {
		GIRL_LAYOUT_SIZE = cc.size(GameDisplay.getUiScreenSize().width / 4, 240)
	},
	[5] = {
		GIRL_LAYOUT_SIZE = cc.size(GameDisplay.getUiScreenSize().width / 5, 190)
	},
	[6] = {
		GIRL_LAYOUT_SIZE = cc.size(GameDisplay.getUiScreenSize().width / 6, 155)
	}
}
local var_0_8 = 130
local var_0_9 = 276
local var_0_10 = {
	"damage",
	"hp"
}
local var_0_11 = 60
local var_0_12 = 60 / 2
local var_0_13 = {
	DOWN = 2,
	UP = 1
}

function HelpBattleFormationLayer:ctor()
	HelpBattleFormationLayer.super.ctor(self)
	self:setAutoAdapt(true)

	local var_1_0 = require("controller/help_battle/help_battle_formation_manager"):getInstance()

	var_1_0:initShowInfo()

	self.manager = var_1_0
	self._showAttr = false
end

function HelpBattleFormationLayer:create(arg_2_1)
	local var_2_0 = HelpBattleFormationLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function HelpBattleFormationLayer:onEnter()
	HelpBattleFormationLayer.super.onEnter(self)
end

function HelpBattleFormationLayer:onExit()
	HelpBattleFormationLayer.super.onExit(self)
end

function HelpBattleFormationLayer:init(arg_5_1)
	arg_5_1 = arg_5_1 or {}

	if arg_5_1.selectCareer then
		self.manager:setSelectCareer(arg_5_1.selectCareer)

		self._selectCareer = arg_5_1.selectCareer
	else
		self._selectCareer = self.manager:getSelectCareer()
	end

	self:initLayer()
	self:initListener()

	return true
end

function HelpBattleFormationLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg("mainScenebg/help_battle_formation_bg.png", var_6_0, 0)

	var_6_1:setLocalZOrder(-999)
	var_6_1:center()

	local var_6_2 = TempWidget:CreateTempImg(var_0_4 .. "top.png", var_6_0)

	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h)

	self._top = var_6_2

	local var_6_3 = TempWidget:CreateTempBtn(var_0_4 .. "btn_attr.png", var_6_2)

	var_6_3:align(cc.p(1, 0.5), var_6_2:size().w - 5, var_6_2:size().h / 2)

	self._attrBtn = var_6_3

	self:initCareerList()
	self:initGirlList()
	self:initExtraBonusLayout()
	self:initBottom()
	self:iniTableView()
end

function HelpBattleFormationLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._attrBtn:_addEvent(function()
		self._showAttr = not self._showAttr

		self:showAttrChanged()
	end)
	self._returnBtn:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._showTypeBtn:_addEvent(function()
		self.manager:switchShowType()
		self:updateShowTypeBtn()
		self:updateTabelView()
	end)
	self._showValueBtn:_addEvent(function()
		self:showOtherValue()
	end)
end

function HelpBattleFormationLayer:initCareerList()
	local var_13_0 = TempWidget:CreateTempListView(self._root)

	var_13_0:setContentSize(cc.size(self._root:size().w, 50))
	var_13_0:setDirection(ccui.ListViewDirection.horizontal)
	var_13_0:align(cc.p(0.5, 1), self._root:size().w / 2, self._top:pos().y - self._top:size().h - 5)

	self._careerList = var_13_0

	local var_13_1 = var_0_6:getCareerInfo()
	local var_13_2 = cc.size(118, var_13_0:size().h)

	self._selectBtns = {}
	self._selectTexts = {}

	for iter_13_0 = 1, #var_13_1 do
		local var_13_3 = TempWidget:CreateTempLayout()

		var_13_3:setContentSize(var_13_2)

		local var_13_5 = var_13_1[iter_13_0].career
		local var_13_6 = TempWidget:CreateTempBtn((var_13_1[iter_13_0].career ~= self._selectCareer or nil) and var_0_4 .. "select_off.png", var_13_3)

		var_13_6:center()
		var_13_6:_addEvent(function()
			if self._selectCareer ~= iter_13_0 then
				local var_14_0 = var_0_6:getCareerInfo()

				self._selectBtns[var_13_5]:loadTextureNormal(var_0_4 .. "select_on.png", var_0_3)
				self._selectBtns[self._selectCareer]:loadTextureNormal(var_0_4 .. "select_off.png", var_0_3)
				self._selectTexts[var_13_5]:_setColor("ffffff")
				self._selectTexts[self._selectCareer]:_setColor("9897b7")
				self.manager:setSelectCareer(var_13_5)

				self._selectCareer = var_13_5

				self:selectCareerChanged()
			end
		end)

		self._selectBtns[var_13_1[iter_13_0].career] = var_13_6

		local var_13_7 = "ffffff"

		if var_13_1[iter_13_0].career ~= self._selectCareer then
			var_13_7 = "9897b7"
		end

		local var_13_8 = TempWidget:CreateTempLabel(var_13_1[iter_13_0].name, FONT_NAME, 25, var_13_6:getVirtualRenderer())

		var_13_8:_setColor(var_13_7)
		var_13_8:center()

		self._selectTexts[var_13_1[iter_13_0].career] = var_13_8

		var_13_0:pushBackCustomItem(var_13_3)
	end
end

function HelpBattleFormationLayer:initGirlList()
	local var_15_0 = TempWidget:CreateTempListView(self._root)

	var_15_0:setLocalZOrder(10)
	var_15_0:setDirection(ccui.ListViewDirection.horizontal)
	var_15_0:setContentSize(cc.size(self._root:size().w - 10, var_0_9 + var_0_12 * (#var_0_10 - 2)))
	var_15_0:align(cc.p(0.5, 1), self._root:size().w / 2, self._careerList:pos().y - self._careerList:size().h - 10)

	self._girlList = var_15_0

	local var_15_1 = cc.size(var_15_0:size().w / 5, var_15_0:size().h)

	for iter_15_0 = 1, var_0_6.ADD_NUM do
		local var_15_2 = TempWidget:CreateTempLayout()

		var_15_2:setContentSize(var_15_1)

		local var_15_3 = TempWidget:CreateTempLayout(var_15_2)

		var_15_3:setContentSize(cc.size(var_15_2:size().w, 205))
		var_15_3:align(cc.p(0.5, 1), var_15_2:size().w / 2, var_15_2:size().h - 5)

		local var_15_4 = TempWidget:CreateTempImg(var_0_4 .. "role_bg.png", var_15_3)

		var_15_4:center()

		local var_15_5 = TempWidget:CreateTempImg(var_0_4 .. "add_img.png", var_15_4)

		var_15_5:setScale(2)
		var_15_5:center()

		local var_15_6 = TempWidget:CreateTempLayout(var_15_4)

		var_15_6:setContentSize(var_15_4:size())
		TempWidget:CreateTempImg(var_0_4 .. "lock_img.png", var_15_6):align(cc.p(0.5, 1), var_15_6:size().w / 2, var_15_6:size().h / 2 + 50)

		local var_15_7 = TempWidget:CreateTempLabel("", FONT_NAME, 25, var_15_6)

		var_15_7:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_15_7:center()

		local var_15_8 = GirlSprite:create({
			initType = "helpBattleStyle"
		})

		var_15_8:setScale(0.92)
		var_15_3:addChild(var_15_8)
		var_15_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_8:setPosition(cc.p(var_15_3:size().w / 2 + 2, var_15_3:size().h / 2))

		local var_15_9 = TempWidget:CreateTempLayout(var_15_2)

		var_15_9:setClippingEnabled(true)
		var_15_9:setContentSize(cc.size(var_15_4:size().w, var_0_11))
		var_15_9:align(cc.p(0.5, 1), var_15_2:size().w / 2, var_15_3:pos().y - var_15_3:size().h - 5)
		var_15_9:setBackGroundImageScale9Enabled(true)
		var_15_9:setBackGroundImageCapInsets(cc.rect(0, 0, var_15_9:size().w, var_15_9:size().h))
		var_15_9:setBackGroundImage(var_0_4 .. "bonus_rect.png", var_0_3)

		local var_15_10 = TempWidget:CreateTempListView(var_15_9)

		var_15_10:setContentSize(cc.size(var_15_9:size().w, #var_0_10 * var_0_12))
		var_15_10:align(cc.p(0.5, 1), var_15_9:size().w / 2, var_15_9:size().h)

		var_15_10._valueTextMap = {}
		var_15_2._upAction, var_15_2._downAction = function()
			var_15_9:stopAllActions()
			schedule(var_15_9, function()
				local var_19_0 = var_15_9:size().h

				if var_19_0 <= var_0_11 then
					var_15_9:stopAllActions()
				else
					var_15_9:setContentSize(cc.size(var_15_9:size().w, var_19_0 - 8))
					var_15_10:align(cc.p(0.5, 1), var_15_9:size().w / 2, var_15_9:size().h)
				end
			end, 0.016666666666666666)
		end, function()
			var_15_9:stopAllActions()
			schedule(var_15_9, function()
				local var_17_0 = var_15_9:size().h

				if var_17_0 >= var_15_10:size().h then
					var_15_9:stopAllActions()
				else
					var_15_9:setContentSize(cc.size(var_15_9:size().w, var_17_0 + 8))
					var_15_10:align(cc.p(0.5, 1), var_15_9:size().w / 2, var_15_9:size().h)
				end
			end, 0.016666666666666666)
		end

		for iter_15_1 = 1, #var_0_10 do
			local var_15_11 = TempWidget:CreateTempLayout()

			var_15_11:setContentSize(cc.size(var_15_10:size().w, var_0_12))
			TempWidget:CreateTempImg(var_0_4 .. "one_value_rect.png", var_15_11):align(cc.p(1, 0.5), var_15_11:size().w - 5, var_15_11:size().h / 2)
			TempWidget:CreateTempImg(var_0_4 .. var_0_10[iter_15_1] .. ".png", var_15_11):align(cc.p(0, 0.5), 10, var_15_11:size().h / 2)

			local var_15_12 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_15_11)

			var_15_12:align(cc.p(0, 0.5), 40, var_15_11:size().h / 2)

			var_15_10._valueTextMap[var_0_10[iter_15_1]] = var_15_12

			var_15_10:pushBackCustomItem(var_15_11)
		end

		function var_15_2._updateGirl()
			local var_20_0 = var_0_6:getServants(self._selectCareer)[iter_15_0]

			if var_20_0 then
				var_15_8:update(var_20_0)
			end

			var_15_8:setVisible(var_20_0 and true or false)
		end

		function var_15_2._update()
			var_15_2._updateGirl()

			local var_21_0 = var_0_6:getServants(self._selectCareer)[iter_15_0]

			if var_21_0 then
				for iter_21_0, iter_21_1 in pairs(var_0_6:getBonus(self._selectCareer).girlInfo[var_21_0].value) do
					if var_15_10._valueTextMap[iter_21_0] then
						var_15_10._valueTextMap[iter_21_0]:setString(iter_21_1)
					end
				end
			else
				for iter_21_2, iter_21_3 in pairs(var_15_10._valueTextMap) do
					iter_21_3:setString(0)
				end
			end

			local var_21_1, var_21_2 = var_0_6:isLock(iter_15_0)

			if not var_21_0 then
				var_15_4:show()

				if not var_21_1 then
					var_15_6:show()
					var_15_7:setString(var_21_2.text)
					var_15_5:hide()
				else
					var_15_6:hide()
					var_15_5:show()
				end
			else
				var_15_4:hide()
			end
		end

		var_15_2._update()

		local var_15_13 = 0

		var_15_3:setTouchEnabled(true)
		var_15_3:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 == ccui.TouchEventType.began then
				var_15_8:imgScaleTo(1.1, 0.1)
				arg_22_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_15_8:startPressBar(function()
						local var_24_0 = var_0_6:getServants(self._selectCareer)[iter_15_0]

						if var_24_0 then
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = 6,
								cursoul = var_24_0,
								exitCallback = function()
									require("controller/help_battle/help_battle_formation_manager"):getInstance():updateGirlList()
								end
							})

							var_15_13 = 0.2
						else
							var_15_13 = 0
						end

						var_15_8:endPressBar()
					end, function(arg_26_0)
						var_15_13 = var_15_13 + arg_26_0
					end)
				end)))
			elseif arg_22_1 == ccui.TouchEventType.canceled then
				var_15_8:imgScaleTo(1, 0.1)
				arg_22_0:stopAllActions()
				var_15_8:endPressBar()
			elseif arg_22_1 == ccui.TouchEventType.ended then
				arg_22_0:stopAllActions()

				local var_22_0, var_22_1 = var_0_6:isLock(iter_15_0)

				if var_22_0 then
					if var_15_13 == 0 then
						local var_22_2 = var_0_6:getServants(self.manager:getSelectCareer())

						if var_22_2[iter_15_0] then
							self.manager:requestUpdateGirl(var_22_2[iter_15_0])
						end
					end
				else
					global_ShowBlockWords(var_22_1.tips)
				end

				var_15_13 = 0

				var_15_8:endPressBar()
				var_15_8:imgScaleTo(1, 0.1)
			end
		end)
		var_15_0:pushBackCustomItem(var_15_2)
	end
end

function HelpBattleFormationLayer:initExtraBonusLayout()
	local var_27_0 = self._girlList
	local var_27_1 = TempWidget:CreateTempLayout(self._root)

	var_27_1:setContentSize(cc.size(self._root:size().w, var_0_8))
	var_27_1:setLocalZOrder(self._girlList:getLocalZOrder())
	var_27_1:_addEvent(function()
		return
	end)
	var_27_1:align(cc.p(0.5, 1), self._root:size().w / 2, self._girlList:pos().y - self._girlList:size().h - 5 + var_0_12 * (#var_0_10 - 2))
	var_27_1:hide()

	self._extraBonusLayout = var_27_1
	var_27_1._upAction, var_27_1._downAction = function()
		var_27_1:stopAllActions()
		var_27_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_27_1:pos().x, var_27_1:pos().y + var_0_12 * (#var_0_10 - 2))), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self._showValueBtn._isMoving = false
		end)))
	end, function()
		var_27_1:stopAllActions()
		var_27_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_27_1:pos().x, var_27_0:pos().y - var_27_0:size().h - 5)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self._showValueBtn._isMoving = false
		end)))
	end

	local var_27_2 = TempWidget:CreateTempImg(var_0_4 .. "extra_bonus_bg.png", var_27_1)

	var_27_2:setScale9Enabled(true)
	var_27_2:setCapInsets(cc.rect(0, 0, var_27_2:getContentSize().width, var_27_2:getContentSize().height))
	var_27_2:setContentSize(cc.size(var_27_1:size().w - 100, var_27_2:size().h))
	var_27_2:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_1:size().h)

	local var_27_3 = TempWidget:CreateTempLabel(var_0_1(L_HELP_BATTLE_FORMATION[2], var_0_6:getCareerInfo()[self._selectCareer].name), FONT_NAME, 22, var_27_2)

	var_27_3:align(cc.p(0.5, 0.5), var_27_2:size().w / 2, var_27_2:size().h / 2 + 31)
	var_27_3:_setColor("a9a8b1")

	self._extraBonusLayout._text = var_27_3

	local var_27_4 = TempWidget:CreateTempLayout(var_27_1)

	var_27_4:setContentSize(cc.size(var_27_1:size().w / 2 - 70, 50))
	var_27_4:align(cc.p(0.5, 0.5), var_27_1:size().w / 2, var_27_1:size().h / 2 - 12)

	self._extraBonusLayout._bonusLayout1 = var_27_4

	local var_27_5 = TempWidget:CreateTempLabel("xxxx", FONT_NAME, 22, var_27_4)

	var_27_5:align(cc.p(0, 0.5), 0, var_27_4:size().h / 2)

	self._extraBonusLayout._name1 = var_27_5

	local var_27_6 = TempWidget:CreateTempImg(var_0_4 .. "num_bg.png", var_27_4)

	var_27_6:align(cc.p(1, 0.5), var_27_4:size().w - 5, var_27_4:size().h / 2)

	local var_27_7 = TempWidget:CreateTempLabel("999", FONT_NAME, 22, var_27_6)

	var_27_7:_setColor("ffd800")
	var_27_7:center()

	self._extraBonusLayout._valueText1 = var_27_7

	local var_27_8 = TempWidget:CreateTempLayout(var_27_1)

	var_27_8:setContentSize(var_27_4:size())
	var_27_8:align(cc.p(0.5, 0.5), var_27_1:size().w / 2, var_27_1:size().h / 2 - 12)

	self._extraBonusLayout._bonusLayout2 = var_27_8

	local var_27_9 = TempWidget:CreateTempLabel("xxxx", FONT_NAME, 22, var_27_8)

	var_27_9:align(cc.p(0, 0.5), var_27_5:pos().x, var_27_8:size().h / 2)

	self._extraBonusLayout._name2 = var_27_9

	local var_27_10 = TempWidget:CreateTempImg(var_0_4 .. "num_bg.png", var_27_8)

	var_27_10:align(cc.p(1, 0.5), var_27_8:size().w - 5, var_27_8:size().h / 2)

	local var_27_11 = TempWidget:CreateTempLabel("999", FONT_NAME, 20, var_27_10)

	var_27_11:center()
	var_27_11:_setColor("ffd800")

	self._extraBonusLayout._valueText2 = var_27_11

	self:updateExtraBonusLayout()

	local var_27_12 = TempWidget:CreateTempBtn(var_0_4 .. "show_value_btn.png", var_27_1)

	var_27_12:align(cc.p(0.5, 0), var_27_1:size().w / 2, 0)
	var_27_12:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, -5)), cc.MoveBy:create(0.5, cc.p(0, 5)))))

	var_27_12._dir = var_0_13.DOWN
	var_27_12._isMoving = false
	self._showValueBtn = var_27_12
end

function HelpBattleFormationLayer:initBottom()
	local var_33_0 = TempWidget:CreateTempImg(var_0_4 .. "buttom.png", self._root)

	var_33_0:_addEvent(function()
		return
	end)
	var_33_0:setLocalZOrder(self._girlList:getLocalZOrder())
	var_33_0:align(cc.p(0, 0), 0, 0)

	self._bottom = var_33_0

	local var_33_1 = TempWidget:CreateTempLayout(var_33_0)

	var_33_1:setContentSize(cc.size(80, var_33_0:size().h))
	var_33_1:align(cc.p(0, 0), 0, 0)

	self._returnBtn = var_33_1
end

function HelpBattleFormationLayer:getTableViewSize()
	return (cc.size(self._root:size().w, self._girlList:pos().y - self._girlList:size().h - self._bottom:size().h))
end

function HelpBattleFormationLayer:getTableViewMoveLaterSize()
	return (self:getTableViewSize())
end

function HelpBattleFormationLayer:iniTableView()
	local var_37_0 = self._bottom
	local var_37_1 = self:getTableViewSize()
	local var_37_2 = TableViewEx:create({
		size = var_37_1,
		cellSizeForTable = function()
			return var_37_1.width, var_0_7[self.manager:getShowNum()].GIRL_LAYOUT_SIZE.height
		end,
		tableCellAtIndex = function(self, arg_39_1)
			local var_39_0 = self:dequeueCell()

			if not var_39_0 then
				var_39_0 = cc.TableViewCell:new()

				local var_39_1 = self:createTableViewCell(arg_39_1 + 1)

				var_39_0:addChild(var_39_1)

				var_39_0._layout = var_39_1
			else
				self:updateTableViewCell(var_39_0._layout, arg_39_1 + 1)
			end

			return var_39_0
		end,
		numberOfCellsInTableView = function(arg_40_0)
			return math.ceil(#self.manager:getShowInfo() / self.manager:getShowNum())
		end
	})

	var_37_2:setLocalZOrder(self._bottom:getLocalZOrder() - 1)
	self._root:addChild(var_37_2)
	var_37_2:setPosition(cc.p(0, self._bottom:size().h))

	self._tableView = var_37_2
	var_37_2._upAction, var_37_2._downAction = function()
		var_37_2:stopAllActions()
		var_37_2:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			local var_44_0 = var_37_2:getContentOffset()

			var_37_2:setViewSize(cc.size(var_37_1.width, var_37_1.height))
			var_37_2:setContentOffset(cc.p(var_44_0.x, var_44_0.y + var_0_12 * (#var_0_10 - 2)))
			var_37_2:setPosition(cc.p(0, var_37_0:size().h - var_0_12 * (#var_0_10 - 2)))
		end), cc.DelayTime:create(0.016666666666666666), cc.MoveBy:create(0.5, cc.p(0, var_0_12 * (#var_0_10 - 2)))))
	end, function()
		var_37_2:stopAllActions()
		var_37_2:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, -var_0_12 * (#var_0_10 - 2))), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
			local var_42_0 = var_37_2:getContentOffset()

			var_37_2:setPosition(cc.p(0, var_37_0:size().h))
			var_37_2:setViewSize(cc.size(var_37_1.width, self:getTableViewMoveLaterSize().height))
			var_37_2:setContentOffset(cc.p(var_42_0.x, var_42_0.y - var_0_12 * (#var_0_10 - 2)))
		end)))
	end

	local var_37_3 = TempWidget:CreateTempImg(var_0_4 .. "switch_show_type_btn.png", self._root)

	var_37_3:align(cc.p(0, 0), 10, self._bottom:size().h + 10)
	var_37_3:setLocalZOrder(self._bottom:getLocalZOrder())

	local var_37_4 = TempWidget:CreateTempBtn(var_0_4 .. "show_type_1.png", var_37_3)

	var_37_4:center()

	self._showTypeBtn = var_37_4

	self:updateShowTypeBtn()
end

function HelpBattleFormationLayer:createTableViewCell(arg_45_1)
	local var_45_0 = TempWidget:CreateTempLayout()

	var_45_0:setContentSize(cc.size(self._root:size().w, var_0_7[self.manager:getShowNum()].GIRL_LAYOUT_SIZE.height))

	var_45_0._spCellTable = {}

	local var_45_1 = cc.size(var_45_0:size().w / self.manager:getMinShowNum(), var_45_0:size().h)

	for iter_45_0 = 1, self.manager:getMaxShowNum() do
		local var_45_2 = TempWidget:CreateTempLayout(var_45_0)

		var_45_2:setAnchorPoint(0, 0.5)
		var_45_2:setContentSize(var_45_1)

		var_45_0._spCellTable[iter_45_0] = var_45_2

		local var_45_3 = GirlSprite:create({
			initType = "helpBattleStyle"
		})

		var_45_3:setTouchEnabled(true)
		var_45_3:setSwallowTouches(false)
		var_45_2:addChild(var_45_3)
		var_45_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_45_3:setPosition(cc.p(var_45_2:size().w / 2 + 2, var_45_2:size().h / 2))

		var_45_2._girlSprite = var_45_3

		local var_45_4 = TempWidget:CreateTempImg(var_0_4 .. "mask_img.png", var_45_2)

		var_45_4:center()
		var_45_4:setScale(1.1)

		var_45_2._maskImg = var_45_4

		local var_45_5 = TempWidget:CreateTempLabel(L_HELP_BATTLE_FORMATION[8], FONT_NAME, 18, var_45_4)

		var_45_5:_setColor("ffd102")
		var_45_5:align(cc.p(0.5, 0.5), var_45_4:size().w / 2, var_45_4:size().h / 2 - 25)

		local var_45_6 = TempWidget:CreateTempImg(var_0_4 .. "mask_img.png", var_45_2)

		var_45_6:center()
		var_45_6:setScale(1.1)

		var_45_2._inFormationImg = var_45_6

		local var_45_7 = TempWidget:CreateTempLabel(L_HELP_BATTLE_FORMATION[10], FONT_NAME, 18, var_45_6)

		var_45_7:_setColor("ffd102")
		var_45_7:align(cc.p(0.5, 0.5), var_45_6:size().w / 2, var_45_6:size().h / 2 - 25)
	end

	self:updateTableViewCell(var_45_0, arg_45_1)

	return var_45_0
end

function HelpBattleFormationLayer:updateTableViewCell(arg_46_1, arg_46_2)
	local var_46_0 = self.manager:getShowInfo()
	local var_46_1 = {}

	for iter_46_0, iter_46_1 in pairs((var_0_6:getServants(self.manager:getSelectCareer()))) do
		var_46_1[iter_46_1] = 1
	end

	local var_46_2 = self.manager:getShowNum()

	arg_46_1:setContentSize(cc.size(self._root:size().w, var_0_7[var_46_2].GIRL_LAYOUT_SIZE.height))

	for iter_46_2 = 1, self.manager:getMaxShowNum() do
		if iter_46_2 <= var_46_2 then
			arg_46_1._spCellTable[iter_46_2]:show()
		else
			arg_46_1._spCellTable[iter_46_2]:hide()
		end
	end

	local var_46_3 = arg_46_1:size().w / var_46_2

	for iter_46_3 = 1, var_46_2 do
		local var_46_4 = arg_46_1._spCellTable[iter_46_3]

		arg_46_1._spCellTable[iter_46_3]:setScale(var_46_3 / arg_46_1._spCellTable[iter_46_3]:size().w)
		var_46_4:move((iter_46_3 - 1) * var_46_3, arg_46_1:size().h / 2)

		local var_46_5 = var_46_4._girlSprite
		local var_46_6 = (arg_46_2 - 1) * var_46_2 + iter_46_3

		var_46_4._girlSprite:setVisible(var_46_0[(arg_46_2 - 1) * var_46_2 + iter_46_3] ~= nil and true or false)

		if var_46_0[var_46_6] then
			var_46_5:update(var_46_0[var_46_6].soulid, self._showAttr)
		end

		local var_46_7 = var_46_4._maskImg

		var_46_4._maskImg:setVisible(var_46_0[var_46_6] == nil and true or false)

		if var_46_0[var_46_6] and var_46_1[var_46_0[var_46_6].soulid] then
			var_46_7:show()
		else
			var_46_7:hide()
		end

		var_46_4._inFormationImg:setVisible(var_0_6:isInFormation((var_46_0[var_46_6] or nil) and (var_46_0[var_46_6].soulid or nil)))

		local var_46_8 = 0

		var_46_5:setSwallowTouches(false)
		var_46_5:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 == ccui.TouchEventType.began then
				var_46_5:imgScaleTo(1.1, 0.1)
				arg_47_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_46_5:startPressBar(function()
						if var_46_0[(arg_46_2 - 1) * var_46_2 + iter_46_3] then
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = 6,
								cursoul = var_46_0[(arg_46_2 - 1) * var_46_2 + iter_46_3].soulid,
								exitCallback = function()
									require("controller/help_battle/help_battle_formation_manager"):getInstance():updateShowingCells()
								end
							})

							var_46_8 = 0.2
						else
							var_46_8 = 0
						end

						var_46_5:endPressBar()
					end, function(arg_51_0)
						var_46_8 = var_46_8 + arg_51_0
					end, 1.2)
				end)))
			elseif arg_47_1 == ccui.TouchEventType.canceled then
				var_46_5:imgScaleTo(1, 0.1)
				arg_47_0:stopAllActions()
				var_46_5:endPressBar()
			elseif arg_47_1 == ccui.TouchEventType.ended then
				arg_47_0:stopAllActions()

				var_46_8 = 0

				var_46_5:endPressBar()
				var_46_5:imgScaleTo(1, 0.1)

				if math.abs(arg_47_0:getTouchBeganPosition().x - arg_47_0:getTouchEndPosition().x) >= 25 then
					return
				end

				if math.abs(arg_47_0:getTouchBeganPosition().y - arg_47_0:getTouchEndPosition().y) >= 25 then
					return
				end

				if var_46_8 == 0 then
					if var_46_0[(arg_46_2 - 1) * var_46_2 + iter_46_3] then
						self.manager:requestUpdateGirl(var_46_0[(arg_46_2 - 1) * var_46_2 + iter_46_3].soulid)
					end
				end
			end
		end)
	end
end

function HelpBattleFormationLayer:selectCareerChanged()
	self:updateExtraBonusLayout()
	self:updateTabelView()
	self:updateGirlList()
end

function HelpBattleFormationLayer:updateLayer()
	return
end

function HelpBattleFormationLayer:updateRed()
	return
end

function HelpBattleFormationLayer:updateExtraBonusLayout()
	local var_55_0 = {
		[var_0_6.CAREER.WARRIOR] = {
			{
				name = L_HELP_BATTLE_FORMATION[3],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.WARRIOR).percent.damage * 100 .. "%"
				end
			},
			{
				name = L_HELP_BATTLE_FORMATION[4],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.WARRIOR).percent.hp * 100 .. "%"
				end
			}
		},
		[var_0_6.CAREER.TANK] = {
			{
				name = L_HELP_BATTLE_FORMATION[5],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.TANK).value.defence
				end
			},
			{
				name = L_HELP_BATTLE_FORMATION[6],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.TANK).value.energydefence
				end
			}
		},
		[var_0_6.CAREER.SUPPORT] = {
			{
				name = L_HELP_BATTLE_FORMATION[7],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.SUPPORT).percent.extra_heal_extern * 100 .. "%"
				end
			}
		},
		[var_0_6.CAREER.MASTER] = {
			{
				name = L_HELP_BATTLE_FORMATION[3],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.MASTER).percent.damage * 100 .. "%"
				end
			}
		},
		[var_0_6.CAREER.ASSASSIN] = {
			{
				name = L_HELP_BATTLE_FORMATION[3],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.ASSASSIN).percent.damage * 100 .. "%"
				end
			}
		},
		[var_0_6.CAREER.SHOOTER] = {
			{
				name = L_HELP_BATTLE_FORMATION[3],
				value = function()
					return var_0_6:getBonus(var_0_6.CAREER.SHOOTER).percent.damage * 100 .. "%"
				end
			}
		}
	}

	self._extraBonusLayout._text:setString(var_0_1(L_HELP_BATTLE_FORMATION[2], var_0_6:getCareerInfo()[self._selectCareer].name))

	if #var_55_0[self._selectCareer] > 1 then
		self._extraBonusLayout._bonusLayout1:show()
		self._extraBonusLayout._bonusLayout2:show()
		self._extraBonusLayout._bonusLayout1:move(self._extraBonusLayout:size().w / 2 - 130, self._extraBonusLayout:size().h / 2)
		self._extraBonusLayout._bonusLayout2:move(self._extraBonusLayout:size().w / 2 + 130, self._extraBonusLayout:size().h / 2)
		self._extraBonusLayout._name1:setString(var_55_0[self._selectCareer][1].name)
		self._extraBonusLayout._name2:setString(var_55_0[self._selectCareer][2].name)
		self._extraBonusLayout._valueText1:setString(var_55_0[self._selectCareer][1].value())
		self._extraBonusLayout._valueText2:setString(var_55_0[self._selectCareer][2].value())
	else
		self._extraBonusLayout._bonusLayout1:show()
		self._extraBonusLayout._bonusLayout2:hide()
		self._extraBonusLayout._bonusLayout1:move(self._extraBonusLayout:size().w / 2, self._extraBonusLayout:size().h / 2)
		self._extraBonusLayout._name1:setString(var_55_0[self._selectCareer][1].name)
		self._extraBonusLayout._valueText1:setString(var_55_0[self._selectCareer][1].value())
	end
end

function HelpBattleFormationLayer:updateShowTypeBtn()
	self._showTypeBtn:loadTextureNormal(var_0_4 .. "show_type_" .. self.manager:getShowType() .. ".png", var_0_3)
end

function HelpBattleFormationLayer:updateShowingCells()
	local var_65_0 = self.manager:getShowNum()
	local var_65_1 = {
		cellsize = cc.size(self._tableView._tableView:getContentSize().width, var_0_7[var_65_0].GIRL_LAYOUT_SIZE.height)
	}

	var_65_1.maxcount = math.ceil(#self.manager:getShowInfo() / var_65_0)

	local var_65_3, var_65_4 = GetTableViewShowCellIdx(self._tableView._tableView, var_65_1)

	for iter_65_0 = var_65_3, var_65_4 do
		self._tableView._tableView:updateCellAtIndex(iter_65_0)
	end
end

function HelpBattleFormationLayer:updateGirlList()
	local var_66_0 = self._girlList:getChildren()

	for iter_66_0 = 1, #var_66_0 do
		var_66_0[iter_66_0]._update()
	end
end

function HelpBattleFormationLayer:updateTabelView()
	self._tableView._tableView:reloadData()
end

function HelpBattleFormationLayer:updateGirlSuccess()
	self:updateGirlList()
	self:updateShowingCells()
	self:updateExtraBonusLayout()
end

function HelpBattleFormationLayer:showAttrChanged()
	self:updateShowingCells()
end

function HelpBattleFormationLayer:showOtherValue()
	local var_70_0 = self._extraBonusLayout
	local var_70_1 = self._girlList:getChildren()

	if not self._showValueBtn._isMoving then
		self._showValueBtn._isMoving = true

		local var_70_2 = ""

		if self._showValueBtn._dir == var_0_13.DOWN then
			var_70_2 = "_downAction"
			self._showValueBtn._dir = var_0_13.UP

			self._showValueBtn:setFlippedY(true)
		elseif self._showValueBtn._dir == var_0_13.UP then
			var_70_2 = "_upAction"
			self._showValueBtn._dir = var_0_13.DOWN

			self._showValueBtn:setFlippedY(false)
		end

		for iter_70_0 = 1, #var_70_1 do
			var_70_1[iter_70_0][var_70_2]()
		end

		var_70_0[var_70_2]()
		self._tableView[var_70_2]()
	end
end

return HelpBattleFormationLayer
