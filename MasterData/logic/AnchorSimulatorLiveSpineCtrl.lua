-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveSpineCtrl.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveSpineCtrl", package.seeall)

local AnchorSimulatorLiveSpineCtrl = class("AnchorSimulatorLiveSpineCtrl", HLSpineCtrl)

function AnchorSimulatorLiveSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	AnchorSimulatorLiveSpineCtrl.super.onInit(self, spineRoot, view)
end

function AnchorSimulatorLiveSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function AnchorSimulatorLiveSpineCtrl:_getDefaultScale()
	return 1
end

function AnchorSimulatorLiveSpineCtrl:playDefaultAnim()
	self:_playAnim("z3_tiaowu", true)
end

function AnchorSimulatorLiveSpineCtrl:playHuanHuAnim()
	self:_playAnim("z2_huanhu", true)
end

return AnchorSimulatorLiveSpineCtrl
