local ChallengeRogueTeamSelectHeroProxy = class("ChallengeRogueTeamSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ChallengeRogueTeamSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/challengeRogueTeamTeamInfo"
end

function ChallengeRogueTeamSelectHeroProxy:InitCustomParams(arg_2_1)
	self.nodeID = arg_2_1.nodeID
	self.needMimirPanel = false
	self.canChangeMimir = false
	self.needHeroHP = true

	local var_2_0 = ChallengeRogueTeamData:HeroGetLockState()

	self.needReserveProposalPanel = not var_2_0
	self.canChangeReserveProposal = not var_2_0

	local var_2_1, var_2_2, var_2_3, var_2_4 = ReserveTools.GetHeroList(self.reserveParams)

	self.uiCacheHeroIDList = var_2_1
	self.uiCacheTrialIDList = var_2_4
	self.canUseMultiMode = true
	self.demonHeroIDList = {
		0,
		0,
		0
	}
	self.demonTrailHeroIDList = {
		0,
		0,
		0
	}
	self.isDemonFirstIn = true
end

function ChallengeRogueTeamSelectHeroProxy:CustomGetHeroHP(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = math.ceil((ChallengeRogueTeamData:GetHeroData(arg_3_2, nil, true).hpPercent or 10000) / 100)

	return math.ceil(self:GetHeroViewProxy():GetHeroAllAttribute(arg_3_2)[HeroConst.HERO_ATTRIBUTE.STA] * var_3_0 / 10000), var_3_0
end

function ChallengeRogueTeamSelectHeroProxy:GreateHeroViewProxy(arg_4_1)
	self.heroViewProxyDic[arg_4_1] = self.heroViewProxyDic[arg_4_1] or HeroViewDataProxy.New(arg_4_1)

	if arg_4_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		self.heroViewProxyDic[arg_4_1].isChallengeRogue = true
	end

	return self.heroViewProxyDic[arg_4_1]
end

function ChallengeRogueTeamSelectHeroProxy:GetStageData()
	return BattleStageFactory.Produce(self.stageType, self.stageID, self.nodeID, self.reserveParams)
end

function ChallengeRogueTeamSelectHeroProxy:GetSelectHeroViewClass()
	return ChallengeRogueTeamSelectHeroView
end

function ChallengeRogueTeamSelectHeroProxy:CustomChangeHeroTeam(arg_7_1, arg_7_2)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		self.demonHeroIDList = arg_7_1
		self.demonTrailHeroIDList = arg_7_2
	else
		self.uiCacheHeroIDList = arg_7_1
		self.uiCacheTrialIDList = arg_7_2
	end
end

function ChallengeRogueTeamSelectHeroProxy:CustomGetTeamData()
	local var_8_0, var_8_1, var_8_2, var_8_3 = ReserveTools.GetHeroList(self.reserveParams)

	var_8_1 = ChallengeRogueTeamTools.IsDemonBattle() and {
		false,
		true,
		true
	} or var_8_1

	return self:GetUiCatchHeroIDList(), var_8_1, var_8_2, self:GetUiCatchTrailHeroIDList()
end

function ChallengeRogueTeamSelectHeroProxy:GetUiCatchHeroIDList()
	if ChallengeRogueTeamTools.IsDemonBattle() then
		if self.isDemonFirstIn then
			self.isDemonFirstIn = false

			return {
				0,
				0,
				0
			}
		else
			return self.demonHeroIDList
		end
	else
		return self.uiCacheHeroIDList
	end
end

function ChallengeRogueTeamSelectHeroProxy:GetUiCatchTrailHeroIDList()
	if ChallengeRogueTeamTools.IsDemonBattle() then
		if self.isDemonFirstIn then
			self.isDemonFirstIn = false

			return {
				0,
				0,
				0
			}
		else
			return self.demonTrailHeroIDList
		end
	else
		return self.uiCacheTrialIDList
	end
end

function ChallengeRogueTeamSelectHeroProxy:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
end

function ChallengeRogueTeamSelectHeroProxy:CustomRefreshHeroInfoList(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if ChallengeRogueTeamTools.IsDemonBattle() then
		self.demonHeroIDList = arg_12_1 or {
			0,
			0,
			0
		}
		self.demonTrailHeroIDList = arg_12_2 or {
			0,
			0,
			0
		}
	else
		self.uiCacheHeroIDList = arg_12_1 or {
			0,
			0,
			0
		}
		self.uiCacheTrialIDList = arg_12_2 or {
			0,
			0,
			0
		}
	end
end

function ChallengeRogueTeamSelectHeroProxy:CustomGetComboSkillID()
	local var_13_0 = ReserveTools.CheckReserveParams(self.reserveParams)

	return ReserveTools.GetReserveTemplateByReserveType(var_13_0.reserveType):GetComboSkillID(var_13_0, self:GetUiCatchHeroIDList())
end

function ChallengeRogueTeamSelectHeroProxy:GetHeroIDList()
	local var_14_0 = {}
	local var_14_1 = self:GetUiCatchHeroIDList()

	for iter_14_0 = 1, self.heroPosMaxCount do
		var_14_0[iter_14_0] = var_14_1[iter_14_0]
	end

	return var_14_0
end

function ChallengeRogueTeamSelectHeroProxy:GetTrialIDList()
	local var_15_0 = {}
	local var_15_1 = self:GetUiCatchTrailHeroIDList()

	for iter_15_0 = 1, self.heroPosMaxCount do
		var_15_0[iter_15_0] = var_15_1[iter_15_0]
	end

	return var_15_0
end

function ChallengeRogueTeamSelectHeroProxy:GetAdditionalViewClass()
	return ChallengRogueTeamAdditionalView
end

return ChallengeRogueTeamSelectHeroProxy
