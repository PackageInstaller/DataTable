class = var_0_10000

local var_0_0 = "GuideShowSignPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuidePlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.signTrs = {}

	return
end

function var_0_1.OnExecution(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.loadSigns(var_3_0, arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.InitSign(var_4_0, arg_2_1, arg_4_0)

			return
		end
	}, arg_2_2)

	return
end

function var_0_1.loadSigns(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetSignList()
	local var_5_1 = {}

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(var_5_0) do
		table = var_1_10010

		var_1_10010.insert(var_5_1, function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.LoadSignRes(var_6_0, iter_5_1, function(arg_7_0)
				table = var_3_10001

				var_3_10001.insert(arg_5_0.signTrs, arg_7_0)
				arg_6_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_5

	var_5(var_5_1, arg_5_2)

	return
end

function var_0_1.LoadSignRes(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.uiLoader

	var_3.Load(var_8_0, arg_8_1.signName, function(arg_9_0)
		if arg_8_1.atlasName and arg_8_1.fileName then
			LoadSprite = var_1

			local var_9_0 = var_1(arg_8_1.atlasName, arg_8_1.fileName)

			setImageSprite = var_2
			findTF = var_3

			var_2(var_3(arg_9_0, "shadow"), var_9_0, true)
		end

		arg_9_0.localPosition = arg_8_1.pos
		Vector3 = var_1
		arg_9_0.eulerAngles = var_1(0, 0, 0)
		Vector3 = var_1
		arg_9_0.localScale = var_1.one
		setActive = var_1

		var_1(arg_9_0, true)

		if arg_8_2 then
			arg_8_2(arg_9_0)
		end

		return
	end)

	return
end

function var_0_1.InitSign(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetSignType(var_10_0)

	GuideShowSignStep = var_10_0

	if var_10_1 == var_10_0.SIGN_TYPE_2 then
		arg_10_0:UpdateSign2(arg_10_1, arg_10_2)
	else
		GuideShowSignStep = var_4

		if var_10_1 == var_4.SIGN_TYPE_3 then
			arg_10_0:UpdateSign3(arg_10_1, arg_10_2)
		else
			arg_10_0:UpdateCommonSign(arg_10_1, arg_10_2)
		end
	end

	return
end

function var_0_1.UpdateSign2(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.signTrs[1]

	findTF = var_1_10004

	local var_11_1 = var_1_10004(var_11_0, "btn")
	local var_11_2

	if arg_11_1:ShouldClick() then
		setActive = var_11_2

		var_11_2(var_11_0, false)

		var_11_2 = arg_11_1:GetClickData()
		var_1_10007 = arg_11_0

		arg_11_0.SearchUI(var_1_10007, var_11_2, function(arg_12_0)
			IsNil = var_2_10001

			if var_2_10001(arg_12_0) then
				pg = var_1

				local var_12_0 = var_1.NewGuideMgr.GetInstance()

				var_1.Stop(var_12_0)

				return
			end

			Vector3 = var_1

			local var_12_1 = var_1(arg_12_0.sizeDelta.x * (arg_12_0.pivot.x - 0.5), arg_12_0.sizeDelta.y * (arg_12_0.pivot.y - 0.5), 0)
			local var_12_2 = var_11_0.parent
			local var_12_3 = var_2.InverseTransformPoint(var_12_2, arg_12_0.position)

			var_11_0.localPosition = var_12_3 - var_12_1

			local var_12_4 = var_11_1

			var_12_4.sizeDelta = arg_12_0.sizeDelta + var_11_2.sizeDeltaPlus
			setActive = var_12_4

			var_12_4(var_11_0, true)

			return
		end)
	elseif arg_11_1:ExistClickArea() then
		var_11_1.sizeDelta = arg_11_1:GetClickArea()
	end

	GetOrAddComponent = var_11_2

	local var_11_3 = var_11_1

	typeof = var_1_10007
	UILongPressTrigger = var_1_10008

	local var_11_4 = var_11_2(var_11_3, var_1_10007(var_1_10008)).onLongPressed

	var_6.RemoveAllListeners(var_11_4)

	local var_11_5 = var_5.onReleased

	var_6.RemoveAllListeners(var_11_5)

	if arg_11_1:GetTriggerType() == 1 then
		local var_11_6 = var_5.onLongPressed

		var_6.AddListener(var_11_6, arg_11_2)
	else
		local var_11_7 = var_5.onReleased

		var_6.AddListener(var_11_7, arg_11_2)
	end

	return
end

function var_0_1.UpdateSign3(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.signTrs[1].sizeDelta = arg_13_1:GetClickArea()

	arg_13_2()

	return
end

function var_0_1.UpdateCommonSign(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1:GetExitDelay() <= 0 then
		arg_14_2()
	else
		Timer = var_4

		local var_14_0 = var_4.New(arg_14_2, var_3, 1)

		var_4.Start(var_14_0)
	end

	return
end

function var_0_1.OnClear(arg_15_0)
	arg_15_0.signTrs = {}

	return
end

return var_0_1
