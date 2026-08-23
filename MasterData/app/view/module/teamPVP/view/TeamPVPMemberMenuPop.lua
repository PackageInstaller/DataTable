local TeamPVPMemberMenuPop = class("TeamPVPMemberMenuPop", require("app.fairyGUI.teamPVP.UI_TeamPVPMemberMenuPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPMemberMenuPop",
		pkgPath = "ui/teamPVP/teamPVP",
		isFullScreen = true,
		pkgName = "teamPVP"
	}, ...)
end)
local var_0_3 = 50

function TeamPVPMemberMenuPop:ctor(arg_2_1, arg_2_2)
	self._params = arg_2_1
	self._snapshot = arg_2_1.snapshot
	self._battleUser = arg_2_1.battleUser

	self:showAtCenter()
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
	self.m_menuComp:setCtrlState("isRobot", {
		index = self._battleUser.is_robot and 1 or 0
	})
	self.m_menuComp:setCtrlState("isCaptain", {
		index = arg_2_1.isCaptain and 1 or 0
	})

	self._clickPos = arg_2_2
end

function TeamPVPMemberMenuPop:_showMenuComp()
	local var_3_0 = {
		x = self._clickPos.x,
		y = self._clickPos.y
	}
	local var_3_1 = self.m_menuComp:getSize()

	if self._clickPos.x + var_3_1.width > display.width then
		var_3_0.x = self._clickPos.x - var_0_3 - var_3_1.width
	end

	if self._clickPos.y + var_3_1.height > display.height then
		var_3_0.y = self._clickPos.y - var_3_1.height
	end

	self.m_menuComp:setPosition(var_3_0)
	self:newScheduleOnce(handler(self, function(arg_4_0)
		arg_4_0.m_menuGroup:setVisible(true)
	end), 0.09)
end

function TeamPVPMemberMenuPop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "click_info_btn" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isUpdate = false,
			uid = self._snapshot.id
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	elseif arg_5_1 == "click_kick_btn" then
		g.core.network.GameNetProxy:send_C2S_GroupBattle_Kick({
			guid = self._battleUser.guid
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function TeamPVPMemberMenuPop:_onClick()
	self.m_menuGroup:setVisible(false)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamPVPMemberMenuPop:onLoad()
	self.m_menuGroup:setVisible(false)
	self:_showMenuComp()
end

return TeamPVPMemberMenuPop
