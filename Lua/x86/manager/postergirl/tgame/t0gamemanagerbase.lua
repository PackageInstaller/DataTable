local var_0_0 = class("T0GameManagerBase")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listener = EventListener.New()
end

function var_0_0.BindActorState(arg_2_0, arg_2_1)
	arg_2_0.actorState = arg_2_1
end

function var_0_0.GetBindActor(arg_3_0)
	return nullable(arg_3_0.actorState, "actor")
end

function var_0_0.GetCurMainActor(arg_4_0)
	return nullable(manager.posterGirl, "actor")
end

function var_0_0.GetCurExtraActor(arg_5_0, arg_5_1)
	return nullable(manager.posterGirl, "extraActor", arg_5_1)
end

function var_0_0.DisposeExtraActor(arg_6_0, arg_6_1)
	arg_6_0:GetCurExtraActor(arg_6_1):Dispose()
end

function var_0_0.Init(arg_7_0)
	return
end

function var_0_0.Reset(arg_8_0)
	if arg_8_0.state then
		arg_8_0.state:Exit(arg_8_0)
	end

	arg_8_0.state = nil

	arg_8_0:RemoveAllStateEvents()
end

function var_0_0.RegisterStateEvents(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			arg_9_0.listener:Register(iter_9_0, function(...)
				iter_9_1(arg_9_1, arg_9_0, ...)
			end)
		end
	end
end

function var_0_0.RemoveAllStateEvents(arg_11_0)
	arg_11_0.listener:RemoveAll()
end

function var_0_0.DoAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.actorState == nil then
		return
	end

	if arg_12_3 then
		arg_12_0.actorState:PlayAniNotSkipable(arg_12_1, arg_12_2, arg_12_4)
	else
		arg_12_0.actorState:PlayAni(arg_12_1, arg_12_2, arg_12_4)
	end
end

function var_0_0.DoActionByActor(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if arg_13_0.actorState == nil then
		return
	end

	if arg_13_4 then
		arg_13_0.actorState:PlayAniNotSkipableByActor(arg_13_1, arg_13_2, arg_13_3, arg_13_5)
	else
		arg_13_0.actorState:PlayAniByActor(arg_13_1, arg_13_2, arg_13_3, arg_13_5)
	end
end

function var_0_0.PlayTalk(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.actorState:PlaySpecialTalk(arg_14_1, arg_14_2)
end

function var_0_0.GoToState(arg_15_0, arg_15_1, ...)
	if arg_15_0.state then
		arg_15_0.state:Exit(arg_15_0)
	end

	arg_15_0.state = arg_15_1.New()

	arg_15_0.state:Enter(arg_15_0, ...)
	manager.notify:Invoke("POSTERGIRL_T0_MINIGAME_ENTER_STATE", arg_15_0.state, arg_15_0)
end

function var_0_0.GetStateName(arg_16_0)
	return nullable(arg_16_0.state, "class", "__cname")
end

local function var_0_1(arg_17_0)
	local var_17_0 = arg_17_0:GetViewDirect()

	return var_17_0, var_17_0
end

var_0_0.SwipeToLeft = var_0_1
var_0_0.SwipeToRight = var_0_1

function var_0_0.GetViewDirect(arg_18_0)
	return arg_18_0:GetCurMainActor():GetViewDirect()
end

function var_0_0.ZoomToCamera(arg_19_0, arg_19_1)
	return PosterTzeroPlusActor.DefaultZoomToCameraImpl(arg_19_0:GetCurMainActor(), arg_19_1, 1, 0)
end

function var_0_0.StartGameImpl(arg_20_0)
	local var_20_0 = manager.posterGirl.actor
	local var_20_1 = arg_20_0.New()

	var_20_0:ChangeState({
		class = T0PosterGameTimelineState,
		args = {
			gameInst = var_20_1
		}
	})
	var_20_1:Init()
end

return var_0_0
