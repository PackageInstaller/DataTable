local var_0_0 = class("DrawView", ReduxView)
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

function var_0_0.OnCtor(arg_1_0)
	arg_1_0.moviePaths = {
		"SofdecAsset/function/blue.usm",
		"SofdecAsset/function/purple.usm",
		"SofdecAsset/function/glod.usm"
	}
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Pool/PoolUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0.poolToggles_ = {}
	arg_4_0.poolObjects_ = {}
	arg_4_0.poolActivitys_ = {}
	arg_4_0.groupRedPoint = {}
	arg_4_0.drawHandler_ = handler(arg_4_0, arg_4_0.DrawCheck)
	arg_4_0.leftGroupItemList_ = {}
	arg_4_0.leftToggleItemList_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.currencyModifyHandler_ = handler(arg_4_0, arg_4_0.CurrencyModify)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.criMovie_ = arg_5_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_5_0.criplayer_ = arg_5_0.criMovie_.player

	arg_5_0.criMovie_:Stop()

	arg_5_0.moviePlaying = false

	SetActive(arg_5_0.movieGo_, false)

	arg_5_0.drawInteract = arg_5_0.drawInteractGo_:GetComponent("DrawController")

	SetActive(arg_5_0.drawInteractGo_, false)

	arg_5_0.showRightController = ControllerUtil.GetController(arg_5_0.transform_, "showRight")
	arg_5_0.rechargeShopGiftController = ControllerUtil.GetController(arg_5_0.transform_, "recharge_shop_gift")
	arg_5_0.infoController = arg_5_0.infoController_:GetController("info")
	arg_5_0.tree_ = LuaTree.New(arg_5_0.uitreeGo_)

	arg_5_0.tree_:SetSelectedHandler(handler(arg_5_0, arg_5_0.OnGroupSelect), handler(arg_5_0, arg_5_0.OnItemSelect))
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnInfo_, nil, function()
		DrawAction.GetPoolData(arg_6_0.selectPoolId_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnOnce_, nil, function()
		arg_6_0:DrawCheck(DrawConst.DRAW_TYPE.ONE)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnTenth_, nil, function()
		local var_10_0 = DrawPoolCfg[arg_6_0.selectPoolId_]

		if var_10_0.pool_type == 8 then
			arg_6_0:DrawCheck(math.min(40 - DrawData:GetPoolDrawTimes(arg_6_0.selectPoolId_), 10))
		elseif var_10_0.pool_type == 9 then
			arg_6_0:DrawCheck(math.min(70 - DrawData:GetPoolDrawTimes(arg_6_0.selectPoolId_), 10))
		else
			arg_6_0:DrawCheck(DrawConst.DRAW_TYPE.TEN)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnSkip_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		arg_6_0:SkipMovie()
	end)
	arg_6_0:AddBtnListener(arg_6_0.chooseBtn_, nil, function()
		DrawTools:GoToSelectUpHeroView(arg_6_0.selectPoolId_, arg_6_0.showId, true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.skipInteractBtn_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		arg_6_0:SkipInteract()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_giftBtn, nil, function()
		local var_14_0 = DrawPoolCfg[arg_6_0.selectPoolId_]
		local var_14_1 = 0

		if var_14_0.pool_type == 3 then
			var_14_1 = 1
		elseif var_14_0.pool_type == 1 then
			var_14_1 = 2
		elseif var_14_0.pool_type == 2 then
			var_14_1 = 3
		elseif var_14_0.pool_type == 6 then
			var_14_1 = 4
		end

		if var_14_1 ~= 0 then
			OperationRecorder.RecordButtonTouch("draw_gifts_type" .. var_14_1)
		end

		JumpTools.OpenPageByJump("rechargeDrawGift", {
			poolId = arg_6_0.selectPoolId_
		})
	end)
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:StopMovie()
	arg_15_0:ShowBar()
	arg_15_0:UpdatePieceReward()
	arg_15_0:AddPieceTimer()
	arg_15_0:AddBonusTimer()
end

function var_0_0.AddBonusTimer(arg_16_0)
	arg_16_0:StopBonusTimer()

	if arg_16_0.bonusView_ then
		arg_16_0.bonusView_:PrePlayAnimator()
	end

	arg_16_0.bonusTimer_ = FrameTimer.New(function()
		arg_16_0:StopBonusTimer()

		if arg_16_0:IsTop() and not arg_16_0.drawProcessFlag_ then
			local var_17_0 = arg_16_0.selectPoolId_
			local var_17_1 = DrawTools.GetDrawBonusActivityIDList()

			if DrawTools.HasDrawBonusPoolID(var_17_1, var_17_0) and arg_16_0.bonusView_ then
				arg_16_0.bonusView_:PlayAnimator()
			end
		end
	end, 2, 1)

	arg_16_0.bonusTimer_:Start()
end

function var_0_0.StopBonusTimer(arg_18_0)
	if arg_18_0.bonusTimer_ then
		arg_18_0.bonusTimer_:Stop()

		arg_18_0.bonusTimer_ = nil
	end
end

function var_0_0.AddPieceTimer(arg_19_0)
	arg_19_0:StopPieceTimer()

	arg_19_0.pieceTimer_ = FrameTimer.New(function()
		arg_19_0:StopPieceTimer()

		if arg_19_0:IsTop() and not arg_19_0.drawProcessFlag_ then
			local var_20_0 = arg_19_0.selectPoolId_
			local var_20_1 = DrawTools.GetDrawPieceActivityIDList()

			if DrawTools.HasDrawPiecePoolID(var_20_1, var_20_0) and arg_19_0.pieceView_ then
				arg_19_0.pieceView_:CheckCompleteList(arg_19_0)
			end
		end
	end, 2, 1)

	arg_19_0.pieceTimer_:Start()
end

function var_0_0.StopPieceTimer(arg_21_0)
	if arg_21_0.pieceTimer_ then
		arg_21_0.pieceTimer_:Stop()

		arg_21_0.pieceTimer_ = nil
	end
end

function var_0_0.OnEnter(arg_22_0)
	if arg_22_0.bonusView_ then
		arg_22_0.bonusView_:OnEnter()
	end

	SetActive(arg_22_0.maskGo_, false)

	if arg_22_0.params_.isFirst then
		arg_22_0:DestroyPoolGo()

		arg_22_0.params_.isFirst = nil
	end

	arg_22_0:SetupActivityPool()

	if arg_22_0.params_.poolType then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.poolToggles_) do
			if DrawPoolCfg[iter_22_1].pool_type ~= arg_22_0.params_.poolType or var_0_5[iter_22_1] or var_0_5[arg_22_0.params_.poolId] then
				-- block empty
			else
				arg_22_0.params_.poolId = iter_22_1
				arg_22_0.params_.poolType = nil
			end
		end
	end

	local var_22_0 = arg_22_0.enterPoolId

	if arg_22_0.params_.poolId then
		local var_22_1 = arg_22_0.poolActivitys_[arg_22_0.params_.poolId]

		if var_22_1 and ActivityData:GetActivityIsOpen(var_22_1) then
			var_22_0 = arg_22_0.params_.poolId
		end
	end

	arg_22_0.tree_.tree_.data.groupDatas[arg_22_0.poolIDToIndexTable[var_22_0][1] - 1].defaultIndex = arg_22_0.poolIDToIndexTable[var_22_0][2] - 1

	arg_22_0.tree_:SelectItem(arg_22_0.poolIDToIndexTable[var_22_0][1], arg_22_0.poolIDToIndexTable[var_22_0][2])
	DrawTools:LoadDrawLevel()
	manager.ui:SetMainCamera("draw")

	arg_22_0.panel_.transform.localPosition = Vector2(0, 0)

	manager.notify:RegistListener(CURRENCY_UPDATE, arg_22_0.currencyModifyHandler_)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	if ShopListCfg[ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP] then
		arg_22_0.shopText_.text = GetI18NText(ShopListCfg[ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP].remark)
	end

	DrawAction.ClickDrawBonusRedPoint()
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:StopBonusTimer()
	arg_23_0:StopPieceTimer()
	SetActive(arg_23_0.maskGo_, false)

	if arg_23_0.bonusView_ then
		arg_23_0.bonusView_:OnExit()
	end

	if arg_23_0.pieceView_ then
		arg_23_0.pieceView_:OnExit()
	end

	arg_23_0.drawProcessFlag_ = false

	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_23_0.currencyModifyHandler_)

	if arg_23_0.selectPoolId_ and arg_23_0.selectPoolId_ ~= 0 and arg_23_0.selectPoolId_ ~= -1 and manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_23_0 = manager.net.tcpConnection_:GetMachineState()

		if var_23_0 and (var_23_0 == "connected" or var_23_0 == "connecting") then
			arg_23_0:HidePoolNewTag(arg_23_0.selectPoolId_, true)
		end
	end

	arg_23_0:DestroyPoolGo()
	manager.windowBar:HideBar()
	arg_23_0:StopMovie()
	arg_23_0.criMovie_:Stop()

	if arg_23_0.curPoolObject then
		arg_23_0.curPoolObject:SetActive(false)
	end

	arg_23_0.curPoolObject = nil
	arg_23_0.selectPoolId_ = -1
	arg_23_0.timer = nil
	arg_23_0.one_cost_type = nil
	arg_23_0.ten_cost_type = nil

	if arg_23_0.interactTimer then
		arg_23_0.interactTimer:Stop()

		arg_23_0.interactTimer = nil
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	arg_23_0:RemoveCountDownTimer()
	DrawTools:UnLoadDrawLevel()
end

function var_0_0.InitTree(arg_24_0)
	local var_24_0 = UITreeData.New()
	local var_24_1 = {}

	arg_24_0.poolIDToIndexTable = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.poolToggles_) do
		local var_24_2 = DrawPoolCfg[iter_24_1]
		local var_24_3 = var_0_2[var_24_2.pool_show_type]

		if var_24_1[var_24_3] == nil then
			var_24_1[var_24_3] = 1
		end

		arg_24_0.poolIDToIndexTable[iter_24_1] = {
			var_24_3,
			var_24_1[var_24_3]
		}
		var_24_1[var_24_3] = var_24_1[var_24_3] + 1
	end

	local var_24_4 = {}
	local var_24_5 = 1

	for iter_24_2 = 1, 8 do
		if var_24_1[iter_24_2] then
			var_24_4[iter_24_2] = var_24_5
			var_24_5 = var_24_5 + 1
		end
	end

	local var_24_6 = {}

	for iter_24_3, iter_24_4 in ipairs(var_0_1) do
		var_24_6[iter_24_3] = UITreeGroupData.New()
		var_24_6[iter_24_3].text = GetTips(iter_24_4)
	end

	for iter_24_5, iter_24_6 in ipairs(arg_24_0.poolToggles_) do
		local var_24_7 = DrawPoolCfg[iter_24_6]
		local var_24_8 = var_0_2[var_24_7.pool_show_type]

		arg_24_0.poolIDToIndexTable[iter_24_6][1] = var_24_4[var_24_8]
		var_24_6[var_24_8].id = var_24_4[var_24_8]

		local var_24_9 = UITreeItemData.New()

		var_24_9.id = var_24_7.id
		var_24_9.text = GetI18NText(var_24_7.name)

		if var_24_7.pool_show_type == 2 then
			local var_24_10 = DrawData:GetPollUpID(iter_24_6)

			var_24_9.text = GetI18NText(var_24_7.name)

			if var_24_10 ~= 0 then
				var_24_9.text = GetTips(var_0_4[var_24_10])
			end
		elseif var_24_7.pool_show_type == 8 or var_24_7.pool_show_type == 9 or var_24_7.pool_show_type == 3 and var_24_7.pool_selected_type == 2 then
			local var_24_11 = DrawData:GetPollUpID(iter_24_6)

			var_24_9.text = GetI18NText(var_24_7.name)

			if var_24_11 ~= 0 then
				local var_24_12 = DrawData:ConvertUpId(iter_24_6, var_24_11, 0)

				var_24_9.text = GetI18NText(HeroCfg[var_24_12].name) or ""
			end
		elseif var_24_7.pool_show_type == 1 then
			local var_24_13 = DrawData:GetPollUpID(iter_24_6)

			var_24_9.text = GetI18NText(var_24_7.name)

			if var_24_13 ~= 0 then
				var_24_9.text = GetI18NText(HeroCfg[var_24_13].name) or ""
			end
		end

		if arg_24_0.poolIDToIndexTable[iter_24_6][1] == 1 and arg_24_0.poolIDToIndexTable[iter_24_6][2] == 1 then
			arg_24_0.enterPoolId = iter_24_6
		end

		var_24_6[var_24_8].itemDatas:Add(var_24_9)
	end

	for iter_24_7 = 1, 7 do
		if var_24_6[iter_24_7].itemDatas.Count > 0 then
			var_24_0.groupDatas:Add(var_24_6[iter_24_7])
		end
	end

	arg_24_0.isFirst = nil

	arg_24_0.tree_:SetData(var_24_0)

	arg_24_0.isFirst = true
end

function var_0_0.OnGroupSelect(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_0.tree_.tree_.data.groupDatas[arg_25_1 - 1].defaultIndex = 0

	manager.notify:Invoke(DRAW_SELECT_GROUP, arg_25_1)
end

function var_0_0.OnItemSelect(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_0.isFirst == nil then
		return
	end

	manager.notify:Invoke(DRAW_SELECT_ITEM, arg_26_1)
	arg_26_0:HidePoolNewTag(arg_26_2)
	arg_26_0:SetSelectPool(arg_26_2)

	local var_26_0 = DrawPoolCfg[arg_26_2]
	local var_26_1 = var_0_2[var_26_0.pool_show_type]

	arg_26_0.infoController:SetSelectedState("info_1")

	if var_26_1 == 1 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
	elseif var_26_1 == 2 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_26_1 == 3 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_26_1 == 4 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")

		arg_26_0.infoController:SetSelectedState("info_3")
	elseif var_26_1 == 5 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_26_1 == 6 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
	elseif var_26_1 == 7 then
		arg_26_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
		arg_26_0.upTips1_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
		arg_26_0.upTips2_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")

		arg_26_0.infoController:SetSelectedState("info_3")
	end

	if DrawData:GetPollUpID(arg_26_0.selectPoolId_) == 0 and DrawData:GetPoolIsNew(arg_26_0.selectPoolId_) == 1 then
		DrawTools:GoToSelectUpHeroView(arg_26_0.selectPoolId_, arg_26_0.showId, true)
	end
end

function var_0_0.SetupActivityPool(arg_27_0)
	arg_27_0.poolToggles_ = {}

	local var_27_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if ActivityData:GetActivityIsOpen(iter_27_1) then
			local var_27_1 = ActivityDrawPoolCfg[iter_27_1]

			if var_27_1 then
				for iter_27_2, iter_27_3 in ipairs(var_27_1.config_list) do
					local var_27_2 = DrawPoolCfg[iter_27_3]

					if var_27_2.pool_show_type == 8 then
						if not DrawData:GetNewbieChooseDrawFlag() then
							table.insert(arg_27_0.poolToggles_, iter_27_3)

							arg_27_0.poolActivitys_[iter_27_3] = iter_27_1
						end
					elseif var_27_2.pool_show_type == 9 then
						if RegressionDataNew:CheckIsOpenRuturnPool() then
							table.insert(arg_27_0.poolToggles_, iter_27_3)

							arg_27_0.poolActivitys_[iter_27_3] = iter_27_1
						end
					else
						table.insert(arg_27_0.poolToggles_, iter_27_3)

						arg_27_0.poolActivitys_[iter_27_3] = iter_27_1
					end
				end
			end
		end
	end

	if #arg_27_0.poolToggles_ == 0 then
		Debugger.LogError("draw error pools is empty")
	end

	table.sort(arg_27_0.poolToggles_, function(arg_28_0, arg_28_1)
		if DrawPoolCfg[arg_28_0].order == DrawPoolCfg[arg_28_1].order then
			return arg_28_1 < arg_28_0
		else
			return DrawPoolCfg[arg_28_0].order < DrawPoolCfg[arg_28_1].order
		end
	end)
	arg_27_0:ClearLeftToggle()
	arg_27_0:InitTree()
	arg_27_0:InitPoolNew()
	arg_27_0:InitLeftToggle()
end

function var_0_0.InitPoolNew(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.poolToggles_) do
		if DrawData:GetPoolIsNew(iter_29_1) == 1 then
			arg_29_0:SetNewTag(true, iter_29_1)
		end
	end
end

function var_0_0.HidePoolNewTag(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.selectPoolId_ ~= -1 and arg_30_0.selectPoolId_ ~= nil and arg_30_0.selectPoolId_ ~= arg_30_1 and DrawData:GetPoolIsNew(arg_30_0.selectPoolId_) == 1 or arg_30_2 then
		DrawAction.HidePoolNewTag(arg_30_0.selectPoolId_, handler(arg_30_0, arg_30_0.SetNewTag))
	end
end

function var_0_0.SetNewTag(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0.poolIDToIndexTable[arg_31_2] then
		return
	end

	if not arg_31_0.tree_ then
		return
	end

	local var_31_0 = arg_31_0.poolIDToIndexTable[arg_31_2][1]
	local var_31_1 = arg_31_0.poolIDToIndexTable[arg_31_2][2]
	local var_31_2 = arg_31_0.tree_:GetGroupRedPointContainerById(var_31_0)
	local var_31_3 = arg_31_0.tree_:GetItemRedPointContainerById(var_31_0, arg_31_2)

	if var_31_2 == nil or var_31_3 == nil then
		return
	end

	if arg_31_1 then
		arg_31_0.groupRedPoint[var_31_0] = arg_31_0.groupRedPoint[var_31_0] or {}
		arg_31_0.groupRedPoint[var_31_0][var_31_1] = arg_31_2
	else
		arg_31_0.groupRedPoint[var_31_0][var_31_1] = nil

		if not next(arg_31_0.groupRedPoint[var_31_0]) then
			arg_31_0.groupRedPoint[var_31_0] = nil
		end

		if not next(arg_31_0.groupRedPoint) then
			manager.redPoint:setTip(RedPointConst.DRAW, 0, RedPointStyle.SHOW_NEW_TAG)

			arg_31_0.groupRedPoint = {}
		end
	end

	local var_31_4 = arg_31_0.groupRedPoint[var_31_0] and next(arg_31_0.groupRedPoint[var_31_0])

	manager.redPoint:setRedPoint({
		display = var_31_2
	}, var_31_4, RedPointStyle.SHOW_NEW_TAG)
	manager.redPoint:setRedPoint({
		display = var_31_3
	}, arg_31_1, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.InitLeftToggle(arg_32_0)
	local var_32_0 = arg_32_0.tree_:GetData().groupDatas
	local var_32_1 = 1

	for iter_32_0 = 0, var_32_0.Count - 1 do
		local var_32_2 = var_32_0[iter_32_0].id
		local var_32_3 = arg_32_0.tree_:GetGroupGameObjectById(var_32_2)

		arg_32_0.leftGroupItemList_[iter_32_0 + 1] = arg_32_0.leftGroupItemList_[iter_32_0 + 1] or DrawLeftToggleGroupItem.New(var_32_3)

		local var_32_4 = {}
		local var_32_5 = var_32_0[iter_32_0].itemDatas

		for iter_32_1 = 0, var_32_5.Count - 1 do
			local var_32_6 = var_32_5[iter_32_1].id
			local var_32_7 = arg_32_0.tree_:GetItemGameObjectById(var_32_2, var_32_6)

			arg_32_0.leftToggleItemList_[var_32_1] = arg_32_0.leftToggleItemList_[var_32_1] or DrawLeftToggleItem.New(var_32_7)

			arg_32_0.leftToggleItemList_[var_32_1]:SetData(var_32_6, iter_32_1 + 1)

			var_32_1 = var_32_1 + 1

			table.insert(var_32_4, var_32_6)
		end

		arg_32_0.leftGroupItemList_[iter_32_0 + 1]:SetData(var_32_4, iter_32_0 + 1)
	end
end

function var_0_0.ClearLeftToggle(arg_33_0)
	for iter_33_0 = #arg_33_0.leftToggleItemList_, 1, -1 do
		arg_33_0.leftToggleItemList_[iter_33_0]:Dispose()

		arg_33_0.leftToggleItemList_[iter_33_0] = nil
	end

	for iter_33_1 = #arg_33_0.leftGroupItemList_, 1, -1 do
		arg_33_0.leftGroupItemList_[iter_33_1]:Dispose()

		arg_33_0.leftGroupItemList_[iter_33_1] = nil
	end
end

function var_0_0.RefreshActivityPool(arg_34_0)
	arg_34_0:SetupActivityPool()

	if not table.indexof(arg_34_0.poolToggles_, arg_34_0.selectPoolId_) then
		arg_34_0.selectPoolId_ = arg_34_0.poolToggles_[1]

		arg_34_0:RefreshUI()
	end
end

function var_0_0.SetSelectPool(arg_35_0, arg_35_1)
	if not table.indexof(arg_35_0.poolToggles_, arg_35_1) then
		return
	end

	if arg_35_1 == arg_35_0.selectPoolId_ then
		return
	end

	arg_35_0.selectPoolId_ = arg_35_1
	arg_35_0.params_.poolId = arg_35_1

	arg_35_0:RefreshUI()
end

function var_0_0.ShowBar(arg_36_0)
	local var_36_0 = DrawTools.GetCostTicketList(arg_36_0.selectPoolId_)
	local var_36_1 = DrawTools.GetActivityCostTicket(arg_36_0.selectPoolId_)
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
		arg_36_0:Back()
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

function var_0_0.RefreshUI(arg_39_0)
	local var_39_0 = arg_39_0.selectPoolId_
	local var_39_1 = DrawPoolCfg[var_39_0]
	local var_39_2 = var_39_0

	arg_39_0:UpdateFirstSelectButton(true)

	if var_39_1.pool_selected_type == 9 then
		local var_39_3 = DrawData:GetPollUpID(var_39_0)

		if var_39_3 == 0 and arg_39_0.selectPoolId_ == DrawConst.WEAPON_SERVANT_POOL_ID then
			arg_39_0:UpdateFirstSelectButton(false)

			var_39_2 = -1
		elseif var_39_3 == 0 and arg_39_0.selectPoolId_ ~= DrawConst.WEAPON_SERVANT_POOL_ID then
			arg_39_0:UpdateFirstSelectButton(false)

			var_39_2 = -2
		else
			var_39_2 = var_39_3
		end
	elseif var_39_1.pool_selected_type == 2 or var_39_1.pool_selected_type == 8 then
		if DrawData:GetPollUpID(var_39_0) == 0 then
			local var_39_4 = var_39_1.pool_change
			local var_39_5 = DrawData:GetPoolUpTimes(var_39_0)

			if var_39_4 == 0 or var_39_5 < var_39_4 then
				arg_39_0.timer = TimeTools.StartAfterSeconds(0.02, function(arg_40_0)
					if arg_39_0.timer == nil then
						return
					end

					if DrawData:IsOnePrefabPool(arg_40_0) then
						arg_39_0:UpdateFirstSelectButton(false)
					else
						arg_39_0:Go("/drawHeroSelect", {
							poolId = arg_39_0.selectPoolId_
						})
					end

					arg_39_0.timer = nil
				end, {
					var_39_0
				})
			end
		end
	elseif var_39_1.pool_selected_type == 1 and DrawData:GetPollUpID(var_39_0) == 0 then
		arg_39_0.timer = TimeTools.StartAfterSeconds(0.02, function(arg_41_0)
			if arg_39_0.timer == nil then
				return
			end

			if DrawData:IsOnePrefabPool(arg_41_0) then
				arg_39_0:UpdateFirstSelectButton(false)
			end

			arg_39_0.timer = nil
		end, {
			var_39_0
		})
	end

	if var_39_1.pool_type == 8 then
		arg_39_0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(40 - DrawData:GetPoolDrawTimes(var_39_0), 10))))
		arg_39_0.tips3Text_.text = GetTips("DRAW_POOL_SCREEN_TYPE_3")
		arg_39_0.tenIconText_.text = "x" .. math.min(40 - DrawData:GetPoolDrawTimes(var_39_0), 10)
	elseif var_39_1.pool_type == 9 then
		arg_39_0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(70 - DrawData:GetPoolDrawTimes(var_39_0), 10))))
		arg_39_0.tips3Text_.text = GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_1")
		arg_39_0.tenIconText_.text = "x" .. math.min(70 - DrawData:GetPoolDrawTimes(var_39_0), 10)
	else
		arg_39_0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), GetTips("NUM_10"))
		arg_39_0.tenIconText_.text = "x10"
	end

	if arg_39_0.curPoolObject then
		if arg_39_0.curPoolObject:GetShowId() == var_39_2 then
			arg_39_0.curPoolObject:Refresh(var_39_2)
			arg_39_0:RefreshRightPanel()

			return
		else
			arg_39_0.curPoolObject:SetActive(false)
		end
	end

	arg_39_0.showId = var_39_2

	if not arg_39_0.poolObjects_[var_39_2] then
		if var_39_1.pool_type == 1 then
			if DrawData:IsOnePrefabPool(var_39_0) then
				arg_39_0.poolObjects_[var_39_2] = DrawRolePoolContainer.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			else
				arg_39_0.poolObjects_[var_39_2] = DrawNormalPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			end
		elseif var_39_1.pool_selected_type == 2 or var_39_1.pool_selected_type == 8 then
			if DrawData:IsOnePrefabPool(var_39_0) then
				if var_39_1.pool_type == 9 then
					arg_39_0.poolObjects_[var_39_2] = ReturnDrawSelectPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
				elseif var_39_1.pool_selected_type == 8 then
					arg_39_0.poolObjects_[var_39_2] = NewbieDrawSelectPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
				else
					arg_39_0.poolObjects_[var_39_2] = DrawSelectPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
				end
			else
				arg_39_0.poolObjects_[var_39_2] = DrawUpPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			end
		elseif var_39_1.pool_selected_type == 9 and arg_39_0.selectPoolId_ == DrawConst.WEAPON_SERVANT_POOL_ID then
			if DrawData:GetPollUpID(var_39_0) == var_39_2 then
				arg_39_0.poolObjects_[var_39_2] = DrawServantPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			else
				arg_39_0.poolObjects_[var_39_2] = DrawServantNormalPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			end
		elseif var_39_1.pool_selected_type == 9 and arg_39_0.selectPoolId_ ~= DrawConst.WEAPON_SERVANT_POOL_ID then
			if DrawData:GetPollUpID(var_39_0) == var_39_2 then
				arg_39_0.poolObjects_[var_39_2] = GodEaterDrawServantPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			else
				arg_39_0.poolObjects_[var_39_2] = GodEaterDrawServantNormalPool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
			end
		else
			arg_39_0.poolObjects_[var_39_2] = DrawBasePool.New(arg_39_0.poolcontentTrs_, var_39_0, var_39_2)
		end
	end

	arg_39_0.curPoolObject = arg_39_0.poolObjects_[var_39_2]

	for iter_39_0, iter_39_1 in pairs(arg_39_0.poolObjects_) do
		if var_39_2 ~= iter_39_0 then
			iter_39_1:Dispose()

			arg_39_0.poolObjects_[iter_39_0] = nil
		end
	end

	arg_39_0.curPoolObject:Refresh(var_39_2)
	arg_39_0.curPoolObject:SetActive(true)
	arg_39_0:OnRequestRecord()
	arg_39_0:RefreshRightPanel()

	local var_39_6 = arg_39_0.poolActivitys_[var_39_0]

	if var_39_6 and ActivityData:GetActivityData(var_39_6) then
		local var_39_7 = ActivityData:GetActivityData(var_39_6).stopTime

		arg_39_0:SetCountDown(var_39_7 ~= 0, var_39_7)
	else
		arg_39_0:SetCountDown(false)
	end

	arg_39_0:ShowBar()

	if #DrawTools.GetRechargeDrawGiftList(var_39_0) == 0 then
		arg_39_0.rechargeShopGiftController:SetSelectedIndex(0)
	else
		arg_39_0.rechargeShopGiftController:SetSelectedIndex(1)
	end

	arg_39_0:UpdateFreeDraw()
	arg_39_0:UpdateBonus()
	arg_39_0:UpdatePieceReward()
end

function var_0_0.OnRequestRecord(arg_42_0)
	local var_42_0 = DrawData:GetDrawRecord(arg_42_0.selectPoolId_)
	local var_42_1 = DrawPoolCfg[arg_42_0.selectPoolId_]

	if var_42_0 then
		local var_42_2 = var_42_0.ssr_draw_times
		local var_42_3 = var_0_2[var_42_1.pool_show_type]
		local var_42_4 = var_0_3[var_42_3] or "70"

		arg_42_0.drawOutLineTxt_.text = var_42_2
		arg_42_0.drawTxt_.text = "/" .. var_42_4
		arg_42_0.drawAllTxt_.text = var_42_2
		arg_42_0.drawOutLineTxt1_.text = var_42_2
		arg_42_0.drawTxt1_.text = "/" .. var_42_4
		arg_42_0.drawAllTxt1_.text = var_42_2
	else
		DrawAction.RequestRecord(arg_42_0.selectPoolId_)
	end
end

function var_0_0.UpdateFreeDraw(arg_43_0)
	local var_43_0 = InviteData:GetDataByPara("poolID")
	local var_43_1 = InviteData:GetDataByPara("drawItemId")
	local var_43_2 = DrawPoolCfg[var_43_0]

	SetActive(arg_43_0.freeGo_, arg_43_0.selectPoolId_ == var_43_0 and ItemTools.getItemNum(var_43_1) > 0)

	if var_43_2 == nil then
		return
	end

	local var_43_3 = arg_43_0.tree_:GetGroupRedPointContainerById(var_0_2[var_43_2.pool_show_type])

	if var_43_3 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_43_3
	}, ItemTools.getItemNum(var_43_1) > 0)

	local var_43_4 = arg_43_0.tree_:GetItemRedPointContainerById(var_0_2[var_43_2.pool_show_type], var_43_0)

	if var_43_4 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_43_4
	}, ItemTools.getItemNum(var_43_1) > 0)
end

function var_0_0.RefreshRightPanel(arg_44_0)
	if not arg_44_0.curPoolObject then
		return
	end

	if arg_44_0.curPoolObject:ShowRightPanel() then
		local var_44_0 = DrawTools.GetActivityCostTicket(arg_44_0.selectPoolId_)

		if var_44_0 == 0 or ItemTools.IsItemExpiredByItemId(var_44_0) or ItemTools.getItemNum(var_44_0) == 0 then
			local var_44_1 = DrawTools.GetCostTicket(arg_44_0.selectPoolId_, 1)

			arg_44_0.iconOnce_.sprite = ItemTools.getItemSprite(var_44_1)

			local var_44_2 = DrawTools.GetCostTicket(arg_44_0.selectPoolId_, 10)

			arg_44_0.iconTenth_.sprite = ItemTools.getItemSprite(var_44_2)
			arg_44_0.one_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			arg_44_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
		else
			arg_44_0.iconOnce_.sprite = ItemTools.getItemSprite(var_44_0)
			arg_44_0.one_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY

			local var_44_3 = ItemTools.getItemNum(var_44_0)
			local var_44_4 = 10
			local var_44_5 = DrawPoolCfg[arg_44_0.selectPoolId_]

			if var_44_5.pool_type == 8 then
				var_44_4 = math.min(40 - DrawData:GetPoolDrawTimes(arg_44_0.selectPoolId_), var_44_4)
			elseif var_44_5.pool_type == 9 then
				var_44_4 = math.min(70 - DrawData:GetPoolDrawTimes(arg_44_0.selectPoolId_), var_44_4)
			end

			if var_44_3 < var_44_4 then
				local var_44_6 = DrawTools.GetCostTicket(arg_44_0.selectPoolId_, 10)

				arg_44_0.iconTenth_.sprite = ItemTools.getItemSprite(var_44_6)
				arg_44_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			else
				arg_44_0.iconTenth_.sprite = ItemTools.getItemSprite(var_44_0)
				arg_44_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY
			end
		end

		arg_44_0.showRightController:SetSelectedIndex(1)
	else
		arg_44_0.showRightController:SetSelectedIndex(0)
	end
end

function var_0_0.UpdateBonus(arg_45_0)
	local var_45_0 = arg_45_0.selectPoolId_
	local var_45_1 = DrawTools.GetDrawBonusActivityIDList()
	local var_45_2 = DrawTools.HasDrawBonusPoolID(var_45_1, var_45_0)

	if var_45_2 then
		if arg_45_0.bonusView_ == nil then
			arg_45_0.bonusView_ = DrawRightBonusItem.New(arg_45_0.rightGo_)

			arg_45_0.bonusView_:OnEnter()
		end

		arg_45_0.bonusView_:SetData(var_45_2, arg_45_0.selectPoolId_)
	elseif arg_45_0.bonusView_ then
		arg_45_0.bonusView_:Show(false)
	end
end

function var_0_0.UpdatePieceReward(arg_46_0)
	local var_46_0 = arg_46_0.selectPoolId_
	local var_46_1 = DrawTools.GetDrawPieceActivityIDList()
	local var_46_2 = DrawTools.HasDrawPiecePoolID(var_46_1, var_46_0)

	if var_46_2 then
		if arg_46_0.pieceView_ == nil then
			arg_46_0.pieceView_ = DrawRightPieceItem.New(arg_46_0.rightGo_)

			arg_46_0.pieceView_:OnEnter()
		end

		arg_46_0.pieceView_:SetData(var_46_2, arg_46_0.selectPoolId_)
	elseif arg_46_0.pieceView_ then
		arg_46_0.pieceView_:Show(false)
	end
end

function var_0_0.DestroyPoolGo(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.poolObjects_) do
		iter_47_1:Dispose()
	end

	arg_47_0.poolObjects_ = {}
end

function var_0_0.SetCountDown(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.activityEndTime_ = arg_48_2

	if arg_48_1 then
		if not arg_48_0.activityTimer_ then
			arg_48_0.activityTimer_ = Timer.New(handler(arg_48_0, arg_48_0.UpdateCountDownText), 1, -1)
		end

		arg_48_0:UpdateCountDownText()
		arg_48_0.curPoolObject:ShowCountDownText(true)
		arg_48_0.activityTimer_:Start()
	else
		arg_48_0.curPoolObject:ShowCountDownText(false)

		if arg_48_0.activityTimer_ then
			arg_48_0.activityTimer_:Stop()
		end
	end
end

function var_0_0.UpdateCountDownText(arg_49_0)
	arg_49_0.curPoolObject:SetCountDownText(arg_49_0.activityEndTime_)
end

function var_0_0.RemoveCountDownTimer(arg_50_0)
	if arg_50_0.activityTimer_ then
		arg_50_0.activityTimer_:Stop()

		arg_50_0.activityTimer_ = nil
	end
end

function var_0_0.DrawCheck(arg_51_0, arg_51_1)
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
				arg_51_0:StartDraw(arg_51_1)
			end
		})
	else
		arg_51_0:StartDraw(arg_51_1)
	end
end

function var_0_0.StartDraw(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.selectPoolId_
	local var_54_1 = DrawPoolCfg[var_54_0]
	local var_54_2
	local var_54_3
	local var_54_4
	local var_54_5

	if DrawConst.DRAW_TYPE.ONE == arg_54_1 then
		var_54_2 = arg_54_0.one_cost_type
		var_54_3 = 1
		var_54_5 = 1
	elseif DrawConst.DRAW_TYPE.TEN == arg_54_1 then
		var_54_2 = arg_54_0.ten_cost_type
		var_54_3 = 10

		if var_54_1.discount > 0 then
			var_54_3 = var_54_3 * var_54_1.discount / 100
		end

		var_54_5 = 10
	else
		var_54_2 = arg_54_0.ten_cost_type
		var_54_3 = arg_54_1

		if var_54_1.discount > 0 then
			var_54_3 = var_54_3 * var_54_1.discount / 100
		end

		var_54_5 = arg_54_1
	end

	local var_54_6 = 0

	if DrawConst.DRAW_COST_TYPE.COMMON == var_54_2 then
		var_54_6 = DrawTools.GetCostTicket(var_54_0, var_54_3)

		local var_54_7 = ItemTools.getItemNum(var_54_6)

		if var_54_7 < var_54_3 then
			local var_54_8 = var_54_3 - var_54_7

			arg_54_0.shopDrawInfo = {
				poolId = var_54_0,
				draw_type = arg_54_1,
				cost_id = var_54_6,
				cost_num = var_54_3
			}

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_gacha_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
			})
			arg_54_0:ShowBuyView(var_54_8, var_54_1)

			return
		end
	elseif DrawConst.DRAW_COST_TYPE.ACTIVITY == var_54_2 then
		var_54_6 = DrawTools.GetActivityCostTicket(var_54_0)

		if ItemTools.IsItemExpiredByItemId(var_54_6) then
			ShowTips("TIP_EXPIRED")
			arg_54_0:RefreshActivityPool()
			arg_54_0:RefreshUI()

			return
		end

		if var_54_3 > ItemTools.getItemNum(var_54_6) then
			error("draw activity tick num error")

			return
		end
	end

	if not SDKTools.GetIsOverSea() and var_54_5 + DrawData:GetTodayDrawTimes() > GameSetting.draw_num_max.value[1] then
		ShowTips("DRAW_NUM_MAX")

		return
	end

	DrawData:SetNewHeroFlag(false)

	local var_54_9 = InviteData:GetDataByPara("drawItemId")

	if _G.SkipTip["DrawSkipTip" .. arg_54_0.selectPoolId_] or var_54_9 == var_54_6 then
		manager.achievementTips:SetShowFlag(false)
		DrawAction.GoToDraw(arg_54_0.selectPoolId_, arg_54_1, var_54_6, var_54_3)
	else
		JumpTools.OpenPageByJump("popCostItem", {
			costId = var_54_6,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				manager.achievementTips:SetShowFlag(false)
				DrawAction.GoToDraw(arg_54_0.selectPoolId_, arg_54_1, var_54_6, var_54_3)
			end,
			ToggleCallback = function(arg_56_0)
				_G.SkipTip["DrawSkipTip" .. arg_54_0.selectPoolId_] = arg_56_0
			end,
			content = string.format(GetTips("DRAW_TIMES"), ItemTools.getItemName(var_54_6), var_54_3, var_54_3)
		})
	end
end

function var_0_0.ShowBuyView(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = getShopCfg(arg_57_2.exchange_id)
	local var_57_1 = var_57_0.cost * arg_57_1
	local var_57_2 = {
		id = DrawTools.GetCostTicket(arg_57_2.id, arg_57_1),
		num = arg_57_1
	}
	local var_57_3 = {}
	local var_57_4 = {}
	local var_57_5 = math.min(ItemTools.getItemNum(var_57_0.cost_id), var_57_1)

	if var_57_5 > 0 then
		var_57_3 = {
			id = var_57_0.cost_id,
			num = var_57_5
		}
	end

	local var_57_6 = var_57_1 - var_57_5

	if var_57_6 > 0 then
		var_57_4 = {
			id = CurrencyConst.GetPlatformDiamondId(),
			num = var_57_6
		}
	end

	if not var_57_3.id and var_57_4.id then
		var_57_3 = var_57_4
		var_57_4 = {}
	end

	JumpTools.OpenPageByJump("itemBuy", {
		title = GetTips("TREASURE_TICKET_TO_BUY"),
		item1 = var_57_2,
		item2 = var_57_3,
		item3 = var_57_4,
		OkCallback = function()
			local var_58_0 = CurrencyData:GetRechargeDiamond()

			if var_57_6 > 0 and var_58_0 < var_57_6 then
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
			arg_57_0.shopDrawInfo = nil
		end
	})
end

function var_0_0.OnShopBuyResult(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	if arg_60_1 == 0 then
		if arg_60_0.shopDrawInfo == nil then
			return
		end

		arg_60_0:Back()
		manager.achievementTips:SetShowFlag(false)

		local var_60_0 = arg_60_0.shopDrawInfo.poolId
		local var_60_1 = arg_60_0.poolActivitys_[var_60_0]

		if var_60_1 and ActivityData:GetActivityIsOpen(var_60_1) then
			DrawAction.GoToDraw(arg_60_0.shopDrawInfo.poolId, arg_60_0.shopDrawInfo.draw_type, arg_60_0.shopDrawInfo.cost_id, arg_60_0.shopDrawInfo.cost_num)
		end

		arg_60_0.shopDrawInfo = nil
	else
		if arg_60_1 then
			ShowTips(arg_60_1)
		end

		arg_60_0.shopDrawInfo = nil
	end
end

function var_0_0.OnGoToDraw(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1.result == 0 then
		arg_61_0.drawProcessFlag_ = true

		local var_61_0 = {}
		local var_61_1 = 0
		local var_61_2 = arg_61_1.item

		for iter_61_0, iter_61_1 in ipairs(var_61_2) do
			DrawData:TodayDrawTimesChange(1)
			table.insert(var_61_0, formatReward(iter_61_1))

			local var_61_3 = ItemCfg[iter_61_1.id]
			local var_61_4 = var_61_3 and var_61_3.display_rare or 0

			if var_61_1 < var_61_4 then
				var_61_1 = var_61_4
			end
		end

		arg_61_0:RefreshUI()
		manager.windowBar:HideBar()

		arg_61_0.itemList_ = var_61_0

		arg_61_0:CheckInteract(var_61_1)
	else
		ShowTips(arg_61_1.result)
		arg_61_0:RefreshActivityPool()
		arg_61_0.tree_:SelectItem(arg_61_0.poolIDToIndexTable[arg_61_0.selectPoolId_][1], arg_61_0.poolIDToIndexTable[arg_61_0.selectPoolId_][2])
		manager.achievementTips:SetShowFlag(true)
	end

	arg_61_0.shopDrawInfo = nil
end

function var_0_0.JumpToReward(arg_62_0)
	arg_62_0.drawProcessFlag_ = false

	manager.achievementTips:SetShowFlag(true)

	local var_62_0 = #arg_62_0.itemList_

	if var_62_0 > 0 then
		local var_62_1 = {}
		local var_62_2 = {}

		for iter_62_0, iter_62_1 in ipairs(arg_62_0.itemList_) do
			local var_62_3 = setmetatable({
				index = iter_62_0
			}, {
				__index = iter_62_1
			})

			if ItemCfg[iter_62_1.id].type == ItemConst.ITEM_TYPE.HERO then
				var_62_3.newTag = true
				var_62_2[iter_62_1.id] = true

				DrawData:SetNewHeroFlag(true)
			elseif ItemCfg[iter_62_1.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				var_62_3.newTag = IllustratedData:GetNewObtainedServant(iter_62_1.id) ~= nil

				if var_62_3.newTag and ItemCfg[iter_62_1.id].rare >= 5 then
					DrawData:SetServantRedPoint(arg_62_0.selectPoolId_, 1)
				end
			end

			table.insert(var_62_1, var_62_3)
		end

		local var_62_4 = 0

		for iter_62_2, iter_62_3 in ipairs(arg_62_0.itemList_) do
			local var_62_5 = iter_62_3.id

			if ItemCfg[var_62_5].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[var_62_5].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or ItemCfg[var_62_5].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				local var_62_6 = var_62_5

				if ItemWillConvert(iter_62_3) then
					var_62_6 = iter_62_3.convert_from.id
				end

				local var_62_7 = ItemCfg[var_62_6].rare

				for iter_62_4, iter_62_5 in ipairs(GameSetting.currency_for_draw.value) do
					if var_62_7 == iter_62_5[1] then
						var_62_4 = var_62_4 + iter_62_5[2]
					end
				end
			end
		end

		if var_62_0 ~= 1 then
			gameContext:Go("drawTenTimesReward", {
				reward = var_62_1,
				callBack_afterTen = function()
					getReward({
						{
							id = ItemConst.CURRENCY_FOR_DRAW,
							num = var_62_4
						}
					}, nil, function()
						local var_64_0 = DrawPoolCfg[arg_62_0.selectPoolId_]

						if var_64_0.pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() or var_64_0.pool_type == 9 and not RegressionDataNew:CheckIsOpenRuturnPool() then
							if var_64_0.pool_type == 9 then
								ShowTips("NEW_REGRESSION__POOL_SCREEN_TYPE_4")
							else
								ShowTips("DRAW_POOL_SCREEN_TYPE_1")
							end

							arg_62_0:SetupActivityPool()

							arg_62_0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

							arg_62_0.tree_:SelectItem(1, 1)
						end
					end)
					arg_62_0:ShowBar()
				end
			})
		else
			local var_62_8 = DrawPoolCfg[arg_62_0.selectPoolId_]

			if var_62_8.pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() or var_62_8.pool_type == 9 and not RegressionDataNew:CheckIsOpenRuturnPool() then
				if var_62_8.pool_type == 9 then
					ShowTips("NEW_REGRESSION__POOL_SCREEN_TYPE_4")
				else
					ShowTips("DRAW_POOL_SCREEN_TYPE_1")
				end

				arg_62_0:SetupActivityPool()

				arg_62_0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

				arg_62_0.tree_:SelectItem(1, 1)
			end

			arg_62_0:ShowBar()
		end
	end

	arg_62_0:UpdateFreeDraw()
	arg_62_0:OnRequestRecord()
end

function var_0_0.SkipMovie(arg_65_0)
	arg_65_0.criplayer_.statusChangeCallback = nil

	if arg_65_0.moviePlaying then
		arg_65_0.criMovie_:Stop()
	end

	arg_65_0:DoNextNode(true)
end

local function var_0_6(arg_66_0)
	local var_66_0 = {
		__index = arg_66_0
	}
	local var_66_1 = ItemWillConvert(arg_66_0) and arg_66_0.convert_from.id or arg_66_0.id

	print("BuildShowItemInfo", arg_66_0.convert_from.id, arg_66_0.id)

	local var_66_2 = ItemCfg[var_66_1]
	local var_66_3 = var_66_2.type
	local var_66_4 = {}

	if var_66_3 == ItemConst.ITEM_TYPE.HERO or var_66_3 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_66_5 = var_66_2.rare

		for iter_66_0, iter_66_1 in ipairs(GameSetting.currency_for_draw.value) do
			if var_66_5 == iter_66_1[1] then
				var_66_4.draw_rebate = iter_66_1[2]
			end
		end
	end

	return setmetatable(var_66_4, var_66_0)
end

function var_0_0.DoNextNode(arg_67_0, arg_67_1)
	arg_67_0.panel_.transform.localPosition = Vector2(0, 0)

	local var_67_0 = #arg_67_0.itemList_

	if arg_67_1 and var_67_0 > 1 then
		local var_67_1 = {}

		for iter_67_0, iter_67_1 in ipairs(arg_67_0.itemList_) do
			if ItemCfg[iter_67_1.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[iter_67_1.id] and not (getData(DrawConst.WATCH_TAG, tostring(iter_67_1.id)) or false) then
				table.insert(var_67_1, var_0_6(iter_67_1))
			end
		end

		if #var_67_1 == 0 then
			arg_67_0:JumpToReward()
		else
			local var_67_2 = handler(arg_67_0, arg_67_0.JumpToReward)
			local var_67_3 = {
				doNextHandler = var_67_2,
				skipHandler = var_67_2,
				itemList = var_67_1
			}

			arg_67_0:Go("obtainView", var_67_3)
		end

		return
	end

	if var_67_0 > 0 then
		local var_67_4 = {}

		for iter_67_2, iter_67_3 in ipairs(arg_67_0.itemList_) do
			local var_67_5 = ItemWillConvert(iter_67_3) and iter_67_3.convert_from.id or iter_67_3.id
			local var_67_6 = ItemCfg[var_67_5].type

			if var_67_0 == 1 and var_67_6 == ItemConst.ITEM_TYPE.HERO and ItemWillConvert(iter_67_3) then
				DrawData:SetNewHeroFlag(true)
			end

			table.insert(var_67_4, var_0_6(iter_67_3))
		end

		local var_67_7 = {
			doNextHandler = handler(arg_67_0, arg_67_0.JumpToReward),
			skipHandler = handler(arg_67_0, arg_67_0.JumpToReward),
			itemList = var_67_4
		}

		arg_67_0:Go("obtainView", var_67_7)
	else
		arg_67_0:JumpToReward()
	end
end

function var_0_0.PlayMovie(arg_68_0, arg_68_1)
	local var_68_0 = manager.audio:GetMusicVolume()

	arg_68_0.criplayer_:SetVolume(var_68_0)
	arg_68_0.criMovie_:Play()

	arg_68_0.criplayer_.statusChangeCallback = handler(arg_68_0, arg_68_0.CirMovieStatusChange)
	arg_68_0.moviePlaying = true

	if arg_68_1 >= 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif arg_68_1 >= 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	manager.audio:PlayEffect("ui_system_search", "search_animation", "")
	SetActive(arg_68_0.movieGo_, true)
end

function var_0_0.CirMovieStatusChange(arg_69_0, arg_69_1)
	local var_69_0 = tostring(arg_69_1)

	if var_69_0 == "PlayEnd" or var_69_0 == "Stop" then
		arg_69_0:DoNextNode(false)
	end
end

function var_0_0.StopMovie(arg_70_0)
	arg_70_0.criplayer_.statusChangeCallback = nil
	arg_70_0.moviePlaying = false

	SetActive(arg_70_0.movieGo_, false)
end

function var_0_0.SkipInteract(arg_71_0)
	SetActive(arg_71_0.drawInteractGo_, false)

	if arg_71_0.drawInteract.timeline then
		arg_71_0.drawInteract.timeline:Stop()
	end

	arg_71_0:DoNextNode(true)
end

function var_0_0.CheckInteract(arg_72_0, arg_72_1)
	arg_72_0.maxRare = arg_72_1

	if not DrawTools:LevelIsDone() then
		SetForceShowQuanquan(true)

		if arg_72_0.interactTimer then
			arg_72_0.interactTimer:Stop()

			arg_72_0.interactTimer = nil
		end

		arg_72_0.interactTimer = FrameTimer.New(handler(arg_72_0, arg_72_0.WaitInteract), 1, -1)

		arg_72_0.interactTimer:Start()
	else
		arg_72_0:StarInteract()
	end
end

function var_0_0.WaitInteract(arg_73_0)
	if DrawTools:LevelIsDone() then
		SetForceShowQuanquan(false)

		if arg_73_0.interactTimer then
			arg_73_0.interactTimer:Stop()

			arg_73_0.interactTimer = nil
		end

		arg_73_0:StarInteract()
	end
end

function var_0_0.StarInteract(arg_74_0)
	local var_74_0 = arg_74_0.maxRare or 0

	if var_74_0 >= 5 then
		SetFile(arg_74_0.criplayer_, nil, arg_74_0.moviePaths[3])
	elseif var_74_0 >= 4 then
		SetFile(arg_74_0.criplayer_, nil, arg_74_0.moviePaths[2])
	else
		SetFile(arg_74_0.criplayer_, nil, arg_74_0.moviePaths[1])
	end

	local var_74_1

	if var_74_0 >= 5 then
		var_74_1 = GameObject.Find("X102/TC/directors/director_gold")
	elseif var_74_0 >= 4 then
		var_74_1 = GameObject.Find("X102/TC/directors/director_purple")
	else
		var_74_1 = GameObject.Find("X102/TC/directors/director_blue")
	end

	if var_74_1 then
		local var_74_2 = var_74_1:GetComponent("PlayableDirector")

		arg_74_0.drawInteract:Init(var_74_2, handler(arg_74_0, arg_74_0.StopInteract))
		arg_74_0.drawInteract:Reset()

		arg_74_0.panel_.transform.localPosition = Vector2(9999, 9999)

		SetActive(arg_74_0.drawInteractGo_, true)
	else
		arg_74_0:StopInteract()
	end

	if arg_74_0.selectPoolId_ and arg_74_0.selectPoolId_ ~= 0 and arg_74_0.selectPoolId_ ~= -1 then
		arg_74_0:HidePoolNewTag(arg_74_0.selectPoolId_, true)
	end
end

function var_0_0.StopInteract(arg_75_0)
	SetActive(arg_75_0.drawInteractGo_, false)
	arg_75_0:PlayMovie(arg_75_0.maxRare or 0)
end

function var_0_0.Dispose(arg_76_0)
	for iter_76_0, iter_76_1 in ipairs(arg_76_0.leftToggleItemList_) do
		iter_76_1:Dispose()
	end

	arg_76_0.leftToggleItemList_ = nil

	for iter_76_2, iter_76_3 in ipairs(arg_76_0.leftGroupItemList_) do
		iter_76_3:Dispose()
	end

	arg_76_0.leftGroupItemList_ = nil

	if arg_76_0.bonusView_ then
		arg_76_0.bonusView_:Dispose()

		arg_76_0.bonusView_ = nil
	end

	arg_76_0.currencyModifyHandler_ = nil
	arg_76_0.timer = nil

	arg_76_0:DestroyPoolGo()
	arg_76_0.tree_:Dispose()

	arg_76_0.drawHandler_ = nil

	var_0_0.super.Dispose(arg_76_0)
end

function var_0_0.CurrencyModify(arg_77_0)
	arg_77_0:RefreshRightPanel()
end

function var_0_0.UpdateFirstSelectButton(arg_78_0, arg_78_1)
	SetActive(arg_78_0.chooseBtn_.gameObject, not arg_78_1)
	SetActive(arg_78_0.btnOnce_.gameObject, arg_78_1)
	SetActive(arg_78_0.btnTenth_.gameObject, arg_78_1)

	local var_78_0 = DrawPoolCfg[arg_78_0.selectPoolId_]

	arg_78_0.chooseText_.text = GetTips(var_78_0.pool_selected_type == 9 and "DRAW_WEAPON_BUTTON" or "DRAW_CHARACTER_BUTTON")
end

function var_0_0.OnInviteDrawUpdate(arg_79_0)
	arg_79_0:UpdateFreeDraw()
end

function var_0_0.AdaptRight(arg_80_0)
	var_0_0.super.AdaptRight(arg_80_0)

	if var_0_0.VIEW_ADAPT_DISTANCE == arg_80_0.lastAdaptDistance_ then
		return
	end

	if not var_0_0.NEED_ADAPT then
		arg_80_0.btnSkip_.transform.anchoredPosition = Vector3(0, 0, 0)
		arg_80_0.skipInteractBtn_.transform.anchoredPosition = Vector3(0, 0, 0)
	else
		arg_80_0.btnSkip_.transform.anchoredPosition = Vector3(-1 * var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)
		arg_80_0.skipInteractBtn_.transform.anchoredPosition = Vector3(-1 * var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)
	end
end

return var_0_0
