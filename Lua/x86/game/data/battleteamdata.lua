require("game.data.BattleTeamDataTemplate")

local var_0_0 = singletonClass("BattleTeamData")

function var_0_0.Init(arg_1_0)
	arg_1_0.battleTeam_ = {}
	arg_1_0.stageTeam_ = {}
	arg_1_0.stageTeamTrial_ = {}
	arg_1_0.trialActivityData_ = {}
	arg_1_0.teamRawData_ = {}
	arg_1_0.reservesTeamList_ = {}
	arg_1_0.reservesTempTeamList_ = {}
end

var_0_0.NO_OWNER = "0"
var_0_0.EMPTY_ENTRY = {
	hero_id = 0,
	owner_id = var_0_0.NO_OWNER
}

function var_0_0.IsValidOwner(arg_2_0)
	if arg_2_0 == nil then
		return false
	end

	return tostring(arg_2_0) ~= var_0_0.NO_OWNER
end

function var_0_0.CreatBaseTeamInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = GetHeroTeamActivityID(arg_3_1, arg_3_2)

	arg_3_0.battleTeam_[arg_3_1] = arg_3_0.battleTeam_[arg_3_1] or {}
	arg_3_0.battleTeam_[arg_3_1][var_3_0] = arg_3_0.battleTeam_[arg_3_1][var_3_0] or {}
	arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams = arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams or {}

	if arg_3_0.battleTeam_[arg_3_1][var_3_0] and not arg_3_3 and not arg_3_4 and #arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams > 0 then
		return
	end

	local var_3_1

	if arg_3_3 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams) do
			if iter_3_1.cont_id == arg_3_3 then
				var_3_1 = iter_3_1
			end
		end
	else
		var_3_1 = arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams[1]
	end

	var_3_1 = var_3_1 or {
		teams = {},
		cont_id = arg_3_3
	}

	local var_3_2

	if arg_3_4 then
		for iter_3_2, iter_3_3 in ipairs(var_3_1.teams) do
			if iter_3_3.id == arg_3_4 then
				return
			end
		end
	else
		var_3_2 = var_3_1.teams[1]
	end

	var_3_2 = var_3_2 or {
		combo = 0,
		id = arg_3_4,
		singleTeam = {
			0,
			0,
			0
		},
		heroTrialList = {
			0,
			0,
			0
		},
		heroAssistList = {
			clone(var_0_0.EMPTY_ENTRY),
			clone(var_0_0.EMPTY_ENTRY),
			clone(var_0_0.EMPTY_ENTRY)
		},
		mimir = {
			id = 0,
			chip = {}
		}
	}

	table.insert(var_3_1.teams, var_3_2)
	table.insert(arg_3_0.battleTeam_[arg_3_1][var_3_0].cont_teams, var_3_1)

	local var_3_3 = {
		chess_data_info_1 = {},
		chess_data_info_2 = {}
	}

	arg_3_0.battleTeam_[arg_3_1][var_3_0].data = arg_3_0.battleTeam_[arg_3_1][var_3_0].data or var_3_3
end

function var_0_0.GetSingleTeam(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = GetHeroTeamActivityID(arg_4_1, arg_4_2)

	arg_4_0:CreatBaseTeamInfo(arg_4_1, var_4_0, arg_4_3, arg_4_4)

	if not arg_4_3 or arg_4_3 == 0 then
		if not arg_4_4 or arg_4_4 == 0 then
			return clone(arg_4_0.battleTeam_[arg_4_1][var_4_0].cont_teams[1].teams[1].singleTeam or {
				0,
				0,
				0
			}), clone(arg_4_0.battleTeam_[arg_4_1][var_4_0].cont_teams[1].teams[1].heroTrialList or {
				0,
				0,
				0
			})
		else
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.battleTeam_[arg_4_1][var_4_0].cont_teams[1].teams) do
				if iter_4_1.id == arg_4_4 then
					return clone(iter_4_1.singleTeam or {
						0,
						0,
						0
					}), clone(iter_4_1.heroTrialList or {
						0,
						0,
						0
					})
				end
			end
		end
	else
		for iter_4_2, iter_4_3 in ipairs(arg_4_0.battleTeam_[arg_4_1][var_4_0].cont_teams) do
			if iter_4_3.cont_id == arg_4_3 then
				if not arg_4_4 or arg_4_4 == 0 then
					return clone(iter_4_3.teams[1].singleTeam or {
						0,
						0,
						0
					}), clone(iter_4_3.teams[1].heroTrialList or {
						0,
						0,
						0
					})
				else
					for iter_4_4, iter_4_5 in ipairs(iter_4_3.teams) do
						if iter_4_5.id == arg_4_4 then
							return clone(iter_4_5.singleTeam or {
								0,
								0,
								0
							}), clone(iter_4_5.heroTrialList or {
								0,
								0,
								0
							})
						end
					end
				end
			end
		end
	end

	return {
		0,
		0,
		0
	}, {
		0,
		0,
		0
	}
