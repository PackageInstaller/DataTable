-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleScene2DOpen.lua

module("logic.extensions.story.core.logic.handles.StoryHandleScene2DOpen", package.seeall)

local M = class("StoryHandleScene2DOpen")
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kMainTex = UnityEngine.Shader.PropertyToID("_BaseMap")

function M:Handle(config, binder)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local bgRootContain = _storyEntry.bgRootContain
	local scene2d = _storyEntry.scene2D

	if goutil.isNil(scene2d) then
		printWarn("scene2d statge is nil")

		return
	end

	local bgRootGo = goutil.findChild(bgRootContain, "bg_root")

	if not bgRootGo then
		return
	end

	local bgObj = goutil.findChild(bgRootGo, "bg")

	self._effectBindObj = goutil.findChild(scene2d, "bgEffect")

	if self._effectBindObj then
		goutil.clearChildren(self._effectBindObj)
	end

	if not bgObj then
		return
	end

	if not self._scene2dLoader then
		self._scene2dLoader = StoryLoader.New()
	end

	goutil.setActive(bgObj, true)

	self._materialSetter = MaterialSetter.Get(bgObj)

	local isVideo = config:GetArgValueBoolean(StoryArgKeyConst.IsVideoSceneBg)
	local isFadeIn = config:GetArgValueBoolean(StoryArgKeyConst.IsFadeInBg)
	local scene2DValue = config:GetArgValue(StoryArgKeyConst.Scene2DValue)
	local offsetPos = config:GetArgValueVector3(StoryArgKeyConst.Scene2DOffsetPos)
	local resultPos = _storyEntry:getSce2DPos() + offsetPos

	GameUtils.setLocalPos(scene2d, resultPos.x, resultPos.y, resultPos.z)
	GameUtils.setLocalPos(bgRootContain, resultPos.x, resultPos.y, resultPos.z)

	self._videoMgr = CriWareVideoMgr.Get(bgObj)

	if isVideo then
		StoryModel.instance:setScene2dBgType(isVideo)

		local videoPath = VideoConfig.instance:getVideoInfoCO(tonumber(scene2DValue))
		local fullVideoPath = GameUrl.getVideoUrl(videoPath.name)

		self._videoMgr:PlayMovie(fullVideoPath, false, true)
	else
		local isVideoBg = StoryModel.instance:getScene2dBgType()

		if isVideoBg and self._videoMgr then
			self._videoMgr:DestroyMovie()

			self._videoMgr = nil
		end

		StoryModel.instance:setScene2dBgType(isVideo)

		local sceneCO = StorySceneConfig.instance:getPlotSceneInfoCO(tonumber(scene2DValue))

		if sceneCO then
			if not string.nilorempty(sceneCO.bgPath) then
				self._sce2dTexUrl = StoryLogicResPathUtils.Get2DSceneTextureUrl(sceneCO.bgPath)
			else
				self._sce2dTexUrl = false
			end

			self._sce2dEffectUrl = false

			local particleID = sceneCO.particleID

			if particleID > 0 then
				local effectCO = EffectConfig.instance:getEffectCO(particleID)

				if effectCO and effectCO.effectType == 3 then
					self._sce2dEffectUrl = StoryLogicResPathUtils.Get3dEffectSceneUrl(effectCO.resPath)
				end
			end

			if not self._sce2dTexUrl then
				local mRender = self._materialSetter:GetRender()

				if not goutil.isNil(mRender) then
					mRender.enabled = true
				end

				self._materialSetter:SetColor(kMainColorID, Color.New(0, 0, 0, 1))
			elseif StorySceneMgr.hasSceneLoader(self._sce2dTexUrl) then
				self:_scene2dLoadFinish()

				return
			end
		end

		if isFadeIn then
			self:_start2dBgFadeIn(0.5, 0.6, self._onFadeInFinish, self)
		else
			self:_onFadeInFinish()
		end
	end
end

function M:_start2dBgFadeIn(fadeInTime, fadeOutTime, callback, handle)
	local blackColor = Color.New(0, 0, 0, 1)
	local _param = {
		fadeType = StoryConstDef.EFadeType.Start2dBg,
		fadeColor = blackColor,
		fadeInTime = fadeInTime,
		fadeOutTime = fadeOutTime,
		fadeInCallBack = callback,
		fadeInCallBackHandle = handle
	}

	StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
end

function M:_onFadeInFinish()
	self:_startLoadingRes()
end

function M:_startLoadingRes()
	if self._sce2dTexUrl then
		self._scene2dLoader:addUrl(self._sce2dTexUrl)
	end

	if self._sce2dEffectUrl then
		self._scene2dLoader:addUrl(self._sce2dEffectUrl)
	end

	StorySceneMgr.addSceneLoader(self._sce2dTexUrl, self._scene2dLoader)
	self._scene2dLoader:startLoad(self._scene2dLoadFinish, self)
end

function M:_scene2dLoadFinish()
	if self._sce2dTexUrl then
		local _texRes = false
		local hasSceneLoader = StorySceneMgr.hasSceneLoader(self._sce2dTexUrl)

		if hasSceneLoader then
			local sceneLoader = StorySceneMgr.getSceneLoader(self._sce2dTexUrl)

			_texRes = sceneLoader:GetRes(self._sce2dTexUrl)
		else
			_texRes = self._scene2dLoader:GetRes(self._sce2dTexUrl)
		end

		local mRender = self._materialSetter:GetRender()

		if not goutil.isNil(mRender) then
			mRender.enabled = true
		end

		self._materialSetter:SetColor(kMainColorID, Color.New(1, 1, 1, 0))
		self._materialSetter:DOAlpha(kMainColorID, 1, 1)

		if _texRes then
			self._materialSetter:SetTexture(kMainTex, _texRes:GetMainAsset())
		end
	end

	if self._sce2dEffectUrl then
		local effectRes = self._scene2dLoader:GetRes(self._sce2dEffectUrl)
		local obj = effectRes:GetMainAsset()
		local effectGo = goutil.clone(obj, obj.name)

		goutil.addChildToParent(effectGo, self._effectBindObj)
		StoryUtils.ResetTransform(effectGo)
	end
end

return M
