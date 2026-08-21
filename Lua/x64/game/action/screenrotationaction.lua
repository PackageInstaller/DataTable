local var_0_0 = {}
local var_0_1

function var_0_0.RotateToPortrait(arg_1_0)
	if GameToSDK.PLATFORM_ID == 1 or GameToSDK.PLATFORM_ID == 3 then
		var_0_0.RotateToPortraitIOS(arg_1_0)
	else
		var_0_1 = Screen.orientation

		var_0_0.RotateToPortraitAndroid(arg_1_0)
	end
end

function var_0_0.RotateToPortraitIOS(arg_2_0)
	local var_2_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_2_1, var_2_2 = SettingTools.GetSettingScreenSize(var_2_0)

	ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)
	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
	setScreenOrientation(false)
	U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
	SetActive(manager.ui.mainCamera, false)
	Screen.SetResolution(var_2_2, var_2_1, true)

	local var_2_3

	var_2_3 = FrameTimer.New(function()
		if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
			var_2_3:Stop()
			SetActive(manager.ui.mainCamera, true)
			manager.ui.mainCameraCom_:ResetAspect()

			if arg_2_0 then
				arg_2_0()
			end
		end
	end, 1, -1)

	var_2_3:Start()
end

function var_0_0.RotateToPortraitAndroid(arg_4_0)
	local var_4_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_4_1, var_4_2 = SettingTools.GetSettingScreenSize(var_4_0)

	ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

	Screen.autorotateToPortrait = true
	Screen.autorotateToPortraitUpsideDown = false
	Screen.autorotateToLandscapeLeft = false
	Screen.autorotateToLandscapeRight = false

	if string.find(UnityEngine.SystemInfo.graphicsDeviceName, "MuMu") or string.find(UnityEngine.SystemInfo.graphicsDeviceName, "LeiDian") or string.find(UnityEngine.SystemInfo.graphicsDeviceName, "Nox") then
		Screen.autorotateToLandscapeLeft = true
		Screen.autorotateToLandscapeRight = true
	end

	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
	setScreenOrientation(false)
	U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
	SetActive(manager.ui.mainCamera, false)
	FrameTimer.New(function()
		Screen.SetResolution(var_4_2, var_4_1, true)
		var_0_0.AutoRotation2AutoRotation(function()
			SetActive(manager.ui.mainCamera, true)
			UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(true)
			U3DHud.mInstance:SetWidthAndHeight(1080, 1920)
			Screen.SetResolution(var_4_2, var_4_1, true)
			manager.ui.mainCameraCom_:ResetAspect()

			if arg_4_0 then
				arg_4_0()
			end
		end)
	end, 1, 1):Start()
end

function var_0_0.AutoRotation2AutoRotation(arg_7_0)
	local var_7_0
	local var_7_1 = 0

	var_7_0 = FrameTimer.New(function()
		var_7_1 = var_7_1 + 1

		if GameToSDK.PLATFORM_ID == 2 or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeLeft or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeRight then
			var_7_0:Stop()
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

			Screen.autorotateToPortrait = false
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = true
			Screen.autorotateToLandscapeRight = true

			var_0_0.AutoRotation2Portrait(arg_7_0)

			return
		end

		if var_7_1 == 10 then
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeLeft)
		elseif var_7_1 >= 15 then
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeRight)

			var_7_1 = 0
		end
	end, 1, -1)

	var_7_0:Start()
end

function var_0_0.AutoRotation2Portrait(arg_9_0)
	local var_9_0

	var_9_0 = FrameTimer.New(function()
		if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeLeft or Screen.orientation == UnityEngine.ScreenOrientation.LandscapeRight then
			var_9_0:Stop()
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)

			local var_10_0 = 0

			var_9_0 = FrameTimer.New(function()
				var_10_0 = var_10_0 + 1

				if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation == UnityEngine.ScreenOrientation.Portrait then
					var_9_0:Stop()

					if arg_9_0 then
						arg_9_0()

						return
					end
				end

				if var_10_0 == 10 then
					ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.PortraitUpsideDown)
				elseif var_10_0 >= 15 then
					ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.Portrait)

					var_10_0 = 0
				end
			end, 1, -1)

			var_9_0:Start()
		end
	end, 1, -1)

	var_9_0:Start()
