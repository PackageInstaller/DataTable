local PaChinKoMainRewardList = class("PaChinKoMainRewardList", ReduxView)

function PaChinKoMainRewardList:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.rewardController_ = self.uiControllerEx_:GetController("reward")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, PaChinKoMainRewardItem)
	self.uiTitleText_.text = GetTips(string.format("PACHINKO_LEVEL_REWARD_%s", arg_1_2))
end

function PaChinKoMainRewardList:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil

	PaChinKoMainRewardList.super.Dispose(self)
end

function PaChinKoMainRewardList:AddListeners()
	return
end

function PaChinKoMainRewardList:OnEnter(arg_4_1)
	self.activityID_ = arg_4_1
	self.rewardIDList_ = PaChinKoTools.GetLevelRewardList(self.activityID_, self.index_)

	self.uiList_:StartScroll(#self.rewardIDList_)
	self:RefreshUI()
end

function PaChinKoMainRewardList:RefreshUI()
	self.uiList_:Refresh()
end

function PaChinKoMainRewardList:OnExit()
	return
end

function PaChinKoMainRewardList:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.activityID_, self.rewardIDList_[arg_7_1])
end

return PaChinKoMainRewardList
