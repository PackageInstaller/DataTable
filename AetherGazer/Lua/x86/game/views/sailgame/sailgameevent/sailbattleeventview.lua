local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailBattleEventView", var_0_0)

function var_0_1.AcceptEvent(arg_1_0)
	local var_1_0 = SailGameEventCfg[arg_1_0.eventID_].stage_id

	arg_1_0:Go("/sectionSelectHero", {
		section = var_1_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.SAIL_GAME,
		activityID = arg_1_0.activityID_,
		customBarList = {
			BACK_BAR
		}
	})
end

function var_0_1.RefreshReward(arg_2_0)
	local var_2_0 = SailGameEventCfg[arg_2_0.eventID_].stage_id
	local var_2_1 = BattleSailGameStageCfg[var_2_0].drop_lib_id
	local var_2_2 = getRewardFromDropCfg(var_2_1, true)[1]

	arg_2_0.rewardIcon_.sprite = ItemTools.getItemSprite(var_2_2.id)
	arg_2_0.rewardNumText_.text = var_2_2.num
end

return var_0_1
