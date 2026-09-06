-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bubble/view/BubbleView.lua

module("logic.extensions.bubble.view.BubbleView", package.seeall)

local BubbleView = class("BubbleView", ViewComponent)

function BubbleView:ctor()
	return
end

function BubbleView:buildUI()
	self._TxtC_Word = goutil.findChild(self.mainGO, "ImgC_Bg/TxtC_Word"):GetComponent("Text")
	self._TxtC_Word.text = ""
end

function BubbleView:onEnter()
	local params = self._viewPresentor:getOpenParam()

	self:_updateUI(params[1], params[2], params[3])
	GlobalDispatcher:addListener(GlobalNotify.CloseBubble, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateBubble, self._updateUI, self)
end

function BubbleView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CloseBubble, self._updateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateBubble, self._updateUI, self)
end

function BubbleView:_updateUI(word, pos, overturn)
	self._TxtC_Word.text = word
	self.mainGO.transform.position = pos

	if overturn then
		Framework.TransformUtil.SetLocalRotation(self.mainGO.transform, 0, 0, 180)
		Framework.TransformUtil.SetLocalRotation(self._TxtC_Word.transform, 0, 0, 180)
	else
		Framework.TransformUtil.SetLocalRotation(self.mainGO.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalRotation(self._TxtC_Word.transform, 0, 0, 0)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mainGO.transform)
end

return BubbleView
