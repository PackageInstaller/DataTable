-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/controller/ToolTipsController.lua

module("logic.extensions.tooltips.controller.ToolTipsController", package.seeall)

local ItemTypeEnum = GameEnum.ItemTypeEnum
local PropSubTypeEnum = GameEnum.PropSubTypeEnum
local M = class("ToolTipsController", BaseController)

local function fn(type, subType)
	return ItemUtil.getItemKeyByTS(type, subType)
end

function M:ctor()
	M.super.ctor(self)

	self._useFuncMap = {}
	self._useFuncMap[GameEnum.ItemTypeEnum.HeroItemType * 1000 + CommEnum.HeroItemSubType.HeroHeartAnchor] = self._openComposeItemView
	self._useFuncMap[GameEnum.ItemTypeEnum.HeroItemType * 1000 + CommEnum.HeroItemSubType.HeroChip] = self._openComposeItemView
	self._useFuncMap[GameEnum.ItemTypeEnum.HeroItemType * 1000 + CommEnum.HeroItemSubType.NormalHeartAnchor] = self._openComposeItemView
	self._useFuncMap[GameEnum.ItemTypeEnum.HeroItemType * 1000 + CommEnum.HeroItemSubType.NormalChip] = self._openComposeItemView
	self._useFuncMap[GameEnum.ItemTypeEnum.PropItemType * 1000 + CommEnum.PropSubType.AirtightTimeProp] = self._useAirtightTimeItem
end

function M:onInit()
	self:_registerUseFunc()
	ToolTipsUtil.init()
	GlobalDispatcher:addEventListener(EventType.ITEM_USE_EVENT, self._dealItemUse, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_NORMAL_MARK_TYPE, self._clickCell, self)
	GlobalDispatcher:addEventListener(EventType.TOP_MONEY_ITEM_JUMP_CLICK, self._handleTopMoneyItemJumpClick, self)
	GlobalDispatcher:addEventListener(EventType.TOP_MONEY_ITEM_ADD_CLICK, self._handleTopMoneyItemAddClick, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_GET_ATTR_INFO_EVENT, self._getItemAttr, self)
end

function M:_registerUseFunc()
	return
end

function M:_dealItemUse(e, data)
	if data then
		local type, subType = data.type, data.subType

		if type and subType then
			local func = self._useFuncMap[fn(type, subType)]

			if func then
				func(self, data)
			else
				GlobalDispatcher:dispatchEvent(EventType.ITEM_DEFAULT_USE_EVENT, data.uuid, data.itemId, data.count, data.param)
			end
		end
	end
end

function M:_useCardExp()
	return
end

function M:_clickCell(e, itemData, go, index, isShowTips, passEvent, isHideGetWay, isHideLock)
	if not isShowTips then
		return
	end

	local data = ToolTipsUtil.createItemTipsData(itemData, go, passEvent)

	data.passEvent = true
	data.isHideGetWay = isHideGetWay
	data.isHideLock = isHideLock

	if passEvent ~= nil then
		data.passEvent = passEvent
	end

	local itemId = itemData:getItemId()

	if ItemUtil.isCharacterById(itemId) then
		CharacterUtil.openCharacterPreviewView(itemId)
	elseif ItemUtil.isCharacterSkinById(itemId) then
		CharacterSkinFacade.instance:showSingleSkin(itemId)
	elseif itemData:getPrefabId() then
		BackpackAgent.instance:sendGetPrefabItemInfoRequest(itemData:getPrefabId(), data)
	else
		ToolTipsMgr.showTips(data.viewName, data)
	end
end

function M:_getItemAttr(evt, prefabItemId, itemNo, tipsData)
	tipsData.baseData = ItemUtil.createItemData(itemNo)

	ToolTipsMgr.showTips(tipsData.viewName, tipsData)
end

function M:_openComposeItemView(data)
	local sourceId = data.itemId
	local sourceData = ItemModel.instance:getItemsByItemId(sourceId)[1]
	local targetId = tonumber(sourceData:getExtrInfo())
	local targetData = ItemModel.instance:getItemsByItemId(targetId)[1]

	targetData = targetData or ItemData.New({
		count = 0,
		itemId = targetId
	})

	local heroId = targetData:getItemInfo().heroId
	local heroCO = BackpackConfig.instance:getItemInfoByItemId(heroId)
	local heroPieceCO = HeroPieceConfig.instance:getInfo(heroCO.quality)

	if heroPieceCO then
		sourceStep = heroPieceCO.pieceNum
	end

	ToolTipsMgr.showItemExchangeTips(sourceId, targetId, sourceStep, 1, true, 1, 0, 0)
end

function M:_useAirtightTimeItem(data)
	ToolTipsMgr.showAirtightRoomTimeOpenTips()
end

function M:setInCloseTipsTime(delayTime)
	self._isInCloseTime = true
	delayTime = delayTime or 0.02

	removetimer(self._delaySetCloseTime, self)
	settimer(delayTime, self._delaySetCloseTime, self, false)
end

function M:getInCloseTipsTime()
	return self._isInCloseTime
end

function M:_delaySetCloseTime()
	self._isInCloseTime = false
end

function M:_handleTopMoneyItemJumpClick(e, itemGo, moneyCode, moneyShowType, passEvent)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)

	local topCurrencyGo = itemGo.transform.parent.gameObject
	local layoutGroup = topCurrencyGo:GetComponent(UIComponentType.HorizontalOrVerticalLayoutGroup)
	local anchoredPos = topCurrencyGo.transform.anchoredPosition
	local padding = layoutGroup.padding
	local width = goutil.getWidth(topCurrencyGo.transform)
	local heigh = goutil.getHeight(topCurrencyGo.transform)
	local isPassEvent = true

	if passEvent ~= nil then
		isPassEvent = passEvent
	end

	local itemData = ItemData.New({
		itemId = moneyCode
	})
	local data = ToolTipsUtil.createCenterTipsData(itemData, anchoredPos, padding, width, heigh, moneyShowType, isPassEvent)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_handleTopMoneyItemAddClick(e, itemGo, moneyCode, moneyShowType)
	local jumpCfgs = ConstConfig.instance:getJsonValueByKey("SpecialCurrencyJumpId") or {}

	if jumpCfgs[moneyCode] then
		local jumpId = jumpCfgs[moneyCode]

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)

		return
	end

	if moneyCode == CommEnum.CurrencyCodeEnum.TlCode then
		ToolTipsMgr.showHealthExchangeTips()
	elseif moneyCode == CommEnum.CurrencyCodeEnum.AirStudioChallengeNum then
		AirWorkShopController.instance:showRodeoChallengeNumExchangeTips()
	else
		printWarn(string.format("未定义Code[%s]处理", moneyCode))
	end
end

M.instance = M.New()

return M
