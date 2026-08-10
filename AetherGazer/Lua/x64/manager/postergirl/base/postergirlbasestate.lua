local var_0_0 = class("PosterGirlBaseState")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.actor = arg_1_1
	arg_1_0.state_key = nil
end

function var_0_0.GetHeroTimelineMgr(arg_2_0)
	return arg_2_0.actor:GetHeroTimelineMgr()
end

function var_0_0.Enter(arg_3_0)
	return
end

function var_0_0.Update(arg_4_0)
	return
end

function var_0_0.Exit(arg_5_0, arg_5_1)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:Exit(true)
end

function var_0_0.SetStateKey(arg_7_0, arg_7_1)
	arg_7_0.state_key = arg_7_1
end

function var_0_0.GetStateKey(arg_8_0)
	return arg_8_0.state_key
end

function var_0_0.CanPlayNextAni(arg_9_0)
	return false
end

function var_0_0.AcceptTouch(arg_10_0)
	return false
end

function var_0_0.PlaySpecialTalk(arg_11_0, arg_11_1, arg_11_2)
	return
end

return var_0_0
