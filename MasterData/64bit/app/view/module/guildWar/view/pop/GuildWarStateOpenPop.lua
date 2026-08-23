local var_0_0 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local GuildWarStateOpenPop = class("GuildWarStateOpenPop", require("app.fairyGUI.guildWar.UI_GuildWarStateOpenPop"), function()
	return fgui.GComponent:create({
		pkgName = "guildWar",
		resName = "GuildWarStateOpenPop",
		pkgPath = "ui/guildWar/guildWar"
	}, ...)
end)

function GuildWarStateOpenPop:ctor(arg_2_1)
	self:showAtCenter()

	self._state = (arg_2_1.state or 0) == var_0_0.DEPLOY and 0 or 1

	if arg_2_1.isNewSeason then
		self._state = 2
	end
end

function GuildWarStateOpenPop:onLoad()
	self.m_stateController:setSelectedIndex(self._state)
	self.m_enterTransition:play(handler(self, self._onPlayAnimFinish))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_LAMU_OPEN)
end

function GuildWarStateOpenPop:_onPlayAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return GuildWarStateOpenPop
