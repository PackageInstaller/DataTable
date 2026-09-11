local HellaPinballRankView = class("HellaPinballRankView", ReduxView)

function HellaPinballRankView:UIName()
	return "Widget/System/Activity_Hel/Com/Activity_Hel_RankUI"
end

function HellaPinballRankView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaPinballRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaPinballRankView:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.commonRankGo_)

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, HellaPinballRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function HellaPinballRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1)
end

function HellaPinballRankView:AddUIListener()
	return
end

function HellaPinballRankView:UpdateView()
	local var_7_0 = RankData:GetActivityRank(self.rankActivityID)

	self.rankData = var_7_0.rankList

	if var_7_0 then
		local var_7_1, var_7_2 = var_7_0:GetCurRankDes()

		self.myScoreLabel_.text = var_7_2
		self.myRankLabel_.text = var_7_1
	else
		self.myScoreLabel_.text = ""
		self.myRankLabel_.text = ""
	end

	self.list:StartScroll(#self.rankData)
end

function HellaPinballRankView:OnEnter()
	self.selectIndex = 1
	self.rankActivityID = ActivityCfg[PinballData:GetActivityID()].sub_activity_list[1]

	RankAction.QueryActivityRank(self.rankActivityID, 0)

	self.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function HellaPinballRankView:OnExit()
	manager.windowBar:HideBar()
end

function HellaPinballRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function HellaPinballRankView:OnRankUpdate()
	self:UpdateView()

	self.isInit_ = true
end

function HellaPinballRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	HellaPinballRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return HellaPinballRankView
