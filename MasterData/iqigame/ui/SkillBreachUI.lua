-- chunkname: @IQIGame\\UI\\SkillBreachUI.lua

local SkillBreachUI = Base:Extend("SkillBreachUI", "IQIGame.Onigao.UI.SkillBreachUI", {
	IsMaxSelectCount = false,
	SelectMaterialExp = 0,
	BreachNeedMoney = 0,
	SkillItemList = {},
	SelectItems = {},
	CurSelectItems = {}
})
local BreachMaterialItem = require("IQIGame.UI.RoleDevelopment.ItemCell.BreachMaterialsItem")
local DropDownUI = require("IQIGame.UI.Common.DropDownUI")
local BreachSelectItemCell = require("IQIGame.UI.RoleDevelopment.ItemCell.BreachSelectItemCell")

function SkillBreachUI:OnInit()
	function self.DelegateCloseBtn()
		UIModule.Close(Constant.UIControllerName.SkillBreachUI)
	end

	function self.DelegateBreachBtn()
		self:BreachBtnClick()
	end

	function self.DelegateBreachSucess()
		self:BreachSucessCallback()
	end

	function self.DelegateOnDiySkillSelectMaterialItemEvent()
		self:OnDiySkillSelectMaterialItemEvent()
	end

	function self.DelegateOnCloseSkillBagBtnClick()
		self:OnCloseSkillBagBtnClick()
	end

	self.wrapContent = self.SkillItemsScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)
	self.breachStarCom = self.BreachStar:GetComponent("SimpleStarComponent")
	self.presentStarCom = self.PresentStar:GetComponent("SimpleStarComponent")
	self.nextStarCom = self.NextStar:GetComponent("SimpleStarComponent")
	self.ApStarCom = self.APStar:GetComponent("SimpleStarComponent")
	self.skillBagTween = self.SkillBag:GetComponent("TweenPosition")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self:InigStaticText()
end

function SkillBreachUI:GetPreloadAssetPaths()
	return nil
end

function SkillBreachUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillBreachUI:IsManualShowOnOpen(userData)
	return false
end

function SkillBreachUI:GetBGM(userData)
	return nil
end

function SkillBreachUI:OnOpen(skillId)
	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())
	self:SetShowInfo(skillId)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.SkillBreachUI)
	LuaUtility.SetGameObjectShow(self.CloseSkillBagBtn, false)
end

function SkillBreachUI:OnClose(userData)
	return
end

function SkillBreachUI:OnAddListeners()
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateBreachBtn)
	self.CloseBtnForMask:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.CloseSkillBagBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseSkillBagBtnClick)
	EventDispatcher.AddEventListener(EventID.RoleSkillBreachSucess, self.DelegateBreachSucess)
	EventDispatcher.AddEventListener(EventID.DiySkillSelectMaterialItemEvent, self.DelegateOnDiySkillSelectMaterialItemEvent)
end

function SkillBreachUI:OnRemoveListeners()
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBreachBtn)
	self.CloseBtnForMask:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.CloseSkillBagBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseSkillBagBtnClick)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillBreachSucess, self.DelegateBreachSucess)
	EventDispatcher.RemoveEventListener(EventID.DiySkillSelectMaterialItemEvent, self.DelegateOnDiySkillSelectMaterialItemEvent)
end

function SkillBreachUI:OnPause()
	return
end

function SkillBreachUI:OnResume()
	return
end

function SkillBreachUI:OnCover()
	return
end

function SkillBreachUI:OnReveal()
	return
end

function SkillBreachUI:OnRefocus(userData)
	return
end

function SkillBreachUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillBreachUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillBreachUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillBreachUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillBreachUI:OnDestroy()
	self.moneyCell:Dispose()
	self.consumeGoldCell:Dispose()
	self.commonReturnBtn:Dispose()

	for k, v in pairs(self.SkillItemList) do
		v:Dispose()
	end

	for k, v in pairs(self.SelectItems) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function SkillBreachUI:InigStaticText()
	UGUIUtil.SetText(self.LevelTitle, RoleDevelopmentApi:GetBreachLevelTitle())
	UGUIUtil.SetText(self.StrengthTipsText, RoleDevelopmentApi:GetIsStrengthTitle())
	UGUIUtil.SetText(self.BreachBtnText, RoleDevelopmentApi:GetBreachBtnTitle())
	UGUIUtil.SetText(self.CDTitle, RoleDevelopmentApi:GetCDTitle())
	UGUIUtil.SetText(self.RangeTitle, RoleDevelopmentApi:GetRangeTitle())
	UGUIUtil.SetText(self.CostTitle, RoleDevelopmentApi:GetCostTitle())
	UGUIUtil.SetText(self.APTitle, RoleDevelopmentApi:GetAPTitle())
	UGUIUtil.SetText(self.ElementTitle, RoleDevelopmentApi:GetElementTitle())
	UGUIUtil.SetText(self.MaxBtnText, RoleDevelopmentApi:GetMaxText())
