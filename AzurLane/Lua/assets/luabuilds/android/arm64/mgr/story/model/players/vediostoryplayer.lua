class = var_0_10000

local var_0_0 = "VedioStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryPlayer"))

function var_0_1.OnReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_3()

	return
end

local function var_0_2(arg_2_0)
	PathMgr = var_1_10001

	return var_1_10001.getAssetBundle("originsource/cpk/" .. arg_2_0 .. ".cpk")
end

function var_0_1.RegisetEvent(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetVedioPath()

	arg_3_0:CheckAndPlay(arg_3_1, var_3_0, arg_3_2)

	return
end

function var_0_1.CheckAndPlay(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	IsUnityEditor = var_1_10004

	if not var_1_10004 then
		PathMgr = var_1_10004

		if not var_1_10004.FileExists(var_0_2(arg_4_2)) then
			arg_4_3()

			return
		end
	end

	arg_4_0:PlayVedio(arg_4_1, arg_4_2, arg_4_3)

	return
end

function var_0_1.PlayVedio(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	LoadAnyAsync = var_1_10004

	var_1_10004("Story/" .. arg_5_2, "", nil, function(arg_6_0)
		if arg_5_0.stop then
			return
		end

		Object = var_1

		local var_6_0 = var_1.Instantiate(arg_6_0, arg_5_0.frontTr).transform
		local var_6_1 = var_2.Find(var_6_0, "cpk")
		local var_6_2 = var_2.GetComponent

		typeof = var_5
		CriManaCpkUI = var_2_10007

		local var_6_3 = var_6_2(var_6_1, var_5(var_2_10007))
		local var_6_4 = var_1.transform
		local var_6_5 = var_3.Find(var_6_4, "skip_button")

		onButton = var_6_1

		local var_6_6 = arg_5_0
		local var_6_7 = var_6_5

		local function var_6_8()
			local var_7_0 = arg_5_0

			var_0.ClearVedio(var_7_0)
			arg_5_3()

			return
		end

		SFX_PANEL = var_2_10009

		var_6_1(var_6_6, var_6_7, var_6_8, var_2_10009)

		local var_6_9 = var_6_3
		local var_6_10 = var_6_3.SetPlayEndHandler

		System = var_6_7

		var_6_10(var_6_9, var_6_7.Action(function()
			triggerButton = var_3_10000

			var_3_10000(var_6_5)

			return
		end))

		setActive = var_6_10

		local var_6_11 = var_6_5
		local var_6_12 = arg_5_1

		var_6_10(var_6_11, var_7.GetSkipFlag(var_6_12))

		arg_5_0._vedioGo = var_1

		return
	end)

	return
end

function var_0_1.ClearVedio(arg_9_0)
	if arg_9_0._vedioGo then
		Object = var_1

		var_1.Destroy(arg_9_0._vedioGo)

		arg_9_0._vedioGo = nil
	end

	return
end

function var_0_1.OnClear(arg_10_0)
	arg_10_0:ClearVedio()

	return
end

function var_0_1.OnEnd(arg_11_0)
	arg_11_0:ClearVedio()

	return
end

return var_0_1
