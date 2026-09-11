local ChallengeRogueTeamOverStatisticsNewRelicView = class("ChallengeRogueTeamOverStatisticsNewRelicView", ReduxView)

function ChallengeRogueTeamOverStatisticsNewRelicView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.unlockRelicList_ = LuaList.New(handler(self, self.IndexItem), self.uiUnlockList_, ChallengeRogueTeamOverStatisticsRelicItem)

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsNewRelicView:Dispose()
	self.unlockRelicList_:Dispose()

	self.unlockRelicList_ = nil

	ChallengeRogueTeamOverStatisticsNewRelicView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsNewRelicView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsNewRelicView:RefreshUI()
	self.unlockRelicDataList_ = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

	if self.unlockRelicDataList_ and not table.isEmpty(self.unlockRelicDataList_) then
		self.unlockRelicList_:StartScroll(#self.unlockRelicDataList_)
	end
end

function ChallengeRogueTeamOverStatisticsNewRelicView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.unlockRelicDataList_[arg_5_1])
end

return ChallengeRogueTeamOverStatisticsNewRelicView
