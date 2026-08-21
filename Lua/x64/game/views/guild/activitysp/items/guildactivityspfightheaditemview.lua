local var_0_0 = class("GuildActivitySPFightHeadItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.emptyController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "empty")
	arg_3_0.heroHead_ = NewHeroHead.New(arg_3_0.heroHeadGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.addBtn_, nil, function()
		if not arg_4_0.editing_ then
			return
		end

		if HeroData:GetHeroNum() <= #arg_4_0.heroList_ then
			ShowTips("ACTIVITY_CLUB_HERO_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/guildActivitySPSetFightHero", {
			putOffList = arg_4_0.putOffList_,
			heroList = arg_4_0.heroList_,
			index = arg_4_0.index_,
			callback = handler(arg_4_0, arg_4_0.OnSelectHero)
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.lockBtn_, nil, function()
		if not arg_4_0.editing_ then
			return
		end

		local var_6_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_4_0.activityID_]
		local var_6_1 = 1

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if ActivityClubSPLevelSettingCfg[iter_6_1].max_hero >= arg_4_0.index_ then
				var_6_1 = ActivityClubSPLevelSettingCfg[iter_6_1].user_level

				break
			end
		end

		ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_6_1)))
	end)
	arg_4_0.heroHead_:RegisterClickListener(function()
		if not arg_4_0.editing_ then
			return
		end

		JumpTools.OpenPageByJump("/guildActivitySPSetFightHero", {
			putOffList = arg_4_0.putOffList_,
			heroList = arg_4_0.heroList_,
			index = arg_4_0.index_,
			heroId = arg_4_0.heroData_.id,
			callback = handler(arg_4_0, arg_4_0.OnSelectHero)
		})
	end)
end

function var_0_0.SetEditing(arg_8_0, arg_8_1)
	arg_8_0.editing_ = arg_8_1
end

function var_0_0.SetHeroChangeHandler(arg_9_0, arg_9_1)
	arg_9_0.heroChangeHandler_ = arg_9_1
end

function var_0_0.OnSelectHero(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0.heroChangeHandler_ then
		arg_10_0.heroChangeHandler_(arg_10_1, arg_10_2, arg_10_3)
	end
end

function var_0_0.AddEventListeners(arg_11_0)
	return
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_0.index_ = arg_12_1
	arg_12_0.heroList_ = arg_12_2
	arg_12_0.heroData_ = arg_12_2[arg_12_1] or nil
	arg_12_0.putOffList_ = arg_12_3
	arg_12_0.activityID_ = arg_12_4

	arg_12_0:UpdateView()
end

function var_0_0.UpdateView(arg_13_0)
	if arg_13_0.index_ > GuildActivitySPData:GetMaxFightHeroCount() then
		arg_13_0.emptyController_:SetSelectedState("lock")
	elseif arg_13_0.heroData_ ~= nil then
		arg_13_0.emptyController_:SetSelectedState("hero")
		arg_13_0.heroHead_:SetHeroData(arg_13_0.heroData_.id)

		local var_13_0 = table.indexof(arg_13_0.putOffList_, arg_13_0.heroData_.id)

		arg_13_0.energyLabel_.text = GuildActivitySPData:GetHeroFatigue(arg_13_0.heroData_.id)
	else
		arg_13_0.emptyController_:SetSelectedState("add")
	end
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.data_ = nil

	if arg_17_0.heroHead_ then
		arg_17_0.heroHead_:Dispose()

		arg_17_0.heroHead_ = nil
	end

	arg_17_0.heroChangeHandler_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
