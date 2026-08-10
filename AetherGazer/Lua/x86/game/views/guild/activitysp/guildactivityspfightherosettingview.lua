local var_0_0 = class("GuildActivitySPFightHeroSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPFightHeroPopUI"
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
	arg_5_0.headList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, GuildActivitySPFightHeadItemView)
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
			arg_8_0:SwitchToList()
		else
			arg_8_0:Back()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.cancelBtn_, nil, function()
		arg_8_0:SwitchToList()
	end)
	arg_8_0:AddBtnListener(arg_8_0.okBtn_, nil, function()
		if GuildActivitySPData:IsFirstConfigFightRole() and #arg_8_0.heroDataList_ < GuildActivitySPData:GetMaxFightHeroCount() then
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

function var_0_0.StartEdit(arg_16_0)
	arg_16_0.statusController_:SetSelectedState("edit")

	arg_16_0.editing_ = true

	local var_16_0 = ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all]
	local var_16_1 = ActivityClubSPLevelSettingCfg[var_16_0].max_hero

	arg_16_0.headList_:StartScroll(var_16_1)
end

function var_0_0.SwitchToList(arg_17_0)
	arg_17_0.putOffHeroList_ = {}
	arg_17_0.heroDataList_ = GuildActivitySPData:GetFightHeroList()
	arg_17_0.heroDataList_ = deepClone(arg_17_0.heroDataList_)

	arg_17_0.statusController_:SetSelectedState("list")

	arg_17_0.editing_ = false

	arg_17_0.headList_:StartScroll(#arg_17_0.heroDataList_)
end

function var_0_0.SaveHeroes(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.heroDataList_) do
		table.insert(var_18_0, iter_18_1.id)
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.putOffHeroList_) do
		for iter_18_4, iter_18_5 in ipairs(arg_18_0.heroDataList_) do
			if iter_18_5.id == iter_18_3 then
				table.insert(var_18_1, iter_18_3)

				break
			end
		end
	end

	GuildActivitySPAction.SetFightMember(var_18_0, var_18_1)
	arg_18_0:SwitchToList()
end

function var_0_0.AddEventListeners(arg_19_0)
	arg_19_0:RegistEventListener(GUILD_ACTIVITY_SP_HERO_LIST_UPDATE, function()
		arg_19_0:SwitchToList()
	end)
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:UpdateBar()
end

function var_0_0.OnBehind(arg_22_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_23_0.editing_ then
			arg_23_0:SwitchToList()

			return
		end

		arg_23_0:Back()
	end)
end

function var_0_0.OnEnter(arg_25_0)
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	arg_25_0:AddEventListeners()

	if arg_25_0.params_.isEnter then
		arg_25_0:SwitchToList()

		arg_25_0.params_.isEnter = false
	end

	local var_25_0 = GameSetting.activity_club_sp_hero_fatigue_recovery.value[1]

	arg_25_0.hoursLabel_.text = string.format(GetTips("ACTIVITY_CLUB_VITALITY_RECOVER"), tostring(60 / var_25_0))
end

function var_0_0.OnExit(arg_26_0)
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(true)
	arg_26_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_27_0)
	return
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.headList_ then
		arg_28_0.headList_:Dispose()

		arg_28_0.headList_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
