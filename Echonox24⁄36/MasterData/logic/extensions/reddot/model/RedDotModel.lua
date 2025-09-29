-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reddot/model/RedDotModel.lua

module("logic.extensions.reddot.model.RedDotModel", package.seeall)

local M = class("RedDotModel", BaseModel)

function M:ctor()
	self._cacheData = {}
	self._redDotDetailIds = {}
	self._redDotKeyParentDic = {}
end

function M:onInit()
	return
end

function M:getRedDotInfo(key)
	local info = self._cacheData[key]

	if not info then
		info = {}
		info.isActive = false
		self._cacheData[key] = info
	end

	return info
end

function M:setDotIsActivite(valueData)
	if type(valueData) == "table" then
		local info = self:getRedDotInfo(valueData.key)

		info.isActive = valueData.isActive
		info.parentKey = valueData.parentKey
	end
end

function M:getDotIsActive(key)
	local info = self:getRedDotInfo(key)

	return info.isActive
end

function M:getDotIsActiveByParentKey(parentKey, isNum)
	local num = 0

	if parentKey then
		if isNum then
			for k, v in pairs(self._cacheData) do
				if v.isActive and parentKey == v.parentKey then
					num = num + 1
				end
			end
		else
			for k, v in pairs(self._cacheData) do
				if v.isActive and parentKey == v.parentKey then
					num = 1

					break
				end
			end
		end
	end

	return num ~= 0, num
end

function M:setCurKeyParent(key, parentKey)
	self._redDotKeyParentDic[key] = parentKey
end

function M:getCurKeyParentKey(key)
	return self._redDotKeyParentDic[key]
end

function M:updateRedDotInfo(redPoints)
	for k, v in ipairs(redPoints) do
		self:addRedDotDetails(v.type, v.detail or "")
	end
end

function M:splitDetailStr(detail)
	local list = {}

	if string.len(detail) <= 0 then
		return list
	end

	local iBegin = string.find(detail, "%[")
	local iEnd = string.find(detail, "%]")

	if not iBegin or not iEnd then
		return list
	end

	local idsStr = string.sub(detail, iBegin + 1, iEnd - 1)
	local isMult = string.find(detail, ",")

	if not isMult then
		table.insert(list, idsStr)
	else
		local idsList = string.split(idsStr, ",")

		for k, v in pairs(idsList) do
			table.insert(list, v)
		end
	end

	return list
end

function M:addRedDotDetails(type, detail)
	self._redDotDetailIds[type] = self._redDotDetailIds[type] or {}

	local list = self:splitDetailStr(detail)

	for k, v in pairs(list) do
		if not table.indexof(self._redDotDetailIds[type], v) then
			table.insert(self._redDotDetailIds[type], v)
		end
	end
end

function M:removeRedDotDetail(type, detail)
	self._redDotDetailIds[type] = self._redDotDetailIds[type] or {}

	local listForRemove = self:splitDetailStr(detail)
	local newIdsStrLst = {}

	for _, valStr in pairs(self._redDotDetailIds[type]) do
		if not table.indexof(listForRemove, valStr) and not table.indexof(newIdsStrLst, valStr) then
			table.insert(newIdsStrLst, valStr)
		end
	end

	self._redDotDetailIds[type] = newIdsStrLst
end

function M:removeRedDotCache(type)
	self._redDotDetailIds[type] = nil
end

function M:getRedDotDetailList(type)
	return self._redDotDetailIds[type] or {}
end

function M:getIdIsInDetail(type, id)
	local newType = type .. "_" .. id

	return self:getDotIsActive(newType)
end

function M:createDotView(data)
	local objPrefabBeh = false

	if data and data.dotNode then
		objPrefabBeh = Astral.SimpleLuaComponentContainer.Add(data.dotNode, RedDotComponent)

		objPrefabBeh:updateRedDot(data.keyList, data.parentKeyList, data.rejectKeyList)
		self:updateKeyParent(data)
	else
		printError("增加红点component失败")
		TableUtil.dump(data)
	end

	return objPrefabBeh
end

function M:deleteDotView(prefabBeh)
	if prefabBeh then
		prefabBeh:onReset()
		Astral.SimpleLuaComponentContainer.Remove(prefabBeh:getViewNode(), RedDotComponent)
	end
end

function M:updateKeyParent(data)
	if data.parentKeyList then
		self._parentKeyMap = self._parentKeyMap or {}

		for k, v in pairs(data.keyList or {}) do
			self._parentKeyMap[v] = self._parentKeyMap[v] or {}

			for k1, v1 in pairs(data.parentKeyList) do
				self._parentKeyMap[v][v1] = true
			end
		end
	end
end

function M:getParentKeys(key)
	self._parentKeyMap = self._parentKeyMap or {}

	if self._parentKeyMap[key] then
		local parentKeys = {}

		for k, v in pairs(self._parentKeyMap[key]) do
			table.insert(parentKeys, k)
		end

		return parentKeys
	end
end

function M:updateRedDotKey(obj, keyList, parentKeyList, rejectKeyList)
	if obj then
		obj:updateRedDot(keyList, parentKeyList, rejectKeyList)
	end
end

function M:clear()
	self._cacheData = {}
	self._redDotDetailIds = {}
end

M.instance = M.New()

return M
