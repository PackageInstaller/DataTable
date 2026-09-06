-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BufftipsView.lua

module("logic.extensions.common.view.BufftipsView", package.seeall)

local BufftipsView = class("BufftipsView", ViewComponent)

function BufftipsView:ctor()
	BufftipsView.super.ctor(self)
end

function BufftipsView:destroyUI()
	BufftipsView.super.destroyUI(self)
end

function BufftipsView:onExitFinished()
	BufftipsView.super.onExitFinished(self)
end

function BufftipsView:onEnterFinished()
	BufftipsView.super.onEnterFinished(self)
end

function BufftipsView:unbindEvents()
	BufftipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function BufftipsView:bindEvents()
	BufftipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function BufftipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function BufftipsView:onExit()
	BufftipsView.super.onExit(self)
	uGuiUtil.clearImage(self._imgIcon)
end

function BufftipsView:buildUI()
	BufftipsView.super.buildUI(self)

	self.content = self:getGo("Nego_Content")

	local top = goutil.findChild(self.content, "Nego_Top")
	local bottom = goutil.findChild(self.content, "Nego_Bottom")

	self._imgIcon = goutil.findChild(top, "ImgC_Con")
	self._txtDesc = goutil.findChildTextComponent(bottom, "TxtC_Desc")
	self._txtName = goutil.findChildTextComponent(top, "TxtC_Name")
	self._customInput = UICustomInput.Get(self.content)
	self._adjustPosition = self.content:GetComponent("UIAdjustPosition")
end

function BufftipsView:onEnter()
	BufftipsView.super.onEnter(self)

	local params = self:getOpenParam()
	local data = params[1]
	local pos = params[2]
	local sizeDelta = params[3]

	self._buffName = data.buffName
	self._buffIconPath = data.iconPath
	self._buffDesc = data.buffDesc
	self._txtDesc.text = self._buffDesc
	self._txtName.text = self._buffName

	uGuiUtil.setSpriteToImage(self._imgIcon, nil, self._buffIconPath)

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end
end

function BufftipsView.getBuffTipSimpleData(name, buffDesc, iconPath)
	return {
		buffName = name,
		buffDesc = buffDesc,
		iconPath = string.format("ui/icon/%s.png", iconPath)
	}
end

return BufftipsView
