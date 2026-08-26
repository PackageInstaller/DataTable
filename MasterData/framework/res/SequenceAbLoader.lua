-- chunkname: @framework/res/SequenceAbLoader.lua

module("framework.res.SequenceAbLoader", package.seeall)

local SequenceAbLoader = class("SequenceAbLoader")

function SequenceAbLoader:ctor()
	self._pathList = {}
	self._resDict = {}
	self._singlePath2AssetItemDict = {}
	self._resList = {}
	self._finishCallback = nil
	self._oneFinishCallback = nil
	self._loadFailCallback = nil
	self._callbackTarget = nil
	self._interval = 0.01
	self._concurrentCount = 1
	self._loadIndex = 1
	self._loadingCount = 0
	self.isLoading = false
end

function SequenceAbLoader:addPath(path)
	table.insert(self._pathList, path)
end

function SequenceAbLoader:setPathList(pathList)
	if pathList then
		self._pathList = pathList
	end
end

function SequenceAbLoader:setInterval(seconds)
	self._interval = seconds
end

function SequenceAbLoader:setConcurrentCount(count)
	self._concurrentCount = count
end

function SequenceAbLoader:startLoad(finishCallback, callbackTarget)
	self.isLoading = true
	self._finishCallback = finishCallback
	self._callbackTarget = callbackTarget
	self._loadIndex = 0

	self:_loadNext()
end

function SequenceAbLoader:setOneFinishCallback(oneFinishCallback)
	self._oneFinishCallback = oneFinishCallback
end

function SequenceAbLoader:setLoadFailCallback(loadFailCallback)
	self._loadFailCallback = loadFailCallback
end

function SequenceAbLoader:getAssetItemDict()
	return self._resDict
end

function SequenceAbLoader:getAssetItem(path)
	return self._resDict[path] or self._singlePath2AssetItemDict[path]
end

function SequenceAbLoader:getFirstAssetItem()
	local firstPath = self._pathList[1]

	return self:getAssetItem(firstPath)
end

function SequenceAbLoader:dispose()
	TaskDispatcher.cancelTask(self._loadNext, self)

	if self._pathList and #self._resList < #self._pathList then
		for _, v in ipairs(self._pathList) do
			removeAssetLoadCb(v, self._onLoadCallback, self)
		end
	end

	for _, assetItem in ipairs(self._resList) do
		assetItem:Release()
	end

	self._pathList = nil
	self._resDict = nil
	self._resList = nil
	self._finishCallback = nil
	self._oneFinishCallback = nil
	self._callbackTarget = nil
end

function SequenceAbLoader:_loadNext()
	if self._loadIndex >= #self._pathList and self._loadingCount == 0 then
		self:_callback()

		return
	end

	local isEditor = SLFramework.FrameworkSettings.IsEditor

	for i = 1, self._concurrentCount do
		self._loadIndex = self._loadIndex + 1

		if self._pathList then
			if self._pathList then
				self._loadingCount = self._loadingCount + 1

				loadAbAsset(self._pathList, false, self._onLoadCallback, self)

				if isEditor and string.find(self._pathList, "\\") then
					logError(string.format("SequenceAbLoader loadAbAsset path:%s error,can not contain \\", self._pathList))
				end
			end
		end
	end
end

function SequenceAbLoader:_onLoadCallback(assetItem)
	if not self._resList then
		return
	end

	table.insert(self._resList, assetItem)

	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		self._resDict[assetItem.ResPath] = assetItem

		local allAssetNames = assetItem.AllAssetNames

		if allAssetNames then
			for i = 0, allAssetNames.Length - 1 do
				local singlePath = ResUrl.getPathWithoutAssetLib(assetItem:getAssetsNameByIndex(i))

				self._singlePath2AssetItemDict[singlePath] = assetItem
			end
		end

		if self._oneFinishCallback then
			if self._callbackTarget then
				self._oneFinishCallback(self._callbackTarget, self, assetItem)
			else
				self:_oneFinishCallback(assetItem)
			end
		end
	elseif self._loadFailCallback then
		if self._callbackTarget then
			self._loadFailCallback(self._callbackTarget, self, assetItem)
		else
			self:_loadFailCallback(assetItem)
		end
	end

	self._loadingCount = self._loadingCount - 1

	if self._loadingCount <= 0 then
		if self._interval and self._interval > 0 then
			TaskDispatcher.runDelay(self._loadNext, self, self._interval)
		else
			self:_loadNext()
		end
	end
end

function SequenceAbLoader:_callback()
	self.isLoading = false

	if self._finishCallback then
		if self._callbackTarget then
			self._finishCallback(self._callbackTarget, self)
		else
			self:_finishCallback()
		end
	end
end

return SequenceAbLoader
