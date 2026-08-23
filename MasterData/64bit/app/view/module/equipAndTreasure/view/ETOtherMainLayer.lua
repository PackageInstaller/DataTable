local var_0_0 = 199
local ETOtherMainLayer = class("ETOtherMainLayer", require("app.fairyGUI.equipAndTreasure.UI_ETOtherMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ETOtherMainLayer",
		pkgName = "equipAndTreasure",
		isFullScreen = true,
		pkgPath = "ui/equipAndTreasure/equipAndTreasure"
	}, ...)
end)
local var_0_2 = g.core.model.User.playerInfoData
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local ETData = require("app.view.module.equipAndTreasure.model.ETData")
local TreasureAttrComp = require("app.view.module.equipAndTreasure.view.treasure.TreasureAttrComp")
local EquipDetailComp = require("app.view.module.equipAndTreasure.view.equip.EquipDetailComp")

function ETOtherMainLayer:ctor(arg_2_1)
	self._knightIndex = nil
	self._knightId = nil
	self._selectedGood = nil
	self._knight = nil
	self._fitHeight = 0
	self.m_attrComp = nil
	self.m_equipAttrComp = nil
	self.m_treasureSelectComp = nil
	self.m_equipSelectComp = nil
	self._formations = nil
	self._selectedIndex = 0
	self._defaultSelect = arg_2_1.defaultPos or 1

	self.m_lineUpList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._lineUpListClickItem))
	self:_initData(arg_2_1)
	self:_initView()
end

function ETOtherMainLayer:onLoad()
	if ETData.needChangeKnight and ETData.knightId and self._knightId ~= ETData.knightId then
		self:_onChangeKnight(ETData.knightId)

		self._selectedIndex = self._knightIndex - 1
		ETData.needChangeKnight = false
		ETData.knightId = nil
	else
		self:_showDefaultEquip()
	end

	self:_updateView()
end

function ETOtherMainLayer:_updateView()
	self:_updateETPositionView()
	self:_updateRightPanel()
	self:_updateLineUpListView()
end

function ETOtherMainLayer:_initData(arg_5_1)
	if not arg_5_1 then
		return
	end

	ETData.needChangeKnight = false
	ETData.knightId = nil
	ETData.selectPositionData = nil

	local var_5_0 = arg_5_1.knightIndex or 1

	self._knightIndex = var_5_0
	self._selectedIndex = var_5_0 - 1
	self._knight = arg_5_1.knight
	self._knightId = arg_5_1.knight:getServerId()
	self._formations = var_0_2:getLineUpKnightSids()
end

function ETOtherMainLayer:_initView()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectedChange))
	self.m_showDialogController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowDiaLogChange))

	self._fitHeight = self.m_fitHeightImg:getSize().height

	self.m_fitHeightImg:addClickListener(handler(self, self._onTouchBackground))
	self.m_topBarComp:setResInfoById(51)
	self.m_groupComp:updateView({
		knightIndex = self._knightIndex,
		knight = self._knight,
		selectPositionData = ETData.selectPositionData
	})
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:doFairyBatching(false)
	self.m_lineUpList:setItemRenderer(handler(self, self._onLineUpItemRenderer))
end

function ETOtherMainLayer:_lineUpListClickItem(arg_7_1)
	local var_7_0 = self.m_lineUpList:getSelectedIndex()

	if var_7_0 == self._selectedIndex then
		return
	end

	self._selectedIndex = var_7_0

	self:_onChangeKnight(self._formations[var_7_0 + 1])
	self:_showDefaultEquip()
end

function ETOtherMainLayer:_onLineUpItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._formations[arg_8_1 + 1], var_0_3["KNIGHT_LINE_UP_" .. arg_8_1 + 1], arg_8_1 + 1, var_0_0, true)
end

