local ActivityHeroEnhanceTalentView = class("ActivityHeroEnhanceTalentView", ReduxView)

function ActivityHeroEnhanceTalentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function ActivityHeroEnhanceTalentView:InitUI()
	self:BindCfgUI()

	self.talentGroups_ = {}

	for iter_2_0 = 1, 4 do
		table.insert(self.talentGroups_, (ActivityHeroEnhanceTalentGroupView.New(self["talentGroupGo_" .. iter_2_0])))
	end

	self:AddUIListener()
end

function ActivityHeroEnhanceTalentView:AddUIListener()
	for iter_3_0, iter_3_1 in ipairs(self.talentGroups_) do
		iter_3_1:SetClickHandler(function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			if self.onClickTalenCallback_ then
				self.onClickTalenCallback_(iter_3_1, iter_3_0, arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			end
		end)
	end
end

function ActivityHeroEnhanceTalentView:OnEnter()
	return
end

function ActivityHeroEnhanceTalentView:OnExit()
	return
end

function ActivityHeroEnhanceTalentView:SetData(arg_7_1)
	self.cfgId_ = arg_7_1
end

function ActivityHeroEnhanceTalentView:SelectGroupIdx(arg_8_1, arg_8_2)
	if self.selectGroupIdx_ == arg_8_1 and (arg_8_1 <= 0 or self.talentGroups_[arg_8_1].selectIdx_ == arg_8_2) then
		return
	end

	self.selectGroupIdx_ = arg_8_1

	if arg_8_1 > 0 then
		self.talentGroups_[arg_8_1]:SelectIdx(arg_8_2)
	end
end

function ActivityHeroEnhanceTalentView:SetClickTalentHandler(arg_9_1)
	self.onClickTalenCallback_ = arg_9_1
end

function ActivityHeroEnhanceTalentView:RefreshUI()
	local var_10_0 = ActivityHeroEnhanceCfg[self.cfgId_]

	self.heroImage_.sprite = ActivityTools.GetActivityTheme(ActivityHeroEnhanceCfg[self.cfgId_].activity_id) == ActivityConst.THEME.ACTIVITY_3_5 and table.indexof({
		1139,
		1049,
		1042
	}, ActivityHeroEnhanceCfg[self.cfgId_].hero_id) and pureGetSpriteWithoutAtlas("TextureBg/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI3_5_" .. ActivityHeroEnhanceCfg[self.cfgId_].hero_id) or pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

	self.heroImage_:SetNativeSize()

	local var_10_1 = ActivityHeroEnhanceTools.GetCfgTalentDict(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(self.talentGroups_) do
		iter_10_1:SetData(self.cfgId_, iter_10_0, var_10_1[iter_10_0])
		iter_10_1:SetSelected(self.selectGroupIdx_ == iter_10_0)
		iter_10_1:RefreshUI()
	end
end

function ActivityHeroEnhanceTalentView:RefreshUI_SelectState()
	for iter_11_0, iter_11_1 in ipairs(self.talentGroups_) do
		iter_11_1:SetSelected(self.selectGroupIdx_ == iter_11_0)
		iter_11_1:RefreshUI_SelectState()
	end
end

function ActivityHeroEnhanceTalentView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.talentGroups_) do
		iter_12_1:Dispose()
	end

	ActivityHeroEnhanceTalentView.super.Dispose(self)
end

return ActivityHeroEnhanceTalentView
