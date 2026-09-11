local ChallengeRogueTeamTreasureItem = class("ChallengeRogueTeamTreasureItem", ReduxView)

function ChallengeRogueTeamTreasureItem:GetUIName()
	return "Widget/System/Activity_Roulike/item/SelectPopItem"
end

function ChallengeRogueTeamTreasureItem:Ctor(arg_2_1, arg_2_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_2_2

	self:BindCfgUI()
	self:AddListeners()

	self.commonItem_ = ChallengeRogueTeamCommonItemView.New(self.gameObject_)
end

function ChallengeRogueTeamTreasureItem:SetData(arg_3_1)
	local var_3_0 = clone(ChallengeRogueTeamCommonItemData)

	var_3_0.id = arg_3_1.id
	var_3_0.rare = arg_3_1.rare
	var_3_0.selectFlag = false
	var_3_0.descRaycastFlag = arg_3_1.descRaycastFlag or false
	var_3_0.ownFlag = arg_3_1.isNew
	var_3_0.needShowCampFlag = arg_3_1.needShowCampFlag or false

	function var_3_0.clickFun()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, self.index_)
	end

	self.commonItem_:SetData(var_3_0)
end

function ChallengeRogueTeamTreasureItem:OnExit()
	return
end

function ChallengeRogueTeamTreasureItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	ChallengeRogueTeamTreasureItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamTreasureItem:AddListeners()
	return
end

function ChallengeRogueTeamTreasureItem:SelectTreasure(arg_8_1)
	if self.index_ == arg_8_1 then
		self.commonItem_:RefreshSelectState(true)
		self.commonItem_:RefreshDescTextRaycast(true)
	else
		self.commonItem_:RefreshSelectState(false)
		self.commonItem_:RefreshDescTextRaycast(false)
	end
end

function ChallengeRogueTeamTreasureItem:PlayAnimator()
	self.commonItem_:PlayAnimator()
end

return ChallengeRogueTeamTreasureItem
