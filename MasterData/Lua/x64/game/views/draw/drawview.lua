local DrawView = class("DrawView", ReduxView)
local var_0_1 = {
	"DRAW_POOL_TYPE_6",
	"DRAW_POOL_TYPE_3",
	"DRAW_POOL_TYPE_7",
	"DRAW_POOL_TYPE_8",
	"DRAW_POOL_TYPE_1",
	"DRAW_POOL_TYPE_2",
	"DRAW_POOL_TYPE_9"
}
local var_0_2 = {
	5,
	6,
	2,
	nil,
	5,
	1,
	3,
	4,
	7
}
local var_0_3 = {
	[1] = "90",
	[4] = "40"
}
local var_0_4 = {
	[200003] = "WEAPON_DRAW_POOL_RACE_3",
	[200001] = "WEAPON_DRAW_POOL_RACE_1",
	[200009] = "WEAPON_DRAW_POOL_RACE_9",
	[2550996] = "WEAPON_DRAW_POOL_RACE_GODEATER_1",
	[200005] = "WEAPON_DRAW_POOL_RACE_5",
	[200004] = "WEAPON_DRAW_POOL_RACE_4",
	[200002] = "WEAPON_DRAW_POOL_RACE_2",
	[2550997] = "WEAPON_DRAW_POOL_RACE_GODEATER_2"
}
local var_0_5 = {
	[4020201] = true,
	[2550996] = true,
	[2550997] = true
}

function DrawView:OnCtor()
	self.moviePaths = {
		"SofdecAsset/function/blue.usm",
		"SofdecAsset/function/purple.usm",
		"SofdecAsset/function/glod.usm"
	}
end

function DrawView:UIName()
	return "Widget/System/Pool/PoolUI"
end

function DrawView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawView:Init()
	self.poolToggles_ = {}
	self.poolObjects_ = {}
	self.poolActivitys_ = {}
	self.groupRedPoint = {}
	self.drawHandler_ = handler(self, self.DrawCheck)
	self.leftGroupItemList_ = {}
	self.leftToggleItemList_ = {}

	self:InitUI()
	self:AddUIListener()

	self.currencyModifyHandler_ = handler(self, self.CurrencyModify)
end

function DrawView:InitUI()
	self:BindCfgUI()

	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criMovie_:Stop()

	self.moviePlaying = false

	SetActive(self.movieGo_, false)

	self.drawInteract = self.drawInteractGo_:GetComponent("DrawController")

	SetActive(self.drawInteractGo_, false)

	self.showRightController = ControllerUtil.GetController(self.transform_, "showRight")
	self.rechargeShopGiftController = ControllerUtil.GetController(self.transform_, "recharge_shop_gift")
	self.infoController = self.infoController_:GetController("info")
	self.tree_ = LuaTree.New(self.uitreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))
end

function DrawView:AddUIListener()
	self:AddBtnListener(self.btnInfo_, nil, function()
		DrawAction.GetPoolData(self.selectPoolId_)
	end)
	self:AddBtnListener(self.btnShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.btnOnce_, nil, function()
		self:DrawCheck(DrawConst.DRAW_TYPE.ONE)
	end)
	self:AddBtnListener(self.btnTenth_, nil, function()
		if DrawPoolCfg[self.selectPoolId_].pool_type == 8 then
			self:DrawCheck(math.min(40 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10))
		elseif DrawPoolCfg[self.selectPoolId_].pool_type == 9 then
			self:DrawCheck(math.min(70 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10))
		else
			self:DrawCheck(DrawConst.DRAW_TYPE.TEN)
		end
	end)
	self:AddBtnListener(self.btnSkip_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		self:SkipMovie()
	end)
	self:AddBtnListener(self.chooseBtn_, nil, function()
		DrawTools:GoToSelectUpHeroView(self.selectPoolId_, self.showId, true)
	end)
	self:AddBtnListener(self.skipInteractBtn_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		self:SkipInteract()
	end)
	self:AddBtnListener(self.m_giftBtn, nil, function()
		local var_14_0 = 0

		if DrawPoolCfg[self.selectPoolId_].pool_type == 3 then
			var_14_0 = 1
		elseif DrawPoolCfg[self.selectPoolId_].pool_type == 1 then
			var_14_0 = 2
		elseif DrawPoolCfg[self.selectPoolId_].pool_type == 2 then
			var_14_0 = 3
		elseif DrawPoolCfg[self.selectPoolId_].pool_type == 6 then
			var_14_0 = 4
		end

		if var_14_0 ~= 0 then
			OperationRecorder.RecordButtonTouch("draw_gifts_type" .. var_14_0)
		end

		JumpTools.OpenPageByJump("rechargeDrawGift", {
			poolId = self.selectPoolId_
		})
	end)
end

function DrawView:OnTop()
	self:StopMovie()
	self:ShowBar()
	self:UpdatePieceReward()
	self:AddPieceTimer()
	self:AddBonusTimer()
end

function DrawView:AddBonusTimer()
	self:StopBonusTimer()

	if self.bonusView_ then
		self.bonusView_:PrePlayAnimator()
	end

	self.bonusTimer_ = FrameTimer.New(function()
		self:StopBonusTimer()

		if self:IsTop() and not self.drawProcessFlag_ and DrawTools.HasDrawBonusPoolID(DrawTools.GetDrawBonusActivityIDList(), self.selectPoolId_) and self.bonusView_ then
			self.bonusView_:PlayAnimator()
		end
	end, 2, 1)

	self.bonusTimer_:Start()
end

function DrawView:StopBonusTimer()
	if self.bonusTimer_ then
		self.bonusTimer_:Stop()

		self.bonusTimer_ = nil
	end
end

function DrawView:AddPieceTimer()
	self:StopPieceTimer()

	self.pieceTimer_ = FrameTimer.New(function()
		self:StopPieceTimer()

		if self:IsTop() and not self.drawProcessFlag_ and DrawTools.HasDrawPiecePoolID(DrawTools.GetDrawPieceActivityIDList(), self.selectPoolId_) and self.pieceView_ then
			self.pieceView_:CheckCompleteList(self)
		end
	end, 2, 1)

	self.pieceTimer_:Start()
end

function DrawView:StopPieceTimer()
	if self.pieceTimer_ then
		self.pieceTimer_:Stop()

		self.pieceTimer_ = nil
	end
end

function DrawView:OnEnter()
	if self.bonusView_ then
		self.bonusView_:OnEnter()
	end

	SetActive(self.maskGo_, false)

	if self.params_.isFirst then
		self:DestroyPoolGo()

		self.params_.isFirst = nil
	end

	self:SetupActivityPool()

	if self.params_.poolType then
		for iter_22_0, iter_22_1 in ipairs(self.poolToggles_) do
			if DrawPoolCfg[iter_22_1].pool_type ~= self.params_.poolType or var_0_5[iter_22_1] or var_0_5[self.params_.poolId] then
				-- block empty
			else
				self.params_.poolId = iter_22_1
				self.params_.poolType = nil
			end
		end
	end

	local var_22_0 = self.enterPoolId

	if self.params_.poolId then
		if self.poolActivitys_[self.params_.poolId] and ActivityData:GetActivityIsOpen(self.poolActivitys_[self.params_.poolId]) then
			var_22_0 = self.params_.poolId
		end
	end

	self.tree_.tree_.data.groupDatas[self.poolIDToIndexTable[var_22_0][1] - 1].defaultIndex = self.poolIDToIndexTable[var_22_0][2] - 1

	self.tree_:SelectItem(self.poolIDToIndexTable[var_22_0][1], self.poolIDToIndexTable[var_22_0][2])
	DrawTools:LoadDrawLevel()
	manager.ui:SetMainCamera("draw")

	self.panel_.transform.localPosition = Vector2(0, 0)

	manager.notify:RegistListener(CURRENCY_UPDATE, self.currencyModifyHandler_)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	if ShopListCfg[ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP] then
		self.shopText_.text = GetI18NText(ShopListCfg[ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP].remark)
	end

	DrawAction.ClickDrawBonusRedPoint()
end

function DrawView:OnExit()
	self:StopBonusTimer()
	self:StopPieceTimer()
	SetActive(self.maskGo_, false)

	if self.bonusView_ then
		self.bonusView_:OnExit()
	end

	if self.pieceView_ then
		self.pieceView_:OnExit()
	end

	self.drawProcessFlag_ = false

	manager.notify:RemoveListener(CURRENCY_UPDATE, self.currencyModifyHandler_)

	if self.selectPoolId_ and self.selectPoolId_ ~= 0 and self.selectPoolId_ ~= -1 and manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_23_0 = manager.net.tcpConnection_:GetMachineState()

		if var_23_0 and (var_23_0 == "connected" or var_23_0 == "connecting") then
			self:HidePoolNewTag(self.selectPoolId_, true)
		end
	end

	self:DestroyPoolGo()
	manager.windowBar:HideBar()
	self:StopMovie()
	self.criMovie_:Stop()

	if self.curPoolObject then
		self.curPoolObject:SetActive(false)
	end

	self.curPoolObject = nil
	self.selectPoolId_ = -1
	self.timer = nil
	self.one_cost_type = nil
	self.ten_cost_type = nil

	if self.interactTimer then
		self.interactTimer:Stop()

		self.interactTimer = nil
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	self:RemoveCountDownTimer()
	DrawTools:UnLoadDrawLevel()
end

function DrawView:InitTree()
	local var_24_0 = UITreeData.New()
	local var_24_1 = {}

	self.poolIDToIndexTable = {}

	for iter_24_0, iter_24_1 in ipairs(self.poolToggles_) do
		if var_24_1[var_0_2[DrawPoolCfg[iter_24_1].pool_show_type]] == nil then
			var_24_1[var_0_2[DrawPoolCfg[iter_24_1].pool_show_type]] = 1
		end

		self.poolIDToIndexTable[iter_24_1] = {
			var_0_2[DrawPoolCfg[iter_24_1].pool_show_type],
			var_24_1[var_0_2[DrawPoolCfg[iter_24_1].pool_show_type]]
		}
		var_24_1[var_0_2[DrawPoolCfg[iter_24_1].pool_show_type]] = var_24_1[var_0_2[DrawPoolCfg[iter_24_1].pool_show_type]] + 1
	end

	local var_24_2 = {}

	for iter_24_2 = 1, 8 do
		if var_24_1[iter_24_2] then
			var_24_2[iter_24_2] = 1
		end
	end

	local var_24_4 = {}

	for iter_24_3, iter_24_4 in ipairs(var_0_1) do
		var_24_4[iter_24_3] = UITreeGroupData.New()
		var_24_4[iter_24_3].text = GetTips(iter_24_4)
	end

	for iter_24_5, iter_24_6 in ipairs(self.poolToggles_) do
		local var_24_5 = var_0_2[DrawPoolCfg[iter_24_6].pool_show_type]

		self.poolIDToIndexTable[iter_24_6][1] = var_24_2[var_0_2[DrawPoolCfg[iter_24_6].pool_show_type]]
		var_24_4[var_24_5].id = var_24_2[var_24_5]

		local var_24_6 = UITreeItemData.New()

		var_24_6.id = DrawPoolCfg[iter_24_6].id
		var_24_6.text = GetI18NText(DrawPoolCfg[iter_24_6].name)

		if DrawPoolCfg[iter_24_6].pool_show_type == 2 then
			local var_24_7 = DrawData:GetPollUpID(iter_24_6)

			var_24_6.text = GetI18NText(DrawPoolCfg[iter_24_6].name)

			if var_24_7 ~= 0 then
				var_24_6.text = GetTips(var_0_4[var_24_7])
			end
		elseif DrawPoolCfg[iter_24_6].pool_show_type == 8 or DrawPoolCfg[iter_24_6].pool_show_type == 9 or DrawPoolCfg[iter_24_6].pool_show_type == 3 and DrawPoolCfg[iter_24_6].pool_selected_type == 2 then
			local var_24_8 = DrawData:GetPollUpID(iter_24_6)

			var_24_6.text = GetI18NText(DrawPoolCfg[iter_24_6].name)

			if var_24_8 ~= 0 then
				var_24_6.text = GetI18NText(HeroCfg[DrawData:ConvertUpId(iter_24_6, var_24_8, 0)].name) or ""
			end
		elseif DrawPoolCfg[iter_24_6].pool_show_type == 1 then
			local var_24_9 = DrawData:GetPollUpID(iter_24_6)

			var_24_6.text = GetI18NText(DrawPoolCfg[iter_24_6].name)

			if var_24_9 ~= 0 then
				var_24_6.text = GetI18NText(HeroCfg[var_24_9].name) or ""
			end
		end

		if self.poolIDToIndexTable[iter_24_6][1] == 1 and self.poolIDToIndexTable[iter_24_6][2] == 1 then
			self.enterPoolId = iter_24_6
		end

		var_24_4[var_24_5].itemDatas:Add(var_24_6)
	end

	for iter_24_7 = 1, 7 do
		if var_24_4[iter_24_7].itemDatas.Count > 0 then
			var_24_0.groupDatas:Add(var_24_4[iter_24_7])
		end
	end

	self.isFirst = nil

	self.tree_:SetData(var_24_0)

	self.isFirst = true
end

function DrawView:OnGroupSelect(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	self.tree_.tree_.data.groupDatas[arg_25_1 - 1].defaultIndex = 0

	manager.notify:Invoke(DRAW_SELECT_GROUP, arg_25_1)
end

function DrawView:OnItemSelect(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if self.isFirst == nil then
		return
	end

	manager.notify:Invoke(DRAW_SELECT_ITEM, arg_26_1)
	self:HidePoolNewTag(arg_26_2)
	self:SetSelectPool(arg_26_2)
	self.infoController:SetSelectedState("info_1")

	if var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 1 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 2 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 3 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 4 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")

		self.infoController:SetSelectedState("info_3")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 5 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 6 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
	elseif var_0_2[DrawPoolCfg[arg_26_2].pool_show_type] == 7 then
		self.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		self.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		self.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")

		self.infoController:SetSelectedState("info_3")
	end

	if DrawData:GetPollUpID(self.selectPoolId_) == 0 and DrawData:GetPoolIsNew(self.selectPoolId_) == 1 then
		DrawTools:GoToSelectUpHeroView(self.selectPoolId_, self.showId, true)
	end
end

function DrawView:SetupActivityPool()
	self.poolToggles_ = {}

	for iter_27_0, iter_27_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(iter_27_1) then
			if ActivityDrawPoolCfg[iter_27_1] then
				for iter_27_2, iter_27_3 in ipairs(ActivityDrawPoolCfg[iter_27_1].config_list) do
					if DrawPoolCfg[iter_27_3].pool_show_type == 8 then
						if not DrawData:GetNewbieChooseDrawFlag() then
							table.insert(self.poolToggles_, iter_27_3)

							self.poolActivitys_[iter_27_3] = iter_27_1
						end
					elseif DrawPoolCfg[iter_27_3].pool_show_type == 9 then
						if RegressionDataNew:CheckIsOpenRuturnPool() then
							table.insert(self.poolToggles_, iter_27_3)

							self.poolActivitys_[iter_27_3] = iter_27_1
						end
					else
						table.insert(self.poolToggles_, iter_27_3)

						self.poolActivitys_[iter_27_3] = iter_27_1
					end
				end
			end
		end
	end

	if #self.poolToggles_ == 0 then
		Debugger.LogError("draw error pools is empty")
	end

	table.sort(self.poolToggles_, function(arg_28_0, arg_28_1)
		if DrawPoolCfg[arg_28_0].order == DrawPoolCfg[arg_28_1].order then
			return arg_28_1 < arg_28_0
		else
			return DrawPoolCfg[arg_28_0].order < DrawPoolCfg[arg_28_1].order
		end
	end)
	self:ClearLeftToggle()
	self:InitTree()
	self:InitPoolNew()
	self:InitLeftToggle()
end

function DrawView:InitPoolNew()
	for iter_29_0, iter_29_1 in ipairs(self.poolToggles_) do
		if DrawData:GetPoolIsNew(iter_29_1) == 1 then
			self:SetNewTag(true, iter_29_1)
		end
	end
end

function DrawView:HidePoolNewTag(arg_30_1, arg_30_2)
	if self.selectPoolId_ ~= -1 and self.selectPoolId_ ~= nil and self.selectPoolId_ ~= arg_30_1 and DrawData:GetPoolIsNew(self.selectPoolId_) == 1 or arg_30_2 then
		DrawAction.HidePoolNewTag(self.selectPoolId_, handler(self, self.SetNewTag))
	end
end

function DrawView:SetNewTag(arg_31_1, arg_31_2)
	if not self.poolIDToIndexTable[arg_31_2] then
		return
	end

	if not self.tree_ then
		return
	end

	local var_31_0 = self.poolIDToIndexTable[arg_31_2][1]
	local var_31_1 = self.tree_:GetGroupRedPointContainerById(self.poolIDToIndexTable[arg_31_2][1])
	local var_31_2 = self.tree_:GetItemRedPointContainerById(self.poolIDToIndexTable[arg_31_2][1], arg_31_2)

	if var_31_1 == nil or var_31_2 == nil then
		return
	end

	if arg_31_1 then
		self.groupRedPoint[var_31_0] = self.groupRedPoint[var_31_0] or {}
		self.groupRedPoint[var_31_0][self.poolIDToIndexTable[arg_31_2][2]] = arg_31_2
	else
		self.groupRedPoint[var_31_0][self.poolIDToIndexTable[arg_31_2][2]] = nil

		if not next(self.groupRedPoint[var_31_0]) then
			self.groupRedPoint[var_31_0] = nil
		end

		if not next(self.groupRedPoint) then
			manager.redPoint:setTip(RedPointConst.DRAW, 0, RedPointStyle.SHOW_NEW_TAG)

			self.groupRedPoint = {}
		end
	end

	manager.redPoint:setRedPoint({
		display = var_31_1
	}, self.groupRedPoint[var_31_0] and next(self.groupRedPoint[var_31_0]), RedPointStyle.SHOW_NEW_TAG)
	manager.redPoint:setRedPoint({
		display = var_31_2
	}, arg_31_1, RedPointStyle.SHOW_NEW_TAG)
end

function DrawView:InitLeftToggle()
	local var_32_0 = self.tree_:GetData().groupDatas

	for iter_32_0 = 0, var_32_0.Count - 1 do
		self.leftGroupItemList_[iter_32_0 + 1] = self.leftGroupItemList_[iter_32_0 + 1] or DrawLeftToggleGroupItem.New((self.tree_:GetGroupGameObjectById(var_32_0[iter_32_0].id)))

		local var_32_2 = {}

		for iter_32_1 = 0, var_32_0[iter_32_0].itemDatas.Count - 1 do
			self.leftToggleItemList_[1] = self.leftToggleItemList_[1] or DrawLeftToggleItem.New((self.tree_:GetItemGameObjectById(var_32_0[iter_32_0].id, var_32_0[iter_32_0].itemDatas[iter_32_1].id)))

			self.leftToggleItemList_[1]:SetData(var_32_0[iter_32_0].itemDatas[iter_32_1].id, iter_32_1 + 1)
			table.insert(var_32_2, var_32_0[iter_32_0].itemDatas[iter_32_1].id)
		end

		self.leftGroupItemList_[iter_32_0 + 1]:SetData(var_32_2, iter_32_0 + 1)
	end
end

function DrawView:ClearLeftToggle()
	for iter_33_0 = #self.leftToggleItemList_, 1, -1 do
		self.leftToggleItemList_[iter_33_0]:Dispose()

		self.leftToggleItemList_[iter_33_0] = nil
	end

	for iter_33_1 = #self.leftGroupItemList_, 1, -1 do
		self.leftGroupItemList_[iter_33_1]:Dispose()

		self.leftGroupItemList_[iter_33_1] = nil
	end
end

function DrawView:RefreshActivityPool()
	self:SetupActivityPool()

	if not table.indexof(self.poolToggles_, self.selectPoolId_) then
		self.selectPoolId_ = self.poolToggles_[1]

		self:RefreshUI()
	end
end

function DrawView:SetSelectPool(arg_35_1)
	if not table.indexof(self.poolToggles_, arg_35_1) then
		return
	end

	if arg_35_1 == self.selectPoolId_ then
		return
	end

	self.selectPoolId_ = arg_35_1
	self.params_.poolId = arg_35_1

	self:RefreshUI()
end

function DrawView:ShowBar()
	local var_36_0 = DrawTools.GetCostTicketList(self.selectPoolId_)
	local var_36_1 = DrawTools.GetActivityCostTicket(self.selectPoolId_)
	local var_36_2 = {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}

	if var_36_1 == 0 or ItemTools.IsItemExpiredByItemId(var_36_1) then
		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			table.insert(var_36_2, iter_36_1)
		end

		table.insertto(var_36_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_36_2)
	elseif var_36_1 == InviteData:GetDataByPara("drawItemId") then
		for iter_36_2, iter_36_3 in ipairs(var_36_0) do
			table.insert(var_36_2, iter_36_3)
		end

		table.insertto(var_36_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_36_2)
	else
		if ItemTools.getItemNum(var_36_1) > 0 then
			table.insert(var_36_2, var_36_1)
		end

		for iter_36_4, iter_36_5 in ipairs(var_36_0) do
			table.insert(var_36_2, iter_36_5)
		end

		table.insertto(var_36_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_36_2)

		if ItemTools.getItemNum(var_36_1) > 0 then
			manager.windowBar:SetBarCanAdd(var_36_1, false)
			manager.windowBar:SetBarCanClick(var_36_1, true)
		end
	end

	manager.windowBar:RegistBackCallBack(function()
		DrawData:ResetServantRedPoint()
		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DrawData:ResetServantRedPoint()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)

	for iter_36_6, iter_36_7 in pairs(var_36_0) do
		manager.windowBar:SetBarCanAdd(iter_36_7, false)
		manager.windowBar:SetBarCanClick(iter_36_7, true)
	end
end

function DrawView:RefreshUI()
	local var_39_0 = DrawPoolCfg[self.selectPoolId_]
	local var_39_1 = self.selectPoolId_

	self:UpdateFirstSelectButton(true)

	if var_39_0.pool_selected_type == 9 then
		local var_39_2 = DrawData:GetPollUpID(self.selectPoolId_)

		if var_39_2 == 0 and self.selectPoolId_ == DrawConst.WEAPON_SERVANT_POOL_ID then
			self:UpdateFirstSelectButton(false)

			var_39_1 = -1
		elseif var_39_2 == 0 and self.selectPoolId_ ~= DrawConst.WEAPON_SERVANT_POOL_ID then
			self:UpdateFirstSelectButton(false)

			var_39_1 = -2
		else
			var_39_1 = var_39_2
		end
	elseif var_39_0.pool_selected_type == 2 or var_39_0.pool_selected_type == 8 then
		if DrawData:GetPollUpID(self.selectPoolId_) == 0 then
			if var_39_0.pool_change == 0 or DrawData:GetPoolUpTimes(self.selectPoolId_) < var_39_0.pool_change then
				self.timer = TimeTools.StartAfterSeconds(0.02, function(arg_40_0)
					if self.timer == nil then
						return
					end

					if DrawData:IsOnePrefabPool(arg_40_0) then
						self:UpdateFirstSelectButton(false)
					else
						self:Go("/drawHeroSelect", {
							poolId = self.selectPoolId_
						})
					end

					self.timer = nil
				end, {
					self.selectPoolId_
				})
			end
		end
	elseif var_39_0.pool_selected_type == 1 and DrawData:GetPollUpID(self.selectPoolId_) == 0 then
		self.timer = TimeTools.StartAfterSeconds(0.02, function(arg_41_0)
			if self.timer == nil then
				return
			end

			if DrawData:IsOnePrefabPool(arg_41_0) then
				self:UpdateFirstSelectButton(false)
			end

			self.timer = nil
		end, {
			self.selectPoolId_
		})
	end

	if var_39_0.pool_type == 8 then
		self.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(40 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10))))
		self.tips3Text_.text = GetTips("DRAW_POOL_SCREEN_TYPE_3")
		self.tenIconText_.text = "x" .. math.min(40 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10)
	elseif var_39_0.pool_type == 9 then
		self.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(70 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10))))
		self.tips3Text_.text = GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_1")
		self.tenIconText_.text = "x" .. math.min(70 - DrawData:GetPoolDrawTimes(self.selectPoolId_), 10)
	else
		self.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), GetTips("NUM_10"))
		self.tenIconText_.text = "x10"
	end

	if self.curPoolObject then
		if self.curPoolObject:GetShowId() == var_39_1 then
			self.curPoolObject:Refresh(var_39_1)
			self:RefreshRightPanel()

			return
		else
			self.curPoolObject:SetActive(false)
		end
	end

	self.showId = var_39_1
	self.poolObjects_[var_39_1] = self.poolObjects_[var_39_1] or var_39_0.pool_type == 1 and (DrawData:IsOnePrefabPool(self.selectPoolId_) and DrawRolePoolContainer.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1) or DrawNormalPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)) or (var_39_0.pool_selected_type == 2 or var_39_0.pool_selected_type == 8) and (DrawData:IsOnePrefabPool(self.selectPoolId_) and (var_39_0.pool_type == 9 and ReturnDrawSelectPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1) or var_39_0.pool_selected_type == 8 and NewbieDrawSelectPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1) or DrawSelectPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)) or DrawUpPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)) or var_39_0.pool_selected_type == 9 and self.selectPoolId_ == DrawConst.WEAPON_SERVANT_POOL_ID and (DrawData:GetPollUpID(self.selectPoolId_) == var_39_1 and DrawServantPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1) or DrawServantNormalPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)) or var_39_0.pool_selected_type == 9 and self.selectPoolId_ ~= DrawConst.WEAPON_SERVANT_POOL_ID and (DrawData:GetPollUpID(self.selectPoolId_) == var_39_1 and GodEaterDrawServantPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1) or GodEaterDrawServantNormalPool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)) or DrawBasePool.New(self.poolcontentTrs_, self.selectPoolId_, var_39_1)
	self.curPoolObject = self.poolObjects_[var_39_1]

	for iter_39_0, iter_39_1 in pairs(self.poolObjects_) do
		if var_39_1 ~= iter_39_0 then
			iter_39_1:Dispose()

			self.poolObjects_[iter_39_0] = nil
		end
	end

	self.curPoolObject:Refresh(var_39_1)
	self.curPoolObject:SetActive(true)
	self:OnRequestRecord()
	self:RefreshRightPanel()

	if self.poolActivitys_[self.selectPoolId_] and ActivityData:GetActivityData(self.poolActivitys_[self.selectPoolId_]) then
		local var_39_3 = ActivityData:GetActivityData(self.poolActivitys_[self.selectPoolId_]).stopTime

		self:SetCountDown(var_39_3 ~= 0, var_39_3)
	else
		self:SetCountDown(false)
	end

	self:ShowBar()

	if #DrawTools.GetRechargeDrawGiftList(self.selectPoolId_) == 0 then
		self.rechargeShopGiftController:SetSelectedIndex(0)
	else
		self.rechargeShopGiftController:SetSelectedIndex(1)
	end

	self:UpdateFreeDraw()
	self:UpdateBonus()
	self:UpdatePieceReward()
end

function DrawView:OnRequestRecord()
	local var_42_0 = DrawData:GetDrawRecord(self.selectPoolId_)

	if var_42_0 then
		local var_42_1 = var_0_3[var_0_2[DrawPoolCfg[self.selectPoolId_].pool_show_type]] or "70"

		self.drawOutLineTxt_.text = var_42_0.ssr_draw_times
		self.drawTxt_.text = "/" .. var_42_1
		self.drawAllTxt_.text = var_42_0.ssr_draw_times
		self.drawOutLineTxt1_.text = var_42_0.ssr_draw_times
		self.drawTxt1_.text = "/" .. var_42_1
		self.drawAllTxt1_.text = var_42_0.ssr_draw_times
	else
		DrawAction.RequestRecord(self.selectPoolId_)
	end
end

function DrawView:UpdateFreeDraw()
	local var_43_0 = InviteData:GetDataByPara("poolID")
	local var_43_1 = InviteData:GetDataByPara("drawItemId")
	local var_43_2 = DrawPoolCfg[var_43_0]

	SetActive(self.freeGo_, self.selectPoolId_ == var_43_0 and ItemTools.getItemNum(var_43_1) > 0)

	if var_43_2 == nil then
		return
	end

	local var_43_3 = self.tree_:GetGroupRedPointContainerById(var_0_2[var_43_2.pool_show_type])

	if var_43_3 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_43_3
	}, ItemTools.getItemNum(var_43_1) > 0)

	local var_43_4 = self.tree_:GetItemRedPointContainerById(var_0_2[var_43_2.pool_show_type], var_43_0)

	if var_43_4 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_43_4
	}, ItemTools.getItemNum(var_43_1) > 0)
