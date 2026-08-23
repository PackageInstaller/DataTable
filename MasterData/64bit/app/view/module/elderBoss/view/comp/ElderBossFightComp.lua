local var_0_0 = g.core.model.User.elderBossData
local ElderBossFightComp = class("ElderBossFightComp", require("app.fairyGUI.elderBoss.UI_ElderBossFightComp"))

function ElderBossFightComp:ctor()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
end

function ElderBossFightComp:updateFight()
	self.m_fightEff:removeAllEffect()
	self.m_fightEff:addEffectSpine({
		anim = "play",
		name = "eff_ui_elderBoss_btnchallenge",
		isLoop = true
	})
	self.m_descTxt:setText(g.core.lang:get(432520, {
		skillDesc = g.core.config.elder_boss_info.get((var_0_0:getBossId())).skill_des
	}))
	self:updateRedPoint()
end

function ElderBossFightComp:_onClickBattleBtn()
	if var_0_0:isHaveElderBossChallengeCount() then
		self:dispatchCompEvent("ON_CLICK_FIGHT_BOSS")
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_LJQS_Battle)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432525))
	end
end

function ElderBossFightComp:updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

return ElderBossFightComp
