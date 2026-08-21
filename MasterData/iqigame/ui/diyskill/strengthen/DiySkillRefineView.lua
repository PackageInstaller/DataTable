-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillRefineView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local effectTipPanelClass = require("IQIGame/UI/DiySkill/Strengthen/DIYRefineTipPanel")
local MaterialItemCell = {
	IsEnough = false
}

function MaterialItemCell.New(view, clickEvent, parentView)
	local obj = Clone(MaterialItemCell)

	obj:__Init(view, clickEvent, parentView)

	return obj
end

function MaterialItemCell:__Init(view, clickEvent, parentView)
	self.gameObject = view
	self.onClickEvent = clickEvent
	self.parentView = parentView

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()
	self:InitDelegate()
	self:AddListeners()
end

function MaterialItemCell:InitComponent()
	self.itemCell = ItemCell.New(self.materialPrefab, false, true, true)

	LuaUtility.SetGameObjectShow(self.buttonReduce, false)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MaterialItemCell:InitDelegate()
	function self.DelegateOnClickSelectMaterialBtn()
		self:__OnItemClickHandler()
	end

	function self.delegateOnClickButtonReduce()
		self:OnClickButtonReduce()
	end
end

function MaterialItemCell:AddListeners()
	self.materialBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectMaterialBtn)
	self.buttonReduce:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonReduce)
end

function MaterialItemCell:RemoveListeners()
	self.materialBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectMaterialBtn)
	self.buttonReduce:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonReduce)
end

function MaterialItemCell:OnClickButtonReduce()
	self.parentView:OnMaterialClickReduce(self.itemId, self.itemCell.ItemCfgOrData.cid)
end

function MaterialItemCell:Show()
	self.gameObject:SetActive(true)
end

function MaterialItemCell:SetData(itemCid, needCount, itemData)
	if itemCid == nil then
		LuaUtility.SetGameObjectShow(self.materialPrefab, false)
		LuaUtility.SetGameObjectShow(self.buttonReduce, false)

		return
	end

	self.itemCell:SetItemByCid(itemCid, 0)

	self.itemId = itemData.id
	self.NeedCount = needCount
	self.ItemType = self.itemCell.ItemCfgOrData:GetCfg().ItemTypes

	local needSplit = self:__IsCellNeedSplit()

	if not needSplit then
		self.itemCell:ResetClickHandler()

		self.IsEnough = self.itemCell:SetCustomNum(needCount, itemData.num)
	else
		self.IsEnough = self.itemCell:SetCustomNum(needCount, itemData.num)
	end

	self.greyImg:SetActive(not self.IsEnough and self.ItemType == Constant.ItemType.Currency)

	if self.ItemType ~= Constant.ItemType.Currency then
		LuaUtility.SetGameObjectShow(self.buttonReduce, self.IsEnough)
		LuaUtility.SetGameObjectShow(self.materialPrefab, self.IsEnough)
	end

	return needSplit
end

function MaterialItemCell:Hide()
	self.gameObject:SetActive(false)
end

function MaterialItemCell:Dispose()
	self:RemoveListeners()
	self.itemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MaterialItemCell:__IsCellNeedSplit()
	if self.ItemType == Constant.ItemType.Item then
		return false
	end

	if self.ItemType == Constant.ItemType.Currency then
		return false
	end

	return true
end

function MaterialItemCell:__OnItemClickHandler(itemCell)
	if self.onClickEvent ~= nil then
		self.onClickEvent(self)
	end
end

local AttItem = {}

function AttItem.New(view)
	local obj = Clone(AttItem)

	obj:__Init(view)

	return obj
end

function AttItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function AttItem:Show(attrType, curValue, nextValue)
	self.gameObject:SetActive(true)

	local attrCfg = CfgAttributeTable[attrType]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrCfg.ImageUrl), self.attIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.attNameText, DiySkillStrengthenUIApi:GetAttrGrowUpTitle(attrType))

	local curShowValue = curValue

	if curShowValue == nil then
		curShowValue = 0
	end

	UGUIUtil.SetText(self.attNumText, curShowValue)

	if nextValue == nil then
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, false)
		LuaUtility.SetGameObjectShow(self.previewNumParent, false)
	elseif curShowValue < nextValue then
		LuaUtility.SetGameObjectShow(self.previewNumParent, true)
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, false)
		LuaUtility.SetText(self.previewNumText, nextValue)
	else
		LuaUtility.SetGameObjectShow(self.previewNumParent, false)
		LuaUtility.SetText(self.textPreviewNormal, nextValue)
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, true)
	end
end

function AttItem:Hide()
	self.gameObject:SetActive(false)
end

function AttItem:IsFree()
	return not self.gameObject.activeSelf
end

function AttItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillAttContent = {}

function SkillAttContent.New(view)
	local obj = Clone(SkillAttContent)

	obj:__Init(view)

	return obj
end

function SkillAttContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.attPrefab.gameObject:SetActive(false)

	self.itemPool = UIViewObjectPool.New(self.attPrefab, nil, function(_view)
		return AttItem.New(_view)
	end)
end

function SkillAttContent:SetData(skillCid, curLevelCfg, nextLevel)
	self.itemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local curPropertyTable = {}
	local curPropertyCount = 0

	ForArrayCustomStep(curLevelCfg.RefineAttribute, function(_index, _attrType)
		local value = curLevelCfg.RefineAttribute[_index + 1]

		curPropertyTable[_attrType] = value
		curPropertyCount = curPropertyCount + 1
	end, 2)

	local nextPropertyTable = {}
	local nextPropertyCount = 0

	if nextLevel > 0 then
		local nextLevelCfg = DiySkillModule.GetSkillRefineCfg(skillCid, nextLevel)

		ForArrayCustomStep(nextLevelCfg.RefineAttribute, function(_index, _attrType)
			local value = nextLevelCfg.RefineAttribute[_index + 1]

			nextPropertyTable[_attrType] = value
			nextPropertyCount = nextPropertyCount + 1
		end, 2)
	end

	if nextPropertyCount <= curPropertyCount then
		ForPairs(curPropertyTable, function(_attrType, _value)
			local nextValue = nextPropertyTable[_attrType]

			self:__ShowAttr(_attrType, _value, nextValue)
		end)
	else
		ForPairs(nextPropertyTable, function(_attrType, _value)
			local curValue = curPropertyTable[_attrType]

			self:__ShowAttr(_attrType, curValue, _value)
		end)
	end
end

function SkillAttContent:__ShowAttr(attrType, curValue, nextValue)
	local attrItem = self.itemPool:GetFree(function(_item)
		return _item:IsFree()
	end)

	attrItem:Show(attrType, curValue, nextValue)
end

function SkillAttContent:Show()
	self.gameObject:SetActive(true)
end

function SkillAttContent:Hide()
	self.gameObject:SetActive(false)
end

function SkillAttContent:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillRefineView = {
	MaterialItemIds = {},
	MaterialItemByCids = {},
	matItemList = {}
}

function DiySkillRefineView.New(view, itemClickEvent, matChangeEvent)
	local obj = Clone(DiySkillRefineView)

	obj:__Init(view, itemClickEvent, matChangeEvent)

	return obj
end

function DiySkillRefineView:__Init(view, itemClickEvent, matChangeEvent)
	self.gameObject = view
	self.itemClickEvent = itemClickEvent
	self.matChangeEvent = matChangeEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()
	self:InitDelegate()
	self.skillEffctNameText:SetActive(false)
	self.materialPrefab:SetActive(false)

	self.matCellPool = UIViewObjectPool.New(self.materialPrefab, nil, function(_view)
		return MaterialItemCell.New(_view, function(_cell)
			self:__OnItemClickHandler(_cell)
		end, self)
	end)

	for i = 1, 5 do
		local cell = self.matCellPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		cell:Show()
		table.insert(self.matItemList, cell)
	end

	function self.__onRefineBtnClickProxy()
		self:__OnRefineBtnClickEvent()
	end

	self:__SetStaticText()
	self:__AddListeners()
