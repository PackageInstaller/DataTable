local ActivityOathSkinDrawPopView = class("ActivityOathSkinDrawPopView", ReduxView)

function ActivityOathSkinDrawPopView:UIName()
	return OathDrawTools.GetPopUIName(self.params_.mainActivity)
end

function ActivityOathSkinDrawPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityOathSkinDrawPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityOathSkinDrawPopView:InitUI()
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

function ActivityOathSkinDrawPopView:AddUIListeners()
	self:AddToggleListener(self.connect1Tgl_, function(arg_6_0)
		self.choose_ = 1

		self:UpdateSliderValue()
	end)
	self:AddToggleListener(self.connect2Tgl_, function(arg_7_0)
		self.choose_ = 2

		self:UpdateSliderValue()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		local var_10_0 = self.goods_[self.choose_]

		if self.cntList_[self.choose_] > self:GetRemainCanDrawCnt() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("WEDDING_AUTO_DRAW_TIPS2"),
				OkCallback = function()
					ShopAction.BuyItem({
						{
							goodID = var_10_0,
							buyNum = self.cntList_[self.choose_]
						}
					})
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShopAction.BuyItem({
				{
					goodID = self.goods_[self.choose_],
					buyNum = self.cntList_[self.choose_]
				}
			})
		end
	end)
	self:AddBtnListener(self.delBtn_, nil, function()
		self:OnChangeBuyCnt(-1)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self:OnChangeBuyCnt(1)
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self:OnChangeBuyCnt(self:GetRemainCanBuyCnt(self.choose_) - self.cntList_[self.choose_])
	end)
	self.useNumSli_.onValueChanged:AddListener(function(arg_16_0)
		if arg_16_0 < 1 then
			arg_16_0 = 1
			self.useNumSli_.value = 1

			return
		end

		self.cntList_[self.choose_] = arg_16_0

		self:UpdateSliderText()
		self:RefrehGoodsInfo(self.choose_)
		self:UpdateDelAddBtn()
	end)
end

function ActivityOathSkinDrawPopView:UpdateSliderValue()
	self.useNumSli_.maxValue = math.min(self:GetMaxCanBuyCount(self.choose_), self:GetRemainCanBuyCnt(self.choose_))
	self.useNumSli_.minValue = 0
	self.useNumSli_.value = self.cntList_[self.choose_]

	self:UpdateDelAddBtn()
end

function ActivityOathSkinDrawPopView:OnChangeBuyCnt(arg_18_1)
	self.useNumSli_.value = Mathf.Clamp(self.cntList_[self.choose_] + arg_18_1, 1, self:GetRemainCanBuyCnt(self.choose_))

	self:UpdateSliderText()
	self:RefrehGoodsInfo(self.choose_)
end

function ActivityOathSkinDrawPopView:UpdateDelAddBtn()
	self.delBtn_.interactable = self.cntList_[self.choose_] > 1
	self.addBtn_.interactable = self.cntList_[self.choose_] < math.min(self:GetMaxCanBuyCount(self.choose_), self:GetRemainCanBuyCnt(self.choose_))
end

function ActivityOathSkinDrawPopView:UpdateSliderText()
	self.useNumText_.text = tostring(self.cntList_[self.choose_])

	self:RefreshGoods()
end

function ActivityOathSkinDrawPopView:GetRemainCanDrawCnt()
	if self.remainCanDrawCnt then
		return self.remainCanDrawCnt
	end

	self.remainCanDrawCnt = ActivityOathDrawData:GetRemainCanDrawCnt(self.activityID_)

	return self.remainCanDrawCnt
end

function ActivityOathSkinDrawPopView:GetRemainCanBuyCnt(arg_22_1)
	local var_22_0 = getShopCfg(self.goods_[arg_22_1])
	local var_22_1 = ShopData.GetShop(var_22_0.shop_id)[self.goods_[arg_22_1]]

	return var_22_0.limit_num - ((var_22_1 or nil) and (var_22_1.buy_times or 0))
end

function ActivityOathSkinDrawPopView:GetDrawingReaminCnt()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs((ActivityOathDrawData:GetDrawData(self.activityID_))) do
		if not iter_23_1.isOpen then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function ActivityOathSkinDrawPopView:GetHaveCnt(arg_24_1)
	return ItemTools.getItemNum(getShopCfg(self.goods_[arg_24_1]).give_id)
