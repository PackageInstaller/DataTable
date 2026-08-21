local var_0_0 = class("GuildManagerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubManagementUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.tree_ = LuaTree.New(arg_3_0.goTree_)

	arg_3_0.tree_:SetSelectedHandler(handler(arg_3_0, arg_3_0.OnGroupSelect), handler(arg_3_0, arg_3_0.OnItemSelect))

	arg_3_0.memberUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, GuildManagerItem)
	arg_3_0.isManagerController_ = arg_3_0.controller:GetController("isManager")
	arg_3_0.showContributeController = arg_3_0.controller:GetController("showContribute")
	arg_3_0.btnController = arg_3_0.controller:GetController("btnState")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshBar()
	arg_4_0:RefreshToggleType()
	arg_4_0:RefreshList()
	arg_4_0:RegisterEvent()
	arg_4_0:RefreshEnterToggle()
	arg_4_0:StartTimer()
	arg_4_0:BindRedPoint()
end

function var_0_0.RefreshBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function var_0_0.StartTimer(arg_6_0)
	if not arg_6_0.refreshTimer then
		arg_6_0.refreshTimer = Timer.New(function()
			arg_6_0:RefreshItemTimer()
		end, 1, -1)

		arg_6_0.refreshTimer:Start()
	end
end

function var_0_0.RefreshItemTimer(arg_8_0)
	if arg_8_0.memberList_ then
		for iter_8_0 = 1, #arg_8_0.memberList_ do
			local var_8_0 = arg_8_0.memberUIList_:GetItemByIndex(iter_8_0)

			if var_8_0 then
				var_8_0:RefreshTimer()
			end
		end
	end
end

function var_0_0.RefreshEnterToggle(arg_9_0)
	if arg_9_0.params_.isBack then
		if arg_9_0.page_ then
			local var_9_0 = arg_9_0.page_
			local var_9_1 = 1

			if arg_9_0.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
				var_9_0 = GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE
				var_9_1 = 2
			end

			arg_9_0.tree_:SelectItem(var_9_0, var_9_1)
		elseif arg_9_0.params_.userID then
			local var_9_2 = GuildData:GetGuildMemberIDList()
			local var_9_3 = false

			for iter_9_0, iter_9_1 in ipairs(var_9_2) do
				if iter_9_1 == arg_9_0.params_.userID then
					arg_9_0.tree_:SelectGroup(1)

					var_9_3 = true

					break
				end
			end

			if not var_9_3 then
				arg_9_0.tree_:SelectGroup(2)
			end

			arg_9_0.params_.userID = nil
		end
	else
		arg_9_0.tree_:SelectGroup(1)
	end
end

function var_0_0.RefreshList(arg_10_0)
	arg_10_0.memberIDList_ = GuildData:GetGuildMemberIDList()
	arg_10_0.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	arg_10_0.memberContributeList_ = GuildData:GetGuildContributeList()
end

function var_0_0.RegisterEvent(arg_11_0)
	arg_11_0:RegistEventListener(GUILD_REFRESH_MEMBER, handler(arg_11_0, arg_11_0.RefreshMember))
	arg_11_0:RegistEventListener(GUILD_REFRESH_REQUEST, handler(arg_11_0, arg_11_0.RefreshRequest))
end

function var_0_0.BindRedPoint(arg_12_0)
	manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function var_0_0.UnBindRedPoint(arg_13_0)
	manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function var_0_0.OnExit(arg_14_0)
	if arg_14_0.memberUIList_ then
		arg_14_0.memberUIList_:StopRender()
	end

	arg_14_0:StopTimer()

	arg_14_0.scrollPos_ = clone(arg_14_0.memberUIList_:GetScrolledPosition())

	arg_14_0:UnBindRedPoint()
	manager.windowBar:HideBar()
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.refreshTimer then
		arg_15_0.refreshTimer:Stop()

		arg_15_0.refreshTimer = nil
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.tree_ then
		arg_16_0.tree_:Dispose()

		arg_16_0.tree_ = nil
	end

	if arg_16_0.memberUIList_ then
		arg_16_0.memberUIList_:Dispose()

		arg_16_0.memberUIList_ = nil
	end

	arg_16_0:StopTimer()
end

function var_0_0.AddListeners(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.buttonSetting_, nil, function()
		JumpTools.OpenPageByJump("guildRequestSetting")
	end)
	arg_17_0:AddBtnListener(arg_17_0.buttonExit_, nil, function()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function()
				local var_20_0 = GuildData:GetGuildInfo().id

				GuildAction.GuildExit(var_20_0, function(arg_21_0)
					if isSuccess(arg_21_0.result) then
						JumpTools.OpenPageByJump("/home")
					else
						ShowTips(arg_21_0.result)
					end
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.OnGroupSelect(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		arg_23_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)
	elseif arg_23_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		arg_23_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)
	elseif arg_23_1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		arg_23_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.REQUEST)
	end
end

function var_0_0.OnItemSelect(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_1 == 1 then
		arg_24_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		arg_24_0.lastPage_ = 2
		arg_24_0.lastPageIndex_ = 1
	else
		arg_24_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		arg_24_0.lastPageIndex_ = 2
	end
end

function var_0_0.RefreshItem(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2:SetData(arg_25_0.memberList_[arg_25_1], arg_25_0.page_ ~= GuildConst.MEMBER_LIST_TYPE.REQUEST, arg_25_0.page_)
end

function var_0_0.SwitchPage(arg_26_0, arg_26_1)
	arg_26_0.showContributeController:SetSelectedState("member")

	if arg_26_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		arg_26_0.memberList_ = GuildData:GetGuildMemberIDList()
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		arg_26_0.showContributeController:SetSelectedState("request")

		arg_26_0.memberList_ = GuildData:GetGuildRequestIDList()
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		arg_26_0.showContributeController:SetSelectedState("contribute")

		arg_26_0.memberList_ = arg_26_0.memberContributeList_
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE then
		arg_26_0.showContributeController:SetSelectedState("contribute")

		arg_26_0.memberList_ = arg_26_0.memberWeekContributeList_
	end

	if arg_26_0.page_ ~= arg_26_1 then
		arg_26_0.page_ = arg_26_1

		arg_26_0.memberUIList_:StartScroll(#arg_26_0.memberList_)
	else
		arg_26_0.memberUIList_:StartScrollWithoutAnimator(#arg_26_0.memberList_, arg_26_0.scrollPos_)
	end
end

function var_0_0.RefreshMember(arg_27_0)
	arg_27_0:RefreshList()

	if arg_27_0.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		if GuildData:GetGuildInfo().post > GuildConst.GUILD_POST.DEPUTY then
			arg_27_0:Go("/guildEntrace/guildMain")
		else
			arg_27_0.scrollPos_ = clone(arg_27_0.memberUIList_:GetScrolledPosition())

			arg_27_0:SwitchPage(arg_27_0.page_)
		end
	end

	arg_27_0:RefreshToggleType()
end

function var_0_0.RefreshRequest(arg_28_0)
	if arg_28_0.page_ == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		arg_28_0.scrollPos_ = clone(arg_28_0.memberUIList_:GetScrolledPosition())

		arg_28_0:SwitchPage(arg_28_0.page_)
	end
end

function var_0_0.RefreshToggleType(arg_29_0)
	local var_29_0 = GuildData:GetGuildInfo()

	if var_29_0.post == GuildConst.GUILD_POST.CAPTAIN or var_29_0.post == GuildConst.GUILD_POST.DEPUTY then
		arg_29_0.isManagerController_:SetSelectedState("true")
		arg_29_0.btnController:SetSelectedState("high")

		arg_29_0.labelText_.text = GetTips("CLUB_BOSS_MENBER_SET")
	else
		arg_29_0.isManagerController_:SetSelectedState("false")
		arg_29_0.btnController:SetSelectedState("low")

		arg_29_0.labelText_.text = GetTips("CLUB_BOSS_MENBER_LIST")
	end
end

return var_0_0
