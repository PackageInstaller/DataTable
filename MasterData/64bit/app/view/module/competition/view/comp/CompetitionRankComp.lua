local var_0_0 = g.core.config.competition_info
local var_0_1 = g.core.model.User.competitionData
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.const.ConstMgr.CompetitionConst
local CompetitionRankComp = class("CompetitionRankComp", require("app.fairyGUI.competition.UI_CompetitionRankComp"))

function CompetitionRankComp:ctor()
	self._rankList = {}
	self._specifyRanks = {}
	self._cdScheduler = nil

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_rankAwardList:setVirtual()
	self.m_rankAwardList:setItemRenderer(handler(self, self._onRankAwardListRenderer))
	self.m_goScoreArea:addClickListener(handler(self, self._onClickGoScoreArea))
end

function CompetitionRankComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvGetCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = g.core.network.proto.HANDBOOK_COMPETITION,
		size = var_0_4.RANK_SIZE,
		specify_ranks = var_0_1:getSpecialRankIdx()
	})
end

function CompetitionRankComp:updateRankComp()
	local var_3_0 = var_0_0.get(var_0_1:getCompetitionActId())

	if var_3_0.rank_reward_type == var_0_2.TYPE_UNITETOKEN then
		self.m_rankRewardIcon:setIcon((g.core.common.Path:getUniteTokenCardImg(var_3_0.rank_reward_value)))
		self.m_detailBtn:initBtnInfo({
			type = var_3_0.rank_reward_type,
			value = var_3_0.rank_reward_value
		})
	end

	self._rankAward = var_0_1:getRankAwardList()

	self.m_rankAwardList:setNumItems(#self._rankAward)
	self.m_curScoreTxt:setText(g.core.lang:get(409751, {
		score = g.core.model.User.handBookData:getTotalKnightBookScore()
	}))
	self:_refreshCountDown()

	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._refreshCountDown), 60)
end

function CompetitionRankComp:_onRcvGetCommonRank(arg_4_1, arg_4_2, arg_4_3)
	self._selfRank = arg_4_3.self_rank or 0
	self._rankList = arg_4_3.rank_units or {}

	if arg_4_3.specify_rank_units then
		for iter_4_0, iter_4_1 in ipairs(arg_4_3.specify_rank_units) do
			table.insert(self._rankList, iter_4_1)
		end
	end

	self:updateRankList()
	self.m_switchTransition:play()
end

function CompetitionRankComp:updateRankList()
	self.m_rankList:setNumItems(#self._rankList)

	if self._selfRank == 0 then
		self.m_selfRankTxt:setText(g.core.lang:get(409700))
	else
		self.m_selfRankTxt:setText(g.core.lang:get(409701, {
			rank = self._selfRank
		}))

		if self._selfRank <= var_0_4.RANK_SIZE then
			self.m_rankList:scrollToView(self._selfRank - 1)
		end
	end
end

function CompetitionRankComp:_refreshCountDown()
	local var_6_0 = var_0_1:getRankShowFinishTime()

	if var_0_3:getTime() <= var_6_0 then
		local var_6_1, var_6_2, var_6_3, var_6_4 = var_0_3:getLeftTimeParts(var_6_0)

		if var_6_3 > 0 or var_6_4 > 0 then
			var_6_2 = var_6_2 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409702, {
			day = var_6_1,
			hour = var_6_2
		}))
	else
		self.m_activityTimeTxt:setText(g.core.lang:get(409704))
	end
end

function CompetitionRankComp:_onRankListRenderer(arg_7_1, arg_7_2)
	if self._rankList[arg_7_1 + 1] then
		arg_7_2:updateCell(self._rankList[arg_7_1 + 1])
	end
end

function CompetitionRankComp:_onRankAwardListRenderer(arg_8_1, arg_8_2)
	if self._rankAward[arg_8_1 + 1] then
		arg_8_2:updateCell(self._rankAward[arg_8_1 + 1])
	end
end

function CompetitionRankComp:_onClickGoScoreArea()
	g.view.entrance.ModuleGotoProxy:gotoModule(62)
end

return CompetitionRankComp
