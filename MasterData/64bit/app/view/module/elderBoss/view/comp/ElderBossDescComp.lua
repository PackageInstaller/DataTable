local var_0_0 = g.core.model.User.elderBossData
local ElderBossDescComp = class("ElderBossDescComp", require("app.fairyGUI.elderBoss.UI_ElderBossDescComp"))

function ElderBossDescComp:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function ElderBossDescComp:updateDescComp(arg_2_1)
	self.m_bossName:setText(arg_2_1.name)

	if var_0_0:getMonsterInfoByTeamId(arg_2_1.monster_team_id) then
		self.m_skillDescTxt:setText(arg_2_1.skill_des)
	end
end

function ElderBossDescComp:_onClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.elderBoss.view.ElderBossPreviewPop").new()))
end

return ElderBossDescComp
