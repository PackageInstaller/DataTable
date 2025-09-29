-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIDialogueView.lua

module("logic.extensions.mainui.view.MainUIDialogueView", package.seeall)

local M = class("MainUIDialogueView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroupDialogue = goutil.addComponentOnce(goutil.findChild(self.mainGO, "content_node/dialogue").gameObject, ComponentType.CanvasGroup)
	self._animation = goutil.findChildComponent(self._canvasGroupDialogue.gameObject, "dialogue/dialogueDi", ComponentType.Animation)
	self._txtDialogue = goutil.findChildComponent(self._canvasGroupDialogue.gameObject, "dialogue/dialogueDi/txtDesc", UIComponentType.Text)

	goutil.setActive(self._canvasGroupDialogue.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:playAnim(name)
	self._animation:Stop()
	self._animation:Play(name)
end

function M:playAniOpen()
	self:playAnim("roleplot_open")
end

function M:playAniHide()
	self:playAnim("roleplot_close")
end

return M
