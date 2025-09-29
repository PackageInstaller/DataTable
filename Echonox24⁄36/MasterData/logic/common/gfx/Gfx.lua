-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfx/Gfx.lua

module("logic.common.gfx.Gfx", package.seeall)

local M = class("Gfx")
local Const = GfxConst
local OSDef = Astral.OSDef

function M:init()
	GlobalDispatcher:addEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
	GfxConfig.syncReplaceSetting()

	self._model = GfxModel.instance

	self:_initQualitySettings()
	SpaceX.GraphicsUtils.SetEnableRuntimeUI(false)
	self:_loadAndInitSetting()
end

function M:_loadAndInitSetting()
	if isInEditorMode and Const.EDITOR_USE_MAX_QUALITY then
		self._model:clearLocalFrameStorage()
	end

	local gfxLevel = GfxGradeUtil.autoJudgeGfxLevel()

	self._model:setCurrentGfxLevel(gfxLevel)
	self._model:loadAndInitUserSettings()
	self:_applyGfxLevel(self._model:getCurGfx())
	CriwareAudioFacade.instance:initAllVolume()
end

function M:_initQualitySettings()
	local renderQualityData = CommonPreloader.instance:getAsset(CommonResPath.RenderQualityData)

	self._qualitySettings = SpaceX.RenderQualitySettings.New(renderQualityData)
end

function M:_onSettingContentChanged(e, settingKey, value)
	local current = self._model:getCurGfx()

	if settingKey == SettingConst.kGraphicsQuality then
		local gfxLevel = GfxConfig.index2GfxLevel(value)

		self._model:setCurrentGfxLevel(gfxLevel)
		self:_applyQuality(current)
		self:_updateCurResolution()
		self:_applyResolution(current)
		self:_updateCurFrame()
		self:_applyFrameRate(current.frameRate)
	elseif settingKey == SettingConst.kResolutionRatioQuality then
		local resolution = GfxConfig.index2Resolution(value)

		current.resolution = resolution

		self:_applyResolution(current)
	elseif settingKey == SettingConst.kGameFrame then
		local frameRate = GfxConfig.index2FrameRate(value)

		self._model:setCustomSetting("frameRate", frameRate)
		self._model:syncCustomSetting()
		self:_applyFrameRate(frameRate)
	elseif settingKey == SettingConst.kEffectQuality then
		self._model:setCustomSetting("effectQuality", value)
		self._model:syncCustomSetting()
	elseif settingKey == SettingConst.kGameAntialiasing then
		local isAntialiasingSwitch = value
		local massQuality = isAntialiasingSwitch and current.massQuality or Const.MsaaQuality.Disabled
		local antialiasingMode = isAntialiasingSwitch and current.antialiasingMode or Const.AntialiasingMode.None

		self:_applyAntialiasingMode(antialiasingMode, current.antialiasingQuality, massQuality)
	elseif settingKey == SettingConst.kGameHDR then
		self:_applyHdr(value)
	end
end

function M:_applyGfxLevel(gfxLevel)
	self:_applyQuality(gfxLevel)
	self:_applyFrameRate(gfxLevel.frameRate)
	self:_updateCurResolution(gfxLevel)
	self:_applyResolution(gfxLevel)

	if enableLog then
		print("current gfx level is:     ", gfxLevel.level)
	end
end

function M:_applyQuality(gfxLevel)
	SpaceX.GraphicsUtils.SetQuality(gfxLevel.name, true)
	SpaceX.GraphicsUtils.SetEffectQuality(gfxLevel.level)

	SpaceX.OptimizerMgr.Instance.logicUpdateInternal = 0

	local isAntialiasingSwitch = PlayerLocalStorageModel.instance:getAntialiasingSwitch()
	local massQuality = isAntialiasingSwitch and gfxLevel.massQuality or Const.MsaaQuality.Disabled
	local antialiasingMode = isAntialiasingSwitch and gfxLevel.antialiasingMode or Const.AntialiasingMode.None

	self:_applyAntialiasingMode(antialiasingMode, gfxLevel.antialiasingQuality, massQuality)
	self:_applyUIPostProcessing(gfxLevel.uiPostProcessing)
	self:_applyDefaultRenderQualitySettings(gfxLevel.renderQuality)
	self:_applyDefaultPipelineAsset(gfxLevel.assetUrl)
	self:_applySceneQuality()
	self:_applyHdr(PlayerLocalStorageModel.instance:getOpenHdr())
