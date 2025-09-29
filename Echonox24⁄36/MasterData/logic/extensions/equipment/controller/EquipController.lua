-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/controller/EquipController.lua

module("logic.extensions.equipment.controller.EquipController", package.seeall)

local M = class("EquipController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._echoFilterCfg = BackpackEchoFilterCfg.New()
	self._equipFilterCfg = CommonEquipFilterCfg.New()
	self._isChangeEquipViewNeedScroll = false
	self._curPart = false
	self._lastSelectedEquipMo = nil
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._dealItemCountChange, self)
	self:onReset()
end

function M:onReset()
	self._selectedEquipMo = nil
	self._needCheckIsSuit = false

	self._equipFilterCfg:reset()
	self._equipFilterCfg:addFilterWhiteList(CommEnum.EquipFilterKind.EquipPart, CommEnum.EquipFilterKind.D6Part)
end

function M:resetEquipFilterCfg()
	self._equipFilterCfg:reset()
end

function M:setNeedCheckIsSuit(needCheck)
	self._needCheckIsSuit = needCheck
end

function M:getNeedCheckIsSuit()
	return self._needCheckIsSuit
end

function M:setEnteredChangeView()
	self._isEnteredChangeView = true
end

function M:getIsHeroSuitChanged(suitId)
	self._lastSuitId = suitId

	if self._isEnteredChangeView then
		self._isEnteredChangeView = false

		return true, suitId and true
	end

	return false, false
end

function M:getLastSelectedEquipMo()
	return self._lastSelectedEquipMo
end

function M:setLastSelectedEquipMo(value)
	self._lastSelectedEquipMo = value
end

function M:_dealItemCountChange()
	EquipSuitModel.instance:updateSuitNum()
end

function M:getEquipFilterCfg()
	return self._equipFilterCfg
end

function M:getEquipSelectIndex()
	local multipleValue = self._equipFilterCfg:getPartFilterType()

	for index, v in pairs(EquipEnum.PartTypeList) do
		if MultipleEnumUtil.multipleEnumIs(multipleValue, v) then
			return index
		end
	end

	return 1
end

function M:setCurEquipFirst(list, part)
	if not list or not part then
		return
	end

	if self._operateHero then
		local equips = self._operateHero:getHeroEquipData()
		local equipMO = equips:getEquipByPart(part)

		if equipMO then
			local uuid = equipMO:getUuid()

			BackpackUtil.SetSpecialEquipId(uuid)
			BackpackUtil.setOriginOrder(list)
			table.sort(list, BackpackUtil.SpecialEquipSort)
		end
	end
end

function M:setEquipFilterCfgPartType(part)
	self._curPartEquipedUUid = false
	self._selectedEquipMo = false
	self._curPart = part
	part = MultipleEnumUtil.getOneMultipleValue(part)

	self._equipFilterCfg:setPartFilterType(part)
end

function M:isPartEquipHasSuitId(part, suitId)
	local equips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)

	for _, equip in ipairs(equips) do
		if equip:getPart() == part and equip:getSuitId() == suitId then
			return true
		end
	end

	return false
end

function M:setEquipFilterCfgSuit(suit)
	self._equipFilterCfg:setSuitId(suit)
end

function M:setEquipFilterCfgDices(dices)
	local list = {}

	for k, v in pairs(dices) do
		local id = v:getAttrId()

		list[id] = id
	end

	self._equipFilterCfg:setDiceIds(list)
end

function M:getEchoFilterCfg()
	return self._echoFilterCfg
end

function M:getEquipsBeforeFilter()
	local equips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local filterCfg = CommonEquipFilterCfg.New()

	filterCfg:setPartFilterType(self._equipFilterCfg:getPartFilterType())

	equips = FilterCfgUtil.commonEquipsFilter(equips, filterCfg)

	return equips
end

function M:getFilterEquipMoList(sortFun, autoSelect)
	if self._operateHero and self._curPart then
		local equips = self._operateHero:getHeroEquipData()
		local equipMo = equips:getEquipByPart(self._curPart)

		self._curPartEquipedUUid = equipMo and equipMo:getUuid() or false
	end

	if self._operateHero then
		BackpackUtil.SetHeroTags(self._operateHero:getTags())
	else
		BackpackUtil.SetHeroTags(false)
	end

	local equipMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local res = FilterCfgUtil.commonEquipsFilter(equipMoList, self._equipFilterCfg)

	table.sort(res, ItemUtil.commonSortFunc)
	BackpackUtil.setOriginOrder(res)

	if #res > 0 then
		if sortFun then
			table.sort(res, sortFun)
		end

		if autoSelect then
			local defaultSelect

			for _, equip in ipairs(res) do
				if equip:getUuid() == self._curPartEquipedUUid then
					self._selectedEquipMo = equip

					break
				end

				if not equip:getIsEquip() and defaultSelect == nil then
					defaultSelect = equip
				end
			end

			if not self._selectedEquipMo then
				if defaultSelect ~= nil then
					self._selectedEquipMo = defaultSelect
				else
					self._selectedEquipMo = res[1]
				end
			end
		end
	end

	return res
