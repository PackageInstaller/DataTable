-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryEntry.lua

module("logic.extensions.story.core.StoryEntry", package.seeall)

local M = class("StoryEntry")

M.defaultSceneId = 11000

local rescache = Astral.LuaResourceCache.Instance
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

function M:ctor()
	self._autoDelayTime = 0
	self.graphAsset = nil
	self.referenceAsset = nil
	self.animCfgAsset = nil
	self._active = false
	self._dispose = false
	self._isAuto = false
	self._storyId = nil
	self._binderGo = nil
	self._binderUrl = nil
	self._configUrl = nil
	self._storyProxy = nil
	self._bindComp = nil
	self.root = nil
	self.stage = nil
	self.scene2D = nil
	self.bgRootContain = nil
	self.globalFreeCamProxyInst = nil
	self.globalCharacterLightProxyInst = nil
	self.opening = false
	self._preBlendStyle = false
	self._preBlendTime = false
	self._cineBrain = false
	self._stayUI = false
	self._cacheViews = ViewStack.New()
	self._startPlayTime = 0
	self._endPlayTime = 0
	self._isClickSkip = false
end

function M:Open(paramData)
	self:Close()
	ViewMgr.instance:openSpecialView(ViewName.StoryloadingviewViewPresentor)
	StoryGameObjectPool.Init()

	self._dispose = false
	self.opening = true
	self._startPlayTime = ServerTime.now()
	self._autoDelayTime = 0
	self.paramData = paramData
	self._storyId = paramData.storyId
	self._stayUI = paramData.stayUI
	self._resetUI = paramData.resetUI
	self._finishFunc = finishFunc
	self._finishHandler = finishHandler

	local curSceneType = SceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Battle then
		self:_startStoryLoading(1000000)
	end

	if not self._stayUI then
		self:_closeAllView()
	end

	self._binderUrl = GameUrl.getStoryBinddataUrl(self._storyId)
	self._configUrl = GameUrl.getStoryCfgdataUrl(self._storyId)
	self._animCfgUrl = GameUrl.getStoryAnimcfgUrl(self._storyId)
	self._loader = StoryLoader.New()

	if rescache:ExistsResource(self._animCfgUrl) then
		self._loader:addUrl(self._animCfgUrl)
	end

	self._loader:addUrl(self._binderUrl)
	self._loader:addUrl(self._configUrl)
	self._loader:startLoad(self._allConfigLoaded, self)
end

function M:OpenWithData(paramData, jsonStr, binderAsset)
	self:Close()
	StoryGameObjectPool.Init()

	self._dispose = false
	self.opening = true
	self._startPlayTime = ServerTime.now()
	self._autoDelayTime = 0
	self.paramData = paramData
	self._storyId = paramData.storyId
	self.referenceAsset = binderAsset
	self.graphAsset = StoryAssetBuilder.BuildAsset(jsonStr)

	self:_checkStoryTypeAndStart()
end

function M:Close()
	if not self.opening then
		return
	end

	local _storyId = self._storyId
	local setting = self.graphAsset and self.graphAsset.settingData or false
	local _sceType = setting and setting.sceneType or false

	StoryFacde.instance:hideAll(StoryConst.DefaultStateKey)
	StoryViewStateModel.instance:onReset()
	StoryModel.instance:sendBattleEvent()
	StoryModel.instance:clear()
	StoryGameObjectPool.Dispose()
	SceneMapResMgr.instance:unload(self._sce3dUrl, false)

	self._sce3dUrl = nil

	StorySceneMgr.disposeAllSceneLoader()
	self:_clearAllTimer()

	self._active = false

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._stageLoader then
		self._stageLoader:dispose()

		self._stageLoader = nil
	end

	if self._storyProxy then
		self._storyProxy:OnStoryDestroy()
		self._storyProxy:Dispose()

		self._storyProxy = nil
	end

	if self.globalFreeCamProxyInst then
		goutil.destroy(self.globalFreeCamProxyInst.gameObject)
	end

	self.globalFreeCamProxyInst = nil

	if self.globalCharacterLightProxyInst then
		goutil.destroy(self.globalCharacterLightProxyInst.gameObject)
	end

	self.globalCharacterLightProxyInst = nil

	if not goutil.isNil(self.bgRootContain) then
		goutil.destroy(self.bgRootContain)

		self.bgRootContain = nil
	end

	goutil.destroy(self.stage)
	goutil.destroy(self._binderGo)
	ViewMgr.instance:close(ViewName.StoryViewViewPresentor)
	StoryModel.instance:revertBgmAndAmb()
	self:clearStoryCueSheet()

	self._endPlayTime = ServerTime.now()

	local playTime = self._endPlayTime - self._startPlayTime

	if not self._hasUpload then
		UserUtil.uploadStoryBuryPoint(self._storyId, self._isClickSkip, playTime)

		self._hasUpload = true
	end

	self.opening = false
	self._binderGo = nil
	self._binderUrl = nil
	self._configUrl = nil
	self._animCfgUrl = nil
	self._bindComp = nil
	self._storyId = nil
	self.paramData = nil
	self.graphAsset = nil
	self.referenceAsset = nil
	self.animCfgAsset = nil
	self.root = nil
	self.stage = nil
	self.scene2D = nil

	VolumeMgr.instance:turnOff(VolumeName.StroyComm)

	if enableLog then
		printInfo("清空剧情完毕", _storyId)
	end

	StoryDispatcher:dispatchEvent(StoryNotifyName.StoryExit, _storyId)
	ViewMgr.instance:openSpecialView(ViewName.StoryloadingviewViewPresentor)

	if _sceType == StoryConstDef.EStorySettingSceneType.S3D then
		SceneFace.instance:backScene()
	elseif _sceType == StoryConstDef.EStorySettingSceneType.S2D then
		SceneFace.instance:temporailyLeaveScene(false)
	end

	self:_resetCameraBlend()
end

function M:_resetCameraBlend()
	if not self._cineBrain then
		return
	end

	if self._preBlendStyle then
		CineCameraUtils.SetBlendStyle(self._cineBrain, self._preBlendStyle)
	end

	if self._preBlendTime then
		CineCameraUtils.SetBlendDuration(self._cineBrain, self._preBlendTime)
	end

	self._preBlendStyle = false
	self._preBlendTime = false
end

function M:_printViewBackStack(titleMsgStr)
	if enableLog then
		titleMsgStr = string.nilorempty(titleMsgStr) and "" or titleMsgStr

		local backStack = ViewMgr.instance._viewMgrImpl._backStack
		local backSize = backStack:getSize()
		local t = {
			titleMsgStr,
			string.format("界面返回堆栈共有[%s]个界面", backSize)
		}
		local viewInfo = false

		for i = backSize, 1, -1 do
			viewInfo = backStack:getDataByIndex(i)

			if viewInfo then
				table.insert(t, string.format("[%s]%s", i, viewInfo.viewName))
			end
		end

		printWarn(table.concat(t, "\n"))
	end
end

function M:Dispose()
	local _storyId = self:getStoryId()

	self:Close()
	GlobalDispatcher:dispatchEvent(EventType.StoryExit, _storyId)
end

function M:_clearAllTimer()
	removetimer(self._onFrame, self)
end

function M:getStoryId()
	return self._storyId
end

function M:SetActive(isActive)
	self._active = isActive == true

	goutil.setActive(self._binderGo, self._active)
end

function M:NextShot()
	local _nextId = self._storyProxy:GetNextShotId()

	if _nextId == -1 then
		printError("next shot id is nil")

		return
	end

	self:SwitchShot(_nextId, false)
end

function M:_GetCurrShotId()
	if self._storyProxy.PlayingShot then
		return self._storyProxy.PlayingShot.shotId
	end

	return -1
end

function M:_GetCurrIndex()
	local curShotId = self:_GetCurrShotId()

	return self:_GetShotIndex(curShotId)
end

function M:_GetShotIndex(shotId)
	local _index = self._storyProxy:GetShotIndex(shotId)

	return _index
end

function M:SwitchShot(shotId, isJump)
	local _index = self:_GetShotIndex(shotId)
	local isCloseStoryFinish = StoryController.instance:isCloseStoryFinish()

	print("story id=", self._storyId, "跳转id", shotId, "index=", _index, "isSwitching", self._isSwitching, "isCloseStoryFinish", isCloseStoryFinish, "isJump", isJump)

	if self._isSwitching then
		return
	end

	if isCloseStoryFinish then
		return
	end

	self._isJump = isJump

	if isJump then
		self._storyProxy:SwitchSeqShot(shotId, isJump)

		if isInEditorMode then
			StoryDispatcher:dispatchEvent(StoryNotifyName.StoryUpdateShotInfo, self._storyId, _index)
		end

		return
	end

	local shot = self._storyProxy:GetShot(shotId)

	if shot.config.needFade and not StoryModel.instance:getJumpState() then
		self._isSwitching = true
		self._targetSwitchId = shotId
		self._tempIndex = _index

		local fadeTime = shot.config.fadeTime or 1
		local _param = {
			fadeType = StoryConstDef.EFadeType.StartNode,
			fadeInTime = fadeTime / 2,
			fadeOutTime = fadeTime / 2,
			fadeColor = shot.config.fadeColor,
			fadeInCallBack = self._onBlackTweenDone,
			fadeInCallBackHandle = self
		}

		StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
	else
		self._storyProxy:SwitchSeqShot(shotId, isJump)

		if isInEditorMode then
			StoryDispatcher:dispatchEvent(StoryNotifyName.StoryUpdateShotInfo, self._storyId, _index)
		end
	end
end

function M:forceSwitch()
	self._isSwitching = false
	self._targetSwitchId = false
end

function M:_onBlackTweenDone()
	if self._targetSwitchId then
		self:_switchShot(self._targetSwitchId)

		self._targetSwitchId = nil
	end
end

function M:_switchShot(shotId)
	self._storyProxy:SwitchSeqShot(shotId, self._isJump or false)

	self._isSwitching = false

	if isInEditorMode then
		StoryDispatcher:dispatchEvent(StoryNotifyName.StoryUpdateShotInfo, self._storyId, self._tempIndex)
	end
end

function M:SetAuto(isAuto)
	self._isAuto = isAuto == true
end

function M:IsAuto()
	return self._isAuto
end

function M:CanAuto()
	return self.graphAsset.settingData.auto == true
end

function M:CanSkip()
	return self.graphAsset.settingData.skip == true
end

function M:IsRogue()
	return self.graphAsset.settingData.rogue or false
end

function M:IsFadeOut()
	return self.graphAsset.settingData.fadeOut or false
end

function M:getSce2DPos()
	return self.graphAsset.settingData.sce2DPos
end

function M:CheckCurrentFinish()
	if not self._storyProxy then
		return true
	end

	return self._storyProxy:CheckCurrentFinish()
end

function M:GotoShotEnd()
	if self._storyProxy.PlayingShot then
		self._storyProxy.PlayingShot:OnStoryUpdate(9999999)
	end
end

function M:SetSpeed(speed)
	if speed ~= self._storyProxy.speed then
		print("设置剧情播放速度==========", speed)
	end

	self._storyProxy.speed = speed
end

function M:GetSpeed()
	return self._storyProxy.speed
end

function M:IsEnd()
	if not self._storyProxy.PlayingShot then
		return false
	end

	return self._storyProxy.PlayingShot:IsEnd()
end

function M:IsCurrentBranch()
	local shot = self._storyProxy and self._storyProxy.PlayingShot or false

	if not shot then
		return false
	end

	return shot:ContainBranchEdge()
end

function M:IsCurrentManual()
	local shot = self._storyProxy and self._storyProxy.PlayingShot or false

	if not shot then
		return false
	end

	return shot:IsManual()
end

function M:hasExistBreak(curIndex)
	local nextGroupId = false
	local needBreak = false
	local jumpIndex = curIndex

	for index, shot in ipairs(self._storyProxy.sequenceShots) do
		if not shot then
			return false
		end

		if curIndex < index then
			for trackK, trackV in ipairs(shot.tracks) do
				if trackV.config.actionType == StoryActionTypeEnum.Branch then
					for sectionK, sectionV in ipairs(trackV.sections) do
						local questionArgInfo = sectionV.config:GetArgValueUInt(StoryArgKeyConst.RadionQuestionFlag)
						local tempQuestion = questionArgInfo > 0
						local tempShot = shot.shotId

						if tempQuestion then
							nextGroupId = tempShot
							needBreak = true
							jumpIndex = index

							break
						end
					end
				elseif trackV.config.actionType == StoryActionTypeEnum.Video then
					for sectionK, sectionV in ipairs(trackV.sections) do
						local tempShot = shot.shotId
						local canJump = sectionV.config:GetArgValueBoolean(StoryArgKeyConst.CamJumpVideo)
						local videoName = sectionV.config:GetArgValueUInt(StoryArgKeyConst.VideoName)

						if not string.nilorempty(videoName) then
							local videoCode = tonumber(videoName)
							local videoCO = VideoConfig.instance:getVideoInfoCO(videoCode)

							if videoCO and not canJump then
								nextGroupId = tempShot
								needBreak = true
								jumpIndex = index

								break
							end
						end
					end
				end
			end
		end
	end

	return needBreak, nextGroupId, jumpIndex
