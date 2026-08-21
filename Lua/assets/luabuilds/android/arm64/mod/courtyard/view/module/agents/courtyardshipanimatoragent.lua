local var_0_0 = class("CourtYardShipAnimatorAgent", import(".CourtYardAgent"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = nil

	return
end

function var_0_0.State2AnimationName(arg_2_0, arg_2_1)
	if arg_2_1 == CourtYardShip.STATE_IDLE or arg_2_1 == CourtYardShip.STATE_STOP then
		return "stand2"
	elseif arg_2_1 == CourtYardShip.STATE_MOVE then
		return "walk"
	elseif arg_2_1 == CourtYardShip.STATE_DRAG then
		return "tuozhuai2"
	elseif arg_2_1 == CourtYardShip.STATE_TOUCH then
		return "touch"
	elseif arg_2_1 == CourtYardShip.STATE_GETAWARD then
		return "motou"
	elseif arg_2_1 == CourtYardShip.STATE_INTERACT then
		-- block empty
	end

	return
end

function var_0_0.SetState(arg_3_0, arg_3_1)
	arg_3_0:RemoveAnimFinishTimer()

	local var_3_0 = arg_3_0:State2AnimationName(arg_3_1)

	if not var_3_0 or arg_3_0.name == var_3_0 then
		return
	end

	arg_3_0:PlayAction(var_3_0, function()
		arg_3_0:OnAnimtionFinish(arg_3_1)

		return
	end)

	return
end

function var_0_0.PlayInteractioAnim(arg_5_0, arg_5_1)
	arg_5_0:PlayAction(arg_5_1, function()
		arg_5_0:OnAnimtionFinish(CourtYardShip.STATE_INTERACT)

		return
	end)
	arg_5_0:CheckMissTagAction(arg_5_1)

	return
end

function var_0_0.PlayAction(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:RemoveAnimFinishTimer()
	arg_7_0.spineAnimUI:SetActionCallBack(nil)
	arg_7_0.spineAnimUI:SetActionCallBack(function(arg_8_0)
		if arg_8_0 == "finish" then
			arg_7_0.spineAnimUI:SetActionCallBack(nil)
			arg_7_2()
		end

		return
	end)
	arg_7_0._role:SetAction(arg_7_1)

	arg_7_0.name = arg_7_1

	return
end

function var_0_0.CheckMissTagAction(arg_9_0, arg_9_1)
	local var_9_0 = pg.furniture_specail_action[arg_9_0.data:GetInterActionData():GetOwner().configId]

	if var_9_0 then
		local var_9_1 = _.detect(var_9_0.actions, function(arg_10_0)
			return arg_10_0[1] == arg_9_1
		end)

		if var_9_1 then
			arg_9_0:AddAnimFinishTimer(var_9_1[2])
		end
	end

	return
end

function var_0_0.AddAnimFinishTimer(arg_11_0, arg_11_1)
	arg_11_0.animFinishTimer = Timer.New(function()
		arg_11_0.animFinishTimer:Stop()

		arg_11_0.animFinishTimer = nil

		arg_11_0:OnAnimtionFinish(CourtYardShip.STATE_INTERACT)

		return
	end, arg_11_1, 1)

	arg_11_0.animFinishTimer:Start()

	return
end

function var_0_0.RemoveAnimFinishTimer(arg_13_0)
	if arg_13_0.animFinishTimer then
		arg_13_0.animFinishTimer:Stop()

		arg_13_0.animFinishTimer = nil
	end

	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAnimFinishTimer()
	var_0_0.super.Dispose(arg_14_0)
	arg_14_0.spineAnimUI:SetActionCallBack(nil)

	return
end

return var_0_0
