-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryOperateViewComponent.lua

module("logic.extensions.story.view.StoryOperateViewComponent", package.seeall)

local M = class("StoryOperateViewComponent", ViewComponent)

M.MultipleSpeed = 4

function M:buildUI()
	self.go_mask = self:getGo("story_main_view_2025943221")
	self.btn_skip = self:getBtn("story_main_view_-1740199858")
	self.btn_auto = self:getBtn("story_main_view_1449351146")
	self.btn_history = self:getBtn("story_main_view_1164765235")
	self.btn_hide = self:getBtn("story_main_view_2051053975")
	self._btnAll = self:getBtn("story_main_view_-177114662")
	self.btnSkipCanvasGroup = self:getUIComponent("story_main_view_-1740199858", ComponentType.CanvasGroup)
	self.btnAutoCanvasGroup = self:getUIComponent("story_main_view_1449351146", ComponentType.CanvasGroup)
	self.btnHideCanvasGroup = self:getUIComponent("story_main_view_2051053975", ComponentType.CanvasGroup)
	self._togAll = self:getUIComponent("story_main_view_-177114662", UIComponentType.SpaceXToggle)
	self._maskClicker = Astral.UIClickTrigger.Get(self.go_mask)
	self._labDebugInfo = self:getUIComponent("story_main_view_-14073163", UIComponentType.TextMeshProUGUI)

	local autoBg = goutil.findChild(self.btn_auto.gameObject, "autoBg")

	self._autoPlayAnim = autoBg:GetComponent(ComponentType.Animation)
end

function M:bindEvents()
	self._maskClicker:AddClickListener(self._onClickMask, self)
	self._maskClicker:AddClickDownListener(self._onMaskDown, self)
	self._maskClicker:AddClickUpListener(self._onMaskUp, self)
	self.btn_skip:AddClickListener(self._onClickSkip, self)
	self.btn_auto:AddClickListener(self._onClickAuto, self)
	self.btn_history:AddClickListener(self._onClickHistory, self)
	self.btn_hide:AddClickListener(self._onClickHide, self)
	self._btnAll:AddClickListener(self.ReSetAutoAnimState, self)
end

function M:unbindEvents()
	self._maskClicker:RemoveClickListener()
	self._maskClicker:RemoveClickDownListener()
	self._maskClicker:RemoveClickUpListener()
	self.btn_skip:RemoveClickListener()
	self.btn_auto:RemoveClickListener()
	self.btn_history:RemoveClickListener()
	self.btn_hide:RemoveClickListener()
	self._btnAll:RemoveClickListener()
end

function M:onEnter()
	self:setSkipState(true)

	self._clickTime = 0
	self._clickIntervalTime = 0.3

	StoryDispatcher:addEventListener(StoryNotifyName.StoryShotEnter, self._onStoryShotEnter, self)
	StoryDispatcher:addEventListener(StoryNotifyName.StoryShotExit, self._onStoryShotExit, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogPrint, self.OnUIDialogPrint, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:addEventListener(StoryNotifyName.StorySwitchShotFinish, self.OnStorySwitchShotFinish, self)

	if isInEditorMode then
		StoryDispatcher:addEventListener(StoryNotifyName.StoryUpdateShotInfo, self.OnStoryUpdateShotInfo, self)
	end
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.StoryShotEnter, self._onStoryShotEnter, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.StoryShotExit, self._onStoryShotExit, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogPrint, self.OnUIDialogPrint, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.StorySwitchShotFinish, self.OnStorySwitchShotFinish, self)

	if isInEditorMode then
		StoryDispatcher:removeEventListener(StoryNotifyName.StoryUpdateShotInfo, self.OnStoryUpdateShotInfo, self)
	end
end

function M:onExitFinished()
	self._labDebugInfo.text = ""
	self._togAll.IsOn = false

	self:_setAutoPlay(false)
end

function M:destroyUI()
	return
end

function M:_onClickSkip()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_story_skip"))

	dialog:setConfirmListener(function()
		self:_doSkipStory()
	end, self)
end

function M:_doSkipStory()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local isBranch = _storyEntry:IsCurrentBranch()

	if isBranch then
		return
	end

	_storyEntry:setClickSkipState(true)

	local index = _storyEntry:_GetCurrIndex()
	local storyId = _storyEntry:getStoryId()
	local storyType = StoryModel.instance:getPlotType()

	GuideAgent.instance:sendJumpPlotRequest(storyId * 100 + index, storyType)

	local interruptSkip, jumpGroupId = StoryMgr.instance:checkInterruptSkip()
	local errorInfo = StoryModel.instance:getWrongStepInfo()

	if errorInfo then
		interruptSkip = true
		jumpGroupId = errorInfo.nextGroupId
	end

	if interruptSkip then
		StoryModel.instance:cacheUserJump()
		StoryModel.instance:setJumpAnimState(true)

		local function fadeInComplete()
			_storyEntry:SwitchShot(jumpGroupId, true)
		end

		local blackColor = Color.New(0, 0, 0, 1)
		local _param = {
			fadeInTime = 0.3,
			fadeType = StoryConstDef.EFadeType.Jump2FadeIn,
			fadeColor = blackColor,
			fadeInCallBack = fadeInComplete,
			fadeInCallBackHandle = self
		}

		StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
	else
		StoryController.instance:Close()
	end
end

function M:OnStorySwitchShotFinish(evt, isJump)
	if isJump then
		local blackColor = Color.New(0, 0, 0, 1)
		local _param = {
			fadeOutTime = 1,
			fadeType = StoryConstDef.EFadeType.Jump2FadeOut,
			fadeColor = blackColor
		}

		StoryDispatcher:dispatchEvent(StoryNotifyName.DoStoryFadeTween, _param)
	end
