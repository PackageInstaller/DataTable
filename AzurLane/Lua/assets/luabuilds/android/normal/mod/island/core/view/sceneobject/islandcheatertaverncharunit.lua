class = var_0_10000

local var_0_0 = "IslandCheaterTavernCharUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSceneUnit"))

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	var_0_1.super.OnAttach(arg_1_0, arg_1_1)

	tf = var_2
	arg_1_0.tf = var_2(arg_1_1)
	arg_1_0.seatId = arg_1_0.data.index

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.GetChild(var_1_0, 0)
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	UnityEngine = var_1_10005
	arg_1_0.animator = var_1_2(var_1_1, var_4(var_1_10005.Animator))

	arg_1_0:InitDisplayState()

	return
end

function var_0_1.OnPlayerOut(arg_2_0, arg_2_1)
	if arg_2_1 then
		pg = var_1_10002

		local var_2_0 = var_1_10002.ViewUtils.SetLayer
		local var_2_1 = arg_2_0.tf

		Layer = var_1_10004

		var_2_0(var_2_1, var_1_10004.Default)
	end

	local var_2_2 = arg_2_0.animator

	var_2.CrossFadeInFixedTime(var_2_2, "fallout", 0, 0)

	setActive = var_2

	var_2(arg_2_0.effectGo, true)

	return
end

function var_0_1.OnPlayerQuestion(arg_3_0)
	if arg_3_0.questTimer then
		local var_3_0 = arg_3_0.questTimer

		var_1.Stop(var_3_0)
	end

	pg = var_1

	local var_3_1 = var_1.ViewUtils.SetLayer
	local var_3_2 = arg_3_0.tf

	Layer = var_1_10003

	var_3_1(var_3_2, var_1_10003.Default)

	Timer = var_3_1

	local var_3_3 = var_3_1.New

	local function var_3_4()
		pg = var_2_10000

		local var_4_0 = var_2_10000.ViewUtils.SetLayer
		local var_4_1 = arg_3_0.tf

		Layer = var_2_10002

		var_4_0(var_4_1, var_2_10002.UIHidden)

		return
	end

	IslandCheaterTavernConst = var_3
	arg_3_0.questTimer = var_3_3(var_3_4, var_3.qusanimationTime, 1)

	local var_3_5 = arg_3_0.questTimer

	var_1.Start(var_3_5)

	return
end

function var_0_1.OnPlayWinAnimation(arg_5_0)
	if arg_5_0.winTimer then
		local var_5_0 = arg_5_0.winTimer

		var_1.Stop(var_5_0)
	end

	pg = var_1

	local var_5_1 = var_1.ViewUtils.SetLayer
	local var_5_2 = arg_5_0.tf

	Layer = var_1_10003

	var_5_1(var_5_2, var_1_10003.Default)

	Timer = var_5_1

	local var_5_3 = var_5_1.New

	local function var_5_4()
		pg = var_2_10000

		local var_6_0 = var_2_10000.ViewUtils.SetLayer
		local var_6_1 = arg_5_0.tf

		Layer = var_2_10002

		var_6_0(var_6_1, var_2_10002.UIHidden)

		return
	end

	IslandCheaterTavernConst = var_3
	arg_5_0.winTimer = var_5_3(var_5_4, var_3.winAnimationTime, 1)

	local var_5_5 = arg_5_0.winTimer

	var_1.Start(var_5_5)

	return
end

function var_0_1.InitDisplayState(arg_7_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.GetIsland(var_7_0)
	local var_7_2 = var_1.GetCheaterTavernAgency(var_7_1)

	if not var_1.IsConnecting(var_7_2) then
		return
	end

	IsNil = var_2

	if var_2(arg_7_0.tf) then
		return
	end

	if var_1:GetMainPlayer() then
		local var_7_3

		if arg_7_0.seatId == var_2.seat then
			pg = var_7_3
			var_7_3 = var_7_3.ViewUtils.SetLayer

			local var_7_4 = arg_7_0.tf

			Layer = var_1_10005

			var_7_3(var_7_4, var_1_10005.UIHidden)
		else
			pg = var_7_3

			local var_7_5 = var_7_3.ViewUtils.SetLayer
			local var_7_6 = arg_7_0.tf

			Layer = var_1_10005

			var_7_5(var_7_6, var_1_10005.Default)
		end
	end

	return
end

function var_0_1.OnDetach(arg_8_0)
	if arg_8_0.questTimer then
		local var_8_0 = arg_8_0.questTimer

		var_1.Stop(var_8_0)
	end

	if arg_8_0.winTimer then
		local var_8_1 = arg_8_0.winTimer

		var_1.Stop(var_8_1)
	end

	if arg_8_0.effectGo then
		setActive = var_1

		var_1(arg_8_0.effectGo, false)
	end

	return
end

function var_0_1.SetEffect(arg_9_0, arg_9_1)
	arg_9_0.effectGo = arg_9_1

	return
end

return var_0_1
