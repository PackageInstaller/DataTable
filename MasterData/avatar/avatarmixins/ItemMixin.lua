-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ItemMixin.lua

local UIManager = UIManager
local UserData = require("Helper/UserData")
local ResBagMisc = require("ClientData/ResBagMisc")
local ResHero = require("ClientData/ResHero")
local Item = require("Common/Object/Item")
local EventConst = require("EventConst")
local ResHeroPaintItemConvert = require("ClientData/ResHeroPaintItemConvert")
local ResVowMisc = require("ClientData/ResVowMisc")
local ResServerErrorNotice = require("ClientData/ResServerErrorNotice")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ItemMixin = {}

function ItemMixin:initItemMixin(baseData, syncData)
	self.commonItems = {}
	self.fragmentItems = {}
	self.itemChangedDelegate = {}
	self.checkUniversalVowOpen = false

	for index, iInfo in ipairs(syncData.bag.item_bag.item) do
		local item = Item(iInfo)

		self:_updateItem(item)
	end

	self:checkBagRedHintOpen()
	self:rearHosueStartCheckNewItem()
end

function ItemMixin:postinitItemMixin(baseData, syncData)
	for moneyType, itId in pairs(Const.MONEY_TYPE2ID) do
		if moneyType ~= Const.MONEY_TYPE_DIAMOND_BUY then
			local money = 0

			if moneyType == Const.MONEY_TYPE_DIAMOND then
				money = self:getDiamondShowNum()
			else
				money = self:getMoneyByType(moneyType)
			end

			if money ~= 0 then
				local item = Item({
					id = itId,
					num = money
				})

				self:_updateItem(item)
			end
		end
	end

	self:refreshHouseItemFrozenNum()
	self:checkRelicUpgradeHint()
	self:checkRelationHeroNewHint()
end

function ItemMixin:_updateItem(item, fromChange)
	local oldValue

	if fromChange then
		local old = self.commonItems[item.id] or self.fragmentItems[item.id]

		if old then
			oldValue = old.num

			old:updateFromChange(item)

			item = old
		else
			item = Item(item)
		end
	end

	if not self.checkUniversalVowOpen and item.num >= 0 then
		self:refreshUniversalVowOpen(item.id)
	end

	if item:isCommonItem() then
		if oldValue == nil then
			local oldItem = self.commonItems[item.id]

			if oldItem then
				oldValue = oldItem.num
			else
				oldValue = 0
			end
		end

		if item.num ~= 0 then
			self.commonItems[item.id] = item
		else
			self.commonItems[item.id] = nil
		end
	elseif item:isFragmentItem() then
		if oldValue == nil then
			local oldItem = self.fragmentItems[item.id]

			if oldItem then
				oldValue = oldItem.num
			else
				oldValue = 0
			end
		end

		if item.num ~= 0 then
			self.fragmentItems[item.id] = item
		else
			self.fragmentItems[item.id] = nil
		end
	end

	if item and item.resData.related_activity then
		local act = item:getRelatedActivity()

		if act then
			act:checkNew()
		end
	end

	if item and self.itemChangedDelegate[item.id] then
		for cb, _ in pairs(self.itemChangedDelegate[item.id]) do
			cb(oldValue or 0, item.num)
		end
	end

	if item.subType == Const.ITEM_STYPE_STEP_MATERIAL then
		self:checkCanStepUpInTeamHeros()
	elseif item.subType == Const.ITEM_STYPE_STICK then
		self:checkHasHeroStickCanLvUp()
	end

	if self.bagRelics and item.subType == Const.ITEM_STYPE_RELIC_MATERIAL then
		self:checkRelicUpgradeHint()
	end

	self:checkGetRearHouseItem(item, oldValue or 0)
	self:checkRearHouseShopRefresh(item)
end

function ItemMixin:registerItemChangedCallBack(itemId, callBack)
	if not self.itemChangedDelegate[itemId] then
		self.itemChangedDelegate[itemId] = {}
	end

	self.itemChangedDelegate[itemId][callBack] = true
end

function ItemMixin:unregisterItemChangedCallBack(itemId, callBack)
	if self.itemChangedDelegate[itemId] then
		self.itemChangedDelegate[itemId][callBack] = nil
	end
end

function ItemMixin:checkUseItemByHasSkin(item)
	local skinHeroId = item.resData.extend_args1
	local skinId = item.resData.extend_args2
	local skinData = self.skinData[skinHeroId]

	if skinData and skinData.skin and skinData.skin[skinId] then
		return true, ResItemHeroSkin[skinHeroId][skinId]
	end

	return false, ResItemHeroSkin[skinHeroId][skinId]
end

