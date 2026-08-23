local var_0_0 = {
	LOCKED = 2,
	ALREADY = 0,
	READY = 1
}
local BaseMulTeamFormationUniteTokenComp = class("BaseMulTeamFormationUniteTokenComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationUniteTokenComp"))

function BaseMulTeamFormationUniteTokenComp:ctor()
	self._stationPos = 0
	self._sid = 0
	self._stateCtrlIdx = 0
	self._dragging = false
end

function BaseMulTeamFormationUniteTokenComp:setFormationType(arg_2_1)
	self._formationType = arg_2_1
end

function BaseMulTeamFormationUniteTokenComp:getFormationType()
	return self._formationType
end

function BaseMulTeamFormationUniteTokenComp:updateComp(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 and (not self._mulIndex or arg_4_3 ~= self._mulIndex) then
		self.m_redPointComp:setCustomData({
			formationType = self._formationType,
			formationIndex = arg_4_3,
			pos = arg_4_1
		})
	end

	self._stationPos = arg_4_1
	self._sid = arg_4_2
	self._dragging = false
	self._mulIndex = arg_4_3

	if self:isEmpty() then
		self.m_stateController:setSelectedIndex(var_0_0.READY)
	else
		self.m_stateController:setSelectedIndex(var_0_0.ALREADY)
		self.m_skillIcon:updateIcon({
			skillId = g.core.model.User.mulFormationData:getUniteTokenBySid(self._formationType, arg_4_2).getSkillId(nil)
		})
	end
end

function BaseMulTeamFormationUniteTokenComp:becomeTo(arg_5_1)
	self:setFormationType(arg_5_1:getFormationType())
	self:updateComp(arg_5_1:getStationPos(), arg_5_1:getSid(), self._mulIndex)
end

function BaseMulTeamFormationUniteTokenComp:isEmpty()
	return self._sid == 0
end

function BaseMulTeamFormationUniteTokenComp:getStationPos()
	return self._stationPos
end

function BaseMulTeamFormationUniteTokenComp:getSid()
	return self._sid
end

function BaseMulTeamFormationUniteTokenComp:onDragStart()
	self._dragging = true
	self._stateCtrlIdx = self.m_stateController:getSelectedIndex()

	self.m_stateController:setSelectedIndex(1)
end

function BaseMulTeamFormationUniteTokenComp:onDragEnd()
	if self._dragging then
		self._dragging = false

		self.m_stateController:setSelectedIndex(self._stateCtrlIdx)
	end
end

return BaseMulTeamFormationUniteTokenComp
