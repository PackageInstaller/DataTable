local var_0_0 = class("GuildMemberListView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/ClubUI/ClubMemberListUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.tree_ = LuaTree.New(arg_3_0.goTree_)

	arg_3_0.tree_:SetSelectedHandler(handler(arg_3_0, arg_3_0.OnGroupSelect), handler(arg_3_0, arg_3_0.OnItemSelect))

	arg_3_0.memberUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, GuildMemberItem)
	arg_3_0.exitGuildHandler_ = handler(arg_3_0, arg_3_0.ExitGuild)
	arg_3_0.refreshMemberHandler_ = handler(arg_3_0, arg_3_0.RefreshMember)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
	arg_4_0:RefreshList()

	if arg_4_0.params_.isBack then
		arg_4_0.tree_:SelectItem(arg_4_0.lastPage_ or 1, arg_4_0.lastPageIndex_ or 1)
	else
		arg_4_0.tree_:SelectGroup(1)
	end

	manager.notify:RegistListener(GUILD_EXIT, arg_4_0.exitGuildHandler_)
	manager.notify:RegistListener(GUILD_REFRESH_MEMBER, arg_4_0.refreshMemberHandler_)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.scrollPos_ = clone(arg_5_0.memberUIList_:GetScrolledPosition())

	if arg_5_0.memberUIList_ then
		arg_5_0.memberUIList_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(GUILD_EXIT, arg_5_0.exitGuildHandler_)
	manager.notify:RemoveListener(GUILD_REFRESH_MEMBER, arg_5_0.refreshMemberHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.tree_:Dispose()

	arg_6_0.tree_ = nil

	arg_6_0.memberUIList_:Dispose()

	arg_6_0.memberUIList_ = nil
	arg_6_0.exitGuildHandler_ = nil
	arg_6_0.refreshMemberHandler_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonExit_, nil, function()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function()
				local var_9_0 = GuildData:GetGuildInfo().id

				GuildAction.GuildExit(var_9_0, function(arg_10_0)
					if isSuccess(arg_10_0.result) then
						JumpTools.OpenPageByJump("/home")
					else
						ShowTips(arg_10_0.result)
					end
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.OnGroupSelect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_1 == 1 then
		arg_12_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)

		arg_12_0.lastPage_ = 1
	end
end

function var_0_0.OnItemSelect(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_1 == 1 then
		arg_13_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		arg_13_0.lastPage_ = 2
		arg_13_0.lastPageIndex_ = 1
	else
		arg_13_0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		arg_13_0.lastPageIndex_ = 2
	end
end

function var_0_0.RefreshItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.memberList_[arg_14_1], arg_14_0.page_ ~= GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)
end

function var_0_0.RefreshList(arg_15_0)
	arg_15_0.memberIDList_ = GuildData:GetGuildMemberIDList()
	arg_15_0.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	arg_15_0.memberContributeList_ = GuildData:GetGuildContributeList()
end

function var_0_0.SwitchPage(arg_16_0, arg_16_1)
	if arg_16_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		arg_16_0.memberList_ = arg_16_0.memberIDList_
	elseif arg_16_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		arg_16_0.memberList_ = arg_16_0.memberContributeList_
	else
		arg_16_0.memberList_ = arg_16_0.memberWeekContributeList_
	end

	if arg_16_0.page_ ~= arg_16_1 then
		arg_16_0.page_ = arg_16_1

		arg_16_0.memberUIList_:StartScroll(#arg_16_0.memberList_)
	else
		arg_16_0.memberUIList_:StartScrollWithoutAnimator(#arg_16_0.memberList_, arg_16_0.scrollPos_)
	end
end

function var_0_0.ExitGuild(arg_17_0)
	arg_17_0:Go("/home")
end

function var_0_0.RefreshMember(arg_18_0)
	arg_18_0:RefreshList()

	if arg_18_0.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		arg_18_0.memberList_ = arg_18_0.memberIDList_
	elseif arg_18_0.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		arg_18_0.memberList_ = arg_18_0.memberContributeList_
	else
		arg_18_0.memberList_ = arg_18_0.memberWeekContributeList_
	end

	local var_18_0 = arg_18_0.memberUIList_:GetScrolledPosition()

	arg_18_0.memberUIList_:StartScrollWithoutAnimator(#arg_18_0.memberList_, var_18_0)
end

return var_0_0
