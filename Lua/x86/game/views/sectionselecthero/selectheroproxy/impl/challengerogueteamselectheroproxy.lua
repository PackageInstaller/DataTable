local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ChallengeRogueTeamSelectHeroProxy", var_0_0)

function var_0_1.GetHeroTeamInfoRoute(arg_1_0)
	return "/challengeRogueTeamTeamInfo"
end

function var_0_1.InitCustomParams(arg_2_0, arg_2_1)
	arg_2_0.nodeID = arg_2_1.nodeID
	arg_2_0.needMimirPanel = false
	arg_2_0.canChangeMimir = false
	arg_2_0.needHeroHP = true

	local var_2_0 = ChallengeRogueTeamData:HeroGetLockState()

	arg_2_0.needReserveProposalPanel = not var_2_0
	arg_2_0.canChangeReserveProposal = not var_2_0

	local var_2_1, var_2_2, var_2_3, var_2_4 = ReserveTools.GetHeroList(arg_2_0.reserveParams)

	arg_2_0.uiCacheHeroIDList = var_2_1
	arg_2_0.uiCacheTrialIDList = var_2_4
	arg_2_0.canUseMultiMode = true
	arg_2_0.demonHeroIDList = {
		0,
		0,
		0
	}
	arg_2_0.demonTrailHeroIDList = {
		0,
		0,
		0
	}
	arg_2_0.isDemonFirstIn = true
end

function var_0_1.CustomGetHeroHP(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = math.ceil((ChallengeRogueTeamData:GetHeroData(arg_3_2, nil, true).hpPercent or 10000) / 100)
	local var_3_1 = arg_3_0:GetHeroViewProxy():GetHeroAllAttribute(arg_3_2)

	return math.ceil(var_3_1[HeroConst.HERO_ATTRIBUTE.STA] * var_3_0 / 10000), var_3_0
end

function var_0_1.GreateHeroViewProxy(arg_4_0, arg_4_1)
	if not arg_4_0.heroViewProxyDic[arg_4_1] then
		arg_4_0.heroViewProxyDic[arg_4_1] = HeroViewDataProxy.New(arg_4_1)
	end

	if arg_4_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_4_0.heroViewProxyDic[arg_4_1].isChallengeRogue = true
	end

	return arg_4_0.heroViewProxyDic[arg_4_1]
end

function var_0_1.GetStageData(arg_5_0)
	return BattleStageFactory.Produce(arg_5_0.stageType, arg_5_0.stageID, arg_5_0.nodeID, arg_5_0.reserveParams)
end

function var_0_1.GetSelectHeroViewClass(arg_6_0)
	return ChallengeRogueTeamSelectHeroView
end

function var_0_1.CustomChangeHeroTeam(arg_7_0, arg_7_1, arg_7_2)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		arg_7_0.demonHeroIDList = arg_7_1
		arg_7_0.demonTrailHeroIDList = arg_7_2
	else
		arg_7_0.uiCacheHeroIDList = arg_7_1
		arg_7_0.uiCacheTrialIDList = arg_7_2
	end
end

function var_0_1.CustomGetTeamData(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3 = ReserveTools.GetHeroList(arg_8_0.reserveParams)

	var_8_1 = ChallengeRogueTeamTools.IsDemonBattle() and {
		false,
		true,
		true
	} or var_8_1

	return arg_8_0:GetUiCatchHeroIDList(), var_8_1, var_8_2, arg_8_0:GetUiCatchTrailHeroIDList()
end

function var_0_1.GetUiCatchHeroIDList(arg_9_0)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		if arg_9_0.isDemonFirstIn then
			arg_9_0.isDemonFirstIn = false

			return {
				0,
				0,
				0
			}
		else
			return arg_9_0.demonHeroIDList
		end
	else
		return arg_9_0.uiCacheHeroIDList
	end
end

function var_0_1.GetUiCatchTrailHeroIDList(arg_10_0)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		if arg_10_0.isDemonFirstIn then
			arg_10_0.isDemonFirstIn = false

			return {
				0,
				0,
				0
			}
		else
			return arg_10_0.demonTrailHeroIDList
		end
	else
		return arg_10_0.uiCacheTrialIDList
	end
end

function var_0_1.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
end

function var_0_1.CustomRefreshHeroInfoList(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		arg_12_0.demonHeroIDList = arg_12_1 or {
			0,
			0,
			0
		}
		arg_12_0.demonTrailHeroIDList = arg_12_2 or {
			0,
			0,
			0
		}
	else
		arg_12_0.uiCacheHeroIDList = arg_12_1 or {
			0,
			0,
			0
		}
		arg_12_0.uiCacheTrialIDList = arg_12_2 or {
			0,
			0,
			0
		}
	end
end

function var_0_1.CustomGetComboSkillID(arg_13_0)
	local var_13_0 = ReserveTools.CheckReserveParams(arg_13_0.reserveParams)

	return ReserveTools.GetReserveTemplateByReserveType(var_13_0.reserveType):GetComboSkillID(var_13_0, arg_13_0:GetUiCatchHeroIDList())
end

function var_0_1.GetHeroIDList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:GetUiCatchHeroIDList()

	for iter_14_0 = 1, arg_14_0.heroPosMaxCount do
		var_14_0[iter_14_0] = var_14_1[iter_14_0]
	end

	return var_14_0
end

function var_0_1.GetTrialIDList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0:GetUiCatchTrailHeroIDList()

	for iter_15_0 = 1, arg_15_0.heroPosMaxCount do
		var_15_0[iter_15_0] = var_15_1[iter_15_0]
	end

	return var_15_0
end

function var_0_1.GetAdditionalViewClass(arg_16_0)
	return ChallengRogueTeamAdditionalView
end

return var_0_1