end

local function _setHeroEquipment(heroId, part, equipData)
	if not heroId or heroId == 0 then
		return
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroData then
		printError("背包中不存在该卡牌　heroId = " .. tostring(heroId))

		return
	end

	local heroEquipData = heroData:getHeroEquipData()

	heroEquipData:refreshEquipByPart(part, equipData)
end

function M:refreshEquipInfo(infos)
	if not infos or not ItemModel.instance:isItemloaded() then
		return
	end

	for _, EquipInfoNO in ipairs(infos) do
		local equipData = ItemModel.instance:getItemDataByUuid(EquipInfoNO.equipUuid)

		if not equipData then
			printError("背包中不存在该装备 equipUuid = " .. tostring(EquipInfoNO.equipUuid))

			return
		end

		_setHeroEquipment(equipData:getHeroId(), equipData:getPart(), nil)
	end

	for _, EquipInfoNO in ipairs(infos) do
		local equipUuid = EquipInfoNO.equipUuid
		local heroId = EquipInfoNO.heroId
		local level = EquipInfoNO.level
		local exp = EquipInfoNO.exp
		local attrs = EquipInfoNO.attrs
		local originDiceAttr = EquipInfoNO.originDiceAttr
		local extraDiceAttrs = EquipInfoNO.extraDiceAttrs
		local extraDiceAttrNum = EquipInfoNO.extraDiceAttrNum
		local isDiscard = EquipInfoNO.discard
		local equipData = ItemModel.instance:getItemDataByUuid(equipUuid)

		if not equipData then
			printError("背包中不存在该装备 equipUuid = " .. tostring(equipUuid))

			return
		end

		equipData:setLevelAndExp(level, exp)
		equipData:refreshAttrs(attrs)
		equipData:setDiceAttr(originDiceAttr)
		equipData:setExtraDiceAttrs(extraDiceAttrs)
		equipData:setIsDiscard(isDiscard)
		equipData:setHeroId(heroId)
		equipData:setExtraDiceAttrNum(extraDiceAttrNum)
		_setHeroEquipment(heroId, equipData:getPart(), equipData)
	end

	EquipSuitModel.instance:updateSuitNum()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_INFO_REFRESH)
end

function M:refreshD6Info(infos)
	if not infos or not ItemModel.instance:isItemloaded() then
		return
	end

	for _, DiceInfoNO in ipairs(infos) do
		local diceUuid = DiceInfoNO.diceUuid
		local attrs = DiceInfoNO.attrs
		local d6ItemData = ItemModel.instance:getItemDataByUuid(diceUuid)

		if not d6ItemData then
			printError("背包中不存在该d6 diceUuid = " .. tostring(diceUuid))

			return
		end

		d6ItemData:setIsDiscard(DiceInfoNO.discard)
		d6ItemData:refreshAttrs(attrs)
	end

	GlobalDispatcher:dispatchEvent(EventType.D6_INFO_REFRESH)
end

function M:setSelectedEquipMo(mo)
	if self._selectedEquipMo and self._selectedEquipMo:getUuid() == mo:getUuid() then
		return
	end

	self._selectedEquipMo = mo

	GlobalDispatcher:dispatchEvent(EventType.EQUIP_SELECT_CELL)
end

function M:getSelectedEquipMo()
	return self._selectedEquipMo
end

function M:setOperateHero(hero)
	self._operateHero = hero
end

function M:getOperateHero()
	return self._operateHero
end

function M:getChangeEquipViewNeedScroll()
	return self._isChangeEquipViewNeedScroll
end

function M:setChangeEquipViewNeedScroll(isNeed)
	self._isChangeEquipViewNeedScroll = isNeed
end

function M:getDiceList()
	if not self._diceListData then
		self._diceListData = {}

		local diceList = EquipmentConfig.instance:getConfigList(ConfigName.DiceAttr)

		for i = 1, #diceList do
			local dice = diceList[i]

			if dice.isFilter == 1 then
				local value = EquipmentConfig.instance:getStrValue(EquipEnum.diceFiterTips)

				table.insert(self._diceListData, DiceAttrMO.New({
					diceAttrId = dice.id,
					value = value
				}))
			end
		end

		table.sort(self._diceListData, function(item1, item2)
			return item1:getAttrId() > item2:getAttrId()
		end)
	end

	return self._diceListData
