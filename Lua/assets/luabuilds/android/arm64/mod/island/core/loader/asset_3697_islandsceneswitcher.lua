local IslandSceneSwitcher = class("IslandSceneSwitcher", import(".IslandSceneLoader"))

function IslandSceneSwitcher:LoadProgressUI(arg_1_1, arg_1_2)
	seriesAsync({
		function(arg_2_0)
			self.progressLoadingId = IslandAssetLoadDispatcher.Instance:Enqueue("ui/IslandSceneLoader", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
				self.loadingInstID = FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_3_0, function(arg_4_0)
					setParent(arg_4_0, pg.UIMgr.GetInstance().UIMain)

					self.progressUI = arg_4_0
					self.curtain = self.progressUI.transform:Find("curtain")

					setActive(self.progressUI, true)
					arg_2_0()

					return
				end)

				return
			end), true, true)

			return
		end,
		function(arg_5_0)
			self:PlayFadeIn(arg_5_0)

			return
		end
	}, arg_1_2)

	return
end

function IslandSceneSwitcher:PlayFadeIn(arg_6_1)
	setActive(self.curtain, true)

	local var_6_0 = GetOrAddComponent(self.curtain, typeof(CanvasGroup))

	var_6_0.alpha = 0

	LeanTween.value(go(self.curtain), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_7_0)
		var_6_0.alpha = arg_7_0

		return
	end)):setOnComplete(System.Action(arg_6_1))

	return
end

function IslandSceneSwitcher:PlayFadeOut(arg_8_1)
	local var_8_0 = GetOrAddComponent(self.curtain, typeof(CanvasGroup))

	var_8_0.alpha = 1

	LeanTween.value(go(self.curtain), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_9_0)
		var_8_0.alpha = arg_9_0

		return
	end)):setOnComplete(System.Action(arg_8_1))

	return
end

function IslandSceneSwitcher:LoadScene(arg_10_1, arg_10_2)
	self:LoadSceneWithProgress(arg_10_1, function(arg_11_0)
		if arg_11_0 == 1 then
			self:PlayFadeOut(arg_10_2)
		end

		return
	end)

	return
end

function IslandSceneSwitcher:UnloadProgressUI()
	if not self.canUnloadProgressUI then
		return
	end

	if self.progressUI then
		Object.Destroy(self.progressUI)

		self.progressUI = nil
	end

	return
end

function IslandSceneSwitcher:UnLoad(arg_13_1)
	if arg_13_1 then
		IslandSceneSwitcher.super.UnLoad(self)
		self:Clear()

		return
	end

	seriesAsync({
		function(arg_14_0)
			self:PlayFadeIn(arg_14_0)

			return
		end,
		function(arg_15_0)
			IslandSceneSwitcher.super.UnLoad(self)
			arg_15_0()

			return
		end,
		function(arg_16_0)
			self:PlayFadeOut(arg_16_0)

			return
		end
	}, function()
		self:Clear()

		return
	end)

	return
end

function IslandSceneSwitcher:Clear()
	self.canUnloadProgressUI = true

	if LeanTween.isTweening(go(self.curtain)) then
		LeanTween.cancel(go(self.curtain))
	end

	self:UnloadProgressUI()

	if self.loadingInstID then
		FrameAsyncInstantiateManager.Instance:Cancel(self.loadingInstID)

		self.loadingInstID = nil
	end

	if self.progressLoadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(self.progressLoadingId)

		self.progressLoadingId = nil
	end

	return
end

return IslandSceneSwitcher
