-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/spine/UnitCompProtectiveSuit.lua

module("logic.scene.unit.component.spine.UnitCompProtectiveSuit", package.seeall)

local M = class("UnitCompProtectiveSuit", UnitComponentBase)
local ReplaceSlotName = HouseEnum.ReplaceSlotName
local AnimationState = HouseEnum.AnimationState
local SpineName = HouseEnum.SpineName
local kMainColorID = UnityEngine.Shader.PropertyToID("_Color")

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._wearSuitSwitch = false
	self._originUrl = nil
	self._onLoadedCallback = nil
	self._onLoadedTarget = nil
	self._preloadResLoader = nil
	self._emptySuitResLoader = nil
	self._createSuitParam = nil
	self._goEmptySuit = nil
end

function M:onInit()
	self._wearSuitSwitch = false
	self._originUrl = nil
	self._onLoadedCallback = nil
	self._onLoadedTarget = nil
	self._preloadResLoader = SingleResLoader.New()
	self._emptySuitResLoader = SingleResLoader.New()
	self._createSuitParam = nil
	self._goEmptySuit = nil
	self._removeSuitTimer = SchedulerCtrl.New(self._realRemoveEmptySuit, self)
end

function M:onReset()
	self._removeSuitTimer:stop()
	self:clearPreloadSpineRes()
	self:_realRemoveEmptySuit()

	self._onLoadedCallback = false
	self._onLoadedTarget = false
	self._createSuitParam = false
	self._originUrl = nil
	self._wearSuitSwitch = false
end

function M:onDestroy()
	self._removeSuitTimer:clear()

	self._removeSuitTimer = nil

	self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	self:clearPreloadSpineRes()
	self:_realRemoveEmptySuit()

	self._preloadResLoader = nil
	self._wearSuitSwitch = false
	self._originUrl = nil
	self._onLoadedCallback = nil
	self._onLoadedTarget = nil
	self._createSuitParam = nil
end

function M:getSwitch()
	return self._wearSuitSwitch
end

function M:switchWearing(switch)
	if self._wearSuitSwitch == switch then
		return
	end

	self._wearSuitSwitch = switch

	if switch then
		self:changeToProSuitSkin()
	else
		self:changeToOriginSkin()
	end
end

function M:preloadSpineRes(switch)
	local preloadResUrl = switch and GameUrl.getSpineUrl(SpineName.ProtectiveSuit) or self._originUrl

	if not string.nilorempty(preloadResUrl) and self._preloadResLoader then
		self._preloadResLoader:load(preloadResUrl)
	end
end

function M:clearPreloadSpineRes()
	if self._preloadResLoader then
		self._preloadResLoader:clear()
	end
end

function M:createEmptySuit(paramData)
	if self._goEmptySuit then
		return
	end

	self._createSuitParam = paramData

	if self._emptySuitResLoader:getResource() then
		self:_onEmptySuitResLoaded()
	else
		self._emptySuitResLoader:load(GameUrl.getSpineUrl(SpineName.ProtectiveSuit), self._onEmptySuitResLoaded, self)
	end
end

function M:_onEmptySuitResLoaded()
	self._goEmptySuit = self._emptySuitResLoader:getResInstance()

	goutil.setActive(self._goEmptySuit, self._createSuitParam.isActive)

	local sceneContainer = SceneMgr.instance:getCurScene():getContainer()

	goutil.addChildToParent(self._goEmptySuit, sceneContainer)
	Astral.TransformUtil.SetPos(self._goEmptySuit.transform, self._createSuitParam.bornPos.x, self._createSuitParam.bornPos.y, self._createSuitParam.bornPos.z)

	if self._createSuitParam.angle then
		Astral.TransformUtil.SetLocalRotation(self._goEmptySuit.transform, 0, 0, self._createSuitParam.angle)
	end

	local skeletonAnimation = self._goEmptySuit:GetComponent(UnitCompSpine.SkeletonAnimationType)

	skeletonAnimation.Skeleton.FlipX = self._createSuitParam.direction ~= UnitSpineDir.Default

	skeletonAnimation:PlayAnimation(self._createSuitParam.actionName, true, true)

	if self._createSuitParam.isFadeIn and self._createSuitParam.isActive then
		local materialSetter = MaterialSetter.Get(self._goEmptySuit)

		materialSetter:SetGameObject(self._goEmptySuit)
		materialSetter:SetColor(kMainColorID, "#FFFFFF00")
		materialSetter:DOAlpha(kMainColorID, 1, self._createSuitParam.fadeInTime)
	end
end

function M:removeEmptySuit(paramData)
	if paramData and paramData.isFadeOut and self._goEmptySuit then
		goutil.setActive(self._goEmptySuit, true)

		if paramData.angle then
			Astral.TransformUtil.SetLocalRotation(self._goEmptySuit.transform, 0, 0, paramData.angle)
		end

		local materialSetter = MaterialSetter.Get(self._goEmptySuit)

		materialSetter:SetGameObject(self._goEmptySuit)
		materialSetter:DOAlpha(kMainColorID, 0, paramData.fadeOutTime)
		self._removeSuitTimer:restart(paramData.fadeOutTime, false)
	else
		self:_realRemoveEmptySuit()
	end
end

function M:_realRemoveEmptySuit()
	if self._goEmptySuit then
		goutil.destroy(self._goEmptySuit)
	end

	self._goEmptySuit = nil

	self._emptySuitResLoader:clear()
end

function M:changeToProSuitSkin()
	self._originUrl = self._unit.spine._url

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	self._unit.spine:setBody(GameUrl.getSpineUrl(SpineName.ProtectiveSuit))
end

function M:changeToOriginSkin()
	if self._originUrl then
		self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
		self._unit.spine:setBody(self._originUrl)
	end
end

function M:setSpineLoadedCallback(callback, target)
	self._onLoadedCallback = callback
	self._onLoadedTarget = target
end

function M:_onSpineLoaded()
	self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	self:clearPreloadSpineRes()

	if self._onLoadedCallback then
		self._onLoadedCallback(self._onLoadedTarget)

		self._onLoadedCallback = nil
		self._onLoadedTarget = nil
	end
end

return M
