-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/international/InternationalLogicMgr.lua

module("logic.international.InternationalLogicMgr", package.seeall)

local InternationalLogicMgr = _M

function InternationalLogicMgr.replaceLogic()
	local sdkType = SDKManager.getSDKType()

	if sdkType == SDKManager.SDKType.Xm then
		XMLogicReplace.doReplace()
	end
end

return InternationalLogicMgr
