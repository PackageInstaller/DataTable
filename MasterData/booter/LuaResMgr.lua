-- chunkname: @booter/LuaResMgr.lua

module("booter.LuaResMgr", package.seeall)

local resMgr = SLFramework.ResMgr.Instance

function _checkIsPathValid(assetUrl)
	if assetUrl == nil then
		logError("LuaResMgr _checkIsPathValid, assetUrl can not be nil!")

		return false
	end

	if resMgr.IsFromEditorDir and string.match(assetUrl, "[A-Z]+") ~= nil then
		logError("LuaResMgr _checkIsPathValid, 资源路径必须都是小写，请检查: assetUrl = " .. assetUrl)

		return false
	end

	return true
end

function loadAbAsset(assetUrl, needPreload, loadedCb, loadedObj)
	if not _checkIsPathValid(assetUrl) then
		return
	end

	resMgr:GetAbAssetForLua(assetUrl, needPreload, loadedCb, loadedObj)
end

function loadNonAbAsset(assetUrl, assetType, loadedCb, loadedObj)
	if not _checkIsPathValid(assetUrl) then
		return
	end

	resMgr:GetNonAbAssetForLua(assetUrl, assetType, loadedCb, loadedObj)
end

function loadPersistentRes(fullUrl, assetType, loadedCb, loadedObj)
	if fullUrl == nil then
		logError("LuaResMgr loadPersistentRes, fullUrl can not be nil!")

		return false
	end

	resMgr:GetPersistenResForLua(fullUrl, assetType, loadedCb, loadedObj)
end

function removeAssetLoadCb(assetUrl, loadedCb, loadedObj)
	resMgr:RemoveAssetItemCb(assetUrl, loadedCb, loadedObj)
end

setGlobal("loadAbAsset", loadAbAsset)
setGlobal("loadNonAbAsset", loadNonAbAsset)
setGlobal("loadPersistentRes", loadPersistentRes)
setGlobal("removeAssetLoadCb", removeAssetLoadCb)
setGlobal("GameResMgr", resMgr)
