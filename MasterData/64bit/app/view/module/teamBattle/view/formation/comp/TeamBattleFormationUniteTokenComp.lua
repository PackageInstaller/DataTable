local var_0_0 = {
	LOCKED = 2,
	READY = 1,
	ALREADY = 0
}
local var_0_1 = g.core.model.User.teamBattleData
local TeamBattleFormationUniteTokenComp = class("TeamBattleFormationUniteTokenComp", require("app.fairyGUI.teamBattle.UI_TeamBattleFormationUniteTokenComp"))

function TeamBattleFormationUniteTokenComp:ctor()
	self._stationPos = 0
	self._aid = 0
	self._stateCtrlIdx = 0
	self._dragging = false
end

function TeamBattleFormationUniteTokenComp:setFormationType(arg_2_1)
	self._formationType = arg_2_1
end

function TeamBattleFormationUniteTokenComp:updateComp(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 and (not self._mulIndex or arg_3_3 ~= self._mulIndex) then
		self.m_redPointComp:setCustomData({
			formationIndex = arg_3_3,
			pos = arg_3_1
		})
	end

	self._stationPos = arg_3_1
	self._aid = arg_3_2
	self._dragging = false
	self._mulIndex = arg_3_3

	if self:isEmpty() then
		self.m_stateController:setSelectedIndex(var_0_0.READY)
	else
		self.m_stateController:setSelectedIndex(var_0_0.ALREADY)
		self.m_skillIcon:updateIcon({
			skillId = var_0_1:getFormationData():getUniteTokenByServerId(arg_3_2):getSkillId()
		})
	end
end

function TeamBattleFormationUniteTokenComp:becomeTo(arg_4_1)
	self:updateComp(arg_4_1:getStationPos(), arg_4_1:getAdvanceId(), self._mulIndex)
end

function TeamBattleFormationUniteTokenComp:isEmpty()
	return self._aid == 0
end

function TeamBattleFormationUniteTokenComp:getStationPos()
	return self._stationPos
end

function TeamBattleFormationUniteTokenComp:getAdvanceId()
	return self._aid
end

function TeamBattleFormationUniteTokenComp:onDragStart()
	self._dragging = true
	self._stateCtrlIdx = self.m_stateController:getSelectedIndex()

	self.m_stateController:setSelectedIndex(1)
end

function TeamBattleFormationUniteTokenComp:onDragEnd()
	if self._dragging then
		self._dragging = false

		self.m_stateController:setSelectedIndex(self._stateCtrlIdx)
	end
end

return TeamBattleFormationUniteTokenComp
