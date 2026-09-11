local GuildActivitySetFightHeroView = class("GuildActivitySetFightHeroView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function GuildActivitySetFightHeroView:Init()
	GuildActivitySetFightHeroView.super.Init(self)
	self.filterView_:SetExtraSorter(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = self.params_.heroId or 0

		if (arg_2_0.id == var_2_0 and 1 or 0) ~= (arg_2_1.id == var_2_0 and 1 or 0) then
			return true, (arg_2_1.id == var_2_0 and 1 or 0) < (arg_2_0.id == var_2_0 and 1 or 0)
		end

		return false, false
	end)
end

function GuildActivitySetFightHeroView:InitUI()
	GuildActivitySetFightHeroView.super.InitUI(self)

	self.energyItem_ = GuildActivityTeamInfoEnergyItemView.New((Object.Instantiate(Asset.Load("UI/GuildActivityUI/items/energy"), self.extensionContainer_)))
end

function GuildActivitySetFightHeroView:HeadRenderer(arg_4_1, arg_4_2)
	GuildActivitySetFightHeroView.super.HeadRenderer(self, arg_4_1, arg_4_2)
end

function GuildActivitySetFightHeroView:UpdateHeroView()
	self.fightPowerText_.text = GetI18NText(getHeroPower(self.selectID_, false))

	self.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(self.selectID_).id)

	self.nameText_.text = GetI18NText(HeroCfg[self.selectID_].name)
	self.subNameText_.text = GetI18NText(HeroCfg[self.selectID_].suffix)

	self.energyItem_:SetCurrent(self:IsHeroInTeam(self.selectID_))

	local var_5_0 = GameSetting.activity_club_hero_fatigue_max.value[1]

	self.energyItem_:SetData(var_5_0, GuildActivityData:IsFirstConfigFightRole() and var_5_0 or table.indexof(self.params_.putOffList, self.selectID_) and 0 or GuildActivityData:GetHeroFatigue(self.selectID_))
end

function GuildActivitySetFightHeroView:OnEnter()
	GuildActivitySetFightHeroView.super.OnEnter(self)
	self:AddEventListeners()
end

function GuildActivitySetFightHeroView:RefreshInfoBtn()
	SetActive(self.infoBtn_.gameObject, false)
end

function GuildActivitySetFightHeroView:OnExit()
	GuildActivitySetFightHeroView.super.OnExit(self)
	self:RemoveAllEventListener()
end

function GuildActivitySetFightHeroView:AddEventListeners()
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildActivitySetFightHeroView:GetHeroTeam()
	return
end

function GuildActivitySetFightHeroView:GetRestrictHeroList(arg_12_1)
	return nil
end

function GuildActivitySetFightHeroView:OnJoinClick()
	if self.params_.heroId ~= nil and self.params_.heroId > 0 then
		if self.selectID_ == self.params_.heroId then
			if not GuildActivityData:IsFirstConfigFightRole() then
				ShowMessageBox({
					content = GetTips("ACTIVITY_CLUB_REMOVE_TEAM_TIP"),
					OkCallback = function()
						if self.params_.callback then
							self.params_.callback(self.params_.index, self.params_.heroId, 0)
						end

						self:Back()
					end,
					CancelCallback = function()
						return
					end
				})
			else
				if self.params_.callback then
					self.params_.callback(self.params_.index, self.params_.heroId, 0)
				end

				self:Back()
			end
		elseif not GuildActivityData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function()
					if self.params_.callback then
						self.params_.callback(self.params_.index, self.params_.heroId, self.selectID_)
					end

					self:Back()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			if self.params_.callback then
				self.params_.callback(self.params_.index, self.params_.heroId, self.selectID_)
			end

			self:Back()
		end
	else
		if self.params_.callback then
			self.params_.callback(self.params_.index, 0, self.selectID_)
		end

		self:Back()
	end
end

function GuildActivitySetFightHeroView:GetTextAndImage()
	if self.params_.heroId ~= nil and self.params_.heroId > 0 then
		if self.selectID_ == self.params_.heroId then
			return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2", true
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0", true
		end
	else
		return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0", true
	end
end

function GuildActivitySetFightHeroView:IsInTeam(arg_19_1, arg_19_2)
	return arg_19_1 == self.params_.heroId, false, -1
end

function GuildActivitySetFightHeroView:GetDefaultHeroData()
	return self.heroDataList_[1].id, 0
end

function GuildActivitySetFightHeroView:GetHeroList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs((HeroData:GetHeroList())) do
		if not self:IsHeroInTeam(iter_21_1.id) or iter_21_1.id == self.params_.heroId then
			var_21_0[iter_21_1.id] = iter_21_1
		end
	end

	return (HeroTools.Sort(var_21_0))
end

function GuildActivitySetFightHeroView:ChangeTeam(arg_22_1, arg_22_2)
	return
end

function GuildActivitySetFightHeroView:IsHeroInTeam(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self.params_.heroList) do
		if iter_23_1.id == arg_23_1 then
			return true
		end
	end

	return false
end

function GuildActivitySetFightHeroView:Dispose()
	if self.energyItem_ then
		self.energyItem_:Dispose()

		self.energyItem_ = nil
	end

	GuildActivitySetFightHeroView.super.Dispose(self)
end

return GuildActivitySetFightHeroView
