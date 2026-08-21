local var_0_0 = class("IndiaNianMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageItemList_ = {}

	for iter_4_0 = 1, 8 do
		local var_4_0 = arg_4_0["stageGo_" .. iter_4_0]
		local var_4_1 = IndiaNianStageItem.New(var_4_0)

		table.insert(arg_4_0.stageItemList_, var_4_1)
	end

	arg_4_0.lockController_ = ControllerUtil.GetController(arg_4_0.transform_, "lock")
	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.selectController_ = ControllerUtil.GetController(arg_4_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		local var_6_0 = ActivityShopCfg[arg_5_0.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			local var_6_2 = ActivityShopCfg[iter_6_1].shop_id
			local var_6_3 = ActivityData:GetActivityData(ShopListCfg[var_6_2].activity_id)

			if var_6_3 and var_6_3:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_4, var_6_5 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_4 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_5 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_5 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("indiaNianReward")
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bossStageBtn_, nil, function()
		IndiaNianData:SetMainSelectedIndex(0)
		arg_5_0:SetSelectedData(arg_5_0.bossCfg_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tokenBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			IndiaNianData:GetSelectedStageCost()[1]
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		IndiaNianData:SetMainSelectedIndex(0)
		arg_5_0:SetSelectedData(arg_5_0.bossCfg_)

		local var_11_0 = IndiaNianData:GetSelectedStageID()

		arg_5_0:Go("indiaNianStageInfo", {
			section = var_11_0,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
			callback = function()
				arg_5_0.stateController_:SetSelectedState("main")
				IndiaNianData:SetMainSelectedIndex(-1)
				arg_5_0:RefreshUI()
			end
		})

		arg_5_0.ani_.enabled = false

		arg_5_0.stateController_:SetSelectedState("detail")
	end)
	arg_5_0:AddBtnListener(arg_5_0.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/indiaNianDetail")

		if IndiaNianData:GetHasUnlockBuff() then
			saveData("ActivityIndiaNian" .. arg_5_0.activityID_ .. PlayerData:GetPlayerInfo().userID, "buffNum", IndiaNianData:GetClearBuffNum())
			manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, 0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_14_0 = GetTips("ACTIVITY_INDIA_NIAN_DESC")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_INDIA_NIAN_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_14_0
		})
	end)
end

function var_0_0.OnTaskListChange(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.OnDataUpdate(arg_16_0)
	arg_16_0:RefreshData()
	arg_16_0:RefreshUI()
end

function var_0_0.OnEnter(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_17_0.activityID_ = IndiaNianData:GetActivityID()
	arg_17_0.isInited = false

	arg_17_0:RefreshData()
	arg_17_0:RefreshUI()
	arg_17_0:AddTimer()
	arg_17_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_17_0, arg_17_0.RefreshUI))
	manager.redPoint:bindUIandKey(arg_17_0.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:bindUIandKey(arg_17_0.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
end

function var_0_0.SetSelectedData(arg_18_0, arg_18_1)
	IndiaNianData:SetSelectedStage(arg_18_1.stage_id)
	IndiaNianData:SetSelectedStageCost(arg_18_1.extra_cost)
	IndiaNianData:SetSelectedDestID(arg_18_1.id)
	arg_18_0:RefreshStageUI()
end

function var_0_0.RefreshData(arg_19_0)
	arg_19_0.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[arg_19_0.activityID_]
	arg_19_0.round = IndiaNianData:GetRound()

	SetActive(arg_19_0.maskBtn_.transform.gameObject, false)

	local var_19_0 = {}
	local var_19_1 = 1
	local var_19_2 = IndiaNianData:GetRound()

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.bossCfgIDList_) do
		local var_19_3 = IndiaNianCfg[iter_19_1]

		if var_19_3.group_id == 100 and var_19_2 >= var_19_3.round and var_19_3.stage_type == 0 then
			arg_19_0.bossCfg_ = var_19_3
		elseif var_19_3.group_id ~= 100 and not var_19_0[var_19_3.group_id] then
			arg_19_0.stageItemList_[var_19_1]:SetData(var_19_1, var_19_3)
			arg_19_0.stageItemList_[var_19_1]:SetCallBack(function(arg_20_0)
				IndiaNianData:SetMainSelectedIndex(arg_20_0)
				arg_19_0:RefreshStageUI()

				local var_20_0 = IndiaNianData:GetSelectedStageID()

				arg_19_0:Go("indiaNianStageInfo", {
					section = var_20_0,
					sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
					callback = function()
						arg_19_0.stateController_:SetSelectedState("main")
						IndiaNianData:SetMainSelectedIndex(-1)
						arg_19_0:RefreshUI()
					end
				})

				arg_19_0.ani_.enabled = false

				arg_19_0.stateController_:SetSelectedState("detail")
			end)

			var_19_0[var_19_3.group_id] = true
			var_19_1 = var_19_1 + 1
		end
	end

	if arg_19_0.bossCfg_.stage_type == 0 and arg_19_0.bossCfg_.round < IndiaNianData:GetRound() or arg_19_0.bossCfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(arg_19_0.bossCfg_.id) == 0 then
		local var_19_4 = IndiaNianCfg.get_id_list_by_group_id[arg_19_0.bossCfg_.group_id]

		for iter_19_2, iter_19_3 in ipairs(var_19_4) do
			local var_19_5 = IndiaNianCfg[iter_19_3]

			if var_19_5.activity_id == arg_19_0.bossCfg_.activity_id and var_19_5.stage_type == 1 then
				arg_19_0.bossCfg_ = var_19_5
			end
		end
	end

	if not arg_19_0.isInited then
		if var_19_2 == arg_19_0.bossCfg_.round then
			arg_19_0:SetSelectedData(arg_19_0.bossCfg_)
		else
			for iter_19_4, iter_19_5 in ipairs(arg_19_0.stageItemList_) do
				if iter_19_5.cfg_.round == var_19_2 then
					IndiaNianData:SetSelectedStage(iter_19_5.cfg_.stage_id)
					IndiaNianData:SetSelectedStageCost(iter_19_5.cfg_.extra_cost)

					if iter_19_5.cfg_.round < IndiaNianData:GetRound() or iter_19_5.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(iter_19_5.cfg_.id) == 0 then
						local var_19_6 = IndiaNianCfg.get_id_list_by_group_id[iter_19_5.cfg_.group_id]

						for iter_19_6, iter_19_7 in ipairs(var_19_6) do
							if IndiaNianCfg[iter_19_7].activity_id == iter_19_5.cfg_.activity_id and IndiaNianCfg[iter_19_7].stage_type == 1 then
								IndiaNianData:SetSelectedDestID(iter_19_7)
							end
						end

						break
					end

					IndiaNianData:SetSelectedDestID(iter_19_5.cfg_.id)

					break
				end
			end
		end

		arg_19_0.isInited = true
	end
end

function var_0_0.RefreshStageUI(arg_22_0)
	local var_22_0 = not IndiaNianData:IsBossRound(IndiaNianData:GetRound())

	arg_22_0.selectController_:SetSelectedState(tostring(IndiaNianData:GetMainSelectedIndex() == 0 and not var_22_0))

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.stageItemList_) do
		iter_22_1:RefreshUI()
	end

	arg_22_0.lockController_:SetSelectedState(tostring(var_22_0))
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:RefreshSliderBar()
	arg_23_0:RefreshStageUI()

	arg_23_0.tokenImg_.sprite = ItemTools.getItemSprite(IndiaNianData.GetSelectedStageCost()[1])
	arg_23_0.tokenNumText_.text = ItemTools.getItemNum(IndiaNianData.GetSelectedStageCost()[1]) .. "/" .. 15
end

function var_0_0.RefreshSliderBar(arg_24_0)
	local var_24_0 = IndiaNianData:GetCurrentHpByID(arg_24_0.bossCfg_.id) / IndiaNianData:GetTotalHp()

	if var_24_0 < 0.01 and IndiaNianData:GetCurrentHpByID(arg_24_0.bossCfg_.id) ~= 0 then
		var_24_0 = 0.01
	end

	arg_24_0.percentText_.text = math.ceil(var_24_0 * 100) .. "%"
	arg_24_0.barFilImg_.fillAmount = var_24_0
	arg_24_0.barLineTrs_.localPosition = Vector3(arg_24_0.barBgTrs_.rect.width * var_24_0 - arg_24_0.barBgTrs_.rect.width / 2, 0, 0)
end

function var_0_0.AddTimer(arg_25_0)
	local var_25_0 = ActivityData:GetActivityData(arg_25_0.activityID_).stopTime

	arg_25_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_25_0, nil, true)
	arg_25_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_25_0 then
			JumpTools.OpenPageByJump("/springFestivalMainV2")

			return
		end

		arg_25_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_25_0, nil, true)
	end, 1, -1)

	arg_25_0.timer_:Start()
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_27_0.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:unbindUIandKey(arg_27_0.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
	manager.windowBar:HideBar()
	arg_27_0.stateController_:SetSelectedState("main")

	arg_27_0.ani_.enabled = true

	arg_27_0.timer_:Stop()

	arg_27_0.timer_ = nil
end

function var_0_0.Dispose(arg_28_0)
	var_0_0.super.Dispose(arg_28_0)

	if arg_28_0.stageItemList_ then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.stageItemList_) do
			iter_28_1:Dispose()
		end

		arg_28_0.stageItemList_ = nil
	end
end

return var_0_0