end

function DiySkillRefineView:InitComponent()
	self.refineTipPanel = effectTipPanelClass.New(self.effectTipPanel, self)
	self.attContent = SkillAttContent.New(self.SkillAttParent)
end

function DiySkillRefineView:InitDelegate()
	function self.toggleCurrentEffectClickDelegate(isOn)
		self:OnToggleCurrentEffectClick(isOn)
	end

	function self.delegateOnClickButtonAutoAdd()
		self:OnClickButtonAutoAdd()
	end

	function self.delegateOnClickButtonClear()
		self:OnClickButtonClear()
	end
end

function DiySkillRefineView:__SetStaticText()
	UGUIUtil.SetText(self.refineText, DiySkillStrengthenUIApi:GetSkillRefineName())
	UGUIUtil.SetText(self.presentTitle, DiySkillStrengthenUIApi:GetRefinePresentTitle())
	UGUIUtil.SetText(self.nextTitle, DiySkillStrengthenUIApi:GetRefineNextTitle())
	UGUIUtil.SetText(self.RefineBtnText, DiySkillStrengthenUIApi:GetRefineButtonText())
end

function DiySkillRefineView:__AddListeners()
	self.buttonAutoAdd:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonAutoAdd)
	self.buttonClear:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClear)
	self.RefineBtn:GetComponent("Button").onClick:AddListener(self.__onRefineBtnClickProxy)
	self.toggleCurrentEffect:GetComponent("Toggle").onValueChanged:AddListener(self.toggleCurrentEffectClickDelegate)
end

function DiySkillRefineView:__RemoveListeners()
	self.buttonAutoAdd:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonAutoAdd)
	self.buttonClear:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClear)
	self.RefineBtn:GetComponent("Button").onClick:RemoveListener(self.__onRefineBtnClickProxy)
	self.toggleCurrentEffect:GetComponent("Toggle").onValueChanged:RemoveListener(self.toggleCurrentEffectClickDelegate)
end

function DiySkillRefineView:Dispose()
	self:__RemoveListeners()
	self.matCellPool:Dispose(function(_item)
		_item:Dispose()
	end)
	self.attContent:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillRefineView:SetData(skillData)
	self.curSkillData = skillData

	local curLevelCfg = DiySkillModule.GetSkillRefineCfg(self.curSkillData.skillCid, self.curSkillData.purifyLv)

	self.curRefineCfg = curLevelCfg

	LuaUtility.SetText(self.refineNumText, DiySkillStrengthenUIApi:GetSkillRefineNumber(self.curSkillData.purifyLv))
	LuaUtility.SetText(self.textCurrentLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(self.curSkillData.purifyLv))

	local curRefineImg = DiySkillStrengthenUIApi:GetSkillRefineLevelImg(skillData.purifyLv)

	AssetUtil.LoadImage(self, curRefineImg, self.presentRefineImg:GetComponent("Image"))
	LuaUtility.SetText(self.presentEffctText, curLevelCfg.SkillTips)

	local maxLevel = DiySkillModule.GetSkillMaxRefineLevel(self.curSkillData.skillCid)
	local nextLevel = self.curSkillData.purifyLv + 1

	LuaUtility.SetGameObjectShow(self.textNextLevel, nextLevel <= maxLevel)

	if maxLevel < nextLevel then
		self:__RefreshMaxShow(curLevelCfg)
		LuaUtility.SetText(self.textTag, DiySkillStrengthenUIApi:GetTextMax())
	else
		self:__RefreshRefineShow(curLevelCfg, nextLevel)
		LuaUtility.SetText(self.textTag, DiySkillStrengthenUIApi:GetTextNext())
		LuaUtility.SetText(self.textNextLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(nextLevel))
	end

	self:SetButtonAutoAddShow(true)
	self.attContent:Show()
end

function DiySkillRefineView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	EventDispatcher.Dispatch(EventID.PlayDiySkillStrengthInAnimationEvent, nil, nil, true)
end

