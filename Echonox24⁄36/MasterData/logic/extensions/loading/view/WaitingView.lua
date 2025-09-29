-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/WaitingView.lua

module("logic.extensions.loading.view.WaitingView", package.seeall)

local WaitingView = class("WaitingView", ViewComponent)

function WaitingView:buildUI()
	self._goContentList = {
		goutil.findChild(self.mainGO, "imgDi"),
		goutil.findChild(self.mainGO, "content")
	}
	self._goRaycast = goutil.findChild(self.mainGO, "raycast")
	self._timeWaiter = TimeWaiter.New()
end

function WaitingView:destroyUI()
	self._goContentList = nil
	self._goRaycast = nil
end

function WaitingView:onEnter()
	local showImmediately = self:getFirstParam()

	self:_setRayCastEnable(true)
	self:_setContentVisible(showImmediately)
	self._timeWaiter:start(3, self._onWaitFinished, self)
end

function WaitingView:onExit()
	self._timeWaiter:clear()
	self:_setRayCastEnable(false)
end

function WaitingView:_onWaitFinished()
	self:_setContentVisible(true)
end

function WaitingView:_setRayCastEnable(enable)
	goutil.setActive(self._goRaycast, enable)
end

function WaitingView:_setContentVisible(visible)
	for _, go in ipairs(self._goContentList) do
		goutil.setActive(go, visible)
	end
end

return WaitingView
