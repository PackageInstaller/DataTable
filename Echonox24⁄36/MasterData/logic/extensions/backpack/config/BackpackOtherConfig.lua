-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/config/BackpackOtherConfig.lua

module("logic.extensions.backpack.config.BackpackOtherConfig", package.seeall)

local M = class("BackpackOtherConfig", BaseConfig)

function M:onInit()
	self._typeNameDict = nil
end

function M:getNames()
	return {
		ConfigName.ItemGetTips,
		ConfigName.ItemTypeName
	}
end

function M:getTipsById(id)
	return self._dict[ConfigName.ItemGetTips][id]
end

function M:getTypeNameByTS(type, subType)
	self._typeNameDict = nil

	if not self._typeNameDict then
		self._typeNameDict = TableUtil.getTableMap(self._dict[ConfigName.ItemTypeName].dataList, "type", "subType")
	end

	local info = self._typeNameDict[type]

	info = info and info[subType]

	return info and info.name or ""
end

M.instance = M.New()

return M