function ItemMixin:onItemUpdateNotify(reason, new_list, change_list)
	for _, iInfo in ipairs(new_list) do
		local item = Item(iInfo)

		self:_updateItem(item)
		EventCenter.sendEvent(EventConst.ITEM_UPDATE, item.id)

		if item.subType == Const.ITEM_STYPE_UPGRADE_SKIN and item.num > 0 then
			local canUse, preSkinData = self:checkUseItemByHasSkin(item)

			if canUse then
				local use = {}

				use.data = {}
				use.data.id = item.id
				use.data.num = item.num

				RPC.itemUse({
					use
				})
			elseif preSkinData then
				MsgManager.notice(string.format(Lang.get(117199), preSkinData.name or ""))
			end
		elseif item.subType == Const.ITEM_STYPE_STICK and item.num > 0 then
			local bindHeroId = item.resData.extend_args1

			if not self:checkHasStick(bindHeroId) then
				local use = {}

				use.data = {}
				use.data.id = item.id
				use.data.num = 1

				RPC.itemUse({
					use
				})
			end
		end
	end

	for _, iInfo in ipairs(change_list) do
		self:_updateItem(iInfo, true)
		EventCenter.sendEvent(EventConst.ITEM_UPDATE, iInfo.id)
	end

	self:refreshBraceletExchange()
	self:refreshHouseItemFrozenNum()
	self:refreshItemAndFragBag()
	self:checkBagRedHintOpen()
	self:checkCrystalUpHint()
	self:checkRearHouseUpgradeHint()
	self:checkRelationHeroNewHint()
end

function ItemMixin:onItemUpdateMoneyNotify(moneyType, money)
	local iId = Const.MONEY_TYPE2ID[moneyType]

	if iId == Const.MONEY_ID_FAKE_DIAMOND then
		iId = Const.MONEY_ID_DIAMOND
	end

	self:onItemUpdateNotify("MoneyUpdate", {}, {
		{
			id = iId,
			num = money
		}
	})
end

function ItemMixin:onBagSizeExtendResp(bag_type, bag_size)
	self.bagSize[bag_type] = bag_size

	if bag_type == Const.BAG_TYPE_HERO then
		self:refreshHeroBagSize()
		MsgManager.notice(Lang.get(1863))
	else
		self:refreshItemBag()
	end

	local bagGridAddDlg = UIManager.getUI("bagGridAddDlg", nil, false)

	if bagGridAddDlg then
		bagGridAddDlg:setVisible(false)
	end
end

function ItemMixin:refreshItemBag()
	local bag = UIManager.getUI("mainBagDlg", nil, false)
	local wear = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if bag then
		bag:refreshItem()
	end

	if wear then
		wear:refreshItem()
	end
end

function ItemMixin:refreshItemAndFragBag()
	local bag = UIManager.getUI("mainBagDlg", nil, false)

	if bag then
		bag:refreshItemAndFragBag()
	end
end

function ItemMixin:onCDKeyResp()
	UIManager.getUI("giftExchangeDlg", false)
	MsgManager.notice(Lang.get(1864))
end

function ItemMixin:onCDKeyRespError(ecode, free_tick)
	if ecode == "kCSErrorCDKeyUsingTooMany" then
		local eKey = string.sub(ecode, 9)
		local strNotice = ResServerErrorNotice[eKey].notice_info
		local strTime = ClientUtils.getServerTimeData(free_tick, Lang.get(100385))

		MsgManager.notice(string.format(strNotice, strTime))
	end
end

function ItemMixin:refreshUniversalVowOpen(id)
	local _, resVowMisc = next(ResVowMisc)
	local universalVowIdList = resVowMisc.universalVowIds

	if universalVowIdList and utils.getIndexByValue(universalVowIdList, id) > 0 then
		self.checkUniversalVowOpen = true
	end
end

function ItemMixin:onErrorBagFullNotifyError()
	self:mailSystemBagFull()
end

function ItemMixin:onErrorBagFullNotify(item_id)
	self:mailSystemBagFull()

	local obj = BaseObject.GetObject(item_id, 1)

	if obj then
		MsgManager.notice(string.format(ClientUtils.getClientNotice(765), obj.name))
	end
end

function ItemMixin:getAllCommonItems()
	local items = {}

	for iid, item in pairs(self.commonItems) do
		if not Const.BAG_HIDE_STYPE[item.subType] and item.resData.hide_in_bag == nil then
			table.insert(items, item)
		end
	end

	return items
end

function ItemMixin:getAllFragmentItems()
	local items = {}

	for iid, item in pairs(self.fragmentItems) do
		table.insert(items, item)
	end

	return items
end

function ItemMixin:getItemNumById(itemId, exceptFrozen)
	if itemId == Const.MONEY_ID_FAKE_DIAMOND then
		itemId = Const.MONEY_ID_DIAMOND
	end

	local count = 0

	for _, iter in ipairs({
		self.commonItems,
		self.fragmentItems
	}) do
		for iid, item in pairs(iter) do
			if iid == itemId then
				if exceptFrozen == true then
					count = count + item.num - (item.frozenNum or 0)
				else
					count = count + item.num
				end
			end
		end
	end

	return count
