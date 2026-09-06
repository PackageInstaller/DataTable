-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/model/AixinmmModel.lua

module("logic.extensions.aixinmm.model.AixinmmModel", package.seeall)

local AixinmmModel = class("AixinmmModel", BaseModel)

function AixinmmModel:ctor()
	return
end

function AixinmmModel:onInit()
	self:onReset()
end

function AixinmmModel:onReset()
	self._passBits = {}
	self._everEvolvePet = false
end

function AixinmmModel:setClgInfo(msg)
	self._passBits = msg.passBits
	self._everEvolvePet = msg.everEvolvePet
end

function AixinmmModel:isEverEvolvePet()
	return self._everEvolvePet
end

function AixinmmModel:getPassBits()
	return self._passBits
end

function AixinmmModel:isAllClgPass()
	local mcfgs = AixinmmConfig.instance:getMonsterCfgs()

	for i, v in ipairs(mcfgs) do
		if not self._passBits[i] then
			return false
		end
	end

	return true
end

function AixinmmModel:getClgPassStateById(masterId)
	return self._passBits[masterId]
end

function AixinmmModel:getClgForm(masterId)
	local form = {}

	for i = 1, 9 do
		form[i] = 0
	end

	local spPetCos = AixinmmConfig.instance:getCreepCfgs(masterId)

	if not spPetCos then
		return form
	end

	for i, spPetCo in ipairs(spPetCos) do
		form[spPetCo.posId] = spPetCo.creepsId
	end

	return form
end

function AixinmmModel:challengeEnd(msg)
	UIJumper.instance:pushOneStack(ViewName.AixinmmmainView)
	UIJumper.instance:pushOneStack(ViewName.AixinmmchallengeView)

	if msg.isWin then
		local isAllPass = true

		for i, v in ipairs(self._passBits) do
			if not v then
				isAllPass = false

				break
			end
		end

		if not isAllPass then
			self._passBits = msg.newPassBits
			isAllPass = true

			for i, v in ipairs(self._passBits) do
				if not v then
					isAllPass = false

					break
				end
			end

			if isAllPass then
				UIJumper.instance:pushOneStack(ViewName.AixinmmunlockView)
			end
		end
	end
end

function AixinmmModel:getMainViewShowRaceId()
	return 50343
end

AixinmmModel.instance = AixinmmModel.New()

return AixinmmModel
