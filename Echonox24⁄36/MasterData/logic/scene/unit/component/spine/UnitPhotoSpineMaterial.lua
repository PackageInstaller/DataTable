-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/spine/UnitPhotoSpineMaterial.lua

module("logic.scene.unit.component.spine.UnitPhotoSpineMaterial", package.seeall)

local UnitPhotoSpineMaterial = class("UnitPhotoSpineMaterial", UnitComponentBase)
local kMainColorID = UnityEngine.Shader.PropertyToID("_Color")
local kToggleScanLineID = UnityEngine.Shader.PropertyToID("_SCANLINE_ON")
local kScanlineMapID = UnityEngine.Shader.PropertyToID("_ScanlineMap")
local kScanlineMapSTID = UnityEngine.Shader.PropertyToID("_ScanlineMap_ST")
local kFlickerMapID = UnityEngine.Shader.PropertyToID("_FlickerMap")
local kFlickerMapSTID = UnityEngine.Shader.PropertyToID("_FlickerMap_ST")
local kScanlineColorID = UnityEngine.Shader.PropertyToID("_ScanlineColor")
local kToggleMaskID = UnityEngine.Shader.PropertyToID("_Switch_Mask")
local kMaskPosID = UnityEngine.Shader.PropertyToID("_MaskPos")
local kMaskFactor = UnityEngine.Shader.PropertyToID("_MaskFactor")
local kSilhouetteColor = UnityEngine.Shader.PropertyToID("_SilhouetteColor")

function UnitPhotoSpineMaterial:onInit()
	self._materialSetter = MaterialSetter.Get(self._unit.go)
	self._materialKeywordSetter = SpineMaterialKeywordSetter.Get(self._unit.go)
	self._spine = self._unit.spine or false

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
end

function UnitPhotoSpineMaterial:onReset()
	if self._materialSetter then
		self._materialSetter:Clear()
	end

	if self._materialKeywordSetter then
		self._materialKeywordSetter:Clear()
	end
end

function UnitPhotoSpineMaterial:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)

	if self._materialSetter then
		self._materialSetter:Clear()

		self._materialSetter = nil
	end

	if self._materialKeywordSetter then
		self._materialKeywordSetter:Clear()

		self._materialKeywordSetter = nil
	end
end

function UnitPhotoSpineMaterial:setMainColor(colorString)
	self._materialSetter:SetColor(kMainColorID, colorString)
end

function UnitPhotoSpineMaterial:getMainColor()
	self._materialSetter:GetColorString(kMainColorID)
end

function UnitPhotoSpineMaterial:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
	if self._materialKeywordSetter then
		self._materialKeywordSetter:SetKeyword("_SCANLINE_ON", enable)
	end

	if self._materialSetter then
		self._materialSetter:SetColor(kScanlineColorID, enable and "#BAFEFF" or "#FFFFFF")
		self:SetScanlineMap(scanLineMap, scanLineMap and Vector4.New(1, 23, 0, 15) or nil)
		self:SetFlickerMap(flickerMap, flickerMap and Vector4.New(0.2, 1, 50, 300) or nil)
	end
end

function UnitPhotoSpineMaterial:SetScanlineMap(texture, vector4)
	if texture then
		self._materialSetter:SetTexture(kScanlineMapID, texture)
	end

	self._materialSetter:SetVector4(kScanlineMapSTID, vector4 or Vector4.New(1, 1, 0, 0))
end

function UnitPhotoSpineMaterial:SetFlickerMap(texture, vector4)
	if texture then
		self._materialSetter:SetTexture(kFlickerMapID, texture)
	end

	self._materialSetter:SetVector4(kFlickerMapSTID, vector4 or Vector4.New(1, 1, 0, 0))
end

function UnitPhotoSpineMaterial:toggleMask(enable, maskPos, maskFactor)
	if self._materialSetter then
		self._materialSetter:SetFloat(kToggleMaskID, enable and 1 or 0)

		if maskPos then
			self._materialSetter:SetFloat(kMaskPosID, maskPos)
		end

		if maskFactor then
			self._materialSetter:SetFloat(kMaskFactor, maskFactor)
		end
	end
end

function UnitPhotoSpineMaterial:toggleSilhouette(enable)
	if self._materialKeywordSetter then
		self._materialKeywordSetter:SetKeyword("_SILHOUETTE_ON", enable)
	end

	if self._materialSetter then
		self._materialSetter:SetColor(kSilhouetteColor, enable and "#8FA2A0" or "#FFFFFF")
	end
end

function UnitPhotoSpineMaterial:killAll(complete)
	if self._materialSetter then
		self._materialSetter:KillAll(complete)
	elseif enableErrorLog then
		printError("UnitPhotoSpineMaterial::killAll faild,_materialSetter is null.")
	end
end

function UnitPhotoSpineMaterial:doMainAlpha(toAlpha, duration)
	if self._materialSetter then
		return self._materialSetter:DOAlpha(kMainColorID, toAlpha, duration)
	elseif enableErrorLog then
		printError("UnitPhotoSpineMaterial::doMainAlpha faild,_materialSetter is null.")
	end
end

function UnitPhotoSpineMaterial:doMainAlphaFrom(fromAlpha, toAlpha, duration)
	if self._materialSetter then
		return self._materialSetter:DOAlpha(kMainColorID, fromAlpha, toAlpha, duration)
	elseif enableErrorLog then
		printError("UnitPhotoSpineMaterial::doMainAlpha faild,_materialSetter is null.")
	end
end

function UnitPhotoSpineMaterial:doColor(colorTo, duration)
	if self._materialSetter then
		self._materialSetter:ColorTo(kMainColorID, colorTo, duration)
	elseif enableErrorLog then
		printError("UnitPhotoSpineMaterial::doMainColor faild,_materialSetter is null.")
	end
end

function UnitPhotoSpineMaterial:_onSpineLoaded()
	local goInst = self._spine:getInst()

	if not goInst then
		if enableWarnLog then
			printWarn("UnitPhotoSpineMaterial::go inst is nil")
		end

		return
	end

	if self._materialSetter then
		self._materialSetter:SetGameObject(goInst)
	elseif enableErrorLog then
		printError("UnitPhotoSpineMaterial::_onSpineLoaded faild,_materialSetter is null.")
	end

	if self._materialKeywordSetter then
		self._materialKeywordSetter:SetGameObject(goInst)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::_onSpineLoaded faild,_materialKeywordSetter is null.")
	end
end

return UnitPhotoSpineMaterial
