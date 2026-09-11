local ActivitySkinDrawPopViewOld = class("ActivitySkinDrawPopViewOld", ReduxView)

function ActivitySkinDrawPopViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetPopUIName(self.params_.mainActivity)
end

function ActivitySkinDrawPopViewOld:UIParent()
	return manager.ui.uiPop.transform
end

function ActivitySkinDrawPopViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawPopViewOld:InitUI()
	self:BindCfgUI()

	self.discountCon_ = ControllerUtil.GetController(self.transform_, "discount")
end

function ActivitySkinDrawPopViewOld:AddUIListeners()
	self:AddToggleListener(self.tgl1_, function(arg_6_0)
		self.choose_ = 1
	end)
	self:AddToggleListener(self.tgl2_, function(arg_7_0)
		self.choose_ = 2
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		ShopAction.BuyItem({
			{
				goodID = self.goods_[self.choose_],
				buyNum = self.cnt_
			}
		})
	end)
end

function ActivitySkinDrawPopViewOld:OnEnter()
	self.choose_ = 2
	self.tgl2_.isOn = true

	self:RefreshUI()
end

function ActivitySkinDrawPopViewOld:RefreshUI()
	self.activityID_ = self.params_.poolActivityID
	self.poolID_ = self.params_.poolID
	self.goods_ = self.params_.goods
	self.cnt_ = self.params_.cnt

	self:RefreshGoods()
	self:RefreshDiscount()
end

function ActivitySkinDrawPopViewOld:RefreshGoods()
	self.text1_.text = self:GetGoodsDesc(1)
	self.text2_.text = self:GetGoodsDesc(2)
end

function ActivitySkinDrawPopViewOld:GetGoodsDesc(arg_14_1)
	local var_14_0 = getShopCfg(self.goods_[arg_14_1])

	return string.format(GetTips("GENGCHEN_SWIMWEAR_TICKET_TIPS"), ((var_14_0.discount ~= 0 or nil) and var_14_0.cheap_cost) * self.cnt_, ItemTools.getItemName(var_14_0.cost_id), ItemTools.getItemName(var_14_0.give_id), self.cnt_)
end

function ActivitySkinDrawPopViewOld:RefreshDiscount()
	local var_15_0 = getShopCfg(self.goods_[2])

	if var_15_0.discount ~= 0 then
		self.discount_.text = ShopTools.GetDiscountLabelByPercent(var_15_0.discount)

		self.discountCon_:SetSelectedState("true")
	else
		self.discountCon_:SetSelectedState("false")
	end
end

function ActivitySkinDrawPopViewOld:OnShopBuyResult(arg_16_1, arg_16_2, arg_16_3)
	self:Back()

	if arg_16_2 == self.goods_[self.choose_] then
		ActivitySkinDrawActionOld.StartDraw(self.activityID_, self.poolID_, self.cnt_)
	end
end

function ActivitySkinDrawPopViewOld:OnExit()
	self:RemoveAllEventListener()
end

function ActivitySkinDrawPopViewOld:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawPopViewOld
