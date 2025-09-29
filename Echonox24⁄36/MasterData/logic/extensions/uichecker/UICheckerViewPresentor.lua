-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uichecker/UICheckerViewPresentor.lua

module("logic.extensions.uichecker.UICheckerViewPresentor", package.seeall)

local M = class("UICheckerViewPresentor", ViewPresentor)

M._loadingBlockNum = 0
M._OutPutJson = true

function M:ctor()
	M.super.ctor(self)
end

function M:getNowTime()
	local unixTime = TimeUtils.GetUnixTimeWithDecimal()

	return unixTime
end

function M:printError(msg)
	printError(string.format("[%s] %s", self:getViewName(), msg))
end

function M:printUICacheData(save)
	if save then
		local jsonStr = self:table2json(self._uiCheckData)
		local unixTime = TimeUtils.GetUnixTime()
		local path

		if self._uiCheckData.viewTime.openUseTime >= 2 then
			path = string.format("%s/uichecker/viewOpen/over2s/%s_%s.json", PlayerModel.instance:getPersonalPath(), self:getViewName(), unixTime)

			self:printError("界面打开耗时超过2s")
		elseif self._uiCheckData.viewTime.openUseTime >= 1 then
			path = string.format("%s/uichecker/viewOpen/over1s/%s_%s.json", PlayerModel.instance:getPersonalPath(), self:getViewName(), unixTime)
		else
			path = string.format("%s/uichecker/viewOpen/%s_%s.json", PlayerModel.instance:getPersonalPath(), self:getViewName(), unixTime)
		end

		Astral.FileUtils.Instance:WriteFile(jsonStr, path)
	end
end

function M:_setCacheLoadRes(resPaths)
	local nowTime = self:getNowTime()

	self._uiCheckData.resLoaderTime = {}
	self._uiCheckData.resLoaderTime.resCount = #resPaths
	self._uiCheckData.resLoaderTime.resBeginTime = nowTime
end

function M:open(param, windowOpenReasonType, isBackOpen)
	self._uiCheckData = {}
	self._uiCheckData.viewTime = {}
	self._uiCheckData.viewTime.viewOpenTime = self:getNowTime()

	M.super.open(self, param, windowOpenReasonType, isBackOpen)
end

function M:_doOpen(windowOpenReasonType)
	local nowTime = self:getNowTime()

	self._uiCheckData.viewTime.openUseTime = nowTime - self._uiCheckData.viewTime.viewOpenTime

	self:printUICacheData(self._OutPutJson)
	M.super._doOpen(self, windowOpenReasonType)
end

function M:loadViewResources()
	local toloadList = self:dependWhatResources()

	if toloadList and #toloadList then
		self._resLoader = SequenceLoader.instance:getResLoader()

		SequenceLoader.instance:setResPaths(self._resLoader, toloadList)
		SequenceLoader.instance:load(self._resLoader, M._onViewResourcesLoaded, self._onOneViewResourceLoaded, self)
	else
		self:_onViewResourcesLoaded(nil)
	end
end

function M:_onOneViewResourceLoaded(loader)
	if not loader.IsSuccess then
		return
	end

	local nowTime = self:getNowTime()
	local beginTime = self._uiCheckData.resLoaderTime.resBeginTime

	self._uiCheckData.resLoaderTime[loader.ResPath] = {}
	self._uiCheckData.resLoaderTime[loader.ResPath].callBackTime = nowTime - beginTime
end

function M:_onViewResourcesLoaded(loader)
	local beginTime = self._uiCheckData.resLoaderTime.resBeginTime
	local nowTime = self:getNowTime()
	local useTime = nowTime - beginTime

	self._uiCheckData.resLoaderTime.resEndTime = nowTime
	self._uiCheckData.resLoaderTime.resUseTime = useTime

	M.super._onViewResourcesLoaded(self, loader)
end

function M:isArrayTable(t)
	if type(t) ~= "table" then
		return false
	end

	local n = #t

	for i, v in pairs(t) do
		if type(i) ~= "number" then
			return false
		end

		if n < i then
			return false
		end
	end

	return true
end

function M:_table2json(key, value)
	if self:isArrayTable(value) then
		return self:_array2json(key, value)
	end

	local tableStr = self:table2json(value)

	return string.format("\"%s\":%s,", key, tableStr)
end

function M:_array2json(key, value)
	local str = "["

	for k, v in pairs(value) do
		str = str .. self:table2json(v) .. ","
	end

	str = string.sub(str, 1, string.len(str) - 1) .. "]"

	return string.format("\"%s\":%s,", key, str)
end

function M:table2json(table)
	local str = "{"

	for k, v in pairs(table) do
		if type(v) == "string" then
			str = str .. string.format("\"%s\":\"%s\",", k, v)
		elseif type(v) == "number" then
			str = str .. string.format("\"%s\":%s,", k, v)
		elseif type(v) == "boolean" and (v ~= nil or true) then
			local value = v

			str = str .. string.format("\"%s\":%s,", k, tostring(value))
		elseif type(v) == "table" then
			str = str .. self:_table2json(k, v)
		end
	end

	str = string.sub(str, 1, string.len(str) - 1)

	return str .. "}"
end

return M
