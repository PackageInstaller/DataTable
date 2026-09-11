local HodurRankView = class("HodurRankView", ReduxView)

function HodurRankView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_RankUI"
end

function HodurRankView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HodurRankView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, HodurRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function HodurRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1)
end

function HodurRankView:AddUIListener()
	return
end

function HodurRankView:UpdateView()
	local var_7_0 = RankData:GetActivityRank(self.rankActivityID)

	self.rankData = var_7_0.rankList

	self.list:StartScroll(#self.rankData)

	if var_7_0 then
		local var_7_1, var_7_2 = var_7_0:GetCurRankDes()

		self.myScoreLabel_.text = var_7_2
		self.myRankLabel_.text = var_7_1
	else
		self.myScoreLabel_.text = ""
		self.myRankLabel_.text = ""
	end
end

function HodurRankView:OnEnter()
	self.selectIndex = 1
	self.rankActivityID = ActivityCfg[self.params_.activityID].sub_activity_list[1]

	RankAction.QueryActivityRank(self.rankActivityID)

	self.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function HodurRankView:OnExit()
	manager.windowBar:HideBar()
end

function HodurRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HodurRankView:OnRankUpdate()
	self:UpdateView()

	self.isInit_ = true
end

function HodurRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	HodurRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return HodurRankView