end

function var_0_0.RotateToLandscape(arg_12_0)
	if GameToSDK.PLATFORM_ID == 1 or GameToSDK.PLATFORM_ID == 3 then
		var_0_0.RotateToLandScapeIOS(arg_12_0)
	else
		var_0_0.RotateToLandscapeAndroid(arg_12_0)
	end
end

function var_0_0.RotateToLandScapeIOS(arg_13_0)
	ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeLeft)
	ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

	Screen.autorotateToPortrait = false
	Screen.autorotateToPortraitUpsideDown = false
	Screen.autorotateToLandscapeLeft = true
	Screen.autorotateToLandscapeRight = true

	local var_13_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_13_1, var_13_2 = SettingTools.GetSettingScreenSize(var_13_0)

	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
	setScreenOrientation(true)
	U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
	SetActive(manager.ui.mainCamera, false)
	Screen.SetResolution(var_13_1, var_13_2, true)

	local var_13_3

	var_13_3 = FrameTimer.New(function()
		if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
			var_13_3:Stop()
			SetActive(manager.ui.mainCamera, true)
			manager.ui.mainCameraCom_:ResetAspect()

			if arg_13_0 then
				arg_13_0()
			end

			manager.notify:Invoke(HERO_DISPLAY_EXIT)
		end
	end, 1, -1)

	var_13_3:Start()
end

function var_0_0.RotateToLandscapeAndroid(arg_15_0)
	if GameToSDK.IsEditorOrPcPlatform() == false then
		ScreenRotateUtil.ChangeScreenOrientation(var_0_1)

		Screen.autorotateToPortrait = false
		Screen.autorotateToPortraitUpsideDown = false
		Screen.autorotateToLandscapeLeft = true
		Screen.autorotateToLandscapeRight = true
	end

	local var_15_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_15_1, var_15_2 = SettingTools.GetSettingScreenSize(var_15_0)

	UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
	setScreenOrientation(true)
	U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
	SetActive(manager.ui.mainCamera, false)
	FrameTimer.New(function()
		Screen.SetResolution(var_15_1, var_15_2, true)
		var_0_0.Portrait2AutoRotation(function()
			SetActive(manager.ui.mainCamera, true)
			UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance:RotateScreen(false)
			U3DHud.mInstance:SetWidthAndHeight(1920, 1080)
			Screen.SetResolution(var_15_1, var_15_2, true)
			manager.ui.mainCameraCom_:ResetAspect()

			if arg_15_0 then
				arg_15_0()
			end
		end)
	end, 1, 1):Start()
end

function var_0_0.Portrait2AutoRotation(arg_18_0)
	local var_18_0
	local var_18_1 = 0

	var_18_0 = FrameTimer.New(function()
		var_18_1 = var_18_1 + 1

		if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
			var_18_0:Stop()
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

			Screen.autorotateToPortrait = false
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = true
			Screen.autorotateToLandscapeRight = true

			arg_18_0()

			return
		end

		if var_18_1 == 10 then
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeLeft)
		elseif var_18_1 >= 15 then
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.LandscapeRight)

			var_18_1 = 0
		end
	end, 1, -1)

	var_18_0:Start()
end

function var_0_0.AutoRotation2LandscapeLeft(arg_20_0)
	local var_20_0

	var_20_0 = FrameTimer.New(function()
		if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
			var_20_0:Stop()
			ScreenRotateUtil.ChangeScreenOrientation(UnityEngine.ScreenOrientation.AutoRotation)

			Screen.autorotateToPortrait = false
			Screen.autorotateToPortraitUpsideDown = false
			Screen.autorotateToLandscapeLeft = true
			Screen.autorotateToLandscapeRight = true
			var_20_0 = FrameTimer.New(function()
				if GameToSDK.IsEditorOrPcPlatform() or Screen.orientation ~= UnityEngine.ScreenOrientation.Portrait then
					var_20_0:Stop()
					arg_20_0()
				end
			end, 1, -1)

			var_20_0:Start()
		end
	end, 1, -1)

	var_20_0:Start()
end

return var_0_0