function DiySkillRefineView:Hide()
	self.curSelectMatCell = nil
	self.MaterialItemIds = {}
	self.MaterialItemByCids = {}

	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DiySkillRefineView:OnMaterialSelect(_itemData, _num)
	if self.MaterialItemIds[_itemData.id] ~= nil or table.len(self.MaterialItemIds) >= self.curRefineCfg.RefineNeedItemNum then
		return
	end

	for i = 1, self.curRefineCfg.RefineNeedItemNum do
		if self.MaterialItemByCids[i] == nil or self.MaterialItemByCids[i] == -1 then
			self.MaterialItemByCids[i] = _itemData

			break
		end
	end

	self.MaterialItemIds[_itemData.id] = _num

	self:SetButtonAutoAddShow(false)

	for i = 1, self.curRefineCfg.RefineNeedItemNum do
		self.matItemList[i]:Show()

		if self.MaterialItemByCids[i] ~= nil and self.MaterialItemByCids[i] ~= -1 then
			self.matItemList[i]:SetData(self.MaterialItemByCids[i].cid, 1, self.MaterialItemByCids[i])
		else
			self.matItemList[i]:SetData(nil)
		end
	end
end

function DiySkillRefineView:OnClearSelectMaterial(_id)
	self:OnMaterialClickReduce(_id)
end

function DiySkillRefineView:__RefreshMaxShow(curLevelCfg)
	self.RefineBtn:SetActive(false)
	self.RefineItemParent:SetActive(false)
	self.RefineMaxState:SetActive(true)
	LuaUtility.SetText(self.nextEffctText, curLevelCfg.SkillTips)
	LuaUtility.SetGameObjectShow(self.toggleCurrentEffect, false)
	LuaUtility.SetGameObjectShow(self.imageNext, false)
	self.attContent:SetData(self.curSkillData.skillCid, curLevelCfg, 0)
end

function DiySkillRefineView:__RefreshRefineShow(curLevelCfg, nextLevel)
	self.nextEffctParent:SetActive(true)
	self.RefineBtn:SetActive(true)
	self.RefineItemParent:SetActive(true)
	self.RefineMaxState:SetActive(false)
	LuaUtility.SetGameObjectShow(self.imageNext, true)

	local nextLevelCfg = DiySkillModule.GetSkillRefineCfg(self.curSkillData.skillCid, nextLevel)
	local nextRefineImg = DiySkillStrengthenUIApi:GetSkillRefineLevelImg(nextLevel)

	AssetUtil.LoadImage(self, nextRefineImg, self.nextRefineImg:GetComponent("Image"))
	UGUIUtil.SetText(self.nextEffctText, nextLevelCfg.SkillTips)
	LuaUtility.SetGameObjectShow(self.toggleCurrentEffect, true)
	self.attContent:SetData(self.curSkillData.skillCid, curLevelCfg, nextLevel)

	for i = 1, #self.matItemList do
		if i > curLevelCfg.RefineNeedItemNum then
			self.matItemList[i]:Hide()
		else
			self.matItemList[i]:Show()

			if self.MaterialItemByCids[i] ~= nil and self.MaterialItemByCids[i] ~= -1 then
				self.matItemList[i]:SetData(self.MaterialItemByCids[i].cid, 1, self.MaterialItemByCids[i])
			else
				self.matItemList[i]:SetData(nil)
			end
		end
	end
end

function DiySkillRefineView:__OnItemClickHandler(cell)
	self.curSelectCell = cell

	local cid = self.curSkillData.skillCid

	if self.itemClickEvent ~= nil then
		self.itemClickEvent(cid, self.curRefineCfg.RefineNeedItem)
	end
end

