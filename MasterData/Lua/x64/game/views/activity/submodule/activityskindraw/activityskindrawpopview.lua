local ActivitySkinDrawPopView = class("ActivitySkinDrawPopView", ReduxView)

function ActivitySkinDrawPopView:UIName()
	return ActivitySkinDrawTools.GetPopUIName(self.params_.mainActivity)
end

function ActivitySkinDrawPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivitySkinDrawPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawPopView:InitUI()
	self:BindCfgUI()

	self.giveId = {}
	self.costNumText_ = {}
	self.costImg_ = {}
	self.costNameText_ = {}
	self.giveNumText_ = {}
	self.giveImg_ = {}
	self.giveNameText_ = {}
	self.disconutController_ = {}
	self.discountText_ = {}

	for iter_4_0 = 1, 2 do
		self.costNumText_[iter_4_0] = self["costNumText_" .. iter_4_0]
		self.costImg_[iter_4_0] = self["costImg_" .. iter_4_0]
		self.costNameText_[iter_4_0] = self["costNameText_" .. iter_4_0]
		self.giveNumText_[iter_4_0] = self["giveNumText_" .. iter_4_0]
		self.giveImg_[iter_4_0] = self["giveImg_" .. iter_4_0]
		self.giveNameText_[iter_4_0] = self["giveNameText_" .. iter_4_0]
		self.disconutController_[iter_4_0] = self["discountCon_" .. iter_4_0]:GetController("discount")
		self.discountText_[iter_4_0] = self["discountText_" .. iter_4_0]
	end
end

function ActivitySkinDrawPopView:AddUIListeners()
	self:AddToggleListener(self.connect1Tgl_, function(arg_6_0)
		self.choose_ = 1
	end)
	self:AddToggleListener(self.connect2Tgl_, function(arg_7_0)
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

function ActivitySkinDrawPopView:OnEnter()
	self:RefreshUI()
end

function ActivitySkinDrawPopView:RefreshUI()
	self.activityID_ = self.params_.poolActivityID
	self.poolID_ = self.params_.poolID
	self.goods_ = self.params_.goods
	self.cnt_ = self.params_.cnt

	self:RefreshState()
	self:RefreshGoods()
end

function ActivitySkinDrawPopView:RefreshState()
	self.disconut_ = self.params_.discount

	if self.disconut_[2] < self.disconut_[1] or self.disconut_[1] == 0 then
		self.choose_ = 2
		self.connect2Tgl_.isOn = true
	else
		self.choose_ = 1
		self.connect1Tgl_.isOn = true
	end
end

function ActivitySkinDrawPopView:RefreshGoods()
	for iter_14_0, iter_14_1 in ipairs(self.goods_) do
		self:RefrehGoodsInfo(iter_14_0)
	end

	self.descText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), self.cnt_, ItemTools.getItemName(self.giveId[self.choose_]))
end

function ActivitySkinDrawPopView:RefrehGoodsInfo(arg_15_1)
	local var_15_0 = getShopCfg(self.goods_[arg_15_1])
	local var_15_1 = var_15_0.cost

	if var_15_0.discount ~= 0 then
		var_15_1 = var_15_0.cheap_cost
	end

	self.giveId[arg_15_1] = var_15_0.give_id
	self.costNumText_[arg_15_1].text = var_15_1 * self.cnt_
	self.costImg_[arg_15_1].sprite = ItemTools.getItemSprite(var_15_0.cost_id)
	self.costNameText_[arg_15_1].text = ItemTools.getItemName(var_15_0.cost_id)
	self.giveNumText_[arg_15_1].text = self.cnt_
	self.giveImg_[arg_15_1].sprite = ItemTools.getItemSprite(var_15_0.give_id, nil, true)
	self.giveNameText_[arg_15_1].text = ItemTools.getItemName(var_15_0.give_id, nil, true)
	self.discountText_[arg_15_1].text = ShopTools.GetDiscountLabelByPercent(self.disconut_[arg_15_1])

	self.disconutController_[arg_15_1]:SetSelectedState(self.disconut_[arg_15_1] ~= 0 and "show" or "hide")
end

function ActivitySkinDrawPopView:OnShopBuyResult(arg_16_1, arg_16_2, arg_16_3)
	self:Back()

	if arg_16_2 == self.goods_[self.choose_] then
		ActivitySkinDrawAction.StartDraw(self.activityID_, self.poolID_, self.cnt_)
	end
end

function ActivitySkinDrawPopView:OnExit()
	self:RemoveAllEventListener()
end

function ActivitySkinDrawPopView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawPopView
