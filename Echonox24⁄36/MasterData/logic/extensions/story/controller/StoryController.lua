-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/StoryController.lua

module("logic.extensions.story.controller.StoryController", package.seeall)

local M = class("StoryController", BaseController)

function M:onLateInit()
	self._curEntry = nil
	self._isHideUI = false
	self._isPlay = false
	self._cameraClearFlagIsSky = true
	self._cameraClearColr = false
end

function M:preCreate()
	ViewMgr.instance:preCreate(ViewName.StoryloadingviewViewPresentor)
	ViewMgr.instance:preCreate(ViewName.StoryViewViewPresentor)
end

function M:onReset()
	self:CloseAll()

	self._isHideUI = false
	self._isPlay = false

	self:clearCacheStory()
end

function M:Open(storyId, callback, callbackhandel, stayUI, plotType, resetUI)
	if self._isPlay then
		self:_cacheNextStory(storyId, callback, callbackhandel, stayUI, plotType)

		return
	end

	self:recordCameraInfo()
	self:CloseCurStoryEntry()
	self:preCreate()
	StoryModel.instance:cacheFeature()
	self:changeCameraType()
	CriwareAudioFacade.instance:stopVoice()
	printInfo("打开剧情,id=", storyId)

	local entry = StoryEntry.New()

	self._curEntry = entry

	local paramData = {}

	paramData.storyId = storyId
	paramData.stayUI = stayUI or false

	if type(resetUI) == "number" then
		paramData.resetUI = resetUI == 1
	else
		paramData.resetUI = true
	end

	self._callback = callback
	self._callbackhandel = callbackhandel

	printInfo("剧情回调", self._callback, storyId)
	entry:Open(paramData)

	self._isPlay = true
end

function M:Close(force)
	if self._isCloseStoryFinish then
		return
	end

	printInfo("剧情准备关闭:", force)

	local existOutline = StoryModel.instance:getFeature(RendererFeatureName.Outline)

	if not existOutline then
		SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(false)
	end

	if force then
		self._isCloseStoryFinish = true

		self:_endStory()
	else
		local errorInfo = StoryModel.instance:getWrongStepInfo()

		if errorInfo then
			local _curEntry = self:getCurStoryEntry()

			if _curEntry then
				_curEntry:SwitchShot(errorInfo.nextGroupId, true)
			end
		else
			self._isCloseStoryFinish = true

			self:_startFadeOutSotry()
		end
	end
end

function M:_realCloseStory()
	if not self._isPlay then
		return
	end

	self:OpenCacheView()

	if self._callback then
		local storyId = self._curEntry and self._curEntry:getStoryId() or false

		self._callback(self._callbackhandel, storyId)

		self._callback = false

		printInfo("剧情回调执行", storyId)
	end

	self:CloseCurStoryEntry()

	self._isPlay = false

	printInfo("关闭剧情-----------")

	local hasNext = self:_tryNextStory()

	if not hasNext then
		self:resetCameraType()
	end
end

function M:_startFadeOutSotry()
	local isFadeOut = self:IsFadeOut()

	printInfo("准备关闭剧情 淡出", isFadeOut)

	if isFadeOut then
		local function fadeInFunc()
			self:_realCloseStory()
		end

		local function fadeOutFunc()
			self._isCloseStoryFinish = false

			ViewMgr.instance:close(ViewName.StoryloadingviewViewPresentor)
		end

		local fadeOutColor = self._curEntry.graphAsset.settingData.fadeOutColor or Color.New(0, 0, 0, 1)
		local _param = {
			fadeOutTime = 0.5,
			fadeInTime = 0.5,
			fadeType = StoryConstDef.EFadeType.EndStory,
			fadeColor = fadeOutColor,
			fadeInCallBack = fadeInFunc,
			fadeInCallBackHandle = self,
			fadeOutCallBack = fadeOutFunc,
			fadeOutCallBackHandle = self
		}

		StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
	else
		self:_endStory()
	end
end

function M:_endStory()
	self:_realCloseStory()
	ViewMgr.instance:close(ViewName.StoryloadingviewViewPresentor)

	self._isCloseStoryFinish = false
end

function M:isCloseStoryFinish()
	return self._isCloseStoryFinish
end

function M:CloseAll()
	self:CloseCurStoryEntry()
end

function M:OpenCacheView()
	if self._curEntry then
		self._curEntry:openCacheView()
	end
end

function M:CloseCurStoryEntry()
	if self._curEntry then
		self._curEntry:Dispose()
	end

	self._curEntry = nil
end

function M:getCurStoryEntry()
	return self._curEntry
end

function M:setAutoPlay(val)
	local curEntry = self:getCurStoryEntry()

	if curEntry then
		curEntry:SetAuto(val)
	end
end

function M:getAutoPlay()
	local curEntry = self:getCurStoryEntry()

	return curEntry and curEntry:IsAuto() or false
end

function M:IsFadeOut()
	local curEntry = self:getCurStoryEntry()

	return curEntry and curEntry:IsFadeOut() or false
end

function M:setHideUI(val)
	self._isHideUI = val
end

function M:getHideState()
	return self._isHideUI or false
end

function M:isInStory()
	return self._isPlay or false
end

function M:parsePlayerName(content, dialogType)
	if string.nilorempty(content) then
		return content
	end

	local _name = PlayerModel.instance:getNickName()

	if string.nilorempty(_name) then
		_name = "[玩家昵称]"
	end

	local _newName = _name

	if dialogType == StoryConstDef.EStoryDialogUIStyleType.Film then
		_newName = string.format("<color=#%s>%s</color>", "c93b3b", _name)

		return string.gsub(content, "{username}", _newName)
	else
		return string.gsub(content, "{username}", _name)
	end
end

function M:isPlayerName(content)
	if string.nilorempty(content) then
		return false
	end

	local _start = string.find(content, "{username}")

	return _start ~= nil
end

function M:EditorOpen(jsonStr, binddata, jumpId)
	self:CloseAll()

	local entry = StoryEntry.New()

	self._curEntry = entry

	local paramData = {}

	paramData.storyId = "_temp"
	paramData.beginShotId = jumpId

	entry:OpenWithData(paramData, jsonStr, binddata)
end

function M:EditorSwitch(jumpId)
	local _curEntry = self:getCurStoryEntry()

	if not _curEntry then
		return
	end

	if _curEntry._storyProxy then
		_curEntry:SwitchShot(jumpId)
	end
end

function M:EditorEvaluate(time)
	local _curEntry = self:getCurStoryEntry()

	if not _curEntry then
		return
	end

	if _curEntry._storyProxy and _curEntry._storyProxy.PlayingShot then
		_curEntry._storyProxy.PlayingShot:Evaluate(time)
	end
end

function M:OnRebuildGraph(jsonStr, binderAsset)
	local _curEntry = self:getCurStoryEntry()

	if not _curEntry then
		return
	end

	if _curEntry._storyProxy then
		_curEntry.referenceAsset = binderAsset
		_curEntry.graphAsset = StoryAssetBuilder.BuildAsset(jsonStr)

		_curEntry._storyProxy:CreateGraph(_curEntry.graphAsset, _curEntry._bindComp)
	end
end

function M:OnAssetDataChanged(shotId, evTime)
	local _curEntry = self:getCurStoryEntry()

	if not _curEntry then
		return
	end

	if _curEntry._storyProxy then
		_curEntry._storyProxy.globalShot:OnShotEnter(shotId)
		_curEntry._storyProxy.PlayingShot:OnStoryExit()
		_curEntry._storyProxy.PlayingShot:OnStoryEnter()
		_curEntry._storyProxy.PlayingShot:Evaluate(evTime)
	end
end

function M:_cacheNextStory(storyId, finishFunc, finishHandler, stayUI, plotType)
	self._nextStoryMap = self._nextStoryMap or {}

	if not self._nextStoryMap[storyId] then
		self._nextStoryMap[storyId] = {}
	end

	local curEntry = self:getCurStoryEntry()

	if curEntry then
		if curEntry:getStoryId() == storyId then
			return
		end

		printInfo("当前播放的剧情:", curEntry:getStoryId())
	end

	printInfo("缓存剧情:", storyId)

	self._nextStoryMap[storyId] = {
		storyId = storyId,
		callBack = finishFunc,
		handler = finishHandler,
		stayUI = stayUI,
		plotType = plotType
	}

	if curEntry and not curEntry:getStoryId() then
		printInfo("show next story id ", storyId)
		self:_tryNextStory()
	end
end

function M:_tryNextStory()
	if self._nextStoryMap and not self._isPlay then
		local nextStoryId = false

		for k, v in pairs(self._nextStoryMap) do
			nextStoryId = v.storyId

			printInfo("触发缓存剧情", nextStoryId, v.callBack)

			self._isCloseStoryFinish = false

			self:Open(nextStoryId, v.callBack, v.handler, v.stayUI, v.plotType)

			break
		end

		if nextStoryId then
			self._nextStoryMap[nextStoryId] = nil
		end

		return nextStoryId
	end

	return false
end

function M:clearCacheStory()
	if self._nextStoryMap then
		table.clear(self._nextStoryMap)
	end

	self._nextStoryMap = false
end

function M:changeCameraType()
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCameraComp = mainCameraTarget:getCamera()

	URPCameraUtils.SetBackgroundTypeColor(mainCameraComp, "#000000")
end

function M:resetCameraType()
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCameraComp = mainCameraTarget:getCamera()
end

function M:recordCameraInfo()
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCameraComp = mainCameraTarget:getCamera()

	if mainCameraComp then
		self._cameraClearFlagIsSky = mainCameraComp.clearFlags == UnityEngine.CameraClearFlags.Skybox

		if self._cameraClearFlagIsSky then
			self._cameraClearColr = mainCameraComp.backgroundColor
		end
	end
end

M.instance = M.New()

return M