end

function ActivityOathSkinDrawPopView:GetDefaultBuyCnt(arg_25_1)
	return math.min(math.max(self:GetDrawingReaminCnt() - self:GetHaveCnt(arg_25_1), 1), self:GetRemainCanBuyCnt(arg_25_1))
end

function ActivityOathSkinDrawPopView:GetMaxCanBuyCount(arg_26_1)
	return math.max(self:GetRemainCanDrawCnt() - self:GetHaveCnt(arg_26_1), 1)
end

function ActivityOathSkinDrawPopView:OnEnter()
	self:RefreshUI()
end

function ActivityOathSkinDrawPopView:RefreshUI()
	self.activityID_ = self.params_.poolActivityID
	self.poolID_ = self.params_.poolID
	self.goods_ = self.params_.goods
	self.defaultBuyCnt_ = self.params_.defaultBuyCnt or -1
	self.cntList_ = {}

	for iter_28_0 = 1, 2 do
		self.cntList_[iter_28_0] = self.defaultBuyCnt_ and self.defaultBuyCnt_ > 0 and self.defaultBuyCnt_ or self:GetDefaultBuyCnt(iter_28_0)
	end

	self:RefreshState()
	self:RefreshGoods()
	self:UpdateSliderValue()
	self:UpdateDelAddBtn()

	self.titlteText_.text = string.format(GetTips("EXCHANGE_TIP"), ItemTools.getItemName(self.giveId[self.choose_]))
end

function ActivityOathSkinDrawPopView:RefreshState()
	self.disconut_ = self.params_.discount

	if self.disconut_[2] < self.disconut_[1] or self.disconut_[1] == 0 then
		self.choose_ = 2
		self.connect2Tgl_.isOn = true
	else
		self.choose_ = 1
		self.connect1Tgl_.isOn = true
	end
end

function ActivityOathSkinDrawPopView:RefreshGoods()
	for iter_30_0, iter_30_1 in ipairs(self.goods_) do
		self:RefrehGoodsInfo(iter_30_0)
	end

	self.descText_.text = string.format(GetTips("WEDDING_TICKET_DRAW_TIPS1"), self.cntList_[self.choose_], self:GetRemainCanBuyCnt(self.choose_))
end

function ActivityOathSkinDrawPopView:RefrehGoodsInfo(arg_31_1)
	local var_31_0 = getShopCfg(self.goods_[arg_31_1])
	local var_31_1 = var_31_0.cost

	if var_31_0.discount ~= 0 then
		var_31_1 = var_31_0.cheap_cost
	end

	self.giveId[arg_31_1] = var_31_0.give_id
	self.costNumText_[arg_31_1].text = var_31_1 * self.cntList_[arg_31_1]
	self.costImg_[arg_31_1].sprite = ItemTools.getItemSprite(var_31_0.cost_id)
	self.costNameText_[arg_31_1].text = ItemTools.getItemName(var_31_0.cost_id)
	self.giveNumText_[arg_31_1].text = self.cntList_[arg_31_1]
	self.giveImg_[arg_31_1].sprite = ItemTools.getItemSprite(var_31_0.give_id, nil, true)
	self.giveNameText_[arg_31_1].text = ItemTools.getItemName(var_31_0.give_id, nil, true)
	self.discountText_[arg_31_1].text = ShopTools.GetDiscountLabelByPercent(self.disconut_[arg_31_1])

	self.disconutController_[arg_31_1]:SetSelectedState(self.disconut_[arg_31_1] ~= 0 and "show" or "hide")
end

function ActivityOathSkinDrawPopView:OnShopBuyResult(arg_32_1, arg_32_2, arg_32_3)
	self:Back()

	if arg_32_2 == self.goods_[self.choose_] and self.params_.drawCallback then
		self.params_.drawCallback(self.cntList_[index])
	end
end

function ActivityOathSkinDrawPopView:OnExit()
	self.remainCanDrawCnt = nil

	self:RemoveAllEventListener()
end

function ActivityOathSkinDrawPopView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityOathSkinDrawPopView
