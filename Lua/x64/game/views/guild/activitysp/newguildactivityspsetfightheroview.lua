local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewGuildActivitySPSetFightHeroView", var_0_0)

function var_0_1.ExtraSorter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_0.params_.heroId or 0
	local var_1_1 = arg_1_1.id == var_1_0 and 1 or 0
	local var_1_2 = arg_1_2.id == var_1_0 and 1 or 0

	if var_1_1 ~= var_1_2 then
		return true, var_1_2 < var_1_1
	end

	return false, false
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	local var_2_0 = Asset.Load("UI/GuildActivitySPUI/items/spenergy")
	local var_2_1 = Object.Instantiate(var_2_0, arg_2_0.extensionContainer_)

	arg_2_0.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New(var_2_1)
end

function var_0_1.UpdateHeroView(arg_3_0)
	var_0_1.super.UpdateHeroView(arg_3_0)
	arg_3_0.energyItem_:SetCurrent(arg_3_0:IsHeroInTeam(arg_3_0.selectHeroData_.id))

	local var_3_0 = GameSetting.activity_club_sp_hero_fatigue_max.value[1]
	local var_3_1

	if GuildActivitySPData:IsFirstConfigFightRole() then
		var_3_1 = var_3_0
	else
		var_3_1 = table.indexof(arg_3_0.params_.putOffList, arg_3_0.selectHeroData_.id) and 0 or GuildActivitySPData:GetHeroFatigue(arg_3_0.selectHeroData_.id)
	end

	arg_3_0.energyItem_:SetData(var_3_0, var_3_1)
end

function var_0_1.OnEnter(arg_4_0)
	var_0_1.super.OnEnter(arg_4_0)
	arg_4_0:AddEventListeners()
end

function var_0_1.RefreshInfoBtn(arg_5_0)
	SetActive(arg_5_0.infoBtn_.gameObject, false)
end

function var_0_1.OnExit(arg_6_0)
	var_0_1.super.OnExit(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_1.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(GUILD_EXIT, function()
		arg_7_0:Go("/home")
	end)
end

function var_0_1.GetHeroTeam(arg_9_0)
	return
end

function var_0_1.OnJoinClick(arg_10_0)
	if arg_10_0.params_.heroId ~= nil and arg_10_0.params_.heroId > 0 then
		if arg_10_0.selectHeroData_.id == arg_10_0.params_.heroId then
			if not GuildActivitySPData:IsFirstConfigFightRole() then
				ShowMessageBox({
					content = GetTips("ACTIVITY_CLUB_REMOVE_TEAM_TIP"),
					OkCallback = function()
						if arg_10_0.params_.callback then
							arg_10_0.params_.callback(arg_10_0.params_.index, arg_10_0.params_.heroId, 0)
						end

						arg_10_0:Back()
					end,
					CancelCallback = function()
						return
					end
				})
			else
				if arg_10_0.params_.callback then
					arg_10_0.params_.callback(arg_10_0.params_.index, arg_10_0.params_.heroId, 0)
				end

				arg_10_0:Back()
			end
		elseif not GuildActivitySPData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function()
					if arg_10_0.params_.callback then
						arg_10_0.params_.callback(arg_10_0.params_.index, arg_10_0.params_.heroId, arg_10_0.selectHeroData_.id)
					end

					arg_10_0:Back()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			if arg_10_0.params_.callback then
				arg_10_0.params_.callback(arg_10_0.params_.index, arg_10_0.params_.heroId, arg_10_0.selectHeroData_.id)
			end

			arg_10_0:Back()
		end
	else
		if arg_10_0.params_.callback then
			arg_10_0.params_.callback(arg_10_0.params_.index, 0, arg_10_0.selectHeroData_.id)
		end

		arg_10_0:Back()
	end
end

function var_0_1.RefreshJoinBtn(arg_15_0)
	arg_15_0.joinBtn_.interactable = true

	if arg_15_0.params_.heroId ~= nil and arg_15_0.params_.heroId > 0 then
		if arg_15_0.selectHeroData_.id == arg_15_0.params_.heroId then
			arg_15_0.joinBtnController_:SetSelectedState("out")
		else
			arg_15_0.joinBtnController_:SetSelectedState("change")
		end
	else
		arg_15_0.joinBtnController_:SetSelectedState("add")
	end
end

function var_0_1.IsInTeam(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_1 == arg_16_0.params_.heroId, false, -1
end

function var_0_1.GetDefaultHeroData(arg_17_0)
	return arg_17_0.heroDataList_[1]
end

function var_0_1.GetHeroList(arg_18_0)
	local var_18_0 = HeroData:GetHeroList()
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if not arg_18_0:IsHeroInTeam(iter_18_1.id) or iter_18_1.id == arg_18_0.params_.heroId then
			var_18_1[iter_18_1.id] = iter_18_1
		end
	end

	return (HeroTools.Sort(var_18_1))
end

function var_0_1.ChangeTeam(arg_19_0, arg_19_1, arg_19_2)
	return
end

function var_0_1.IsHeroInTeam(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.params_.heroList

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.id == arg_20_1 then
			return true
		end
	end

	return false
end

function var_0_1.Dispose(arg_21_0)
	if arg_21_0.energyItem_ then
		arg_21_0.energyItem_:Dispose()

		arg_21_0.energyItem_ = nil
	end

	var_0_1.super.Dispose(arg_21_0)
end

return var_0_1
