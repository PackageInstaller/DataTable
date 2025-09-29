-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/capture/BattleCaptureMgr.lua

module("logic.battle.battleflow.component.capture.BattleCaptureMgr", package.seeall)

local M = class("BattleCaptureMgr", IBattleFlowComp)

function M:onInit()
	self._captureScreen = CaptureScreenUtils.New()
	self._allScreenRTs = {}
	self._isCaptureVsInfo = false
end

function M:onStart()
	self._isCaptureVsInfo = false
	self._currentCount = 0

	self:_setEvent(true)
	self:clearCaches()
end

function M:onClear()
	self:_setEvent(false)
	self:clearCaches()

	self._isCaptureVsInfo = false
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnCaptureScreenEvent, self._onCaptureScren, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnCaptureScreenEvent, self._onCaptureScren, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
	end
end

function M:_onUpdateVsViewInfo(evt)
	if not self._isCaptureVsInfo then
		self._isCaptureVsInfo = true

		self:_onCaptureScren()
	end
end

function M:_onCaptureScren(evt)
	if self._currentCount >= 3 then
		return
	end

	if self._captureScreen then
		self._currentCount = self._currentCount + 1

		self._captureScreen:CaptureFrame(self._onCaptureFrameFinish, self)
	end
end

function M:_onCaptureFrameFinish(renderTexture)
	table.insert(self._allScreenRTs, renderTexture)
end

function M:getAllRenderTextures()
	return self._allScreenRTs
end

function M:clearCaches()
	self._currentCount = 0

	for i = 1, #self._allScreenRTs do
		self._captureScreen:Clear(self._allScreenRTs[i])
	end

	table.clear(self._allScreenRTs)
end

return M
