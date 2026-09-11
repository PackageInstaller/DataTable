local UIManager = class("UIManager")
local var_0_1 = "adv"

function UIManager:Ctor()
	self.uiMain = GameObject.Find("UICamera/Canvas/UIMain")
	self.uiStory = GameObject.Find("UICamera/Canvas/UIStory/Canvas")
	self.uiPop = GameObject.Find("UICamera/Canvas/UIPop/Canvas")
	self.uiMessage = GameObject.Find("UICamera/Canvas/UIMessage/Canvas")
	self.uiTips = GameObject.Find("UICamera/Canvas/UITips/Canvas")
	self.uiLoad = GameObject.Find("UICamera/Canvas/UILoad/Canvas")
	self.uiHPPanel = GameObject.Find("UICamera/Canvas/UIMain/HPPanel")

	self:InitFakeBackground()
	self:ShowBackground(false)

	self.mainCamera = GameObject.Find("MainCamera")
	self.canvas = GameObject.Find("UICamera/Canvas")
	self.uiCamera = self.canvas:GetComponent(typeof(Canvas)).worldCamera
	self.dontDestroyCanvas = GameObject.Find("UICamera_DontDestroy/Canvas")
	self.uiCanvasGroup = self.canvas:GetComponent("CanvasGroup")
	self.canvasSize_ = self.canvas:GetComponent("RectTransform").sizeDelta
	self.mainCamera.transform.localPosition = Vector3(0, 0, 2)
	self.mainCamera.transform.localEulerAngles = Vector3(0, 180, 0)
	self.mainCameraPos_ = Vector3(0, 0, 2)
	self.mainCameraRot_ = Vector3(0, 180, 0)
	self.mainCameraCom_ = self.mainCamera:GetComponent("Camera")
	self.cameraExtension = self.mainCamera:GetComponent(typeof(UnityEngine.Pipelines.SimPipeline.CameraExtension))
	self.sceneObject_ = {}
	self.canvasRate = self.canvas:GetComponent("RectTransform").sizeDelta.x / Screen.width
	self.UIDGo_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/UIDText")
	self.UIDGo_.layer = 18

	local var_1_0 = self.UIDGo_:AddComponent(typeof(Canvas))

	if not isNil(var_1_0) then
		var_1_0.overrideSorting = true
		var_1_0.sortingLayerName = "windowbg"
	end

	self.UIDText_ = self.UIDGo_:GetComponent(typeof(Text))
	self.tipImageRect_ = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/TipImage"):GetComponent(typeof(RectTransform))
end

function UIManager:InitFakeBackground()
	self.uiBackground = GameObject.Instantiate(self.uiHPPanel, self.uiMain.transform)
	self.uiBackground.name = "Background"

	local var_2_0 = self.uiBackground:GetComponent("RectTransform")

	var_2_0:SetSiblingIndex(0)

	var_2_0.anchorMin = Vector2.New(0, 0)
	var_2_0.anchorMax = Vector2.New(1, 1)
	var_2_0.offsetMin = Vector2.New(0, 0)
	var_2_0.offsetMax = Vector2.New(0, 0)
	self.uiBackground:AddComponent(typeof(Image)).color = Color.New(0.254902, 0.2862745, 0.345098)
end

local var_0_2 = 175

function UIManager:SetUIDText(arg_3_1, arg_3_2)
	if self.UIDText_ then
		self.UIDText_.text = arg_3_1
	end

	if self.UIDMarkText_ and GameToSDK.clientInfo.env == var_0_1 then
		if arg_3_1 == "" then
			self.UIDMarkText_.text = ""
		else
			local var_3_0 = arg_3_1

			for iter_3_0 = 1, var_0_2 do
				var_3_0 = var_3_0 .. "                        " .. arg_3_1
			end

			self.UIDMarkText_.text = var_3_0
		end
	end

	if self.UIDEncodeText_ and GameToSDK.clientInfo.env == var_0_1 then
		if self.encodePosTimer_ then
			self.encodePosTimer_:Stop()
		end

		if arg_3_1 == "" then
			self.UIDEncodeText_.text = ""
		else
			print("userId", arg_3_2)

			self.UIDEncodeText_.text = encodeUID(arg_3_2)
			self.encodePosTimer_ = Timer.New(function()
				if self.UIDEncodeTrs_ then
					math.randomseed(os.time())

					self.UIDEncodeTrs_.anchoredPosition = Vector3(math.random(250, _G.SCREEN_WIDTH - 250), math.random(40, _G.SCREEN_HEIGHT - 40), 0)
				end
			end, 1, -1)

			self.encodePosTimer_:Start()
		end
	end

	CustomLog.SetUserID(arg_3_1)
end

