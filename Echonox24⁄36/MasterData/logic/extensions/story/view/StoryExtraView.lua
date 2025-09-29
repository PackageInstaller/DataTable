-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryExtraView.lua

module("logic.extensions.story.view.StoryExtraView", package.seeall)

local M = class("StoryExtraView", ViewComponent)

function M:buildUI()
	self._extraPanel = self:getGo("story_main_view_745372372")
	self._extraInfo1 = self:getUIComponent("story_main_view_898091898", typeof(TMPro.TextMeshProUGUI))
	self._extraInfo2 = self:getUIComponent("story_main_view_2059499922", typeof(TMPro.TextMeshProUGUI))
	self._extraInfo3 = self:getUIComponent("story_main_view_1993998388", typeof(TMPro.TextMeshProUGUI))
	self._extraInfo4 = self:getUIComponent("story_main_view_-1114802350", typeof(TMPro.TextMeshProUGUI))
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	self:registerLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	self:unregisterLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
end

function M:OnShowDialog(_, data)
	local _dialogType = data.dialogType

	if _dialogType == StoryConstDef.EStoryDialogUIStyleType.Extra then
		self._extraInfo1.text = ""
		self._extraInfo2.text = ""
		self._extraInfo3.text = ""
		self._extraInfo4.text = ""

		if self._tmpSequence then
			self._tmpSequence:Kill()
		end

		self._tmpSequence = DG.Tweening.DOTween.Sequence()

		if not string.nilorempty(data.content) then
			local characterCount = StringUtil.getStringLength(data.content)
			local speed1 = characterCount * 0.05

			self._tmpSequence:Append(self._extraInfo1:DOText(data.content, speed1))
		end

		if not string.nilorempty(data.content2) then
			local characterCount = StringUtil.getStringLength(data.content2)
			local speed2 = characterCount * 0.05

			self._tmpSequence:Append(self._extraInfo2:DOText(data.content2, speed2))
		end

		if not string.nilorempty(data.content3) then
			local characterCount = StringUtil.getStringLength(data.content3)
			local speed3 = characterCount * 0.05

			self._tmpSequence:Append(self._extraInfo3:DOText(data.content3, speed3))
		end

		if not string.nilorempty(data.content4) then
			local characterCount = StringUtil.getStringLength(data.content4)
			local speed4 = characterCount * 0.05

			self._tmpSequence:Append(self._extraInfo4:DOText(data.content4, speed4))
		end

		self._tmpSequence:SetAutoKill(true)
		self._tmpSequence:SetTarget(self._extraPanel)
		goutil.setActive(self._extraPanel, true)

		if string.nilorempty(data.content2) and string.nilorempty(data.content3) and string.nilorempty(data.content4) then
			goutil.setActive(self._extraInfo2.gameObject, false)
			goutil.setActive(self._extraInfo3.gameObject, false)
			goutil.setActive(self._extraInfo4.gameObject, false)
		else
			goutil.setActive(self._extraInfo2.gameObject, true)
			goutil.setActive(self._extraInfo3.gameObject, true)
			goutil.setActive(self._extraInfo4.gameObject, true)
		end

		self._isShow = true

		StoryFacde.instance:showAll(StoryConst.DefaultStateKey)
	end
end

function M:_OnHideUIByManual(evt, isHide)
	if not goutil.isNil(self._extraPanel) and self._isShow then
		goutil.setActive(self._extraPanel, not isHide)

		if not isHide and self._tmpSequence then
			self._tmpSequence:Kill()
		end
	end
end

function M:OnDialogExit(evt, data)
	if not data then
		return
	end

	local _dialogType = data.dialogType

	if _dialogType == StoryConstDef.EStoryDialogUIStyleType.Extra then
		self:_hideExtraAndTryNext()
	end
end

function M:_hideExtraAndTryNext()
	self._isShow = false

	goutil.setActive(self._extraPanel, false)

	if self._tmpSequence then
		self._tmpSequence:Kill()
	end
end

function M:destroyUI()
	return
end

return M
