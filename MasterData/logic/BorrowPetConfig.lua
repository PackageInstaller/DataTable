-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/config/BorrowPetConfig.lua

module("logic.extensions.borrowpet.config.BorrowPetConfig", package.seeall)

local BorrowPetConfig = class("BorrowPetConfig", BaseConfig)

function BorrowPetConfig:onInit()
	BorrowPetConfig.super.onInit(self)
end

function BorrowPetConfig:getNames()
	return {
		"borrow_pet_activity",
		"borrow_pet_plan",
		"borrow_pet_item"
	}
end

function BorrowPetConfig:handleConfig(name, content)
	if name == "borrow_pet_activity" then
		self._borrow_pet_activity = content
	elseif name == "borrow_pet_plan" then
		self._borrow_pet_plan = content

		self:_handlePetPlan(content)
	elseif name == "borrow_pet_item" then
		self._borrow_pet_item = content
	end
end

function BorrowPetConfig:getActivityCfg(activityId)
	return self._borrow_pet_activity[activityId]
end

function BorrowPetConfig:getBorrowPetPlanCfg(planId)
	return self._borrow_pet_plan[planId]
end

function BorrowPetConfig:_handlePetPlan(content)
	self._petPlanList = {}

	local indexMap = {}

	for i, v in ipairs(content.dataList) do
		self._petPlanList[v.planId] = self._petPlanList[v.planId] or {}
		indexMap[v.planId] = indexMap[v.planId] or 1
		v.index = indexMap[v.planId]
		indexMap[v.planId] = indexMap[v.planId] + 1

		table.insert(self._petPlanList[v.planId], v)
	end
end

function BorrowPetConfig:getBorrowPetPlanListCfg(planId)
	return self._petPlanList[planId] or {}
end

function BorrowPetConfig:getBorrowPetPlanCfgByItemId(planId, itemId)
	return self._borrow_pet_plan[planId][itemId]
end

function BorrowPetConfig:getBorrowPetItemCfg(itemId)
	return self._borrow_pet_item[itemId]
end

BorrowPetConfig.instance = BorrowPetConfig.New()

return BorrowPetConfig
