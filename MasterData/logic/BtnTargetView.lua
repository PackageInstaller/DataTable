-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/BtnTargetView.lua

module("logic.extensions.powerland.view.BtnTargetView", package.seeall)

local BtnTargetView = class("BtnTargetView", ViewComponent)

function BtnTargetView:ctor()
	BtnTargetView.super.ctor(self)
end

function BtnTargetView:buildUI()
	BtnTargetView.super.buildUI(self)

	self._btnTarget = goutil.findChild(self.mainGO, "btnTarget")
end

function BtnTargetView:bindEvents()
	BtnTargetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
end

function BtnTargetView:unbindEvents()
	BtnTargetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTarget)
end

function BtnTargetView:destroyUI()
	BtnTargetView.super.destroyUI(self)
end

function BtnTargetView:onEnter()
	BtnTargetView.super.onEnter(self)
end

function BtnTargetView:onExit()
	BtnTargetView.super.onExit(self)
end

function BtnTargetView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.NowTargetView)
end

return BtnTargetView
