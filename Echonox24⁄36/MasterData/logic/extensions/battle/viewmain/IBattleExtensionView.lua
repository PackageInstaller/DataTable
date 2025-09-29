-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/IBattleExtensionView.lua

module("logic.extensions.battle.viewmain.IBattleExtensionView", package.seeall)

local IBattleExtensionView = class("IBattleExtensionView", ViewComponent)

IBattleExtensionView.AttackRoot = {
	TOP_LEFT = "extensionRoot"
}

function IBattleExtensionView:dependMainResource()
	return
end

function IBattleExtensionView:dependExtensionResources()
	return
end

function IBattleExtensionView:attachToWhichRoot()
	return
end

function IBattleExtensionView:getRes(path)
	local resMgr = BattleMgr.instance:getResourceMgr()

	return resMgr:getResource(path)
end

function IBattleExtensionView:getPrefab(path)
	local resMgr = BattleMgr.instance:getResourceMgr()

	return resMgr:getPrefab(path)
end

function IBattleExtensionView:getResInstance(path)
	local resMgr = BattleMgr.instance:getResourceMgr()

	return resMgr:getInst(path)
end

return IBattleExtensionView
