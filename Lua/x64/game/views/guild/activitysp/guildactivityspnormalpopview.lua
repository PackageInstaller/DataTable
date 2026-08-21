local var_0_0 = class("GuildActivitySPNormalPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPNormalPopUI"
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
	arg_6_0:AddBtnListener(arg_6_0.goonBtn_, nil, function()
		arg_6_0:Back()
		JumpTools.OpenPageByJump("guildActivitySPDispatch", {
			nodeId = arg_6_0.params_.nodeId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_9_0 = GuildActivitySPData:GetCurRunActivityID()

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = var_9_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_SP_CANCEL_DISPATCH_CONFIRM_TIP"),
			OkCallback = function()
				GuildActivitySPAction.CancelDispatch(arg_6_0.nodeCfg_.id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.AddEventListeners(arg_13_0)
	arg_13_0:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_14_0)
		if table.indexof(arg_14_0, arg_13_0.params_.nodeId) then
			arg_13_0:UpdateView()
		end
	end)
	arg_13_0:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function(arg_15_0)
		if arg_15_0 == arg_13_0.params_.id then
			arg_13_0:Back()
		end
	end)
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
end

function var_0_0.OnBehind(arg_17_0)
	return
end

function var_0_0.UpdateBar(arg_18_0)
	return
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:AddEventListeners()

	arg_19_0.nodeCfg_ = ActivityClubSPCfg[arg_19_0.params_.nodeId]

	arg_19_0:UpdateView()
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_21_0)
	local var_21_0 = GuildActivitySPData:GetNodeData(arg_21_0.params_.nodeId)

	arg_21_0.titleLabel_.text = BattleClubActivitySPCfg[arg_21_0.nodeCfg_.stage_id].name
	arg_21_0.levelLabel_.text = "Lv." .. arg_21_0.nodeCfg_.level

	local var_21_1 = GuildActivitySPData:GetCurMainActivityID()

	arg_21_0.recoverImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_21_1, 1))
	arg_21_0.recoverLabel_.text = "+" .. arg_21_0.nodeCfg_.token_get

	local var_21_2 = 10 - var_21_0.occupied_num

	if var_21_2 < 1 then
		var_21_2 = 1
	end

	arg_21_0.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_21_2))
	arg_21_0.difficultyReduceLabel_.text = tostring(100 - var_21_2 * 10) .. "%"
	arg_21_0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_FIRST_BONUS_DESC"))

	local var_21_3 = BattleClubActivitySPCfg[arg_21_0.nodeCfg_.stage_id].drop_lib_id

	if var_21_3 ~= nil and var_21_3 > 0 then
		local var_21_4 = DropCfg[var_21_3].base_drop[1]

		arg_21_0.firstRecoverLabel_.text = var_21_4[2]
		arg_21_0.nodeRewardImg.sprite = ItemTools.getItemSprite(var_21_4[1])
	else
		arg_21_0.firstRecoverLabel_.text = "0"
	end

	arg_21_0.energyCostLabel_.text = arg_21_0.nodeCfg_.vitality_cost
	arg_21_0.informationLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_DISPATCH_INFO_TIP"), var_21_0.dispatch_num, 10)

	if GuildActivitySPData:IsMyOccupiedNode(arg_21_0.params_.nodeId) then
		if GuildActivitySPData:IsDispatched(arg_21_0.params_.nodeId) then
			arg_21_0.statusController_:SetSelectedState("cancel")

			local var_21_5 = GuildActivitySPData:GetSelfNodeData(arg_21_0.params_.nodeId)
		elseif GuildActivitySPData:IsDispatchMax(arg_21_0.params_.nodeId) then
			arg_21_0.statusController_:SetSelectedState("upper_limit")
		else
			arg_21_0.statusController_:SetSelectedState("dispatch")
		end
	elseif GuildActivitySPData:IsNodeCanReach(arg_21_0.params_.nodeId) then
		arg_21_0.statusController_:SetSelectedState("occupy")
	else
		arg_21_0.statusController_:SetSelectedState("unreachable")
	end
end

function var_0_0.OnMainHomeViewTop(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