end

function M:getNextVideoPath()
	local _nextShotId = self._storyProxy:GetNextShotId()

	if _nextShotId == -1 then
		return false
	end

	local nextShot = self._storyProxy:GetShot(_nextShotId)

	if nextShot then
		for trackK, trackV in ipairs(nextShot.tracks) do
			if trackV.config.actionType == StoryActionTypeEnum.Video then
				for sectionK, sectionV in ipairs(trackV.sections) do
					local videoName = sectionV.config:GetArgValue(StoryArgKeyConst.VideoName)

					if not string.nilorempty(videoName) then
						local videoCode = tonumber(videoName)
						local videoCO = VideoConfig.instance:getVideoInfoCO(videoCode)

						if videoCO then
							local fullVideoPath = GameUrl.getVideoUrl(videoCO.name)

							return fullVideoPath
						end
					end
				end
			end
		end
	end

	return false
end

function M:getNextDialogType()
	local _nextShotId = self._storyProxy:GetNextShotId()

	if _nextShotId == -1 then
		return false, false
	end

	local nextShot = self._storyProxy:GetShot(_nextShotId)

	if nextShot then
		for trackK, trackV in ipairs(nextShot.tracks) do
			if trackV.config.actionType == StoryActionTypeEnum.Dialog then
				for sectionK, sectionV in ipairs(trackV.sections) do
					local dialogType = sectionV.config:GetArgValueEnum(StoryArgKeyConst.DialogType)

					if dialogType == StoryConstDef.EStoryDialogUIStyleType.Black then
						return true, false
					elseif dialogType == StoryConstDef.EStoryDialogUIStyleType.White then
						return false, true
					end
				end
			end
		end
	end

	return false, false
end

function M:getStageRes(resUrl)
	local resAsset = self._stageLoader:GetRes(resUrl)

	if resAsset then
		return resAsset:GetMainAsset()
	end

	return nil
end

function M:_onFrame()
	if not self._active then
		return
	end

	local _deltaTime = Time.deltaTime

	self._storyProxy:OnStoryUpdate(_deltaTime)

	if not self:CheckCurrentFinish() then
		return
	end

	local _isBranch = self:IsCurrentBranch()

	if _isBranch then
		return
	end

	local _autoPlaying = self:IsAuto()
	local _curIsOpNode = self:IsCurrentManual()

	if not _autoPlaying and _curIsOpNode then
		return
	end

	if _autoPlaying and _curIsOpNode and self._autoDelayTime < 0.5 then
		self._autoDelayTime = self._autoDelayTime + _deltaTime

		return
	end

	local isChapterVideoFinish = self:_isChapterVideo()

	if isChapterVideoFinish then
		return
	end

	local _hasAfflastuseEffect = StoryFacde.instance:hasAfflastuseEffect()

	if _hasAfflastuseEffect then
		return
	end

	self._autoDelayTime = 0

	if self:IsEnd() then
		StoryController.instance:Close()

		return
	end

	self:NextShot()
end

function M:_isChapterVideo()
	return StoryModel.instance:hasVideo()
end

function M:_allConfigLoaded()
	if self._dispose then
		return
	end

	local _binderRes = self._loader:GetRes(self._binderUrl)
	local _jsonRes = self._loader:GetRes(self._configUrl)
	local _animCfgRes = self._loader:GetRes(self._animCfgUrl)

	if not _binderRes or not _jsonRes then
		if enableErrorLog then
			printError(string.format("剧情配置不存在，ID：%s", self._storyId))
		end

		StoryController.instance:Close(true)

		return
	end

	local jsonStr = _jsonRes.textAsset

	self.referenceAsset = _binderRes:GetMainAsset()
	self.graphAsset = StoryAssetBuilder.BuildAsset(jsonStr)

	if _animCfgRes then
		self.animCfgAsset = _animCfgRes:GetMainAsset()
	end

	print("Start Story Fade In State", self.graphAsset.settingData.fadeIn)

	if self.graphAsset.settingData.fadeIn then
		self:_startStoryLoading(1000000)
	end

	self:_checkStoryTypeAndStart()
end

