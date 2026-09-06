-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ecs/ECSEntity.lua

module("frameworkext.ecs.ECSEntity", package.seeall)

local ECSEntity = class("ECSEntity")

function ECSEntity:ctor()
	self._comopnents = {}
end

function ECSEntity:addComponent(compCls)
	local comp = self:getComponent(compCls)

	if not comp then
		comp = compCls.New()
		comp.entity = self

		table.insert(self._comopnents, comp)
		comp:onInit()
	end

	return comp
end

function ECSEntity:getAllComponents()
	return self._comopnents
end

function ECSEntity:getComponent(compCls)
	local len = #self._comopnents
	local clsName = compCls.__cname

	for i = 1, len do
		if iskindof(self._comopnents[i], clsName) then
			return self._comopnents[i]
		end
	end

	return nil
end

function ECSEntity:removeComponent(compCls)
	local compIndex = 0
	local comp
	local len = #self._comopnents
	local clsName = compCls.__cname

	for i = 1, len do
		if iskindof(self._comopnents[i], clsName) then
			compIndex = i
			comp = self._comopnents[i]

			break
		end
	end

	if comp then
		table.remove(self._comopnents, compIndex)
		comp:onDestroy()
	end
end

function ECSEntity:destroy()
	local len = #self._comopnents

	for i = 1, len do
		self._comopnents[i]:onDestroy()
	end

	self._comopnents = nil
end

return ECSEntity
