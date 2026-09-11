local RechargeEnterView = class("RechargeEnterView", ReduxView)

function RechargeEnterView:UIName()
	return "Widget/System/Recharge/RechargeEnterUI_new"
end

function RechargeEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function RechargeEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeEnterView:InitUI()
	self:BindCfgUI()

	self.bgList_ = {}
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, RechargeEnterListItemView)
end

function RechargeEnterView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.recommendIdList_[arg_5_1])

	if arg_5_2:GetIndex() == self.pageIndex_ then
		arg_5_2:SetSelect(true)
	else
		arg_5_2:SetSelect(false)
	end

	arg_5_2:RegisterClickListener(function(arg_6_0)
		OperationRecorder.RecordButtonTouch("shop_recommend_left_" .. self.recommendIdList_[arg_6_0])

		if self.pageIndex_ ~= arg_6_0 then
			self.uiList_:SwitchToPage(arg_6_0)
			self:OnPageChange(arg_6_0)
		end

		ShopAction.ReadRedPoint(self.recommendIdList_[arg_6_0])
		self.timer_:Reset()
	end)
end

function RechargeEnterView:AddUIListener()
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DAILY_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.rechargeBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("shop_recharge")
		JumpTools.GoToSystem("/rechargeMain", {
			page = 1
		}, ViewConst.SYSTEM_ID.RECHARGE)
	end)
end

function RechargeEnterView:OnPageChange(arg_10_1)
	if self.pageIndex_ == arg_10_1 then
		return
	end

	CustomLog.Log(debug.traceback(string.format("OnPageChange, index = %s", tostring(arg_10_1))))

	if self.bgList_[self.recommendIdList_[self.pageIndex_]] then
		self.bgList_[self.recommendIdList_[self.pageIndex_]]:Hide()
	end

	self.pageIndex_ = arg_10_1

	self.uiList_:Refresh()
	self:UpdatePageView()
end

function RechargeEnterView:UpdatePageView()
	local var_11_0 = self.recommendIdList_[self.pageIndex_]

	self.cfg_ = RechargeRecommendCfg[self.recommendIdList_[self.pageIndex_]]

	if not self.bgList_[var_11_0] then
		self.bgList_[var_11_0] = self:CreatedRecommendBgItem(var_11_0)
	else
		self.bgList_[var_11_0]:Show()
	end

	self.bgList_[var_11_0]:SetData(self.pageIndex_, self.cfg_)

	if self.cfg_.free_dlc_icon ~= "" then
		self.image_.sprite = ItemTools.getItemSprite(self.cfg_.free_dlc_icon[1])

		SetActive(self.littleItemGo_, true)
	else
		SetActive(self.littleItemGo_, false)
	end
end

function RechargeEnterView:CreatedRecommendBgItem(arg_12_1)
	local var_12_0 = Object.Instantiate(Asset.Load("Widget/System/Shop/RechargeShopRecommend/" .. RechargeRecommendCfg[arg_12_1].prefab), self.bgContainer_)

	if RechargeRecommendCfg[arg_12_1].show_type == 1 then
		return RechargeRecommendFukubukuroItemView.New(var_12_0)
	else
		return RechargeRecommendBgItemView.New(var_12_0)
	end
end

function RechargeEnterView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RechargeEnterView:OnEnter()
	self.recommendIdList_ = {}

	for iter_14_0, iter_14_1 in ipairs(RechargeRecommendCfg.all) do
		local var_14_0 = RechargeRecommendCfg[iter_14_1]
		local var_14_1 = not RechargeRecommendCfg[iter_14_1].time[1] or #RechargeRecommendCfg[iter_14_1].time[1][1] < 3 or #RechargeRecommendCfg[iter_14_1].time[1][2] < 3
		local var_14_2 = var_14_0.time[2]

		if not var_14_0.time[2] or #var_14_2[1] < 3 or #var_14_2[2] < 3 then
			var_14_1 = true
		end

		if not var_14_1 then
			local var_14_3 = TimeMgr.GetInstance():parseTimeFromConfig(var_14_0.time[1])
			local var_14_4 = TimeMgr.GetInstance()
			local var_14_5 = TimeMgr.GetInstance():GetServerTime()

			var_14_1 = var_14_5 < var_14_4:parseTimeFromConfig(var_14_0.time[2]) and var_14_3 <= var_14_5
		end

		if var_14_1 then
			table.insert(self.recommendIdList_, iter_14_1)
		end
	end

	table.sort(self.recommendIdList_, function(arg_15_0, arg_15_1)
		return RechargeRecommendCfg[arg_15_0].order < RechargeRecommendCfg[arg_15_1].order
	end)
	self.uiList_:StartScroll(#self.recommendIdList_)
	manager.redPoint:bindUIandKey(self.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:bindUIandKey(self.shopBtn_.transform, RedPointConst.SHOP)
	self:OnPageChange(1)
	self:StartTimer()
	self:RefreshRechargeBtnTag()
end

function RechargeEnterView:OnExit()
	manager.redPoint:unbindUIandKey(self.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:unbindUIandKey(self.shopBtn_.transform, RedPointConst.SHOP)
	manager.windowBar:HideBar()
	self:StopTimer()

	if self.bgList_[self.recommendIdList_[self.pageIndex_]] then
		self.bgList_[self.recommendIdList_[self.pageIndex_]]:Hide()
	end

	self.pageIndex_ = 0
end

function RechargeEnterView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:ScrollToNextPage()
		end, 10, -1)
	end

	self.timer_:Start()
end

function RechargeEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RechargeEnterView:ScrollToNextPage()
	if #self.recommendIdList_ <= 1 then
		return
	end

	local var_20_0 = self.pageIndex_ % #self.recommendIdList_ + 1

	self.uiList_:SwitchToPage(self.pageIndex_ % #self.recommendIdList_ + 1)
	self:OnPageChange(var_20_0)
	CustomLog.Log(debug.traceback(string.format("ScrollToNextPage, newIndex = %s", tostring(var_20_0))))
end

function RechargeEnterView:OnTop()
	self:UpdateBar()
	self:UpdatePageView()
end

function RechargeEnterView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.bgList_ then
		for iter_22_0, iter_22_1 in pairs(self.bgList_) do
			iter_22_1:Dispose()
		end

		self.bgList_ = nil
	end

	RechargeEnterView.super.Dispose(self)
end

function RechargeEnterView:RefreshRechargeBtnTag()
	if ActivityNoobData:IsFirstRechargeNewTag() then
		SetActive(self.rechargeBtnTagGo_, true)

		self.rechargeBtnTagText_.text = GetTips("RECHARGE_WELFARE")
	else
		SetActive(self.rechargeBtnTagGo_, false)
	end
end

return RechargeEnterView
