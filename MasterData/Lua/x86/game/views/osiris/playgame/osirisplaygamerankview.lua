local OsirisPlayGameRankView = class("OsirisPlayGameRankView", ReduxView)

function OsirisPlayGameRankView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_RankUI"
end

function OsirisPlayGameRankView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisPlayGameRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameRankView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, OsirisPlayGameRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.tabConList_ = {}

	for iter_4_0 = 1, 6 do
		self.tabConList_[iter_4_0] = ControllerUtil.GetController(self["tab_" .. iter_4_0].gameObject.transform, "name")
	end
end

function OsirisPlayGameRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1)
end

function OsirisPlayGameRankView:AddUIListener()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(1)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(2)
	end)

	for iter_6_0 = 1, 6 do
		self:AddBtnListener(self["tab_" .. iter_6_0], nil, function()
			if self.selectIndex == iter_6_0 then
				return
			end

			self.selectIndex = iter_6_0
			self.activityID = ActivityCfg[self.rankActivityID].sub_activity_list[self.selectIndex]

			RankAction.QueryActivityRank(self.activityID)
			self:RefreshTab(iter_6_0)
			self:SwitchPage(2)
		end)
	end
end

function OsirisPlayGameRankView:SwitchPage(arg_10_1)
	if self.tabConState_ == nil then
		self.tabConState_ = {
			"club",
			"all"
		}
	end

	self.tabController_:SetSelectedState(self.tabConState_[arg_10_1])

	self.curPage_ = arg_10_1
	self.rankData = self:GetListFromIndex(arg_10_1)

	self:UpdateView()
end

function OsirisPlayGameRankView:SwitchPageIfDiff(arg_11_1)
	if self.curPage_ ~= arg_11_1 then
		self:SwitchPage(arg_11_1)
	end
end

function OsirisPlayGameRankView:UpdateView()
	self.list:StartScroll(#self.rankData)

	local var_12_0 = RankData[self.curPage_ == 1 and "GetGuildActivityRank" or "GetActivityRank"](RankData, self.activityID)

	if var_12_0 then
		local var_12_1, var_12_2 = var_12_0:GetCurRankDes()

		self.myScoreLabel_.text = var_12_2
		self.myRankLabel_.text = var_12_1
	else
		self.myScoreLabel_.text = ""
		self.myRankLabel_.text = ""
	end
end

function OsirisPlayGameRankView:OnEnter()
	self.selectIndex = 1
	self.rankActivityID = ActivityCfg[self.params_.activityID].sub_activity_list[1]
	self.activityID = ActivityCfg[self.rankActivityID].sub_activity_list[self.selectIndex]

	RankAction.QueryActivityRank(self.activityID)

	self.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	local var_13_0 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_13_0 and "02" or "01")

	if var_13_0 then
		RankAction.QueryGuildActivityRank(self.activityID)
	end

	self:RefreshTab(1)
end

function OsirisPlayGameRankView:RefreshTab(arg_14_1)
	for iter_14_0 = 1, 6 do
		self.tabConList_[iter_14_0]:SetSelectedIndex(iter_14_0 == arg_14_1 and 0 or 1)
	end
end

function OsirisPlayGameRankView:GetListFromIndex(arg_15_1)
	if arg_15_1 == 1 then
		local var_15_0 = RankData:GetGuildActivityRank(self.activityID)

		return (var_15_0 or nil) and (var_15_0.rankList or {})
	else
		local var_15_1 = RankData:GetActivityRank(self.activityID)

		return (var_15_1 or nil) and (var_15_1.rankList or {})
	end
end

function OsirisPlayGameRankView:OnExit()
	manager.windowBar:HideBar()
end

function OsirisPlayGameRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function OsirisPlayGameRankView:OnRankUpdate()
	self:SwitchPage(2)

	self.isInit_ = true
end

function OsirisPlayGameRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	if self.tabConList_ then
		self.tabConList_ = nil
	end

	OsirisPlayGameRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return OsirisPlayGameRankView
