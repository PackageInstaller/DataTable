local GuildActivityRateView = class("GuildActivityRateView", ReduxView)

function GuildActivityRateView:UIName()
	return "UI/GuildActivityUI/GuildActivityRatePopUI"
end

function GuildActivityRateView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivityRateView:OnCtor()
	return
end

function GuildActivityRateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityRateView:InitUI()
	self:BindCfgUI()

	self.premissItemList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, GuildActivityRatePremissItem)
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function GuildActivityRateView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivityRateView:AddEventListeners()
	return
end

function GuildActivityRateView:OnEnter()
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	manager.windowBar:HideBar()
	self:AddEventListeners()

	self.activityID_ = self.params_.activityID
	self.curRateID_ = GuildActivityData:GetCurRateID(self.activityID_)

	local var_9_0 = table.keyof(ActivityClubLevelSettingCfg.get_id_list_by_activity[self.activityID_], self.curRateID_)

	if var_9_0 then
		self.nextRateID_ = ActivityClubLevelSettingCfg.get_id_list_by_activity[self.activityID_][var_9_0 + 1]
	end

	if self.nextRateID_ ~= nil then
		self.premissIDList_ = ActivityClubLevelSettingCfg[self.nextRateID_].condition

		self.stateController_:SetSelectedState("false")
	else
		self.premissIDList_ = {}

		self.stateController_:SetSelectedState("true")
	end

	self:RefreshUI()
end

function GuildActivityRateView:Dispose()
	self.premissItemList_:Dispose()
	GuildActivityRateView.super.Dispose(self)
end

function GuildActivityRateView:RefreshUI()
	self.premissItemList_:StartScroll(#self.premissIDList_)
	self.levelController_:SetSelectedState(tostring(ActivityClubLevelSettingCfg[self.curRateID_].user_level))

	self.titleText_.text = GetI18NText(ActivityClubLevelSettingCfg[self.curRateID_].desc)
	self.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_DOMAIN"), ActivityClubLevelSettingCfg[self.curRateID_].max_domain)
	self.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), ActivityClubLevelSettingCfg[self.curRateID_].max_hero)
end

function GuildActivityRateView:RefreshItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.premissIDList_[arg_12_1], self.activityID_)
end

return GuildActivityRateView
