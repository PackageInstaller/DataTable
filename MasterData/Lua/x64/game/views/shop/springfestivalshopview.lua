local SpringFestivalShopView = class("SpringFestivalShopView", NewActivityShopView)

function SpringFestivalShopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Shop/SandPlay_3_10_ShopUI"
end

function SpringFestivalShopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpringFestivalShopView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ExchangeItemView)
	self.tipsController_ = self.transCon_:GetController("tips")
	self.titleTogList = {
		RechargeSpringFestivalTitleItem.New(self.tag01_),
		(RechargeSpringFestivalTitleItem.New(self.tag02_))
	}

	local var_3_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[SpringFestivalShopData:GetPointActivityId()]

	self.pointRewardList_ = {}
	self.pointDataList_ = {}

	for iter_3_0 = 1, 8 do
		local var_3_1 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, self["point_" .. iter_3_0])

		var_3_1.achieveController_ = var_3_1.achieveCon_:GetController("achieve")
		var_3_1.rewardItem = CommonItemView.New(var_3_1.rewrdItemGo_, true)
		var_3_1.numTxt_.text = ActivityPointRewardCfg[var_3_0[iter_3_0]].need / GameSetting.activity_item_point_conversion.value[1][4]

		local var_3_2 = clone(ItemTemplateData)

		var_3_2.id = ActivityPointRewardCfg[var_3_0[iter_3_0]].reward_item_list[1][1]
		var_3_2.number = ActivityPointRewardCfg[var_3_0[iter_3_0]].reward_item_list[1][2]
		var_3_2.pointRewardData = ActivityPointRewardCfg[var_3_0[iter_3_0]]
		var_3_2.clickFun = handler(self, self.OnClickPointReward)

		var_3_1.rewardItem:SetData(var_3_2)

		self.pointRewardList_[iter_3_0] = var_3_1
		self.pointDataList_[iter_3_0] = ActivityPointRewardCfg[var_3_0[iter_3_0]]
	end
end

function SpringFestivalShopView:SetItem(arg_4_1, arg_4_2)
	self.shopDataList[arg_4_1].checkShopOpen = true
	self.shopDataList[arg_4_1].defaultNumColor = true

	arg_4_2:SetData(self.shopDataList[arg_4_1])
end

function SpringFestivalShopView:AddUIListener()
	self:AddBtnListener(self.tipBtn_, nil, function()
		self.tipsShow_ = true

		self.tipsController_:SetSelectedState(tostring(self.tipsShow_))

		self.pointTipText_.text = GetTips("SANDPLAY_SHOP_TIP_1")

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.pointTipGo_.transform)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.tipsShow_ = false

		self.tipsController_:SetSelectedState(tostring(self.tipsShow_))
	end)
end

function SpringFestivalShopView:GoHome()
	QWorldUIShow()
end

function SpringFestivalShopView:OnEnter()
	self.super.OnEnter(self)
	self:RefreshPoint()
	self:RegistEventListener(SPRING_FESTIVAL_SHOP_UPDATE, handler(self, self.RefreshPoint))

	self.tipsShow_ = false

	self.tipsController_:SetSelectedState(tostring(self.tipsShow_))
end

function SpringFestivalShopView:UpdateTitle()
	self.groupInfo = self.groups[self.groupIndexes[1]]

	for iter_10_0, iter_10_1 in ipairs(self.titleTogList) do
		iter_10_1:SetData(ShopListCfg[self.params_.showShops[iter_10_0]], iter_10_0, handler(self, self.ClickTitle), self.params_.showShops[iter_10_0])

		if not ShopTools.IsShopOpen(self.params_.showShops[iter_10_0]) then
			iter_10_1.lockController_:SetSelectedState("true")
		end
	end

	self:ClickTitle(1)
end

