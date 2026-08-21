local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("GuildActivitySetFightHeroView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.filterView_:SetExtraSorter(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0.params_.heroId or 0
		local var_2_1 = arg_2_0.id == var_2_0 and 1 or 0
		local var_2_2 = arg_2_1.id == var_2_0 and 1 or 0

		if var_2_1 ~= var_2_2 then
			return true, var_2_2 < var_2_1
		end

		return false, false
	end)
end

function var_0_1.InitUI(arg_3_0)
	var_0_1.super.InitUI(arg_3_0)

	local var_3_0 = Asset.Load("UI/GuildActivityUI/items/energy")
	local var_3_1 = Object.Instantiate(var_3_0, arg_3_0.extensionContainer_)

	arg_3_0.energyItem_ = GuildActivityTeamInfoEnergyItemView.New(var_3_1)
end

function var_0_1.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_1.UpdateHeroView(arg_5_0)
	local var_5_0 = HeroTools.HeroUsingSkinInfo(arg_5_0.selectID_).id
	local var_5_1 = arg_5_0.selectID_

	arg_5_0.fightPowerText_.text = GetI18NText(getHeroPower(var_5_1, false))

	arg_5_0.heroAvatarView_:SetSkinId(var_5_0)

	local var_5_2 = HeroCfg[var_5_1]

	arg_5_0.nameText_.text = GetI18NText(var_5_2.name)
	arg_5_0.subNameText_.text = GetI18NText(var_5_2.suffix)

	arg_5_0.energyItem_:SetCurrent(arg_5_0:IsHeroInTeam(arg_5_0.selectID_))

	local var_5_3 = GameSetting.activity_club_hero_fatigue_max.value[1]
	local var_5_4

	if GuildActivityData:IsFirstConfigFightRole() then
		var_5_4 = var_5_3
	else
		var_5_4 = table.indexof(arg_5_0.params_.putOffList, arg_5_0.selectID_) and 0 or GuildActivityData:GetHeroFatigue(arg_5_0.selectID_)
	end

	arg_5_0.energyItem_:SetData(var_5_3, var_5_4)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)
	arg_6_0:AddEventListeners()
end

function var_0_1.RefreshInfoBtn(arg_7_0)
	SetActive(arg_7_0.infoBtn_.gameObject, false)
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_1.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(GUILD_EXIT, function()
		arg_9_0:Go("/home")
	end)
end

function var_0_1.GetHeroTeam(arg_11_0)
	return
end

function var_0_1.GetRestrictHeroList(arg_12_0, arg_12_1)
	return nil
end

function var_0_1.OnJoinClick(arg_13_0)
	if arg_13_0.params_.heroId ~= nil and arg_13_0.params_.heroId > 0 then
		if arg_13_0.selectID_ == arg_13_0.params_.heroId then
			if not GuildActivityData:IsFirstConfigFightRole() then
				ShowMessageBox({
					content = GetTips("ACTIVITY_CLUB_REMOVE_TEAM_TIP"),
					OkCallback = function()
						if arg_13_0.params_.callback then
							arg_13_0.params_.callback(arg_13_0.params_.index, arg_13_0.params_.heroId, 0)
						end

						arg_13_0:Back()
					end,
					CancelCallback = function()
						return
					end
				})
			else
				if arg_13_0.params_.callback then
					arg_13_0.params_.callback(arg_13_0.params_.index, arg_13_0.params_.heroId, 0)
				end

				arg_13_0:Back()
			end
		elseif not GuildActivityData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function()
					if arg_13_0.params_.callback then
						arg_13_0.params_.callback(arg_13_0.params_.index, arg_13_0.params_.heroId, arg_13_0.selectID_)
					end

					arg_13_0:Back()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			if arg_13_0.params_.callback then
				arg_13_0.params_.callback(arg_13_0.params_.index, arg_13_0.params_.heroId, arg_13_0.selectID_)
			end

			arg_13_0:Back()
		end
	else
		if arg_13_0.params_.callback then
			arg_13_0.params_.callback(arg_13_0.params_.index, 0, arg_13_0.selectID_)
		end

		arg_13_0:Back()
	end
end

function var_0_1.GetTextAndImage(arg_18_0)
	if arg_18_0.params_.heroId ~= nil and arg_18_0.params_.heroId > 0 then
		if arg_18_0.selectID_ == arg_18_0.params_.heroId then
			return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2", true
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0", true
		end
	else
		return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0", true
	end
end

function var_0_1.IsInTeam(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_1 == arg_19_0.params_.heroId, false, -1
end

function var_0_1.GetDefaultHeroData(arg_20_0)
	return arg_20_0.heroDataList_[1].id, 0
end

function var_0_1.GetHeroList(arg_21_0)
	local var_21_0 = HeroData:GetHeroList()
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if not arg_21_0:IsHeroInTeam(iter_21_1.id) or iter_21_1.id == arg_21_0.params_.heroId then
			var_21_1[iter_21_1.id] = iter_21_1
		end
	end

	return (HeroTools.Sort(var_21_1))
end

function var_0_1.ChangeTeam(arg_22_0, arg_22_1, arg_22_2)
	return
end

function var_0_1.IsHeroInTeam(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.params_.heroList

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.id == arg_23_1 then
			return true
		end
	end

	return false
end

function var_0_1.Dispose(arg_24_0)
	if arg_24_0.energyItem_ then
		arg_24_0.energyItem_:Dispose()

		arg_24_0.energyItem_ = nil
	end

	var_0_1.super.Dispose(arg_24_0)
end

return var_0_1
