local ETOtherIconComp = class("ETOtherIconComp", require("app.fairyGUI.equipAndTreasure.UI_ETOtherIconComp"))
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local ETData = require("app.view.module.equipAndTreasure.model.ETData")

function ETOtherIconComp:ctor()
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
end

function ETOtherIconComp:_initData(arg_2_1)
	self._wearStatus = arg_2_1.isWear and TreasureConst.WEAR_STATUS.WEAR or TreasureConst.WEAR_STATUS.CAN_WEAR
	self._positionType = self.m_positionTypeController:getSelectedIndex() + 1

	if arg_2_1.type == g.core.common.Goods.TYPE_TREASURE then
		local var_2_0 = g.core.model.User.playerInfoData:getTreasureByPos(arg_2_1.pos)

		self._sId = var_2_0 and var_2_0.id or 0
	else
		self.m_equipIconComp:hideQualityEffect()
	end

	self._knightIndex = arg_2_1.knightIndex
	self._selectPositionData = arg_2_1.selectPositionData
	self._data = arg_2_1

	if self._data.serverData then
		self._treasureId = self._data.serverData.base_id
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
end

function ETOtherIconComp:updateView(arg_3_1)
	self:_initData(arg_3_1)

	local var_3_0 = arg_3_1.type == g.core.common.Goods.TYPE_EQUIP

	if self._selectPositionData and self._selectPositionData.positionType == self._positionType then
		if arg_3_1.type == g.core.common.Goods.TYPE_EQUIP then
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

		local var_3_1 = {
			overrideClick = true,
			isBlack = true,
			resonanceState = 2,
			changeControllers = true,
			type = arg_3_1.type,
			value = arg_3_1.serverData.base_id,
			level = arg_3_1.serverData.level,
			refineLevel = arg_3_1.serverData.refining_level,
			glyphLevel = arg_3_1.serverData.glyph_level,
			isDiamond = var_3_0
		}

		var_3_1.resonanceLevel = arg_3_1.serverData.resonance_level or 0
		var_3_1.magicalStage = arg_3_1.serverData.magical_stage or 0

		self.m_equipIconComp:updateIcon(var_3_1)
	else
		self.m_equipIconComp:updateIcon({
			isBlack = true,
			empty = true,
			isDiamond = var_3_0
		})
		self.m_equipIconComp:setTouchable(false)
	end
end

function ETOtherIconComp:isLock()
	return self._data.isLock
end

function ETOtherIconComp:onClickIcon(arg_5_1)
	if arg_5_1 then
		arg_5_1:stopPropagation()
	end

	self:dispatchCompEvent("on_select_et_position", self._positionData)
end

return ETOtherIconComp
