-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/spine/BRMPlayerSpineCtrl.lua

module("logic.extensions.beastrichman.view.spine.BRMPlayerSpineCtrl", package.seeall)

local BRMPlayerSpineCtrl = class("BRMPlayerSpineCtrl", HLPlayerSpineCtrl)

function BRMPlayerSpineCtrl:_getUrl()
	return "20211028/zhiren_aoqi/zhiren_aoqi-ui_p_half_touming.prefab"
end

return BRMPlayerSpineCtrl
