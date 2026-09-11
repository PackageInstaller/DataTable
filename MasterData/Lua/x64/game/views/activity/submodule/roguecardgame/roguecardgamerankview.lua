local RogueCardGameRankView = class("RogueCardGameRankView", ReduxView)

function RogueCardGameRankView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_RankUI"
end

function RogueCardGameRankView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameRankView:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.commonRankGo_)

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, RogueCardGameRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function RogueCardGameRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1)
end

function RogueCardGameRankView:AddUIListener()
	return
end

function RogueCardGameRankView:UpdateView()
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

function RogueCardGameRankView:OnEnter()
	self.selectIndex = 1
	self.rankActivityID = ActivityCfg[ActivityConst.ACTIVITY_ROGUECARD_5_0].sub_activity_list[1]

	RankAction.QueryActivityRank(self.rankActivityID, 0)

	self.nameLabel_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function RogueCardGameRankView:OnExit()
	manager.windowBar:HideBar()
end

function RogueCardGameRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function RogueCardGameRankView:OnRankUpdate()
	self:UpdateView()

	self.isInit_ = true
end

function RogueCardGameRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	RogueCardGameRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RogueCardGameRankView
