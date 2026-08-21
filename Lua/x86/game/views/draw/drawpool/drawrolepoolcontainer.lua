local var_0_0 = class("DrawRolePoolContainer", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3

	arg_1_0:CreatePoolGo(arg_1_1)
end

function var_0_0.CreatePoolGo(arg_2_0, arg_2_1)
	if arg_2_0:TryCreateOldRolePoolGo(arg_2_1) then
		return
	end

	arg_2_0:TryCreateNewRolePoolGo(arg_2_1)
end

function var_0_0.TryCreateOldRolePoolGo(arg_3_0, arg_3_1)
	local var_3_0 = Asset.Load("Widget/System/Pool/pool_" .. arg_3_0.showId)

	if not var_3_0 then
		return false
	end

	local var_3_1 = GameObject.Instantiate(var_3_0, arg_3_1)

	arg_3_0.poolView_ = DrawNormalSelectPool.New(var_3_1, arg_3_0.poolId, arg_3_0.showId)

	return true
end

function var_0_0.TryCreateNewRolePoolGo(arg_4_0, arg_4_1)
	local var_4_0 = Asset.Load("Widget/System/Pool/pool_convention_mult")

	if not var_4_0 then
		return false
	end

	local var_4_1 = GameObject.Instantiate(var_4_0, arg_4_1)

	arg_4_0.poolView_ = DrawRolePool.New(var_4_1, arg_4_0.poolId, arg_4_0.showId)

	return true
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.poolView_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	arg_6_0:CallPoolViewFunc("Refresh", arg_6_1)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	arg_7_0:CallPoolViewFunc("SetActive", arg_7_1)
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0:CallPoolViewFunc("UpdateView")
end

function var_0_0.SetVideoTrack(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:CallPoolViewFunc("SetVideoTrack", arg_9_1, arg_9_2)
end

function var_0_0.ShowCountDownText(arg_10_0, arg_10_1)
	arg_10_0:CallPoolViewFunc("ShowCountDownText", arg_10_1)
end

function var_0_0.CirMovieStatusChange(arg_11_0, arg_11_1)
	arg_11_0:CallPoolViewFunc("CirMovieStatusChange", arg_11_1)
end

function var_0_0.SetCountDownText(arg_12_0, arg_12_1)
	arg_12_0:CallPoolViewFunc("SetCountDownText", arg_12_1)
end

function var_0_0.ShowRightPanel(arg_13_0)
	return arg_13_0:CallPoolViewFunc("ShowRightPanel")
end

function var_0_0.GetPoolId(arg_14_0)
	return arg_14_0.poolId
end

function var_0_0.GetShowId(arg_15_0)
	return arg_15_0.showId
end

function var_0_0.CallPoolViewFunc(arg_16_0, arg_16_1, ...)
	if arg_16_0.poolView_ and arg_16_0.poolView_[arg_16_1] then
		return arg_16_0.poolView_[arg_16_1](arg_16_0.poolView_, ...)
	end
end

return var_0_0
