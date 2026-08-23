local RankAward = require("app.core.common.RankAward")
local TeamBattleRankLayer = class("TeamBattleRankLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleRankLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleRankLayer",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	})
end)

function TeamBattleRankLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onTeamBattleRankRenderer))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onTeamBattleAwardRenderer))

	self._awardArr = RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.TEAM_BATTLE, g.core.model.User.teamBattleData:getActivityId())

	self.m_rewardList:setNumItems(#self._awardArr)
end

function TeamBattleRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMRANK, handler(self, self._onGetTeamBattleRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateTeamBattleRankUser), self)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamRank({})
end

function TeamBattleRankLayer:_onGetTeamBattleRank(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._list = arg_4_4.list or {}
	self._ownRank = arg_4_4.own_rank or 0
	self._ownScore = arg_4_4.own_score or 0

	self.m_rankList:setNumItems(#self._list)

	local var_4_0 = 427104
	local var_4_1 = {}

	if self._ownRank > 0 then
		var_4_1.rankTxt = self._ownRank or g.core.lang:get(113014)
	end

	self.m_rankTxt:setText(g.core.lang:get(var_4_0, var_4_1))
	self.m_scoreNumTxt:setText(g.core.lang:get(427105, {
		score = self._ownScore
	}))

	if #self._list == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function TeamBattleRankLayer:_updateTeamBattleRankUser()
	if self._list and next(self._list) then
		self.m_rankList:setNumItems(#self._list)
	end
end

function TeamBattleRankLayer:_onTeamBattleRankRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateBattleRankCell(self._list[arg_6_1 + 1], arg_6_1 + 1)
end

function TeamBattleRankLayer:_onTeamBattleAwardRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._awardArr[arg_7_1 + 1], arg_7_1 + 1)
end

return TeamBattleRankLayer
