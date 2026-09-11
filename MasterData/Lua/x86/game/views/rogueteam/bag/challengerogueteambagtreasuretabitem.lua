local ChallengeRogueTeamBagTreasureItem = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function ChallengeRogueTeamBagTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
end

function ChallengeRogueTeamBagTreasureItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.index_)
		end
	end)
end

function ChallengeRogueTeamBagTreasureItem:Dispose()
	ChallengeRogueTeamBagTreasureItem.super.Dispose(self)
end

function ChallengeRogueTeamBagTreasureItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1
	self.campId_ = arg_5_2

	if self.campId_ ~= 0 then
		self.campSkillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp, self.campId_)
		self.icon_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[self.index_ - 1])
		self.iconSelect_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[self.index_ - 1])
	end

	self.num_.text = arg_5_2 == 0 and #ChallengeRogueTeamData:TreasureGetList() or #ChallengeRogueTeamData:TreasureGetListByCampList({
		arg_5_2
	})

	self:RefreshSelect(arg_5_3)
end

function ChallengeRogueTeamBagTreasureItem:SetCallBack(arg_6_1)
	self.callback_ = arg_6_1
end

function ChallengeRogueTeamBagTreasureItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(self.index_ == arg_7_1))
end

return ChallengeRogueTeamBagTreasureItem