function DiySkillRefineView:__OnRefineBtnClickEvent()
	local matItems = {}

	for k, v in pairs(self.MaterialItemByCids) do
		if v ~= nil and v ~= -1 then
			matItems[v.id] = 1
		end
	end

	if table.len(matItems) <= 0 or table.len(matItems) < self.curRefineCfg.RefineNeedItemNum then
		NoticeModule.ShowNotice(45012)

		return
	end

	for k, v in pairs(matItems) do
		local itemdata = WarehouseModule.FindItem(k)

		if itemdata ~= nil and itemdata.skillData ~= nil and itemdata.skillData.purifyLv > 1 then
			NoticeModule.ShowNotice(20037, function()
				DiySkillModule.PurifySkill(self.curSkillData.id, matItems)
			end)

			return
		end
	end

	DiySkillModule.PurifySkill(self.curSkillData.id, matItems)
end

function DiySkillRefineView:__CheckMat()
	local matItems = {}
	local isEnough = true

	self.matCellPool:ForItems(function(_item)
		if not _item.IsEnough then
			isEnough = false

			return true
		else
			if _item.ItemType == Constant.ItemType.Currency then
				return
			end

			if _item.ItemType == Constant.ItemType.Item then
				local itemData, _ = WarehouseModule.FindItemForCid(_item.itemCell.ItemCfgOrData.cid)

				matItems[itemData.id] = _item.itemCell.NeedCount
			else
				matItems[_item.itemId] = 1
			end
		end
	end)

	return isEnough, matItems
end

function DiySkillRefineView:OnToggleCurrentEffectClick(isOn)
	if isOn then
		self.refineTipPanel:Refresh(self.curSkillData)
		self.refineTipPanel:Show()

		local purifyLv = self.curSkillData.purifyLv + 1

		LuaUtility.SetText(self.textCurrentLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(purifyLv))
		LuaUtility.SetGameObjectShow(self.imageNext, false)
		LuaUtility.SetGameObjectShow(self.textNextLevel, false)
	else
		self.refineTipPanel:Hide()
		LuaUtility.SetText(self.textCurrentLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(self.curSkillData.purifyLv))
		LuaUtility.SetGameObjectShow(self.imageNext, true)
		LuaUtility.SetGameObjectShow(self.textNextLevel, true)
	end
end

function DiySkillRefineView:OnClickButtonAutoAdd()
	local allItems = DiySkillModule.GetAllDiySkillRefineMatWithWarehouseByItemID(self.curSkillData.id, self.curRefineCfg.RefineNeedItem, true)

	if #allItems <= 0 then
		NoticeModule.ShowNotice(20038)

		return
	end

	for _, v in pairs(allItems) do
		if table.len(self.MaterialItemIds) >= self.curRefineCfg.RefineNeedItemNum then
			break
		end

		if v.skillData == nil or v.skillData and not v.skillData.lock then
			self:OnMaterialSelect(v, 1)
			LuaUtility.SetText(self.textTag, DiySkillStrengthenUIApi:GetRefineNext())
			self:SetButtonAutoAddShow(false)
		end
	end

	if self.matChangeEvent ~= nil then
		self.matChangeEvent()
	end
end

function DiySkillRefineView:OnClickButtonClear()
	self.curSelectMatCell = nil
	self.MaterialItemIds = {}
	self.MaterialItemByCids = {}

	self:SetData(self.curSkillData)
	self:SetButtonAutoAddShow(true)

	if self.matChangeEvent ~= nil then
		self.matChangeEvent()
	end
end

function DiySkillRefineView:SetButtonAutoAddShow(show)
	LuaUtility.SetGameObjectShow(self.buttonAutoAdd, show)
	LuaUtility.SetGameObjectShow(self.buttonClear, not show)
end

function DiySkillRefineView:OnMaterialClickReduce(itemID, cid)
	for i, v in pairs(self.MaterialItemIds) do
		if i == itemID then
			self.MaterialItemIds[i] = nil

			break
		end
	end

	for k, v in pairs(self.MaterialItemByCids) do
		if v ~= -1 and v.id == itemID then
			self.MaterialItemByCids[k] = -1

			break
		end
	end

	if self.matChangeEvent ~= nil then
		self.matChangeEvent()
	end

	self:SetData(self.curSkillData)
end

function DiySkillRefineView:OnResetMaterial()
	self.MaterialItemByCids = {}
	self.MaterialItemIds = {}
end

return DiySkillRefineView
