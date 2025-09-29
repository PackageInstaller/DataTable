-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/preload/CommonPreloader.lua

module("logic.starter.preload.CommonPreloader", package.seeall)

local CommonPreloader = class("CommonPreloader")
local kAbMaterialsComm = "materials_comm"

function CommonPreloader:ctor()
	self._resDict = {}
	self._resLoader = MultiResLoader.New()
	self._loadedHandler = Handler.New()
	self._progressHandler = Handler.New()
	self._gamelibAssetsCache = {}
end

function CommonPreloader:loadBasic(callback, callbackSelf, progressCallback)
	self._loadedHandler:setListener(callback, callbackSelf)

	if progressCallback then
		self._progressHandler:setListener(progressCallback, callbackSelf)
	end

	local resPaths = {}

	table.insertto(resPaths, CommonResPath.loginGroups)
	table.insertto(resPaths, CommonResPath.basicGroups)

	local curSceneName = SceneUtil.getActiveSceneName()

	if curSceneName == "Starter" then
		table.insertto(resPaths, CommonResPath.basic)
	elseif curSceneName == "story_preview" or curSceneName == "HouseEditor" or curSceneName == "RoleClip" or curSceneName == "EchoEffectEditor" then
		table.insertto(resPaths, CommonResPath.storyBasic)
	end

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllBasicLoaded, self._onBasicLoaded, self)
end

function CommonPreloader:_onBasicLoaded(res, loadedCount, totalCount)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end

	self._progressHandler:call(loadedCount, totalCount)
end

function CommonPreloader:loadMainSceneRes(callback, callbackSelf, progressCallback)
	self._loadedHandler:setListener(callback, callbackSelf)

	if progressCallback then
		self._progressHandler:setListener(progressCallback, callbackSelf)
	end

	local resPaths = {}

	table.insertto(resPaths, CommonResPath.mainScenePreloadRes)

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllMainSceneResLoaded, self._onMainSceneResLoaded, self)
end

function CommonPreloader:_onMainSceneResLoaded(res, loadedCount, totalCount)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end

	self._progressHandler:call(loadedCount, totalCount)
end

function CommonPreloader:_onAllMainSceneResLoaded(loader)
	self._resLoader:clear()
	self._loadedHandler:callAndClear()
	self._progressHandler:clear()
end

function CommonPreloader:_onBasicLoaded(res, loadedCount, totalCount)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end

	self._progressHandler:call(loadedCount, totalCount)
end

function CommonPreloader:_onAllBasicLoaded(loader)
	self:_setShaderCache()
	self:_loadTextMeshProMaterial()
	self._resLoader:clear()
	self._loadedHandler:callAndClear()
	self._progressHandler:clear()
end

function CommonPreloader:_setShaderCache()
	local res = self._resDict[CommonResPath.ShaderCacheCollection]

	if not res then
		return
	end

	local asset = res:GetAsset(nil, nil)

	asset:AddToShaderCache()
end

function CommonPreloader:_loadTextMeshProMaterial()
	local res = self._resDict[CommonResPath.TMPMaterialSetting]

	if not res then
		return
	end

	local asset = res:GetAsset(nil, nil)

	asset:LoadAllMaterial()
end

function CommonPreloader:loadAdditional(callback, callbackSelf)
	self._loadedHandler:setListener(callback, callbackSelf)

	local resPaths = {}

	table.insertto(resPaths, CommonResPath.additional)

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllAdditionalLoaded, self._onAdditionalLoaded, self)
end

function CommonPreloader:_onAdditionalLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function CommonPreloader:_onAllAdditionalLoaded(loader)
	self._resLoader:clear()
	self._loadedHandler:callAndClear()
end

function CommonPreloader:removeRes(resPath)
	local res = self._resDict[resPath]

	if res then
		res:Release()

		self._resDict[resPath] = nil
	end
end

function CommonPreloader:getRes(resPath)
	return self._resDict[resPath]
end

function CommonPreloader:getAsset(resPath)
	local res = self._resDict[resPath]

	if res then
		return res:GetAsset(nil, nil)
	end

	return false
end

function CommonPreloader:getMaterialsCommAsset(resPath)
	local asset = self._gamelibAssetsCache[resPath]

	if not asset then
		local res = self._resDict[kAbMaterialsComm]

		asset = res:GetAsset(resPath, nil)
		self._gamelibAssetsCache[resPath] = asset

		return asset
	end

	return asset
end

function CommonPreloader:clearPreLoadRes()
	self:removeRes(CommonResPath.Spacestation)
	self:removeRes(CommonResPath.MainScene)

	for k, v in pairs(CommonResPath.loginGroups) do
		self:removeRes(v)
	end
end

CommonPreloader.instance = CommonPreloader.New()

return CommonPreloader
