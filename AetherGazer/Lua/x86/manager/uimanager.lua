local var_0_0 = class("UIManager")
local var_0_1 = "adv"

function var_0_0.Ctor(arg_1_0)
	arg_1_0.uiMain = GameObject.Find("UICamera/Canvas/UIMain")
	arg_1_0.uiStory = GameObject.Find("UICamera/Canvas/UIStory/Canvas")
	arg_1_0.uiPop = GameObject.Find("UICamera/Canvas/UIPop/Canvas")
	arg_1_0.uiMessage = GameObject.Find("UICamera/Canvas/UIMessage/Canvas")
	arg_1_0.uiTips = GameObject.Find("UICamera/Canvas/UITips/Canvas")
	arg_1_0.uiLoad = GameObject.Find("UICamera/Canvas/UILoad/Canvas")
	arg_1_0.uiHPPanel = GameObject.Find("UICamera/Canvas/UIMain/HPPanel")

	arg_1_0:InitFakeBackground()
	arg_1_0:ShowBackground(false)

	arg_1_0.mainCamera = GameObject.Find("MainCamera")
	arg_1_0.canvas = GameObject.Find("UICamera/Canvas")
	arg_1_0.uiCamera = arg_1_0.canvas:GetComponent(typeof(Canvas)).worldCamera
	arg_1_0.dontDestroyCanvas = GameObject.Find("UICamera_DontDestroy/Canvas")
	arg_1_0.uiCanvasGroup = arg_1_0.canvas:GetComponent("CanvasGroup")
	arg_1_0.canvasSize_ = arg_1_0.canvas:GetComponent("RectTransform").sizeDelta

	local var_1_0 = arg_1_0.mainCamera.transform

	var_1_0.localPosition = Vector3(0, 0, 2)
	var_1_0.localEulerAngles = Vector3(0, 180, 0)
	arg_1_0.mainCameraPos_ = Vector3(0, 0, 2)
	arg_1_0.mainCameraRot_ = Vector3(0, 180, 0)
	arg_1_0.mainCameraCom_ = arg_1_0.mainCamera:GetComponent("Camera")
	arg_1_0.cameraExtension = arg_1_0.mainCamera:GetComponent(typeof(UnityEngine.Pipelines.SimPipeline.CameraExtension))
	arg_1_0.sceneObject_ = {}
	arg_1_0.canvasRate = arg_1_0.canvas:GetComponent("RectTransform").sizeDelta.x / Screen.width
	arg_1_0.UIDGo_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/UIDText")
	arg_1_0.UIDGo_.layer = 18

	local var_1_1 = arg_1_0.UIDGo_:AddComponent(typeof(Canvas))

	if not isNil(var_1_1) then
		var_1_1.overrideSorting = true
		var_1_1.sortingLayerName = "windowbg"
	end

	arg_1_0.UIDText_ = arg_1_0.UIDGo_:GetComponent(typeof(Text))
	arg_1_0.tipImageRect_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/TipImage"):GetComponent(typeof(RectTransform))
end

function var_0_0.InitFakeBackground(arg_2_0)
	arg_2_0.uiBackground = GameObject.Instantiate(arg_2_0.uiHPPanel, arg_2_0.uiMain.transform)
	arg_2_0.uiBackground.name = "Background"

	local var_2_0 = arg_2_0.uiBackground:GetComponent("RectTransform")

	var_2_0:SetSiblingIndex(0)

	var_2_0.anchorMin = Vector2.New(0, 0)
	var_2_0.anchorMax = Vector2.New(1, 1)
	var_2_0.offsetMin = Vector2.New(0, 0)
	var_2_0.offsetMax = Vector2.New(0, 0)
	arg_2_0.uiBackground:AddComponent(typeof(Image)).color = Color.New(0.254902, 0.2862745, 0.345098)
end

local var_0_2 = 175