end

function M:getSuitList()
	local part = self:getEquipSelectIndex()

	if not self._suitListData then
		self._suitListData = {}
	end

	if not self._suitListData[part] then
		local res = {}
		local allSuit = EquipSuitModel.instance:getAllSuitMap()
		local j = 1

		for k, v in pairs(allSuit) do
			if k ~= CommEnum.CommonAll then
				res[j] = v
				j = j + 1
			end
		end

		table.sort(res, function(item1, item2)
			return item1:getId() > item2:getId()
		end)

		self._suitListData[part] = res
	end

	local allEquips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local flag = {}

	for i, equipMo in ipairs(allEquips) do
		local suitId = equipMo:getSuitId()
		local moPart = equipMo:getPart()

		if moPart == part then
			flag[suitId] = true
		end
	end

	for k, v in pairs(self._suitListData[part]) do
		local id = v:getId()

		if id == CommEnum.CommonAll then
			v:setIsOwner(true)
		else
			v:setIsOwner(flag[id] or false)
		end
	end

	return self._suitListData[part]
end

function M:getAllSuitList()
	if not self._allSuitListData then
		local res = {}
		local allSuit = EquipSuitModel.instance:getAllSuitMap()
		local j = 1

		for k, v in pairs(allSuit) do
			if k ~= CommEnum.CommonAll and v:isFilter() then
				res[j] = v
				j = j + 1
			end
		end

		self._allSuitListData = res
	end

	local allEquips = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)
	local flag = {}

	for i, equipMo in ipairs(allEquips) do
		local suitId = equipMo:getSuitId()

		flag[suitId] = true
	end

	local ownlist = {}
	local unownlist = {}

	for k, v in pairs(self._allSuitListData) do
		local id = v:getId()

		v:setIsOwner(flag[id] or false)

		if flag[id] then
			table.insert(ownlist, v)
		else
			table.insert(unownlist, v)
		end
	end

	self:_sortFilterSuitList(ownlist)
	self:_sortFilterSuitList(unownlist)
	table.insertto(ownlist, unownlist, 0)

	return ownlist
end

function M:_sortFilterSuitList(list)
	table.sort(list, function(item1, item2)
		if item1:getSort() ~= item2:getSort() then
			return item1:getSort() < item2:getSort()
		end

		return item1:getId() < item2:getId()
	end)
end

function M:getIsSuit(equipList)
	local suitId = false

	for i = 1, EquipEnum.MaxSuitCount do
		if not equipList[i] then
			return false
		end

		local suitIdNew = equipList[i]:getSuitId()

		if not suitIdNew or suitId and suitId ~= suitIdNew then
			return false
		end

		suitId = suitIdNew
	end

	return true
end

function M:checkHerosEquipRedpointInDungeonPre(heroIdList)
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false) then
		return false
	end

	if not heroIdList or #heroIdList < 1 then
		return false
	end

	for _, heroId in ipairs(heroIdList) do
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if not heroData then
			printError("背包中不存在该卡牌　heroId = " .. tostring(heroId))
		else
			local heroEquipData = heroData:getHeroEquipData()

			if heroEquipData and heroEquipData:checkForBattleRedPoint() then
				return heroId
			end
		end
	end

	return false
end

function M:checkHerosEquipForFailTips(heroIdList)
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false) then
		return false, false
	end

	if not heroIdList or #heroIdList < 1 then
		return false, false
	end

	local tempList = BattleTableUtil.getTempList()
	local minCarryCount = EquipEnum.MaxPartType

	for _, heroId in ipairs(heroIdList) do
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if not heroData then
			printError("背包中不存在该卡牌　heroId = " .. tostring(heroId))
		else
			local equipCount = 0
			local heroEquipData = heroData:getHeroEquipData()

			if heroEquipData then
				for index = 1, EquipEnum.MaxPartType do
					local equip = heroEquipData:getEquipByPart(index)

					if equip then
						equipCount = equipCount + 1
					end
				end
			end

			if equipCount < minCarryCount then
				table.clear(tempList)
				table.insert(tempList, heroId)

				minCarryCount = equipCount
			elseif equipCount == minCarryCount then
				table.insert(tempList, heroId)
			end
		end
	end

	local heroCode = BattleCalculateMgr.instance:findFirstHeroCodeByDefaultRules(tempList)

	BattleTableUtil.releaseTempList(tempList)

	return true, heroCode
end

M.instance = M.New()

return M
