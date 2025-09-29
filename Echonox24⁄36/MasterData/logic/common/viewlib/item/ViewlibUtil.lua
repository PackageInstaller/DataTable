-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/ViewlibUtil.lua

module("logic.common.viewlib.item.ViewlibUtil", package.seeall)

local ViewlibUtil = {}

local function generatePath2ClassTable()
	local t = {}

	for k, v in pairs(ViewlibResPath) do
		t[v] = k
	end

	return t
end

local kPath2ClassTable = generatePath2ClassTable()
local kGGG = getglobal("_G")

function ViewlibUtil.getItem(resPath, parent)
	local itemClass = ViewlibUtil.getItemClass(resPath)

	if not itemClass then
		return
	end

	local prefab = ViewlibUtil.getItemPrefab(resPath)

	if not prefab then
		return
	end

	return itemClass:NewObject(prefab, parent or nil)
end

function ViewlibUtil.getItemClass(resPath)
	local itemClassName = kPath2ClassTable[resPath]

	if not itemClassName then
		if enableErrorLog then
			printError("ViewlibUtil::cannot find class for path!", resPath)
		end

		return
	end

	return kGGG[itemClassName]
end

function ViewlibUtil.getItemPrefab(resPath)
	local resource = rescache:GetResource(resPath, nil, nil)

	if not resource.IsSuccess then
		if enableErrorLog then
			printError("ViewlibUtil::please preload resource first!", resPath)
		end

		return
	end

	return resource:GetMainAsset()
end

return ViewlibUtil
