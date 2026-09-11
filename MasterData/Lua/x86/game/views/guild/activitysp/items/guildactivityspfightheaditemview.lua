local GuildActivitySPFightHeadItemView = class("GuildActivitySPFightHeadItemView", ReduxView)

function GuildActivitySPFightHeadItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPFightHeadItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPFightHeadItemView:InitUI()
	self:BindCfgUI()

	self.emptyController_ = ControllerUtil.GetController(self.gameObject_.transform, "empty")
	self.heroHead_ = NewHeroHead.New(self.heroHeadGo_)
end

function GuildActivitySPFightHeadItemView:AddUIListener()
	self:AddBtnListener(self.addBtn_, nil, function()
		if not self.editing_ then
			return
		end

		if HeroData:GetHeroNum() <= #self.heroList_ then
			ShowTips("ACTIVITY_CLUB_HERO_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/guildActivitySPSetFightHero", {
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

		for iter_6_0, iter_6_1 in ipairs(ActivityClubSPLevelSettingCfg.get_id_list_by_activity[self.activityID_]) do
			if ActivityClubSPLevelSettingCfg[iter_6_1].max_hero >= self.index_ then
				var_6_0 = ActivityClubSPLevelSettingCfg[iter_6_1].user_level

				break
			end
		end

		ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_6_0)))
	end)
	self.heroHead_:RegisterClickListener(function()
		if not self.editing_ then
			return
		end

		JumpTools.OpenPageByJump("/guildActivitySPSetFightHero", {
			putOffList = self.putOffList_,
			heroList = self.heroList_,
			index = self.index_,
			heroId = self.heroData_.id,
			callback = handler(self, self.OnSelectHero)
		})
	end)
end

function GuildActivitySPFightHeadItemView:SetEditing(arg_8_1)
	self.editing_ = arg_8_1
end

function GuildActivitySPFightHeadItemView:SetHeroChangeHandler(arg_9_1)
	self.heroChangeHandler_ = arg_9_1
end

function GuildActivitySPFightHeadItemView:OnSelectHero(arg_10_1, arg_10_2, arg_10_3)
	if self.heroChangeHandler_ then
		self.heroChangeHandler_(arg_10_1, arg_10_2, arg_10_3)
	end
end

function GuildActivitySPFightHeadItemView:AddEventListeners()
	return
end

function GuildActivitySPFightHeadItemView:SetData(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.index_ = arg_12_1
	self.heroList_ = arg_12_2
	self.heroData_ = arg_12_2[arg_12_1] or nil
	self.putOffList_ = arg_12_3
	self.activityID_ = arg_12_4

	self:UpdateView()
end

function GuildActivitySPFightHeadItemView:UpdateView()
	if self.index_ > GuildActivitySPData:GetMaxFightHeroCount() then
		self.emptyController_:SetSelectedState("lock")
	elseif self.heroData_ ~= nil then
		self.emptyController_:SetSelectedState("hero")
		self.heroHead_:SetHeroData(self.heroData_.id)

		local var_13_0 = table.indexof(self.putOffList_, self.heroData_.id)

		self.energyLabel_.text = GuildActivitySPData:GetHeroFatigue(self.heroData_.id)
	else
		self.emptyController_:SetSelectedState("add")
	end
end

function GuildActivitySPFightHeadItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPFightHeadItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPFightHeadItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPFightHeadItemView:Dispose()
	self.data_ = nil

	if self.heroHead_ then
		self.heroHead_:Dispose()

		self.heroHead_ = nil
	end

	self.heroChangeHandler_ = nil

	GuildActivitySPFightHeadItemView.super.Dispose(self)
end

return GuildActivitySPFightHeadItemView