end

function M:_applyHdr(isOpen)
	SpaceX.GraphicsUtils.SetSupportHDR(isOpen)
end

function M:_applySceneQuality()
	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local onSetupSceneOptimization = scene.stage.onSetupSceneOptimization

	if onSetupSceneOptimization then
		scene.stage:onSetupSceneOptimization()
	end
end

function M:_applyDefaultRenderQualitySettings(renderQuality)
	SpaceX.GraphicsUtils.ApplyDefaultRenderQualitySettings(self._qualitySettings, renderQuality)
end

function M:_applyDefaultPipelineAsset(assetUrl)
	local pipelineAsset = CommonPreloader.instance:getAsset(assetUrl)

	SpaceX.GraphicsUtils.ApplyUniversalRenderPipelineAsset(pipelineAsset)
end

function M:_applyShaderQualitySettings(shaderQuality)
	if enableDebug then
		SpaceX.GraphicsUtils.ApplyShaderQualitySettings(self._qualitySettings, shaderQuality)
	end
end

function M:_applyResolution(gfxLevel)
	local renderScale = 1
	local isHighLevel = gfxLevel.level >= GfxConfig.QUALITY.high.level

	if not isInEditorMode and isHighLevel and OSDef.RunOS == OSDef.Win32 then
		renderScale = Const.PC_RENDER_SCALE

		if enableDebug then
			print("[gfx] current is pc, renderScale is:", renderScale)
		end
	elseif isHighLevel and DeviceUtil.isEmulator() then
		renderScale = Const.EMULATOR_RENDER_SCALE

		if enableDebug then
			print("[gfx] current is emulator, renderScale is:", renderScale)
		end
	else
		local resolution = gfxLevel.resolution > 0 and gfxLevel.resolution or UnityEngine.Screen.height

		renderScale = math.min(resolution / UnityEngine.Screen.height, 1)
		renderScale = math.max(renderScale, gfxLevel.minRenderScale)

		if enableDebug then
			print("[gfx] current is normal, renderScale is:", renderScale, "resolution :", resolution, "screen height :", UnityEngine.Screen.height)
		end
	end

	SpaceX.GraphicsUtils.SetMaxResolution(-1)
	SpaceX.GraphicsUtils.SetRenderScale(renderScale)
end

function M:_applyAntialiasingMode(antialiasingMode, antialiasingQuality, massCount)
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCamera = mainCameraTarget:getCamera()

	URPCameraUtils.SetAntialiasingMode(mainCamera, antialiasingMode)

	if antialiasingQuality ~= nil then
		URPCameraUtils.SetAntialiasingQuality(mainCamera, antialiasingQuality)
	end

	SpaceX.GraphicsUtils.SetMsaaSampleCount(massCount)
end

function M:_applyUIPostProcessing(enable)
	VolumeMgr.instance:setUICameraPostProcessingEnable(enable)
end

function M:_applyFrameRate(frameRate)
	UnityEngine.Application.targetFrameRate = frameRate
end

function M:_updateCurResolution(gfxLevel)
	local userResolutionIndex = PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local current = gfxLevel or self._model:getCurGfx()

	if userResolutionIndex > 0 then
		current.resolution = GfxConfig.index2Resolution(userResolutionIndex)
	end
end

function M:_updateCurFrame(gfxLevel)
	local userFrameRateIndex = PlayerLocalStorageModel.instance:getGameFrame()
	local current = gfxLevel or self._model:getCurGfx()

	if userFrameRateIndex > 0 then
		local frameRate = GfxConfig.index2FrameRate(userFrameRateIndex)

		current.frameRate = frameRate
	end
end

function M:forceHightResolution()
	self:_applyResolution(GfxConfig.QUALITY.high)
end

function M:resetCurrentResolution()
	self:_applyResolution(self._model:getCurGfx())
end

function M:getShaderQualitySettings()
	if enableDebug then
		return SpaceX.GraphicsUtils.GetShaderQuality(self._qualitySettings)
	end
end

function M:getShaderQualitySettingObj()
	if enableDebug then
		return self._qualitySettings
	end
end

M.instance = M.New()

return M
