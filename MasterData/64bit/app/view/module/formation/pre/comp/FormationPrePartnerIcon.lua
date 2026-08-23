local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationPrePartnerIcon = class("FormationPrePartnerIcon", require("app.fairyGUI.formation.UI_FormationPrePartnerIcon"))

function FormationPrePartnerIcon:ctor()
	self._unLock = true
	self._partnerPos = 0
	self._formationPos = 0
	self._knightId = 0
	self._knight = {}
	self._unLockText = nil
	self._canClick = true
	self._hasRed = true
end

function FormationPrePartnerIcon:updateCell(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 then
		self:updatePartnerFormatIconByKnightStruct(arg_2_3)
	elseif arg_2_2 then
		self:updatePartnerFormatIcon(arg_2_2)
	end

	local var_2_0 = var_0_1["KNIGHT_PARTNER_" .. arg_2_1]

	if var_0_0:isModuleUnlock(var_0_1["KNIGHT_PARTNER_" .. arg_2_1]) then
		self:setPartnerPos(arg_2_1)
		self:freshRedPoint()
	else
		local var_2_1, var_2_2 = var_0_0:getModuleUnlockLevelAndComment(var_2_0)

		self:updateFormatUnlock(var_2_1, var_2_2)
	end
end

function FormationPrePartnerIcon:setPartnerPos(arg_3_1)
	self._partnerPos = arg_3_1
	self._formationPos = var_0_2.LINEUP_MAX + arg_3_1
end

function FormationPrePartnerIcon:getPartnerPos()
	return self._partnerPos
end

function FormationPrePartnerIcon:updateFormatUnlock(arg_5_1, arg_5_2)
	self._unLock = false

	self.m_stateController:setSelectedIndex(2)

	self._unLockText = g.core.lang:get(202514, {
		level = arg_5_1
	})
	self._unLockDirection = arg_5_2

	self.m_openText:setText(self._unLockText)
end

function FormationPrePartnerIcon:updatePartnerFormatIcon(arg_6_1)
	self._canClick = true

	if arg_6_1 == 0 then
		self.m_stateController:setSelectedIndex(1)

		return
	end

	self._knightId = arg_6_1

	self.m_stateController:setSelectedIndex(0)
	self.m_knightIcon:updateIcon({
		isNeedShowWedding = true,
		sid = arg_6_1
	})
end

function FormationPrePartnerIcon:freshRedPoint()
	if not self._hasRed then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._partnerPos
		}
	})
end

function FormationPrePartnerIcon:updatePartnerFormatIconByKnightStruct(arg_8_1)
	self._canClick = false

	if arg_8_1 == nil then
		self.m_stateController:setSelectedIndex(3)

		return
	end

	self.m_stateController:setSelectedIndex(0)
	self.m_knightIcon:updateIcon({
		struct = arg_8_1
	})
end

function FormationPrePartnerIcon:setHasRedPoint(arg_9_1)
	self._hasRed = arg_9_1

	self.m_redPointComp:setVisible(arg_9_1)
end

return FormationPrePartnerIcon