function UIManager:ShowUID(arg_5_1)
	SetActive(self.UIDGo_, arg_5_1)

	self.tipImageRect_.localPosition = arg_5_1 and self.tipImageRect_.localPosition - Vector3(0, 20, 0) or self.tipImageRect_.localPosition + Vector3(0, 20, 0)
end

function UIManager:SetMainActive(arg_6_1)
	SetActive(self.uiMain, arg_6_1)
end

function UIManager:SetMainCameraPos(arg_7_1)
	self.mainCamera.transform.localPosition = arg_7_1 or self.mainCameraPos_
end

function UIManager:SetMainCameraRot(arg_8_1)
	self.mainCamera.transform.localEulerAngles = arg_8_1 or self.mainCameraRot_
end

function UIManager:SetMainCameraFieldOfView(arg_9_1)
	self.mainCameraCom_.fieldOfView = arg_9_1
end

function UIManager:ShowBackground(arg_10_1)
	if not isNil(self.uiBackground) then
		SetActive(self.uiBackground, arg_10_1)
	end
end

function UIManager:SetMainCamera(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_2 and CameraCfg[arg_11_1] == nil then
		print("没有配置对应的相机位置:", arg_11_1)

		return
	end

	if not arg_11_2 then
		self.mainCamera.transform.localPosition = Vector3(CameraCfg[arg_11_1].position[1], CameraCfg[arg_11_1].position[2], CameraCfg[arg_11_1].position[3])
		self.mainCamera:GetComponent("Camera").orthographic = false
		self.mainCamera.transform.localEulerAngles = Vector3(CameraCfg[arg_11_1].rotate[1], CameraCfg[arg_11_1].rotate[2], CameraCfg[arg_11_1].rotate[3])
		self.mainCameraCom_.fieldOfView = CameraCfg[arg_11_1].fieldOfView
	end

	if self.sceneGo_ then
		LuaForUtil.SetSceneSetting(self.sceneGo_, false)
		SetActive(self.sceneGo_, false)

		self.sceneGo_ = nil
	end

	local var_11_0 = arg_11_1

	if not arg_11_2 then
		if CameraCfg[arg_11_1].multiscene == 1 then
			if CameraCfg[arg_11_1].type == "home" or CameraCfg[arg_11_1].type == "chat" or CameraCfg[arg_11_1].type == "playerInfo" then
				var_11_0 = arg_11_4 and manager.loadScene:GetPreviewHomeShouldLoadSceneName() or manager.loadScene:GetHomeShouldLoadSceneName()
			elseif CameraCfg[arg_11_1].type == "homePreview" then
				var_11_0 = manager.loadScene:GetPreviewHomeShouldLoadSceneName()
			end
		else
			var_11_0 = CameraCfg[arg_11_1].sceneName
		end
	end

	if var_11_0 and var_11_0 ~= "" then
		self.sceneGo_ = self:GetSceneByName(var_11_0)

		if self.sceneGo_ then
			LuaForUtil.SetSceneSetting(self.sceneGo_, true)
			SetActive(self.sceneGo_, not arg_11_3)
		end
	end
end

function UIManager:GetSceneSetting()
	local var_12_0 = SceneManager.GetActiveScene()
	local var_12_1 = var_12_0:GetRootGameObjects()
	local var_12_2

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

function UIManager:GetSceneSettingBySceneName(arg_13_1)
	local var_13_0 = SceneManager.GetSceneByName(arg_13_1)
	local var_13_1 = var_13_0:GetRootGameObjects()
	local var_13_2

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

function UIManager:SetSceneLightEffect(arg_14_1)
	if arg_14_1 == nil then
		if not isNil(self.sceneLightEffectGo_) then
			Object.Destroy(self.sceneLightEffectGo_)
		end

		if self.lastPath_ then
			Asset.Unload(self.lastPath_)
		end

		self.lastPath_ = nil

		return
	end

	if isNil(self.sceneGo_) then
		return
	end

	if self.lastPath_ == arg_14_1 and not isNil(self.sceneLightEffectGo_) then
		return
	end

	if not isNil(self.sceneLightEffectGo_) then
		Object.Destroy(self.sceneLightEffectGo_)
	end

	self.lastPath_ = arg_14_1
	self.sceneLightEffectGo_ = Object.Instantiate(Asset.Load(arg_14_1), self.sceneGo_.transform)
end

function UIManager:SetSceneWeatherEffect(arg_15_1)
	if isNil(self.sceneGo_) then
		return
	end

	if self.lastPath_ == arg_15_1 and not isNil(self.sceneWeatherEffectGo_) then
		return
	end

	if not isNil(self.sceneWeatherEffectGo_) then
		Object.Destroy(self.sceneWeatherEffectGo_)
	end

	self.lastPath_ = arg_15_1
	self.sceneWeatherEffectGo_ = Object.Instantiate(Asset.Load(arg_15_1), self.sceneGo_.transform)
end

function UIManager:GetSceneByName(arg_16_1)
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

function UIManager:ResetMainCamera()
	self:SetMainCamera("null")

	if self.sceneGo_ then
		LuaForUtil.SetSceneSetting(self.sceneGo_, false)
		SetActive(self.sceneGo_, false)

		self.sceneGo_ = nil
	end
end

function UIManager:SetScene(arg_18_1)
	self.sceneGo_ = arg_18_1
end

function UIManager:SetMainCameraCom(arg_19_1, arg_19_2)
	local var_19_0 = self.mainCamera:GetComponent(arg_19_1)

	if var_19_0 then
		var_19_0.enabled = arg_19_2
	end
end

function UIManager:AddMainCameraCom(arg_20_1)
	return GameObjectTools.GetOrAddComponent(self.mainCamera, arg_20_1)
end

function UIManager:SetUISeparateRender(arg_21_1, arg_21_2)
	if self.cameraExtension then
		self.cameraExtension.uiSeparateRender = arg_21_1
	end

	if arg_21_2 and UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance then
		UnityEngine.Pipelines.SimPipeline.CanvasManager.Instance.uiSeparate = arg_21_1
	end
end

function UIManager:GetUISeparateRender()
	if self.cameraExtension then
		return self.cameraExtension.uiSeparateRender
	end

	return false
end

function UIManager:GetCanvasSize()
	return self.canvasSize_
end

function UIManager:SetSceneObject(arg_24_1, arg_24_2)
	self.sceneObject_[arg_24_1] = arg_24_2
end

function UIManager:GetSceneObject(arg_25_1)
	if self.sceneObject_[arg_25_1] == nil then
		self.sceneObject_[arg_25_1] = GameObject.Find(arg_25_1)
	end

	return self.sceneObject_[arg_25_1]
end

function UIManager:UIEventEnabled(arg_26_1)
	if self.isForce_ then
		return
	end

	self:EventEnabled(arg_26_1)
end

function UIManager:UIEventEnabledByUI(arg_27_1, arg_27_2)
	self.isForce_ = arg_27_2

	self:EventEnabled(arg_27_1)
end

function UIManager:SetCanvasAlpha(arg_28_1)
	if self.uiCanvasGroup then
		self.uiCanvasGroup.alpha = arg_28_1
	end
end

function UIManager:EventEnabled(arg_29_1)
	if self.uiCanvasGroup then
		self.uiCanvasGroup.blocksRaycasts = arg_29_1
	end
end

function UIManager:GetIsUIEventEnabled()
	if self.uiCanvasGroup then
		return self.uiCanvasGroup.blocksRaycasts
	end
end

function UIManager:Dispose()
	self:ShowBackground(false)

	if self.guideUI_ then
		Object.Destroy(self.guideUI_)

		self.guideUI_ = nil
	end

	if self.encodePosTimer_ then
		self.encodePosTimer_:Stop()
	end

	if self.sceneGo_ then
		LuaForUtil.SetSceneSetting(self.sceneGo_, false)
		SetActive(self.sceneGo_, false)

		self.sceneGo_ = nil
	end

	self.uiCanvasGroup = nil
	self.uiMain = nil
	self.uiPop = nil
	self.uiMessage = nil
	self.uiTips = nil
	self.uiLoad = nil
	self.uiHPPanel = nil
	self.uiCamera = nil
	self.sceneObject_ = {}
	self.lastPath_ = nil
	self.sceneLightEffectGo_ = nil
	self.sceneWeatherEffectGo_ = nil
end

function UIManager:AdaptUIByFOV()
	local var_32_0 = math.deg(2 * math.atan(2 * 1000000 * math.tan(math.rad(self.mainCameraCom_.fieldOfView * 0.5)) * self.mainCameraCom_.aspect * 0.5 / 1000000))

	print("该界面的水平FOV为：", var_32_0)

	if var_32_0 < 46 then
		self.mainCameraCom_.fieldOfView = math.deg(2 * math.atan(2 * 1000000 * math.tan(math.rad(46 * 0.5)) / self.mainCameraCom_.aspect * 0.5 / 1000000))
	end
end

function UIManager:ScreenToWorldPoint(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = self.mainCameraCom_:ScreenToWorldPoint(Vector3(arg_33_1, arg_33_2, arg_33_3))

	return var_33_0.x, var_33_0.z
end

function UIManager:ShowScreenTap(arg_34_1)
	if self.screenTapCanvas == nil then
		self.screenTap = GameObject.Find("UICamera/Canvas/UIScreenTap/ScreenTapUI")

		if self.screenTap then
			self.screenTapCanvas = self.screenTap:GetComponent("CanvasGroup")
		end
	end

	if self.screenTapCanvas then
		self.screenTapCanvas.alpha = arg_34_1 and 1 or 0
	end

	self:ShowUID(arg_34_1)
end

return UIManager
