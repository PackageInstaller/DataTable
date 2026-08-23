local ETIconComp = class("ETIconComp", require("app.fairyGUI.equipAndTreasure.UI_ETIconComp"))
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local ETData = require("app.view.module.equipAndTreasure.model.ETData")

function ETIconComp:ctor()
	self._data = {}
	self._sId = 0
	self._treasureId = nil
	self._positionType = nil
	self._knightIndex = 1
	self._selectPositionData = nil
	self._wearStatus = 0
	self._positionData = nil

	self:addClickListener(handler(self, self.onClickIcon))
	self.m_equipIconComp:setQualityEffectEnable(true)
	self.m_addEffect:addEffectSpine({
		name = "eff_ui_equip_addIdle",
		scale = 1,
		isLoop = true
	})
end

function ETIconComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_LUCK, handler(self, self._onRcvTreasureLock), self)
end

function ETIconComp:_initData(arg_3_1)
	self.m_redPointComp:setId(0)

	if arg_3_1.isWear and not arg_3_1.isLock then
		self._wearStatus = TreasureConst.WEAR_STATUS.WEAR
	elseif arg_3_1.isLock then
		self._wearStatus = TreasureConst.WEAR_STATUS.NOT_UNLOCK
	elseif arg_3_1.canWear then
		self._wearStatus = TreasureConst.WEAR_STATUS.CAN_WEAR

		g.core.utils.Action.playBlinkAction(self.m_plusImg, 1, 0)
	else
		self._wearStatus = TreasureConst.WEAR_STATUS.CAN_WEAR
	end

	self._positionType = self.m_positionTypeController:getSelectedIndex() + 1

	if arg_3_1.type == g.core.common.Goods.TYPE_TREASURE then
		self._sId = arg_3_1.isWear and not arg_3_1.isLock and arg_3_1.pos and g.core.model.User.treasureData:getTreasureDataByPos(arg_3_1.pos).id or 0

		self.m_redPointComp:setId(127)
	else
		self.m_equipIconComp:hideQualityEffect()
		self.m_redPointComp:setId(119)
	end

	self._knightIndex = arg_3_1.knightIndex
	self._selectPositionData = arg_3_1.selectPositionData
	self._data = arg_3_1

	local var_3_0 = 0

	if self._data.serverData then
		self._treasureId = self._data.serverData.base_id
		var_3_0 = self._data.serverData.id
	end

	self._positionData = {
		state = 1,
		pos = self._data.pos,
		type = self._data.type,
		id = self._treasureId,
		sid = self._sId,
		knightPos = self._data.knight:getInfo().position,
		positionType = self._positionType,
		wearStatus = self._wearStatus
	}

	if arg_3_1.type == g.core.common.Goods.TYPE_TREASURE then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				index = self._positionData.knightPos,
				type = self._positionType,
				onlyId = self._sId
			}
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				index = self._positionData.knightPos,
				type = self._positionType,
				id = var_3_0
			}
		})
	end
end

function ETIconComp:updateView(arg_4_1)
	self:_initData(arg_4_1)
	self.m_plusImg:stopAllFGActions()
	self.m_treasureLockLoader:setVisible(false)
	self.m_equipStateController:setSelectedIndex(self._wearStatus)

	local var_4_0 = arg_4_1.type == g.core.common.Goods.TYPE_EQUIP

	if self._selectPositionData and self._selectPositionData.positionType == self._positionType then
		if arg_4_1.type == g.core.common.Goods.TYPE_EQUIP then
			self.m_equipSelectController:setSelectedIndex(1)
		else
			self.m_selectController:setSelectedIndex(1)
		end

		ETData.selectPositionData = self._positionData
	else
		self.m_selectController:setSelectedIndex(0)
		self.m_equipSelectController:setSelectedIndex(0)
	end

	if self._wearStatus == TreasureConst.WEAR_STATUS.WEAR then
		self.m_equipIconComp:setTouchable(false)

		local var_4_1 = {
			changeControllers = true,
			isBlack = true,
			overrideClick = true,
			resonanceState = 2,
			type = arg_4_1.type,
			value = arg_4_1.serverData.base_id,
			level = arg_4_1.serverData.level,
			refineLevel = arg_4_1.serverData.refining_level,
			glyphLevel = arg_4_1.serverData.glyph_level,
			isDiamond = var_4_0
		}

		var_4_1.resonanceLevel = arg_4_1.serverData.resonance_level or 0
		var_4_1.magicalStage = arg_4_1.serverData.magical_stage or 0

		self.m_equipIconComp:updateIcon(var_4_1)

		if g.core.common.Goods.TYPE_TREASURE == arg_4_1.type then
			if g.core.model.User.treasureData:getTreasureDataByOnlyId(self._sId).lock then
				self.m_treasureLockLoader:setVisible(true)
			else
				self.m_treasureLockLoader:setVisible(false)
			end
		end
	else
		self.m_equipIconComp:updateIcon({
			empty = true,
			isBlack = true,
			isDiamond = var_4_0
		})
		self.m_equipIconComp:setTouchable(false)
	end
end

function ETIconComp:isLock()
	return self._data.isLock
end

function ETIconComp:onClickIcon(arg_6_1)
	if arg_6_1 then
		arg_6_1:stopPropagation()
	end

	self:dispatchCompEvent("on_select_et_position", self._positionData)

	if self._wearStatus == TreasureConst.WEAR_STATUS.NOT_UNLOCK then
		g.core.module.ModuleManager:tip(self._data.desc)
	end
end

function ETIconComp:_onRcvTreasureLock()
	if self._sId and self._sId > 0 then
		if g.core.model.User.treasureData:getTreasureDataByOnlyId(self._sId).lock then
			self.m_treasureLockLoader:setVisible(true)
		else
			self.m_treasureLockLoader:setVisible(false)
		end
	end
end

return ETIconComp