end

function SkillBreachUI:SetShowInfo(skillId)
	self.ItemData = WarehouseModule.FindItem(skillId)
	self.SkillData = self.ItemData.skillData
	self.BreachNeedMoney = 0
	self.BreachNeedMaterial = {}

	local isMaxStrength = self.SkillData:IsMaxBreachLv()

	if not isMaxStrength then
		self.BreachNeedMoney = self.SkillData:GetRankCfg().StrengCost[2]
	end

	self.consumeGoldCell:SetData(self.BreachNeedMoney)

	self.skillRangeID = self.SkillData:GetCfg().SkillRangeID
	RoleDevelopmentModule.SelectBreachMaterialIsMax = false

	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[self.SkillData.itemCid].BigIcon), self.DIYImg)
	LuaUtility.SetGameObjectShow(self.CDNormalState, self.SkillData.CD > 0)
	LuaUtility.SetGameObjectShow(self.CDNoneState, not (self.SkillData.CD > 0))
	LuaUtility.SetGameObjectShow(self.RangeNormalState, self.skillRangeID ~= 0)
	LuaUtility.SetGameObjectShow(self.RangeNoneState, self.skillRangeID == 0)
	LuaUtility.SetGameObjectShow(self.CostNormalState, self.SkillData.Cost > 0)
	LuaUtility.SetGameObjectShow(self.CostNoneState, not (self.SkillData.Cost > 0))
	LuaUtility.SetGameObjectShow(self.APNormalState, self.SkillData:GetCostEnergy() > 0)
	LuaUtility.SetGameObjectShow(self.APNoneState, not (self.SkillData:GetCostEnergy() > 0))
	LuaUtility.SetGameObjectShow(self.ElementNormalState, CfgSkillDetailTable[self.SkillData.skillCid].Element > 0)
	LuaUtility.SetGameObjectShow(self.ElementNoneState, not (CfgSkillDetailTable[self.SkillData.skillCid].Element > 0))
	UGUIUtil.SetText(self.SkillName, self.SkillData:GetCfg().Name)
	UGUIUtil.SetText(self.PresentLevelText, self.SkillData.lv)
	UGUIUtil.SetText(self.CurLevelText, self.SkillData.lv)
	UGUIUtil.SetText(self.NextCurLevelText, self.SkillData.lv)
	UGUIUtil.SetText(self.CurMaxLevelText, "/" .. self.SkillData:GetDiySkillMaxLvByBreach(self.SkillData.strengLv))
	UGUIUtil.SetText(self.SkillTypeText, RoleDevelopmentApi:GetSkillType(self.SkillData:GetCfg().SkillType))
	self.ArrowImage:SetActive(not isMaxStrength)
	self.NextLvInfo:SetActive(not isMaxStrength)

	if not isMaxStrength then
		UGUIUtil.SetText(self.NextMaxLevelText, "/" .. self.SkillData:GetDiySkillMaxLvByBreach(self.SkillData.strengLv + 1))
	end

	UGUIUtil.SetText(self.CDText, self.SkillData.CD)
	UGUIUtil.SetText(self.CostNum, self.SkillData.Cost)
	self:RefreshSkillBreachStar()
	LuaUtility.SetGameObjectShow(self.LockImg, self.SkillData.lock)
	LuaUtility.SetGameObjectShow(self.UnLockImg, not self.SkillData.lock)
	LuaUtility.SetGameObjectShow(self.SelectItemParent, not isMaxStrength)
	LuaUtility.SetGameObjectShow(self.BreachBtn, not isMaxStrength)
	LuaUtility.SetGameObjectShow(self.Com_ConsumeGold, not isMaxStrength)
	LuaUtility.SetGameObjectShow(self.MaxBtn, isMaxStrength)

	if self.SkillData:IsMaxBreachLv() then
		return
	end

	local AllMaterialItem = WarehouseModule.GetItemDataByCfgID(self.SkillData:GetRankCfg().CostItemLiet)

	self.AllSkillItems = RoleDevelopmentModule.GetSkillItemsByCid(self.ItemData.cid, self.ItemData.id)

	if AllMaterialItem ~= nil then
		for i = 1, AllMaterialItem.num do
			table.insert(self.AllSkillItems, i, AllMaterialItem)
		end
	end

	self:RefreshItem()
	self:RefreshSelectItemGrid()
	self:RefreshStrengthTips()
