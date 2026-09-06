-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/resource/loader/MultiResLoader.lua

module("framework.resource.rescache.MultiResLoader", package.seeall)

local MultiResLoader = class("MultiResLoader")

function MultiResLoader:ctor()
	self._loadedResDict = {}
	self._resPaths = {}
	self._resPreloadFlags = {}
	self._resTypeList = {}
	self._isAllPreload = false
	self._callbackObj = nil
	self._finishCallback = nil
	self._progressCallback = nil
	self.loadedCount = 0
	self.totalCount = 0
	self.successCount = 0
	self.priority = 0
end

function MultiResLoader:isAllSuccess()
	return self.totalCount == self.successCount
end

function MultiResLoader:setResPriority(priority)
	self.priority = priority

	if self.priority and self.priority ~= 0 and self._resPaths then
		for i = 1, #self._resPaths do
			local res = rescache:GetResourceNoLoadIfNotExists(self._resPaths[i])

			if res then
				rescache:SetPriority(res, priority)
			end
		end
	end
end

function MultiResLoader:addResPath(resPath, needPreload, resType)
	if needPreload == nil then
		needPreload = false
	end

	if resType == nil then
		resType = ResType.AssetBunble
	end

	table.insert(self._resPaths, resPath)
	table.insert(self._resPreloadFlags, needPreload)
	table.insert(self._resTypeList, resType)
end

function MultiResLoader:setResPaths(resPaths, resPreloadFlags, resTypeList)
	self._resPaths = resPaths
	self._resPreloadFlags = resPreloadFlags
	self._resTypeList = resTypeList
end

function MultiResLoader:setAllPreload()
	self._isAllPreload = true
end

function MultiResLoader:load(finishCallback, progressCallback, callbackObj)
	if self._resPaths == nil or #self._resPaths == 0 then
		if finishCallback then
			if callbackObj then
				finishCallback(callbackObj, self)
			else
				finishCallback(self)
			end
		end

		return
	end

	self._finishCallback = finishCallback
	self._progressCallback = progressCallback
	self._callbackObj = callbackObj
	self.totalCount = #self._resPaths

	local resType = ResType.AssetBunble

	for i = 1, self.totalCount do
		resType = self._resTypeList ~= nil and self._resTypeList[i] or ResType.AssetBunble

		getres(self._resPaths[i], MultiResLoader._onResLoaded, self, resType, self._isAllPreload and true or self._resPreloadFlags ~= nil and self._resPreloadFlags[i] or true)

		local res = rescache:GetResourceNoLoadIfNotExists(self._resPaths[i])

		if self.priority and self.priority ~= 0 then
			rescache:SetPriority(res, self.priority)
		end
	end
end

function MultiResLoader:_onResLoaded(res)
	if self.totalCount == 0 then
		return
	end

	if res.IsSuccess then
		self.successCount = self.successCount + 1

		if not self._loadedResDict[res.ResPath] then
			self._loadedResDict[res.ResPath] = res

			res:Retain()
		end
	end

	self.loadedCount = self.loadedCount + 1

	if self._progressCallback then
		if self._callbackObj then
			self._progressCallback(self._callbackObj, res)
		else
			self._progressCallback(res)
		end
	end

	if self.loadedCount >= self.totalCount and self._finishCallback then
		if self._callbackObj then
			self._finishCallback(self._callbackObj, self)
		else
			self:_finishCallback()
		end
	end
end

function MultiResLoader:getResources()
	return self._loadedResDict
end

function MultiResLoader:getResource(resPath)
	return self._loadedResDict[resPath]
end

function MultiResLoader:clear()
	if self.totalCount == 0 then
		return
	end

	if self.loadedCount < self.totalCount then
		for i = 1, self.totalCount do
			removeresl(self._resPaths[i], MultiResLoader._onResLoaded, self)
		end
	end

	for k, v in pairs(self._loadedResDict) do
		v:Release()
	end

	self._loadedResDict = {}
	self._resPaths = {}
	self._resPreloadFlags = {}
	self._isAllPreload = false
	self._callbackObj = nil
	self._finishCallback = nil
	self._progressCallback = nil
	self.loadedCount = 0
	self.totalCount = 0
	self.successCount = 0
end

return MultiResLoader
