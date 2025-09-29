-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/pool/util/BattleReusableCollection.lua

module("logic.battle.pool.util.BattleReusableCollection", package.seeall)

local BattleReusableCollection = class("BattleReusableCollection")

function BattleReusableCollection:ctor(class)
	self._class = class
	self._usingList = {}
end

function BattleReusableCollection:createInstance(...)
	local inst = self._class:createInstance(...)

	table.insert(self._usingList, inst)

	return inst
end

function BattleReusableCollection:releaseInstance(inst)
	inst:returnSelf()
	table.removebyvalue(self._usingList, inst)
end

function BattleReusableCollection:pairs()
	return pairs(self._usingList)
end

function BattleReusableCollection:clear()
	for _, inst in pairs(self._usingList) do
		inst:returnSelf()
	end

	BattleTableUtil.clearTable(self._usingList)
end

return BattleReusableCollection
