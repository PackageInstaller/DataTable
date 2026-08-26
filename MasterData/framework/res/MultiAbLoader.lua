-- chunkname: @framework/res/MultiAbLoader.lua

module("framework.res.MultiAbLoader", package.seeall)

local MultiAbLoader = class("MultiAbLoader")

function MultiAbLoader:ctor()
	self._pathList = {}
	self._resDict = {}
	self._singlePath2AssetItemDict = {}
	self._resList = {}
	self._finishCallback = nil
	self._oneFinishCallback = nil
	self._loadFailCallback = nil
	self._callbackTarget = nil
	self.isLoading = false
end

function MultiAbLoader:addPath(path)
	table.insert(self._pathList, path)
end

function MultiAbLoader:setPathList(pathList)
	if pathList then
		self._pathList = pathList
	end
end

function MultiAbLoader:startLoad(finishCallback, callbackTarget)
	self.isLoading = true
	self._finishCallback = finishCallback
	self._callbackTarget = callbackTarget

	local isEditor = SLFramework.FrameworkSettings.IsEditor

	if self._pathList then
		if not #self._pathList then
			local count = 0

			if count > 0 then
				for i = 1, count do
					local path = self._pathList[i]

					loadAbAsset(path, false, self._onLoadCallback, self)

					if isEditor and string.find(path, "\\") then
						logError(string.format("MultiAbLoader loadAbAsset path:%s error,can not contain \\", path))
					end
				end
			else
				self:_callback()
			end
		end
	end
end

function MultiAbLoader:setOneFinishCallback(oneFinishCallback)
	self._oneFinishCallback = oneFinishCallback
end

function MultiAbLoader:setLoadFailCallback(loadFailCallback)
	self._loadFailCallback = loadFailCallback
end

function MultiAbLoader:getAssetItemDict()
	return self._resDict
end

function MultiAbLoader:getAssetItem(path)
	return self._resDict[path]
end

function MultiAbLoader:getFirstAssetItem()
	local firstPath = self._pathList[1]

	return self:getAssetItem(firstPath)
end

function MultiAbLoader:dispose()
	if self._pathList and #self._resList < #self._pathList then
		for _, v in ipairs(self._pathList) do
			removeAssetLoadCb(v, self._onLoadCallback, self)
		end
	end

	if self._resList then
		for i, assetItem in ipairs(self._resList) do
			assetItem:Release()
			rawset(self._resList, i, nil)
		end
	end

	self._pathList = nil
	self._resDict = nil
	self._resList = nil
	self._finishCallback = nil
	self._oneFinishCallback = nil
	self._callbackTarget = nil
end

function MultiAbLoader:_onLoadCallback(assetItem)
	if not self._resList then
		return
	end

	table.insert(self._resList, assetItem)

	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		self._resDict[assetItem.ResPath] = assetItem

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

	if #self._resList >= #self._pathList then
		self:_callback()
	end
end

function MultiAbLoader:_callback()
	self.isLoading = false

	if self._finishCallback then
		if self._callbackTarget then
			self._finishCallback(self._callbackTarget, self)
		else
			self:_finishCallback()
		end
	end
end

return MultiAbLoader
