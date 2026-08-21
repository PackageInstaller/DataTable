local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivitySpringFestivalGiveEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/V4_8_Xihe/V4_8_Xihe_SevenSkinUI/V4_8_Xihe_SevenSkinUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.listGo_, ActivitySpringFestivalGiveDayItem)
	arg_2_0.onSignHandler = handler(arg_2_0, arg_2_0.OnSignSpringGiveSuccess)
	arg_2_0.role01Con_ = arg_2_0.contentCtrl_:GetController("role01")
	arg_2_0.zuCon_ = arg_2_0.contentCtrl_:GetController("zu")
	arg_2_0.role02Con_ = arg_2_0.contentCtrl_:GetController("role02")
	arg_2_0.bgCon_ = arg_2_0.contentCtrl_:GetController("bg")
	arg_2_0.onClearHandler = handler(arg_2_0, arg_2_0.OnClearSuccess)
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("SPRINGFESTIVAL_GIVE_TIPS")
		})
	end)
end

function var_0_1.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
	arg_5_2:RefreshSelect(arg_5_0.curSelectDay)
	arg_5_2:RegisterClickFunc(function(arg_6_0, arg_6_1)
		arg_5_0:OnBtnSignClick(arg_6_0, arg_6_1)
	end)
end

function var_0_1.OnBtnSignClick(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.curSelectDay == arg_7_2 and arg_7_1 ~= "reward" then
		return
	end

	local var_7_0 = ActivitySpringFestivalGive2100Cfg.all[arg_7_2]
	local var_7_1 = ActivitySpringFestivalGive2100Cfg[var_7_0].sub_id

	if arg_7_1 == "reward" then
		if ActivityData:GetActivityIsOpen(var_7_1) then
			ActivitySpringFestivalGive2100Data:SetCurSelectDay(arg_7_2)

			local var_7_2 = ActivitySpringFestivalGive2100Cfg.all[arg_7_2]

			ActivitySpringFestivalGive2100Data:SetDayListInfoByIndex(arg_7_2)
			ActivitySpringFestivalGive2100Action.ReqSign(var_7_2)
		end
	else
		ActivitySpringFestivalGive2100Data:SetCurSelectDay(arg_7_2)

		arg_7_0.curSelectDay = arg_7_2

		arg_7_0:RefreshUI()
		arg_7_0.anim_:Play("UI_V4_8_Xihe_SevenSkinUI", -1, 0)
		arg_7_0.anim_:Update(0)

		arg_7_0.scrollRect_.localPosition = Vector2(0, 0)

		arg_7_0.uiList_:StartScroll(#arg_7_0.dataList_, arg_7_0.curSelectDay)
	end
end

function var_0_1.OnEnter(arg_8_0)
	var_0_1.super.OnEnter(arg_8_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_8_0.onClearHandler)
	manager.notify:RegistListener(SPRING_GIVE_SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_8_0.onSignHandler)

	if ActivityCfg[arg_8_0.toggleActivityID_].activity_template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
		arg_8_0.role01Con_:SetSelectedIndex(1)
		arg_8_0.zuCon_:SetSelectedIndex(1)
		arg_8_0.role02Con_:SetSelectedIndex(1)
		arg_8_0.bgCon_:SetSelectedIndex(1)
		SetActive(arg_8_0.listGo_.gameObject, false)
	else
		arg_8_0.role01Con_:SetSelectedIndex(0)
		arg_8_0.zuCon_:SetSelectedIndex(0)
		arg_8_0.role02Con_:SetSelectedIndex(0)
		arg_8_0.bgCon_:SetSelectedIndex(0)
		SetActive(arg_8_0.listGo_.gameObject, true)

		arg_8_0.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		arg_8_0.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(true)

		arg_8_0.uiList_:StartScroll(#arg_8_0.dataList_, arg_8_0.curSelectDay)
		arg_8_0.uiList_:SwitchToPage(arg_8_0.curSelectDay)
		arg_8_0:RefreshUI()
	end
end

function var_0_1.RefreshUI(arg_9_0)
	local var_9_0 = ActivitySpringFestivalGive2100Cfg.all[arg_9_0.curSelectDay]
	local var_9_1 = ActivitySpringFestivalGive2100Cfg[var_9_0]

	if arg_9_0.curSelectDay == 1 then
		local var_9_2 = PlayerData:GetPlayerInfo().nick

		arg_9_0.cardTitle_.text = string.gsub(GetI18NText(var_9_1.player_name), "#{nickname}#", var_9_2)
	else
		arg_9_0.cardTitle_.text = GetI18NText(var_9_1.player_name)
	end

	arg_9_0.cardContent_.text = GetI18NText(var_9_1.desc)
	arg_9_0.cardHero_.text = GetI18NText(HeroCfg[var_9_1.hero_id].suffix)
	arg_9_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_9_1.hero_id)
	arg_9_0.role_head.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_9_1.role_head)
end

function var_0_1.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	arg_10_0.scrollRect_.localPosition = Vector2(0, 0)

	if arg_10_1 then
		arg_10_0:UpdatePreview()

		arg_10_0.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(false)

		arg_10_0.uiList_:SwitchToPage(arg_10_0.curSelectDay)
	end
end

function var_0_1.OnSignSpringGiveSuccess(arg_11_0, arg_11_1)
	getReward(formatRewardCfgList(arg_11_1.reward_list), nil, function()
		arg_11_0.anim_:Play("UI_V4_8_Xihe_SevenSkinUI_cx", -1, 0)
		arg_11_0.anim_:Update(0)

		arg_11_0.scrollRect_.localPosition = Vector2(0, 0)
		arg_11_0.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		arg_11_0.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(false)

		arg_11_0.uiList_:StartScroll(#arg_11_0.dataList_, arg_11_0.curSelectDay)
		arg_11_0.uiList_:SwitchToPage(arg_11_0.curSelectDay)
		arg_11_0:RefreshUI()
		ActivitySpringFestivalGive2100Action.UpdateRedPoint()
	end)
end

function var_0_1.OnClearSuccess(arg_13_0)
	if ActivityCfg[arg_13_0.toggleActivityID_].activity_template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
		arg_13_0.role01Con_:SetSelectedIndex(1)
		arg_13_0.zuCon_:SetSelectedIndex(1)
		arg_13_0.role02Con_:SetSelectedIndex(1)
		arg_13_0.bgCon_:SetSelectedIndex(1)
		SetActive(arg_13_0.listGo_.gameObject, false)
	else
		arg_13_0.role01Con_:SetSelectedIndex(0)
		arg_13_0.zuCon_:SetSelectedIndex(0)
		arg_13_0.role02Con_:SetSelectedIndex(0)
		arg_13_0.bgCon_:SetSelectedIndex(0)
		SetActive(arg_13_0.listGo_.gameObject, true)

		arg_13_0.dataList_ = ActivitySpringFestivalGive2100Data:GetDayListInfo()
		arg_13_0.curSelectDay = ActivitySpringFestivalGive2100Data:GetCurSelectDay(true)

		arg_13_0.uiList_:StartScroll(#arg_13_0.dataList_, arg_13_0.curSelectDay)
		arg_13_0.uiList_:SwitchToPage(arg_13_0.curSelectDay)
		arg_13_0:RefreshUI()
	end
end

function var_0_1.OnExit(arg_14_0)
	var_0_1.super.OnExit(arg_14_0)
	manager.notify:RemoveListener(SPRING_GIVE_SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_14_0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_14_0.onClearHandler)
end

function var_0_1.Dispose(arg_15_0)
	var_0_1.super.Dispose(arg_15_0)
	arg_15_0.uiList_:Dispose()
end

return var_0_1
