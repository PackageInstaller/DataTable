local var_0_0 = g.core.model.User.guildBossData
local var_0_1 = g.core.const.ConstMgr.GuildBossConst
local var_0_2 = g.core.common.ServerTime
local GuildBossPreRankComp = class("GuildBossPreRankComp", require("app.fairyGUI.guildBoss.UI_GuildBossPreRankComp"))

function GuildBossPreRankComp:ctor()
	self._curTabIndex = 0
	self._awardData = {}
	self._personRankData = {}
	self._guildRankData = {}
	self._personSelfData = {
		score = 0,
		rank = 0
	}
	self._guildSelfData = {
		score = 0,
		rank = 0
	}
	self._bossInfo = var_0_0:getTodayBossInfo()

	self:_initUI()
end

function GuildBossPreRankComp:_initUI()
	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRank))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAward))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeState))
	self.m_rankBtn:addClickListener(handler(self, self._onPopRank))
end

function GuildBossPreRankComp:_onRenderRank(arg_3_1, arg_3_2)
	if self._curTabIndex == 0 then
		arg_3_2:updateGuildCell({
			widthIdx = 0,
			rankData = self._guildRankData[arg_3_1 + 1],
			bossInfo = self._bossInfo
		})
	else
		arg_3_2:updatePersonCell({
			widthIdx = 0,
			rankData = self._personRankData[arg_3_1 + 1],
			bossInfo = self._bossInfo
		})
	end
end

function GuildBossPreRankComp:_onRenderAward(arg_4_1, arg_4_2)
	if self._awardData[arg_4_1 + 1] then
		arg_4_2:updateIcon({
			type = self._awardData[arg_4_1 + 1].type,
			value = self._awardData[arg_4_1 + 1].value
		})
	end
end

function GuildBossPreRankComp:_onChangeState()
	self._curTabIndex = self.m_tabController:getSelectedIndex()

	if self._curTabIndex == 0 then
		self.m_rankList:setNumItems(#self._guildRankData)
		self.m_rankList:transitionShowCells("enter_right", 0.03)
	else
		self.m_rankList:setNumItems(#self._personRankData)
		self.m_rankList:transitionShowCells("enter_right", 0.03)
	end

	self:updateMyRank()
end

function GuildBossPreRankComp:onUpdateRank()
	self:_onChangeState()
end

function GuildBossPreRankComp:_onPopRank()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildBoss.view.GuildBossRankAwardPop").new({
		bossInfo = self._bossInfo
	}))
end

function GuildBossPreRankComp:updateBossName(arg_8_1)
	self.m_styleController:setSelectedIndex(arg_8_1.type == var_0_1.TYPE_CROSS_SERVER and 1 or 0)
	self.m_bossNameTxt:setText(g.core.config.knight_base_info.get(arg_8_1.show_model).name)
	self.m_timeTxt:setText(var_0_2:secondToHMString(arg_8_1.start_time) .. "-" .. var_0_2:secondToHMString(arg_8_1.end_time))
end

function GuildBossPreRankComp:updateCountDown()
	local var_9_0 = var_0_2:secondsFromToday()
	local var_9_1 = self._bossInfo.end_time
	local var_9_2 = 100

	if self._bossInfo.start_time <= var_9_0 and var_9_0 <= var_9_1 then
		local var_9_3 = math.floor((var_9_0 - self._bossInfo.start_time) / 5)
		local var_9_4 = math.floor((var_9_1 - self._bossInfo.start_time) / 10)

		var_9_2 = var_9_3 <= var_9_4 and 100 - self._bossInfo.boss_hp / var_9_4 * var_9_3 or 100 - self._bossInfo.boss_hp - (100 - self._bossInfo.boss_hp) / var_9_4 * (var_9_3 - var_9_4)
	elseif var_9_1 < var_9_0 then
		var_9_2 = 0
	elseif var_9_0 < self._bossInfo.start_time then
		var_9_2 = 100
	end

	self.m_progBar:setPercent({
		max = 100,
		cur = var_9_2
	})
	self.m_timeTxt:setText(var_0_2:secondToHMSString((math.max(0, var_9_1 - var_9_0))))
end

function GuildBossPreRankComp:updateAwardList()
	if self.m_stateController:getSelectedIndex() ~= 2 then
		self.m_hasAwardController:setSelectedIndex(1)

		self._awardData = var_0_0:getAuctionAwards()

		self.m_awardList:setNumItems(#self._awardData)
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	else
		self.m_hasAwardController:setSelectedIndex(0)
	end
end

function GuildBossPreRankComp:updateRankData(arg_11_1, arg_11_2)
	if not arg_11_1.rank_units then
		self.m_hasRankController:setSelectedIndex(0)

		return
	else
		self.m_hasRankController:setSelectedIndex(1)
	end

	self._bossInfo = arg_11_2

	local var_11_0 = arg_11_1.id
	local var_11_1 = false
	local var_11_2 = g.core.network.proto

	if arg_11_1.id == g.core.network.proto.GUILD_BOSS_USER_LOCAL or var_11_0 == var_11_2.GUILD_BOSS_USER_CROSS then
		self._personRankData = arg_11_1.rank_units or {}

		if self._curTabIndex == 1 then
			self.m_rankList:setNumItems(#self._personRankData)

			var_11_1 = true
		end
	elseif var_11_0 == var_11_2.GUILD_BOSS_GUILD_LOCAL or var_11_0 == var_11_2.GUILD_BOSS_GUILD_CROSS then
		self._guildRankData = arg_11_1.rank_units or {}

		if self._curTabIndex == 0 then
			self.m_rankList:setNumItems(#self._guildRankData)

			var_11_1 = true
		end
	end

	local var_11_3 = {
		name = "",
		score = 0,
		rank = arg_11_1.self_rank
	}
	local var_11_4 = false

	if arg_11_1.self_rank > 0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.rank_units) do
			if iter_11_1.rank == arg_11_1.self_rank then
				var_11_4 = true
				var_11_3.score = iter_11_1.score

				break
			end
		end
	end

	if var_11_0 == var_11_2.GUILD_BOSS_USER_LOCAL or var_11_0 == var_11_2.GUILD_BOSS_USER_CROSS then
		if not var_11_4 then
			var_11_3.score = var_0_0:getUserScore()
		end

		var_11_3.name = g.core.model.User:getName()
		self._personSelfData = var_11_3
	else
		if not var_11_4 then
			var_11_3.score = var_0_0:getGuildScore()
		end

		var_11_3.name = g.core.model.User:getGuildName()
		self._guildSelfData = var_11_3
	end

	if var_11_1 then
		self:updateMyRank()
	end
end

function GuildBossPreRankComp:updateMyRank()
	if self.m_hasRankController:getSelectedIndex() == 0 then
		return
	end

	local var_12_0

	if self._curTabIndex == 1 then
		var_12_0 = self._personSelfData or self._guildSelfData
	end

	self.m_nameTxt:setText(var_12_0.name)

	if var_12_0.rank <= 0 then
		self.m_rankTxt:setText(g.core.lang:get(306508))
	else
		self.m_rankTxt:setText(var_12_0.rank)
	end

	self.m_scoreTxt:setText(var_12_0.score)
end

return GuildBossPreRankComp
