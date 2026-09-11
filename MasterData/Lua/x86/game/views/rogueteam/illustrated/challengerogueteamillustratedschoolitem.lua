local ChallengeRogueTeamIllustratedSchoolItem = class("ChallengeRogueTeamIllustratedSchoolItem", ReduxView)

function ChallengeRogueTeamIllustratedSchoolItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.positionController_ = self.controller_:GetController("position")
end

function ChallengeRogueTeamIllustratedSchoolItem:Dispose()
	ChallengeRogueTeamIllustratedSchoolItem.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedSchoolItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedTreasure", {
			id = self.id_
		})
	end)
end

function ChallengeRogueTeamIllustratedSchoolItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1

	self.positionController_:SetSelectedState(tostring(arg_5_1 % 2 == 1))

	self.id_ = arg_5_2
	self.itemTemp_ = arg_5_3
	self.treasureList_ = ChallengeRogueTeamData:GetAllCampTreasureIDByCamp(self.itemTemp_, self.id_)
	self.unlockTresureList_ = ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(ChallengeRogueTeamData:GetCacheTemplateID(), self.id_)
	self.progressText_.text = #self.unlockTresureList_ .. "/" .. #self.treasureList_
	self.nameText_.text = GetTips("ROGUE_TEAM_SCHOOL_NAME_" .. self.id_)
	self.descText_.text = GetTips("ROGUE_TEAM_SCHOOL_DESCRIPTION_" .. self.id_)
	self.image_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_BIG_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[self.index_])
end

return ChallengeRogueTeamIllustratedSchoolItem
