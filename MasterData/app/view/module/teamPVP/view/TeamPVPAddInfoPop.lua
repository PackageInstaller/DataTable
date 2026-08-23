local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPAddInfoPop = class("TeamPVPAddInfoPop", require("app.fairyGUI.teamPVP.UI_TeamPVPAddInfoPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPAddInfoPop",
		pkgPath = "ui/teamPVP/teamPVP",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPAddInfoPop:ctor(arg_2_1)
	self._popType = arg_2_1.popType

	self:showAtCenter()
	self:_updateView()
end

function TeamPVPAddInfoPop:_updateView()
	self.m_attrsPanel:updatePanel(self._popType)
	self.m_addGroup:setVisible(self._popType == var_0_1.ADD_POP_TYPE.TEAM)

	if self._popType == var_0_1.ADD_POP_TYPE.TIME then
		self.m_bgPanel:setTitle(g.core.lang:get(420440))
	elseif self._popType == var_0_1.ADD_POP_TYPE.TEAM then
		self.m_bgPanel:setTitle(g.core.lang:get(420439))
		self.m_addAll:setText(g.core.lang:get(420427, {
			num = var_0_0:getAddition()
		}))
	end
end

return TeamPVPAddInfoPop
