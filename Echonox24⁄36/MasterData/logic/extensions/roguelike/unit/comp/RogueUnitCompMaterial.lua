-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/RogueUnitCompMaterial.lua

module("logic.extensions.roguelike.unit.comp.RogueUnitCompMaterial", package.seeall)

local M = class("RogueUnitCompMaterial", RogueUnitCompBase)
local kSelectOutline = UnityEngine.Shader.PropertyToID("_SelectOutlineColor")
local kSelectOutlineWidth = UnityEngine.Shader.PropertyToID("_SelectOutline")

function M:onInit()
	M.super.onInit(self)
	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReuse()
	return
end

function M:onReset()
	return
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:setOutlineColor(colorString, intensity)
	self._materialSetter:SetColor(kSelectOutline, colorString, intensity)
end

function M:setOutlineWidth(width)
	self._materialSetter:SetFloat(kSelectOutlineWidth, width)
end

function M:turnOnLayerMask(layer)
	if self._materialSetter then
		return self._materialSetter:TurnOnLayerMask(layer)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doLuminance faild,_materialSetter is null.")
	end
end

function M:turnOffLayerMask(layer)
	if self._materialSetter then
		return self._materialSetter:TurnOffLayerMask(layer)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doLuminance faild,_materialSetter is null.")
	end
end

function M:_onMeshModelLoaded()
	local goInst = self._unit.meshModel:getInst()

	if goInst then
		self._materialSetter = BatchMaterialSetter.Get(goInst)
		self._materialSwitcher = MaterialSwitcher.Get(goInst)

		self:setOutlineWidth(0.001)
	end
end

function M:showOutlineColor(color)
	self:setOutlineColor(color, 1)
	self:turnOnLayerMask(RenderingLayerMask.Layer20)
	settimer(0.5, function()
		self:turnOffLayerMask(RenderingLayerMask.Layer20)
	end, self, false)
end

return M
