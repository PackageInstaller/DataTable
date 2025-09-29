-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryFullTextView.lua

module("logic.extensions.story.view.StoryFullTextView", package.seeall)

local M = class("StoryFullTextView", ViewComponent)
local FullTxtSetp = StoryConstDef.FullTxtSetp
local DialogType = StoryConstDef.EStoryDialogUIStyleType

function M:buildUI()
	self._fullTextPanel = self:getUIComponent("story_main_view_-1765807412", ComponentType.CanvasGroup)
	self._bg = self:getImage("story_main_view_791831567")
	self._btnBg = self:getBtn("story_main_view_791831567")
	self._txt = self:getUIComponent("story_main_view_1815242617", typeof(TMPro.TextMeshProUGUI))
	self._tip = self:getGo("story_main_view_-149991698")
	self._typeWriter = TMPTypeWriter.Get(self._txt.gameObject)
end

function M:bindEvents()
	self._btnBg:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:addEventListener(StoryNotifyName.StorySwitchShotFinish, self.OnStorySwitchShotFinish, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.StorySwitchShotFinish, self.OnStorySwitchShotFinish, self)
	Scheduler.removeListener(self._onUpdate, self)
end

function M:OnShowDialog(_, data)
	local _dialogType = data.dialogType
	local changeBgAlpha = data.changeBgAlpha or false

	self.targetAlpha = changeBgAlpha and 0.9 or 1

	local isBlack = _dialogType == StoryConstDef.EStoryDialogUIStyleType.Black
	local isWhite = _dialogType == StoryConstDef.EStoryDialogUIStyleType.White

	if isBlack or isWhite then
		self._isAutoModel = StoryController.instance:getAutoPlay()

		if self._isAutoModel then
			StoryController.instance:setAutoPlay(false)
		end

		self._isInFullText = true
		self._type = _dialogType

		local colorValue = isBlack and 0 or 1
		local fontColorValue = isBlack and 1 or 0

		self._bg.color = Color.New(colorValue, colorValue, colorValue, self.targetAlpha)
		self._txt.color = Color.New(fontColorValue, fontColorValue, fontColorValue, 1)

		self._fullTextPanel:DOKill()

		self._fullTextPanel.alpha = 1
		self._txt.fontSize = data.fontSize
		self._txt.alignment = StoryUtils.GetRealTextAlign(data.alignType)
		self._data = data
		self.dialog = data.content

		self:_showFullText()
	end
end

function M:_showFullText()
	self._isFadeOut = false
	self.step = FullTxtSetp.FadeIn
	self._stepStartTime = Time.time

	StoryFacde.instance:hideAll(StoryConst.DefaultStateKey)
	goutil.setActive(self._fullTextPanel.gameObject, true)

	if self._tip then
		goutil.setActive(self._tip, false)
	end

	goutil.setActive(self._txt.gameObject, false)
	self:_onUpdate()
	Scheduler.addListener(0, self._onUpdate, self, true)
end

function M:_onUpdate()
	if not self._isInFullText then
		return
	end

	if self.step == FullTxtSetp.FadeIn then
		self:_onFadeInUpdate()
	elseif self.step == FullTxtSetp.Typeing then
		self:_onTypeingUpdate()
	elseif self.step == FullTxtSetp.Waiting then
		self:_onWaitingUpdate()
	elseif self.step == FullTxtSetp.Stay then
		self:_goNextStep()
	else
		self:_onFadeOutUpdate()
	end
end

function M:_onFadeInUpdate()
	local time = Time.time - self._stepStartTime
	local fadeInTime = 0.75
	local curIsBlack = self._type == DialogType.Black
	local colorValue = curIsBlack and 0 or 1

	if fadeInTime > 0 and time < fadeInTime then
		local tempAlpha = time / fadeInTime

		if tempAlpha >= self.targetAlpha then
			tempAlpha = self.targetAlpha
		end

		self._bg.color = Color.New(colorValue, colorValue, colorValue, tempAlpha)
	else
		self._bg.color = Color.New(colorValue, colorValue, colorValue, self.targetAlpha)

		self:_goNextStep()
	end
end

function M:_onTypeingUpdate()
	if not self._typeWriter.isActive then
		self:_goNextStep()
	end
end

function M:_onWaitingUpdate()
	if self._isAutoModel then
		self:_goNextStep()
	end
end

function M:_onFadeOutUpdate()
	local curIsBlack = self._type == DialogType.Black
	local colorValue = curIsBlack and 0 or 1
	local fontColorValue = curIsBlack and 1 or 0
	local time = Time.time - self._stepStartTime
	local fadeOutTime = 0.75

	if fadeOutTime > 0 and time < fadeOutTime then
		self._bg.color = Color.New(colorValue, colorValue, colorValue, self.targetAlpha - time / fadeOutTime)
		self._txt.color = Color.New(fontColorValue, fontColorValue, fontColorValue, self.targetAlpha - time / fadeOutTime)
	else
		self._bg.color = Color.New(colorValue, colorValue, colorValue, 0)
		self._txt.color = Color.New(fontColorValue, fontColorValue, fontColorValue, 0)

		self:_goNextStep()
	end
end

function M:_onClick()
	if self._type == DialogType.Black or self._type == DialogType.White then
		if self.step == FullTxtSetp.Typeing then
			if self._typeWriter.isActive then
				self._typeWriter:ShowAll()
			end

			self:_goNextStep()
		elseif self.step == FullTxtSetp.Waiting then
			self:_goNextStep()
		end
	end
end

function M:_goNextStep()
	self._stepStartTime = Time.time

	if self._tip then
		self._tip:SetActive(false)
	end

	if self.step == FullTxtSetp.FadeIn then
		self.step = FullTxtSetp.Typeing

		local function onShowAll()
			if self._callback then
				self._callback(self._handle)

				self._callback = nil
				self._handle = nil
			end

			self._typeWriter:SetShowAllCallback(nil, nil)
		end

		self._txt.gameObject:SetActive(true)
		self._typeWriter:SetShowAllCallback(onShowAll, self)
		self._typeWriter:Init(self.dialog)
	elseif self.step == FullTxtSetp.Typeing then
		self.step = FullTxtSetp.Waiting

		if self._tip then
			self._tip:SetActive(true)
		end
	elseif self.step == FullTxtSetp.Waiting then
		self.step = FullTxtSetp.FadeOut
	else
		Scheduler.removeListener(self._onUpdate, self)
		self:_closeViewInfo()
	end

	if enableLog then
		print("step:" .. self.step)
	end
end

function M:OnDialogExit(evt, data)
	return
end

function M:_closeViewInfo()
	self._fullTextPanel:DOKill()
	self._fullTextPanel:DOFade(0, 0.5):OnComplete(self._onFadeOut, self):SetAutoKill(true)
end

function M:_onFadeOut()
	self._isFadeOut = true
	self._isInFullText = false

	Scheduler.removeListener(self._onUpdate, self)
	goutil.setActive(self._fullTextPanel.gameObject, false)

	if self._isAutoModel then
		StoryController.instance:setAutoPlay(true)
	end

	StoryFacde.instance:tryNextShot()
end

function M:OnStorySwitchShotFinish()
	if self._fullTextPanel.gameObject.activeSelf then
		printInfo("switch with full text")
		self:_closeViewInfo()
	end
end

function M:destroyUI()
	return
end

return M
