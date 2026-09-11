GotoSystemBase = import("game.qworld.go.gotoSystemImpl.GotoSystemBase")

local GotoWarfare = class("GotoWarfare", GotoSystemBase)

function GotoWarfare:CustomEnable()
	return true
end

function GotoWarfare:OnEnter(arg_2_1, arg_2_2, arg_2_3)
	SeaWarfareTools.SetCacheTagId(arg_2_3)

	if arg_2_2[1] then
		JumpTools.OpenPageByJump("/seaWarfareNormalStageInfo", {
			stageType = BattleConst.STAGE_TYPE_NEW.SEA_WARFARE,
			stageID = SeaWarfareStageCfg[arg_2_2[1]].stage_id,
			seaWarfareStageID = arg_2_2[1],
			cameraParams = self:GetCameraParams()
		})
	else
		SeaWarfareTools.GotoChallengeStage()
	end
end

return GotoWarfare
