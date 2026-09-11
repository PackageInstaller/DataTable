local NewGuildActivitySPSetFightHeroView = class("NewGuildActivitySPSetFightHeroView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewGuildActivitySPSetFightHeroView:ExtraSorter(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = self.params_.heroId or 0

	if (arg_1_1.id == var_1_0 and 1 or 0) ~= (arg_1_2.id == var_1_0 and 1 or 0) then
		return true, (arg_1_2.id == var_1_0 and 1 or 0) < (arg_1_1.id == var_1_0 and 1 or 0)
	end

	return false, false
end

function NewGuildActivitySPSetFightHeroView:InitUI()
	NewGuildActivitySPSetFightHeroView.super.InitUI(self)

	self.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New((Object.Instantiate(Asset.Load("UI/GuildActivitySPUI/items/spenergy"), self.extensionContainer_)))
end

function NewGuildActivitySPSetFightHeroView:UpdateHeroView()
	NewGuildActivitySPSetFightHeroView.super.UpdateHeroView(self)
	self.energyItem_:SetCurrent(self:IsHeroInTeam(self.selectHeroData_.id))

	local var_3_0 = GameSetting.activity_club_sp_hero_fatigue_max.value[1]

	self.energyItem_:SetData(var_3_0, GuildActivitySPData:IsFirstConfigFightRole() and var_3_0 or table.indexof(self.params_.putOffList, self.selectHeroData_.id) and 0 or GuildActivitySPData:GetHeroFatigue(self.selectHeroData_.id))
end

function NewGuildActivitySPSetFightHeroView:OnEnter()
	NewGuildActivitySPSetFightHeroView.super.OnEnter(self)
	self:AddEventListeners()
end

function NewGuildActivitySPSetFightHeroView:RefreshInfoBtn()
	SetActive(self.infoBtn_.gameObject, false)
end

function NewGuildActivitySPSetFightHeroView:OnExit()
	NewGuildActivitySPSetFightHeroView.super.OnExit(self)
	self:RemoveAllEventListener()
end

function NewGuildActivitySPSetFightHeroView:AddEventListeners()
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function NewGuildActivitySPSetFightHeroView:GetHeroTeam()
	return
end

function NewGuildActivitySPSetFightHeroView:OnJoinClick()
	if self.params_.heroId ~= nil and self.params_.heroId > 0 then
		if self.selectHeroData_.id == self.params_.heroId then
			if not GuildActivitySPData:IsFirstConfigFightRole() then
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
		elseif not GuildActivitySPData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function()
					if self.params_.callback then
						self.params_.callback(self.params_.index, self.params_.heroId, self.selectHeroData_.id)
					end

					self:Back()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			if self.params_.callback then
				self.params_.callback(self.params_.index, self.params_.heroId, self.selectHeroData_.id)
			end

			self:Back()
		end
	else
		if self.params_.callback then
			self.params_.callback(self.params_.index, 0, self.selectHeroData_.id)
		end

		self:Back()
	end
end

function NewGuildActivitySPSetFightHeroView:RefreshJoinBtn()
	self.joinBtn_.interactable = true

	if self.params_.heroId ~= nil and self.params_.heroId > 0 then
		if self.selectHeroData_.id == self.params_.heroId then
			self.joinBtnController_:SetSelectedState("out")
		else
			self.joinBtnController_:SetSelectedState("change")
		end
	else
		self.joinBtnController_:SetSelectedState("add")
	end
end

function NewGuildActivitySPSetFightHeroView:IsInTeam(arg_16_1, arg_16_2)
	return arg_16_1 == self.params_.heroId, false, -1
end

function NewGuildActivitySPSetFightHeroView:GetDefaultHeroData()
	return self.heroDataList_[1]
end

function NewGuildActivitySPSetFightHeroView:GetHeroList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs((HeroData:GetHeroList())) do
		if not self:IsHeroInTeam(iter_18_1.id) or iter_18_1.id == self.params_.heroId then
			var_18_0[iter_18_1.id] = iter_18_1
		end
	end

	return (HeroTools.Sort(var_18_0))
end

function NewGuildActivitySPSetFightHeroView:ChangeTeam(arg_19_1, arg_19_2)
	return
end

function NewGuildActivitySPSetFightHeroView:IsHeroInTeam(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.params_.heroList) do
		if iter_20_1.id == arg_20_1 then
			return true
		end
	end

	return false
end

function NewGuildActivitySPSetFightHeroView:Dispose()
	if self.energyItem_ then
		self.energyItem_:Dispose()

		self.energyItem_ = nil
	end

	NewGuildActivitySPSetFightHeroView.super.Dispose(self)
end

return NewGuildActivitySPSetFightHeroView
