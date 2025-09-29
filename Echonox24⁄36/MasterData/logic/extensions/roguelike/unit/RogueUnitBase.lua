-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/RogueUnitBase.lua

module("logic.extensions.roguelike.unit.RogueUnitBase", package.seeall)

local M = class("RogueUnitBase", ReusableUnitBase)

function M:NewObject(name)
	local goUnit = goutil.create(name, false)
	local unit = Astral.LuaComponentContainer.Add(goUnit, self)

	return unit
end

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self._id = 0
	self.go = componetContainer.gameObject
	self._trs = self.go.transform
	self._compList = {}

	self:_init()
end

function M:_init()
	return
end

function M:reuse()
	self:_notifyComponents(BattleFunctionName.onReuse)
end

function M:reset()
	self:_notifyComponents(BattleFunctionName.onReset)
end

function M:destroy()
	self:_notifyComponents(BattleFunctionName.onDestroy)
	self:OnDestroy()
end

function M:_initComponents()
	return
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function M:OnDestroy()
	self._compList = {}
end

function M:_notifyComponents(functionName, ...)
	for _, component in pairs(self._compList or {}) do
		local func = component[functionName]

		if func then
			func(component, ...)
		end
	end
end

return M
