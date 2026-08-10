local var_0_0 = import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")
local var_0_1 = class("AutoChessTimelineRenderController", var_0_0)

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.playableDirector = nil
	arg_1_0.playableAsset = nil
	arg_1_0.timelineFinishHandler = handler(arg_1_0, arg_1_0.OnTimelineFinish)
end

function var_0_1.InitPlayable(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.playableDirector = arg_2_1
	arg_2_0.playableAsset = arg_2_2
end

function var_0_1.OnPlay(arg_3_0)
	arg_3_0.playableDirector.enabled = true
	arg_3_0.playableDirector.stopped = arg_3_0.playableDirector.stopped - arg_3_0.timelineFinishHandler

	arg_3_0.playableDirector:Play(arg_3_0.playableAsset)

	arg_3_0.playableDirector.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
	arg_3_0.playableDirector.time = 0
	arg_3_0.playableDirector.stopped = arg_3_0.playableDirector.stopped + arg_3_0.timelineFinishHandler

	LuaForUtil.SetTimelineSpeed(arg_3_0.playableDirector, arg_3_0.speed)
end

function var_0_1.Reset(arg_4_0)
	var_0_1.super.Reset(arg_4_0)

	if arg_4_0.playableDirector then
		arg_4_0.playableDirector.stopped = arg_4_0.playableDirector.stopped - arg_4_0.timelineFinishHandler
		arg_4_0.playableDirector = nil
		arg_4_0.playableAsset = nil
	end
end

function var_0_1.OnPause(arg_5_0)
	if arg_5_0.playableDirector then
		LuaForUtil.SetTimelineSpeed(arg_5_0.playableDirector, 0)
	end
end

function var_0_1.OnResume(arg_6_0)
	if arg_6_0.playableDirector then
		LuaForUtil.SetTimelineSpeed(arg_6_0.playableDirector, arg_6_0.speed)
	end
end

function var_0_1.OnSpeedChange(arg_7_0)
	if arg_7_0.playableDirector then
		LuaForUtil.SetTimelineSpeed(arg_7_0.playableDirector, arg_7_0.speed)
	end
end

function var_0_1.OnTimelineFinish(arg_8_0)
	arg_8_0:Finish()
end

return var_0_1
