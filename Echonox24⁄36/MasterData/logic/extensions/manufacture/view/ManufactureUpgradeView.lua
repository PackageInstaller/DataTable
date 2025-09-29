-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureUpgradeView.lua

module("logic.extensions.manufacture.view.ManufactureUpgradeView", package.seeall)

local M = class("ManufactureUpgradeView", ViewComponent)
local kCostNum = 3

function M:ctor()
	M.super.ctor(self)

	self._arrayUnlockCell = {}
end

function M:buildUI()
	local dynIcon = Astral.ImageDynIcon.Get(self:getGo("facility_yield_upgrade_tips_-1510312179"))

	dynIcon:SetImage("ui/bigbg/room/room_yield/zzc_mb_03.png")

	self._txtTitle = self:getText("facility_yield_upgrade_tips_-1138924223")
	self._txtCurrLv = self:getText("facility_yield_upgrade_tips_-693663454")
	self._txtNextLv = self:getText("facility_yield_upgrade_tips_-1438160327")
	self._btnUpgrade = self:getBtn("facility_yield_upgrade_tips_-100353727")
	self._btnClose = self:getBtn("small_tips_common_bg_1276053964")
	self._goCanUpgrade = self:getGo("facility_yield_upgrade_tips_-1835321372")
	self._goNotUpgrade = self:getGo("facility_yield_upgrade_tips_-1356393230")
	self._goUnlockContent = self:getGo("facility_yield_upgrade_tips_1150977453")

	local costContentGO = self:getGo("facility_yield_upgrade_tips_83933318")

	self._arrayCostItem = {}

	for i = 1, kCostNum do
		local costItem = {}

		costItem.goRoot = goutil.findChild(costContentGO, string.format("expend%s", i))
		costItem.imgIcon = goutil.findChildImageComponent(costItem.goRoot, "imgIcon")
		costItem.txtNum = goutil.findChildTextComponent(costItem.goRoot, "txtValue")

		table.insert(self._arrayCostItem, costItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnUpgrade:AddClickListener(self._onClickBtnUpgrade, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	end
end

function M:onEnter()
	self:initViews()
	self:refreshViews()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
	self:clearUnlockCells()
end

function M:initViews()
	self._txtTitle.text = lang("tip_manufacturer")
end

function M:refreshViews()
	local limitLv = ManufactureModel.instance:getLimitLv()
	local currLv = ManufactureModel.instance:getLv()

	self._txtCurrLv.text = string.format("Lv.%s", currLv)
	self._txtNextLv.text = string.format("Lv.%s", currLv + 1)

	local canUpgrade = ManufactureModel.instance:canUpgradeLv(false)

	goutil.setActive(self._goCanUpgrade, canUpgrade)
	goutil.setActive(self._goNotUpgrade, not canUpgrade)

	local cfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, currLv)
	local costList = cfg.cost or {}

	for i, costItem in ipairs(self._arrayCostItem) do
		local costInfo = costList[i]

		if costInfo then
			goutil.setActive(costItem.goRoot, true)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(costInfo.id)

			IconLoader.setSprite(costItem.imgIcon, IconType.ItemIcon, itemCo.icon)

			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)
			local numColor = ownCount >= costInfo.num and "#B3B3B3" or "#FF3E48"

			costItem.txtNum.text = costInfo.num
			costItem.txtNum.color = parsecolor(numColor)
		else
			goutil.setActive(costItem.goRoot, false)
		end
	end

	self:refreshUnlockCells()
end

function M:refreshUnlockCells()
	self:clearUnlockCells()

	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local currLv = ManufactureModel.instance:getLv()

	if currLv < maxLv then
		local currLvCfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, currLv)
		local nextLvCfg = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufacture, currLv + 1)

		if not string.nilorempty(currLvCfg.upgradeDesc) then
			self:_createDescUnlockCell(currLvCfg.upgradeDesc)
		end

		if nextLvCfg.jobCount > currLvCfg.jobCount then
			self:_createJobUnlockCell(nextLvCfg.jobCount)
		end

		local COs = ManufactureConfig.instance:getSchemeListByUnlockLv(currLv + 1)

		self:_createSchemeUnlockCell(COs)
	end
end

function M:_createUnlockCell()
	local cellGO = self:getResInstance(ResName.Room_facility_yield_unlock_cell)
	local unlockCell = Astral.LuaComponentContainer.Add(cellGO, RoomUnlockCell)

	goutil.addChildToParent(cellGO, self._goUnlockContent)
	table.insert(self._arrayUnlockCell, unlockCell)

	return unlockCell
end

function M:_createDescUnlockCell(descStr)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_up_result"))
	unlockCell:setDescription(true, descStr)
	unlockCell:setOrders(false)
end

function M:_createJobUnlockCell(jobIndex)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_unlock_team"))
	unlockCell:setDescription(false)

	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Manufacturing]
	local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCodeList[jobIndex])
	local data = {}

	data.nameStr = cfg.jobName
	data.iconType = IconType.HouseCompile
	data.iconName = cfg.icon

	unlockCell:setOrders(true, {
		data
	})
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

			table.insert(dataList, data)
		end

		unlockCell:setOrders(true, dataList)
	end
end

function M:clearUnlockCells()
	for _, cell in ipairs(self._arrayUnlockCell) do
		goutil.destroy(cell:getMainGO())
	end

	self._arrayUnlockCell = {}
end

function M:_onClickBtnUpgrade()
	if ManufactureModel.instance:canUpgradeLv(true) then
		ManufactureAgent.instance:sendManufactureLevelUpRequest()
		self:close()
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onManufactureInfoReply()
	self:refreshViews()
end

function M:_onManufactureInfoChange()
	self:refreshViews()
end

return M
