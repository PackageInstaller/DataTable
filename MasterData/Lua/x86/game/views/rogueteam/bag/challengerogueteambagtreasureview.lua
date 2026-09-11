local ChallengeRogueTeamBagTreasureView = class("ChallengeRogueTeamBagTreasureView", ReduxView)

function ChallengeRogueTeamBagTreasureView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChallengeRogueTeamBagTreasureView:Init()
	self:BindCfgUI()

	self.tabItemList_ = {}
	self.treasureList_ = LuaList.New(handler(self, self.IndexTreasureItem), self.treasureUIList_, ChallengeRogueTeamBagTreasureItem)
	self.campSkill_ = ChallengeRogueTeamBagTreasureCampSkillItem.New(self.campSkillGo_)
	self.tabItemList_ = {}
end

function ChallengeRogueTeamBagTreasureView:OnEnter(arg_3_1)
	self.tabIndex_ = arg_3_1.tabIndex or 1
	self.campId_ = arg_3_1.campId or 0
	self.activityID = ChallengeRogueTeamData:GetActivityID()
	self.templateID_ = ChallengeRogueTeamData:GetActiveTemplateID()
	self.allTreasureID_, self.tabDataList_ = ChallengeRogueTeamTools:GetAllSuitSkillIDList()
end

function ChallengeRogueTeamBagTreasureView:IndexTabItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.tabDataList_[arg_4_1], self.tabIndex_)
	arg_4_2:SetCallBack(function(arg_5_0)
		if self.tabIndex_ == arg_5_0 then
			return
		end

		self.tabIndex_ = arg_5_0
		self.campId_ = self.tabDataList_[arg_5_0]

		for iter_5_0, iter_5_1 in ipairs(self.tabItemList_) do
			iter_5_1:RefreshSelect(self.tabIndex_)

			self.treasureDataList_ = ChallengeRogueTeamData:TreasureGetListByCampList({
				self.tabDataList_[arg_5_0]
			})

			self.treasureList_:StartScroll(#self.treasureDataList_)
			self.campSkill_:RefreshUI(self.tabDataList_[arg_5_0])
		end
	end)
end

function ChallengeRogueTeamBagTreasureView:IndexTreasureItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.treasureDataList_[arg_6_1])
end

function ChallengeRogueTeamBagTreasureView:RefreshUI()
	self.treasureDataList_ = ChallengeRogueTeamData:TreasureGetListByCampList({
		self.campId_
	})

	table.sort(self.treasureDataList_, function(arg_8_0, arg_8_1)
		if arg_8_0.rare ~= arg_8_1.rare then
			return arg_8_0.rare > arg_8_1.rare
		else
			return arg_8_0.id < arg_8_1.id
		end
	end)

	for iter_7_0, iter_7_1 in ipairs(self.tabDataList_) do
		self.tabItemList_[iter_7_0] = self.tabItemList_[iter_7_0] or ChallengeRogueTeamBagTreasureTabItem.New((Object.Instantiate(self.tabItemGo_, self.tabContent_)))

		self:IndexTabItem(iter_7_0, self.tabItemList_[iter_7_0])
		SetActive(self.tabItemList_[iter_7_0].gameObject_, true)
	end

	for iter_7_2 = #self.tabItemList_, #self.tabDataList_ + 1, -1 do
		SetActive(self.tabItemList_[iter_7_2].gameObject_, false)
	end

	self.treasureList_:StartScroll(#self.treasureDataList_)
	self.campSkill_:RefreshUI(self.tabDataList_[self.tabIndex_])
end

function ChallengeRogueTeamBagTreasureView:OnExit()
	return
end

function ChallengeRogueTeamBagTreasureView:Dispose()
	ChallengeRogueTeamBagTreasureView.super.Dispose(self)

	if self.tabItemList_ then
		for iter_10_0, iter_10_1 in ipairs(self.tabItemList_) do
			iter_10_1:Dispose()
		end

		self.tabItemList_ = nil
	end

	if self.treasureList_ then
		self.treasureList_:Dispose()

		self.treasureList_ = nil
	end

	if self.campSkill_ then
		self.campSkill_:Dispose()

		self.campSkill_ = nil
	end
end

return ChallengeRogueTeamBagTreasureView