function ETOtherMainLayer:_updateLineUpListView(arg_9_1)
	self.m_lineUpList:setNumItems(#self._formations)

	if arg_9_1 ~= self._selectedIndex then
		self._selectedIndex = arg_9_1 and arg_9_1 or self._selectedIndex
	end

	if self._selectedIndex < 0 then
		self._selectedIndex = 0
	end

	self.m_lineUpList:setSelectedIndex(self._selectedIndex)
	self.m_lineUpList:transitionShowCells("enter", 0.06)
end

function ETOtherMainLayer:_onSelectedChange()
	if self.m_groupController:getSelectedIndex() == 1 then
		self.m_move_1Transition:play()
	else
		self.m_move_0Transition:play()
	end
end

function ETOtherMainLayer:_onShowDiaLogChange()
	local var_11_0 = self.m_showDialogController:getSelectedIndex()

	if var_11_0 == 1 then
		-- block empty
	elseif var_11_0 == 2 and self.m_equipAttrComp then
		self.m_equipAttrComp:onPlayEnterTransition()
	end
end

function ETOtherMainLayer:_onTouchBackground()
	self:_resetView()
end

function ETOtherMainLayer:_onChangeKnight(arg_13_1)
	self._knightId = arg_13_1
	self._knight = g.core.model.User.friendData:getPlayerInfo().knightIdDict[arg_13_1]
	self._knightIndex = self._knight:getFormationPos()

	self:_updateETPositionView()

	if self.m_equipAttrComp then
		self.m_equipAttrComp:onPlayEnterTransition()
	end

	return true
end

function ETOtherMainLayer:_onETSelectPosition(arg_14_1)
	ETData.selectPositionData = arg_14_1

	self:_updateETPositionView()
	self:_updateRightPanel()
end

function ETOtherMainLayer:_updateETPositionView()
	self.m_groupComp:updateView({
		knightIndex = self._knightIndex,
		knight = self._knight,
		selectPositionData = ETData.selectPositionData
	})
end

function ETOtherMainLayer:_updateRightPanel()
	if not ETData.selectPositionData then
		return
	end

	if ETData.selectPositionData.positionType <= 4 then
		self:_updateEquipRightPanel(ETData.selectPositionData)
	else
		self:_updateTreasureRightPanel(ETData.selectPositionData)
	end
end

function ETOtherMainLayer:_updateEquipRightPanel(arg_17_1)
	if arg_17_1.wearStatus == TreasureConst.WEAR_STATUS.WEAR then
		self:_showPanelByControllerIndex(2)

		if not self.m_equipAttrComp then
			self.m_equipAttrComp = EquipDetailComp.new()

			self.m_equipAttrComp:setHeight(display.height)
			self.m_equipAttrHolder:addChild(self.m_equipAttrComp)
		end

		self.m_equipAttrComp:updateView(true)
	elseif arg_17_1.wearStatus == TreasureConst.WEAR_STATUS.CAN_WEAR then
		self:_resetView()
	end
end

function ETOtherMainLayer:_updateTreasureRightPanel(arg_18_1)
	if arg_18_1.wearStatus == TreasureConst.WEAR_STATUS.WEAR then
		self:_showPanelByControllerIndex(1)

		if not self.m_attrComp then
			self.m_attrComp = TreasureAttrComp.new()

			self.m_attrComp:getView():setHeight(self._fitHeight)
			self.m_attrPlaceHolder:addChild(self.m_attrComp)
		end

		self.m_attrComp:updateView({
			isOther = true,
			selectPositionData = arg_18_1
		})
	elseif arg_18_1.wearStatus == TreasureConst.WEAR_STATUS.CAN_WEAR then
		self:_resetView()
	end
end

function ETOtherMainLayer:_resetView()
	ETData.selectPositionData = nil

	self.m_showDialogController:setSelectedIndex(0)
	self.m_groupController:setSelectedIndex(0)
	self:_updateETPositionView()
end

function ETOtherMainLayer:_showPanelByControllerIndex(arg_20_1)
	if arg_20_1 > 2 then
		return
	end

	if arg_20_1 == 0 then
		self.m_groupController:setSelectedIndex(0)
	else
		self.m_groupController:setSelectedIndex(1)
	end

	self.m_showDialogController:setSelectedIndex(arg_20_1)
end

function ETOtherMainLayer:receiveCompEvent(arg_21_1)
	if arg_21_1 == "on_select_et_position" then
		self:_onETSelectPosition(({
			...
		})[1])
	end
end

function ETOtherMainLayer:_showDefaultEquip()
	if self._defaultSelect <= 4 then
		self.m_groupComp["m_equipComp" .. self._defaultSelect]:onClickIcon()
	elseif self._defaultSelect ~= 5 then
		if self._defaultSelect == 6 then
			self.m_groupComp["m_treasureComp" .. self._defaultSelect - 4]:onClickIcon()
		end
	end

	self._defaultSelect = 1
end

return ETOtherMainLayer
