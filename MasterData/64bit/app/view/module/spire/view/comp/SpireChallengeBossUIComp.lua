local SpireChallengeBossUIComp = class("SpireChallengeBossUIComp", require("app.fairyGUI.spire.UI_SpireChallengeBossUIComp"))

function SpireChallengeBossUIComp:ctor()
	self._bossStage = nil
	self._bossTitleSpine = nil

	self:_initComp()
end

function SpireChallengeBossUIComp:_initComp()
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClicked))
	self.m_helpBtn:addClickListener(handler(self, self._onHelpBtnClicked))
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderAwardItem))
	self.m_buffList:setVirtual(self)
	self.m_buffList:setItemRenderer(handler(self, self._onRenderBuffItem))
	self.m_buffList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onBuffListClickItem))
end

function SpireChallengeBossUIComp:_onRenderAwardItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rankAwards[arg_3_1 + 1])
end

function SpireChallengeBossUIComp:_onRenderBuffItem(arg_4_1, arg_4_2)
	arg_4_2:updateBuffItem(self._bossStage:getBossBuffList()[arg_4_1 + 1], self._bossStage:getMaxRate(), arg_4_1 + 1)
end

function SpireChallengeBossUIComp:_onBuffListClickItem()
	local var_5_0 = self._bossStage:getBossBuffList()[self.m_buffList:getSelectedIndex() + 1]
	local var_5_1 = var_5_0.cfg

	if self._bossStage:getMaxRate() >= var_5_0.cfg.unlock then
		self:_toSetBuffEnable(var_5_0.cfg.id, not var_5_0.isSelect)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432022, {
			rate = var_5_1.unlock
		}))
	end
end

function SpireChallengeBossUIComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSBUFF, handler(self, self._updateBuffPanel), self)
end

function SpireChallengeBossUIComp:updateUI(arg_7_1)
	self._bossStage = arg_7_1:getBossStage()

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs((self._bossStage:getBuffInfoList())) do
		local var_7_1, var_7_2 = g.core.utils.String.formatPassiveSkillDesc(iter_7_1.buff)

		var_7_0[#var_7_0 + 1] = g.core.lang:get(432023, {
			index = iter_7_0,
			des = var_7_1
		})
	end

	if #var_7_0 == 0 then
		self.m_tipComp:setVisible(false)
	else
		self.m_tipComp:updateTip(table.concat(var_7_0, "\n"))
		self.m_tipComp:setVisible(true)
	end

	self.m_nameTxt:setText(self._bossStage:getCfg().name)
	self.m_scoreTxt:setText(self._bossStage:getMaxScore())

	local var_7_3 = self._bossStage:getRank()

	if var_7_3 == 0 then
		self.m_rankTxt:setText(g.core.lang:get(304610))
	else
		self.m_rankTxt:setText(var_7_3)
	end

	self._rankAwards = g.core.model.User.spireData:getRankAwardByRank(var_7_3)

	if #self._rankAwards > 0 then
		self.m_rewardList:setNumItems(#self._rankAwards)
		self.m_hasRankRwdController:setSelectedIndex(1)
	else
		self.m_hasRankRwdController:setSelectedIndex(0)
	end

	self:_updateBuffPanel()

	if not self._bossTitleSpine then
		self:_initBossEff()
	end
end

function SpireChallengeBossUIComp:_updateBuffPanel()
	self.m_scoreRatioTxt:setText(g.core.lang:get(432004, {
		ratio = self._bossStage:getBuffRatio()
	}))
	self.m_buffList:setNumItems(#self._bossStage:getBossBuffList())
end

function SpireChallengeBossUIComp:_toSetBuffEnable(arg_9_1, arg_9_2)
	g.core.network.GameNetProxy:send_C2S_Spire_BossBuff({
		set = arg_9_2,
		id = arg_9_1
	})
end

function SpireChallengeBossUIComp:_onHelpBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_BOSS_DETAIL_POP, self._bossStage)
end

function SpireChallengeBossUIComp:_onRankBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_RANK_LAYER)
end

function SpireChallengeBossUIComp:_initBossEff()
	self._bossTitleSpine = self.m_iconEffNode:addEffectSpine({
		anim = "icon",
		isLoop = true,
		name = "eff_ui_spire_bosstitle"
	})
end

return SpireChallengeBossUIComp
