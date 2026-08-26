-- chunkname: @framework/luamono/MonoHelper.lua

module("framework.luamono.MonoHelper", package.seeall)

local MonoHelper = {}

function MonoHelper.addLuaComOnceToGo(go, clsDefine, ctorParam)
	if gohelper.isNil(go) then
		logError("MonoHelper.addLuaComOnceToGo, go can not be nil!")

		return nil
	end

	if not clsDefine then
		logError("MonoHelper.addLuaComOnceToGo, clsDefine can not be nil!")

		return nil
	end

	local container = SLFramework.LuaMonoTools.GetLuaComContainer(go, LuaMonoContainer)

	return container:addCompOnce(clsDefine, ctorParam)
end

function MonoHelper.addNoUpdateLuaComOnceToGo(go, clsDefine, ctorParam)
	if gohelper.isNil(go) then
		logError("MonoHelper.addNoUpdateLuaComOnceToGo, go can not be nil!")

		return nil
	end

	if not clsDefine then
		logError("MonoHelper.addNoUpdateLuaComOnceToGo, clsDefine can not be nil!")

		return nil
	end

	local container = SLFramework.LuaMonoTools.GetLuaComContainer(go, LuaNoUpdateMonoContainer)

	return container:addCompOnce(clsDefine, ctorParam)
end

function MonoHelper.getLuaComFromGo(go, clsDefine)
	if gohelper.isNil(go) or not clsDefine then
		logError("MonoHelper.getLuaComFromGo, go and clsDefine can not be nil! ")

		return nil
	end

	local container = SLFramework.LuaMonoTools.FindLuaComContainer(go)

	if container ~= nil then
		return container:getComp(clsDefine)
	end

	return nil
end

function MonoHelper.removeLuaComFromGo(go, clsDefine)
	if gohelper.isNil(go) or not clsDefine then
		logError("MonoHelper.removeLuaComFromGo, go and clsDefine can not be nil! ")

		return nil
	end

	local container = SLFramework.LuaMonoTools.FindLuaComContainer(go)

	if container ~= nil then
		container:removeCompByDefine(clsDefine)
	end
end

function MonoHelper.getLuaContainerInGo(go)
	if gohelper.isNil(go) then
		logError("MonoHelper.getLuaContainerInGo, go can not be nil!")

		return nil
	end

	return SLFramework.LuaMonoTools.FindLuaComContainer(go)
end

return MonoHelper