function M:_checkStoryTypeAndStart()
	local setting = self.graphAsset.settingData
	local _sceType = setting.sceneType

	if _sceType == StoryConstDef.EStorySettingSceneType.S3D then
		self._sceId = M.defaultSceneId

		GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._sceneFinish, self)
		SceneFace.instance:temporarilyChangeScene(SceneType.Story, self._sceId, true, true)
	elseif _sceType == StoryConstDef.EStorySettingSceneType.S2D then
		MainCameraMgr.instance:setCameraVisible(true)
		SceneFace.instance:temporailyLeaveScene(true, false)
		self:_realOpenStory()
	else
		self:_realOpenStory()
	end
end

function M:_sceneFinish(_, _curSceneType, _curSceneId)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._sceneFinish, self)

	if self._sceId == _curSceneId then
		self:_realOpenStory()
	end
end

function M:_realOpenStory()
	ViewMgr.instance:open(ViewName.StoryViewViewPresentor)

	self._binderGo = goutil.create("" .. self._storyId, false)
	self.root = self._binderGo
	self._bindComp = self._binderGo:AddComponent(typeof(StoryEngine.StoryDataBinder))

	self:_resetStoryRoot(self._binderGo)

	self.root.transform.localPosition = self.graphAsset.settingData.stagePos
	self.root.transform.localRotation = Quaternion.Euler(self.graphAsset.settingData.stageRotation)
	self.root.transform.localScale = Vector3.one
	self._bindComp.referenceAsset = self.referenceAsset

	self:_loadStageAndScene(self.graphAsset)
end

function M:_loadStageAndScene(asset)
	self._stageUrl = nil
	self._sce3dUrl = nil
	self._sce2dUrl = nil

	local setting = asset.settingData
	local tpl = setting.stageTpl
	local needLoad = false

	if not string.nilorempty(tpl) then
		self._stageUrl = StoryLogicResPathUtils.GetStoryStageUrl(tpl)
		needLoad = true
	end

	local _sceType = setting.sceneType

	if _sceType == StoryConstDef.EStorySettingSceneType.S3D then
		local sce3d = setting.sce3D

		if not string.nilorempty(sce3d) then
			self._sce3dUrl = StoryLogicResPathUtils.GetScenePath(sce3d)
			needLoad = true
		end
	elseif _sceType == StoryConstDef.EStorySettingSceneType.S2D then
		local sce2d = setting.sce2D

		if not string.nilorempty(sce2d) then
			self._sce2dUrl = StoryLogicResPathUtils.Get2DSceneUrl(sce2d)
			needLoad = true
		end
	end

	needLoad = true

	local _freeCamUrl = StoryLogicResPathUtils.GetFreeCamUrl()
	local _lightUrl = StoryLogicResPathUtils.GetCharcterLight()

	if not needLoad then
		self:_enterStory()

		return
	end

	self._stageLoader = StoryLoader.New()

	self._stageLoader:addUrl(_freeCamUrl)
	self._stageLoader:addUrl(_lightUrl)

	if self._stageUrl then
		self._stageLoader:addUrl(self._stageUrl)
	end

	if self._sce3dUrl then
		self._stageLoader:addUrl(self._sce3dUrl)
	end

	if self._sce2dUrl then
		self._stageLoader:addUrl(self._sce2dUrl)
	end

	self:_loadAllAnimation()
	self._stageLoader:startLoad(self._allSettingLoaded, self)
end

function M:_loadAllAnimation()
	if self.animCfgAsset then
		local count = self.animCfgAsset.idleAnims.Count

		for i = 1, count do
			local item = self.animCfgAsset:GetIdleAnimName(i - 1)

			if not string.nilorempty(item) then
				self._stageLoader:addUrl(item)
			end
		end

		count = self.animCfgAsset.headAnims.Count

		for i = 1, count do
			local item = self.animCfgAsset:GetHeadAnimName(i - 1)

			if not string.nilorempty(item) then
				self._stageLoader:addUrl(item)
			end
		end

		count = self.animCfgAsset.mouthAnims.Count

		for i = 1, count do
			local item = self.animCfgAsset:GetMouthAnimName(i - 1)

			if not string.nilorempty(item) then
				self._stageLoader:addUrl(item)
			end
		end

		count = self.animCfgAsset.faceAnims.Count

		for i = 1, count do
			local item = self.animCfgAsset:GetFaceAnimName(i - 1)

			if not string.nilorempty(item) then
				self._stageLoader:addUrl(item)
			end
		end
	end
end

