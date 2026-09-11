local GuildActivityFightHeroSettingView = class("GuildActivityFightHeroSettingView", ReduxView)

function GuildActivityFightHeroSettingView:UIName()
	return "UI/GuildActivityUI/GuildActivityFightHeroPopUI"
end

function GuildActivityFightHeroSettingView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityFightHeroSettingView:OnCtor()
	return
end

function GuildActivityFightHeroSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityFightHeroSettingView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.headList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, GuildActivityFightHeadItemView)
end

function GuildActivityFightHeroSettingView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetEditing(self.editing_)
	arg_6_2:SetData(arg_6_1, self.heroDataList_, self.putOffHeroList_, self.params_.activityID)
	arg_6_2:SetHeroChangeHandler(handler(self, self.OnHeroChange))
end

function GuildActivityFightHeroSettingView:OnHeroChange(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 > #self.heroDataList_ + 1 then
		arg_7_1 = #self.heroDataList_ + 1
	end

	if arg_7_2 ~= 0 then
		for iter_7_0, iter_7_1 in ipairs(self.heroDataList_) do
			if iter_7_1.id == arg_7_2 then
				self.heroDataList_[iter_7_0].fatigue = 0

				break
			end
		end

		if table.indexof(self.putOffHeroList_, arg_7_2) then
			-- block empty
		else
			table.insert(self.putOffHeroList_, arg_7_2)
		end
	end

	if arg_7_3 == 0 then
		for iter_7_2 = arg_7_1, #self.heroDataList_ - 1 do
			self.heroDataList_[iter_7_2] = self.heroDataList_[iter_7_2 + 1]
		end

		table.remove(self.heroDataList_, #self.heroDataList_)
	else
		self.heroDataList_[arg_7_1] = {
			fatigue = 0,
			id = arg_7_3
		}
	end

	self.headList_:Refresh()
end

function GuildActivityFightHeroSettingView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.statusController_:GetSelectedState() == "edit" then
			-- block empty
		else
			self:Back()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:SwitchToList()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		if GuildActivityData:IsFirstConfigFightRole() and #self.heroDataList_ < GuildActivityData:GetMaxFightHeroCount() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_FIGHT_HERO_NOT_FULL_TIP"),
				OkCallback = function()
					self:SaveHeroes()
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		self:SaveHeroes()
	end)
	self:AddBtnListener(self.editBtn_, nil, function()
		self:StartEdit()
	end)
end

function GuildActivityFightHeroSettingView:StartEdit()
	self.statusController_:SetSelectedState("edit")

	self.titleLabel_.text = GetTips("ACTIVITY_CLUB_HERO_EDIT")
	self.editing_ = true

	self.headList_:StartScroll(ActivityClubLevelSettingCfg[GuildActivitySpTools.GetTopUserLevel(self.params_.activityID)].max_hero)
end

function GuildActivityFightHeroSettingView:SwitchToList()
	self.putOffHeroList_ = {}
	self.heroDataList_ = GuildActivityData:GetFightHeroList()
	self.heroDataList_ = deepClone(self.heroDataList_)

	self.statusController_:SetSelectedState("list")

	self.titleLabel_.text = GetTips("ACTIVITY_CLUB_HERO_LIST")
	self.editing_ = false

	self.headList_:StartScroll(#self.heroDataList_)
end

function GuildActivityFightHeroSettingView:SaveHeroes()
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(self.heroDataList_) do
		table.insert(var_17_0, iter_17_1.id)
	end

	for iter_17_2, iter_17_3 in ipairs(self.putOffHeroList_) do
		for iter_17_4, iter_17_5 in ipairs(self.heroDataList_) do
			if iter_17_5.id == iter_17_3 then
				table.insert(var_17_1, iter_17_3)

				break
			end
		end
	end

	GuildActivityAction.SetFightMember(var_17_0, var_17_1)
	self:SwitchToList()
end

function GuildActivityFightHeroSettingView:AddEventListeners()
	self:RegistEventListener(GUILD_ACTIVITY_HERO_LIST_UPDATE, function()
		self:SwitchToList()
	end)
end

function GuildActivityFightHeroSettingView:OnTop()
	self:UpdateBar()
end

function GuildActivityFightHeroSettingView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivityFightHeroSettingView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.editing_ then
			self:SwitchToList()

			return
		end

		self:Back()
	end)
end

function GuildActivityFightHeroSettingView:OnEnter()
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	self:AddEventListeners()

	if self.params_.isEnter then
		self:SwitchToList()

		self.params_.isEnter = false
	end

	self.hoursLabel_.text = string.format(GetTips("ACTIVITY_CLUB_VITALITY_RECOVER"), tostring(60 / GameSetting.activity_club_hero_fatigue_recovery.value[1]))
end

function GuildActivityFightHeroSettingView:OnExit()
	GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildActivityFightHeroSettingView:OnMainHomeViewTop()
	return
end

function GuildActivityFightHeroSettingView:Dispose()
	if self.headList_ then
		self.headList_:Dispose()

		self.headList_ = nil
	end

	GuildActivityFightHeroSettingView.super.Dispose(self)
end

return GuildActivityFightHeroSettingView
