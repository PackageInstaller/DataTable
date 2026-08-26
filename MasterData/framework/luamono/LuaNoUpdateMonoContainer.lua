-- chunkname: @framework/luamono/LuaNoUpdateMonoContainer.lua

module("framework.luamono.LuaNoUpdateMonoContainer", package.seeall)

local LuaNoUpdateMonoContainer = class("LuaNoUpdateMonoContainer")
local containers_static = {}

function LuaNoUpdateMonoContainer.tryDispose()
	for container, _ in pairs(containers_static) do
		if gohelper.isNil(container._go) then
			if isDebugBuild then
				logWarn("保底 destory: " .. container._path)
			end

			callWithCatch(container.__onDispose, container)
		end
	end
end

function LuaNoUpdateMonoContainer:__onDispose()
	if not containers_static[self] then
		return
	end

	containers_static[self] = nil

	if not self._luaMonoList then
		return
	end

	for _, comp in ipairs(self._luaMonoList) do
		comp:__onDispose()
	end

	self._monoCom = nil
	self._go = nil
	self._luaMonoList = nil
	self._hasStarted = false
end

function LuaNoUpdateMonoContainer:ctor(monoCom)
	self._monoCom = monoCom
	self._go = monoCom.gameObject
	self._luaMonoList = {}
	self._hasStarted = false
	self._compNames = {}

	if isDebugBuild then
		self._path = SLFramework.GameObjectHelper.GetPath(self._go)
	end

	containers_static[self] = true
end

function LuaNoUpdateMonoContainer:getCompNames()
	return self._compNames
end

function LuaNoUpdateMonoContainer:addCompOnce(clsDefine, ctorParam)
	local comp = self:getComp(clsDefine)

	if comp ~= nil then
		return comp
	end

	comp = clsDefine.New(ctorParam)

	comp:__onInit()
	comp:init(self._go)

	if self._hasStarted then
		if comp.onEnable and self._monoCom:IsEnabled() then
			comp:onEnable()
		end

		if comp.onStart then
			comp:onStart()
		end

		if comp.addEventListeners then
			comp:addEventListeners()
		end
	end

	table.insert(self._luaMonoList, comp)
	table.insert(self._compNames, comp.__cname)

	return comp
end

function LuaNoUpdateMonoContainer:removeComp(comp)
	local count = #self._luaMonoList
	local tmpComp

	for idx = count, 1, -1 do
		if comp == self._luaMonoList[idx] then
			table.remove(self._luaMonoList, idx)
			table.remove(self._compNames, idx)
			self:_onRemove(self._luaMonoList[idx])

			break
		end
	end
end

function LuaNoUpdateMonoContainer:removeCompByDefine(clsDefine)
	local count = #self._luaMonoList
	local tmpComp

	for idx = count, 1, -1 do
		if isTypeOf(self._luaMonoList[idx], clsDefine) then
			table.remove(self._luaMonoList, idx)
			table.remove(self._compNames, idx)
			self:_onRemove(self._luaMonoList[idx])

			break
		end
	end
end

function LuaNoUpdateMonoContainer:_onRemove(comp)
	if comp.onDisable then
		comp:onDisable()
	end

	if comp.removeEventListeners then
		comp:removeEventListeners()
	end

	if comp.onDestroy then
		comp:onDestroy()
	end

	comp:__onDispose()
end

function LuaNoUpdateMonoContainer:getComp(clsDefine)
	for _, comp in ipairs(self._luaMonoList) do
		if isTypeOf(comp, clsDefine) then
			return comp
		end
	end

	return nil
end

function LuaNoUpdateMonoContainer:onEnable()
	local tempTable = {}

	for _, comp in ipairs(self._luaMonoList) do
		table.insert(tempTable, comp)
	end

	for _, comp in ipairs(tempTable) do
		if comp.onEnable then
			comp:onEnable()
		end
	end

	tempTable = nil
end

function LuaNoUpdateMonoContainer:onDisable()
	local tempTable = {}

	for _, comp in ipairs(self._luaMonoList) do
		table.insert(tempTable, comp)
	end

	for _, comp in ipairs(tempTable) do
		if comp.onDisable then
			comp:onDisable()
		end
	end

	tempTable = nil
end

function LuaNoUpdateMonoContainer:onStart()
	self._hasStarted = true

	local tempTable = {}

	for _, comp in ipairs(self._luaMonoList) do
		table.insert(tempTable, comp)
	end

	for _, comp in ipairs(tempTable) do
		if comp.onStart then
			comp:onStart()
		end

		if comp.addEventListeners then
			comp:addEventListeners()
		end
	end

	tempTable = nil
end

function LuaNoUpdateMonoContainer:onDestroy()
	if not containers_static[self] then
		return
	end

	containers_static[self] = nil

	local tempTable = {}

	for _, comp in ipairs(self._luaMonoList) do
		table.insert(tempTable, comp)
	end

	for _, comp in ipairs(tempTable) do
		self:_onRemove(comp)
	end

	tempTable = nil
	self._monoCom = nil
	self._go = nil
	self._luaMonoList = nil
	self._hasStarted = false
end

return LuaNoUpdateMonoContainer
