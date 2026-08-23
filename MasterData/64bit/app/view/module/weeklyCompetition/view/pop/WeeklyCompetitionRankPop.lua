local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionRankPop = class("WeeklyCompetitionRankPop", require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionRankPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/weeklyCompetition/weeklyCompetition",
		resName = "WeeklyCompetitionRankPop",
		pkgName = "weeklyCompetition"
	})
end)

function WeeklyCompetitionRankPop:ctor(arg_2_1)
	self:showAtCenter()

	self._weeklyData = arg_2_1.weeklyData
	self._rankInfo = arg_2_1.rankInfo
	self._rankAwardList = {}

	local var_2_0 = arg_2_1.baseId
	local var_2_1 = g.core.config.rank_award_info.match(function(arg_3_0)
		return arg_3_0.rank_type == WeeklyCompetitionConst.RANK_LOCAL_TYPE and arg_3_0.activity_id == var_2_0
	end)

	table.sort(var_2_1, function(arg_4_0, arg_4_1)
		return arg_4_0.min_rank < arg_4_1.min_rank
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = 1
		local var_2_3 = {}

		while g.core.config.rank_award_info.hasKey("reward_type" .. 1) do
			if iter_2_1["reward_size" .. var_2_2] > 0 then
				var_2_3[#var_2_3 + 1] = {
					type = iter_2_1["reward_type" .. var_2_2],
					value = iter_2_1["reward_value" .. var_2_2],
					size = iter_2_1["reward_size" .. var_2_2]
				}
			end

			var_2_2 = var_2_2 + 1
		end

		for iter_2_2 = iter_2_1.min_rank, math.min(iter_2_1.max_rank, 50) do
			self._rankAwardList[iter_2_2] = var_2_3
		end
	end

	self:_initView()
end

function WeeklyCompetitionRankPop:_initView()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
	self.m_rankList:doFairyBatching(false)
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self:getChild("n33"):setText(self._weeklyData:getScoreIconName())
	self.m_topBarComp:setResInfoById(320)
end

function WeeklyCompetitionRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updatePop), self)
	self:_updatePop()
end

function WeeklyCompetitionRankPop:_updatePop()
	if self._rankInfo.myRank == 0 then
		self.m_isMyRankController:setSelectedIndex(0)
	else
		self.m_isMyRankController:setSelectedIndex(1)
		self.m_rankValueText:setText(self._rankInfo.myRank)
	end

	self.m_rankList:setNumItems(50)
end

function WeeklyCompetitionRankPop:_onRankItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._rankInfo.rankList[arg_8_1 + 1] or {
		rank = arg_8_1 + 1
	}, self._rankAwardList[arg_8_1 + 1], self._weeklyData)
end

return WeeklyCompetitionRankPop
