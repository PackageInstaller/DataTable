local var_0_0 = class("ChallengeRogueTeamMapTimelineView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.parent_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.playableDirector_ = arg_1_0.gameObject_:GetComponent(typeof(PlayableDirector))
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:AddMoveFollowTimer()
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopMoveFollowTimer()
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddMoveFollowTimer(arg_5_0)
	arg_5_0:Play()

	arg_5_0.moveFollowTimer_ = FrameTimer.New(function()
		arg_5_0:Play()
	end, 1, -1)

	arg_5_0.moveFollowTimer_:Start()
end

function var_0_0.Play(arg_7_0)
	local var_7_0 = -1 * arg_7_0.parent_.contentRect_.localPosition.x / arg_7_0.parent_.contentRect_.rect.width

	if var_7_0 < 0 then
		var_7_0 = 0
	elseif var_7_0 > 1 then
		var_7_0 = 1
	end

	arg_7_0.playableDirector_.time = arg_7_0.playableDirector_.duration * var_7_0

	arg_7_0.playableDirector_:Evaluate()
end

function var_0_0.StopMoveFollowTimer(arg_8_0)
	if arg_8_0.moveFollowTimer_ then
		arg_8_0.moveFollowTimer_:Stop()

		arg_8_0.moveFollowTimer_ = nil
	end
end

return var_0_0
