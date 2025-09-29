-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipLvUpDetailInfoComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipLvUpDetailInfoComponent", package.seeall)

local M = class("EquipLvUpDetailInfoComponent", EquipDetailInfoComponent)
local lvUpMod = {
	ten = 10,
	one = 1
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	M.super._buildUI(self)

	self._texts = {}
	self._txtItemCount1 = self._registry:getText("backpack_equip_detail_tips_-1820698156")
	self._txtItemCount10 = self._registry:getText("backpack_equip_detail_tips_-1974991900")
	self._txtCurrencyCount1 = self._registry:getText("backpack_equip_detail_tips_-1842459544")
	self._txtCurrencyCount10 = self._registry:getText("backpack_equip_detail_tips_-2099634218")
	self._icon1 = self._registry:getImage("backpack_equip_detail_tips_-799681958")
	self._icon2 = self._registry:getImage("backpack_equip_detail_tips_-1521445395")
	self._icon3 = self._registry:getImage("backpack_equip_detail_tips_-1359398498")
	self._icon4 = self._registry:getImage("backpack_equip_detail_tips_-344759273")
	self._mask1 = self._registry:getGo("backpack_equip_detail_tips_-1358674903")
	self._mask2 = self._registry:getGo("backpack_equip_detail_tips_-1997466882")
	self._goTenInfo = self._registry:getGo("backpack_equip_detail_tips_-181472684")
end

function M:setTipsPos(pos1, pos2)
	self._tipsGo = {}

	table.insert(self._tipsGo, pos1)
	table.insert(self._tipsGo, pos2)
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnLvUp:AddClickListener(self._onClickLvUpOne, self)
	self._btnLvUpTen:AddClickListener(self._onClickLvUpTen, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshLvUp, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnLvUp:RemoveClickListener()
	self._btnLvUpTen:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshLvUp, self)
end

function M:_onClickLvUpOne()
	if self._isLvUpOnceItem1Enough and self._isLvUpOnceItem2Enough then
		local itemNeed = EquipIntensifyModel.instance:getLvConsumeInfo(lvUpMod.one)
		local cost = {}

		cost[self._itemIdConsume] = itemNeed

		EquipmentAgent.instance:sendEquipStrengthenRequest(self._equipId, cost)
	else
		FloatWordMgr.instance:show(lang("tip_equip_lv_item_less"))
		self:_showItemTips(not self._isLvUpOnceItem2Enough, not self._isLvUpOnceItem1Enough)
	end
end

function M:_onClickLvUpTen()
	if self._isLessTen then
		FloatWordMgr.instance:show(lang("tip_equip_lv_time_less"))

		return
	end

	if self._isLvUpTenItem1Enough and self._isLvUpTenItem2Enough then
		local itemNeed = EquipIntensifyModel.instance:getLvConsumeInfo(lvUpMod.ten)
		local cost = {}

		cost[self._itemIdConsume] = itemNeed

		EquipmentAgent.instance:sendEquipStrengthenRequest(self._equipId, cost)
	else
		FloatWordMgr.instance:show(lang("tip_equip_lv_item_less"))
		self:_showItemTips(not self._isLvUpTenItem2Enough, not self._isLvUpTenItem1Enough)
	end
end

function M:setEquipData(mo)
	self._equipMo = mo
	self._maxLv = self._equipMo:getMaxLevel()
	self._equipId = self._equipMo:getUuid()

	self:_setLvConsumeIcon()
	M.super.setEquipData(self, mo)
end

function M:_setLvConsumeIcon()
	self._itemIdConsume = EquipIntensifyModel.instance:getIntensityItemId()
	self._currencyId = GameEnum.CurrencyCodeEnum.LzbCode

	IconLoader.setSprite(self._icon3, IconType.Skinlib, CommEnum.CurrencyItemSrc[self._currencyId])
	IconLoader.setSprite(self._icon4, IconType.Skinlib, CommEnum.CurrencyItemSrc[self._currencyId])
end

function M:refreshView()
	M.super.refreshView(self)
	self:_refreshLvUp()
end

function M:_refreshLvUp()
	local lv = self._equipMo:getLevel()

	self._isMax = lv >= self._maxLv

	self:_setIsMaxLv(self._isMax)

	if self._isMax then
		return
	end

	local itemHas = ItemModel.instance:getItemCountByItemId(self._itemIdConsume)
	local goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	local itemNeed, goldNeed = EquipIntensifyModel.instance:getLvConsumeInfo(lvUpMod.one)

	self:setText(self._txtItemCount1, itemNeed, itemHas)
	self:setText(self._txtCurrencyCount1, goldNeed, goldHas)

	self._isLvUpOnceItem1Enough = itemNeed <= itemHas
	self._isLvUpOnceItem2Enough = goldNeed <= goldHas

	goutil.setActive(self._mask1, not self._isLvUpOnceItem1Enough or not self._isLvUpOnceItem2Enough)

	self._isLessTen = self._maxLv - lv < lvUpMod.ten

	if self._isLessTen then
		goutil.setActive(self._mask2, true)
		goutil.setActive(self._goTenInfo, false)
	else
		local itemNeed, goldNeed = EquipIntensifyModel.instance:getLvConsumeInfo(lvUpMod.ten)

		self:setText(self._txtItemCount10, itemNeed, itemHas)
		self:setText(self._txtCurrencyCount10, goldNeed, goldHas)

		self._isLvUpTenItem1Enough = itemNeed <= itemHas
		self._isLvUpTenItem2Enough = goldNeed <= goldHas

		goutil.setActive(self._mask2, not self._isLvUpTenItem1Enough or not self._isLvUpTenItem2Enough)
		goutil.setActive(self._goTenInfo, true)
	end
end

function M:setText(txt, num, has)
	if has < num then
		txt.text = string.format("<color=#FF5C63>%d</color>", num)
	else
		txt.text = string.format("<color=#E4E4E4>%d</color>", num)
	end
end

function M:_setIsMaxLv(isMax)
	goutil.setActive(self._btnLvUp.gameObject, not isMax)
	goutil.setActive(self._btnLvUpTen.gameObject, not isMax)
	goutil.setActive(self._lvMaxGo, isMax)
end

function M:_showItemTips(showItem1, showItem2)
	local index = 1
	local viewName

	if showItem1 then
		local data = ToolTipsUtil.createItemTipsData(ItemData.New({
			count = 0,
			itemId = self._currencyId
		}), self._tipsGo[index])

		ToolTipsMgr.showTips(data.viewName, data)

		index = index + 1
		viewName = ViewName.ToolTipsSimple2View
	end

	if showItem2 then
		local data = ToolTipsUtil.createItemTipsData(ItemData.New({
			count = 0,
			itemId = self._itemIdConsume
		}), self._tipsGo[index])

		ToolTipsMgr.showTips(viewName or data.viewName, data)
	end
end

function M:_refreshDiscard()
	local isDiscard = self._equipMo:getIsDiscard()

	goutil.setActive(self._discardRootGo, isDiscard)
end

function M:playeLvUpEffect()
	if not self._lvUpAni then
		self._lvUpAni = self._normalAttributeRoot:GetComponent(ComponentType.Animation)
	end

	self._lvUpAni:Stop()

	local lv = self._equipMo:getLevel()

	if lv < 10 then
		self._lvUpAni:Play("equip_level_up_1")
	else
		AnimationUtils.ResetAnimation(self._lvUpAni, "equip_level_up_1")
		self._lvUpAni:Play("equip_level_up")
	end
end

return M