function M:_allSettingLoaded()
	if self._dispose then
		return
	end

	if self._stageUrl then
		local _stageRes = self._stageLoader:GetRes(self._stageUrl)

		if _stageRes then
			local obj = _stageRes:GetMainAsset()

			self.stage = goutil.cloneAndSetParent(obj, self.root.transform, obj.name)

			GameUtils.setLocalPos(self.stage.gameObject, 0, 0, 0)
		elseif enableErrorLog then
			printError("舞台资源加载失败。", self._stageUrl)
		end
	else
		self.stage = goutil.create("stage_new", false)

		goutil.addChildToParent(self.stage, self.root)
		GameUtils.setLocalPos(self.stage.gameObject, 0, 0, 0)
	end

	if self._sce3dUrl then
		SceneUtils.SetActiveScene(self.graphAsset.settingData.sce3D .. "_run")
	end

	if self._sce2dUrl then
		local _s2dRes = self._stageLoader:GetRes(self._sce2dUrl)
		local obj = _s2dRes:GetMainAsset()
		local _s2dGo = goutil.cloneAndSetParent(obj, self.root.transform, obj.name)

		self.scene2D = _s2dGo

		local _s2dPos = self.graphAsset.settingData.sce2DPos
		local _s2dRot = self.graphAsset.settingData.sce2DRot
		local _s2dScale = self.graphAsset.settingData.sce2DScale

		GameUtils.setLocalPos(_s2dGo, _s2dPos.x, _s2dPos.y, _s2dPos.z)
		GameUtils.setLocalRotation(_s2dGo, _s2dRot.x, _s2dRot.y, _s2dRot.z)

		local bgTf = _s2dGo.transform:Find("bg_root/bg")

		CriWareVideoMgr.Get(bgTf.gameObject)
		GameUtils.setLocalScale(bgTf, _s2dScale.x, _s2dScale.y, 1)

		local bgRootObj = goutil.findChild(_s2dGo, "bg_root")

		self.bgRootContain = goutil.create("bg_contain", false)

		if kMainCamera and not goutil.isNil(self.bgRootContain) then
			goutil.addChildToParent(self.bgRootContain, kMainCamera)
			goutil.addChildToParent(bgRootObj, self.bgRootContain)
			StoryUtils.ResetTransform(self.bgRootContain)
		end
	end

	local _freeCamUrl = StoryLogicResPathUtils.GetFreeCamUrl()
	local _freeCamRes = self._stageLoader:GetRes(_freeCamUrl)
	local obj = _freeCamRes:GetMainAsset()
	local _freeCamGo = goutil.clone(obj, obj.name)
	local _inst = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(_freeCamGo)

	self.globalFreeCamProxyInst = _inst

	local _instGo = _inst.gameObject

	_instGo.name = "freeCamera"

	goutil.addChildToParent(_inst, self.stage)
	StoryUtils.ResetTransform(_instGo)
	self._bindComp:AddProxyPtr(StoryConstDef.FreeCameraTag, _inst, StoryPtrTag.SysFreeCamera)
	self._bindComp:SetProxyPtrVisible(StoryConstDef.FreeCameraTag, true, false)
	goutil.setActive(_instGo, false)

	local virtualCam = CinemachineVirtualCamAdapter.Get(_freeCamGo)

	virtualCam:SetCineVirtualCamPriority(100)

	self._cineBrain = VirtualCameraMgr.instance:getCinemachineBrain()
	self._preBlendStyle = CineCameraUtils.GetBlendStyle(self._cineBrain)
	self._preBlendTime = CineCameraUtils.GetBlendTime(self._cineBrain)

	CineCameraUtils.SetBlendStyle(self._cineBrain, Cinemachine.CinemachineBlendDefinition.Style.Cut)
	self:_createCharacterLight()
	self:_createVolumeRoot()
	self:_createParticleRoot()
	self:_enterStory()
end

function M:_enterStory()
	print("剧情配置环境加载完毕，准备创建剧情.......", self._storyId)

	self._storyProxy = StoryProxy.New()

	self._storyProxy:CreateGraph(self.graphAsset, self._bindComp)
	self:_addAllAssetPtr()
	self:_addStageCamAndPosPtr()
	self:_resetStageCameraOffsetAndVisible()
	self:CallStoryAwake()
	settimer(0, self._onFrame, self, true)
	self:SetActive(true)
	print("Story Start Need Fade Out ?", self.graphAsset.settingData.fadeOut)

	if self.graphAsset.settingData.fadeOut then
		self:_startStoryFadeout(0.3)
	else
		self:_startStoryFadeout(0)
	end

	local beginShotId = self.paramData.beginShotId or self._storyProxy:GetFirstShotId()

	self._storyProxy:SwitchSeqShot(beginShotId, false)

	if isInEditorMode then
		StoryDispatcher:dispatchEvent(StoryNotifyName.StoryUpdateShotInfo, self._storyId, 1)
	end
