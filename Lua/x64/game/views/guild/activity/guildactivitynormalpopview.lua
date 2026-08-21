local var_0_0 = class("GuildActivityNormalPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityNormalPopUI"
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
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_8_0 = GuildActivityData:GetNodeData(arg_6_0.params_.nodeId)

		if var_8_0.occupied_num + var_8_0.processing_num >= 10 then
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

function var_0_0.TipsOkCallBack(arg_14_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	if arg_14_0.delayTimer_ then
		arg_14_0.delayTimer_:Stop()
	end

	arg_14_0.delayTimer_ = FrameTimer.New(function()
		GuildActivityLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	end, 1, 1)

	arg_14_0.delayTimer_:Start()
end

function var_0_0.AddEventListeners(arg_16_0)
	arg_16_0:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_17_0)
		if table.indexof(arg_17_0, arg_16_0.params_.nodeId) then
			arg_16_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0:UpdateBar()
end

function var_0_0.OnBehind(arg_19_0)
	return
end

function var_0_0.UpdateBar(arg_20_0)
	return
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:AddEventListeners()

	arg_21_0.nodeCfg_ = ActivityClubCfg[arg_21_0.params_.nodeId]

	arg_21_0:UpdateView()
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()

	if arg_22_0.delayTimer_ then
		arg_22_0.delayTimer_:Stop()
	end
end

function var_0_0.UpdateView(arg_23_0)
	local var_23_0 = GuildActivityData:GetNodeData(arg_23_0.params_.nodeId)

	arg_23_0.titleLabel_.text = GetI18NText(BattleClubActivityCfg[arg_23_0.nodeCfg_.stage_id].name)
	arg_23_0.levelLabel_.text = "Lv." .. arg_23_0.nodeCfg_.level
	arg_23_0.cdLabel_.text = "+" .. GetI18NText(arg_23_0.nodeCfg_.token_get)

	local var_23_1 = 10 - var_23_0.history_occupied_num

	if var_23_1 < 1 then
		var_23_1 = 1
	end

	arg_23_0.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_23_1))
	arg_23_0.difficultyReduceLabel_.text = tostring(100 - var_23_1 * 10) .. "%"
	arg_23_0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_ATTACK_DESC"), var_23_0.occupied_num, var_23_0.processing_num)
	arg_23_0.energyCostLabel_.text = arg_23_0.nodeCfg_.vitality_cost

	if GuildActivityData:IsMyOccupiedNode(arg_23_0.params_.nodeId) then
		arg_23_0.statusController_:SetSelectedState("occupied")
	elseif var_23_0.occupied_num + var_23_0.processing_num >= 10 then
		arg_23_0.statusController_:SetSelectedState("full")
	elseif GuildActivityData:IsNodeCanReach(arg_23_0.params_.nodeId) then
		arg_23_0.statusController_:SetSelectedState("unoccupy")
	else
		arg_23_0.statusController_:SetSelectedState("unreach")
	end
end

function var_0_0.OnMainHomeViewTop(arg_24_0)
	return
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
