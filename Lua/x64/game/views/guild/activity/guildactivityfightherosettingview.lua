local var_0_0 = class("GuildActivityFightHeroSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityFightHeroPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
	arg_5_0.headList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, GuildActivityFightHeadItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetEditing(arg_6_0.editing_)
	arg_6_2:SetData(arg_6_1, arg_6_0.heroDataList_, arg_6_0.putOffHeroList_, arg_6_0.params_.activityID)
	arg_6_2:SetHeroChangeHandler(handler(arg_6_0, arg_6_0.OnHeroChange))
end

function var_0_0.OnHeroChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 > #arg_7_0.heroDataList_ + 1 then
		arg_7_1 = #arg_7_0.heroDataList_ + 1
	end

	if arg_7_2 ~= 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.heroDataList_) do
			if iter_7_1.id == arg_7_2 then
				arg_7_0.heroDataList_[iter_7_0].fatigue = 0

				break
			end
		end

		if table.indexof(arg_7_0.putOffHeroList_, arg_7_2) then
			-- block empty
		else
			table.insert(arg_7_0.putOffHeroList_, arg_7_2)
		end
	end

	if arg_7_3 == 0 then
		for iter_7_2 = arg_7_1, #arg_7_0.heroDataList_ - 1 do
			arg_7_0.heroDataList_[iter_7_2] = arg_7_0.heroDataList_[iter_7_2 + 1]
		end

		table.remove(arg_7_0.heroDataList_, #arg_7_0.heroDataList_)
	else
		arg_7_0.heroDataList_[arg_7_1] = {
			fatigue = 0,
			id = arg_7_3
		}
	end

	arg_7_0.headList_:Refresh()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		if arg_8_0.statusController_:GetSelectedState() == "edit" then
			-- block empty
		else
			arg_8_0:Back()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.cancelBtn_, nil, function()
		arg_8_0:SwitchToList()
	end)
	arg_8_0:AddBtnListener(arg_8_0.okBtn_, nil, function()
		if GuildActivityData:IsFirstConfigFightRole() and #arg_8_0.heroDataList_ < GuildActivityData:GetMaxFightHeroCount() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_FIGHT_HERO_NOT_FULL_TIP"),
				OkCallback = function()
					arg_8_0:SaveHeroes()
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		arg_8_0:SaveHeroes()
	end)
	arg_8_0:AddBtnListener(arg_8_0.editBtn_, nil, function()
		arg_8_0:StartEdit()
	end)
end

function var_0_0.StartEdit(arg_15_0)
	arg_15_0.statusController_:SetSelectedState("edit")

	arg_15_0.titleLabel_.text = GetTips("ACTIVITY_CLUB_HERO_EDIT")
	arg_15_0.editing_ = true

	local var_15_0 = GuildActivitySpTools.GetTopUserLevel(arg_15_0.params_.activityID)
	local var_15_1 = ActivityClubLevelSettingCfg[var_15_0].max_hero

	arg_15_0.headList_:StartScroll(var_15_1)
end

function var_0_0.SwitchToList(arg_16_0)
	arg_16_0.putOffHeroList_ = {}
	arg_16_0.heroDataList_ = GuildActivityData:GetFightHeroList()
	arg_16_0.heroDataList_ = deepClone(arg_16_0.heroDataList_)

	arg_16_0.statusController_:SetSelectedState("list")

	arg_16_0.titleLabel_.text = GetTips("ACTIVITY_CLUB_HERO_LIST")
	arg_16_0.editing_ = false

	arg_16_0.headList_:StartScroll(#arg_16_0.heroDataList_)
end

function var_0_0.SaveHeroes(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.heroDataList_) do
		table.insert(var_17_0, iter_17_1.id)
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.putOffHeroList_) do
		for iter_17_4, iter_17_5 in ipairs(arg_17_0.heroDataList_) do
			if iter_17_5.id == iter_17_3 then
				table.insert(var_17_1, iter_17_3)

				break
			end
		end
	end

	GuildActivityAction.SetFightMember(var_17_0, var_17_1)
	arg_17_0:SwitchToList()
end

function var_0_0.AddEventListeners(arg_18_0)
	arg_18_0:RegistEventListener(GUILD_ACTIVITY_HERO_LIST_UPDATE, function()
		arg_18_0:SwitchToList()
	end)
end

function var_0_0.OnTop(arg_20_0)
	arg_20_0:UpdateBar()
end

function var_0_0.OnBehind(arg_21_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_22_0.editing_ then
			arg_22_0:SwitchToList()

			return
		end

		arg_22_0:Back()
	end)
end

function var_0_0.OnEnter(arg_24_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	arg_24_0:AddEventListeners()

	if arg_24_0.params_.isEnter then
		arg_24_0:SwitchToList()

		arg_24_0.params_.isEnter = false
	end

	local var_24_0 = GameSetting.activity_club_hero_fatigue_recovery.value[1]

	arg_24_0.hoursLabel_.text = string.format(GetTips("ACTIVITY_CLUB_VITALITY_RECOVER"), tostring(60 / var_24_0))
end

function var_0_0.OnExit(arg_25_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	arg_25_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_26_0)
	return
end

function var_0_0.Dispose(arg_27_0)
	if arg_27_0.headList_ then
		arg_27_0.headList_:Dispose()

		arg_27_0.headList_ = nil
	end

	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
