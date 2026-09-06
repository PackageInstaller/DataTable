-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/model/BuddyHireModel.lua

module("logic.extensions.buddyhire.model.BuddyHireModel", package.seeall)

local BuddyHireModel = class("BuddyHireModel", BaseModel)

function BuddyHireModel:ctor()
	BuddyHireModel.super.ctor(self)
end

function BuddyHireModel:onInit()
	self:onReset()
end

function BuddyHireModel:onReset()
	self:resetMsg()

	self.petHasHireMap = {}
	self.petMoMap = {}
	self.headMap = {}
end

function BuddyHireModel:resetMsg()
	self.leasePetInfos = nil
	self.buddyLeasePetInfos = nil
	self.petInfos = nil
	self.isGainPrize = false
end

function BuddyHireModel:onGetOtherListInfo(msg)
	self.leasePetInfos = {}

	for i, v in ipairs(msg.leasePetInfos) do
		table.insert(self.leasePetInfos, v)

		local key = v.headInfo.userId .. "_" .. v.petInfo.petId

		self.petHasHireMap[key] = true
	end

	self.buddyLeasePetInfos = msg.buddyLeasePetInfos
end

function BuddyHireModel:onGetMyListInfo(msg)
	self.petInfos = {}

	for i, v in ipairs(msg.petInfos) do
		table.insert(self.petInfos, v)
	end

	self.isGainPrize = msg.isGainPrize
end

function BuddyHireModel:onGetPrize(msg)
	self.isGainPrize = true
end

function BuddyHireModel:setPetMo(petId, headInfo, mo)
	local key = headInfo.userId .. "_" .. petId

	self.petMoMap[key] = mo
	self.headMap[key] = headInfo
end

function BuddyHireModel:getPetMo(petId, userId)
	local key = userId .. "_" .. petId

	return self.petMoMap[key], self.headMap[key]
end

function BuddyHireModel:onPetHireIn(msg)
	local leasePetInfo = msg.leasePetInfo

	self.leasePetInfos = self.leasePetInfos or {}

	table.insert(self.leasePetInfos, leasePetInfo)

	local key = leasePetInfo.headInfo.userId .. "_" .. leasePetInfo.petInfo.petId

	self.petHasHireMap[key] = true
end

function BuddyHireModel:onPetHireOut(msg)
	local singlePetInfo = msg.singlePetInfo

	self.petInfos = self.petInfos or {}

	local slotId = singlePetInfo.slotId

	self.petInfos[slotId] = singlePetInfo
end

function BuddyHireModel:checkHasHire(petId, userId)
	local key = userId .. "_" .. petId

	return checkbool(self.petHasHireMap[key])
end

BuddyHireModel.instance = BuddyHireModel.New()

return BuddyHireModel
