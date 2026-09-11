local var_0_0 = singletonClass("GuildBossTeamData")

function var_0_0.Init(arg_1_0)
	arg_1_0.singleTeam_ = {}
	arg_1_0.heroTrialList_ = {}
	arg_1_0.stageTeam_ = {}
	arg_1_0.stageTeamTrial_ = {}
	arg_1_0.serverTeam_ = {}
	arg_1_0.trialActivityData_ = {}
end

function var_0_0:InitTeam(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.singleTeam_[iter_2_1.type] = {}
		self.heroTrialList_[iter_2_1.type] = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.hero_list) do
			if iter_2_3.hero_type == 1 or iter_2_3.hero_id == 0 then
				self.singleTeam_[iter_2_1.type][iter_2_2] = iter_2_3.hero_id
				self.heroTrialList_[iter_2_1.type][iter_2_2] = 0
			else
				self.singleTeam_[iter_2_1.type][iter_2_2] = HeroStandardSystemCfg[iter_2_3.hero_id].hero_id
				self.heroTrialList_[iter_2_1.type][iter_2_2] = iter_2_3.hero_id
			end
		end

		for iter_2_4 = 1, 3 do
			self.singleTeam_[iter_2_1.type][iter_2_4] = self.singleTeam_[iter_2_1.type][iter_2_4] or 0
			self.heroTrialList_[iter_2_1.type][iter_2_4] = self.heroTrialList_[iter_2_1.type][iter_2_4] or 0
		end
	end
end

function var_0_0.UpdateRoomData(arg_3_0, arg_3_1)
	arg_3_0.roomID_ = arg_3_1.room_id

	local var_3_0 = {}

	for iter_3_0 = 1, 3 do
		if arg_3_1.player_list[iter_3_0] then
			local var_3_1 = {}

			for iter_3_1, iter_3_2 in ipairs(arg_3_1.player_list[iter_3_0].hero_list) do
				local var_3_2 = iter_3_2.hero_id
				local var_3_3 = 0

				if iter_3_2.hero_type == 2 then
					var_3_2 = HeroStandardSystemCfg[var_3_2].hero_id
					var_3_3 = iter_3_2.hero_id
				end

				local var_3_4 = {
					id = var_3_2,
					trialID = var_3_3,
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

				var_3_4.servantInfo = iter_3_2.weapon_info.servant and {
					id = iter_3_2.weapon_info.servant.id,
					stage = iter_3_2.weapon_info.servant.stage
				} or {}

				if iter_3_2.equip_list then
					for iter_3_3, iter_3_4 in ipairs(iter_3_2.equip_list) do
						local var_3_5 = {}

						if iter_3_4.enchant_slot_list then
							for iter_3_5, iter_3_6 in ipairs(iter_3_4.enchant_slot_list) do
								local var_3_7 = {}

								for iter_3_7, iter_3_8 in ipairs(iter_3_6.effect_list) do
									table.insert(var_3_7, {
										id = iter_3_8.id,
										num = iter_3_8.level
									})
								end

								if #var_3_7 > 0 then
									var_3_5[iter_3_5] = var_3_7
								end
							end
						end

						local var_3_8 = {
							equip_id = iter_3_4.equip_id,
							prefab_id = iter_3_4.prefab_id,
							exp = iter_3_4.exp
						}

						var_3_8.now_break_level = iter_3_4.now_break_level or 0
						var_3_8.enchant = var_3_5
						var_3_8.race = iter_3_4.race
						var_3_4.equip_list[iter_3_3] = var_3_8
					end
				end

				if iter_3_2.astrolabe_list then
					for iter_3_9, iter_3_10 in ipairs(iter_3_2.astrolabe_list) do
						var_3_4.using_astrolabe[iter_3_9] = iter_3_10
					end
				end

				if iter_3_2.skill then
					for iter_3_11, iter_3_12 in ipairs(iter_3_2.skill) do
						var_3_4.skill[iter_3_11] = {
							skill_id = iter_3_12.skill_id,
							skill_level = iter_3_12.skill_level
						}
					end
				end

				table.insert(var_3_1, var_3_4)
			end

			var_3_0[iter_3_0] = {
				playerID = arg_3_1.player_list[iter_3_0].player_id,
				nick = arg_3_1.player_list[iter_3_0].nick,
				level = arg_3_1.player_list[iter_3_0].level,
				channel = arg_3_1.player_list[iter_3_0].channel,
				server = arg_3_1.player_list[iter_3_0].server,
				is_ready = arg_3_1.player_list[iter_3_0].is_ready,
				is_master = arg_3_1.player_list[iter_3_0].is_master,
				heroList = var_3_1
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

function var_0_0:GetRoomID()
	return self.roomID_
end

function var_0_0:GetServerTeam()
	return self.serverTeam_
end

function var_0_0:SetSingleTeam(arg_6_1, arg_6_2, arg_6_3)
	self.singleTeam_[arg_6_1] = {}

	for iter_6_0 = 1, 3 do
		self.singleTeam_[arg_6_1][iter_6_0] = arg_6_2[iter_6_0] or 0
	end

	self.heroTrialList_[arg_6_1] = arg_6_3
end

function var_0_0:GetSingleTeam(arg_7_1)
	return clone(self.singleTeam_[arg_7_1] or {
		0,
		0,
		0
	}), clone(self.heroTrialList_[arg_7_1] or {
		0,
		0,
		0
	})
end

function var_0_0:SetStageTeam(arg_8_1, arg_8_2, arg_8_3)
	self.stageTeam_[arg_8_1] = arg_8_2
	self.stageTeamTrial_[arg_8_1] = arg_8_3
end

function var_0_0:GetStageTeam(arg_9_1)
	return clone(self.stageTeam_[arg_9_1]), clone(self.stageTeamTrial_[arg_9_1])
end

function var_0_0:UpdateHeroTrial(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.hero_trial_list) do
		self.trialActivityData_[iter_10_1.activity_id] = {}

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.template_hero_list) do
			table.insert(self.trialActivityData_[iter_10_1.activity_id], iter_10_3)
		end
	end
end

function var_0_0:GetHeroTrial(arg_11_1)
	return self.trialActivityData_[arg_11_1]
end

return var_0_0
