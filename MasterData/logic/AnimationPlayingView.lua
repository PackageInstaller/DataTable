-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/view/AnimationPlayingView.lua

module("logic.extensions.video.view.AnimationPlayingView", package.seeall)

local AnimationPlayingView = class("AnimationPlayingView", ViewComponent)

function AnimationPlayingView:buildUI()
	AnimationPlayingView.super.buildUI(self)

	local canvas = self.mainGO:GetComponent(typeof(UnityEngine.Canvas))

	self._worldCamera = canvas.worldCamera
	self._passBtn = self:getBtn("rightTop/PassNode")
end

function AnimationPlayingView:bindEvents()
	AnimationPlayingView.super.bindEvents(self)
	self._passBtn:AddClickListener(self._onClickPass, self)
end

function AnimationPlayingView:_onClickPass()
	if not self._isPlayingAnimation then
		return
	end

	if self._animPlayer then
		self._animPlayer:PauseAll()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), "确定跳过此段动画吗？", function()
		if self._animPlayer then
			self._animPlayer:ResumeAll()
			self._animPlayer:Stop()
		end
	end, function()
		if self._animPlayer then
			self._animPlayer:ResumeAll()
		end
	end, "确定", "取消")
end

function AnimationPlayingView:unbindEvents()
	AnimationPlayingView.super.unbindEvents(self)
	self._passBtn:RemoveClickListener()
end

function AnimationPlayingView:onEnter()
	AnimationPlayingView.super.onEnter(self)
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", self.mainGO)
	self._passBtn.gameObject:SetActive(false)

	self._animationConfig = self:getFirstParam()

	if self._animationConfig.passable == nil then
		self._animationConfig.passable = true
	end

	local animName = self._animationConfig.animName

	if not string.find(animName, "txt") then
		animName = animName .. ".txt"
	end

	if not string.find(animName, "storyconfig/animations/") then
		animName = "storyconfig/animations/" .. animName
	end

	self._animPlayer = AnimationPlayer.play(animName, self._onAnimPlayFinish, self._onAnimPlayStart, self, self._animationConfig.speed or 1, self._animationConfig.autoClear, self._animationConfig.needPrepareResources, self._animationConfig.targets)

	self._animPlayer:setEvtHandler(self._animationConfig.animEventHandler, self._animationConfig.callbackTarget)

	if self._animationConfig.passable then
		self._animPlayer:EnabledClickSkip(false)
	end

	if not self._animationConfig.layer then
		local layer = SceneLayer.UI3DEx_Value

		Framework.GameObjectUtil.SetLayerRecursively(self.mainGO, layer)

		self._worldCamera.cullingMask = GoUtil.MaskLayer(0, layer)
	end
end

function AnimationPlayingView:onExit()
	ViewMgr.instance:setCustomViewAttachNode("popupwindow", nil)

	self._isPlayingAnimation = nil
	self._animationConfig = nil

	if self._animPlayer then
		self._animPlayer:Stop()

		self._animPlayer = nil
	end

	AnimationPlayingView.super.onExit(self)

	if TipsFacade.popupWindowSource == self._viewPresentor.viewName and not ViewMgr.instance:isPermanent(ViewName.Popupwindow) then
		ViewMgr.instance:close(ViewName.Popupwindow)
	end
end

function AnimationPlayingView:_onAnimPlayStart()
	self._isPlayingAnimation = true

	self._passBtn.gameObject:SetActive(self._animationConfig.passable or false)
	self:_doCallback(self._animationConfig.animStartCallback, self._animationConfig.callbackTarget)
end

function AnimationPlayingView:_doCallback(callabck, obj)
	if callabck then
		if obj then
			callabck(obj)
		else
			callabck()
		end
	end
end

function AnimationPlayingView:_onAnimPlayFinish()
	self._isPlayingAnimation = nil
	self._animPlayer = nil

	if not self._animationConfig then
		return
	end

	local finishCallback = self._animationConfig.animFinishCallback
	local finishCallbackObj = self._animationConfig.callbackTarget

	self:close()
	self:_doCallback(finishCallback, finishCallbackObj)
end

function AnimationPlayingView:close()
	ViewMgr.instance:close(self._viewPresentor.viewName)
end

return AnimationPlayingView
