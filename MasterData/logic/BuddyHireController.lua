-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/controller/BuddyHireController.lua

module("logic.extensions.buddyhire.controller.BuddyHireController", package.seeall)

local BuddyHireController = class("BuddyHireController", BaseController)

function BuddyHireController:ctor()
	BuddyHireController.super.ctor(self)
end

function BuddyHireController:onInit()
	self:onReset()
	self:IntiRaceConfig()
end

function BuddyHireController:onReset()
	return
end

function BuddyHireController:IntiRaceConfig()
	self.petRaceMap = nil

	local raceStr = BuddlyHireConfig.instance:getValueByKey("RENT_OUT_RACE")
	local arr = string.splitToNumber(raceStr, ",")

	for i, v in ipairs(arr) do
		self.petRaceMap = self.petRaceMap or {}
		self.petRaceMap[v] = true
	end
end

function BuddyHireController:checkIsLimitRace(raceId)
	local petCo = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	if petCo and petCo.canBuddyHire then
		return true
	end

	return false
end

function BuddyHireController:getOtherListInfo()
	if BuddyHireModel.instance.buddyLeasePetInfos or BuddyHireModel.instance.leasePetInfos then
		GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
	else
		BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseGetHirePetInfoReq()
	end
end

function BuddyHireController:onGetOtherListInfo(msg)
	BuddyHireModel.instance:onGetOtherListInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
end

function BuddyHireController:getMyListInfo()
	if BuddyHireModel.instance.petInfos then
		GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
	else
		BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseGetRentOutInfoReq()
	end
end

function BuddyHireController:sendGetPrize()
	BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseGainPrizeReq()
end

function BuddyHireController:onGetPrize(msg)
	BuddyHireModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
end

function BuddyHireController:onGetMyListInfo(msg)
	BuddyHireModel.instance:onGetMyListInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
end

function BuddyHireController:tryShowPetInfo(petId, userId)
	local petMo, headInfo = BuddyHireModel.instance:getPetMo(petId, userId)

	if petMo then
		GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_PET_SHOW, petMo, headInfo)
	else
		BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseGetBuddyPetInfoReq(petId, userId)
	end
end

function BuddyHireController:onGetPetDetail(msg)
	local petId = msg.petId
	local headInfo = msg.headInfo
	local petMo = BagPetMo.New()

	petMo:initBaseView(msg.petView)

	petMo._zdl = msg.zdl

	BuddyHireModel.instance:setPetMo(petId, headInfo, petMo)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_PET_SHOW, petMo, headInfo)
end

function BuddyHireController:tryHireInPet(petMo, userId)
	local count = checknumber(BuddlyHireConfig.instance:getValueByKey("HIRE_NUM"))

	if not BuddyHireModel.instance.leasePetInfos then
		if count > #BuddyHireModel.instance.leasePetInfos then
			BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseHireReq(petMo.petId, userId)
		else
			TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("本周精灵租借次数已达上限"))
		end
	end
end

function BuddyHireController:onPetHireIn(msg)
	BuddyHireModel.instance:onPetHireIn(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
end

function BuddyHireController:tryHireOutPet(petMo, idx)
	if idx == nil then
		idx = 1
	end

	local count = checknumber(BuddlyHireConfig.instance:getValueByKey("RENT_OUT_NUM"))

	if not BuddyHireModel.instance.petInfos then
		if count > #BuddyHireModel.instance.petInfos then
			BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseRentOutReq(petMo.petId, idx)
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否把当前精灵更新为新的租借精灵？"), function()
				BuddyPetLeaseAgent.instance:sendPM_BuddyPetLeaseRentOutReq(petMo.petId, idx)
			end)
		end
	end
end

function BuddyHireController:onPetHireOut(msg)
	BuddyHireModel.instance:onPetHireOut(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE)
end

BuddyHireController.instance = BuddyHireController.New()

return BuddyHireController