end

function M:_createCharacterLight()
	local _lightCamUrl = StoryLogicResPathUtils.GetCharcterLight()
	local _lightRes = self._stageLoader:GetRes(_lightCamUrl)
	local obj = _lightRes:GetMainAsset()
	local _lightGo = goutil.clone(obj, obj.name)
	local _inst = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(_lightGo)

	self.globalCharacterLightProxyInst = _inst

	local _instGo = _inst.gameObject

	_instGo.name = "characterLight"

	goutil.addChildToParent(_inst, self.stage)
	StoryUtils.ResetTransform(_instGo)
	self._bindComp:AddProxyPtr(StoryConstDef.CharacterLightTag, _inst, StoryPtrTag.CharacterLight)
	self._bindComp:SetProxyPtrVisible(StoryConstDef.CharacterLightTag, true, false)
	goutil.setActive(_instGo, false)
end

function M:_createVolumeRoot()
	local volumeRoot = goutil.create("volumeroot")

	volumeRoot.transform:SetParent(self.root.transform)
	StoryUtils.ResetTransform(volumeRoot.gameObject)
end

function M:_createParticleRoot()
	local root = goutil.create("particleRoot")

	root.transform:SetParent(self.root.transform)
	StoryUtils.ResetTransform(root.gameObject)
end

function M:CallStoryAwake()
	for index, item in ipairs(self._storyProxy.sequenceShots) do
		item:OnStoryAwake()
	end
end

function M:_resetStageCameraOffsetAndVisible()
	local outList = self._bindComp:FindIDPtrWithTypeAndTag(StoryResIDPtrType.GameObject, StoryPtrTag.FixCamera)
	local vect0 = Vector3.zero
	local vect1 = Vector3.one

	for i = 0, outList.Count - 1 do
		local item = outList[i]
		local proxy = item.targetObj

		if proxy then
			local target = proxy.target

			target.transform.localPosition = vect0
			target.transform.localScale = vect1
			target.transform.localRotation = Quaternion.identity

			goutil.setActive(proxy.proxyTarget, i == 0)
		end
	end
end

function M:_addStageCamAndPosPtr()
	if goutil.isNil(self.stage) then
		printError("不存在剧情stage===========")

		return
	end

	local camTf = self.stage.transform:Find("cameras")

	if camTf then
		local count = camTf.childCount
		local childTrf = {}

		for i = 0, count - 1 do
			local child = camTf:GetChild(i)

			table.insert(childTrf, child)
			CinemachineVirtualCamAdapter.Get(child.gameObject):SetCineVirtualCamPriority(1000)
		end

		local vect0 = Vector3.zero
		local vect1 = Vector3.one

		for i, item in ipairs(childTrf) do
			local proxyInst = goutil.create(item.name, false)

			proxyInst.layer = item.gameObject.layer

			proxyInst.transform:SetParent(camTf)

			proxyInst.transform.localPosition = item.localPosition
			proxyInst.transform.localScale = item.localScale
			proxyInst.transform.localRotation = item.localRotation

			item:SetParent(proxyInst.transform)

			item.transform.localPosition = vect0
			item.transform.localScale = vect1
			item.transform.localRotation = Quaternion.identity

			goutil.setActive(item.gameObject, true)

			local proxy = StoryEngine.StoryGameObjectInstProxy.Get(proxyInst, item.gameObject)

			self._bindComp:AddProxyPtr(proxyInst.name, proxy, StoryPtrTag.FixCamera)
			goutil.setActive(proxyInst, i == 0)
		end
	end

	local posTf = self.stage.transform:Find("positions")

	if posTf then
		local count = posTf.childCount

		for i = 0, count - 1 do
			local child = posTf:GetChild(i)
			local proxy = StoryEngine.StoryGameObjectInstProxy.Get(child.gameObject, child.gameObject)

			self._bindComp:AddProxyPtr(child.name, proxy, StoryPtrTag.FixPosition)
			goutil.setActive(child.gameObject, false)
		end
	end
end

