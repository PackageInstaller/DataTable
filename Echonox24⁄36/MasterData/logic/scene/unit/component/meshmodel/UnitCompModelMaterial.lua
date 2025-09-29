-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompModelMaterial.lua

module("logic.scene.unit.component.meshmodel.UnitCompModelMaterial", package.seeall)

local M = class("UnitCompModelMaterial", UnitComponentBase)
local kScreenDoorAlpha = UnityEngine.Shader.PropertyToID("_Transparency")
local kScreenDoorKeyWord = "_SCREEN_ON"

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._materialSetter = nil
end

function M:onReset()
	self:clear()
end

function M:onDestroy()
	self:onReset()
end

function M:clear()
	self:clearPropertyBlock()
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:Clear()
	end

	self._materialSetter = nil
end

function M:clearPropertyBlock()
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:ClearPropertyBlock()
	end
end

function M:setEnable(key, enable)
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:SetBool(key, enable)
	end
end

function M:setFloat(nameId, value)
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:SetFloat(nameId, value)
	end
end

function M:setScreenDoorAlphaEnable(enable)
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:KillAll(false)
		self._materialSetter:SetBool(kScreenDoorKeyWord, enable)
	end
end

function M:setScreenDoorAlpha(alpha)
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:KillAll(false)
	end

	self:setFloat(kScreenDoorAlpha, alpha)
end

function M:doScreenDoorAlpha(from, to, duration)
	self:setScreenDoorAlphaEnable(true)
	self:_getMaterialSetter()

	if self._materialSetter then
		self._materialSetter:DOFloat(kScreenDoorAlpha, from, to, duration)
	end
end

function M:_getMaterialSetter()
	self._materialSetter = nil

	local goInst = self._unit.meshModel:getInst()

	if goInst then
		self._materialSetter = BatchMaterialSetter.Get(goInst)
	end
end

return M
