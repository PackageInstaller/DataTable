-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CaiqingdrawSpineCtrl.lua

module("logic.extensions.caiqingdraw.view.CaiqingdrawSpineCtrl", package.seeall)

local CaiqingdrawSpineCtrl = class("CaiqingdrawSpineCtrl", HLSpineCtrl)

CaiqingdrawSpineCtrl.AnimName = {
	Idle = "idle-all"
}

function CaiqingdrawSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	CaiqingdrawSpineCtrl.super.onInit(self, spineRoot, view)
end

function CaiqingdrawSpineCtrl:_getUrl()
	return self._spinePath
end

function CaiqingdrawSpineCtrl:_getDefaultScale()
	return 1
end

function CaiqingdrawSpineCtrl:playDefaultAnim()
	local animName = CaiqingdrawSpineCtrl.AnimName.Idle

	self:_playAnim(animName, true)
end

return CaiqingdrawSpineCtrl
