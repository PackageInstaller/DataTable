local var_0_0 = g.core.model.User.towerData
local var_0_1 = g.core.config.massive_monster_team_info
local var_0_2 = g.core.event.enum
local BattleConst = require("app.view.battle.const.BattleConst")
local MulTeamTowerSubScript = class("MulTeamTowerSubScript")

function MulTeamTowerSubScript:getSubEventList()
	return {
		[var_0_2.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN] = handler(self, self.onTowerChallengeBegin)
	}
end

function MulTeamTowerSubScript:getIsOpen()
	return (var_0_0:getSubTowerIsOpen(self:getCustomData().stageInfo.stage_type))
end

function MulTeamTowerSubScript:getRecommendValue()
	return var_0_1.get((var_0_0:getSwitchMonsterTeamId(self:getCustomData().stageInfo.monster_team_id))).fight or 0
end

function MulTeamTowerSubScript:startChallengeStage()
	g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
		play_type = 3,
		id = self:getCustomData().stageInfo.id
	})
end

function MulTeamTowerSubScript:onTowerChallengeBegin(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		bgId = 126,
		cloudLoading = true,
		type = BattleConst.TYPE_TOWER,
		battle_id = arg_5_4.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
	self:dispatchCompEvent("MulTeamLayer_pop")
end

return MulTeamTowerSubScript
