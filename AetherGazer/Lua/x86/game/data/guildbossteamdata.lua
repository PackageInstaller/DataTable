local var_0_0 = singletonClass("GuildBossTeamData")

function var_0_0.Init(arg_1_0)
	arg_1_0.singleTeam_ = {}
	arg_1_0.heroTrialList_ = {}
	arg_1_0.stageTeam_ = {}
	arg_1_0.stageTeamTrial_ = {}
	arg_1_0.serverTeam_ = {}
	arg_1_0.trialActivityData_ = {}
end

function var_0_0.InitTeam(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_1.type

		arg_2_0.singleTeam_[var_2_0] = {}
		arg_2_0.heroTrialList_[var_2_0] = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.hero_list) do
			if iter_2_3.hero_type == 1 or iter_2_3.hero_id == 0 then
				arg_2_0.singleTeam_[var_2_0][iter_2_2] = iter_2_3.hero_id
				arg_2_0.heroTrialList_[var_2_0][iter_2_2] = 0
			else
				arg_2_0.singleTeam_[var_2_0][iter_2_2] = HeroStandardSystemCfg[iter_2_3.hero_id].hero_id
				arg_2_0.heroTrialList_[var_2_0][iter_2_2] = iter_2_3.hero_id
			end
		end

		for iter_2_4 = 1, 3 do
			arg_2_0.singleTeam_[var_2_0][iter_2_4] = arg_2_0.singleTeam_[var_2_0][iter_2_4] or 0
			arg_2_0.heroTrialList_[var_2_0][iter_2_4] = arg_2_0.heroTrialList_[var_2_0][iter_2_4] or 0
		end
	end
end

function var_0_0.UpdateRoomData(arg_3_0, arg_3_1)
	arg_3_0.roomID_ = arg_3_1.room_id

	local var_3_0 = {}

	for iter_3_0 = 1, 3 do
		local var_3_1 = arg_3_1.player_list[iter_3_0]

		if var_3_1 then
			local var_3_2 = {}

			for iter_3_1, iter_3_2 in ipairs(var_3_1.hero_list) do
				local var_3_3 = iter_3_2.hero_id
				local var_3_4 = 0

				if iter_3_2.hero_type == 2 then
					var_3_3 = HeroStandardSystemCfg[var_3_3].hero_id
					var_3_4 = iter_3_2.hero_id
				end

				local var_3_5 = {
					id = var_3_3,
					trialID = var_3_4,
					star = iter_3_2.star,
					exp = iter_3_2.exp,
					level = HeroTools.CheckExp(1, iter_3_2.exp),
					equip_list = {},
					using_astrolabe = {},
					skill = {},
					break_level = iter_3_2.break_level,
					weapon_info = {
						exp = iter_3_2.weapon_info.exp,
						breakthrough = iter_3_2.weapon_info.breakthrough
					}
				}

				if iter_3_2.weapon_info.servant then
					var_3_5.servantInfo = {
						id = iter_3_2.weapon_info.servant.id,
						stage = iter_3_2.weapon_info.servant.stage
					}
				else
					var_3_5.servantInfo = {}
				end

				if iter_3_2.equip_list then
					for iter_3_3, iter_3_4 in ipairs(iter_3_2.equip_list) do
						local var_3_6 = {}

						if iter_3_4.enchant_slot_list then
							for iter_3_5, iter_3_6 in ipairs(iter_3_4.enchant_slot_list) do
								local var_3_7 = iter_3_6.id
								local var_3_8 = iter_3_6.effect_list
								local var_3_9 = {}

								for iter_3_7, iter_3_8 in ipairs(var_3_8) do
									table.insert(var_3_9, {
										id = iter_3_8.id,
										num = iter_3_8.level
									})
								end

								if #var_3_9 > 0 then
									var_3_6[iter_3_5] = var_3_9
								end
							end
						end

						var_3_5.equip_list[iter_3_3] = {
							equip_id = iter_3_4.equip_id,
							prefab_id = iter_3_4.prefab_id,
							exp = iter_3_4.exp,
							now_break_level = iter_3_4.now_break_level or 0,
							enchant = var_3_6,
							race = iter_3_4.race
						}
					end
				end

				if iter_3_2.astrolabe_list then
					for iter_3_9, iter_3_10 in ipairs(iter_3_2.astrolabe_list) do
						var_3_5.using_astrolabe[iter_3_9] = iter_3_10
					end
				end

				if iter_3_2.skill then
					for iter_3_11, iter_3_12 in ipairs(iter_3_2.skill) do
						var_3_5.skill[iter_3_11] = {
							skill_id = iter_3_12.skill_id,
							skill_level = iter_3_12.skill_level
						}
					end
				end

				table.insert(var_3_2, var_3_5)
			end

			var_3_0[iter_3_0] = {
				playerID = var_3_1.player_id,
				nick = var_3_1.nick,
				level = var_3_1.level,
				channel = var_3_1.channel,
				server = var_3_1.server,
				is_ready = var_3_1.is_ready,
				is_master = var_3_1.is_master,
				heroList = var_3_2
			}
		end
	end

	arg_3_0.serverTeam_ = {
		dest = arg_3_1.dest,
		available = arg_3_1.available,
		access = arg_3_1.access,
		level = arg_3_1.level,
		playerList = var_3_0
	}
end

function var_0_0.GetRoomID(arg_4_0)
	return arg_4_0.roomID_
end

function var_0_0.GetServerTeam(arg_5_0)
	return arg_5_0.serverTeam_
end

function var_0_0.SetSingleTeam(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.singleTeam_[arg_6_1] = {}

	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_2[iter_6_0] or 0

		arg_6_0.singleTeam_[arg_6_1][iter_6_0] = var_6_0
	end

	arg_6_0.heroTrialList_[arg_6_1] = arg_6_3
end

function var_0_0.GetSingleTeam(arg_7_0, arg_7_1)
	return clone(arg_7_0.singleTeam_[arg_7_1] or {
		0,
		0,
		0
	}), clone(arg_7_0.heroTrialList_[arg_7_1] or {
		0,
		0,
		0
	})
end

function var_0_0.SetStageTeam(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.stageTeam_[arg_8_1] = arg_8_2
	arg_8_0.stageTeamTrial_[arg_8_1] = arg_8_3
end

function var_0_0.GetStageTeam(arg_9_0, arg_9_1)
	return clone(arg_9_0.stageTeam_[arg_9_1]), clone(arg_9_0.stageTeamTrial_[arg_9_1])
end

function var_0_0.UpdateHeroTrial(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.hero_trial_list) do
		arg_10_0.trialActivityData_[iter_10_1.activity_id] = {}

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.template_hero_list) do
			table.insert(arg_10_0.trialActivityData_[iter_10_1.activity_id], iter_10_3)
		end
	end
end

function var_0_0.GetHeroTrial(arg_11_0, arg_11_1)
	return arg_11_0.trialActivityData_[arg_11_1]
end

return var_0_0
