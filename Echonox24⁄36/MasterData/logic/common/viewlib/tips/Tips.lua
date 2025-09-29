-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tips/Tips.lua

module("logic.common.viewlib.tips.Tips", package.seeall)

local kCapacity = 1
local kTipsRoot = PoolRootUtil.createUIPoolRoot("Tips")

local function registerTips(url, tipsClass)
	tipsClass.url = url

	tipsClass:preparePool(kCapacity)
	GameObjectCache.instance:bindUrl(url, kCapacity)
end

local function createTips(tipsClass)
	return tipsClass:createInstance()
end

local M = class("Tips")

M.tipsRoot = kTipsRoot

registerTips("ui/views/common/tips/item_tips.prefab", ItemTipsImpl)

function M.showItemTips(code)
	local tips = createTips(ItemTipsImpl)

	tips:setCode(code):show()

	return tips
end

return M
