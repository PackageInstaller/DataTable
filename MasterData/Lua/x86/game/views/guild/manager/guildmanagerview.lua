local GuildManagerView = class("GuildManagerView", ReduxView)

function GuildManagerView:UIName()
	return "Widget/System/Club/ClubManagementUI"
end

function GuildManagerView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildManagerView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.tree_ = LuaTree.New(self.goTree_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.memberUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, GuildManagerItem)
	self.isManagerController_ = self.controller:GetController("isManager")
	self.showContributeController = self.controller:GetController("showContribute")
	self.btnController = self.controller:GetController("btnState")
end

function GuildManagerView:OnEnter()
	self:RefreshBar()
	self:RefreshToggleType()
	self:RefreshList()
	self:RegisterEvent()
	self:RefreshEnterToggle()
	self:StartTimer()
	self:BindRedPoint()
end

function GuildManagerView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function GuildManagerView:StartTimer()
	if not self.refreshTimer then
		self.refreshTimer = Timer.New(function()
			self:RefreshItemTimer()
		end, 1, -1)

		self.refreshTimer:Start()
	end
end

function GuildManagerView:RefreshItemTimer()
	if self.memberList_ then
		for iter_8_0 = 1, #self.memberList_ do
			local var_8_0 = self.memberUIList_:GetItemByIndex(iter_8_0)

			if var_8_0 then
				var_8_0:RefreshTimer()
			end
		end
	end
end

function GuildManagerView:RefreshEnterToggle()
	if self.params_.isBack then
		if self.page_ then
			local var_9_0 = self.page_
			local var_9_1 = 1

			if self.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
				var_9_0 = GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE
				var_9_1 = 2
			end

			self.tree_:SelectItem(var_9_0, var_9_1)
		elseif self.params_.userID then
			local var_9_2 = false

			for iter_9_0, iter_9_1 in ipairs((GuildData:GetGuildMemberIDList())) do
				if iter_9_1 == self.params_.userID then
					self.tree_:SelectGroup(1)

					var_9_2 = true

					break
				end
			end

			if not var_9_2 then
				self.tree_:SelectGroup(2)
			end

			self.params_.userID = nil
		end
	else
		self.tree_:SelectGroup(1)
	end
end

function GuildManagerView:RefreshList()
	self.memberIDList_ = GuildData:GetGuildMemberIDList()
	self.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	self.memberContributeList_ = GuildData:GetGuildContributeList()
end

function GuildManagerView:RegisterEvent()
	self:RegistEventListener(GUILD_REFRESH_MEMBER, handler(self, self.RefreshMember))
	self:RegistEventListener(GUILD_REFRESH_REQUEST, handler(self, self.RefreshRequest))
end

function GuildManagerView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function GuildManagerView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function GuildManagerView:OnExit()
	if self.memberUIList_ then
		self.memberUIList_:StopRender()
	end

	self:StopTimer()

	self.scrollPos_ = clone(self.memberUIList_:GetScrolledPosition())

	self:UnBindRedPoint()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function GuildManagerView:StopTimer()
	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end
end

function GuildManagerView:Dispose()
	GuildManagerView.super.Dispose(self)

	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.memberUIList_ then
		self.memberUIList_:Dispose()

		self.memberUIList_ = nil
	end

	self:StopTimer()
end

function GuildManagerView:AddListeners()
	self:AddBtnListener(self.buttonSetting_, nil, function()
		JumpTools.OpenPageByJump("guildRequestSetting")
	end)
	self:AddBtnListener(self.buttonExit_, nil, function()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function()
				GuildAction.GuildExit(GuildData:GetGuildInfo().id, function(arg_21_0)
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

function GuildManagerView:OnGroupSelect(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)
	elseif arg_23_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)
	elseif arg_23_1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.REQUEST)
	end
end

function GuildManagerView:OnItemSelect(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_1 == 1 then
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		self.lastPage_ = 2
		self.lastPageIndex_ = 1
	else
		self:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		self.lastPageIndex_ = 2
	end
end

function GuildManagerView:RefreshItem(arg_25_1, arg_25_2)
	arg_25_2:SetData(self.memberList_[arg_25_1], self.page_ ~= GuildConst.MEMBER_LIST_TYPE.REQUEST, self.page_)
end

function GuildManagerView:SwitchPage(arg_26_1)
	self.showContributeController:SetSelectedState("member")

	if arg_26_1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		self.memberList_ = GuildData:GetGuildMemberIDList()
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		self.showContributeController:SetSelectedState("request")

		self.memberList_ = GuildData:GetGuildRequestIDList()
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		self.showContributeController:SetSelectedState("contribute")

		self.memberList_ = self.memberContributeList_
	elseif arg_26_1 == GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE then
		self.showContributeController:SetSelectedState("contribute")

		self.memberList_ = self.memberWeekContributeList_
	end

	if self.page_ ~= arg_26_1 then
		self.page_ = arg_26_1

		self.memberUIList_:StartScroll(#self.memberList_)
	else
		self.memberUIList_:StartScrollWithoutAnimator(#self.memberList_, self.scrollPos_)
	end
end

function GuildManagerView:RefreshMember()
	self:RefreshList()

	if self.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		if GuildData:GetGuildInfo().post > GuildConst.GUILD_POST.DEPUTY then
			self:Go("/guildEntrace/guildMain")
		else
			self.scrollPos_ = clone(self.memberUIList_:GetScrolledPosition())

			self:SwitchPage(self.page_)
		end
	end

	self:RefreshToggleType()
end

function GuildManagerView:RefreshRequest()
	if self.page_ == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		self.scrollPos_ = clone(self.memberUIList_:GetScrolledPosition())

		self:SwitchPage(self.page_)
	end
end

function GuildManagerView:RefreshToggleType()
	local var_29_0 = GuildData:GetGuildInfo()

	if var_29_0.post == GuildConst.GUILD_POST.CAPTAIN or var_29_0.post == GuildConst.GUILD_POST.DEPUTY then
		self.isManagerController_:SetSelectedState("true")
		self.btnController:SetSelectedState("high")

		self.labelText_.text = GetTips("CLUB_BOSS_MENBER_SET")
	else
		self.isManagerController_:SetSelectedState("false")
		self.btnController:SetSelectedState("low")

		self.labelText_.text = GetTips("CLUB_BOSS_MENBER_LIST")
	end
end

return GuildManagerView
