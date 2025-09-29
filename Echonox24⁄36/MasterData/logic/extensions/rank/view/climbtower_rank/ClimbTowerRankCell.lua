-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/climbtower_rank/ClimbTowerRankCell.lua

module("logic.extensions.rank.view.climbtower_rank.ClimbTowerRankCell", package.seeall)

local M = class("ClimbTowerRankCell", ListBinderCell)

function M:Awake()
	self._text_progress = goutil.findChildTextComponent(self._go, "stateYZAM/layout/txtLevel")
	self._text_round = goutil.findChildTextComponent(self._go, "stateYZAM/layout/other/txtNum1")
	self._text_stepCount = goutil.findChildTextComponent(self._go, "stateYZAM/layout/other/txtNum2")
	self._go_user = goutil.findChild(self._go, "player_ranking_common_item")
	self._go_rankTeam = goutil.findChild(self._go, "stateYZAM/rank_team")
	self._rankUserCell = Astral.LuaComponentContainer.Add(self._go_user, RankUserCell)
	self._rankTeamItem = Astral.LuaComponentContainer.Add(self._go_rankTeam, RankTeamItem)
end

function M:updateData(data)
	if not data then
		return
	end

	self._rankUserCell:updateData(data)
	self._rankTeamItem:updateData(data)

	self._text_progress.text = data:getProgress() or lang("rank_no_ranking")
	self._text_round.text = data:getRound() or RankConfig.noDataShow
	self._text_stepCount.text = data:getStep() or RankConfig.noDataShow
end

return M
