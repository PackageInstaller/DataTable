local var_0_0 = g.core.model.User.GuildFightData
local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local GuildFightNormalComp = class("GuildFightNormalComp", require("app.fairyGUI.guildFight.UI_GuildFightNormalComp"))

function GuildFightNormalComp:ctor(arg_1_1)
	self._type = 1
end

function GuildFightNormalComp:updateComp()
	local var_2_0 = var_0_0:getAllNormalAreaData()

	for iter_2_0 = 1, GuildFightConst.NORMAL_AREA_NUM do
		self["m_entranceBtn" .. iter_2_0]:updateInfo(var_2_0[iter_2_0])
	end

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self:_showEnterEff()
end

function GuildFightNormalComp:_showEnterEff()
	if self._enterEffNode then
		self._enterEffNode:removeFromParent()

		self._enterEffNode = nil
	end

	self._enterEffNode = self.m_effEnter:addEffectSpine({
		isLoop = false,
		name = "eff_ui_guildFight_enter",
		anim = "play"
	})
end

return GuildFightNormalComp
