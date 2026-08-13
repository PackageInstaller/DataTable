class = var_0_10000

local var_0_0 = "IslandSceneSwitcher"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSceneLoader"))

function var_0_1.LoadProgressUI(arg_1_0, arg_1_1, arg_1_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			IslandAssetLoadDispatcher = var_2_10002

			local var_2_1 = var_2_10002.Instance
			local var_2_2 = var_2.Enqueue
			local var_2_3 = "ui/IslandSceneLoader"
			local var_2_4 = ""

			typeof = var_2_10006
			GameObject = var_2_10007

			local var_2_5 = var_2_10006(var_2_10007)

			UnityEngine = var_2_10007
			var_2_0.progressLoadingId = var_2_2(var_2_1, var_2_3, var_2_4, var_2_5, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
				local var_3_0 = arg_1_0

				FrameAsyncInstantiateManager = var_3_10002

				local var_3_1 = var_3_10002.Instance

				var_3_0.loadingInstID = var_2.EnqueueInstantiate(var_3_1, arg_3_0, function(arg_4_0)
					setParent = var_4_10001

					local var_4_0 = arg_4_0

					pg = var_4_10003

					var_4_10001(var_4_0, var_4_10003.UIMgr.GetInstance().UIMain)

					arg_1_0.progressUI = arg_4_0

					local var_4_1 = arg_1_0
					local var_4_2 = arg_1_0.progressUI.transform

					var_4_1.curtain = var_2.Find(var_4_2, "curtain")
					setActive = var_4_1

					var_4_1(arg_1_0.progressUI, true)
					arg_2_0()

					return
				end)

				return
			end), true, true)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_1_0

			var_1.PlayFadeIn(var_5_0, arg_5_0)

			return
		end
	}, arg_1_2)

	return
end

function var_0_1.PlayFadeIn(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0.curtain, true)

	GetOrAddComponent = var_1_10002

	local var_6_0 = arg_6_0.curtain

	typeof = var_4
	CanvasGroup = var_1_10005

	local var_6_1 = var_1_10002(var_6_0, var_4(var_1_10005))

	var_6_1.alpha = 0
	LeanTween = var_3

	local var_6_2 = var_3.value

	go = var_4

	local var_6_3 = var_6_2(var_4(arg_6_0.curtain), 0, 1, 0.5)
	local var_6_4 = var_3.setOnUpdate

	System = var_5

	local var_6_5 = var_6_4(var_6_3, var_5.Action_float(function(arg_7_0)
		var_6_1.alpha = arg_7_0

		return
	end))
	local var_6_6 = var_3.setOnComplete

	System = var_5

	var_6_6(var_6_5, var_5.Action(arg_6_1))

	return
end

function var_0_1.PlayFadeOut(arg_8_0, arg_8_1)
	GetOrAddComponent = var_1_10002

	local var_8_0 = arg_8_0.curtain

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_8_1 = var_1_10002(var_8_0, var_1_10004(var_1_10005))

	var_8_1.alpha = 1
	LeanTween = var_3

	local var_8_2 = var_3.value

	go = var_4

	local var_8_3 = var_8_2(var_4(arg_8_0.curtain), 1, 0, 0.5)
	local var_8_4 = var_3.setOnUpdate

	System = var_5

	local var_8_5 = var_8_4(var_8_3, var_5.Action_float(function(arg_9_0)
		var_8_1.alpha = arg_9_0

		return
	end))
	local var_8_6 = var_3.setOnComplete

	System = var_5

	var_8_6(var_8_5, var_5.Action(arg_8_1))

	return
end

function var_0_1.LoadScene(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:LoadSceneWithProgress(arg_10_1, function(arg_11_0)
		if arg_11_0 == 1 then
			local var_11_0 = arg_10_0

			var_1.PlayFadeOut(var_11_0, arg_10_2)
		end

		return
	end)

	return
end

function var_0_1.UnloadProgressUI(arg_12_0)
	if not arg_12_0.canUnloadProgressUI then
		return
	end

	if arg_12_0.progressUI then
		Object = var_1

		var_1.Destroy(arg_12_0.progressUI)

		arg_12_0.progressUI = nil
	end

	return
end

function var_0_1.UnLoad(arg_13_0, arg_13_1)
	if arg_13_1 then
		var_0_1.super.UnLoad(arg_13_0)
		arg_13_0:Clear()

		return
	end

	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.PlayFadeIn(var_14_0, arg_14_0)

			return
		end,
		function(arg_15_0)
			var_0_1.super.UnLoad(arg_13_0)
			arg_15_0()

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_13_0

			var_1.PlayFadeOut(var_16_0, arg_16_0)

			return
		end
	}, function()
		local var_17_0 = arg_13_0

		var_0.Clear(var_17_0)

		return
	end)

	return
end

function var_0_1.Clear(arg_18_0)
	arg_18_0.canUnloadProgressUI = true
	LeanTween = var_1

	local var_18_0 = var_1.isTweening

	go = var_1_10002

	if var_18_0(var_1_10002(arg_18_0.curtain)) then
		LeanTween = var_1

		local var_18_1 = var_1.cancel

		go = var_2

		var_18_1(var_2(arg_18_0.curtain))
	end

	arg_18_0:UnloadProgressUI()

	if arg_18_0.loadingInstID then
		FrameAsyncInstantiateManager = var_1

		local var_18_2 = var_1.Instance

		var_1.Cancel(var_18_2, arg_18_0.loadingInstID)

		arg_18_0.loadingInstID = nil
	end

	if arg_18_0.progressLoadingId then
		IslandAssetLoadDispatcher = var_1

		local var_18_3 = var_1.Instance

		var_1.Cancel(var_18_3, arg_18_0.progressLoadingId)

		arg_18_0.progressLoadingId = nil
	end

	return
end

return var_0_1
