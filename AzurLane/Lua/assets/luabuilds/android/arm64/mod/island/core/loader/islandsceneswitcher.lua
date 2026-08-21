local var_0_0 = class("IslandSceneSwitcher", import(".IslandSceneLoader"))

function var_0_0.LoadProgressUI(arg_1_0, arg_1_1, arg_1_2)
	seriesAsync({
		function(arg_2_0)
			arg_1_0.progressLoadingId = IslandAssetLoadDispatcher.Instance:Enqueue("ui/IslandSceneLoader", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
				arg_1_0.loadingInstID = FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_3_0, function(arg_4_0)
					setParent(arg_4_0, pg.UIMgr.GetInstance().UIMain)

					arg_1_0.progressUI = arg_4_0
					arg_1_0.curtain = arg_1_0.progressUI.transform:Find("curtain")

					setActive(arg_1_0.progressUI, true)
					arg_2_0()

					return
				end)

				return
			end), true, true)

			return
		end,
		function(arg_5_0)
			arg_1_0:PlayFadeIn(arg_5_0)

			return
		end
	}, arg_1_2)

	return
end

function var_0_0.PlayFadeIn(arg_6_0, arg_6_1)
	setActive(arg_6_0.curtain, true)

	local var_6_0 = GetOrAddComponent(arg_6_0.curtain, typeof(CanvasGroup))

	GetOrAddComponent(arg_6_0.curtain, typeof(CanvasGroup)).alpha = 0

	LeanTween.value(go(arg_6_0.curtain), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_7_0)
		var_6_0.alpha = arg_7_0

		return
	end)):setOnComplete(System.Action(arg_6_1))

	return
end

function var_0_0.PlayFadeOut(arg_8_0, arg_8_1)
	local var_8_0 = GetOrAddComponent(arg_8_0.curtain, typeof(CanvasGroup))

	GetOrAddComponent(arg_8_0.curtain, typeof(CanvasGroup)).alpha = 1

	LeanTween.value(go(arg_8_0.curtain), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_9_0)
		var_8_0.alpha = arg_9_0

		return
	end)):setOnComplete(System.Action(arg_8_1))

	return
end

function var_0_0.LoadScene(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:LoadSceneWithProgress(arg_10_1, function(arg_11_0)
		if arg_11_0 == 1 then
			arg_10_0:PlayFadeOut(arg_10_2)
		end

		return
	end)

	return
end

function var_0_0.UnloadProgressUI(arg_12_0)
	if not arg_12_0.canUnloadProgressUI then
		return
	end

	if arg_12_0.progressUI then
		Object.Destroy(arg_12_0.progressUI)

		arg_12_0.progressUI = nil
	end

	return
end

function var_0_0.UnLoad(arg_13_0, arg_13_1)
	if arg_13_1 then
		var_0_0.super.UnLoad(arg_13_0)
		arg_13_0:Clear()

		return
	end

	seriesAsync({
		function(arg_14_0)
			arg_13_0:PlayFadeIn(arg_14_0)

			return
		end,
		function(arg_15_0)
			var_0_0.super.UnLoad(arg_13_0)
			arg_15_0()

			return
		end,
		function(arg_16_0)
			arg_13_0:PlayFadeOut(arg_16_0)

			return
		end
	}, function()
		arg_13_0:Clear()

		return
	end)

	return
end

function var_0_0.Clear(arg_18_0)
	arg_18_0.canUnloadProgressUI = true

	if LeanTween.isTweening(go(arg_18_0.curtain)) then
		LeanTween.cancel(go(arg_18_0.curtain))
	end

	arg_18_0:UnloadProgressUI()

	if arg_18_0.loadingInstID then
		FrameAsyncInstantiateManager.Instance:Cancel(arg_18_0.loadingInstID)

		arg_18_0.loadingInstID = nil
	end

	if arg_18_0.progressLoadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(arg_18_0.progressLoadingId)

		arg_18_0.progressLoadingId = nil
	end

	return
end

return var_0_0
