local TeamPVPMemberMenuComp = class("TeamPVPMemberMenuComp", require("app.fairyGUI.teamPVP.UI_TeamPVPMemberMenuComp"))

function TeamPVPMemberMenuComp:ctor()
	self._battleUser = nil
	self._snapshot = nil

	self.m_infoBtn:addClickListener(handler(self, self._onClickInfoBtn))
	self.m_kickBtn:addClickListener(handler(self, self._onClickKickBtn))
end

function TeamPVPMemberMenuComp:_onClickInfoBtn()
	self:dispatchCompEvent("click_info_btn")
end

function TeamPVPMemberMenuComp:_onClickKickBtn()
	self:dispatchCompEvent("click_kick_btn")
end

return TeamPVPMemberMenuComp
