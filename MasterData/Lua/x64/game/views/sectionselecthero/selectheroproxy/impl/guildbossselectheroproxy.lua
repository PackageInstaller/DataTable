local GuildBossSelectHeroProxy = class("GuildBossSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function GuildBossSelectHeroProxy:InitCustomParams(arg_1_1)
	self.dest = arg_1_1.dest
	self.needHeroAssistant = true
	self.canUseMultiMode = false
end

function GuildBossSelectHeroProxy:CustomRefreshHeroInfoList(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.reserveHeroInfoList = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS):GetCurHeroInfoList()

	for iter_2_0 = 1, #self.heroInfoList do
		if self.reserveHeroInfoList[iter_2_0] then
			if self.reserveHeroInfoList[iter_2_0].type == 2 then
				self.heroInfoList[iter_2_0]:SetAssistantInfo(true, self.reserveHeroInfoList[iter_2_0].info)
			else
				self.heroInfoList[iter_2_0]:SetAssistantInfo(false)
			end
		end
	end
end

function GuildBossSelectHeroProxy:CustomChangeHeroTeam(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		for iter_3_2, iter_3_3 in ipairs(self.reserveHeroInfoList) do
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

	self.reserveHeroInfoList = var_3_1

	self:GuildBossChangeHeroTeam(self.reserveHeroInfoList)
end

function GuildBossSelectHeroProxy:CustomApplyRroposalHeroTeam(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		var_4_0[iter_4_0] = {
			type = 1,
			heroId = iter_4_1
		}
	end

	self.reserveHeroInfoList = var_4_0

	self:GuildBossChangeHeroTeam(self.reserveHeroInfoList)
end

function GuildBossSelectHeroProxy:CustomSaveTeam()
	self:GuildBossChangeHeroTeam(self.reserveHeroInfoList)
end

function GuildBossSelectHeroProxy:GuildBossChangeHeroTeam(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = 1

	for iter_6_0 = 1, 3 do
		if arg_6_1[iter_6_0] then
			if arg_6_1[iter_6_0].type == 1 then
				var_6_0[var_6_2] = arg_6_1[iter_6_0].heroId
			elseif arg_6_1[iter_6_0].type == 2 then
				var_6_0[var_6_2] = arg_6_1[iter_6_0].info.assist_hero_id
				var_6_1[var_6_2] = arg_6_1[iter_6_0].info.member_id
			end

			var_6_2 = var_6_2 + 1
		end
	end

	local var_6_3 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	var_6_3:SetHeroList(self.reserveParams, var_6_0, {
		0,
		0,
		0
	})
	var_6_3:SetOwnerID(var_6_1)
end

function GuildBossSelectHeroProxy:CustomGetSkinCfg(arg_7_1, arg_7_2, arg_7_3)
	if self.reserveHeroInfoList[arg_7_1] and self.reserveHeroInfoList[arg_7_1].type == 2 then
		return SkinCfg[(self.reserveHeroInfoList[arg_7_1].info.assist_hero_skin == 0 or nil) and self.reserveHeroInfoList[arg_7_1].info.assist_hero_id]
	end

	return HeroData:GetHeroBattleUsingSkinInfo(self.reserveHeroInfoList[arg_7_1].heroId)
end

function GuildBossSelectHeroProxy:CustomGetHeroPower(arg_8_1, arg_8_2, arg_8_3)
	if self.reserveHeroInfoList[arg_8_1] and self.reserveHeroInfoList[arg_8_1].type == 2 then
		return self.reserveHeroInfoList[arg_8_1].info.fight_capacity
	end

	return getHeroPower(self.reserveHeroInfoList[arg_8_1].heroId, false)
end

function GuildBossSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/guildBossTeamInfo"
end

function GuildBossSelectHeroProxy:GetCustomeTeamInfoParams(arg_10_1)
	return {
		heroList = self.reserveHeroInfoList
	}
end

function GuildBossSelectHeroProxy:GetCustomeReserveProposalParams()
	local var_11_0 = self:GetHeroIDList()

	for iter_11_0, iter_11_1 in ipairs(self.reserveHeroInfoList) do
		local var_11_1

		if iter_11_1.type == 1 then
			var_11_0[1] = var_11_0[iter_11_0]

			if 1 ~= iter_11_0 then
				var_11_0[iter_11_0] = 0
			end

			var_11_1 = 1 + 1
		elseif iter_11_1.type == 2 then
			var_11_0[iter_11_0] = 0
		end
	end

	return {
		heroList = var_11_0
	}
end

function GuildBossSelectHeroProxy:GetStageData()
	local var_12_0 = BattleStageFactory.Produce(self.stageType, self.stageID, 1, self.reserveParams)
	local var_12_1 = {}
	local var_12_2 = {}

	self.assistList = {}
	self.assistOwnerList = {}

	for iter_12_0, iter_12_1 in ipairs(self.reserveHeroInfoList) do
		if iter_12_1.type == 2 then
			table.insert(var_12_1, iter_12_1.info.assist_hero_id)
			table.insert(var_12_2, iter_12_1.info.member_id)
			table.insert(self.assistList, iter_12_1.info.assist_hero_id)
			table.insert(self.assistOwnerList, iter_12_1.info.member_id)
		else
			table.insert(var_12_1, iter_12_1.heroId)
			table.insert(var_12_2, "0")
		end
	end

	var_12_0:SetReserveParams(self.reserveParams)
	var_12_0:SetGuildBossTeam(var_12_1, var_12_2)
	var_12_0:SetMultiple(self.multiple)
	var_12_0:SetDest(self.dest)

	return var_12_0
end

function GuildBossSelectHeroProxy:LaunchBattle(arg_13_1)
	local var_13_0 = 0

	if #self.assistList > 0 then
		for iter_13_0, iter_13_1 in ipairs(self.assistList) do
			ForeignInfoAction:TryToCheckForeignHeroInfo(self.assistOwnerList[iter_13_0], iter_13_1, 2, function()
				var_13_0 = var_13_0 + 1

				if var_13_0 >= #self.assistList then
					local var_14_0 = {}

					for iter_14_0, iter_14_1 in ipairs(self.assistList) do
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

return GuildBossSelectHeroProxy