end

function M:OnStoryUpdateShotInfo(evt, storyId, index)
	if isInEditorMode then
		local storyInfo = string.format("storyId:%s,index:%s", storyId, index)

		self._labDebugInfo.text = storyInfo
	else
		self._labDebugInfo.text = ""
	end
end

function M:_onClickAuto()
	local _val = StoryController.instance:getAutoPlay()
	local _isAuto = not _val

	self:_setAutoPlay(_isAuto)
end

function M:_setAutoPlay(_isAuto)
	StoryController.instance:setAutoPlay(_isAuto)
	goutil.setActive(self.btn_hide.gameObject, not _isAuto)
	self:_setAutoAnimState(_isAuto)
	self:localNotify(StoryNotifyName.AutoPlay)
end

function M:_setAutoAnimState(_isAuto)
	if _isAuto then
		self._autoPlayAnim:Play()
	else
		self._autoPlayAnim:Stop()
	end
end

function M:ReSetAutoAnimState()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsAuto() then
		self:_setAutoAnimState(true)
	end
end

function M:_onClickHide()
	local _val = StoryController.instance:getHideState()
	local _isHide = not _val

	self:_setHideModel(_isHide)
end

function M:_setHideModel(_isHide)
	StoryController.instance:setHideUI(_isHide)

	if _isHide then
		StoryFacde.instance:hideAll(StoryConst.HideStateKey)
	else
		StoryFacde.instance:showAll(StoryConst.HideStateKey)
	end

	self:localNotify(StoryNotifyName.HideUIByManual, _isHide)
end

function M:_onClickHistory()
	self:_setAutoPlay(false)
	self:localNotify(StoryNotifyName.ShowHistoy)
end

function M:tryNextShot()
	self:_onClickMask()
end

function M:_onClickMask()
	local time = Time.time - self._clickTime

	if time < self._clickIntervalTime then
		return
	end

	self._clickTime = Time.time

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local isHideUI = StoryController.instance:getHideState()

	if isHideUI then
		self:_setHideModel(false)

		return
	end

	if self._togAll.IsOn then
		self._togAll.IsOn = false
	end

	local _isBranch = _storyEntry:IsCurrentBranch()

	if _isBranch then
		print("分支选项无法继续，请选择分支")

		return
	end

	local _finish = _storyEntry:CheckCurrentFinish()

	if self._canClickShowAll then
		StoryDispatcher:dispatchEvent(StoryNotifyName.UIDilaogShowAll)

		self._canClickShowAll = false

		return
	end

	if not _finish then
		_storyEntry:GotoShotEnd()

		if not _storyEntry:IsEnd() then
			_storyEntry:NextShot()
		end

		return
	end

	local _isManual = _storyEntry:IsCurrentManual()

	if _finish and _isManual then
		if _storyEntry:IsEnd() then
			StoryController.instance:Close()
		else
			_storyEntry:NextShot()
		end
	end
end

function M:_onStoryShotEnter()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	if self._pressDownForSpeed and _storyEntry:IsAuto() then
		_storyEntry:SetSpeed(M.MultipleSpeed)
	end

	if _storyEntry:IsAuto() and self._togAll.IsOn == true and self._autoPlayAnim.isPlaying == false then
		self:_setAutoAnimState(true)

		return
	end
end

function M:_onStoryShotExit()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	_storyEntry:SetSpeed(1)
end

function M:_onMaskDown(triggerIndex, param)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	if _storyEntry:IsAuto() and not self._pressDownForSpeed then
		removetimer(self._onPressDownForMultiSpeed, self)
		settimer(0.5, self._onPressDownForMultiSpeed, self, false)
	end
end

function M:_onPressDownForMultiSpeed()
	removetimer(self._onPressDownForMultiSpeed, self)

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	if _storyEntry:IsAuto() then
		self._pressDownForSpeed = true

		self:SetSpeed(M.MultipleSpeed)
	end
end

function M:_onMaskUp(triggerIndex, param)
	removetimer(self._onPressDownForMultiSpeed, self)

	local _isPressDown = self._pressDownForSpeed

	self._pressDownForSpeed = false

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	if _storyEntry:IsAuto() and _isPressDown then
		self:SetSpeed(1)
	end
end

function M:SetSpeed(speed)
	local curEntry = StoryController.instance:getCurStoryEntry()

	if not curEntry then
		return
	end

	curEntry:SetSpeed(speed)
	self:localNotify(StoryNotifyName.MultipleSpeed, speed)
end

function M:OnShowDialog(evt, data)
	self._canClickShowAll = false

	local _dialogType = data.dialogType

	if _dialogType <= StoryConstDef.EStoryDialogUIStyleType.Distance or _dialogType == StoryConstDef.EStoryDialogUIStyleType.Subtitle3d or _dialogType == StoryConstDef.EStoryDialogUIStyleType.Bubble or _dialogType == StoryConstDef.EStoryDialogUIStyleType.Film then
		self._canClickShowAll = true
	end
end

function M:OnUIDialogPrint(evt, progress, maxCount)
	if progress >= 1 then
		self._canClickShowAll = false
	end
end

function M:OnDialogExit()
	self._canClickShowAll = false
end

function M:setSkipState(enable)
	self.btnSkipCanvasGroup.alpha = enable and 1 or 0.4
	self.btnSkipCanvasGroup.interactable = enable
	self.btnAutoCanvasGroup.alpha = enable and 1 or 0.4
	self.btnAutoCanvasGroup.interactable = enable
	self.btnHideCanvasGroup.alpha = enable and 1 or 0.4
	self.btnHideCanvasGroup.interactable = enable
end

return M
