-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/util/LocalReusableCollection.lua

module("logic.common.pool.util.LocalReusableCollection", package.seeall)

local LocalReusableCollection = class("LocalReusableCollection")

function LocalReusableCollection:ctor(class, capacity)
	self._localPool = ReusablePool.New(class, capacity)
	self._reusableList = {}
end

function LocalReusableCollection:createInstance(...)
	local inst = self._localPool:fetchObject(...)

	table.insert(self._reusableList, inst)

	return inst
end

function LocalReusableCollection:releaseInstance(inst)
	self._localPool:returnObject(inst)
	table.removebyvalue(self._reusableList, inst)
end

function LocalReusableCollection:pairs()
	return pairs(self._reusableList)
end

function LocalReusableCollection:clear()
	self:clearAllInstance()
	self:clearPool()
end

function LocalReusableCollection:clearAllInstance()
	for _, inst in pairs(self._reusableList) do
		self._localPool:returnObject(inst)
	end

	BattleTableUtil.clearTable(self._reusableList)
end

function LocalReusableCollection:clearPool()
	self._localPool:clear()
end

return LocalReusableCollection
