-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIFindMyBed.lua

module("logic.extensions.ai.impl.action.AIFindMyBed", package.seeall)

local M = class("AIFindMyBed", AINode)
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)

	self._findBath = false
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._findBath = aiConfigData.findBath
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()
	local zoneMO, bunkInfo = LivingFacilitiesZoneController.instance:findZoneByHeroId(unit.heroId)

	if zoneMO then
		local roomId = zoneMO:getId()

		if self._findBath then
			local furnMOs = HouseFurnitureModel.instance:getRoomFurnitures(roomId)

			for _, furnMO in ipairs(furnMOs) do
				if furnMO:isBathRoom() then
					local pos = HouseSceneUtil.getRandomRoomPos(roomId)

					self:getContext():setTargetPos(pos, roomId)
					self:getContext():setUseRandomPos(true)

					return self:onEnd(AIConst.AIStatus.SUCCESS)
				end
			end
		else
			local bedMO = HouseFurnitureModel.instance:getFurniture(bunkInfo.furnitureUUId)
			local posX, posY, posZ = bedMO:getPosInHouseScene()

			vec3Temp:Set(posX, posY, posZ)
			self:getContext():setTargetPos(vec3Temp, bedMO:getRoomId())
			self:getContext():setUseRandomPos(false)

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	return self
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
