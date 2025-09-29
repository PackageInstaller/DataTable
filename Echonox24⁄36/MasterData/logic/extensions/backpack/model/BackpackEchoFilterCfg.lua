-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackEchoFilterCfg.lua

module("logic.extensions.backpack.model.BackpackEchoFilterCfg", package.seeall)

local CommAll = CommEnum.CommonAll
local M = class("BackpackEchoFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._qualityFilterType = CommAll
	self._careerFilterType = CommAll
	self._hideEquipped = nil
end

function M:resetFilterViewData()
	self._qualityFilterType = CommAll
	self._careerFilterType = CommAll
end

function M:setQualityFilterType(filterType)
	self._qualityFilterType = filterType
end

function M:getQualityFilterType()
	return self._qualityFilterType
end

function M:setCareerFilterType(filterType)
	self._careerFilterType = filterType
end

function M:getCareerFilterType()
	return self._careerFilterType
end

function M:setHideEquipped(hideEquipped)
	self._hideEquipped = hideEquipped
end

function M:getHideEquipped()
	return self._hideEquipped
end

function M:doFilter(list)
	local quality = self:getQualityFilterType()
	local career = self:getCareerFilterType()
	local hideEquipped = self:getHideEquipped()
	local isRecycling = MainBackpackModel.instance:isInRecycling()
	local res = {}

	for _, itemData in ipairs(list) do
		if itemData:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
			if not isRecycling and (career == CommEnum.CareerFilterType.All or career == MultipleEnumUtil.getOneMultipleValue(CommEnum.CareerFilterType.Puzzle)) then
				table.insert(res, itemData)
			end
		elseif MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(career, itemData:getCareer()) and (not hideEquipped or itemData:getHeroId() == 0) and career ~= MultipleEnumUtil.getOneMultipleValue(CommEnum.CareerFilterType.Puzzle) and (not isRecycling or itemData:isCanDecompose()) then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	local quality = self:getQualityFilterType()
	local career = self:getCareerFilterType()
	local hideEquipped = self:getHideEquipped()

	if itemData:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		return true
	end

	return MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(career, itemData:getCareer()) and (not hideEquipped and true or itemData:getHeroId() == 0)
end

return M
