-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/VideoPlayView.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.VideoPlayView", package.seeall)

local M = class("VideoPlayView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("imageguideview_copy_678884780")
	self._videoClose = Astral.UIClickTrigger.Get(self:getGo("imageguideview_copy_1683318416"))
	self._typeGo = {
		self:getGo("imageguideview_copy_-1570229296"),
		self:getGo("imageguideview_copy_-1124094933"),
		self:getGo("imageguideview_copy_-1174429780"),
		self:getGo("imageguideview_copy_-1354326982"),
		self:getGo("imageguideview_copy_742162551")
	}

	for i, v in ipairs(self._typeGo) do
		goutil.setActive(v, i == 5)
	end

	self._btnLeft = self:getGo("imageguideview_copy_-1154705026")
	self._btnRight = self:getGo("imageguideview_copy_443214607")
	self._dotParentGO = self:getGo("imageguideview_copy_-1924247883")

	goutil.setActive(self._btnLeft.gameObject, false)
	goutil.setActive(self._btnRight.gameObject, false)
	goutil.setActive(self._dotParentGO, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._videoClose:AddClickListener(self._onClickClose, self)
end

function M:_onClickClose()
	self:close()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._videoClose:RemoveClickListener()
end

function M:destroyUI()
	if self._videoMgr then
		self._videoMgr:DestroyMovie()
	end
end

function M:onExitFinished()
	if self._videoMgr then
		self._videoMgr:Reset()
	end
end

function M:onEnter()
	local params = self:getOpenParam()
	local path = params[1]
	local isLoop = params[2]
	local tips = params[3] or ""

	self:_videoProcess(path, isLoop, tips)
end

function M:_videoProcess(path, isLoop, tips)
	if not self._videoMgr then
		local videoGo = self:getGo("imageguideview_copy_-69611282")

		self._videoMgr = CriWareVideoMgr.Get(videoGo)
		self._txtVideo = self:getUIComponent("imageguideview_copy_-404114003", UIComponentType.TextMeshProUGUI)
	end

	local fullVideoPath = path

	self._videoMgr:PlayMovie(fullVideoPath, true, true, self._onPlayFinished, self)

	self._txtVideo.text = tips
end

function M:onExit()
	if self._videoMgr then
		self._videoMgr:StopMovie()
	end
end

return M
