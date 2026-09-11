local ActivityInvitePlotView = class("ActivityInvitePlotView", ReduxView)

function ActivityInvitePlotView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionContenuUI"
end

function ActivityInvitePlotView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityInvitePlotView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityInvitePlotView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ActivityInvitePlotItem)
end

function ActivityInvitePlotView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData({
		id = self.inviteCfg.chat_order_seq[arg_5_1],
		role = self.inviteCfg.chat_name_seq[arg_5_1],
		heroId = self.inviteCfg.hero_id
	}, arg_5_1, self.inviteCfg, self.index)
end

function ActivityInvitePlotView:AddUIListener()
	self:AddBtnListener(self.finishBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.listBtn_, nil, function()
		self.index = self.index + 1

		if #self.inviteCfg.chat_order_seq > self.index - 1 then
			self.list:StartScroll(self.index, self.index)
			manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_talk_3", "")
		else
			SetActive(self.finishBtn_.gameObject, true)
		end
	end)
end

function ActivityInvitePlotView:UpdateBar()
	return
end

function ActivityInvitePlotView:UpdateView()
	self.activityId = InviteData:GetDataByPara("activityId")

	local var_10_0 = ActivityData:GetActivityData(self.activityId)

	SetActive(self.finishBtn_.gameObject, false)

	self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_10_0.stopTime, nil, true)
	self.updateTimer_ = Timer.New(function()
		self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_10_0.stopTime, nil, true)
	end, 1, var_10_0.stopTime, 1)
	self.inviteCfg = ActivityInviteCfg[self.params_.id]
	self.nameTxt_.text = GetI18NText(HeroCfg[self.inviteCfg.hero_id].suffix)
	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(self.inviteCfg.hero_image_route))

	self.list:StartScroll(self.index, self.index)
end

function ActivityInvitePlotView:OnEnter()
	self.index = 1

	self:UpdateView()
end

function ActivityInvitePlotView:OnExit()
	manager.windowBar:HideBar()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.params_.haveReward then
		self.params_.haveReward = false

		ShowTips("ACTIVITY_INVITE_FINISH_TIPS")
	end
end

function ActivityInvitePlotView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityInvitePlotView:Dispose()
	ActivityInvitePlotView.super.Dispose(self)

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	Object.Destroy(self.gameObject_)
end

return ActivityInvitePlotView
