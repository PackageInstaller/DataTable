local var_0_0 = class("GuildActivityElitePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityElitePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
	arg_5_0.isBeginController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "isBegin")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.giveupLockedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_ELITE_GRID_GIVEUP_CONFIRM"),
			OkCallback = function()
				GuildActivityAction.UnlockNode(arg_6_0.params_.nodeId)
				arg_6_0:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_11_0 = GuildActivityData:GetNodeData(arg_6_0.params_.nodeId)

		if var_11_0.occupied_num + var_11_0.processing_num >= 10 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_GRID_OCCUPY_MAX"),
				OkCallback = function()
					arg_6_0:TipsOkCallBack()
				end
			})

			return
		end

		if GuildActivityData:GetMyOccupiedNum() >= GuildActivityData:GetMaxOccupyCount() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_SELF_OCCUPY_MAX"),
				OkCallback = function()
					arg_6_0:TipsOkCallBack()
				end
			})

			return
		end

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
		GuildActivityAction.LockNode(arg_6_0.params_.nodeId)
	end)
	arg_6_0:AddBtnListener(arg_6_0.goonBtn_, nil, function()
		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_NORMAL_GRID_GIVEUP_CONFIRM"),
			OkCallback = function()
				arg_6_0:TipsOkCallBack()
				GuildActivityAction.GiveUpNode(arg_6_0.nodeCfg_.id)
				arg_6_0:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.TipsOkCallBack(arg_18_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	if arg_18_0.delayTimer_ then
		arg_18_0.delayTimer_:Stop()
	end

	arg_18_0.delayTimer_ = FrameTimer.New(function()
		GuildActivityLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	end, 1, 1)

	arg_18_0.delayTimer_:Start()
end

function var_0_0.AddEventListeners(arg_20_0)
	arg_20_0:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_21_0)
		if table.indexof(arg_21_0, arg_20_0.params_.nodeId) then
			arg_20_0:UpdateView()
			arg_20_0:UpdateTimer()
		end
	end)
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:UpdateBar()
end

function var_0_0.OnBehind(arg_23_0)
	return
end

function var_0_0.UpdateBar(arg_24_0)
	return
end

function var_0_0.OnEnter(arg_25_0)
	arg_25_0:AddEventListeners()

	arg_25_0.nodeCfg_ = ActivityClubCfg[arg_25_0.params_.nodeId]

	arg_25_0:UpdateView()
	arg_25_0:StartTimer()
	arg_25_0:UpdateTimer()
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:RemoveAllEventListener()
	arg_26_0:StopTimer()

	if arg_26_0.delayTimer_ then
		arg_26_0.delayTimer_:Stop()
	end
end

function var_0_0.StartTimer(arg_27_0)
	if arg_27_0.timer_ == nil then
		arg_27_0.timer_ = Timer.New(function()
			arg_27_0:UpdateTimer()
		end, 1, -1)
	end

	arg_27_0.timer_:Start()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_30_0)
	local var_30_0 = GuildActivityData:GetSelfNodeData(arg_30_0.params_.nodeId)

	if var_30_0 ~= nil then
		local var_30_1 = var_30_0.processing_timestamp
		local var_30_2 = manager.time:GetServerTime()

		if var_30_0.processing_type == 3 and var_30_1 > 0 and var_30_2 < var_30_1 then
			SetActive(arg_30_0.countdownLabel_.gameObject, true)

			arg_30_0.countdownLabel_.text = manager.time:DescCDTime(var_30_1 - var_30_2)
		else
			SetActive(arg_30_0.countdownLabel_.gameObject, false)
		end
	else
		SetActive(arg_30_0.countdownLabel_.gameObject, false)
	end
end

function var_0_0.UpdateView(arg_31_0)
	local var_31_0 = GuildActivityData:GetNodeData(arg_31_0.params_.nodeId)

	arg_31_0.titleLabel_.text = GetI18NText(BattleClubActivityCfg[arg_31_0.nodeCfg_.stage_id].name)
	arg_31_0.levelLabel_.text = "Lv." .. arg_31_0.nodeCfg_.level
	arg_31_0.recoverLabel_.text = "+" .. GetI18NText(arg_31_0.nodeCfg_.token_get)

	local var_31_1 = 10 - var_31_0.history_occupied_num

	if var_31_1 < 1 then
		var_31_1 = 1
	end

	arg_31_0.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_31_1))
	arg_31_0.difficultyReduceLabel_.text = tostring(100 - var_31_1 * 10) .. "%"
	arg_31_0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_ATTACK_DESC"), var_31_0.occupied_num, var_31_0.processing_num)
	arg_31_0.energyCostLabel_.text = arg_31_0.nodeCfg_.vitality_cost

	if GuildActivityData:IsMyOccupiedNode(arg_31_0.params_.nodeId) then
		arg_31_0.statusController_:SetSelectedState("occupied")
		arg_31_0.isBeginController_:SetSelectedState("false")
	else
		local var_31_2 = GuildActivityData:GetSelfNodeData(arg_31_0.params_.nodeId)

		if var_31_2 ~= nil and var_31_2.processing_timestamp > 0 and manager.time:GetServerTime() < var_31_2.processing_timestamp then
			arg_31_0.statusController_:SetSelectedState("continue")
		elseif var_31_0.occupied_num + var_31_0.processing_num >= 10 then
			arg_31_0.statusController_:SetSelectedState("full")
		elseif GuildActivityData:IsNodeCanReach(arg_31_0.params_.nodeId) then
			arg_31_0.statusController_:SetSelectedState("unoccupy")
		else
			arg_31_0.statusController_:SetSelectedState("unreach")
		end

		if var_31_2 then
			arg_31_0.isBeginController_:SetSelectedState("true")

			local var_31_3 = math.floor(100 - var_31_2.elite_health_rate)

			arg_31_0.attackingProgressLabel_.text = tostring(var_31_3) .. "%"
			arg_31_0.progressImage_.fillAmount = var_31_3 / 100
		else
			arg_31_0.isBeginController_:SetSelectedState("false")

			arg_31_0.attackingProgressLabel_.text = "0%"
			arg_31_0.progressImage_.fillAmount = 0
		end
	end
end

function var_0_0.OnMainHomeViewTop(arg_32_0)
	return
end

function var_0_0.Dispose(arg_33_0)
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
