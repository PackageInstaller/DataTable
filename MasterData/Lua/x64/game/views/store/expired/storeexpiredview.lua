local StoreExpiredView = class("StoreExpiredView", ReduxView)

function StoreExpiredView:UIName()
	return "Widget/System/Bag/BagExpiredUI"
end

function StoreExpiredView:UIParent()
	return manager.ui.uiPop.transform
end

function StoreExpiredView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StoreExpiredView:InitUI()
	self:BindCfgUI()

	self.haveBonusController_ = self.controllerEx_:GetController("haveBonus")
	self.expiredItemList_ = LuaList.New(handler(self, self.indexExpiredItem), self.expiredListGo_, CommonItemView)
	self.expiredItemList2_ = LuaList.New(handler(self, self.indexExpiredItem), self.expiredListGo2_, CommonItemView)
	self.getItemList_ = LuaList.New(handler(self, self.indexGetItem), self.getListGo_, CommonItemView)
end

function StoreExpiredView:indexGetItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.getItemDataList_[arg_5_1].id
	var_5_0.number = self.getItemDataList_[arg_5_1].num

	arg_5_2:SetData(var_5_0)
end

function StoreExpiredView:indexExpiredItem(arg_6_1, arg_6_2)
	local var_6_0 = clone(ItemTemplateData)

	var_6_0.id = self.expiredList_[arg_6_1].id
	var_6_0.number = self.expiredList_[arg_6_1].num
	var_6_0.transform = self.expiredList_[arg_6_1].transform

	arg_6_2:SetData(var_6_0)
end

function StoreExpiredView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn2_, nil, function()
		self:Back()
	end)
end

function StoreExpiredView:OnEnter()
	self.expiredList_ = self.params_.expiredList

	local var_10_0 = {}

	self.getItemDataList_ = {}

	for iter_10_0, iter_10_1 in ipairs(self.expiredList_) do
		if ItemCfg[iter_10_1.id].time_exchange_item then
			var_10_0[ItemCfg[iter_10_1.id].time_exchange_item[1]] = not var_10_0[ItemCfg[iter_10_1.id].time_exchange_item[1]] and ItemCfg[iter_10_1.id].time_exchange_item[2] * iter_10_1.num or var_10_0[ItemCfg[iter_10_1.id].time_exchange_item[1]] + ItemCfg[iter_10_1.id].time_exchange_item[2] * iter_10_1.num
			iter_10_1.transform = true
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		table.insert(self.getItemDataList_, {
			id = iter_10_2,
			num = iter_10_3
		})
	end

	if #self.getItemDataList_ > 0 then
		self.haveBonusController_:SetSelectedState("true")
		self.expiredItemList_:StartScroll(#self.expiredList_)
		self.getItemList_:StartScroll(#self.getItemDataList_)
	else
		self.expiredItemList2_:StartScroll(#self.expiredList_)
		self.haveBonusController_:SetSelectedState("false")
	end
end

function StoreExpiredView:OnExit()
	return
end

function StoreExpiredView:Dispose()
	self.expiredItemList_:Dispose()

	self.expiredItemList_ = nil

	self.expiredItemList2_:Dispose()

	self.expiredItemList2_ = nil

	self.getItemList_:Dispose()

	self.getItemList_ = nil

	StoreExpiredView.super.Dispose(self)
end

return StoreExpiredView
