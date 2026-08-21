-- chunkname: @IQIGame\\UI\\RoleBreachUI.lua

local RoleBreachUI = Base:Extend("RoleBreachUI", "IQIGame.Onigao.UI.RoleBreachUI", {
	CurNeedMoney = 0,
	CurNeedBreachItem = {},
	heroData = {},
	AttrsTable = {},
	AttrItemCellList = {},
	materialItems = {}
})
local roleBreachAttrItem = require("IQIGame.UI.RoleDevelopment.RoleBreachAttrItem")
local RoleBreachMaterialsItem = require("IQIGame.UI.RoleDevelopment.RoleBreachMaterialsItem")

function RoleBreachUI:OnInit()
	LuaCodeInterface.BindOutlet(self.BreachInfoView, self)

	function self.DelegateCloseBtn()
		UIModule.Close(Constant.UIControllerName.RoleBreachUI)
	end

	function self.DelegateBreachBtnClick()
		self:BreachBtnClick()
	end

	function self.DelegateBreachSucessCallback()
		self:RoleBreachSucessCallBack()
	end

	function self.DelegateUpdateItem()
		self:UpdateItem()
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	local luaTable = {}

	self.MainAttributeItemBindLua = LuaCodeInterface.BindOutlet(self.MainAttributeItem, luaTable)

	UGUIUtil.SetText(self.MainAttributeItemBindLua.CurLvTitle, RoleDevelopmentApi:GetLvText())
	UGUIUtil.SetText(self.MainAttributeItemBindLua.NextLvTitle, RoleDevelopmentApi:GetLvText())
	UGUIUtil.SetTextInChildren(self.BreachBtn, RoleDevelopmentApi:GetBreachBtnTitle())
end

function RoleBreachUI:GetPreloadAssetPaths()
	return nil
end

function RoleBreachUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleBreachUI:IsManualShowOnOpen(userData)
	return false
end

function RoleBreachUI:GetBGM(userData)
	return nil
end

function RoleBreachUI:OnOpen(userData)
	self.heroCid = userData.heroCid
	self.isPreview = userData.isPreview
	self.CurNeedMoney = 0

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self.consumeGoldCell:SetData(self.CurNeedMoney)
	self:SetRoleInfo()
	self:ShowRoleBreachItems()
	self:SetRoleBreachState()
	self:ShowRoleAttr()
end

function RoleBreachUI:OnClose(userData)
	return
end

function RoleBreachUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateBreachBtnClick)
	EventDispatcher.AddEventListener(EventID.RoleBreakThroughSucess, self.DelegateBreachSucessCallback)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function RoleBreachUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBreachBtnClick)
	EventDispatcher.RemoveEventListener(EventID.RoleBreakThroughSucess, self.DelegateBreachSucessCallback)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function RoleBreachUI:OnPause()
	return
end

function RoleBreachUI:OnResume()
	return
end

function RoleBreachUI:OnCover()
	return
end

function RoleBreachUI:OnReveal()
	return
end

function RoleBreachUI:OnRefocus(userData)
	return
end

function RoleBreachUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleBreachUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleBreachUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleBreachUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleBreachUI:OnRenderItemRowItem(cell)
	local ItemData = self.CurNeedBreachItem[cell.index + 1]
	local item = RoleBreachMaterialsItem.New(cell.gameObject)

	item:SetData(ItemData)
end

function RoleBreachUI:SetRoleInfo()
	self.heroData = WarlockModule.WarlockDataDic[self.heroCid]
	self.MaxHeroLv = self.heroData:GetCurMaxLv()
	self.CacheHeroData = Clone(self.heroData)

	self:IsPreview(self.isPreview)
end

function RoleBreachUI:SetRoleBreachState()
	self:LoadImage(RoleDevelopmentApi:GetBreachStateImg(self.heroData.breakLv), self.CurBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetBreachFontImg(self.heroData.breakLv), self.CurBreachFont:GetComponent("Image"))

	if self.heroData:IsMaxBreachLv() then
		self.NextBreachParent:SetActive(false)
		self.NextArrow:SetActive(false)
		self.ScrollViewGroup.gameObject:SetActive(false)
		self:IsPreview(false)

		return
	else
		self.ScrollViewGroup.gameObject:SetActive(true)
	end

	self:LoadImage(RoleDevelopmentApi:GetNextBreachStateImg(self.heroData.breakLv + 1), self.NextBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachFontImg(self.heroData.breakLv + 1), self.NextBreachFont:GetComponent("Image"))
end

