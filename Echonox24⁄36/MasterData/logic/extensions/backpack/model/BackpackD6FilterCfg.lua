-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackD6FilterCfg.lua

module("logic.extensions.backpack.model.BackpackD6FilterCfg", package.seeall)

local CommAll = CommEnum.CommonAll
local M = class("BackpackD6FilterCfg", BackpackBaseFilterCfg)
local FilterType = CommEnum.D6FilterType

function M:ctor()
	M.super.ctor(self)

	self._simplePart = CommAll
	self._simpleResonance = CommAll
	self._simpleAttribute = {}
	self._whiteList = {}
end

function M:reset()
	if not self:inWhiteList(FilterType.Part) then
		self._simplePart = CommAll
	end

	if not self:inWhiteList(FilterType.Resonance) then
		self._simpleResonance = CommAll
	end

	table.clear(self._simpleAttribute)
end

function M:addWhiteType(D6FilterType)
	self._whiteList[D6FilterType] = true
end

function M:deleteWhiteType(D6FilterType)
	self._whiteList[D6FilterType] = false
end

function M:inWhiteList(D6FilterType)
	return self._whiteList[D6FilterType] or false
end

function M:setSimplePartFilter(simplePart)
	self._simplePart = simplePart
end

function M:getSimplePartFilter()
	return self._simplePart
end

function M:setSimpleResonanceFilter(simpleResonance)
	self._simpleResonance = simpleResonance
end

function M:getSimpleResonanceFilter()
	return self._simpleResonance
end

function M:setFilterValue(filterType, value)
	if filterType == FilterType.Part then
		self:setSimplePartFilter(value)
	elseif filterType == FilterType.Resonance then
		self:setSimpleResonanceFilter(value)
	else
		self:setSimpleAttributeFilter(value)
	end
end

function M:getFilterValue(filterType)
	if filterType == FilterType.Part then
		return self:getSimplePartFilter()
	elseif filterType == FilterType.Resonance then
		return self:getSimpleResonanceFilter()
	else
		return self:getSimpleAttributeFilter()
	end
end

function M:setSimpleAttributeFilter(simpleAttribute)
	self._simpleAttribute = clone(simpleAttribute)
end

function M:getSimpleAttributeFilter()
	return self._simpleAttribute
end

function M:doFilter(list)
	local d6SimplePart = self:getSimplePartFilter()
	local d6SimpleResonance = self:getSimpleResonanceFilter()
	local d6SimpleAttr = self:getSimpleAttributeFilter()
	local res = {}

	for _, itemData in ipairs(list) do
		if FilterCfgUtil.checkD6Filter(itemData, d6SimplePart, d6SimpleResonance, d6SimpleAttr) then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	local d6SimplePart = self:getSimplePartFilter()
	local d6SimpleResonance = self:getSimpleResonanceFilter()
	local d6SimpleAttr = self:getSimpleAttributeFilter()

	return FilterCfgUtil.checkD6Filter(itemData, d6SimplePart, d6SimpleResonance, d6SimpleAttr)
end

return M
