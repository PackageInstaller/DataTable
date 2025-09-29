-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/model/ManufactureModel.lua

module("logic.extensions.manufacture.model.ManufactureModel", package.seeall)

local M = class("ManufactureModel", BaseModel)

function M:ctor()
	self._dictPlant = {}

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
	self._hasLoadedInfo = false

	table.clear(self._dictPlant)
end

function M:getPlantById(id)
	local mo = self._dictPlant[id]

	if not mo then
		mo = ManufacturePlantMO.New(id)
		self._dictPlant[id] = mo
	end

	return mo
end

function M:updateInfoByAgent(info)
	self._lv = info.level

	for _, plantNO in ipairs(info.plants or {}) do
		local mo = self:getPlantById(plantNO.id)

		mo:updateByAgent(plantNO)
	end

	self._hasLoadedInfo = true
end

function M:hasLoadedInfo()
	return self._hasLoadedInfo
end

function M:setLv(level)
	self._lv = level
end

function M:getLimitLv()
	return SupervisorModel.instance:getModuleLvLimit()
end

function M:getLv()
	return self._lv or 1
end

function M:getPlantLimitStore()
	local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self:getLv())

	return cfg.store
end

function M:getJobCount()
	local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self:getLv())

	return cfg.jobCount
end

function M:getBaseProductivity()
	local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self:getLv())

	return cfg.productivity
end

function M:getDescription()
	local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self:getLv())

	return cfg.desc
end

function M:setTotalStoreToMainView()
	local totalPlantNum = 0

	for _, plantMO in pairs(self._dictPlant) do
		if not plantMO:isLock() and plantMO:getCurrStore() > 0 then
			totalPlantNum = totalPlantNum + 1
		end
	end

	HouseMainRoomModel.instance:setHarvestNum(HouseMainEnum.HarvestTyp.Manufacturing, totalPlantNum)
end

function M:canUpgradeLv(showFloatWord)
	local canUpgrade = true
	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local limitLv = self:getLimitLv()

	if limitLv > self:getLv() then
		local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self:getLv())
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
				FloatWordMgr.instance:show(lang("tip_up_office_level"))
			else
				FloatWordMgr.instance:show(lang(""))
			end
		end
	end

	return canUpgrade
end

function M:getProducingSchemeCount(schemeId)
	local count = 0

	for _, plant in pairs(self._dictPlant) do
		if plant:getSchemeId() == schemeId then
			count = count + 1
		end
	end

	return count
end

M.instance = M.New()

return M
