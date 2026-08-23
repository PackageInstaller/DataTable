local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GvePioneerTeamTipsPop = class("GvePioneerTeamTipsPop", require("app.fairyGUI.gve.UI_GvePioneerTeamTipsPop"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		resName = "GvePioneerTeamTipsPop",
		pkgPath = "ui/gve/gve"
	}, ...)
end)

function GvePioneerTeamTipsPop:ctor()
	var_0_1 = var_0_0:getGveData()

	self:showAtCenter()
end

function GvePioneerTeamTipsPop:onLoad()
	self.m_descText:setTitle(g.core.lang:get(309136, {
		name = var_0_1:getFinalBossName()
	}))
end

return GvePioneerTeamTipsPop
