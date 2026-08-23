local var_0_0 = 199
local ETMainLayer = class("ETMainLayer", require("app.fairyGUI.equipAndTreasure.UI_ETMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ETMainLayer",
		pkgName = "equipAndTreasure",
		isFullScreen = true,
		pkgPath = "ui/equipAndTreasure/equipAndTreasure"
	}, ...)
end)
local var_0_2 = g.core.model.User.treasureData
local var_0_3 = g.core.model.User.equipmentData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.const.ConstMgr.FUNCTION_TYPE
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local ETData = require("app.view.module.equipAndTreasure.model.ETData")
local TreasureAttrComp = require("app.view.module.equipAndTreasure.view.treasure.TreasureAttrComp")
local TreasureSelectComp = require("app.view.module.equipAndTreasure.view.treasure.TreasureSelectComp")
local EquipDetailComp = require("app.view.module.equipAndTreasure.view.equip.EquipDetailComp")
local EquipWearComp = require("app.view.module.equipAndTreasure.view.equip.EquipWearComp")

function ETMainLayer:ctor(arg_2_1)
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

function ETMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onChangeFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_INHERITFORMATION, self._onETInheritFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_INHERITFORMATION, self._onETInheritFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_UPGRADE, self._onS2CEquipmentUpgrade, self)

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

function ETMainLayer:_updateView()
	self:_updateETPositionView()
	self:_updateRightPanel()
	self:_updateLineUpListView()
end

function ETMainLayer:_initData(arg_5_1)
	if not arg_5_1 then
		return
	end

	ETData.needChangeKnight = false
	ETData.knightId = nil
	ETData.selectPositionData = nil

	local var_5_0 = arg_5_1.knightIndex or 1

	self._knightIndex = var_5_0
	self._selectedIndex = var_5_0 - 1

	local var_5_1 = var_0_4:getKnightByFormationIndex(var_5_0)

	self._knight = var_5_1
	self._knightId = var_5_1:getServerId()
	self._formations = var_0_4:getFormationKnights()
end

function ETMainLayer:_initView()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_mastBtn:addClickListener(handler(self, self._onClickMaster))
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

function ETMainLayer:_lineUpListClickItem(arg_7_1)
	local var_7_0 = self.m_lineUpList:getSelectedIndex()

	if var_7_0 == self._selectedIndex then
		return
	end

	self._selectedIndex = var_7_0

	self:_onChangeKnight(self._formations[var_7_0 + 1])
	self:_showDefaultEquip()
end

function ETMainLayer:_onLineUpItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._formations[arg_8_1 + 1], var_0_5["KNIGHT_LINE_UP_" .. arg_8_1 + 1], arg_8_1 + 1, var_0_0)
end

function ETMainLayer:_updateLineUpListView(arg_9_1)
	self.m_lineUpList:setNumItems((var_0_4:getLineupKnightCount()))

	if arg_9_1 ~= self._selectedIndex then
		self._selectedIndex = arg_9_1 and arg_9_1 or self._selectedIndex
	end

	if self._selectedIndex < 0 then
		self._selectedIndex = 0
	end

	self.m_lineUpList:setSelectedIndex(self._selectedIndex)
	self.m_lineUpList:transitionShowCells("enter", 0.06)
end

function ETMainLayer:_onSelectedChange()
	if self.m_groupController:getSelectedIndex() == 1 then
		self.m_move_1Transition:play()
	else
		self.m_move_0Transition:play()
	end
end

function ETMainLayer:_onShowDiaLogChange()
	local var_11_0 = self.m_showDialogController:getSelectedIndex()

	if var_11_0 == 1 then
		-- block empty
	elseif var_11_0 == 2 then
		-- block empty
	elseif var_11_0 == 3 then
		-- block empty
	elseif var_11_0 == 4 and self.m_equipAttrComp then
		self.m_equipAttrComp:onPlayEnterTransition()
	end
end

function ETMainLayer:_onTouchBackground()
	self:_resetView()
end

function ETMainLayer:_onChangeKnight(arg_13_1)
	self._knightId = arg_13_1
	self._knight = var_0_4:getKnightById(self._knightId)
	self._knightIndex = self._knight:getFormationPos()

	self:_updateETPositionView()

	if self.m_equipAttrComp then
		self.m_equipAttrComp:onPlayEnterTransition()
	end

	return true