function RoleBreachUI:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function RoleBreachUI:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function RoleBreachUI:ShowRoleBreachItems()
	if self.heroData:IsMaxBreachLv() then
		return
	end

	local items = self.heroData:QueryHeroBreachCfg().Cost

	self.CurNeedBreachItem = {}

	for i = 1, #items, 2 do
		if items[i] == Constant.ItemCid.GOLD then
			self.CurNeedMoney = items[i + 1]
		else
			table.insert(self.CurNeedBreachItem, {
				ID = items[i],
				Num = items[i + 1]
			})
		end
	end

	self:RefreshNeedMaterials()
	self.consumeGoldCell:SetData(self.CurNeedMoney)
	UGUIUtil.SetText(self.AllMoney, WarehouseModule.GetPlayerGoldNum() .. "/")

	if WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) >= self.CurNeedMoney then
		UGUIUtil.SetText(self.NeedMoney, string.format(ColorCfg.RoleUpdate.normalNum, self.CurNeedMoney))
	else
		UGUIUtil.SetText(self.NeedMoney, string.format(ColorCfg.RoleUpdate.zeroNum, self.CurNeedMoney))
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Com_ConsumeGold.transform)
end

function RoleBreachUI:RefreshNeedMaterials()
	local items = self.CurNeedBreachItem

	for i = 1, #items do
		local ItemObj = self:CreateItems(i)

		ItemObj:SetData(self.CurNeedBreachItem[i])
	end

	for i = 1, #self.materialItems do
		if i <= #items then
			self.materialItems[i]:Show()
		else
			self.materialItems[i]:Hide()
		end
	end
end

function RoleBreachUI:CreateItems(index)
	local ItemMaterial = self.materialItems[index]

	if ItemMaterial == nil then
		local ItemObj = UnityEngine.GameObject.Instantiate(self.MaterialItem)

		ItemObj.transform:SetParent(self.ItemsGrid.transform, false)

		local materialLuaTable = RoleBreachMaterialsItem.New(ItemObj)

		self.materialItems[index] = materialLuaTable
		ItemMaterial = self.materialItems[index]
	end

	return ItemMaterial
end

function RoleBreachUI:IsPreview(type)
	self.BreachBtn:SetActive(type)
	self.Com_ConsumeGold.gameObject:SetActive(type)
end

function RoleBreachUI:BreachBtnClick()
	if self.CurNeedMoney > WarehouseModule.GetPlayerGoldNum() then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	if not self.heroData:IsCanBreach() then
		NoticeModule.ShowNotice(11014)

		return
	end

	local hreoid = self.heroData.warlockCid

	RoleDevelopmentModule.RoleBreach(hreoid)
end

function RoleBreachUI:RoleBreachSucessCallBack()
	UIModule.Open(Constant.UIControllerName.RoleBreachSucessUI, Constant.UILayer.UI, self.CacheHeroData)
	UIModule.CloseSelf(self)
end

function RoleBreachUI:ShowRoleAttr()
	self.curAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv)
	self.nextAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv + 1)

	UGUIUtil.SetText(self.MainAttributeItemBindLua.AttrName, RoleDevelopmentApi:GetAttarTitle())
	UGUIUtil.SetText(self.MainAttributeItemBindLua.CurAttrText, self.curAttrData.MaxHeroLv)
	self.MainAttributeItemBindLua.NextAttrText:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.NextLvTitle:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.ArrowImg:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.AttrImg:SetActive(false)

	if not self.heroData:IsMaxBreachLv() then
		UGUIUtil.SetText(self.MainAttributeItemBindLua.NextAttrText, self.nextAttrData.MaxHeroLv)
	end

	self:RefreshAttr()
end

function RoleBreachUI:RefreshAttr()
	local lastAttrData

	lastAttrData = (self.heroData.breakLv ~= 0 or nil) and self.heroData:QueryHeroBreachCfg(self.heroData.breakLv - 1)

	local attrLength = 0

	for i = 1, #self.nextAttrData.AttrType do
		if self.nextAttrData.AttrType[i] ~= 0 and CfgAttributeTable[self.nextAttrData.AttrType[i]] ~= nil and CfgAttributeTable[self.nextAttrData.AttrType[i]].Show and RoleDevelopmentModule.PreviewHeroData.attr[i] ~= 0 then
			attrLength = attrLength + 1

			if self.AttrItemCellList[attrLength] == nil then
				local attrItem = UnityEngine.Object.Instantiate(self.AttributeItem)

				attrItem.transform:SetParent(self.AttributeGrid.transform, false)

				self.AttrItemCellList[attrLength] = roleBreachAttrItem.New(attrItem)
			end

			self.AttrItemCellList[attrLength]:SetData(self.heroData, self.curAttrData, self.nextAttrData, i, lastAttrData)
		end
	end

	for i = 1, #self.AttrItemCellList do
		if attrLength < i then
			self.AttrItemCellList[i]:Hide()
		else
			self.AttrItemCellList[i]:Show()
		end
	end
end

function RoleBreachUI:UpdateItem()
	self:RefreshNeedMaterials()
end

function RoleBreachUI:OnDestroy()
	for i = 1, #self.AttrItemCellList do
		self.AttrItemCellList[i]:Dispose()
	end

	for i = 1, #self.materialItems do
		self.materialItems[i]:Dispose()
	end

	self.MainAttributeItemBindLua = nil

	self.consumeGoldCell:Dispose()
	AssetUtil.UnloadAsset(self)
end

return RoleBreachUI
