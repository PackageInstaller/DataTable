local var_0_0 = g.core.model.User.mysteryBossData
local MysteryBossResultPop = class("MysteryBossResultPop", require("app.fairyGUI.mystery.UI_MysteryBossResultPop"), function()
	return fgui.GComponent:create({
		resName = "MysteryBossResultPop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryBossResultPop:ctor()
	self._notifyAwardData = var_0_0:getMysteryBossNotifyAwards()

	self:showAtCenter()
	self.m_rankAwardList:setVirtual()
	self.m_rankAwardList:setItemRenderer(handler(self, self._onRankAwardItemRender))
	self.m_posAwardList:setVirtual()
	self.m_posAwardList:setItemRenderer(handler(self, self._onPosAwardItemRender))
	self.m_giveUpBtn:addClickListener(handler(self, self._onClickGiveUpBtn))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_Jiangli)
end

function MysteryBossResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_RECVAWARD, handler(self, self.onS2CMysteryBossRecvAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GIVEAWARD, handler(self, self.onS2CMysteryBossGiveAward), self)
	self:_updateMainView()
end

function MysteryBossResultPop:_onRankAwardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rankAward[arg_4_1 + 1])
end

function MysteryBossResultPop:_onPosAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._posAward[arg_5_1 + 1])
end

function MysteryBossResultPop:_updateMainView()
	self.m_rankTxt:setText(self._notifyAwardData.rank)

	self._pos = self._notifyAwardData.pos

	self.m_isHavePosAwardController:setSelectedIndex(self._pos > 0 and 1 or 0)

	self._rankAward = self._notifyAwardData.rank_awards or {}

	self.m_rankAwardList:setNumItems(#self._rankAward)

	self._posAward = self._notifyAwardData.pos_awards or {}

	self.m_posAwardList:setNumItems(#self._posAward)
end

function MysteryBossResultPop:onS2CMysteryBossRecvAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards, true)
	self:_playCloseAnimation()
end

function MysteryBossResultPop:_playCloseAnimation()
	self.m_backTransition:play(handler(self, self._onClosePop))
end

function MysteryBossResultPop:_onClickGetAwardBtn()
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_RecvAward({})
end

function MysteryBossResultPop:_onClickGiveUpBtn()
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_GiveAward({})
end

function MysteryBossResultPop:onS2CMysteryBossGiveAward()
	self:_playCloseAnimation()
end

function MysteryBossResultPop:_onClosePop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return MysteryBossResultPop