end

function DrawView:RefreshRightPanel()
	if not self.curPoolObject then
		return
	end

	if self.curPoolObject:ShowRightPanel() then
		local var_44_0 = DrawTools.GetActivityCostTicket(self.selectPoolId_)

		if var_44_0 ~= 0 and not ItemTools.IsItemExpiredByItemId(var_44_0) then
			if ItemTools.getItemNum(var_44_0) == 0 then
				self.iconOnce_.sprite = ItemTools.getItemSprite((DrawTools.GetCostTicket(self.selectPoolId_, 1)))
				self.iconTenth_.sprite = ItemTools.getItemSprite((DrawTools.GetCostTicket(self.selectPoolId_, 10)))
				self.one_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
				self.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON

				goto label_44_0
			end
		end

		self.iconOnce_.sprite = ItemTools.getItemSprite(var_44_0)
		self.one_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY

		do
			local var_44_1 = ItemTools.getItemNum(var_44_0)
			local var_44_2 = 10

			if DrawPoolCfg[self.selectPoolId_].pool_type == 8 then
				var_44_2 = math.min(40 - DrawData:GetPoolDrawTimes(self.selectPoolId_), var_44_2)
			elseif DrawPoolCfg[self.selectPoolId_].pool_type == 9 then
				var_44_2 = math.min(70 - DrawData:GetPoolDrawTimes(self.selectPoolId_), var_44_2)
			end

			if var_44_1 < var_44_2 then
				self.iconTenth_.sprite = ItemTools.getItemSprite((DrawTools.GetCostTicket(self.selectPoolId_, 10)))
				self.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			else
				self.iconTenth_.sprite = ItemTools.getItemSprite(var_44_0)
				self.ten_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY
			end
		end

		::label_44_0::

		self.showRightController:SetSelectedIndex(1)
	else
		self.showRightController:SetSelectedIndex(0)
	end
end

function DrawView:UpdateBonus()
	local var_45_0 = DrawTools.HasDrawBonusPoolID(DrawTools.GetDrawBonusActivityIDList(), self.selectPoolId_)

	if var_45_0 then
		if self.bonusView_ == nil then
			self.bonusView_ = DrawRightBonusItem.New(self.rightGo_)

			self.bonusView_:OnEnter()
		end

		self.bonusView_:SetData(var_45_0, self.selectPoolId_)
	elseif self.bonusView_ then
		self.bonusView_:Show(false)
	end
end

function DrawView:UpdatePieceReward()
	local var_46_0 = DrawTools.HasDrawPiecePoolID(DrawTools.GetDrawPieceActivityIDList(), self.selectPoolId_)

	if var_46_0 then
		if self.pieceView_ == nil then
			self.pieceView_ = DrawRightPieceItem.New(self.rightGo_)

			self.pieceView_:OnEnter()
		end

		self.pieceView_:SetData(var_46_0, self.selectPoolId_)
	elseif self.pieceView_ then
		self.pieceView_:Show(false)
	end
end

