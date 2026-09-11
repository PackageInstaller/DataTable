local DrawGiftView = class("DrawGiftView", ReduxView)

function DrawGiftView:UIName()
	return "Widget/System/Recharge/RechargeDrawGiftUI"
end

function DrawGiftView:UIParent()
	return manager.ui.uiPop.transform
end

function DrawGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawGiftView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, RechargeGiftItem)
end

function DrawGiftView:AddUIListener()
	self:AddBtnListener(self.m_bgmask, nil, function()
		self:Back()
	end)
end

function DrawGiftView:OnTop()
	local var_7_0 = DrawTools.GetCostTicketList(self.poolId)
	local var_7_1 = DrawTools.GetActivityCostTicket(self.poolId)

	if var_7_1 == 0 or ItemTools.IsItemExpiredByItemId(var_7_1) then
		manager.windowBar:SwitchBar((table.insertto(var_7_0, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})))
	else
		local var_7_2 = {}

		if ItemTools.getItemNum(var_7_1) > 0 then
			table.insert(var_7_2, var_7_1)
		end

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_2, iter_7_1)
		end

		table.insertto(var_7_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_7_2)

		if ItemTools.getItemNum(var_7_1) > 0 then
			manager.windowBar:SetBarCanAdd(var_7_1, false)
			manager.windowBar:SetBarCanClick(var_7_1, true)
		end
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	self.list:Refresh()
end

function DrawGiftView:OnEnter()
	self.poolId = self.params_.poolId

	self:RefreshUI()
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_9_0)
		self.list:Refresh()
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_10_0)
		self.list:Refresh()
	end)
	self:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_11_0, arg_11_1)
		self:RefreshUI()
	end)
end

function DrawGiftView:RefreshUI()
	self.recharge_shop_list = DrawTools.GetRechargeDrawGiftList(self.poolId)

	self.list:StartScroll(#self.recharge_shop_list)
end

function DrawGiftView:OnExit()
	self:RemoveAllEventListener()
end

function DrawGiftView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData({
		id = self.recharge_shop_list[arg_14_1]
	})
end

function DrawGiftView:OnItemOutOfDate(arg_15_1)
	self:RefreshUI()
end

function DrawGiftView:OnShopBuyResult()
	self.list:Refresh()
end

function DrawGiftView:Dispose()
	self.list:Dispose()
	DrawGiftView.super.Dispose(self)
end

return DrawGiftView
