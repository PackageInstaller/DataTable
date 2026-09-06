-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/model/BorrowPetModel.lua

module("logic.extensions.borrowpet.model.BorrowPetModel", package.seeall)

local BorrowPetModel = class("BorrowPetModel", BaseModel)

function BorrowPetModel:ctor()
	self._pets = {}
end

function BorrowPetModel:onInit()
	self:onReset()
end

function BorrowPetModel:onReset()
	self._pets = {}
	self._viewInfo = {}
end

function BorrowPetModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.BorrowPet)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.BorrowPet)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.BorrowPet, v.activityId) then
			local cfg = BorrowPetConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_borrow_pet_activity no cfg, id = " .. v.activityId)

			break
		end
	end

	return actId
end

function BorrowPetModel:saveBorrowPetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	info.borrowMap = {}
	info.borrowTotalTimes = 0

	if info.borrowItemIds then
		for j, id in ipairs(info.borrowItemIds) do
			if id > 0 then
				info.borrowMap[id] = true
				info.borrowTotalTimes = info.borrowTotalTimes + 1
			end
		end
	end

	info.petBorrowTimes = {}

	if info.borrowTimes then
		for i, v in ipairs(info.borrowTimes) do
			info.petBorrowTimes[v.left] = v.right
		end
	end

	self._viewInfo[info.activityId] = info
end

function BorrowPetModel:saveBorrowPet(msg)
	local info = self._viewInfo[msg.activityId]

	if msg.itemId > 0 then
		if not info.borrowMap[msg.itemId] then
			info.borrowMap[msg.itemId] = true
			info.borrowTotalTimes = 1 + (info.borrowTotalTimes or 0)
		end

		if msg.borrowTimes and info.petBorrowTimes then
			info.petBorrowTimes[msg.itemId] = msg.borrowTimes
		end
	else
		info.borrowMap[msg.itemId] = nil
	end
end

function BorrowPetModel:getIsBorrowPet(activityId, itemId)
	local info = self._viewInfo[activityId]

	if info then
		return info.borrowMap[itemId] or false
	end

	return false
end

function BorrowPetModel:getBorrowPetList(activityId)
	local info = self._viewInfo[activityId]

	if info then
		return info.borrowItemIds or {}
	end

	return {}
end

function BorrowPetModel:getBorrowTotalTimes(activityId)
	local info = self._viewInfo[activityId]

	if info then
		return info.borrowTotalTimes or 0
	end

	return 0
end

function BorrowPetModel:getPetBorrowTimes(activityId, itemId)
	local info = self._viewInfo[activityId]

	if info and info.petBorrowTimes then
		return info.petBorrowTimes[itemId] or 0
	end

	return 0
end

function BorrowPetModel:setPet(petId, data)
	if self._pets[petId] then
		local oldData = self._pets[petId]:GetClone()

		self._pets[petId]:initMo(data)
		MountModel.instance:checkMountLogicRaceId(oldData.raceId)

		return oldData
	else
		local bagPetMo = BorrowPetMo.New()
		local petId = bagPetMo:initMo(data)

		self._pets[petId] = bagPetMo

		MountModel.instance:checkMountLogicRaceId(bagPetMo.raceId)
	end

	MaterialFacade.instance:AddMaterial(MatType.BorrowPet, petId, 1)
end

function BorrowPetModel:getPets()
	return self._pets
end

function BorrowPetModel:getPet(id)
	local mo

	return (self._pets or nil) and self._pets[id]
end

function BorrowPetModel:getExistPet(petId)
	local mo

	if self._pets then
		mo = self._pets[petId]
	end

	if mo and mo:isExist() then
		return mo
	end

	return nil
end

function BorrowPetModel:getBagPets()
	local ret = {}

	for i, v in pairs(self._pets) do
		if v:isExist() then
			table.insert(ret, v)
		end
	end

	return ret
end

BorrowPetModel.instance = BorrowPetModel.New()

return BorrowPetModel
