local MysteryBossAwardPop = class("MysteryBossAwardPop", require("app.fairyGUI.mystery.UI_MysteryBossAwardPop"), function()
	return fgui.GComponent:create({
		resName = "MysteryBossAwardPop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryBossAwardPop:ctor(arg_2_1)
	self._boss = arg_2_1

	self:showAtCenter()
	self.m_rankRewardList:setVirtual()
	self.m_rankRewardList:doFairyBatching(false)
	self.m_rankRewardList:setItemRenderer(handler(self, self._onRandRewardItemRender))
	self.m_posRewardList:setVirtual()
	self.m_posRewardList:doFairyBatching(false)
	self.m_posRewardList:setItemRenderer(handler(self, self._onPosRewardItemRender))
end

function MysteryBossAwardPop:_onRandRewardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._bossRankAward[arg_3_1 + 1], arg_3_1 + 1)
end

function MysteryBossAwardPop:_onPosRewardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._posAward[arg_4_1 + 1], arg_4_1 + 1)
end

function MysteryBossAwardPop:onLoad()
	self._bossRankAward = self._boss:getBossInfoRankAwards()

	self.m_rankRewardList:setNumItems(#self._bossRankAward)

	self._posAward = self._boss:getPosAwardData()

	self.m_posRewardList:setNumItems(#self._posAward)
end

return MysteryBossAwardPop
