local GuildActivitySPDispatchView = class("GuildActivitySPDispatchView", ReduxView)

function GuildActivitySPDispatchView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPDispatchUI"
end

function GuildActivitySPDispatchView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPDispatchView:OnCtor()
	return
end

function GuildActivitySPDispatchView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPDispatchView:InitUI()
	self:BindCfgUI()

	self.eliteController_ = ControllerUtil.GetController(self.gameObject_.transform, "elite")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, GuildActivitySPDispatchItemView)
end

function GuildActivitySPDispatchView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetSelectHandler(handler(self, self.OnItemSelect))
	arg_6_2:SetData(arg_6_1, self.allCatIds_[arg_6_1], self.params_.nodeId)
	arg_6_2:SetSelect(self.selectedIndex_ ~= nil and arg_6_1 == self.selectedIndex_)
end

function GuildActivitySPDispatchView:OnItemSelect(arg_7_1, arg_7_2)
	local var_7_0 = self.allCatIds_[arg_7_1]
	local var_7_1

	if table.indexof(GuildActivitySPData:GetCanDispatchCatList(), self.allCatIds_[arg_7_1]) then
		-- block empty
	else
		for iter_7_0, iter_7_1 in ipairs(ActivityClubSPLevelSettingCfg.all) do
			if table.indexof(ActivityClubSPLevelSettingCfg[iter_7_1].dispatch, var_7_0) then
				ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(ActivityClubSPLevelSettingCfg[iter_7_1].user_level)))

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
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_CLUB_SP_REDISPATCH_CONFIRM_TIP"), ChipCfg[var_7_0].suit_name),
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

function GuildActivitySPDispatchView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPDispatchView:AddEventListeners()
	self:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function(arg_13_0, arg_13_1)
		ShowTips("CANTEEN_TASK_DISPATCH")
		self:Back()
	end)
end

function GuildActivitySPDispatchView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPDispatchView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySPDispatchView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function GuildActivitySPDispatchView:OnEnter()
	self:AddEventListeners()

	self.allCatIds_ = GuildActivitySPData:GetAllDispatchCatList()

	self.uiList_:StartScroll(#self.allCatIds_)
	self:UpdateView()
end

function GuildActivitySPDispatchView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildActivitySPDispatchView:UpdateView()
	self.levelLabel_.text = "Lv." .. ActivityClubSPCfg[self.params_.nodeId].level
	self.recoverLabel_.text = "+" .. ActivityClubSPCfg[self.params_.nodeId].token_get
	self.gridName.text = GetTips(GuildActivitySPConst.NodeType[ActivityClubSPCfg[self.params_.nodeId].type])
	self.cuyImg.sprite = ItemTools.getItemSprite(tonumber((GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1))))
end

function GuildActivitySPDispatchView:OnMainHomeViewTop()
	return
end

function GuildActivitySPDispatchView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	GuildActivitySPDispatchView.super.Dispose(self)
end

return GuildActivitySPDispatchView