end

function SkillBreachUI:RefreshSkillBreachStar()
	local cells = self.breachStarCom.cells.Count

	for i = 1, cells do
		local simpleStarCell = self.breachStarCom.cells[i - 1]

		self:LoadImg(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.SkillData.itemCid].Quality), simpleStarCell.lightPart)

		simpleStarCell = self.presentStarCom.cells[i - 1]

		self:LoadImg(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.SkillData.itemCid].Quality), simpleStarCell.lightPart)

		simpleStarCell = self.nextStarCom.cells[i - 1]

		self:LoadImg(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.SkillData.itemCid].Quality), simpleStarCell.lightPart)
	end

	self.breachStarCom:UpdateView(5, self.SkillData.strengLv)
	self.presentStarCom:UpdateView(5, self.SkillData.strengLv)
	self.nextStarCom:UpdateView(5, self.SkillData.strengLv + 1 > 5 and 5 or self.SkillData.strengLv + 1)
	self.ApStarCom:UpdateView(5, self.SkillData.AP)

	local skillElement = CfgSkillDetailTable[self.SkillData.skillCid].Element

	if skillElement > 0 then
		self:LoadImg(CommonSlotUIApi:GetSkillElement(skillElement), self.ElementImg)
	end

	if self.skillRangeID ~= 0 then
		local path = UIGlobalApi.GetImagePath(CfgSkillRangeTable[self.skillRangeID].SkillRangeImg)

		self:LoadImg(path, self.RangeImg)
	end
end

