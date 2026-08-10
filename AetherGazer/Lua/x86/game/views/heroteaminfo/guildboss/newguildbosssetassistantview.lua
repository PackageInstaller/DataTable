local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewGuildBossSetAssistantView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.filterView_:SetExtraSorter(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = GuildData:CheckCurrentHeroIDIsAssistant(arg_2_0.id) and 1 or 0
		local var_2_1 = GuildData:CheckCurrentHeroIDIsAssistant(arg_2_1.id) and 1 or 0

		if var_2_0 ~= var_2_1 then
			return true, var_2_1 < var_2_0
		end

		return false, false
	end)
end

function var_0_1.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_0.heroDataList_[arg_3_1].id

	if GuildData:CheckCurrentHeroIDIsAssistant(var_3_0) then
		arg_3_2:SetTeamMarkBg("purple")
		arg_3_2:SetTeamMark(true, GetTips("CURRENT_ASSISTANT"))
	else
		arg_3_2:SetTeamMark(false)
	end
end

function var_0_1.OnEnter(arg_4_0)
	var_0_1.super.OnEnter(arg_4_0)
	arg_4_0:AddEventListeners()
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)
	arg_5_0:RemoveAllEventListener()
end

function var_0_1.AddEventListeners(arg_6_0)
	arg_6_0:RegistEventListener(GUILD_BOSS_ASSISTANT_HERO_CHANGE, function(arg_7_0)
		arg_6_0.heroHeadList_:Refresh()
		arg_6_0:RefreshJoinBtn()
	end)
	arg_6_0:RegistEventListener(GUILD_EXIT, function()
		arg_6_0:Go("/home")
	end)
end

function var_0_1.GetHeroTeam(arg_9_0)
	arg_9_0.lockStateList_ = {
		false,
		false,
		false
	}
end

function var_0_1.OnJoinClick(arg_10_0)
	local var_10_0 = arg_10_0.selectHeroData_.id
	local var_10_1 = GuildData:GetGuildInfo().id

	if GuildData:CheckCurrentHeroIDIsAssistant(var_10_0) then
		GuildAction.SetAssistHero(var_10_1, var_10_0, false)

		return
	end

	local var_10_2 = GuildData:GetCurrentBossAssistantHeroId()

	if GameSetting.club_boss_assist_max_num.value[1] <= #var_10_2 then
		ShowTips("CLUB_BOSS_ASSIST_MAX_NUM")
	else
		GuildAction.SetAssistHero(var_10_1, var_10_0, true)
	end
end

function var_0_1.RefreshJoinBtn(arg_11_0)
	if GuildData:CheckCurrentHeroIDIsAssistant(arg_11_0.selectHeroData_.id) then
		arg_11_0.joinBtnController_:SetSelectedState("currentAssistant")

		arg_11_0.joinBtn_.interactable = true
	else
		arg_11_0.joinBtnController_:SetSelectedState("setAssistant")

		arg_11_0.joinBtn_.interactable = true
	end
end

function var_0_1.IsInTeam(arg_12_0, arg_12_1, arg_12_2)
	return GuildData:CheckCurrentHeroIDIsAssistant(arg_12_1), false, -1
end

function var_0_1.GetDefaultHeroData(arg_13_0)
	local var_13_0 = GuildData:GetCurrentBossAssistantHeroId()

	if var_13_0 and #var_13_0 > 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.heroDataList_) do
			if iter_13_1.id == var_13_0[1] then
				return iter_13_1
			end
		end
	end

	return arg_13_0.heroDataList_[1]
end

return var_0_1
