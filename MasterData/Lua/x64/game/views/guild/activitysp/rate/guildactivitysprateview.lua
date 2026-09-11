local GuildActivitySPRateView = class("GuildActivitySPRateView", ReduxView)

function GuildActivitySPRateView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPRatePopUI"
end

function GuildActivitySPRateView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPRateView:OnCtor()
	return
end

function GuildActivitySPRateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPRateView:InitUI()
	self:BindCfgUI()

	self.premissItemList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, GuildActivitySPRatePremissItem)
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function GuildActivitySPRateView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPRateView:AddEventListeners()
	return
end

function GuildActivitySPRateView:OnEnter()
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	manager.windowBar:HideBar()
	self:AddEventListeners()

	self.activityID_ = self.params_.activityID
	self.curRateID_ = GuildActivitySPData:GetCurRateID(self.activityID_)

	local var_9_0 = table.keyof(ActivityClubSPLevelSettingCfg.get_id_list_by_activity[self.activityID_], self.curRateID_)

	if var_9_0 then
		self.nextRateID_ = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[self.activityID_][var_9_0 + 1]
	end

	if self.nextRateID_ ~= nil then
		self.premissIDList_ = ActivityClubSPLevelSettingCfg[self.nextRateID_].condition

		self.stateController_:SetSelectedState("false")
	else
		self.premissIDList_ = {}

		self.stateController_:SetSelectedState("true")
	end

	self:RefreshUI()
end

function GuildActivitySPRateView:Dispose()
	self.premissItemList_:Dispose()
	GuildActivitySPRateView.super.Dispose(self)
end

function GuildActivitySPRateView:RefreshUI()
	self.premissItemList_:StartScroll(#self.premissIDList_)
	self.levelController_:SetSelectedState(tostring(ActivityClubSPLevelSettingCfg[self.curRateID_].user_level))

	self.titleText_.text = ActivityClubSPLevelSettingCfg[self.curRateID_].desc
	self.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_CAT"), #ActivityClubSPLevelSettingCfg[self.curRateID_].dispatch or 0)
	self.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), ActivityClubSPLevelSettingCfg[self.curRateID_].max_hero)
end

function GuildActivitySPRateView:RefreshItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.premissIDList_[arg_12_1], self.activityID_)
end

return GuildActivitySPRateView