function var_0_0.SetUIDText(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.UIDText_ then
		arg_3_0.UIDText_.text = arg_3_1
	end

	if arg_3_0.UIDMarkText_ and GameToSDK.clientInfo.env == var_0_1 then
		if arg_3_1 == "" then
			arg_3_0.UIDMarkText_.text = ""
		else
			local var_3_0 = arg_3_1
			local var_3_1 = "                        " .. arg_3_1

			for iter_3_0 = 1, var_0_2 do
				var_3_0 = var_3_0 .. var_3_1
			end

			arg_3_0.UIDMarkText_.text = var_3_0
		end
	end

	if arg_3_0.UIDEncodeText_ and GameToSDK.clientInfo.env == var_0_1 then
		if arg_3_0.encodePosTimer_ then
			arg_3_0.encodePosTimer_:Stop()
		end

		if arg_3_1 == "" then
			arg_3_0.UIDEncodeText_.text = ""
		else
			print("userId", arg_3_2)

			arg_3_0.UIDEncodeText_.text = encodeUID(arg_3_2)
			arg_3_0.encodePosTimer_ = Timer.New(function()
				if arg_3_0.UIDEncodeTrs_ then
					math.randomseed(os.time())

					arg_3_0.UIDEncodeTrs_.anchoredPosition = Vector3(math.random(250, _G.SCREEN_WIDTH - 250), math.random(40, _G.SCREEN_HEIGHT - 40), 0)
				end
			end, 1, -1)

			arg_3_0.encodePosTimer_:Start()
		end
	end

	CustomLog.SetUserID(arg_3_1)
end

function var_0_0.ShowUID(arg_5_0, arg_5_1)
	SetActive(arg_5_0.UIDGo_, arg_5_1)

	if arg_5_1 then
		arg_5_0.tipImageRect_.localPosition = arg_5_0.tipImageRect_.localPosition - Vector3(0, 20, 0)
	else
		arg_5_0.tipImageRect_.localPosition = arg_5_0.tipImageRect_.localPosition + Vector3(0, 20, 0)
	end
end

function var_0_0.SetMainActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.uiMain, arg_6_1)
end

function var_0_0.SetMainCameraPos(arg_7_0, arg_7_1)
	arg_7_0.mainCamera.transform.localPosition = arg_7_1 or arg_7_0.mainCameraPos_
end

function var_0_0.SetMainCameraRot(arg_8_0, arg_8_1)
	arg_8_0.mainCamera.transform.localEulerAngles = arg_8_1 or arg_8_0.mainCameraRot_
end

function var_0_0.SetMainCameraFieldOfView(arg_9_0, arg_9_1)
	arg_9_0.mainCameraCom_.fieldOfView = arg_9_1
end

function var_0_0.ShowBackground(arg_10_0, arg_10_1)
	if not isNil(arg_10_0.uiBackground) then
		SetActive(arg_10_0.uiBackground, arg_10_1)
	end
end