function M:_addAllAssetPtr()
	local referenceAsset = self.referenceAsset
	local count = referenceAsset.BindList.Count

	for i = 1, count do
		local item = referenceAsset:GetBindWithIndex(i - 1)
		local resType = item.resType

		if resType == StoryRefereceResType.ModelPrefab then
			self._bindComp:AddAssetPtr(item.UID, item.reference, StoryPtrTag.ModelAsset, nil, item)
		elseif resType == StoryRefereceResType.Particle then
			self._bindComp:AddAssetPtr(item.UID, item.reference, StoryPtrTag.ParticleSystemAsset, nil, item)
		elseif resType == StoryRefereceResType.Timeline then
			self._bindComp:AddAssetPtr(item.UID, item.reference, StoryPtrTag.UnityTimeLineAsset, nil, item)
		elseif resType == StoryRefereceResType.Scene then
			self._bindComp:AddAssetPtr(item.UID, item.reference, StoryPtrTag.SceneAsset, nil, item)
		elseif resType == StoryRefereceResType.CharacterCam then
			self._bindComp:AddAssetPtr(item.UID, item.reference, StoryPtrTag.CharacterCamAsset, nil, item)
		end
	end
end

function M:_setCinemachineCamera(visible)
	local _scene = SceneMgr.instance:getCurScene()

	if _scene and _scene.camera then
		_scene.camera:setCinemachineBrainEnabled(visible)

		local _cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
		local _adapter = CinemachineBrainAdapter.Get(_cameraTarget:getGO())

		_adapter:SetCameraCutTime(0)
	end
end

function M:_resetStoryRoot(_proot)
	local _scene = SceneMgr.instance:getCurScene()

	if _scene then
		local _container = _scene:getContainer()

		goutil.addChildToParent(_proot, _container)

		_proot.transform.localScale = Vector3.one
		_proot.transform.localPosition = Vector3.zero
		_proot.transform.localRotation = Quaternion.identity

		return _proot
	else
		return nil
	end
end

function M:_startStoryLoading(time)
	if enableLog then
		printInfo("StoryControll::_startStoryLoading")
	end

	local fadeColor = self.graphAsset and self.graphAsset.settingData.fadeInColor or Color.New(0, 0, 0, 1)
	local _param = {
		fadeType = StoryConstDef.EFadeType.WaitStory,
		fadeColor = fadeColor,
		fadeInTime = time
	}

	StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
end

function M:_startStoryFadeout(time)
	local fadeColor = self.graphAsset and self.graphAsset.settingData.fadeInColor or Color.New(0, 0, 0, 1)
	local _param = {
		fadeType = StoryConstDef.EFadeType.StartStory,
		fadeColor = fadeColor,
		fadeOutTime = time
	}

	StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
end

function M:_closeAllView()
	self._cacheViews:clear()

	local backStack = ViewMgr.instance._viewMgrImpl._backStack
	local backSize = backStack:getSize()
	local itemInfo = false

	for i = backSize, 1, -1 do
		itemInfo = backStack:getDataByIndex(i)

		if itemInfo and ViewMgr.instance:isOpen(itemInfo.viewName) and itemInfo.viewName ~= ViewName.PlayerCreateMain and ViewName.BattleMain ~= itemInfo.viewName then
			print(string.format("当前关闭的UI是" .. itemInfo.viewName))
			self._cacheViews:push({
				viewName = itemInfo.viewName,
				openParam = itemInfo.openParam
			})
			ViewMgr.instance:close(itemInfo.viewName, false, WindowType.WindowCloseReasonType.QuickCloseType)
		end
	end

	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, false, BattleConst.StoryStateKey)
end

function M:openCacheView()
	if self._stayUI then
		return
	end

	if not self._resetUI then
		return
	end

	local backSize = self._cacheViews:getSize()
	local itemInfo = false

	for i = backSize, 1, -1 do
		itemInfo = self._cacheViews:getDataByIndex(i)

		if not ViewMgr.instance:isOpen(itemInfo.viewName) and itemInfo.viewName ~= ViewName.PlayerCreateMain and itemInfo.viewName ~= "waiting_view" then
			print(string.format("当前打开的UI是" .. itemInfo.viewName))
			ViewMgr.instance:open(itemInfo.viewName, itemInfo.openParam)
		end
	end

	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, true, BattleConst.StoryStateKey)
	self._cacheViews:clear()
end

function M:clearStoryCueSheet()
	if string.nilorempty(self._storyId) then
		return
	end

	local storyBgmCueSheetName = "music_juqing"

	CriwareAudioFacade.instance:unloadCueSheet(storyBgmCueSheetName)

	local cueSheetName = string.format("story_%s", self._storyId)

	CriwareAudioFacade.instance:unloadCueSheet(cueSheetName)
end

function M:setClickSkipState(value)
	self._isClickSkip = value
end

return M
