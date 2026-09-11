local GuildActivityFightHeadItemView = class("GuildActivityFightHeadItemView", ReduxView)

function GuildActivityFightHeadItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivityFightHeadItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityFightHeadItemView:InitUI()
	self:BindCfgUI()

	self.emptyController_ = ControllerUtil.GetController(self.gameObject_.transform, "empty")
	self.heroHead_ = NewHeroHead.New(self.heroHeadGo_)
end

function GuildActivityFightHeadItemView:AddUIListener()
	self:AddBtnListener(self.addBtn_, nil, function()
		if not self.editing_ then
			return
		end

		if HeroData:GetHeroNum() <= #self.heroList_ then
			ShowTips("ACTIVITY_CLUB_HERO_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/guildActivitySetFightHero", {
			putOffList = self.putOffList_,
			heroList = self.heroList_,
			index = self.index_,
			callback = handler(self, self.OnSelectHero)
		})
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_6_0

		if not self.editing_ then
			do return end

			var_6_0 = 1
		end

		for iter_6_0, iter_6_1 in ipairs(ActivityClubLevelSettingCfg.get_id_list_by_activity[self.activityID_]) do
			if ActivityClubLevelSettingCfg[iter_6_1].max_hero >= self.index_ then
				var_6_0 = ActivityClubLevelSettingCfg[iter_6_1].user_level

				break
			end
		end

		ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_6_0)))
	end)
	self.heroHead_:RegisterClickListener(function()
		if not self.editing_ then
			return
		end

		JumpTools.OpenPageByJump("/guildActivitySetFightHero", {
			putOffList = self.putOffList_,
			heroList = self.heroList_,
			index = self.index_,
			heroId = self.heroData_.id,
			callback = handler(self, self.OnSelectHero)
		})
	end)
end

function GuildActivityFightHeadItemView:SetEditing(arg_8_1)
	self.editing_ = arg_8_1
end

function GuildActivityFightHeadItemView:SetHeroChangeHandler(arg_9_1)
	self.heroChangeHandler_ = arg_9_1
end

function GuildActivityFightHeadItemView:OnSelectHero(arg_10_1, arg_10_2, arg_10_3)
	if self.heroChangeHandler_ then
		self.heroChangeHandler_(arg_10_1, arg_10_2, arg_10_3)
	end
end

function GuildActivityFightHeadItemView:AddEventListeners()
	return
end

function GuildActivityFightHeadItemView:SetData(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.index_ = arg_12_1
	self.heroList_ = arg_12_2
	self.heroData_ = arg_12_2[arg_12_1] or nil
	self.putOffList_ = arg_12_3
	self.activityID_ = arg_12_4

	self:UpdateView()
end

function GuildActivityFightHeadItemView:UpdateView()
	if self.index_ > GuildActivityData:GetMaxFightHeroCount() then
		self.emptyController_:SetSelectedState("lock")
	elseif self.heroData_ ~= nil then
		self.emptyController_:SetSelectedState("hero")
		self.heroHead_:SetHeroData(self.heroData_.id)

		self.energyLabel_.text = table.indexof(self.putOffList_, self.heroData_.id) and "0" or GuildActivityData:GetHeroFatigue(self.heroData_.id)
	else
		self.emptyController_:SetSelectedState("add")
	end
end

function GuildActivityFightHeadItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivityFightHeadItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivityFightHeadItemView:OnMainHomeViewTop()
	return
end

function GuildActivityFightHeadItemView:Dispose()
	self.data_ = nil

	if self.heroHead_ then
		self.heroHead_:Dispose()

		self.heroHead_ = nil
	end

	self.heroChangeHandler_ = nil

	GuildActivityFightHeadItemView.super.Dispose(self)
end

return GuildActivityFightHeadItemView