function var_0_0.SetMainCamera(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = CameraCfg[arg_11_1]

	if not arg_11_2 and var_11_0 == nil then
		print("没有配置对应的相机位置:", arg_11_1)

		return
	end

	if not arg_11_2 then
		arg_11_0.mainCamera.transform.localPosition = Vector3(var_11_0.position[1], var_11_0.position[2], var_11_0.position[3])
		arg_11_0.mainCamera:GetComponent("Camera").orthographic = false
		arg_11_0.mainCamera.transform.localEulerAngles = Vector3(var_11_0.rotate[1], var_11_0.rotate[2], var_11_0.rotate[3])
		arg_11_0.mainCameraCom_.fieldOfView = var_11_0.fieldOfView
	end

	if arg_11_0.sceneGo_ then
		LuaForUtil.SetSceneSetting(arg_11_0.sceneGo_, false)
		SetActive(arg_11_0.sceneGo_, false)

		arg_11_0.sceneGo_ = nil
	end

	local var_11_1 = arg_11_1

	if not arg_11_2 then
		if var_11_0.multiscene == 1 then
			if var_11_0.type == "home" or var_11_0.type == "chat" or var_11_0.type == "playerInfo" then
				if arg_11_4 then
					var_11_1 = manager.loadScene:GetPreviewHomeShouldLoadSceneName()
				else
					var_11_1 = manager.loadScene:GetHomeShouldLoadSceneName()
				end
			elseif var_11_0.type == "homePreview" then
				var_11_1 = manager.loadScene:GetPreviewHomeShouldLoadSceneName()
			end
		else
			var_11_1 = var_11_0.sceneName
		end
	end

	if var_11_1 and var_11_1 ~= "" then
		arg_11_0.sceneGo_ = arg_11_0:GetSceneByName(var_11_1)

		if arg_11_0.sceneGo_ then
			LuaForUtil.SetSceneSetting(arg_11_0.sceneGo_, true)
			SetActive(arg_11_0.sceneGo_, not arg_11_3)
		end
	end
end

function var_0_0.GetSceneSetting(arg_12_0)
	local var_12_0 = SceneManager.GetActiveScene()
	local var_12_1 = var_12_0:GetRootGameObjects()
	local var_12_2
	local var_12_3

	if var_12_1 ~= nil then
		for iter_12_0 = 0, var_12_1.Length - 1 do
			if var_12_1[iter_12_0].name == var_12_0.name then
				var_12_2 = var_12_1[iter_12_0]

				break
			end
		end
	end

	if var_12_2 then
		local var_12_4 = var_12_2:GetComponent("SceneSetting")

		if var_12_4.enabled == true then
			return var_12_4
		end
	end
end

function var_0_0.GetSceneSettingBySceneName(arg_13_0, arg_13_1)
	local var_13_0 = SceneManager.GetSceneByName(arg_13_1)
	local var_13_1 = var_13_0:GetRootGameObjects()
	local var_13_2
	local var_13_3

	if var_13_1 ~= nil then
		for iter_13_0 = 0, var_13_1.Length - 1 do
			if var_13_1[iter_13_0].name == var_13_0.name then
				var_13_2 = var_13_1[iter_13_0]

				break
			end
		end
	end

	if var_13_2 then
		return (var_13_2:GetComponent("SceneSetting"))
	end
end

function var_0_0.SetSceneLightEffect(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		if not isNil(arg_14_0.sceneLightEffectGo_) then
			Object.Destroy(arg_14_0.sceneLightEffectGo_)
		end

		if arg_14_0.lastPath_ then
			Asset.Unload(arg_14_0.lastPath_)
		end

		arg_14_0.lastPath_ = nil

		return
	end

	if isNil(arg_14_0.sceneGo_) then
		return
	end

	if arg_14_0.lastPath_ == arg_14_1 and not isNil(arg_14_0.sceneLightEffectGo_) then
		return
	end

	if not isNil(arg_14_0.sceneLightEffectGo_) then
		Object.Destroy(arg_14_0.sceneLightEffectGo_)
	end

	arg_14_0.lastPath_ = arg_14_1

	local var_14_0 = Asset.Load(arg_14_1)

	arg_14_0.sceneLightEffectGo_ = Object.Instantiate(var_14_0, arg_14_0.sceneGo_.transform)
end

function var_0_0.SetSceneWeatherEffect(arg_15_0, arg_15_1)
	if isNil(arg_15_0.sceneGo_) then
		return
	end

	if arg_15_0.lastPath_ == arg_15_1 and not isNil(arg_15_0.sceneWeatherEffectGo_) then
		return
	end

	if not isNil(arg_15_0.sceneWeatherEffectGo_) then
		Object.Destroy(arg_15_0.sceneWeatherEffectGo_)
	end

	arg_15_0.lastPath_ = arg_15_1

	local var_15_0 = Asset.Load(arg_15_1)

	arg_15_0.sceneWeatherEffectGo_ = Object.Instantiate(var_15_0, arg_15_0.sceneGo_.transform)
end

function var_0_0.GetSceneByName(arg_16_0, arg_16_1)
	local var_16_0

	if SceneManager.GetSceneByName(arg_16_1).rootCount > 0 then
		var_16_0 = SceneManager.GetSceneByName(arg_16_1):GetRootGameObjects()
	end

	if var_16_0 ~= nil then
		for iter_16_0 = 0, var_16_0.Length - 1 do
			if var_16_0[iter_16_0].name == arg_16_1 then
				return var_16_0[iter_16_0]
			end
		end
	end

	return nil
end

function var_0_0.ResetMainCamera(arg_17_0)
	arg_17_0:SetMainCamera("null")

	if arg_17_0.sceneGo_ then
		LuaForUtil.SetSceneSetting(arg_17_0.sceneGo_, false)
		SetActive(arg_17_0.sceneGo_, false)

		arg_17_0.sceneGo_ = nil
	end
end

function var_0_0.SetScene(arg_18_0, arg_18_1)
	arg_18_0.sceneGo_ = arg_18_1
end

function var_0_0.SetMainCameraCom(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.mainCamera:GetComponent(arg_19_1)

	if var_19_0 then
		var_19_0.enabled = arg_19_2
	end
end

function var_0_0.AddMainCameraCom(arg_20_0, arg_20_1)
	return GameObjectTools.GetOrAddComponent(arg_20_0.mainCamera, arg_20_1)
end

function var_0_0.SetUISeparateRender(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.cameraExtension then
		arg_21_0.cameraExtension.uiSeparateRender = arg_21_1
	end

	if arg_21_2 and UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance then
		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance.uiSeparate = arg_21_1
	end
end

function var_0_0.GetUISeparateRender(arg_22_0)
	if arg_22_0.cameraExtension then
		return arg_22_0.cameraExtension.uiSeparateRender
	end

	return false
end

function var_0_0.GetCanvasSize(arg_23_0)
	return arg_23_0.canvasSize_
end

function var_0_0.SetSceneObject(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.sceneObject_[arg_24_1] = arg_24_2
end

function var_0_0.GetSceneObject(arg_25_0, arg_25_1)
	if arg_25_0.sceneObject_[arg_25_1] == nil then
		arg_25_0.sceneObject_[arg_25_1] = GameObject.Find(arg_25_1)
	end

	return arg_25_0.sceneObject_[arg_25_1]
end

function var_0_0.UIEventEnabled(arg_26_0, arg_26_1)
	if arg_26_0.isForce_ then
		return
	end

	arg_26_0:EventEnabled(arg_26_1)
end

function var_0_0.UIEventEnabledByUI(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.isForce_ = arg_27_2

	arg_27_0:EventEnabled(arg_27_1)
end

function var_0_0.SetCanvasAlpha(arg_28_0, arg_28_1)
	if arg_28_0.uiCanvasGroup then
		arg_28_0.uiCanvasGroup.alpha = arg_28_1
	end
end

function var_0_0.EventEnabled(arg_29_0, arg_29_1)
	if arg_29_0.uiCanvasGroup then
		arg_29_0.uiCanvasGroup.blocksRaycasts = arg_29_1
	end
end

function var_0_0.GetIsUIEventEnabled(arg_30_0)
	if arg_30_0.uiCanvasGroup then
		return arg_30_0.uiCanvasGroup.blocksRaycasts
	end
end

function var_0_0.Dispose(arg_31_0)
	arg_31_0:ShowBackground(false)

	if arg_31_0.guideUI_ then
		Object.Destroy(arg_31_0.guideUI_)

		arg_31_0.guideUI_ = nil
	end

	if arg_31_0.encodePosTimer_ then
		arg_31_0.encodePosTimer_:Stop()
	end

	if arg_31_0.sceneGo_ then
		LuaForUtil.SetSceneSetting(arg_31_0.sceneGo_, false)
		SetActive(arg_31_0.sceneGo_, false)

		arg_31_0.sceneGo_ = nil
	end

	arg_31_0.uiCanvasGroup = nil
	arg_31_0.uiMain = nil
	arg_31_0.uiPop = nil
	arg_31_0.uiMessage = nil
	arg_31_0.uiTips = nil
	arg_31_0.uiLoad = nil
	arg_31_0.uiHPPanel = nil
	arg_31_0.uiCamera = nil
	arg_31_0.sceneObject_ = {}
	arg_31_0.lastPath_ = nil
	arg_31_0.sceneLightEffectGo_ = nil
	arg_31_0.sceneWeatherEffectGo_ = nil
end

function var_0_0.AdaptUIByFOV(arg_32_0)
	local var_32_0 = 1000000
	local var_32_1 = 2 * var_32_0 * math.tan(math.rad(arg_32_0.mainCameraCom_.fieldOfView * 0.5)) * arg_32_0.mainCameraCom_.aspect
	local var_32_2 = math.deg(2 * math.atan(var_32_1 * 0.5 / var_32_0))

	print("该界面的水平FOV为：", var_32_2)

	if var_32_2 < 46 then
		local var_32_3 = 46
		local var_32_4 = 2 * var_32_0 * math.tan(math.rad(var_32_3 * 0.5)) / arg_32_0.mainCameraCom_.aspect

		arg_32_0.mainCameraCom_.fieldOfView = math.deg(2 * math.atan(var_32_4 * 0.5 / var_32_0))
	end
end

function var_0_0.ScreenToWorldPoint(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0.mainCameraCom_:ScreenToWorldPoint(Vector3(arg_33_1, arg_33_2, arg_33_3))

	return var_33_0.x, var_33_0.z
end

function var_0_0.ShowScreenTap(arg_34_0, arg_34_1)
	if arg_34_0.screenTapCanvas == nil then
		arg_34_0.screenTap = GameObject.Find("UICamera/Canvas/UIScreenTap/ScreenTapUI")

		if arg_34_0.screenTap then
			arg_34_0.screenTapCanvas = arg_34_0.screenTap:GetComponent("CanvasGroup")
		end
	end

	if arg_34_0.screenTapCanvas then
		if arg_34_1 then
			arg_34_0.screenTapCanvas.alpha = 1
		else
			arg_34_0.screenTapCanvas.alpha = 0
		end
	end

	arg_34_0:ShowUID(arg_34_1)
end

return var_0_0
