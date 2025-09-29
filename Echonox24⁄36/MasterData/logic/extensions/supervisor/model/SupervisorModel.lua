-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/model/SupervisorModel.lua

module("logic.extensions.supervisor.model.SupervisorModel", package.seeall)

local M = class("SupervisorModel", BaseModel)

M.StoreCost = 1

function M:ctor()
	self:_resetData()
end

function M:onInit()
	self:_resetData()
end

function M:onLateInit()
	return
end

function M:onReset()
	self:_resetData()
end

function M:_resetData()
	self._lv = nil
	self._productivity = nil
	self._store = nil
	self._productHero = nil
	self._productHouseRatio = nil
	self._productSpeed = nil
	self._nextProductTimeStamp = nil
	self._productCostTime = nil
	self._productCostSec = nil
	self._hasLoadedInfo = false
end

function M:updateInfoByAgent(info)
	self._lv = info.level

	self:setCurrProductivity(info.productivity)
	self:setCurrStore(info.store)

	self._productHero = info.productHero
	self._productHouseRatio = info.productHouseRatio
	self._productSpeed = info.productSpeed

	self:_updateProductCostTime()
	self:updateNextProductTimeStamp()

	self._hasLoadedInfo = true
end

function M:updateNextProductTimeStamp(isPush)
	local needNum = SupervisorConfig.instance:getProductivityNeed()
	local minCount = math.ceil((needNum - self._productivity) / self._productSpeed)
	local serverDate = ServerTime.nowDate()
	local currSecond = isPush and 0 or serverDate.sec

	self._nextProductTimeStamp = ServerTime.now() - currSecond + minCount * 60
end

function M:hasLoadedInfo()
	return self._hasLoadedInfo
end

function M:setSupervisorLv(level)
	self._lv = level
end

function M:getSupervisorLv()
	return self._lv
end

function M:getLimitLv()
	return HouseTaskModel.instance:getHouseLevel()
end

function M:getModuleLvLimit()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.muduleLevel
end

function M:setCurrStore(store)
	store = checknumber(store)
	self._store = store

	HouseMainRoomModel.instance:setHarvestNum(HouseMainEnum.HarvestTyp.Supervisor, store > 0 and 1 or 0)
end

function M:getCurrStore()
	return self._store
end

function M:getLimitStore()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.store
end

function M:getJobCount()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.jobCount
end

function M:getShelterRoomUnlockCount()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.holdRoomCount
end

function M:getSmallRoomUnlockCount()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.smallZoneCount
end

function M:getBigRoomUnlockCount()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.bigZoneCount
end

function M:getSpRoomMaxCount()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.spRoomCount
end

function M:getDescription()
	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	return cfg.desc
end

function M:getTotalMoodCost()
	local defaultCost = HouseConfig.instance:getDefaultMoodCost()
	local atmoLv = HouseMainUtil.getNormalAtmosphereLv()
	local cfg = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseAtmosphere, atmoLv)

	return defaultCost + cfg.moodConsume
end

function M:isStoreFulled()
	local currStore = self:getCurrStore()
	local limitStore = self:getLimitStore()

	return limitStore < self.StoreCost + currStore
end

function M:setCurrProductivity(productivity)
	self._productivity = productivity
end

function M:getProductSpeed()
	return self._productSpeed
end

function M:getProductHero()
	return self._productHero
end

function M:getProductHouseRatio()
	return self._productHouseRatio
end

function M:getProductCostTime()
	return self._productCostTime
end

function M:getProductCostSec()
	return self._productCostSec
end

function M:getNextProductTimeStamp()
	return self._nextProductTimeStamp
end

function M:getNextProductProgress()
	local remainTime = self._nextProductTimeStamp - ServerTime.now()
	local progress = remainTime > 0 and (self._productCostTime - remainTime) / self._productCostTime or 1

	progress = math.max(0, progress)

	return progress
end

function M:getRemainTimeToFull()
	local remainTime = 0

	if not self:isStoreFulled() then
		local currStore = self:getCurrStore()
		local limitStore = self:getLimitStore()
		local remainCount = math.floor((limitStore - currStore) / self.StoreCost)

		remainCount = math.max(0, remainCount - 1)
		remainTime = self._nextProductTimeStamp - ServerTime.now() + remainCount * self._productCostSec
		remainTime = math.max(0, remainTime)
	end

	return remainTime
end

function M:canUpgradeLv(showFloatWord)
	local canUpgrade = true
	local maxLv = SupervisorConfig.instance:getMaxLv()
	local limitLv = self:getLimitLv()

	if limitLv > self._lv then
		local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)
		local costEnough = true

		for _, costInfo in ipairs(cfg.cost or {}) do
			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)

			if ownCount < costInfo.num then
				costEnough = false

				break
			end
		end

		if not costEnough then
			canUpgrade = false

			if showFloatWord then
				FloatWordMgr.instance:show(lang("tip_prop_not_enough_1"))
			end
		end
	else
		canUpgrade = false

		if showFloatWord then
			if limitLv < maxLv then
				FloatWordMgr.instance:show(lang("tip_supervisor_lang_13"))
			else
				FloatWordMgr.instance:show(lang("tip_supervisor_lang_14"))
			end
		end
	end

	return canUpgrade
end

function M:_updateProductCostTime()
	local needNum = SupervisorConfig.instance:getProductivityNeed()
	local minCount = needNum / self._productSpeed

	self._productCostSec = minCount * 60
	self._productCostTime = math.ceil(minCount) * 60
end

M.instance = M.New()

return M
