local MysteryBattleChallengePop = class("MysteryBattleChallengePop", require("app.fairyGUI.mystery.UI_MysteryBattleChallengePop"), function()
	return fgui.GComponent:create({
		resName = "MysteryBattleChallengePop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryBattleChallengePop:ctor(arg_2_1)
	self:showAtCenter()

	self._stageInfo = arg_2_1 and arg_2_1.info

	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wuzhuang_GetMenuSlide)
end

function MysteryBattleChallengePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_CHALLENGEBEGIN, handler(self, self._onS2CMysteryChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEBEGIN, handler(self, self._onS2CMysteryChallengeBegin), self)
	self:_updateChallengeInfo()
end

function MysteryBattleChallengePop:_updateChallengeInfo()
	self.m_knightPicComp:updateKnight({
		resId = tonumber(g.core.config.knight_base_info.get(self._stageInfo.knight_base).fight_id)
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
	self.m_challengeComp:updateComp(self._stageInfo)
end

function MysteryBattleChallengePop:_onS2CMysteryChallengeBegin(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return MysteryBattleChallengePop
