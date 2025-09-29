-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/furniture/FurnitureProductView.lua

module("logic.extensions.house.view.furniture.FurnitureProductView", package.seeall)

local M = class("FurnitureProductView", ViewComponent)
local kMaxCostNum = 3

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnEnsure = self:getBtn("furniture_fabricate_expend_tips_-1787719458")
	self._btnClose = self:getBtn("furniture_fabricate_expend_tips_2015194716")
	self._imgFurnQuality = self:getImage("furniture_fabricate_expend_tips_690023849")
	self._imgFurnIcon = self:getImage("furniture_fabricate_expend_tips_1651515181")
	self._imgFurnIconS = self:getImage("furniture_fabricate_expend_tips_1664235904")
	self._txtFurnName = self:getText("furniture_fabricate_expend_tips_-1455410121")
	self._txtFurnTypeName = self:getText("furniture_fabricate_expend_tips_1071586105")
	self._txtFurnSpecialAtmoName = self:getText("furniture_fabricate_expend_tips_829820053")
	self._txtFurnSpecialAtmoValue = self:getText("furniture_fabricate_expend_tips_664021176")
	self._txtFurnNormalAtmoValue = self:getText("furniture_fabricate_expend_tips_157580741")
	self._btnMinus = self:getBtn("furniture_fabricate_expend_tips_-488457803")
	self._btnAdd = self:getBtn("furniture_fabricate_expend_tips_1753118799")
	self._btnMax = self:getBtn("furniture_fabricate_expend_tips_20736996")
	self._inputNum = self:getInput("furniture_fabricate_expend_tips_-2006062600")
	self._goCostRoot = self:getGo("furniture_fabricate_expend_tips_1189557751")
	self._arrayCostGO = {}

	for i = 1, kMaxCostNum do
		local costGO = goutil.findChild(self._goCostRoot, string.format("cost%s", i))

		table.insert(self._arrayCostGO, costGO)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnEnsure:AddClickListener(self._onClickBtnEnsure, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnMinus:AddClickListener(self._onClickBtnMinus, self)
	self._btnAdd:AddClickListener(self._onClickBtnAdd, self)
	self._btnMax:AddClickListener(self._onClickBtnMax, self)
	self._inputNum:AddOnEndEdit(self._onInputEndEdit, self)
end

function M:unbindEvents()
	self._btnEnsure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._inputNum:RemoveOnEndEdit()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
	end
end

function M:onEnter()
	local info = self:getFirstParam()

	self._paperId = info.paperId
	self._paperCO = BackpackConfig.instance:getItemInfoByItemId(self._paperId)
	self._productCount = 1

	self:initFurniture()
	self:initCurrency()
	self:refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:initFurniture()
	local furnitureId = self._paperCO.furniture
	local itemData = FurnitureData.New({
		itemId = furnitureId
	})
	local qualityPath = GameUrl.getEquipQualityUrl(itemData:getQuality())

	IconLoader.setSprite(self._imgFurnQuality, IconType.DynSpriteAtlas_CharacterSystem, qualityPath)
	IconLoader.setSprite(self._imgFurnIcon, IconType.Furniture, itemData:getIcon())
	IconLoader.setSprite(self._imgFurnIconS, IconType.Furniture, itemData:getIcon())

	self._txtFurnName.text = itemData:getName()

	local subType = itemData:getSubType()
	local firstIndex = math.floor(subType / 100)
	local secondIndex = subType % 100
	local typeNameStr = HouseEnum.FurnitureSubTypeName[firstIndex][secondIndex] or lang("tip_undefined_type")

	self._txtFurnTypeName.text = typeNameStr

	local spAtmosVal, spAtmosTyp = itemData:getCfgSpAtmosValAndTyp()

	self._txtFurnSpecialAtmoName.text = spAtmosVal > 0 and lang(HouseMainEnum.AtmosphereName[spAtmosTyp]) or ""
	self._txtFurnSpecialAtmoValue.text = spAtmosVal > 0 and tostring(spAtmosVal) or ""
	self._txtFurnNormalAtmoValue.text = itemData:getAtmosphere()
end

function M:initCurrency()
	local costList = self._paperCO.cost or {}

	self:setTopCurrency(costList)
end

function M:refreshView()
	self._inputNum:SetText(tostring(self._productCount))

	local costList = self._paperCO.cost or {}

	for idx, costGO in ipairs(self._arrayCostGO) do
		local costInfo = costList[idx]

		if costInfo then
			goutil.setActive(costGO, true)

			local imgIcon = goutil.findChildImageComponent(costGO, "imgIcon")
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(costInfo.id)

			IconLoader.setSprite(imgIcon, IconType.ItemIcon, itemCo.icon)

			local txtNum = goutil.findChildTextComponent(costGO, "txtValue")
			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)
			local costCount = self._productCount * costInfo.num
			local colorStr = ownCount < costCount and "#FF0000" or "#2F2F2F"

			txtNum.text = string.format("<color=%s>%s</color>", colorStr, costCount)
		else
			goutil.setActive(costGO, false)
		end
	end
end

function M:setTopCurrency(costItemLst)
	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, CommEnum.MoneyShowType.FurniturePartAndMoneyShowType)
end

function M:_adjustProductCount(setMax)
	local maxCount = 99999999
	local costList = self._paperCO.cost or {}

	for _, costInfo in ipairs(costList) do
		local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)
		local count = math.floor(ownCount / costInfo.num)

		if count < maxCount then
			maxCount = count
		end
	end

	maxCount = math.max(1, maxCount)

	if setMax then
		self._productCount = maxCount
	end

	self._productCount = math.max(1, math.min(self._productCount, maxCount))
end

function M:_canProduct(showFloatWord)
	local canProduct = true
	local itemList = ItemModel.instance:getItemsByItemId(self._paperId)
	local itemData = itemList[1]
	local itemUUId = itemData and checknumber(itemData:getUuid()) or 0
	local paperCount = ItemModel.instance:getItemCountByItemId(self._paperId)

	if itemUUId <= 0 or paperCount <= 0 then
		canProduct = false

		if showFloatWord then
			FloatWordMgr.instance:show(lang("tip_product_furniture_lang_1"))
		end
	else
		local costList = self._paperCO.cost or {}

		for _, costInfo in ipairs(costList) do
			local needNum = self._productCount * costInfo.num
			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)

			if ownCount < needNum then
				canProduct = false

				if showFloatWord then
					FloatWordMgr.instance:show(lang("tip_prop_not_enough_1"))
				end

				break
			end
		end
	end

	return canProduct, itemUUId
end

function M:_onClickBtnMinus()
	self._productCount = self._productCount - 1

	self:_adjustProductCount()
	self:refreshView()
end

function M:_onClickBtnAdd()
	self._productCount = self._productCount + 1

	self:_adjustProductCount()
	self:refreshView()
end

function M:_onClickBtnMax()
	self:_adjustProductCount(true)
	self:refreshView()
end

function M:_onClickBtnEnsure()
	local canProduct, itemUUId = self:_canProduct(true)

	if canProduct then
		HouseAgent.instance:sendMakeFurnitureRequest(itemUUId, self._productCount)
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onInputEndEdit()
	local numStr = self._inputNum:GetText()

	self._productCount = checknumber(self._inputNum:GetText())

	self:_adjustProductCount()
	self:refreshView()
end

function M:_handleItemCostEvent()
	self:_adjustProductCount()
	self:refreshView()
end

return M
