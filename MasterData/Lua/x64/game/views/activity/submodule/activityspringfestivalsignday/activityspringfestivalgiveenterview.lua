local ActivitySpringFestivalGiveEnterView = class("ActivitySpringFestivalGiveEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivitySpringFestivalGiveEnterView:GetUIName()
	return "Widget/Version/V4_8_Xihe/V4_8_Xihe_SevenSkinUI/V4_8_Xihe_SevenSkinUI"
end

function ActivitySpringFestivalGiveEnterView:Init()
	ActivitySpringFestivalGiveEnterView.super.Init(self)

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, ActivitySpringFestivalGiveDayItem)
	self.onSignHandler = handler(self, self.OnSignSpringGiveSuccess)
	self.role01Con_ = self.contentCtrl_:GetController("role01")
	self.zuCon_ = self.contentCtrl_:GetController("zu")
	self.role02Con_ = self.contentCtrl_:GetController("role02")
	self.bgCon_ = self.contentCtrl_:GetController("bg")
	self.onClearHandler = handler(self, self.OnClearSuccess)
end

function ActivitySpringFestivalGiveEnterView:AddListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("SPRINGFESTIVAL_GIVE_TIPS")
		})
	end)
end

function ActivitySpringFestivalGiveEnterView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
	arg_5_2:RefreshSelect(self.curSelectDay)
	arg_5_2:RegisterClickFunc(function(arg_6_0, arg_6_1)
		self:OnBtnSignClick(arg_6_0, arg_6_1)
	end)
end

function ActivitySpringFestivalGiveEnterView:OnBtnSignClick(arg_7_1, arg_7_2)
	if self.curSelectDay == arg_7_2 and arg_7_1 ~= "reward" then
		return
	end

	if arg_7_1 == "reward" then
		if ActivityData:GetActivityIsOpen(ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[arg_7_2]].sub_id) then
			ActivitySpringFestivalGive2100Data:SetCurSelectDay(arg_7_2)
			ActivitySpringFestivalGive2100Data:SetDayListInfoByIndex(arg_7_2)
			ActivitySpringFestivalGive2100Action.ReqSign(ActivitySpringFestivalGive2100Cfg.all[arg_7_2])
		end
	else
		ActivitySpringFestivalGive2100Data:SetCurSelectDay(arg_7_2)

		self.curSelectDay = arg_7_2

		self:RefreshUI()
		self.anim_:Play("UI_V4_8_Xihe_SevenSkinUI", -1, 0)
		self.anim_:Update(0)

		self.scrollRect_.localPosition = Vector2(0, 0)

		self.uiList_:StartScroll(#self.dataList_, self.curSelectDay)
	end
end

function ActivitySpringFestivalGiveEnterView:OnEnter()
	ActivitySpringFestivalGiveEnterView.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SPRING_GIVE_SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)

	if ActivityCfg[self.toggleActivityID_].activity_template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
		self.role01Con_:SetSelectedIndex(1)
		self.zuCon_:SetSelectedIndex(1)
		self.role02Con_:SetSelectedIndex(1)
		self.bgCon_:SetSelectedIndex(1)
		SetActive(self.listGo_.gameObject, false)
	else
		self.role01Con_:SetSelectedIndex(0)
		self.zuCon_:SetSelectedIndex(0)
		self.role02Con_:SetSelectedIndex(0)
		self.bgCon_:SetSelectedIndex(0)
		SetActive(self.listGo_.gameObject, true)

		self.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		self.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(true)

		self.uiList_:StartScroll(#self.dataList_, self.curSelectDay)
		self.uiList_:SwitchToPage(self.curSelectDay)
		self:RefreshUI()
	end
end

function ActivitySpringFestivalGiveEnterView:RefreshUI()
	local var_9_0 = ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[self.curSelectDay]]

	self.cardTitle_.text = self.curSelectDay == 1 and string.gsub(GetI18NText(var_9_0.player_name), "#{nickname}#", PlayerData:GetPlayerInfo().nick) or GetI18NText(var_9_0.player_name)
	self.cardContent_.text = GetI18NText(var_9_0.desc)
	self.cardHero_.text = GetI18NText(HeroCfg[var_9_0.hero_id].suffix)
	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_9_0.hero_id)
	self.role_head.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_9_0.role_head)
end

function ActivitySpringFestivalGiveEnterView:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	self.scrollRect_.localPosition = Vector2(0, 0)

	if arg_10_1 then
		self:UpdatePreview()

		self.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(false)

		self.uiList_:SwitchToPage(self.curSelectDay)
	end
end

function ActivitySpringFestivalGiveEnterView:OnSignSpringGiveSuccess(arg_11_1)
	getReward(formatRewardCfgList(arg_11_1.reward_list), nil, function()
		self.anim_:Play("UI_V4_8_Xihe_SevenSkinUI_cx", -1, 0)
		self.anim_:Update(0)

		self.scrollRect_.localPosition = Vector2(0, 0)
		self.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		self.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(false)

		self.uiList_:StartScroll(#self.dataList_, self.curSelectDay)
		self.uiList_:SwitchToPage(self.curSelectDay)
		self:RefreshUI()
		ActivitySpringFestivalGive2100Action.UpdateRedPoint()
	end)
end

function ActivitySpringFestivalGiveEnterView:OnClearSuccess()
	if ActivityCfg[self.toggleActivityID_].activity_template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
		self.role01Con_:SetSelectedIndex(1)
		self.zuCon_:SetSelectedIndex(1)
		self.role02Con_:SetSelectedIndex(1)
		self.bgCon_:SetSelectedIndex(1)
		SetActive(self.listGo_.gameObject, false)
	else
		self.role01Con_:SetSelectedIndex(0)
		self.zuCon_:SetSelectedIndex(0)
		self.role02Con_:SetSelectedIndex(0)
		self.bgCon_:SetSelectedIndex(0)
		SetActive(self.listGo_.gameObject, true)

		self.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		self.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(true)

		self.uiList_:StartScroll(#self.dataList_, self.curSelectDay)
		self.uiList_:SwitchToPage(self.curSelectDay)
		self:RefreshUI()
	end
end

function ActivitySpringFestivalGiveEnterView:OnExit()
	ActivitySpringFestivalGiveEnterView.super.OnExit(self)
	manager.notify:RemoveListener(SPRING_GIVE_SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
end

function ActivitySpringFestivalGiveEnterView:Dispose()
	ActivitySpringFestivalGiveEnterView.super.Dispose(self)
	self.uiList_:Dispose()
end

return ActivitySpringFestivalGiveEnterView