end

function ETMainLayer:_onETSelectPosition(arg_14_1)
	ETData.selectPositionData = arg_14_1

	self:_updateETPositionView()
	self:_updateRightPanel()
end

function ETMainLayer:_updateETPositionView()
	self.m_groupComp:updateView({
		knightIndex = self._knightIndex,
		knight = self._knight,
		selectPositionData = ETData.selectPositionData
	})
end

function ETMainLayer:_updateRightPanel()
	if not ETData.selectPositionData then
		return
	end

	if ETData.selectPositionData.positionType <= 4 then
		self:_updateEquipRightPanel(ETData.selectPositionData)
	else
		self:_updateTreasureRightPanel(ETData.selectPositionData)
	end
end

function ETMainLayer:_updateEquipRightPanel(arg_17_1)
	if arg_17_1.wearStatus == TreasureConst.WEAR_STATUS.WEAR then
		self:_showPanelByControllerIndex(4)

		if not self.m_equipAttrComp then
			self.m_equipAttrComp = EquipDetailComp.new()

			self.m_equipAttrComp:setHeight(display.height)
			self.m_equipAttrHolder:addChild(self.m_equipAttrComp)
		end

		self.m_equipAttrComp:updateView()
	elseif arg_17_1.wearStatus == TreasureConst.WEAR_STATUS.NOT_UNLOCK then
		self:_showPanelByControllerIndex(0)
	elseif arg_17_1.wearStatus == TreasureConst.WEAR_STATUS.CAN_WEAR then
		self:_showPanelByControllerIndex(3)
		self:_updateEquipSelectComp()
	end
end

function ETMainLayer:_updateTreasureRightPanel(arg_18_1)
	if arg_18_1.wearStatus == TreasureConst.WEAR_STATUS.WEAR then
		self:_showPanelByControllerIndex(2)

		if not self.m_attrComp then
			self.m_attrComp = TreasureAttrComp.new()

			self.m_attrComp:getView():setHeight(self._fitHeight)
			self.m_attrPlaceHolder:addChild(self.m_attrComp)
		end

		self.m_attrComp:updateView({
			selectPositionData = arg_18_1
		})
	elseif arg_18_1.wearStatus == TreasureConst.WEAR_STATUS.NOT_UNLOCK then
		self:_showPanelByControllerIndex(0)
	elseif arg_18_1.wearStatus == TreasureConst.WEAR_STATUS.CAN_WEAR then
		self:_showPanelByControllerIndex(1)
		self:_updateTreasureSelectComp(arg_18_1)
	end
end

function ETMainLayer:_updateTreasureSelectComp(arg_19_1)
	if not self.m_treasureSelectComp then
		self.m_treasureSelectComp = TreasureSelectComp.new()

		self.m_treasureSelectComp:getView():setHeight(self._fitHeight)
		self.m_treasureSelPlaceHolder:addChild(self.m_treasureSelectComp)
		self.m_treasureSelectComp:updateView({
			selectPositionData = arg_19_1,
			knightId = self._knightId,
			knightIndex = self._knightIndex
		})
	else
		self.m_treasureSelectComp:updateView({
			selectPositionData = arg_19_1,
			knightId = self._knightId,
			knightIndex = self._knightIndex
		})
	end
end

function ETMainLayer:_updateEquipSelectComp()
	if not self.m_equipSelectComp then
		self.m_equipSelectComp = EquipWearComp.new()

		self.m_equipSelectComp:getView():setHeight(self._fitHeight)
		self.m_equipSelectHolder:addChild(self.m_equipSelectComp)
	end

	local var_20_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_equipSelectComp)

	if var_20_0 then
		var_20_0:play()
	end

	self.m_equipSelectComp:updateView()
end

function ETMainLayer:_resetView()
	ETData.selectPositionData = nil

	self.m_showDialogController:setSelectedIndex(0)
	self.m_groupController:setSelectedIndex(0)
	self:_updateETPositionView()
end

