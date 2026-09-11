local RogueTeamItemInfoSetttingTreasureView = class("RogueTeamItemInfoSetttingTreasureView", ReduxView)

function RogueTeamItemInfoSetttingTreasureView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.treasureUIList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, RogueTeamItemInfoSettingTreasureItem)
	self.suitSkillController_ = self.suitSkillControllerEx_:GetController("empty")
	self.treasureDataList_ = ChallengeRogueTeamTools.TreasureSort(ChallengeRogueTeamData:TreasureGetList())
	self.activeSuitSkillID_ = ChallengeRogueTeamData:SuitSkillGetID()
	self.suitSkillView_ = RogueTeamItemInfoSettingSuitSkillItem.New(self.suitSkillGo_)

	self:RefreshSuitSkillUI()
	self.treasureUIList_:StartScroll(#self.treasureDataList_)
end

function RogueTeamItemInfoSetttingTreasureView:Dispose()
	self.treasureUIList_:Dispose()

	self.treasureUIList_ = nil

	self.suitSkillView_:Dispose()

	self.suitSkillView_ = nil

	RogueTeamItemInfoSetttingTreasureView.super.Dispose(self)
end

function RogueTeamItemInfoSetttingTreasureView:AddListeners()
	return
end

function RogueTeamItemInfoSetttingTreasureView:RefreshUI()
	return
end

function RogueTeamItemInfoSetttingTreasureView:RefreshSuitSkillUI()
	if self.activeSuitSkillID_ == 0 then
		self.suitSkillController_:SetSelectedState("true")
	else
		self.suitSkillController_:SetSelectedState("false")
		self.suitSkillView_:SetData(ChallengeRogueTeamTools.GetItemIDByCampID(self.activeSuitSkillID_))
	end
end

function RogueTeamItemInfoSetttingTreasureView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.treasureDataList_[arg_6_1])
end

return RogueTeamItemInfoSetttingTreasureView