end

function var_0_0.GetMimirInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = GetHeroTeamActivityID(arg_5_1, arg_5_2)

	arg_5_0:CreatBaseTeamInfo(arg_5_1, var_5_0, arg_5_3, arg_5_4)

	if not arg_5_3 or arg_5_3 == 0 then
		if not arg_5_4 or arg_5_4 == 0 then
			return clone(arg_5_0.battleTeam_[arg_5_1][var_5_0].cont_teams[1].teams[1].mimir.id or 0), clone(arg_5_0.battleTeam_[arg_5_1][var_5_0].cont_teams[1].teams[1].mimir.chip or {})
		else
			for iter_5_0, iter_5_1 in ipairs(arg_5_0.battleTeam_[arg_5_1][var_5_0].cont_teams[1].teams) do
				if iter_5_1.id == arg_5_4 then
					return clone(iter_5_1.mimir.id or 0), clone(iter_5_1.mimir.chip or {})
				end
			end
		end
	else
		for iter_5_2, iter_5_3 in ipairs(arg_5_0.battleTeam_[arg_5_1][var_5_0].cont_teams) do
			if iter_5_3.cont_id == arg_5_3 then
				if not arg_5_4 or arg_5_4 == 0 then
					return clone(iter_5_3.teams[1].mimir.id or 0), clone(iter_5_3.teams[1].mimir.chip or {})
				else
					for iter_5_4, iter_5_5 in ipairs(iter_5_3.teams) do
						if iter_5_5.id == arg_5_4 then
							return clone(iter_5_5.mimir.id or 0), clone(iter_5_5.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return 0, {}
end

function var_0_0.GetMimirIDInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = GetHeroTeamActivityID(arg_6_1, arg_6_2)

	arg_6_0:CreatBaseTeamInfo(arg_6_1, var_6_0, arg_6_3, arg_6_4)

	if not arg_6_3 or arg_6_3 == 0 then
		if not arg_6_4 or arg_6_4 == 0 then
			return clone(arg_6_0.battleTeam_[arg_6_1][var_6_0].cont_teams[1].teams[1].mimir.id or 0)
		else
			for iter_6_0, iter_6_1 in ipairs(arg_6_0.battleTeam_[arg_6_1][var_6_0].cont_teams[1].teams) do
				if iter_6_1.id == arg_6_4 then
					return clone(iter_6_1.mimir.id or 0)
				end
			end
		end
	else
		for iter_6_2, iter_6_3 in ipairs(arg_6_0.battleTeam_[arg_6_1][var_6_0].cont_teams) do
			if iter_6_3.cont_id == arg_6_3 then
				if not arg_6_4 or arg_6_4 == 0 then
					return clone(iter_6_3.teams[1].mimir.id or 0)
				else
					for iter_6_4, iter_6_5 in ipairs(iter_6_3.teams) do
						if iter_6_5.id == arg_6_4 then
							return clone(iter_6_5.mimir.id or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function var_0_0.GetMimirChipInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = GetHeroTeamActivityID(arg_7_1, arg_7_2)

	arg_7_0:CreatBaseTeamInfo(arg_7_1, var_7_0, arg_7_3, arg_7_4)

	if not arg_7_3 or arg_7_3 == 0 then
		if not arg_7_4 or arg_7_4 == 0 then
			return clone(arg_7_0.battleTeam_[arg_7_1][var_7_0].cont_teams[1].teams[1].mimir.chip or {})
		else
			for iter_7_0, iter_7_1 in ipairs(arg_7_0.battleTeam_[arg_7_1][var_7_0].cont_teams[1].teams) do
				if iter_7_1.id == arg_7_4 then
					return clone(iter_7_1.mimir.chip or {})
				end
			end
		end
	else
		for iter_7_2, iter_7_3 in ipairs(arg_7_0.battleTeam_[arg_7_1][var_7_0].cont_teams) do
			if iter_7_3.cont_id == arg_7_3 then
				if not arg_7_4 or arg_7_4 == 0 then
					return clone(iter_7_3.teams[1].mimir.chip or {})
				else
					for iter_7_4, iter_7_5 in ipairs(iter_7_3.teams) do
						if iter_7_5.id == arg_7_4 then
							return clone(iter_7_5.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return {}
end

function var_0_0.SetMimirIDInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = GetHeroTeamActivityID(arg_8_1, arg_8_2)

	arg_8_0:CreatBaseTeamInfo(arg_8_1, var_8_0, arg_8_4, arg_8_5)

	local var_8_1

	if not arg_8_4 or arg_8_4 == 0 then
		if not arg_8_5 or arg_8_5 == 0 then
			var_8_1 = arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams[1].teams[1].mimir
		else
			for iter_8_0, iter_8_1 in ipairs(arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams[1].teams) do
				if iter_8_1.id == arg_8_5 then
					var_8_1 = iter_8_1.mimir

					break
				end
			end
		end
	else
		for iter_8_2, iter_8_3 in ipairs(arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams) do
			if iter_8_3.cont_id == arg_8_4 then
				if not arg_8_5 or arg_8_5 == 0 then
					var_8_1 = iter_8_3.teams[1].mimir

					break
				end

				for iter_8_4, iter_8_5 in ipairs(iter_8_3.teams) do
					if iter_8_5.id == arg_8_5 then
						var_8_1 = iter_8_5.mimir

						break
					end
				end

				break
			end
		end
	end

	if var_8_1 then
		var_8_1.id = arg_8_3 or 0

		if not var_8_1 or arg_8_3 == 0 then
			var_8_1.chip = arg_8_0:GetMimirChipInfo(arg_8_1, arg_8_2, arg_8_4, arg_8_5)
		end
	end
end

function var_0_0.SetMimirChipInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = GetHeroTeamActivityID(arg_9_1, arg_9_2)

	arg_9_0:CreatBaseTeamInfo(arg_9_1, var_9_0, arg_9_4, arg_9_5)

	if not arg_9_4 or arg_9_4 == 0 then
		if not arg_9_5 or arg_9_5 == 0 then
			arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams[1].teams[1].mimir.chip = clone(arg_9_3 or {})
		else
			for iter_9_0, iter_9_1 in ipairs(arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams[1].teams) do
				if iter_9_1.id == arg_9_5 then
					iter_9_1.mimir.chip = clone(arg_9_3 or {})

					break
				end
			end
		end
	else
		for iter_9_2, iter_9_3 in ipairs(arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams) do
			if iter_9_3.cont_id == arg_9_4 then
				if not arg_9_5 or arg_9_5 == 0 then
					iter_9_3.teams[1].mimir.chip = clone(arg_9_3 or {})

					break
				end

				for iter_9_4, iter_9_5 in ipairs(iter_9_3.teams) do
					if iter_9_5.id == arg_9_5 then
						iter_9_5.mimir.chip = clone(arg_9_3 or {})

						break
					end
				end

				break
			end
		end
	end
end

function var_0_0.InsertMimirChipInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = GetHeroTeamActivityID(arg_10_1, arg_10_2)
	local var_10_1 = {}

	arg_10_0:CreatBaseTeamInfo(arg_10_1, var_10_0, arg_10_4, arg_10_5)

	if not arg_10_4 or arg_10_4 == 0 then
		if not arg_10_5 or arg_10_5 == 0 then
			var_10_1 = arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams[1].teams[1].mimir.chip
		else
			for iter_10_0, iter_10_1 in ipairs(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams[1].teams) do
				if iter_10_1.id == arg_10_5 then
					var_10_1 = iter_10_1.mimir.chip

					break
				end
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams) do
			if iter_10_3.cont_id == arg_10_4 then
				if not arg_10_5 or arg_10_5 == 0 then
					var_10_1 = iter_10_3.teams[1].mimir.chip

					break
				end

				for iter_10_4, iter_10_5 in ipairs(iter_10_3.teams) do
					if iter_10_5.id == arg_10_5 then
						var_10_1 = iter_10_5.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.InsertChip(var_10_1, arg_10_3)
end

function var_0_0.RemoveMimirChipInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = GetHeroTeamActivityID(arg_11_1, arg_11_2)
	local var_11_1 = {}

	arg_11_0:CreatBaseTeamInfo(arg_11_1, var_11_0, arg_11_4, arg_11_5)

	if not arg_11_4 or arg_11_4 == 0 then
		if not arg_11_5 or arg_11_5 == 0 then
			var_11_1 = arg_11_0.battleTeam_[arg_11_1][var_11_0].cont_teams[1].teams[1].mimir.chip
		else
			for iter_11_0, iter_11_1 in ipairs(arg_11_0.battleTeam_[arg_11_1][var_11_0].cont_teams[1].teams) do
				if iter_11_1.id == arg_11_5 then
					var_11_1 = iter_11_1.mimir.chip

					break
				end
			end
		end
	else
		for iter_11_2, iter_11_3 in ipairs(arg_11_0.battleTeam_[arg_11_1][var_11_0].cont_teams) do
			if iter_11_3.cont_id == arg_11_4 then
				if not arg_11_5 or arg_11_5 == 0 then
					var_11_1 = iter_11_3.teams[1].mimir.chip

					break
				end

				for iter_11_4, iter_11_5 in ipairs(iter_11_3.teams) do
					if iter_11_5.id == arg_11_5 then
						var_11_1 = iter_11_5.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.RemoveChip(var_11_1, arg_11_3)
end

function var_0_0.GetComboInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = GetHeroTeamActivityID(arg_12_1, arg_12_2)

	arg_12_0:CreatBaseTeamInfo(arg_12_1, var_12_0, arg_12_3, arg_12_4)

	if not arg_12_3 or arg_12_3 == 0 then
		if not arg_12_4 or arg_12_4 == 0 then
			return clone(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams[1].teams[1].combo or 0)
		else
			for iter_12_0, iter_12_1 in ipairs(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams[1].teams) do
				if iter_12_1.id == arg_12_4 then
					return clone(iter_12_1.combo or 0)
				end
			end
		end
	else
		for iter_12_2, iter_12_3 in ipairs(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams) do
			if iter_12_3.cont_id == arg_12_3 then
				if not arg_12_4 or arg_12_4 == 0 then
					return clone(iter_12_3.teams[1].combo or 0)
				else
					for iter_12_4, iter_12_5 in ipairs(iter_12_3.teams) do
						if iter_12_5.id == arg_12_4 then
							return clone(iter_12_5.combo or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function var_0_0.SetComboInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = GetHeroTeamActivityID(arg_13_1, arg_13_2)

	arg_13_0:CreatBaseTeamInfo(arg_13_1, var_13_0, arg_13_4, arg_13_5)

	if not arg_13_4 or arg_13_4 == 0 then
		if not arg_13_5 or arg_13_5 == 0 then
			arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams[1].teams[1].combo = arg_13_3
		else
			for iter_13_0, iter_13_1 in ipairs(arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams[1].teams) do
				if iter_13_1.id == arg_13_5 then
					iter_13_1.combo = arg_13_3

					break
				end
			end
		end
	else
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams) do
			if iter_13_3.cont_id == arg_13_4 then
				if not arg_13_5 or arg_13_5 == 0 then
					iter_13_3.teams[1].combo = arg_13_3

					break
				end

				for iter_13_4, iter_13_5 in ipairs(iter_13_3.teams) do
					if iter_13_5.id == arg_13_5 then
						iter_13_5.combo = arg_13_3

						break
					end
				end

				break
			end
		end
	end
end

function var_0_0.UpdateHeroTrial(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.hero_trial_list) do
		arg_14_0.trialActivityData_[iter_14_1.activity_id] = {}

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.template_hero_list) do
			table.insert(arg_14_0.trialActivityData_[iter_14_1.activity_id], iter_14_3)
		end
	end
end

function var_0_0.GetHeroTrial(arg_15_0, arg_15_1)
	if ActivityTools.GetActivityType(arg_15_1) == ActivityTemplateConst.SURVIVE_SOLO_LEVEL then
		return ActivitySoloSlayerCfg[arg_15_1].hero_standard_system_id_list
	end

	return arg_15_0.trialActivityData_[arg_15_1]
end

function var_0_0.SetHeroTrial(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.trialActivityData_[arg_16_1] = arg_16_2
end

function var_0_0.IsInList(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.hero_list

	for iter_17_0 = 1, 10 do
		local var_17_1 = arg_17_0.reservesTeamList_[iter_17_0]
		local var_17_2 = arg_17_0.reservesTeamList_[iter_17_0].hero_list

		if var_17_0[1] == var_17_2[1] and var_17_0[2] == var_17_2[2] and var_17_0[3] == var_17_2[3] and arg_17_2.comboSkill == var_17_1.comboSkill and arg_17_2.chipInfo.id == var_17_1.chipInfo.id and #arg_17_2.chipInfo.list == #var_17_1.chipInfo.list then
			for iter_17_1, iter_17_2 in ipairs(arg_17_2.chipInfo.list) do
				if not table.indexof(var_17_1.chipInfo.list, iter_17_2) then
					return false
				end
			end

			return true
		end
	end

	return false
end

return var_0_0
