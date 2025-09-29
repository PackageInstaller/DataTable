-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolEquipView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolEquipView", package.seeall)

local M = class("RogueHackToolEquipView", ViewComponent)
local kMaxEquipLevel = 10

function M:buildUI()
	self._imgEquipIcon = self:getImage("rungroup_equip_main_view_-1480059542")
	self._imgEquipIcon2 = self:getImage("rungroup_equip_main_view_-424295038")
	self._imgCostIcon = self:getImage("rungroup_equip_main_view_1443333306")
	self._imgCostIcon2 = self:getImage("rungroup_equip_main_view_-2038346395")
	self._txtEquipName = self:getText("rungroup_equip_main_view_-1541164687")
	self._txtEquipDesc = self:getText("rungroup_equip_main_view_1996667338")
	self._txtEquipCurLv = self:getText("rungroup_equip_main_view_-1182299931")
	self._txtEquipCurLv2 = self:getText("rungroup_equip_main_view_-98684751")
	self._txtEquipNextLv = self:getText("rungroup_equip_main_view_-93144019")
	self._txtEquipNextLv2 = self:getText("rungroup_equip_main_view_-716163247")
	self._txtPassiveDesc = self:getText("rungroup_equip_main_view_-350418796")
	self._txtPassiveDesc2 = self:getText("rungroup_equip_main_view_-748296745")
	self._txtProactiveDesc = self:getText("rungroup_equip_main_view_-1635818266")
	self._txtProactiveDesc2 = self:getText("rungroup_equip_main_view_-606341255")
	self._txtCostCount = self:getText("rungroup_equip_main_view_-1086258845")
	self._txtCostCount2 = self:getText("rungroup_equip_main_view_-498891606")
	self._btnUpgrade = self:getBtn("rungroup_equip_main_view_-1321100471")
	self._btnUpgrade2 = self:getBtn("rungroup_equip_main_view_-657133378")
	self._btnCloseUpgrade = self:getBtn("rungroup_equip_main_view_-8830003")
	self._goUpgradePanel = self:getGo("rungroup_equip_main_view_-1886372418")
	self._goHackTool = self:getGo("rungroup_equip_main_view_-1253298213")
	self._btnDress = self:getBtn("rungroup_equip_main_view_560870309")
	self._dropdownLevel = self:getUIComponent("rungroup_equip_main_view_1189380689", UIComponentType.DropdownApapter)
	self._goEquipScroll = self:getGo("rungroup_equip_main_view_-273873212")
	self._goUpgrade = self:getGo("rungroup_equip_main_view_736208824")
	self._goWear = self:getGo("rungroup_equip_main_view_2139831312")
	self._btnWear = self:getBtn("rungroup_equip_main_view_1643664512")
	self._txtBtnWear = self:getText("rungroup_equip_main_view_-111100714")
	self._equipScroll = LoopGridViewHelper.New(self._goEquipScroll)

	self._equipScroll:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._imgEquipIcon = nil
	self._imgCostIcon = nil
	self._txtEquipName = nil
	self._txtEquipDesc = nil
	self._txtEquipCurLv = nil
	self._txtEquipNextLv = nil
	self._txtPassiveDesc = nil
	self._txtProactiveDesc = nil
	self._txtCostCount = nil
	self._btnUpgrade = nil

	self._equipScroll:Dispose()

	self._equipScroll = nil
end

function M:bindEvents()
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnCloseUpgrade:AddClickListener(self._onHideUpgradePanel, self)
	self._btnWear:AddClickListener(self._onClickWear, self)
	self._btnDress:AddClickListener(self._onClickDress, self)
	self._dropdownLevel:AddListener(self._dealDropDownLevel, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnCloseUpgrade:RemoveClickListener()
	self._btnWear:RemoveClickListener()
	self._btnDress:RemoveClickListener()
	self._dropdownLevel:RemoveClickListener()
end

function M:_dealDropDownLevel(idx)
	self._equipLevel = 5 - idx

	local curMo = self._equipMos[self._curSelectIndex]

	curMo:setLevel(self._equipLevel)
	self:updateCurShowEquip(curMo)
end

function M:onEnter()
	self:setEvent(true)

	self._curSelectIndex = nil

	self:showAllEquips()
	goutil.setActive(self._goWear, false)
	goutil.setActive(self._goUpgrade, false)
	goutil.setActive(self._goHackTool, true)
end

function M:onExit()
	self:setEvent(false)
	self._equipScroll:ClearCells()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_UPGRADE, self._onEquipUpgrade, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_WEAR, self._onEquipWear, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_UPGRADE, self._onEquipUpgrade, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_WEAR, self._onEquipWear, self)
	end
end

function M:_onEquipRefresh()
	self:showAllEquips()
end

function M:_onEquipWear()
	self:close()
end

function M:_onEquipUpgrade(sender, id, lv)
	local equipCo = RoguelikeConfig.instance:getEquipById(id, lv)

	if equipCo then
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(id)

		self._txtPassiveDesc2.text = equipCo.passiveEffectDescription
		self._txtProactiveDesc2.text = equipCo.activeEffectDescription

		IconLoader.setSprite(self._imgEquipIcon2, IconType.ItemIcon, itemCo.icon)

		local costItem2 = equipCo.cost and equipCo.cost[1] or nil

		if costItem2 then
			local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem2.id)

			IconLoader.setSprite(self._imgCostIcon2, IconType.ItemIcon, co1.icon)

			self._txtCostCount2.text = "x" .. costItem2.num
		end

		self._txtEquipCurLv2.text = "Lv." .. lv - 1
		self._txtEquipNextLv2.text = lv >= RoguelikeConfig.instance:getEquipMaxLevel(id) and "已满级" or "Lv." .. lv

		goutil.setActive(self._goUpgradePanel, true)
	end
end

function M:showAllEquips()
	local equipsMos = {}
	local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeEquipType)
	local count = cos and #cos or 0

	for k, v in pairs(cos) do
		local data = {}

		data.id = v.id
		data.cd = 1
		data.lv = 1

		local mo = RogueEquipMo.New(data)

		table.insert(equipsMos, mo)
	end

	self._equipMos = equipsMos

	if count > 0 and self._curSelectIndex == nil then
		self._curSelectIndex = 1

		self:updateCurShowEquip(self._equipMos[self._curSelectIndex])
	end

	self._equipScroll:ClearCells()
	self._equipScroll:SetListItemCount(count, true)
	self._equipScroll:RefreshAllShownItem()

	if self._curSelectIndex then
		self:updateCurShowEquip(self._equipMos[self._curSelectIndex])
	end
end

function M:_onShowUpgradePanel()
	if self._curSelectEquipMo and not self._curSelectEquipMo:getIsMaxLevel() then
		goutil.setActive(self._goUpgradePanel, true)
	else
		FloatWordMgr.instance:show("当前装备已满级")
	end
end

function M:_onHideUpgradePanel()
	goutil.setActive(self._goUpgradePanel, false)
end

function M:checkIsWear(id)
	local curEquipMos = RoguelikeModel.instance:getCurEquipMOS() or {}

	for k, v in pairs(curEquipMos) do
		if v:getId() == id then
			return true
		end
	end

	return false
end

function M:_onClickWear()
	if self._curSelectEquipMo then
		local id = self:checkIsWear(self._curSelectEquipMo:getId()) and 0 or self._curSelectEquipMo:getId()

		RoguelikeAgent.instance:sendWearEquipRequest(id)
	else
		print("暂未选择装备")
	end
end

function M:_onClickDress()
	local callback = self:getFirstParam()

	if callback then
		local curMo = self._equipMos[self._curSelectIndex]

		curMo:setLevel(self._equipLevel)
		callback(curMo)
	end

	self:close()
end

function M:_onClickUpgrade()
	if self._curSelectEquipMo then
		local isMaxLevel = self._curSelectEquipMo:getIsMaxLevel()

		if isMaxLevel then
			FloatWordMgr.instance:show("装备已满级")

			return
		end

		RoguelikeAgent.instance:sendUpgradeEquipRequest(self._curSelectEquipMo:getId())
	else
		print("暂未选择装备")
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._equipScroll:NewListViewItem("backpack_item")
	local data = self._equipMos[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, RogueEquipItem)

	shower.view = self

	shower:setCellData(data, curIndex, self._curSelectIndex)
	shower:setClickCallBack(self._clickEquipCallBack, self)

	return item
end

function M:_clickEquipCallBack(index)
	self._curSelectIndex = index

	local count = self._equipMos and #self._equipMos or 0

	self._equipScroll:SetListItemCount(count, true)
	self._equipScroll:RefreshAllShownItem()
	self:updateCurShowEquip(self._equipMos[index])
end

function M:updateCurShowEquip(data)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data:getId())

	IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, itemCo.icon)

	local equipCo = RoguelikeConfig.instance:getEquipById(data:getId(), data:getLevel())

	self._txtEquipName.text = itemCo.name
	self._txtEquipDesc.text = itemCo.desc
	self._txtPassiveDesc.text = equipCo.passiveEffectDescription
	self._txtProactiveDesc.text = equipCo.activeEffectDescription

	local costItem = equipCo.cost and equipCo.cost[1] or nil

	if costItem then
		local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem.id)

		IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, co1.icon)
		IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, co1.icon)

		self._txtCostCount.text = "x" .. costItem.num
	end

	self._txtEquipCurLv.text = "Lv." .. data:getLevel()
	self._txtEquipNextLv.text = data:getIsMaxLevel() and "已满级" or "Lv." .. data:getLevel() + 1
	self._curSelectEquipMo = data
	self._txtBtnWear.text = self:checkIsWear(data:getId()) and "卸下" or "穿戴"

	if not data:getIsMaxLevel() then
		local equipCo2 = RoguelikeConfig.instance:getEquipById(data:getId(), data:getLevel() + 1)

		if equipCo2 then
			self._txtPassiveDesc2.text = equipCo2.passiveEffectDescription
			self._txtProactiveDesc2.text = equipCo2.activeEffectDescription

			IconLoader.setSprite(self._imgEquipIcon2, IconType.ItemIcon, itemCo.icon)

			local costItem2 = equipCo2.cost and equipCo2.cost[1] or nil

			if costItem2 then
				local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem2.id)

				IconLoader.setSprite(self._imgCostIcon2, IconType.ItemIcon, co1.icon)

				self._txtCostCount2.text = "x" .. costItem2.num
			end

			self._txtEquipCurLv2.text = "Lv." .. data:getLevel()
			self._txtEquipNextLv2.text = data:getIsMaxLevel() and "已满级" or "Lv." .. data:getLevel() + 1
		end
	end

	if self._dropdownLevel.dropdown then
		self._dropdownLevel.dropdown.value = 5 - data:getLevel()
	end
end

return M
