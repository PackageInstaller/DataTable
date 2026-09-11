local PolyhedronShopView = class("PolyhedronShopView", ReduxView)

function PolyhedronShopView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronShopUI"
end

function PolyhedronShopView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronShopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronShopView:InitUI()
	self:BindCfgUI()

	self.shopList = LuaList.New(handler(self, self.IndexItem), self.m_shopList, PolyhedronShopItem)
end

function PolyhedronShopView:AddUIListener()
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(self.coinId), self.refreshCost),
			OkCallback = function()
				PolyhedronAction.QueryRefreshShop()
			end
		})
	end)
	self:AddBtnListener(self.m_addBloodBtn, nil, function()
		PolyhedronAction.QueryShopBloodReturn()
	end)
	self:AddBtnListener(self.m_back, nil, function()
		gameContext:Go("/polyhedronBlank/polyhedronBattle")
	end)
end

function PolyhedronShopView:OnTop()
	return
end

function PolyhedronShopView:OnEnter()
	self:RefreshUI()
end

function PolyhedronShopView:OnExit()
	LuaForCursor.SwitchCursor(false)
end

function PolyhedronShopView:RefreshUI(arg_13_1)
	local var_13_0 = PolyhedronData:GetPolyhedronInfo()

	self.polyhedronInfo = var_13_0
	self.shops = var_13_0:GetShopItemList()

	if arg_13_1 then
		self.shopList:StartScrollByPosition(#self.shops, arg_13_1)
	else
		self.shopList:StartScroll(#self.shops)
	end

	self.refreshCount = var_13_0:GetShopRefreshTimes()

	local var_13_1 = var_13_0:GetShopMaxRefreshTimes()
	local var_13_2 = var_13_0:GetShopFressRefreshTimes()

	self.coinId = var_13_0:GetPolyhedronCoinId()

	if var_13_1 > self.refreshCount then
		SetActive(self.m_refreshContent, true)

		self.refreshCost = 0
		self.m_refreshCount.text = string.format("%d/%d", self.refreshCount, var_13_1)
		self.refreshCost = var_13_2 <= self.refreshCount and var_13_0:GetShopRefreshCost(self.refreshCount - var_13_2 + 1) or 0
		self.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(self.coinId)
		self.m_refreshCost.text = self.refreshCost
	else
		SetActive(self.m_refreshContent, false)
	end

	self.recoverCount = var_13_0:GetShopRecoverTimes()

	if var_13_0:GetShopRecoverMaxTimes() > self.recoverCount then
		SetActive(self.m_recoverContent, true)
	else
		SetActive(self.m_recoverContent, false)
	end

	self.m_addBloodDes.text = PolyhedronEffectCfg[PolyhedronSettingCfg[PolyhedronConst.POLYHEDRON_SETTING_ID.SHOP_RECOVER].value[1]].params[1] / 10 .. "%"
	self.coinId = var_13_0:GetPolyhedronCoinId()
	self.m_coinIcon.sprite = ItemTools.getItemLittleSprite(self.coinId)
	self.m_coinLab.text = var_13_0:GetCoinCount()
end

function PolyhedronShopView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.polyhedronInfo, self.shops[arg_14_1])
end

function PolyhedronShopView:Dispose()
	self.shopList:Dispose()
	PolyhedronShopView.super.Dispose(self)
end

function PolyhedronShopView:OnPolyhedronGameUpdate()
	self:RefreshUI((self.shopList:GetScrolledPosition()))
end

function PolyhedronShopView:OnPolyhedronProcessUpdate()
	self:RefreshUI((self.shopList:GetScrolledPosition()))
end

return PolyhedronShopView