function ETMainLayer:_showPanelByControllerIndex(arg_22_1)
	if arg_22_1 > 4 then
		return
	end

	if arg_22_1 == 0 then
		self.m_groupController:setSelectedIndex(0)
	else
		self.m_groupController:setSelectedIndex(1)
	end

	self.m_showDialogController:setSelectedIndex(arg_22_1)
end

function ETMainLayer:_onWearTreasure(arg_23_1, arg_23_2, arg_23_3)
	return
end

function ETMainLayer:_onOpenTreasureDialog(arg_24_1, arg_24_2, arg_24_3)
	if ETData.selectPositionData then
		self.m_showDialogController:setSelectedIndex(1)
		self:_updateTreasureSelectComp(ETData.selectPositionData)
	end
end

function ETMainLayer:_onOpenEquipDialog()
	if ETData.selectPositionData then
		self.m_showDialogController:setSelectedIndex(3)
		self:_updateEquipSelectComp()
	end
end

function ETMainLayer:receiveCompEvent(arg_26_1)
	if arg_26_1 == "on_click_master" then
		self:_onClickMaster()
	elseif arg_26_1 == "on_open_treasure_dialog" then
		self:_onOpenTreasureDialog()
	elseif arg_26_1 == "on_open_equip_dialog" then
		self:_onOpenEquipDialog()
	elseif arg_26_1 == "on_select_et_position" then
		self:_onETSelectPosition(({
			...
		})[1])
	end
end

function ETMainLayer:_onClickMaster()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.STRENGTHEN_MASTER) then
		local var_27_0 = true
		local var_27_1 = true

		for iter_27_0 = 1, 4 do
			if not var_0_3:isWornEquip((self._knightIndex - 1) * 4 + iter_27_0) then
				var_27_0 = false

				break
			end
		end

		for iter_27_1 = 1, 2 do
			local var_27_2

			if not var_0_2:isHaveTreasurePos((self._knightIndex - 1) * 2 + iter_27_1) then
				var_27_1 = false

				do break end

				var_27_2 = {
					type = g.core.common.Goods.TYPE_TREASURE
				}
			end

			var_27_2.value = g.core.config.treasure_info.get(var_0_2:getTreasureDataByPos((self._knightIndex - 1) * 2 + iter_27_1).base_id).id

			if g.core.common.Goods:convert(var_27_2).quality < 2 then
				var_27_1 = false

				break
			end
		end

		if not var_27_0 and not var_27_1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(202024))

			return
		end

		self:addPopup(require("app.view.module.equipAndTreasure.view.common.ETMasterPop").new(self._knightIndex - 1, var_27_0, var_27_1))
	end
end

function ETMainLayer:_onChangeFormation(arg_28_1, arg_28_2, arg_28_3)
	self._changeFormHint = {}

	if arg_28_3.tp == 3 or arg_28_3.tp == 4 then
		self:_handleChangeEquipGroup(arg_28_3)

		if arg_28_3.pos > 0 then
			self:_updateRightPanel()
		end

		if arg_28_3.pos == 0 then
			self:_resetView()
		end
	end
end

function ETMainLayer:_onETInheritFormation(arg_29_1, arg_29_2, arg_29_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(200013))
	self:_updateView()

	if arg_29_3.award then
		g.core.module.ModuleManager:awardSummary(arg_29_3.award, false, nil, g.core.lang:get(200014))
	end
end

function ETMainLayer:_onS2CEquipmentUpgrade()
	self:_updateView()
end

function ETMainLayer:_handleChangeEquipGroup(arg_31_1)
	if arg_31_1.tp == 1 then
		self._changeFormHint[#self._changeFormHint + 1] = {
			title = g.core.lang:get(201538)
		}
	elseif arg_31_1.pos ~= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(201539))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201540))
	end

	self:_updateETPositionView()
end

function ETMainLayer:_showDefaultEquip()
	if self._defaultSelect <= 4 then
		self.m_groupComp["m_equipComp" .. self._defaultSelect]:onClickIcon()
	elseif self._defaultSelect ~= 5 then
		if self._defaultSelect == 6 then
			self.m_groupComp["m_treasureComp" .. self._defaultSelect - 4]:onClickIcon()
		end
	end

	self._defaultSelect = 1
end

return ETMainLayer
