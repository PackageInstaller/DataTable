GotoSystemBase = import("game.qworld.go.gotoSystemImpl.GotoSystemBase")

local var_0_0 = class("GotoWarfare", GotoSystemBase)

function var_0_0.CustomEnable(arg_1_0)
	return true
end

function var_0_0.OnEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	SeaWarfareTools.SetCacheTagId(arg_2_3)

	local var_2_0 = arg_2_2[1]

	if var_2_0 then
		local var_2_1 = SeaWarfareStageCfg[var_2_0].stage_id

		JumpTools.OpenPageByJump("/seaWarfareNormalStageInfo", {
			stageType = BattleConst.STAGE_TYPE_NEW.SEA_WARFARE,
			stageID = var_2_1,
			seaWarfareStageID = var_2_0,
			cameraParams = arg_2_0:GetCameraParams()
		})
	else
		SeaWarfareTools.GotoChallengeStage()
	end
end

return var_0_0
