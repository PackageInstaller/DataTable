-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/BoxTipsView.lua

module("logic.extensions.warriortower.view.BoxTipsView", package.seeall)

local BoxTipsView = class("BoxTipsView", TipsViewBase)

function BoxTipsView:buildUI()
	self._go = self:getGo("Top/Tip")
	self._customInput = UICustomInput.Get(self._go)
end

function BoxTipsView:destroyUI()
	self._customInput = nil
end

function BoxTipsView:onEnter()
	self._go:SetActive(false)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	if TipsViewBase.tipsPosition then
		self._go.transform.localPosition = TipsViewBase.tipsPosition
		TipsViewBase.tipsPosition = nil
	end

	WTowerController.instance:registerLocalNotify("ClickBox", self._refreshBox, self)
end

function BoxTipsView:onExit()
	WTowerController.instance:unregisterLocalNotify("ClickBox", self._refreshBox, self)
end

function BoxTipsView:_refreshBox()
	self._go:SetActive(true)
end

function BoxTipsView:_onCustomInputCallback(hover)
	if not hover then
		self._go:SetActive(false)
	end
end

function BoxTipsView:_isOnTop()
	local tf = self._go.transform
	local parent = tf.parent

	if not parent then
		return true
	end

	local idx = tf:GetSiblingIndex()
	local count = parent.childCount - 1

	if idx == count then
		return true
	end

	for i = idx, count do
		local sibling = parent:GetChild(i)

		if sibling.gameObject.activeSelf then
			return nil
		end
	end

	return true
end

return BoxTipsView
