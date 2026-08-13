class = var_0_10000

local var_0_0 = var_0_10000("DreamlandSpinePlayer")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.holdSpinePlayRecorder = {}
	arg_1_0.effects = {}
	arg_1_0.timers = {}
	arg_1_0.isPlayEffect = {}

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.root = arg_2_1
	arg_2_0.spineAnimUIList = arg_2_3

	local var_2_0 = arg_2_3[arg_2_2.name]
	local var_2_1 = arg_2_4.type

	DreamlandData = var_1_10007

	if var_2_1 == var_1_10007.EXPLORE_TYPE_HOLD then
		local var_2_2 = arg_2_0.holdSpinePlayRecorder[arg_2_2.name]

		arg_2_0:PlayInterActionAnimHold(arg_2_4.sub_type, var_2_0, var_2_2, arg_2_2)

		local var_2_3 = arg_2_0.holdSpinePlayRecorder
		local var_2_4 = arg_2_2.name

		defaultValue = var_9
		var_2_3[var_2_4] = not var_9(var_2_2, false)
	else
		arg_2_0:PlayInterActionAnimOnce(arg_2_4.sub_type, var_2_0, arg_2_2)
	end

	return
end

function var_0_0.PlayInterActionAnimHold(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_1[1]

	if arg_3_3 then
		DreamlandUtil = var_1_10006
		var_1_10006 = var_1_10006.GetSpineNormalAction(var_3_0)

		arg_3_2:SetAction(var_1_10006, 0)

		DreamlandData = var_7

		if var_3_0 == var_7.EXPLORE_SUBTYPE_EFFECT then
			arg_3_0:RemoveEffect(arg_3_1[2])
		end

		DreamlandData = var_7

		if var_3_0 == var_7.EXPLORE_SUBTYPE_UNION and arg_3_0.spineAnimUIList[arg_3_1[2]] then
			var_7:SetAction(var_1_10006, 0)
		end
	else
		DreamlandData = var_1_10006

		if var_3_0 == var_1_10006.EXPLORE_SUBTYPE_3SEC then
			arg_3_0:PlayAction(arg_3_2, "action", "normal2")
		else
			DreamlandData = var_6

			if var_3_0 == var_6.EXPLORE_SUBTYPE_EFFECT then
				arg_3_0:PlayerEffect(-1, arg_3_1[2])
			else
				DreamlandUtil = var_6

				local var_3_1 = var_6.GetSpineInterAction(var_3_0)

				arg_3_2:SetAction(var_3_1, 0)

				DreamlandData = var_7

				if var_3_0 == var_7.EXPLORE_SUBTYPE_UNION and arg_3_0.spineAnimUIList[arg_3_1[2]] then
					var_7:SetAction(var_3_1, 0)
				end
			end
		end
	end

	return
end

function var_0_0.PlayInterActionAnimOnce(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1[1]

	DreamlandData = var_1_10005

	if var_4_0 == var_1_10005.EXPLORE_SUBTYPE_EFFECT then
		arg_4_0:PlayerEffect(arg_4_1[3], arg_4_1[2])
	else
		DreamlandUtil = var_5

		local var_4_1 = var_5.GetSpineInterAction(var_4_0)

		DreamlandUtil = var_6

		local var_4_2 = var_6.GetSpineNormalAction(var_4_0)

		arg_4_0:PlayAction(arg_4_2, var_4_1, var_4_2)

		DreamlandData = var_7

		if var_4_0 == var_7.EXPLORE_SUBTYPE_UNION and arg_4_0.spineAnimUIList[arg_4_1[2]] then
			arg_4_0:PlayAction(var_7, var_4_1, var_4_2)
		end
	end

	return
end

function var_0_0.PlayerEffect(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.isPlayEffect[arg_5_2] then
		return
	end

	pg = var_3

	local var_5_0 = var_3.UIMgr.GetInstance()

	var_3.LoadingOn(var_5_0)
	arg_5_0:RemoveEffect(arg_5_2)

	PoolMgr = var_3

	local var_5_1 = var_3.GetInstance()

	var_3.GetUI(var_5_1, arg_5_2, true, function(arg_6_0)
		local var_6_0 = arg_5_0.effects

		var_6_0[arg_5_2] = arg_6_0
		setParent = var_6_0

		var_6_0(arg_6_0, arg_5_0.root)

		setActive = var_6_0

		var_6_0(arg_6_0, true)

		pg = var_6_0

		local var_6_1 = var_6_0.UIMgr.GetInstance()

		var_1.LoadingOff(var_6_1)

		return
	end)

	if arg_5_1 > 0 then
		arg_5_0:AddTimer(arg_5_2, arg_5_1)
	end

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.isPlayEffect[arg_7_1] = true

	local var_7_0 = arg_7_0.timers

	Timer = var_4
	var_7_0[arg_7_1] = var_4.New(function()
		local var_8_0 = arg_7_0

		var_0.RemoveEffect(var_8_0, arg_7_1)

		arg_7_0.isPlayEffect[arg_7_1] = false

		return
	end, arg_7_2, 1)

	local var_7_1 = arg_7_0.timers[arg_7_1]

	var_3.Start(var_7_1)

	return
end

function var_0_0.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1] then
		local var_9_0 = arg_9_0.timers[arg_9_1]

		var_2.Stop(var_9_0)

		arg_9_0.timers[arg_9_1] = nil
	end

	return
end

function var_0_0.RemoveEffect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0

	arg_10_0.RemoveTimer(var_10_0)

	if arg_10_0.effects[arg_10_1] then
		local var_10_1 = arg_10_0.effects[arg_10_1]

		setActive = var_10_0

		var_10_0(var_10_1, false)

		PoolMgr = var_10_0

		local var_10_2 = var_10_0.GetInstance()

		var_3.ReturnUI(var_10_2, arg_10_1, var_10_1)

		arg_10_0.effects[arg_10_1] = nil
	end

	return
end

function var_0_0.PlayAction(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local function var_11_0(arg_12_0)
		if arg_12_0 == "finish" then
			local var_12_0 = arg_11_1

			var_1.SetActionCallBack(var_12_0, nil)

			local var_12_1 = arg_11_1

			var_1.SetAction(var_12_1, arg_11_3, 0)

			if arg_11_4 then
				arg_11_4()
			end
		end

		return
	end

	arg_11_1:SetActionCallBack(nil)
	arg_11_1:SetActionCallBack(var_11_0)
	arg_11_1:SetAction(arg_11_2, 0)

	return
end

function var_0_0.ClearEffects(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.effects) do
		arg_13_0:RemoveEffect(iter_13_0)
	end

	return
end

function var_0_0.Clear(arg_14_0)
	arg_14_0.holdSpinePlayRecorder = {}
	pairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.timers) do
		iter_14_1:Stop()
	end

	arg_14_0.timers = {}
	pairs = var_1

	for iter_14_2, iter_14_3 in var_1(arg_14_0.effects) do
		PoolMgr = var_1_10006

		local var_14_0 = var_1_10006.GetInstance()

		var_1_10006.ReturnUI(var_14_0, iter_14_2, iter_14_3)
	end

	arg_14_0.effects = {}
	arg_14_0.isPlayEffect = {}

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:Clear()

	return
end

return var_0_0
