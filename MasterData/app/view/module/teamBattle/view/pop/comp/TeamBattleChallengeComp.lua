local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_3 = g.core.config.team_battle_parameter_info
local var_0_4 = g.core.common.Path
local TeamBattleChallengeComp = class("TeamBattleChallengeComp", require("app.fairyGUI.teamBattle.UI_TeamBattleChallengeComp"))

function TeamBattleChallengeComp:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onEnemyItemRender))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
end

function TeamBattleChallengeComp:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function TeamBattleChallengeComp:_onEnemyItemRender(arg_3_1, arg_3_2)
	arg_3_2:updatEnemyIcon({
		id = self._enemyIdList[arg_3_1 + 1],
		hp = self._hpList[arg_3_1 + 1]
	})
end

function TeamBattleChallengeComp:updateChallengeComp(arg_4_1)
	self._enemyIdList = arg_4_1.enemyIdList
	self._hpList = arg_4_1.hpList

	local var_4_0 = arg_4_1.battleMonsterInfo

	self._awards = g.core.common.Drops:getGoodsArray(arg_4_1.battleMonsterInfo.reward)

	self.m_awardList:setNumItems(#self._awards)

	local var_4_1 = arg_4_1.teamInfo
	local var_4_2 = g.core.model.User.teamBattleData:getMapData():getLeftPoint()
	local var_4_3 = var_0_3.get(TeamBattleConst.PARAMETER_ID.CHALLENGE_COST_ID).parameter

	self._isEnough = var_4_3 <= var_4_2

	self.m_costTxt:setText(var_4_3)
	self.m_costLoader:setURL(g.core.common.Path:getTeamBattleIcon(93))
	self.m_costTxt:setColor((self._isEnough or nil) and (g.core.common.Color.A5 or g.core.common.Color.A4))
	self.m_fightValueText:setText(var_4_1.fight)
	self.m_enemyList:setNumItems(#self._enemyIdList)
	self.m_diffLoader:setURL(var_0_4:getTeamBattleDiffIcon(var_4_0.Grade))
	self.m_isShowDiffController:setSelectedIndex(var_4_0.Grade <= TeamBattleConst.TEAM_DIFF_LEVEL and 1 or 0)
end

function TeamBattleChallengeComp:_onClickBattleBtn()
	if not self._isEnough then
		g.core.module.ModuleManager:tip(g.core.lang:get(427148))

		return
	end

	self:dispatchCompEvent("TEAM_BATTLE_CHALLENGE")
end

return TeamBattleChallengeComp