function DrawView:DestroyPoolGo()
	for iter_47_0, iter_47_1 in pairs(self.poolObjects_) do
		iter_47_1:Dispose()
	end

	self.poolObjects_ = {}
end

function DrawView:SetCountDown(arg_48_1, arg_48_2)
	self.activityEndTime_ = arg_48_2

	if arg_48_1 then
		self.activityTimer_ = self.activityTimer_ or Timer.New(handler(self, self.UpdateCountDownText), 1, -1)

		self:UpdateCountDownText()
		self.curPoolObject:ShowCountDownText(true)
		self.activityTimer_:Start()
	else
		self.curPoolObject:ShowCountDownText(false)

		if self.activityTimer_ then
			self.activityTimer_:Stop()
		end
	end
end

function DrawView:UpdateCountDownText()
	self.curPoolObject:SetCountDownText(self.activityEndTime_)
end

function DrawView:RemoveCountDownTimer()
	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

function DrawView:DrawCheck(arg_51_1)
	if WeaponServantData:GetServantNum() >= GameSetting.max_weapon_servant.value[1] then
		ShowMessageBox({
			content = GetTips("SERVANT_NUM_MAX"),
			BtnText = {
				nil,
				GetTips("SCAN_TIPS_1"),
				GetTips("SCAN_TIPS_2")
			},
			OkCallback = function()
				JumpTools.OpenPageByJump("/weaponServantList")
			end,
			CancelCallback = function()
				self:StartDraw(arg_51_1)
			end
		})
	else
		self:StartDraw(arg_51_1)
	end
end

function DrawView:StartDraw(arg_54_1)
	local var_54_0 = DrawPoolCfg[self.selectPoolId_]
	local var_54_1
	local var_54_2
	local var_54_4

	if DrawConst.DRAW_TYPE.ONE == arg_54_1 then
		var_54_1 = self.one_cost_type
		var_54_2 = 1
		var_54_4 = 1
	elseif DrawConst.DRAW_TYPE.TEN == arg_54_1 then
		var_54_1 = self.ten_cost_type
		var_54_2 = 10

		if var_54_0.discount > 0 then
			var_54_2 = var_54_2 * var_54_0.discount / 100
		end

		var_54_4 = 10
	else
		var_54_1 = self.ten_cost_type
		var_54_2 = arg_54_1

		if var_54_0.discount > 0 then
			var_54_2 = var_54_2 * var_54_0.discount / 100
		end

		var_54_4 = arg_54_1
	end

	local var_54_5 = 0

	if DrawConst.DRAW_COST_TYPE.COMMON == var_54_1 then
		var_54_5 = DrawTools.GetCostTicket(self.selectPoolId_, var_54_2)

		local var_54_6 = ItemTools.getItemNum(var_54_5)

		if var_54_6 < var_54_2 then
			self.shopDrawInfo = {
				poolId = self.selectPoolId_,
				draw_type = arg_54_1,
				cost_id = var_54_5,
				cost_num = var_54_2
			}

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_gacha_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
			})
			self:ShowBuyView(var_54_2 - var_54_6, var_54_0)

			return
		end
	elseif DrawConst.DRAW_COST_TYPE.ACTIVITY == var_54_1 then
		var_54_5 = DrawTools.GetActivityCostTicket(self.selectPoolId_)

		if ItemTools.IsItemExpiredByItemId(var_54_5) then
			ShowTips("TIP_EXPIRED")
			self:RefreshActivityPool()
			self:RefreshUI()

			return
		end

		if var_54_2 > ItemTools.getItemNum(var_54_5) then
			error("draw activity tick num error")

			return
		end
	end

	if not SDKTools.GetIsOverSea() and var_54_4 + DrawData:GetTodayDrawTimes() > GameSetting.draw_num_max.value[1] then
		ShowTips("DRAW_NUM_MAX")

		return
	end

	DrawData:SetNewHeroFlag(false)

	if _G.SkipTip["DrawSkipTip" .. self.selectPoolId_] or InviteData:GetDataByPara("drawItemId") == var_54_5 then
		manager.achievementTips:SetShowFlag(false)
		DrawAction.GoToDraw(self.selectPoolId_, arg_54_1, var_54_5, var_54_2)
	else
		JumpTools.OpenPageByJump("popCostItem", {
			costId = var_54_5,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				manager.achievementTips:SetShowFlag(false)
				DrawAction.GoToDraw(self.selectPoolId_, arg_54_1, var_54_5, var_54_2)
			end,
			ToggleCallback = function(arg_56_0)
				_G.SkipTip["DrawSkipTip" .. self.selectPoolId_] = arg_56_0
			end,
			content = string.format(GetTips("DRAW_TIMES"), ItemTools.getItemName(var_54_5), var_54_2, var_54_2)
		})
	end
end

function DrawView:ShowBuyView(arg_57_1, arg_57_2)
	local var_57_0 = getShopCfg(arg_57_2.exchange_id)
	local var_57_1 = {}
	local var_57_2 = {}
	local var_57_3 = math.min(ItemTools.getItemNum(var_57_0.cost_id), var_57_0.cost * arg_57_1)

	if var_57_3 > 0 then
		var_57_1 = {
			id = var_57_0.cost_id,
			num = var_57_3
		}
	end

	local var_57_4 = var_57_0.cost * arg_57_1 - var_57_3

	if var_57_0.cost * arg_57_1 - var_57_3 > 0 then
		var_57_2 = {
			id = CurrencyConst.GetPlatformDiamondId(),
			num = var_57_4
		}
	end

	if not var_57_1.id and var_57_2.id then
		var_57_1 = var_57_2
		var_57_2 = {}
	end

	JumpTools.OpenPageByJump("itemBuy", {
		title = GetTips("TREASURE_TICKET_TO_BUY"),
		item1 = {
			id = DrawTools.GetCostTicket(arg_57_2.id, arg_57_1),
			num = arg_57_1
		},
		item2 = var_57_1,
		item3 = var_57_2,
		OkCallback = function()
			if var_57_4 > 0 and CurrencyData:GetRechargeDiamond() < var_57_4 then
				if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
					ShopTools.DiamondEnoughMessageBox()
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
				end

				return
			end

			ShopAction.BuyItem({
				{
					goodID = arg_57_2.exchange_id,
					buyNum = arg_57_1
				}
			}, nil, PayConst.BUY_SOURCE_DRAW_POPUP)
		end,
		CancelCallback = function()
			self.shopDrawInfo = nil
		end
	})
end

function DrawView:OnShopBuyResult(arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	if arg_60_1 == 0 then
		if self.shopDrawInfo == nil then
			return
		end

		self:Back()
		manager.achievementTips:SetShowFlag(false)

		if self.poolActivitys_[self.shopDrawInfo.poolId] and ActivityData:GetActivityIsOpen(self.poolActivitys_[self.shopDrawInfo.poolId]) then
			DrawAction.GoToDraw(self.shopDrawInfo.poolId, self.shopDrawInfo.draw_type, self.shopDrawInfo.cost_id, self.shopDrawInfo.cost_num)
		end

		self.shopDrawInfo = nil
	else
		if arg_60_1 then
			ShowTips(arg_60_1)
		end

		self.shopDrawInfo = nil
	end
end

function DrawView:OnGoToDraw(arg_61_1, arg_61_2)
	if arg_61_1.result == 0 then
		self.drawProcessFlag_ = true

		local var_61_0 = {}
		local var_61_1 = 0

		for iter_61_0, iter_61_1 in ipairs(arg_61_1.item) do
			DrawData:TodayDrawTimesChange(1)
			table.insert(var_61_0, formatReward(iter_61_1))

			if ItemCfg[iter_61_1.id] then
				local var_61_2 = ItemCfg[iter_61_1.id].display_rare or 0

				if var_61_1 < var_61_2 then
					var_61_1 = var_61_2
				end
			end
		end

		self:RefreshUI()
		manager.windowBar:HideBar()

		self.itemList_ = var_61_0

		self:CheckInteract(var_61_1)
	else
		ShowTips(arg_61_1.result)
		self:RefreshActivityPool()
		self.tree_:SelectItem(self.poolIDToIndexTable[self.selectPoolId_][1], self.poolIDToIndexTable[self.selectPoolId_][2])
		manager.achievementTips:SetShowFlag(true)
	end

	self.shopDrawInfo = nil
end

function DrawView:JumpToReward()
	self.drawProcessFlag_ = false

	manager.achievementTips:SetShowFlag(true)

	if #self.itemList_ > 0 then
		local var_62_0 = {}
		local var_62_1 = {}

		for iter_62_0, iter_62_1 in ipairs(self.itemList_) do
			local var_62_2 = setmetatable({
				index = iter_62_0
			}, {
				__index = iter_62_1
			})

			if ItemCfg[iter_62_1.id].type == ItemConst.ITEM_TYPE.HERO then
				var_62_2.newTag = true
				var_62_1[iter_62_1.id] = true

				DrawData:SetNewHeroFlag(true)
			elseif ItemCfg[iter_62_1.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				var_62_2.newTag = IllustratedData:GetNewObtainedServant(iter_62_1.id) ~= nil

				if var_62_2.newTag and ItemCfg[iter_62_1.id].rare >= 5 then
					DrawData:SetServantRedPoint(self.selectPoolId_, 1)
				end
			end

			table.insert(var_62_0, var_62_2)
		end

		local var_62_3 = 0

		for iter_62_2, iter_62_3 in ipairs(self.itemList_) do
			if ItemCfg[iter_62_3.id].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[iter_62_3.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or ItemCfg[iter_62_3.id].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				local var_62_5 = ItemCfg[(ItemWillConvert(iter_62_3) or nil) and iter_62_3.convert_from.id].rare

				for iter_62_4, iter_62_5 in ipairs(GameSetting.currency_for_draw.value) do
					if var_62_5 == iter_62_5[1] then
						var_62_3 = var_62_3 + iter_62_5[2]
					end
				end
			end
		end

		if #self.itemList_ ~= 1 then
			gameContext:Go("drawTenTimesReward", {
				reward = var_62_0,
				callBack_afterTen = function()
					getReward({
						{
							id = ItemConst.CURRENCY_FOR_DRAW,
							num = var_62_3
						}
					}, nil, function()
						local var_64_0 = DrawPoolCfg[self.selectPoolId_]

						if DrawPoolCfg[self.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() or var_64_0.pool_type == 9 and not RegressionDataNew:CheckIsOpenRuturnPool() then
							if var_64_0.pool_type == 9 then
								ShowTips("NEW_REGRESSION__POOL_SCREEN_TYPE_4")
							else
								ShowTips("DRAW_POOL_SCREEN_TYPE_1")
							end

							self:SetupActivityPool()

							self.tree_.tree_.data.groupDatas[1].defaultIndex = 1

							self.tree_:SelectItem(1, 1)
						end
					end)
					self:ShowBar()
				end
			})
		else
			local var_62_6 = DrawPoolCfg[self.selectPoolId_]

			if DrawPoolCfg[self.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() or var_62_6.pool_type == 9 and not RegressionDataNew:CheckIsOpenRuturnPool() then
				if var_62_6.pool_type == 9 then
					ShowTips("NEW_REGRESSION__POOL_SCREEN_TYPE_4")
				else
					ShowTips("DRAW_POOL_SCREEN_TYPE_1")
				end

				self:SetupActivityPool()

				self.tree_.tree_.data.groupDatas[1].defaultIndex = 1

				self.tree_:SelectItem(1, 1)
			end

			self:ShowBar()
		end
	end

	self:UpdateFreeDraw()
	self:OnRequestRecord()
end

function DrawView:SkipMovie()
	self.criplayer_.statusChangeCallback = nil

	if self.moviePlaying then
		self.criMovie_:Stop()
	end

	self:DoNextNode(true)
end

local function var_0_6(arg_66_0)
	local var_66_0

	if ItemWillConvert(arg_66_0) then
		var_66_0 = arg_66_0.convert_from.id or arg_66_0.id
	end

	print("BuildShowItemInfo", arg_66_0.convert_from.id, arg_66_0.id)

	local var_66_1 = {}

	if ItemCfg[var_66_0].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[var_66_0].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_66_2 = ItemCfg[var_66_0].rare

		for iter_66_0, iter_66_1 in ipairs(GameSetting.currency_for_draw.value) do
			if var_66_2 == iter_66_1[1] then
				var_66_1.draw_rebate = iter_66_1[2]
			end
		end
	end

	return setmetatable(var_66_1, {
		__index = arg_66_0
	})
end

function DrawView:DoNextNode(arg_67_1)
	self.panel_.transform.localPosition = Vector2(0, 0)

	local var_67_0 = #self.itemList_

	if arg_67_1 and var_67_0 > 1 then
		local var_67_1 = {}

		for iter_67_0, iter_67_1 in ipairs(self.itemList_) do
			if ItemCfg[iter_67_1.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[iter_67_1.id] then
				if not (getData(DrawConst.WATCH_TAG, tostring(iter_67_1.id)) or false) then
					table.insert(var_67_1, var_0_6(iter_67_1))
				end
			end
		end

		if #var_67_1 == 0 then
			self:JumpToReward()
		else
			local var_67_2 = handler(self, self.JumpToReward)

			self:Go("obtainView", {
				doNextHandler = var_67_2,
				skipHandler = var_67_2,
				itemList = var_67_1
			})
		end

		return
	end

	if var_67_0 > 0 then
		local var_67_3 = {}

		for iter_67_2, iter_67_3 in ipairs(self.itemList_) do
			if var_67_0 == 1 and ItemCfg[(ItemWillConvert(iter_67_3) or nil) and (iter_67_3.convert_from.id or iter_67_3.id)].type == ItemConst.ITEM_TYPE.HERO and ItemWillConvert(iter_67_3) then
				DrawData:SetNewHeroFlag(true)
			end

			table.insert(var_67_3, var_0_6(iter_67_3))
		end

		self:Go("obtainView", {
			doNextHandler = handler(self, self.JumpToReward),
			skipHandler = handler(self, self.JumpToReward),
			itemList = var_67_3
		})
	else
		self:JumpToReward()
	end
end

function DrawView:PlayMovie(arg_68_1)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self.criMovie_:Play()

	self.criplayer_.statusChangeCallback = handler(self, self.CirMovieStatusChange)
	self.moviePlaying = true

	if arg_68_1 >= 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif arg_68_1 >= 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	manager.audio:PlayEffect("ui_system_search", "search_animation", "")
	SetActive(self.movieGo_, true)
end

function DrawView:CirMovieStatusChange(arg_69_1)
	local var_69_0 = tostring(arg_69_1)

	if var_69_0 == "PlayEnd" or var_69_0 == "Stop" then
		self:DoNextNode(false)
	end
end

function DrawView:StopMovie()
	self.criplayer_.statusChangeCallback = nil
	self.moviePlaying = false

	SetActive(self.movieGo_, false)
end

function DrawView:SkipInteract()
	SetActive(self.drawInteractGo_, false)

	if self.drawInteract.timeline then
		self.drawInteract.timeline:Stop()
	end

	self:DoNextNode(true)
end

function DrawView:CheckInteract(arg_72_1)
	self.maxRare = arg_72_1

	if not DrawTools:LevelIsDone() then
		SetForceShowQuanquan(true)

		if self.interactTimer then
			self.interactTimer:Stop()

			self.interactTimer = nil
		end

		self.interactTimer = FrameTimer.New(handler(self, self.WaitInteract), 1, -1)

		self.interactTimer:Start()
	else
		self:StarInteract()
	end
end

function DrawView:WaitInteract()
	if DrawTools:LevelIsDone() then
		SetForceShowQuanquan(false)

		if self.interactTimer then
			self.interactTimer:Stop()

			self.interactTimer = nil
		end

		self:StarInteract()
	end
end

function DrawView:StarInteract()
	local var_74_0 = self.maxRare or 0

	if var_74_0 >= 5 then
		SetFile(self.criplayer_, nil, self.moviePaths[3])
	elseif var_74_0 >= 4 then
		SetFile(self.criplayer_, nil, self.moviePaths[2])
	else
		SetFile(self.criplayer_, nil, self.moviePaths[1])
	end

	local var_74_1 = var_74_0 >= 5 and GameObject.Find("X102/TC/directors/director_gold") or var_74_0 >= 4 and GameObject.Find("X102/TC/directors/director_purple") or GameObject.Find("X102/TC/directors/director_blue")

	if var_74_1 then
		self.drawInteract:Init(var_74_1:GetComponent("PlayableDirector"), handler(self, self.StopInteract))
		self.drawInteract:Reset()

		self.panel_.transform.localPosition = Vector2(9999, 9999)

		SetActive(self.drawInteractGo_, true)
	else
		self:StopInteract()
	end

	if self.selectPoolId_ and self.selectPoolId_ ~= 0 and self.selectPoolId_ ~= -1 then
		self:HidePoolNewTag(self.selectPoolId_, true)
	end
end

function DrawView:StopInteract()
	SetActive(self.drawInteractGo_, false)
	self:PlayMovie(self.maxRare or 0)
end

function DrawView:Dispose()
	for iter_76_0, iter_76_1 in ipairs(self.leftToggleItemList_) do
		iter_76_1:Dispose()
	end

	self.leftToggleItemList_ = nil

	for iter_76_2, iter_76_3 in ipairs(self.leftGroupItemList_) do
		iter_76_3:Dispose()
	end

	self.leftGroupItemList_ = nil

	if self.bonusView_ then
		self.bonusView_:Dispose()

		self.bonusView_ = nil
	end

	self.currencyModifyHandler_ = nil
	self.timer = nil

	self:DestroyPoolGo()
	self.tree_:Dispose()

	self.drawHandler_ = nil

	DrawView.super.Dispose(self)
end

function DrawView:CurrencyModify()
	self:RefreshRightPanel()
end

function DrawView:UpdateFirstSelectButton(arg_78_1)
	SetActive(self.chooseBtn_.gameObject, not arg_78_1)
	SetActive(self.btnOnce_.gameObject, arg_78_1)
	SetActive(self.btnTenth_.gameObject, arg_78_1)

	self.chooseText_.text = GetTips(DrawPoolCfg[self.selectPoolId_].pool_selected_type == 9 and "DRAW_WEAPON_BUTTON" or "DRAW_CHARACTER_BUTTON")
end

function DrawView:OnInviteDrawUpdate()
	self:UpdateFreeDraw()
end

function DrawView:AdaptRight()
	DrawView.super.AdaptRight(self)

	if DrawView.VIEW_ADAPT_DISTANCE == self.lastAdaptDistance_ then
		return
	end

	if not DrawView.NEED_ADAPT then
		self.btnSkip_.transform.anchoredPosition = Vector3(0, 0, 0)
		self.skipInteractBtn_.transform.anchoredPosition = Vector3(0, 0, 0)
	else
		self.btnSkip_.transform.anchoredPosition = Vector3(-1 * DrawView.VIEW_ADAPT_DISTANCE, 0, 0)
		self.skipInteractBtn_.transform.anchoredPosition = Vector3(-1 * DrawView.VIEW_ADAPT_DISTANCE, 0, 0)
	end
end

return DrawView
