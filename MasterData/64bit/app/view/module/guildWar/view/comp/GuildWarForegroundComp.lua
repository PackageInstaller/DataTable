local GuildWarForegroundComp = class("GuildWarForegroundComp", require("app.fairyGUI.guildWar.UI_GuildWarForegroundComp"))

function GuildWarForegroundComp:ctor()
	self._isAddEffect = false
	self._isAddBg = false
end

function GuildWarForegroundComp:onLoad()
	self.m_t0Transition:play()
end

function GuildWarForegroundComp:addBgEffect()
	if self._isAddEffect then
		return
	end

	self._isAddEffect = true

	self.m_effectNodeLeft:addEffectSpine({
		isLoop = true,
		name = "eff_ui_guildwar_mainlayerLeft",
		anim = "play"
	})
	self.m_effectNodeRight:addEffectSpine({
		isLoop = true,
		name = "eff_ui_guildwar_mainlayerRight",
		anim = "play"
	})
	self.m_effectNodeUp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_guildwar_mainlayerUp",
		anim = "play"
	})
	self.m_effectNodeDown:addEffectSpine({
		isLoop = true,
		name = "eff_ui_guildwar_mainlayerDown",
		anim = "play"
	})
end

return GuildWarForegroundComp
