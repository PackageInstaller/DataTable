local NewWarChessLevelView = class("NewWarChessLevelView", ReduxView)

function NewWarChessLevelView:UIName()
	return "UI/NewWarChess/NewWarChessEntryUI"
end

function NewWarChessLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessLevelView:InitUI()
	self:BindCfgUI()

	self.newChessList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, NewWarChessLevelItem)
end

function NewWarChessLevelView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(NewWarChessLevelCfg.get_id_list_by_activity[self.subActivityIDList_[arg_5_1]][1])
	arg_5_2:SetEventListener()
end

function NewWarChessLevelView:AddUIListener()
	return
end

function NewWarChessLevelView:OnEnter()
	self.activityID_ = self.params_.ActivityID
	self.subActivityIDList_ = ActivityCfg[self.activityID_].sub_activity_list

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]) do
		if ItemCfg[iter_7_1].time[2][1] == self.activityID_ then
			table.insert(var_7_0, iter_7_1)
		end
	end

	local var_7_1 = {
		BACK_BAR,
		HOME_BAR
	}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_3)
	end

	manager.windowBar:SwitchBar(var_7_1)

	for iter_7_4, iter_7_5 in pairs(var_7_0) do
		manager.windowBar:SetBarCanAdd(iter_7_5, true)
	end

	self:RefreshUI()
end

function NewWarChessLevelView:RefreshUI()
	self.newChessList_:StartScroll(#self.subActivityIDList_)

	for iter_8_0, iter_8_1 in pairs((self.newChessList_:GetItemList())) do
		iter_8_1:SetEventListener()
		iter_8_1:CreatTimer()
	end

	self.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover", self.activityID_)[1])
end

function NewWarChessLevelView:OnNewWarChessLevelInfoUpdate()
	self.newChessList_:Refresh()
end

function NewWarChessLevelView:OnExit()
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in pairs((self.newChessList_:GetItemList())) do
		iter_10_1:RemoveEventListener()
		iter_10_1:StopTimer()
	end
end

function NewWarChessLevelView:Dispose()
	if self.newChessList_ then
		self.newChessList_:Dispose()

		self.newChessList_ = nil
	end

	self.super.Dispose(self)
end

return NewWarChessLevelView
