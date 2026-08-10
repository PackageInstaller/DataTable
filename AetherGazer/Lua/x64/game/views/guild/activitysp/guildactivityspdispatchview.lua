local var_0_0 = class("GuildActivitySPDispatchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPDispatchUI"
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

	arg_5_0.eliteController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "elite")
	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.uiListGo_, GuildActivitySPDispatchItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetSelectHandler(handler(arg_6_0, arg_6_0.OnItemSelect))
	arg_6_2:SetData(arg_6_1, arg_6_0.allCatIds_[arg_6_1], arg_6_0.params_.nodeId)
	arg_6_2:SetSelect(arg_6_0.selectedIndex_ ~= nil and arg_6_1 == arg_6_0.selectedIndex_)
end

function var_0_0.OnItemSelect(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.allCatIds_[arg_7_1]
	local var_7_1
	local var_7_2 = GuildActivitySPData:GetCanDispatchCatList()

	if table.indexof(var_7_2, var_7_0) then
		-- block empty
	else
		for iter_7_0, iter_7_1 in ipairs(ActivityClubSPLevelSettingCfg.all) do
			local var_7_3 = ActivityClubSPLevelSettingCfg[iter_7_1]

			if table.indexof(var_7_3.dispatch, var_7_0) then
				ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_7_3.user_level)))

				return
			end
		end
	end

	if var_7_1 == arg_7_2 then
		return
	end

	if GuildActivitySPData:IsDispatchMax(arg_7_2) then
		ShowTips("ACTIVITY_CLUB_SP_DISPATCH_MAX")

		return
	end

	if GuildActivitySPData:IsCatDispatched(var_7_0) then
		local var_7_4 = ChipCfg[var_7_0].suit_name

		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_CLUB_SP_REDISPATCH_CONFIRM_TIP"), var_7_4),
			OkCallback = function()
				GuildActivitySPAction.Dispatch(arg_7_2, var_7_0)
			end,
			CancelCallback = function()
				return
			end
		})
	else
		GuildActivitySPAction.Dispatch(arg_7_2, var_7_0)
	end
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.bgBtn_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_12_0)
	arg_12_0:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function(arg_13_0, arg_13_1)
		ShowTips("CANTEEN_TASK_DISPATCH")
		arg_12_0:Back()
	end)
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:AddEventListeners()

	arg_17_0.allCatIds_ = GuildActivitySPData:GetAllDispatchCatList()

	arg_17_0.uiList_:StartScroll(#arg_17_0.allCatIds_)
	arg_17_0:UpdateView()
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_19_0)
	local var_19_0 = ActivityClubSPCfg[arg_19_0.params_.nodeId]

	arg_19_0.levelLabel_.text = "Lv." .. var_19_0.level
	arg_19_0.recoverLabel_.text = "+" .. var_19_0.token_get
	arg_19_0.gridName.text = GetTips(GuildActivitySPConst.NodeType[var_19_0.type])

	local var_19_1 = GuildActivitySPData:GetCurMainActivityID()
	local var_19_2 = GuildActivitySpTools.GetCurCurrencyID(var_19_1, 1)

	arg_19_0.cuyImg.sprite = ItemTools.getItemSprite(tonumber(var_19_2))
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
