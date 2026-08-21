local var_0_0 = class("IslandCheaterTavernCharUnit", import(".IslandSceneUnit"))

function var_0_0.OnAttach(arg_1_0, arg_1_1)
	var_0_0.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0.tf = tf(arg_1_1)
	arg_1_0.seatId = arg_1_0.data.index
	arg_1_0.animator = arg_1_0.tf:GetChild(0):GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:InitDisplayState()

	return
end

function var_0_0.OnPlayerOut(arg_2_0, arg_2_1)
	if arg_2_1 then
		pg.ViewUtils.SetLayer(arg_2_0.tf, Layer.Default)
	end

	arg_2_0.animator:CrossFadeInFixedTime("fallout", 0, 0)
	setActive(arg_2_0.effectGo, true)

	return
end

function var_0_0.OnPlayerQuestion(arg_3_0)
	if arg_3_0.questTimer then
		arg_3_0.questTimer:Stop()
	end

	pg.ViewUtils.SetLayer(arg_3_0.tf, Layer.Default)

	arg_3_0.questTimer = Timer.New(function()
		pg.ViewUtils.SetLayer(arg_3_0.tf, Layer.UIHidden)

		return
	end, IslandCheaterTavernConst.qusanimationTime, 1)

	arg_3_0.questTimer:Start()

	return
end

function var_0_0.OnPlayWinAnimation(arg_5_0)
	if arg_5_0.winTimer then
		arg_5_0.winTimer:Stop()
	end

	pg.ViewUtils.SetLayer(arg_5_0.tf, Layer.Default)

	arg_5_0.winTimer = Timer.New(function()
		pg.ViewUtils.SetLayer(arg_5_0.tf, Layer.UIHidden)

		return
	end, IslandCheaterTavernConst.winAnimationTime, 1)

	arg_5_0.winTimer:Start()

	return
end

function var_0_0.InitDisplayState(arg_7_0)
	local var_7_0 = getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency()

	if not var_7_0:IsConnecting() then
		return
	end

	if IsNil(arg_7_0.tf) then
		return
	end

	local var_7_1 = var_7_0:GetMainPlayer()

	if var_7_1 then
		if arg_7_0.seatId == var_7_1.seat then
			pg.ViewUtils.SetLayer(arg_7_0.tf, Layer.UIHidden)
		else
			pg.ViewUtils.SetLayer(arg_7_0.tf, Layer.Default)
		end
	end

	return
end

function var_0_0.OnDetach(arg_8_0)
	if arg_8_0.questTimer then
		arg_8_0.questTimer:Stop()
	end

	if arg_8_0.winTimer then
		arg_8_0.winTimer:Stop()
	end

	if arg_8_0.effectGo then
		setActive(arg_8_0.effectGo, false)
	end

	return
end

function var_0_0.SetEffect(arg_9_0, arg_9_1)
	arg_9_0.effectGo = arg_9_1

	return
end

return var_0_0