function SkillBreachUI:RefreshItem()
	self:SortItem()
	self.wrapContent:Refresh(#self.AllSkillItems)
	self.NoneSkillItem:SetActive(#self.AllSkillItems <= 0)
end

function SkillBreachUI:SortItem()
	table.sort(self.AllSkillItems, function(a, b)
		if a:GetCfg().Quality == b:GetCfg().Quality then
			if a:GetCfg().ItemTypes == Constant.ItemType.Skill and b:GetCfg().ItemTypes == Constant.ItemType.Skill then
				if a.skillData.lv == b.skillData.lv then
					if a.skillData.strengLv == b.skillData.strengLv then
						return a.skillData.heroCid > b.skillData.heroCid
					end

					return a.skillData.strengLv > b.skillData.strengLv
				end

				return a.skillData.lv > b.skillData.lv
			end

			return a:GetCfg().ItemTypes < b:GetCfg().ItemTypes
		end

		return a:GetCfg().Quality > b:GetCfg().Quality
	end)
end

function SkillBreachUI:OnRenderItem(cell)
	local itemData = self.AllSkillItems[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.SkillItemList[instanceId]

	if itemCell == nil then
		itemCell = BreachMaterialItem.New(cell.gameObject, function(itemData, instanceId)
			self:ItemSelectCallBack(itemData, instanceId)
		end, function(itemData, instanceId)
			self:ItemCancelCallBack(itemData, instanceId)
		end)
		self.SkillItemList[instanceId] = itemCell
	end

	itemCell:SetData(itemData, instanceId)
	itemCell:InitState()
end

function SkillBreachUI:RefreshSelectItemGrid()
	self.CurSelectItems = {}

	for i = 1, self.SkillData:GetRankCfg().ItemCount do
		local selectItemObj = self:CreateSelectItem(i)

		selectItemObj:InitState()
		table.insert(self.CurSelectItems, selectItemObj)
	end

	for i = 1, #self.SelectItems do
		self.SelectItems[i].View:SetActive(i <= self.SkillData:GetRankCfg().ItemCount)
	end
end

function SkillBreachUI:CreateSelectItem(index)
	local selectItem = self.SelectItems[index]

	if selectItem == nil then
		local selectItemObj = UnityEngine.GameObject.Instantiate(self.SelectItemPrefab)

		selectItemObj.transform:SetParent(self.SelectItemParent.transform, false)

		self.SelectItems[index] = BreachSelectItemCell.New(selectItemObj, index)
		selectItem = self.SelectItems[index]
	end

	return selectItem
end

function SkillBreachUI:RefreshIsBreachMaxExp()
	local exp = 0

	for k, v in pairs(self.BreachNeedMaterial) do
		if v > 0 then
			exp = exp + WarehouseModule.FindItem(k):GetCfg().ActionParams[1] * v
		else
			self.BreachNeedMaterial[k] = nil
		end
	end

	RoleDevelopmentModule.SelectBreachMaterialIsMax = exp >= self.SkillData:GetRankCfg().ItemCount
end

function SkillBreachUI:ItemSelectCallBack(itemData, instanceId)
	self:OnRefreshSelectMaterial(itemData, instanceId)
end

function SkillBreachUI:ItemCancelCallBack(itemData, instanceId)
	self:OnRefreshCancelMaterial(itemData, instanceId)
end

function SkillBreachUI:OnRefreshSelectMaterial(itemData, instanceId)
	for i = 1, #self.CurSelectItems do
		local selectItem = self.CurSelectItems[i]

		if selectItem.instanceID == nil then
			selectItem:SetData(itemData, instanceId)

			break
		end
	end

	if itemData:GetCfg().ItemTypes == Constant.ItemType.Item then
		local num = self.BreachNeedMaterial[itemData.id]

		self.BreachNeedMaterial[itemData.id] = num == nil and 1 or self.BreachNeedMaterial[itemData.id] + 1
	else
		self.BreachNeedMaterial[itemData.id] = 1
	end

	self:RefreshIsBreachMaxExp()
	self:RefreshStrengthTips()
end

function SkillBreachUI:OnRefreshCancelMaterial(itemData, instanceId)
	if itemData:GetCfg().ItemTypes == Constant.ItemType.Item then
		local num = self.BreachNeedMaterial[itemData.id]
		local var_41_0 = self.BreachNeedMaterial
		local var_41_1 = itemData.id

		if num == nil then
			-- block empty
		end

		var_41_0[var_41_1] = self.BreachNeedMaterial[itemData.id] - 1
	else
		self.BreachNeedMaterial[itemData.id] = nil
	end

	for i = #self.CurSelectItems, 1, -1 do
		local selectItem = self.CurSelectItems[i]

		if selectItem.instanceID == instanceId then
			selectItem:InitState()

			break
		end
	end

	self:RefreshIsBreachMaxExp()
	self:RefreshStrengthTips()
end

function SkillBreachUI:OnDiySkillSelectMaterialItemEvent()
	self:PlayAnim(true)
end

function SkillBreachUI:RefreshStrengthTips()
	local isShowTips = false

	for k, v in pairs(self.BreachNeedMaterial) do
		if v > 0 then
			local breachItem = WarehouseModule.FindItem(k)

			if breachItem:GetCfg().ItemTypes == Constant.ItemType.Skill and (breachItem.skillData.lv > 1 or breachItem.skillData.strengLv >= 1) then
				isShowTips = true
			end
		end
	end

	self.IsStrengthTips:SetActive(isShowTips)
end

function SkillBreachUI:PlayAnim(state)
	LuaUtility.SetGameObjectShow(self.CloseSkillBagBtn, state)

	if state then
		self.skillBagTween:PlayForward()
	else
		self.skillBagTween:PlayReverse()
	end
end

function SkillBreachUI:OnCloseSkillBagBtnClick()
	self:PlayAnim(false)
end

function SkillBreachUI:BreachBtnClick()
	if not RoleDevelopmentModule.SelectBreachMaterialIsMax then
		NoticeModule.ShowNotice(45016)

		return
	end

	if self.BreachNeedMoney > WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	RoleDevelopmentModule.RoleSkillBeach(self.SkillData.id, self.BreachNeedMaterial)
end

function SkillBreachUI:BreachSucessCallback()
	self:SetShowInfo(self.SkillData.id)
	NoticeModule._ShowStrengthEffectNotcie(Constant.StrengthType.SkillBreach)
	UIModule.Close(Constant.UIControllerName.SkillBreachUI)
end

function SkillBreachUI:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

return SkillBreachUI
