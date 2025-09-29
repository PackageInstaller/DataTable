-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/unit/UnitCompHeroLookAtIK.lua

module("logic.common.unit.UnitCompHeroLookAtIK", package.seeall)

local M = class("UnitCompHeroLookAtIK")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._lookAtIkAdpter = LookAtIKAdpter.Get(self.mainGO)

	self._lookAtIkAdpter:SetBodyWeight(0)
	self._lookAtIkAdpter:EnableLookAt(false)

	self._lookAtIkAdpter.enabled = false

	self:setEnableLookAtIk(false)
end

function M:Awake()
	return
end

function M:OnDestroy()
	self:setEvent(false)
	self:clear()

	self._lookAtIkAdpter = nil
end

function M:clear()
	return
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:isVaild()
	if not self._lookAtIkAdpter or goutil.isNil(self._lookAtIkAdpter) then
		return false
	end

	return true
end

function M:setEnableLookAtIk(enable, info, forceSetWeight)
	if not self:isVaild() then
		return
	end

	self._lookAtIkAdpter:SetBodyWeight(0)

	if enable and info then
		local childPos = info.targetChildPos or {}

		self._lookAtIkAdpter:SetTargetChildLocalPos(childPos.x or 0, childPos.y or 0, childPos.z or 0)

		self._lookAtIkAdpter.useTargetChild = info.useTargetChild

		if info.maxRootAngle then
			self._lookAtIkAdpter:SetMaxRootAngle(info.maxRootAngle or 180)
		end

		if info.smoothTime then
			self._lookAtIkAdpter:SetSmoothTime(info.smoothTime)
		end

		if info.onlyLookForward == nil then
			info.onlyLookForward = false
		end

		self._lookAtIkAdpter.onlyLookForward = info.onlyLookForward

		self._lookAtIkAdpter:SetLookAtWeight(info.bodyWeight or -1, info.headWeight or -1, info.eyesWeight or -1)
	end

	self._lookAtIkAdpter:EnableLookAt(enable)

	if enable then
		self._lookAtIkAdpter.enabled = enable
	end

	if forceSetWeight and tonumber(forceSetWeight) then
		self._lookAtIkAdpter.weight = tonumber(forceSetWeight)
	end
end

function M:setWeight(weight)
	if not self:isVaild() then
		return
	end

	if not weight or weight < 0 or weight > 1 then
		printError("set illegal smoothTime :", weight)

		return
	end

	self._lookAtIkAdpter.weight = weight
end

function M:setSmoothTime(speed)
	if not self:isVaild() then
		return
	end

	if not speed then
		printError("set illegal smoothTime :", speed)

		speed = 0.3
	end

	self._lookAtIkAdpter:SetSmoothTime(speed)
end

function M:setMaxRootAngle(angle)
	if not self:isVaild() then
		return
	end

	if not angle or angle < 0 or angle > 180 then
		printError("set illegal Angle :", angle)

		return
	end

	self._lookAtIkAdpter:SetMaxRootAngle(angle)
end

function M:setUseTargetChild(use, x, y, z)
	if not self:isVaild() then
		return
	end

	self._lookAtIkAdpter:SetTargetChildLocalPos(x or 0, y or 0, z or 0)

	self._lookAtIkAdpter.useTargetChild = use
end

function M:setOnlyLookForward(onlyLookForward)
	if not self:isVaild() then
		return
	end

	self._lookAtIkAdpter.onlyLookForward = onlyLookForward
end

function M:setLookAtWeight(bodyWeight, headWeight, eyesWeight)
	if not self:isVaild() then
		return
	end

	self._lookAtIkAdpter:SetLookAtWeight(bodyWeight or -1, headWeight or -1, eyesWeight or -1)
end

return M
