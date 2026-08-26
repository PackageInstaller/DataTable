-- chunkname: @framework/luamono/LuaMonoContainer.lua

module("framework.luamono.LuaMonoContainer", package.seeall)

local LuaMonoContainer = class("LuaMonoContainer")
local containers_static = {}

function LuaMonoContainer.tryDispose()
	for container, _ in pairs(containers_static) do
		if gohelper.isNil(container._go) then
			if isDebugBuild then
				logWarn("保底 destory: " .. container._path)
			end

			callWithCatch(container.__onDispose, container)
		end
	end
end

function LuaMonoContainer:__onDispose()
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
	self._tempList = nil
	self._hasStarted = false
	self._compDirty = true
end

function LuaMonoContainer:ctor(monoCom)
	self._monoCom = monoCom
	self._go = monoCom.gameObject
	self._luaMonoList = {}
	self._compNames = {}
	self._hasStarted = false
	self._compDirty = true

	if isDebugBuild then
		self._path = SLFramework.GameObjectHelper.GetPath(self._go)
	end

	containers_static[self] = true
end

function LuaMonoContainer:getCompNames()
	return self._compNames
end

function LuaMonoContainer:addCompOnce(clsDefine, ctorParam)
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

		comp:addEventListeners()
	end

	self._compDirty = true

	table.insert(self._luaMonoList, comp)
	table.insert(self._compNames, comp.__cname)

	return comp
end

function LuaMonoContainer:removeComp(comp)
	local count = #self._luaMonoList
	local tmpComp

	for idx = count, 1, -1 do
		if comp == self._luaMonoList[idx] then
			self._compDirty = true

			table.remove(self._luaMonoList, idx)
			table.remove(self._compNames, idx)
			self:_onRemove(self._luaMonoList[idx])

			break
		end
	end
end

function LuaMonoContainer:removeCompByDefine(clsDefine)
	local count = #self._luaMonoList
	local tmpComp

	for idx = count, 1, -1 do
		if isTypeOf(self._luaMonoList[idx], clsDefine) then
			self._compDirty = true

			table.remove(self._luaMonoList, idx)
			table.remove(self._compNames, idx)
			self:_onRemove(self._luaMonoList[idx])

			break
		end
	end
end

function LuaMonoContainer:_onRemove(comp)
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

function LuaMonoContainer:getComp(clsDefine)
	for _, comp in ipairs(self._luaMonoList) do
		if isTypeOf(comp, clsDefine) then
			return comp
		end
	end

	return nil
end

function LuaMonoContainer:onEnable()
	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		if comp.onEnable then
			comp:onEnable()
		end
	end

	tempTable = nil
end

function LuaMonoContainer:onDisable()
	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		if comp.onDisable then
			comp:onDisable()
		end
	end

	tempTable = nil
end

function LuaMonoContainer:onStart()
	self._hasStarted = true

	local tempTable = self:_getCompListTemp()

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

function LuaMonoContainer:onUpdate()
	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		if comp.onUpdate then
			comp:onUpdate()
		end
	end

	tempTable = nil
end

function LuaMonoContainer:onDestroy()
	if not containers_static[self] then
		return
	end

	containers_static[self] = nil

	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		self:_onRemove(comp)
	end

	tempTable = nil
	self._monoCom = nil
	self._go = nil
	self._luaMonoList = nil
	self._tempList = nil
	self._hasStarted = false
	self._compDirty = true
end

function LuaMonoContainer:onTriggerEnter(other)
	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		if comp.onTriggerEnter then
			comp:onTriggerEnter(other)
		end
	end

	tempTable = nil
end

function LuaMonoContainer:onTriggerExit(other)
	local tempTable = self:_getCompListTemp()

	for _, comp in ipairs(tempTable) do
		if comp.onTriggerExit then
			comp:onTriggerExit(other)
		end
	end

	tempTable = nil
end

function LuaMonoContainer:_getCompListTemp()
	if self._compDirty then
		self._tempList = self._tempList or {}

		for i, comp in ipairs(self._luaMonoList) do
			self._tempList[i] = comp
		end

		for i = #self._luaMonoList + 1, #self._tempList do
			self._tempList[i] = nil
		end

		self._compDirty = false
	end

	return self._tempList
end

return LuaMonoContainer
