local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("GuildBossSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.dest = arg_1_1.dest
	arg_1_0.needHeroAssistant = true
	arg_1_0.canUseMultiMode = false
end

function var_0_1.CustomRefreshHeroInfoList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.reserveHeroInfoList = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS):GetCurHeroInfoList()

	for iter_2_0 = 1, #arg_2_0.heroInfoList do
		if arg_2_0.reserveHeroInfoList[iter_2_0] then
			if arg_2_0.reserveHeroInfoList[iter_2_0].type == 2 then
				arg_2_0.heroInfoList[iter_2_0]:SetAssistantInfo(true, arg_2_0.reserveHeroInfoList[iter_2_0].info)
			else
				arg_2_0.heroInfoList[iter_2_0]:SetAssistantInfo(false)
			end
		end
	end
end

function var_0_1.CustomChangeHeroTeam(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		for iter_3_2, iter_3_3 in ipairs(arg_3_0.reserveHeroInfoList) do
			if iter_3_3.type == 2 and iter_3_3.info.assist_hero_id == iter_3_1 then
				var_3_0[iter_3_1] = iter_3_3
			elseif iter_3_3.type == 1 and iter_3_3.heroId == iter_3_1 then
				var_3_0[iter_3_1] = iter_3_3
			end
		end
	end

	local var_3_1 = {}

	for iter_3_4, iter_3_5 in pairs(arg_3_1) do
		var_3_1[iter_3_4] = var_3_0[iter_3_5]
	end

	arg_3_0.reserveHeroInfoList = var_3_1

	arg_3_0:GuildBossChangeHeroTeam(arg_3_0.reserveHeroInfoList)
end

function var_0_1.CustomApplyRroposalHeroTeam(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		var_4_0[iter_4_0] = {
			type = 1,
			heroId = iter_4_1
		}
	end

	arg_4_0.reserveHeroInfoList = var_4_0

	arg_4_0:GuildBossChangeHeroTeam(arg_4_0.reserveHeroInfoList)
end

function var_0_1.CustomSaveTeam(arg_5_0)
	arg_5_0:GuildBossChangeHeroTeam(arg_5_0.reserveHeroInfoList)
end

function var_0_1.GuildBossChangeHeroTeam(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {
		0,
		0,
		0
	}
	local var_6_2 = {}
	local var_6_3 = 1

	for iter_6_0 = 1, 3 do
		if arg_6_1[iter_6_0] then
			local var_6_4 = arg_6_1[iter_6_0]

			if var_6_4.type == 1 then
				var_6_0[var_6_3] = var_6_4.heroId
			elseif var_6_4.type == 2 then
				var_6_0[var_6_3] = var_6_4.info.assist_hero_id
				var_6_2[var_6_3] = var_6_4.info.member_id
			end

			var_6_3 = var_6_3 + 1
		end
	end

	local var_6_5 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	var_6_5:SetHeroList(arg_6_0.reserveParams, var_6_0, var_6_1)
	var_6_5:SetOwnerID(var_6_2)
end

function var_0_1.CustomGetSkinCfg(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0.reserveHeroInfoList[arg_7_1] and arg_7_0.reserveHeroInfoList[arg_7_1].type == 2 then
		local var_7_0 = arg_7_0.reserveHeroInfoList[arg_7_1].info.assist_hero_skin

		if var_7_0 == 0 then
			var_7_0 = arg_7_0.reserveHeroInfoList[arg_7_1].info.assist_hero_id
		end

		return SkinCfg[var_7_0]
	end

	return HeroData:GetHeroBattleUsingSkinInfo(arg_7_0.reserveHeroInfoList[arg_7_1].heroId)
end

function var_0_1.CustomGetHeroPower(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.reserveHeroInfoList[arg_8_1] and arg_8_0.reserveHeroInfoList[arg_8_1].type == 2 then
		return arg_8_0.reserveHeroInfoList[arg_8_1].info.fight_capacity
	end

	return getHeroPower(arg_8_0.reserveHeroInfoList[arg_8_1].heroId, false)
end

function var_0_1.GetHeroTeamInfoRoute(arg_9_0)
	return "/guildBossTeamInfo"
end

function var_0_1.GetCustomeTeamInfoParams(arg_10_0, arg_10_1)
	return {
		heroList = arg_10_0.reserveHeroInfoList
	}
end

function var_0_1.GetCustomeReserveProposalParams(arg_11_0)
	local var_11_0 = arg_11_0:GetHeroIDList()
	local var_11_1 = 1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.reserveHeroInfoList) do
		if iter_11_1.type == 1 then
			var_11_0[var_11_1] = var_11_0[iter_11_0]

			if var_11_1 ~= iter_11_0 then
				var_11_0[iter_11_0] = 0
			end

			var_11_1 = var_11_1 + 1
		elseif iter_11_1.type == 2 then
			var_11_0[iter_11_0] = 0
		end
	end

	return {
		heroList = var_11_0
	}
end

function var_0_1.GetStageData(arg_12_0)
	local var_12_0 = BattleStageFactory.Produce(arg_12_0.stageType, arg_12_0.stageID, 1, arg_12_0.reserveParams)
	local var_12_1 = {}
	local var_12_2 = {}

	arg_12_0.assistList = {}
	arg_12_0.assistOwnerList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.reserveHeroInfoList) do
		if iter_12_1.type == 2 then
			table.insert(var_12_1, iter_12_1.info.assist_hero_id)
			table.insert(var_12_2, iter_12_1.info.member_id)
			table.insert(arg_12_0.assistList, iter_12_1.info.assist_hero_id)
			table.insert(arg_12_0.assistOwnerList, iter_12_1.info.member_id)
		else
			table.insert(var_12_1, iter_12_1.heroId)
			table.insert(var_12_2, "0")
		end
	end

	var_12_0:SetReserveParams(arg_12_0.reserveParams)
	var_12_0:SetGuildBossTeam(var_12_1, var_12_2)
	var_12_0:SetMultiple(arg_12_0.multiple)
	var_12_0:SetDest(arg_12_0.dest)

	return var_12_0
end

function var_0_1.LaunchBattle(arg_13_0, arg_13_1)
	local var_13_0 = 0

	if #arg_13_0.assistList > 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.assistList) do
			ForeignInfoAction:TryToCheckForeignHeroInfo(arg_13_0.assistOwnerList[iter_13_0], iter_13_1, 2, function()
				var_13_0 = var_13_0 + 1

				if var_13_0 >= #arg_13_0.assistList then
					local var_14_0 = {}

					for iter_14_0, iter_14_1 in ipairs(arg_13_0.assistList) do
						local var_14_1 = ForeignInfoData:GetHeroData(iter_14_1)
						local var_14_2 = {}

						if var_14_1.using_hero_chip then
							for iter_14_2, iter_14_3 in ipairs(var_14_1.using_hero_chip) do
								if iter_14_3 > 0 then
									table.insert(var_14_2, iter_14_3)
								end
							end
						end

						var_14_0[iter_14_1] = var_14_2
					end

					arg_13_1:SetChipDic(var_14_0)
					arg_13_1:InitChipData()
					BattleController.GetInstance():LaunchBattle(arg_13_1)
				end
			end)
		end
	else
		arg_13_1:InitChipData()
		BattleController.GetInstance():LaunchBattle(arg_13_1)
	end
end

return var_0_1
