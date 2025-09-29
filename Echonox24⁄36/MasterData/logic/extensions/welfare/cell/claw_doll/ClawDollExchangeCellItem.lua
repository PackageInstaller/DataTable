-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/claw_doll/ClawDollExchangeCellItem.lua

module("logic.extensions.welfare.cell.claw_doll.ClawDollExchangeCellItem", package.seeall)

local M = class("ClawDollExchangeCellItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:getMainGo()
	return self.mainGO
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
	self._txtDesc = goutil.findChildTextComponent(mainGO, "txtDesc")
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGet"))
	self._btnNotEnough = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnNotEnough"))
	self._txtDone = goutil.findChild(mainGO, "txtDone").gameObject
	self._txtLimit = goutil.findChildTextComponent(mainGO, "txtLimit")
	self.goitem_1 = goutil.findChild(mainGO, "itemList/item1").gameObject
	self.goitem_2 = goutil.findChild(mainGO, "itemList/item2").gameObject
	self.goitem_3 = goutil.findChild(mainGO, "itemList/item3").gameObject
	self._item_1 = Astral.LuaComponentContainer.Add(self.goitem_1, ItemCell)
	self._item_2 = Astral.LuaComponentContainer.Add(self.goitem_2, ItemCell)
	self._item_3 = Astral.LuaComponentContainer.Add(self.goitem_3, ItemCell)

	self._item_1:Awake()
	self._item_2:Awake()
	self._item_3:Awake()
	self._item_1:setShowSelectedEffect(false)
	self._item_2:setShowSelectedEffect(false)
	self._item_3:setShowSelectedEffect(false)
	self:setExchangeItemFalse()

	local goItem = goutil.findChild(mainGO, "cell/backpack_item").gameObject

	goutil.setActive(goItem, true)

	self._itemCell = Astral.LuaComponentContainer.Add(goItem, ItemCell)

	self._itemCell:Awake()
	self._itemCell:setShowSelectedEffect(false)

	self._canExchange = 0
end

function M:bindEvents()
	self._btnReceive:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnReceive:RemoveClickListener()
end

function M:_onClickGet()
	if self._canExchange >= self._length and self._isFinish == 0 then
		ClawDollAgent.instance:sendRedeemPrizeRequest({
			cfgId = self._cfgId,
			id = self._id
		})
	end
end

function M:updateData(exchangeMo)
	self._canExchange = 0
	self._cfgId = exchangeMo:getCfgId()
	self._id = exchangeMo:getId()
	self._isFinish = exchangeMo:getIsFinish()

	self:setExchangeItemFalse()

	local tempExchangeList = exchangeMo:getExchangeList()

	self._length = #tempExchangeList

	for k, v in ipairs(tempExchangeList) do
		if k == 1 then
			self:setExchangeItem(v, self._item_1, self.goitem_1)
		elseif k == 2 then
			self:setExchangeItem(v, self._item_2, self.goitem_2)
		elseif k == 3 then
			self:setExchangeItem(v, self._item_3, self.goitem_3)
		end
	end

	local rewardData = exchangeMo:getRewardItemData()

	self._itemCell:updateData(rewardData)

	self._canvasGroup.alpha = 1

	if self._isFinish == 1 then
		self._canvasGroup.alpha = 0.5

		goutil.setActive(self._txtDone, true)
		goutil.setActive(self._btnNotEnough.gameObject, false)
		goutil.setActive(self._btnReceive.gameObject, false)
	elseif self._canExchange < self._length then
		goutil.setActive(self._txtDone, false)
		goutil.setActive(self._btnNotEnough.gameObject, true)
		goutil.setActive(self._btnReceive.gameObject, false)
	else
		goutil.setActive(self._txtDone, false)
		goutil.setActive(self._btnNotEnough.gameObject, false)
		goutil.setActive(self._btnReceive.gameObject, true)
	end

	self._txtDesc.text = exchangeMo:getName()
	self._txtLimit.text = string.format("限购%s/%s", exchangeMo:getMaxCnt() - exchangeMo:getCount(), exchangeMo:getMaxCnt())
end

function M:setExchangeItem(info, item, go)
	local tempData = ItemUtil.createItemData({
		itemId = info.id
	})
	local curNum = ItemModel.instance:getItemCountByItemId(info.id)
	local color = curNum < info.num and "FF5C63" or "E4E4E4"

	if curNum >= info.num then
		self._canExchange = self._canExchange + 1
	end

	item:updateData(tempData)
	item:getComponent("num"):setCostTextActive(true)
	item:getComponent("num"):setCostText(string.format("<color=#%s>%s</color>/%s", color, TextFormatter.formatNumber(curNum), info.num))
	item:getComponent("num"):setCountTextActive(false)
	goutil.setActive(go, true)
end

function M:setExchangeItemFalse()
	goutil.setActive(self.goitem_1, false)
	goutil.setActive(self.goitem_2, false)
	goutil.setActive(self.goitem_3, false)
end

return M
