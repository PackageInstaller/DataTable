-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/standard/BattleMultiResLoaderIncludeModel.lua

module("logic.battle.skill.performance.standard.BattleMultiResLoaderIncludeModel", package.seeall)

local M = class("BattleMultiResLoaderIncludeModel")

function M:ctor()
	self._modelLoader = MultiResLoader.New()
	self._normalLoader = MultiResLoader.New()
end

function M:addNormalRes(resPath)
	self._normalLoader:addResPath(resPath)
end

function M:addModelRes(resPath)
	self._modelLoader:addResPath(resPath)
end

function M:load(finishCallback, callbackObj, replaceClip)
	self._replaceClip = replaceClip
	self._loadHandler = finishCallback
	self._loadObj = callbackObj

	self._modelLoader:load(self._onModelLoaded, false, self)
end

function M:_onModelLoaded()
	local ress = self._modelLoader:getResources()

	for k, res in pairs(ress) do
		self:_addAnimationClip(res)
	end

	self._normalLoader:load(self._onNormalResLoaded, false, self)
end

function M:_addAnimationClip(res)
	local asset = res:GetMainAsset()
	local animationNames = BattleTableUtil.getTempList()
	local animationPlayer = AnimationPlayer.Get(asset)

	animationPlayer:GetAnimationNamesLua(animationNames)

	for k, animationName in pairs(animationNames) do
		local path = animationPlayer:GetAnimationPath(animationName)

		self:addNormalRes(path)
	end

	BattleTableUtil.releaseTempList(animationNames)
end

function M:_onNormalResLoaded()
	self:_tryReplaceClips()

	if self._loadHandler then
		self._loadHandler(self._loadObj, self._normalLoader)
	end
end

function M:_tryReplaceClips()
	if self._replaceClip then
		local ress = self._modelLoader:getResources()

		for k, res in pairs(ress) do
			self:_replaceClips(res)
		end
	end
end

function M:_replaceClips(res)
	local asset = res:GetMainAsset()
	local animationNames = BattleTableUtil.getTempList()
	local animationPlayer = AnimationPlayer.Get(asset)

	animationPlayer:GetAnimationNamesLua(animationNames)

	for k, animationName in pairs(animationNames) do
		local path = animationPlayer:GetAnimationPath(animationName)
		local res = self._normalLoader:getResource(path)

		animationPlayer:ReplaceClip(animationName, res:GetAsset(nil, nil))
	end

	BattleTableUtil.releaseTempList(animationNames)
end

function M:getNormalLoader()
	return self._normalLoader
end

function M:getModelLoader()
	return self._modelLoader
end

function M:getResource(url)
	local resource = self._normalLoader:getResource(url)

	resource = resource or self._modelLoader:getResource(url)

	return resource
end

function M:isAllSuccess()
	return self._modelLoader:isAllSuccess() and self._normalLoader:isAllSuccess()
end

function M:getTotalCount()
	return self._modelLoader.totalCount + self._normalLoader.totalCount
end

function M:clear()
	table.clear(self._clipPath2AnimationPlayer)
	self._modelLoader:clear()
	self._normalLoader:clear()
end

return M
