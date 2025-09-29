-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/DeviceUpgradeSucceedView.lua

module("logic.extensions.house.view.common.DeviceUpgradeSucceedView", package.seeall)

local M = class("DeviceUpgradeSucceedView", ViewComponent)
local WorkType = HouseEnum.WorkType
local kTxtColorStr = "#DBDBDB"

function M:ctor()
	M.super.ctor(self)

	self._arrayUnlockCell = {}
end

function M:buildUI()
	self._goUnlockContent = self:getGo("facility_yield_upgrade_succeed_tips_986806565")
	self._dynImgDevice = Astral.ImageDynIcon.Get(self:getGo("facility_yield_upgrade_succeed_tips_1806287476"))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._workType = self:getFirstParam()

	if self._workType == WorkType.Supervisor then
		self._lv = SupervisorModel.instance:getSupervisorLv()
	elseif self._workType == WorkType.Manufacturing then
		self._lv = ManufactureModel.instance:getLv()
	elseif self._workType == WorkType.Trading then
		self._lv = TradingModel.instance:getLv()
	end

	self:refreshImg()
	self:refreshUnlockCells()
end

function M:onExit()
	self:clearUnlockCells()
end

function M:refreshImg()
	local key = 1

	if self._workType == WorkType.Trading then
		key = 2
	elseif self._workType == WorkType.Manufacturing then
		key = 3
	end

	local path = string.format("ui/bigbg/room/room_yield/zzc_mb_0%s.png", key)

	self._dynImgDevice:SetImage(path)
end

function M:refreshUnlockCells()
	self:clearUnlockCells()

	if self._workType == WorkType.Supervisor then
		self:_refreshSupervisorCells()
	elseif self._workType == WorkType.Manufacturing then
		self:_refreshManufacturingCells()
	elseif self._workType == WorkType.Trading then
		self:_refreshTradingCells()
	end
end

function M:_refreshSupervisorCells()
	local currLvCfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv - 1)
	local nextLvCfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, self._lv)

	if not string.nilorempty(currLvCfg.upgradeDesc) then
		self:_createDescUnlockCell(currLvCfg.upgradeDesc)
	end

	if nextLvCfg.jobCount > currLvCfg.jobCount then
		self:_createJobUnlockCell(nextLvCfg.jobCount)
	end

	local shelterRoomUnlockAdd = nextLvCfg.holdRoomCount - currLvCfg.holdRoomCount
	local smallRoomUnlockAdd = nextLvCfg.smallZoneCount - currLvCfg.smallZoneCount
	local bigRoomUnlockAdd = nextLvCfg.bigZoneCount - currLvCfg.bigZoneCount

	self:_createRoomUnlockCell(shelterRoomUnlockAdd, smallRoomUnlockAdd, bigRoomUnlockAdd)
end

function M:_refreshManufacturingCells()
	local currLvCfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self._lv - 1)
	local nextLvCfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, self._lv)

	if not string.nilorempty(currLvCfg.upgradeDesc) then
		self:_createDescUnlockCell(currLvCfg.upgradeDesc)
	end

	if nextLvCfg.jobCount > currLvCfg.jobCount then
		self:_createJobUnlockCell(nextLvCfg.jobCount)
	end

	local COs = ManufactureConfig.instance:getSchemeListByUnlockLv(self._lv)

	self:_createSchemeUnlockCell(COs)
end

function M:_refreshTradingCells()
	local currLvCfg = TradingConfig.instance:getHouseCoByLevel(self._lv - 1)
	local nextLvCfg = TradingConfig.instance:getHouseCoByLevel(self._lv)

	if not string.nilorempty(nextLvCfg.upgradeDesc) then
		self:_createDescUnlockCell(nextLvCfg.upgradeDesc)
	end

	if nextLvCfg.jobCount > currLvCfg.jobCount then
		self:_createJobUnlockCell(nextLvCfg.jobCount)
	end
end

function M:_createDescUnlockCell(descStr)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_up_result"))
	unlockCell:setDescription(true, descStr, kTxtColorStr)
	unlockCell:setOrders(false)
end

function M:_createJobUnlockCell(jobIndex)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_unlock_team"))
	unlockCell:setDescription(false)

	local jobCodeList = HouseEnum.WorkType2JobCodeList[self._workType]
	local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCodeList[jobIndex])
	local data = {}

	data.nameStr = cfg.jobName
	data.nameColorStr = kTxtColorStr

	unlockCell:setOrders(true, {
		data
	})
end

function M:_createRoomUnlockCell(shelterRoomUnlockAdd, smallRoomUnlockAdd, bigRoomUnlockAdd)
	local dataList = {}

	if shelterRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_holding_room_d"), shelterRoomUnlockAdd)
		data.nameColorStr = kTxtColorStr

		table.insert(dataList, data)
	end

	if smallRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_small_room_d"), smallRoomUnlockAdd)
		data.nameColorStr = kTxtColorStr

		table.insert(dataList, data)
	end

	if bigRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_big_room_d"), bigRoomUnlockAdd)
		data.nameColorStr = kTxtColorStr

		table.insert(dataList, data)
	end

	if #dataList > 0 then
		local unlockCell = self:_createUnlockCell()

		unlockCell:setTitle(lang("tip_unlock_facility"))
		unlockCell:setDescription(false)
		unlockCell:setOrders(true, dataList)
	end
end

function M:_createSchemeUnlockCell(schemeCOs)
	if #schemeCOs > 0 then
		local unlockCell = self:_createUnlockCell()

		unlockCell:setTitle(lang("tip_unlock_solution"))
		unlockCell:setDescription(false)

		local dataList = {}

		for _, CO in ipairs(schemeCOs) do
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(CO.id)
			local data = {}

			data.quality = itemCo.quality

			local iconType = IconType.ItemIcon

			if itemCo.type == GameEnum.ItemTypeEnum.FurnitureItemType then
				iconType = IconType.Furniture
			end

			data.iconType = iconType
			data.iconName = itemCo.icon
			data.nameStr = itemCo.name
			data.nameColorStr = kTxtColorStr

			table.insert(dataList, data)
		end

		unlockCell:setOrders(true, dataList)
	end
end

function M:_createUnlockCell()
	local cellGO = self:getResInstance(ResName.Room_facility_yield_unlock_cell)
	local unlockCell = Astral.LuaComponentContainer.Add(cellGO, RoomUnlockCell)

	goutil.addChildToParent(cellGO, self._goUnlockContent)
	table.insert(self._arrayUnlockCell, unlockCell)

	return unlockCell
end

function M:clearUnlockCells()
	for _, cell in ipairs(self._arrayUnlockCell) do
		goutil.destroy(cell:getMainGO())
	end

	self._arrayUnlockCell = {}
end

function M:_onClickBtnClose()
	self:close()
end

return M
