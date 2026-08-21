-- chunkname: @IQIGame\\UI\\ItemTipsUI.lua

local ItemTipsUI = Base:Extend("ItemTipsUI", "IQIGame.Onigao.UI.ItemTipsUI", {
	forShow = true,
	cbParams = {}
})
local ItemInfoCell = require("IQIGame.UI.Tips.ItemInfoCell")
local ItemTipContent = require("IQIGame.UI.Tips.ItemTipContent")

function ItemTipsUI:OnInit()
	self:Initialize()
end

function ItemTipsUI:GetPreloadAssetPaths()
	return nil
end

function ItemTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ItemTipsUI:OnOpen(userData)
	self:RefreshView(userData)
end

function ItemTipsUI:OnClose(userData)
	return
end

function ItemTipsUI:OnPause()
	return
end

function ItemTipsUI:OnResume()
	return
end

function ItemTipsUI:OnCover()
	return
end

function ItemTipsUI:OnReveal()
	return
end

function ItemTipsUI:OnRefocus(userData)
	return
end

function ItemTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ItemTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ItemTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ItemTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ItemTipsUI:OnDestroy()
	self.infoCell:OnDestroy()
	self.contentView:OnDestroy()
end

function ItemTipsUI:Initialize()
	self.scrollRect = self.goScrollRect:GetComponent("ScrollRect")

	local goView = self.scrollRect.viewport:GetChild(0).gameObject

	self.scrollRect.content = goView:GetComponent("RectTransform")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.contentView = ItemTipContent.New(goView)
	self.infoCell = ItemInfoCell.New(self.goSlotParent.transform:GetChild(0).gameObject)
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnUse = self.goBtnUse:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnUseDelegate()
		self:OnClickBtnUse()
	end

	function self.onClickSkillStrengthDelegate()
		self:OnClickSkillStrength()
	end

	function self.onClickEquipStrengthDelegate()
		self:OnClickEquipStrength()
	end

	function self.onClickCompositeDelegate()
		self:OnClickComposite()
	end

	self.goBtnUse.transform:Find("Text"):GetComponent("Text").text = ItemTipsApi:GetBtnUseTxt()
end

function ItemTipsUI:RefreshView(userData)
	self:RefreshDatum(userData)
	self:RefreshMisc()
	self.infoCell:RefreshView(self.itemData)
	self.contentView:RefreshView(self.itemData, self, userData.hideSource)
end

function ItemTipsUI:RefreshDatum(userData)
	self.itemData = userData.data

	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self.cfgItemData = CfgItemTable[self.itemData.cid]

	if userData.cbParams == nil then
		self.cbParams = {}
	else
		self.cbParams = userData.cbParams
	end

	self.forShow = userData.forShow
end

function ItemTipsUI:RefreshMisc()
	self.tfDesc.text = ItemTipsApi:GetDesc(self.cfgItemData.ItemTips)

	local isSpecialItem = false

	if self.cfgItemData.ItemTypes == Constant.ItemType.Skill or self.cfgItemData.ItemTypes == Constant.ItemType.Equip or self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == 1 or self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == 2 then
		isSpecialItem = true
	end

	self.goBtnUse:SetActive(not self.forShow and not self.itemData:IsExpired() and self.cfgItemData.UseType == 2 and not isSpecialItem)
	self.goSkillStrengthBtn:SetActive(not self.forShow and self.cfgItemData.ItemTypes == Constant.ItemType.Skill and not self.itemData:IsExpired())
	LuaUtility.SetGameObjectShow(self.goEquipStrengthBtn, false)

	if self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == 1 then
		self.goCompositeBtn:SetActive(not self.forShow and self:IsHasHero(self.cfgItemData) and not self.itemData:IsExpired())
	else
		self.goCompositeBtn:SetActive(not self.forShow and (self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == 1 or self.cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and self.cfgItemData.ItemSubTypes == 2) and not self.itemData:IsExpired())
	end
end

