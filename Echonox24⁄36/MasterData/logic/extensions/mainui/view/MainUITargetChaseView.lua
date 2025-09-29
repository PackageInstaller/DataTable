-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUITargetChaseView.lua

module("logic.extensions.mainui.view.MainUITargetChaseView", package.seeall)

local M = class("MainUITargetChaseView", ViewComponent)

M.TimeToShowEff = 10

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasRoot = self:getUIComponent("main_view_-132674483", ComponentType.CanvasGroup)
	self._txtDesc = self:getUIComponent("main_view_1322543508", UIComponentType.Text)
	self._btnJump = self:getBtn("main_view_-709906022")
	self._animation = self:getUIComponent("main_view_-132674483", ComponentType.Animation)
	self._goEffect = goutil.findChild(self._canvasRoot.gameObject, "effect").gameObject

	goutil.setActive(self._goEffect, false)
end

function M:destroyUI()
	self._isEnter = nil
end

function M:bindEvents()
	self._btnJump:AddClickListener(self._onClickJump, self)
end

function M:unbindEvents()
	self._btnJump:RemoveClickListener()
end

function M:onEnter(reasonType)
	self._isEnter = true
	self._jumpId = nil
	self._taskId = nil
	self._isRepeatTask = nil

	goutil.setActive(self._goEffect, false)
	self:_setEvent(true)
	self:_setCanvasInteractable(self._canvasRoot, true)
	self:_refreshTarget(MainUITaskController.instance:getChaseTask())
end

function M:onEnterFinished()
	settimer(1, self._checkAnyTouch, self)
end

function M:onExit()
	self._isEnter = false

	self:_setEvent(false)

	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:_setCanvasInteractable(self._canvasRoot, false)
	removetimer(self._updateTimer, self)
	removetimer(self._checkAnyTouch, self)
	self:_setEffectShow(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.UPDATE_HOME_CHASE_TASK, self._handleUpdateHomeChaseTask, self)
	else
		GlobalDispatcher:removeEventListener(EventType.UPDATE_HOME_CHASE_TASK, self._handleUpdateHomeChaseTask, self)
	end
end

function M:_handleUpdateHomeChaseTask(e, taskId)
	if not self._isEnter then
		return
	end

	self:_refreshTarget(taskId)
end

function M:_updateTimer()
	if not self._isEnter then
		return
	end

	local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua

	if Input.IsAnyPointerPressed() then
		self._lastTouchTime = Time.time

		return
	end

	if Time.time - self._lastTouchTime >= M.TimeToShowEff and self._canPlayLongTimeTips and not GuideController.instance:isGuiding() then
		self:_setEffectShow(self._taskId and not self._isRepeatTask)

		self._canPlayLongTimeTips = false
	end
end

function M:_checkAnyTouch()
	if not self._isEnter then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	self._canPlayLongTimeTips = true
	self._lastTouchTime = Time.time

	removetimer(self._checkAnyTouch, self)
	settimer(0, self._updateTimer, self, true)
end

function M:_setCanvasInteractable(canvas, active)
	canvas.interactable = active
	canvas.blocksRaycasts = active
end

function M:_onClickJump()
	local jumpId = self._jumpId

	if not jumpId or not (jumpId > 0) then
		return
	end

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_refreshTarget(taskId)
	taskId = taskId or 0
	self._jumpId = nil
	self._taskId = nil
	self._isRepeatTask = nil

	local cfg

	if taskId > 0 then
		cfg = TaskConfig.instance:getConfigByKey(ConfigName.HomeChainTask, taskId, true)

		if not cfg then
			cfg = TaskConfig.instance:getConfigByKey(ConfigName.HomeRepeatTask, taskId)
			self._isRepeatTask = cfg ~= nil
		end
	end

	if cfg then
		local showStr = cfg.text
		local content = cfg.content
		local param = cfg.param
		local isOnline = cfg.isOnline

		self._jumpId = cfg.jump
		self._taskId = taskId

		if string.nilorempty(showStr) and not string.nilorempty(param) and content > 0 then
			local taskDesc, maxCount, isTaskGroup = TaskUtil.parseContent(content, param)

			if not string.nilorempty(taskDesc) then
				showStr = taskDesc
			end
		end

		self._txtDesc.text = lang("tip_task_recommend") .. showStr
	end

	goutil.setActive(self._btnJump.gameObject, self._jumpId and self._jumpId > 0)
	goutil.setActive(self._canvasRoot.gameObject, cfg)
end

function M:_setEffectShow(show)
	if not self._goEffect or goutil.isNil(self._goEffect) then
		return
	end

	goutil.setActive(self._goEffect, show)
	self._animation:Stop()
	self._animation:Play("huxi_anim")

	if not show then
		AnimationUtils.ResetAnimation(self._animation)
		self._animation:Stop()
	end
end

return M