function SpringFestivalShopView:ClickTitle(arg_11_1)
	local var_11_0 = self.params_.showShops[arg_11_1]
	local var_11_1 = ShopListCfg[self.params_.showShops[arg_11_1]]

	if not ShopTools.IsShopOpen(self.params_.showShops[arg_11_1]) then
		SetActive(self.lockGo_, true)

		self.lockDescTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_11_1.activity_id).startTime))

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.concitionTrs_)
	else
		SetActive(self.lockGo_, false)
	end

	self.currentItemIndex_ = arg_11_1
	self.titleTxt_.text = ActivityCfg[var_11_1.activity_id].remark

	if self.selectTitleItem_ then
		self.selectTitleItem_:ShowSelect(false)
	end

	self.selectTitleItem_ = self.titleTogList[arg_11_1]

	self.selectTitleItem_:ShowSelect(true)
	self:UpdateBarByShopId(var_11_0)

	self.params_.shopId = var_11_0
	self.enterTimer = TimeTools.StartAfterSeconds(0.05, function()
		if self.enterTimer == nil then
			return
		end

		self:UpdateShopList(var_11_0)

		self.enterTimer = nil
	end, {})
end

function SpringFestivalShopView:OnClickPointReward(arg_13_1)
	if SpringFestivalShopData:GetTotalPoint() >= arg_13_1.pointRewardData.need and not SpringFestivalShopData:GetIsReceivedReward(arg_13_1.pointRewardData.id) then
		local var_13_0 = ItemTools.GetItemExpiredTimeByID(arg_13_1.pointRewardData.reward_item_list[1][1])

		if ItemCfg[arg_13_1.pointRewardData.reward_item_list[1][1]] and ItemCfg[arg_13_1.pointRewardData.reward_item_list[1][1]].type == 5 and ItemCfg[arg_13_1.pointRewardData.reward_item_list[1][1]].sub_type == 517 then
			JumpTools.OpenPageByJump("springFestivalItemSelectView", {
				popItemInfo = {
					arg_13_1.pointRewardData.reward_item_list[1][1],
					ItemTools.getItemNum(arg_13_1.pointRewardData.reward_item_list[1][1], var_13_0),
					0,
					var_13_0
				},
				selectNum = arg_13_1.pointRewardData.reward_item_list[1][2],
				cfgID = arg_13_1.pointRewardData.id
			})
		else
			SpringFestivalShopAciton.ReceivePointReward(arg_13_1.pointRewardData.id, 0, arg_13_1.pointRewardData.reward_item_list[1][2])
		end
	else
		ShowPopItem(POP_ITEM, {
			arg_13_1.id,
			arg_13_1.number
		})
	end
end

function SpringFestivalShopView:RefreshPoint()
	local var_14_0 = SpringFestivalShopData:GetTotalPoint()

	self.totalPointTxt_.text = math.floor(var_14_0 / GameSetting.activity_item_point_conversion.value[1][4])
	self.firstSlider_.value = var_14_0 >= self.pointDataList_[1].need and 1 or var_14_0 / self.pointDataList_[1].need

	for iter_14_0 = 1, #self.pointRewardList_ do
		local var_14_1 = self.pointRewardList_[iter_14_0]
		local var_14_2 = self.pointDataList_[iter_14_0].need
		local var_14_3

		if self.pointDataList_[iter_14_0 + 1] then
			var_14_3 = self.pointDataList_[iter_14_0 + 1].need or 0
		end

		var_14_1.achieveController_:SetSelectedState(var_14_2 <= var_14_0 and "on" or "off")

		var_14_1.slider_.value = var_14_3 <= var_14_0 and 1 or (var_14_0 - var_14_2) / (var_14_3 - var_14_2)

		local var_14_4 = SpringFestivalShopData:GetIsReceivedReward(self.pointDataList_[iter_14_0].id)

		if var_14_2 <= var_14_0 then
			var_14_1.rewardItem:RefreshCompleted(var_14_4)
			var_14_1.rewardItem:RefreshHighLight(not var_14_4)
		end
	end
end

function SpringFestivalShopView:OnExit()
	self.super.OnExit(self)
end

function SpringFestivalShopView:Dispose()
	self.super.Dispose(self)
end

return SpringFestivalShopView
