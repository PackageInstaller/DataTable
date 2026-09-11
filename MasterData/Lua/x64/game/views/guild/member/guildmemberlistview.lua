local GuildMemberListView = class("GuildMemberListView", ReduxView)

function GuildMemberListView:UIName()
	return "UI/ClubUI/ClubMemberListUI_new"
end

function GuildMemberListView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildMemberListView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.tree_ = LuaTree.New(self.goTree_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.memberUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, GuildMemberItem)
	self.exitGuildHandler_ = handler(self, self.ExitGuild)
	self.refreshMemberHandler_ = handler(self, self.RefreshMember)
end

function GuildMemberListView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
	self:RefreshList()

	if self.params_.isBack then
		self.tree_:SelectItem(self.lastPage_ or 1, self.lastPageIndex_ or 1)
	else
		self.tree_:SelectGroup(1)
	end

	manager.notify:RegistListener(GUILD_EXIT, self.exitGuildHandler_)
	manager.notify:RegistListener(GUILD_REFRESH_MEMBER, self.refreshMemberHandler_)
end

function GuildMemberListView:OnExit()
	self.scrollPos_ = clone(self.memberUIList_:GetScrolledPosition())

	if self.memberUIList_ then
		self.memberUIList_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(GUILD_EXIT, self.exitGuildHandler_)
	manager.notify:RemoveListener(GUILD_REFRESH_MEMBER, self.refreshMemberHandler_)
end

function GuildMemberListView:Dispose()
	GuildMemberListView.super.Dispose(self)
	self.tree_:Dispose()

	self.tree_ = nil

	self.memberUIList_:Dispose()

	self.memberUIList_ = nil
	self.exitGuildHandler_ = nil
	self.refreshMemberHandler_ = nil
end

function GuildMemberListView:AddListeners()
	self:AddBtnListener(self.buttonExit_, nil, function()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function()
				GuildAction.GuildExit(GuildData:GetGuildInfo().id, function(arg_10_0)
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

function GuildMemberListView:OnGroupSelect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_1 == 1 then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)

		self.lastPage_ = 1
	end
end

function GuildMemberListView:OnItemSelect(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_1 == 1 then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		self.lastPage_ = 2
		self.lastPageIndex_ = 1
	else
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		self.lastPageIndex_ = 2
	end
end

function GuildMemberListView:RefreshItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.memberList_[arg_14_1], self.page_ ~= GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)
end

function GuildMemberListView:RefreshList()
	self.memberIDList_ = GuildData:GetGuildMemberIDList()
	self.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	self.memberContributeList_ = GuildData:GetGuildContributeList()
end

function GuildMemberListView:SwitchPage(arg_16_1)
	self.memberList_ = arg_16_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER and self.memberIDList_ or arg_16_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE and self.memberContributeList_ or self.memberWeekContributeList_

	if self.page_ ~= arg_16_1 then
		self.page_ = arg_16_1

		self.memberUIList_:StartScroll(#self.memberList_)
	else
		self.memberUIList_:StartScrollWithoutAnimator(#self.memberList_, self.scrollPos_)
	end
end

function GuildMemberListView:ExitGuild()
	self:Go("/home")
end

function GuildMemberListView:RefreshMember()
	self:RefreshList()

	self.memberList_ = self.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER and self.memberIDList_ or self.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE and self.memberContributeList_ or self.memberWeekContributeList_

	self.memberUIList_:StartScrollWithoutAnimator(#self.memberList_, (self.memberUIList_:GetScrolledPosition()))
end

return GuildMemberListView