function ItemTipsUI:RefreshBtnVisible()
	return
end

function ItemTipsUI:IsHasHero(cfgData)
	local combinId = cfgData.CombinationId[1]
	local herocid = CfgItemTable[CfgCombinationTable[combinId].Output[1]].ActionParams[1]

	return WarlockModule.WarlockDataDic[herocid] == nil
end

function ItemTipsUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnUse.onClick:AddListener(self.onClickBtnUseDelegate)
	self.goSkillStrengthBtn:GetComponent("Button").onClick:AddListener(self.onClickSkillStrengthDelegate)
	self.goEquipStrengthBtn:GetComponent("Button").onClick:AddListener(self.onClickEquipStrengthDelegate)
	self.goCompositeBtn:GetComponent("Button").onClick:AddListener(self.onClickCompositeDelegate)
end

function ItemTipsUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnUse.onClick:RemoveListener(self.onClickBtnUseDelegate)
	self.goSkillStrengthBtn:GetComponent("Button").onClick:RemoveListener(self.onClickSkillStrengthDelegate)
	self.goEquipStrengthBtn:GetComponent("Button").onClick:RemoveListener(self.onClickEquipStrengthDelegate)
	self.goCompositeBtn:GetComponent("Button").onClick:RemoveListener(self.onClickCompositeDelegate)
end

function ItemTipsUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ItemTipsUI)
end

function ItemTipsUI:OnClickBtnUse()
	local canUse, errorMsg = ItemModule.CheckCanUse(self.itemData, 1)

	if canUse then
		if self.cfgItemData.UseType == Constant.ItemUseType.ManualUse and self.itemData.num >= 1 then
			if self.itemData.num == 1 and self.cfgItemData.ItemTypes == Constant.ItemType.Gift and (self.cfgItemData.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].Random or self.cfgItemData.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].NonSelection) then
				local useItemPods = {}

				useItemPods.selectIndex = 1
				useItemPods.id = self.itemData.id
				useItemPods.num = 1

				ItemModule.UseItem({
					useItemPods
				})
			else
				UIModule.Open(Constant.UIControllerName.UseNumberUI, Constant.UILayer.UI, self.itemData)
			end
		end

		self:OnClickBtnClose()
	else
		NoticeModule.ShowNoticeNoCallback(21040005, errorMsg)
	end
end

function ItemTipsUI:OnClickSkillStrength()
	if self.itemData.skillData:IsMaxLv() then
		NoticeModule.ShowNotice(20015)

		return
	end

	self:OnClickBtnClose()
	UIModule.Open(Constant.UIControllerName.SkillStrengthenUI, Constant.UILayer.UI, self.itemData.skillData.id)
end

function ItemTipsUI:OnClickEquipStrength()
	if self.itemData.equipData.isMaxLv then
		NoticeModule.ShowNotice(20015)

		return
	end

	self:OnClickBtnClose()
	UIModule.Open(Constant.UIControllerName.EquipStrengthUI, Constant.UILayer.UI, {
		equipData = self.itemData.equipData
	})
end

function ItemTipsUI:OnClickComposite()
	self:OnClickBtnUse()
end

function ItemTipsUI:OnClickBtnSell()
	if self.itemData.num > 1 and self.cfgItemData.SellConfirm ~= 0 then
		UIModule.Open(Constant.UIControllerName.UseNumberUI, Constant.UILayer.Tooltip, {
			isUse = false,
			id = self.itemData.id
		}, true)
	else
		ItemModule.SellItem(self.itemData, 1)
	end

	self:OnClickBtnClose()
end

function ItemTipsUI:OnClickBtnDestroy()
	ItemModule.DestroyItem(self.itemData)
	self:OnClickBtnClose()
end

function ItemTipsUI:OnClickBtnCustom()
	for i, v in pairs(self.cbParams) do
		if i == "customCallback" then
			v()

			break
		end
	end

	self:OnClickBtnClose()
end

return ItemTipsUI
