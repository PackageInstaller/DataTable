-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BRMPlayerMgr.lua

module("logic.extensions.beastrichman.view.BRMPlayerMgr", package.seeall)

local BRMPlayerMgr = class("BRMPlayerMgr", HLPlayerMgr)

function BRMPlayerMgr:ctor()
	self._scrollerViewCtrl = HLScrollerViewCtrl.New()
	self._playerSpineCtrl = BRMPlayerSpineCtrl.New()
	self._curLocalPos = Vector3.New()
	self._boundingBox2D = BoundingBox2D.New()
end

return BRMPlayerMgr
