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
		anim = "play",
		name = "eff_ui_guildwar_mainlayerLeft",
		isLoop = true
	})
	self.m_effectNodeRight:addEffectSpine({
		anim = "play",
		name = "eff_ui_guildwar_mainlayerRight",
		isLoop = true
	})
	self.m_effectNodeUp:addEffectSpine({
		anim = "play",
		name = "eff_ui_guildwar_mainlayerUp",
		isLoop = true
	})
	self.m_effectNodeDown:addEffectSpine({
		anim = "play",
		name = "eff_ui_guildwar_mainlayerDown",
		isLoop = true
	})
end

return GuildWarForegroundComp