end

function ItemMixin:getItemsByStype(typeDict)
	local items = {}

	for _, iter in ipairs({
		self.commonItems,
		self.fragmentItems
	}) do
		for iid, item in pairs(iter) do
			if typeDict[item.subType] and item.resData.hide_in_bag == nil then
				table.insert(items, item)
			end
		end
	end

	return items
end

function ItemMixin:openBagGridAddDlg(bagType, goRechargeCallback)
	local curMaxCount = self:getBagSize(bagType)
	local totalMaxCount = self:getBagMaxSize(bagType)

	if curMaxCount == totalMaxCount then
		MsgManager.notice(Lang.get(1865))

		return
	end

	local bagGridAddDlg = UIManager.getUI("bagGridAddDlg", true)

	if bagGridAddDlg then
		bagGridAddDlg:setBagType(bagType)

		if goRechargeCallback then
			bagGridAddDlg:setGoRechargeCallback(goRechargeCallback)
		end
	end
end

local function _clearBagFunc(bagType)
	JumpGuideManager.jump(Const.BAG_TYPE_GUIDE[bagType])
end

function ItemMixin:confirmBagAdd(bagType, addBagCallback, clearBagCallback, goRechargeCallback)
	local curMaxCount = self:getBagSize(bagType)
	local totalMaxCount = self:getBagMaxSize(bagType)

	if curMaxCount == totalMaxCount then
		local function yesFunc()
			if clearBagCallback then
				clearBagCallback()
			end

			_clearBagFunc(bagType)
		end

		local function noFunc()
			return
		end

		local msgContent = string.format(Lang.get(1861), Const.BAG_TYPE_NAME[bagType])

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, noFunc, -1, Lang.get(858), Lang.get(7))
	else
		local function yesFunc()
			if addBagCallback then
				addBagCallback()
			end

			self:openBagGridAddDlg(bagType, goRechargeCallback)
		end

		local function noFunc()
			return
		end

		local function otherFunc()
			if clearBagCallback then
				clearBagCallback()
			end

			_clearBagFunc(bagType)
		end

		local msgContent = string.format(Lang.get(1862), Const.BAG_TYPE_NAME[bagType])

		UIManager.showConfirm(UIConst.CONFIRM_THREEBTN, "", msgContent, {
			yesFunc,
			noFunc,
			otherFunc
		}, -1, {
			Lang.get(1866),
			Lang.get(7),
			Lang.get(858)
		})
	end
end

function ItemMixin:resetOpenBoxDlg()
	local openBoxChooseDlg = UIManager.getUI("openBoxChooseDlg", nil, false)

	if openBoxChooseDlg then
		openBoxChooseDlg:reChooseIfEnough()
	end
end

Const.PAINT_ITEM_MAP = {}

function ItemMixin:getHeroPaintMaterial(camp, container, filterHero)
	container = container or {}

	for heroId, heroData in pairs(ResHero) do
		if heroId ~= filterHero and heroData.camp == camp and heroData.paint_convert_disable ~= 1 then
			local itId = heroData.paint_item_id

			if itId and self.commonItems[itId] then
				Const.PAINT_ITEM_MAP[itId] = heroId

				table.insert(container, self.commonItems[itId])
			end
		end
	end

	return container
end

function ItemMixin:guideCanConvertPaintItem(args, grid)
	if grid and grid.object and grid.lackNum and grid.lackNum > 0 and grid.selectHero then
		return self:canConvertPaintItem(grid.object.id, grid.selectHero)
	end
end

function ItemMixin:canConvertPaintItem(itemId, filterHero)
	for camp, convInfo in pairs(ResHeroPaintItemConvert) do
		if convInfo[itemId] then
			for heroId, heroData in pairs(ResHero) do
				if heroId ~= filterHero and heroData.camp == camp and heroData.paint_convert_disable ~= 1 then
					local itId = heroData.paint_item_id

					if itId and self.commonItems[itId] then
						return true
					end
				end
			end
		end
	end

	return false
end

function ItemMixin:checkBagRedHintOpen()
	local haveCommonHint = false

	for itemId, item in pairs(self.commonItems) do
		if item.resData.is_hint then
			haveCommonHint = true
		end

		if item.subType == Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL then
			self.equipEvolveOpen = 1
		elseif item.subType == Const.ITEM_STYPE_UPGRADE_SKIN and self:checkUseItemByHasSkin(item) then
			haveCommonHint = true
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_BAG_MATERIAL, haveCommonHint)

	local haveFragComplete = false
	local heroIdMaxStarDic = self:getIdMaxStarDic()

	for id, frag in pairs(self.fragmentItems) do
		if frag.num >= frag.resData.extend_args1 then
			haveFragComplete = frag:getCantComposeNoticeId(heroIdMaxStarDic) == nil
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_BAG_SHATTER, haveFragComplete)
end

return ItemMixin
