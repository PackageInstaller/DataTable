local var_0_0 = class("SelectHeroBaseProxy")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or {}
	arg_1_2 = arg_1_2 or {}

	arg_1_0:Init(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:InitBaseParams(arg_2_1)
	arg_2_0:InitReserveParams(arg_2_2, arg_2_3)
	arg_2_0:InitUIParams(arg_2_1)
	arg_2_0:InitHeroTeamInfoViewParams(arg_2_1)
	arg_2_0:InitCustomParams(arg_2_1)
	arg_2_0:GetHeroTeam()
end

function var_0_0.InitBaseParams(arg_3_0, arg_3_1)
	arg_3_0.stageID = arg_3_1.section or 0
	arg_3_0.stageType = arg_3_1.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_3_0.activityID = arg_3_1.activityID
	arg_3_0.multiple = arg_3_1.multiple or 1
end

function var_0_0.InitReserveParams(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.reserveParams = arg_4_1 or ReserveTools.GetReserveParams(arg_4_0.stageType, arg_4_0.stageID, arg_4_0.activityID)
	arg_4_0.heroDataType = arg_4_2 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_4_0.heroViewProxy = HeroViewDataProxy.New(arg_4_0.heroDataType)
	arg_4_0.heroViewProxyDic = {}
	arg_4_0.heroViewProxyDic[arg_4_0.heroDataType] = arg_4_0.heroViewProxy
	arg_4_0.heroPosMaxCount = 3
	arg_4_0.heroInfoList = {}
	arg_4_0.lockHeroList = {}
	arg_4_0.comboSkillID = 0
	arg_4_0.mimirID = 0
	arg_4_0.chipList = {}
end

function var_0_0.InitUIParams(arg_5_0, arg_5_1)
	arg_5_0.isEnter = false
	arg_5_0.barList = arg_5_1.customBarList or {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}
	arg_5_0.canHeroDrag = true
	arg_5_0.canChangeTeam = true
	arg_5_0.needDisplayFilterLocalHero = true
	arg_5_0.needHeroPower = true
	arg_5_0.needRacePanel = true
	arg_5_0.forceRace = -1
	arg_5_0.needComboSkillPanel = true
	arg_5_0.canChangeComboSkill = true
	arg_5_0.needMimirPanel = true
	arg_5_0.canChangeMimir = true
	arg_5_0.needReserveProposalPanel = true
	arg_5_0.canChangeReserveProposal = true
	arg_5_0.needHeroHP = false
	arg_5_0.needHeroAssistant = false
	arg_5_0.needHeroEnergy = false
	arg_5_0.forceChangePos = false

	arg_5_0:CheckComboSkill()
	arg_5_0:CheckMimirInfo()
end

function var_0_0.InitHeroTeamInfoViewParams(arg_6_0, arg_6_1)
	arg_6_0.needReorderTeam = true
	arg_6_0.needHideInfoBtn = false
	arg_6_0.canCleanTeam = false
	arg_6_0.canUseOwnHero = true
	arg_6_0.canUseMultiMode = SectionSelectHeroTools.CanUseMultiMode(arg_6_0.stageType, arg_6_0.stageID)
end

function var_0_0.InitCustomParams(arg_7_0, arg_7_1)
	return
end

function var_0_0.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar(arg_8_0.barList)
	manager.windowBar:RegistBackCallBack(function()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		gameContext:Back()
	end)
end

function var_0_0.OnSectionSelectEnter(arg_10_0)
	return
end

function var_0_0.OnSectionSelectExit(arg_11_0)
	return
end

function var_0_0.CustomCheckBeforeGotoHeroInfoUI(arg_12_0, arg_12_1)
	local var_12_0 = true
	local var_12_1 = ""

	return var_12_0, var_12_1
end

function var_0_0.GetHeroTeamInfoRoute(arg_13_0)
	return "/newHeroTeamInfo"
end

function var_0_0.GetCustomeTeamInfoParams(arg_14_0, arg_14_1)
	return {}
end

function var_0_0.GetHeroReserveProposalRoute(arg_15_0)
	return "/reservesUI"
end

function var_0_0.GetCustomeReserveProposalParams(arg_16_0)
	return {}
end

function var_0_0.CustomCheckBeforeBattle(arg_17_0)
	local var_17_0 = true
	local var_17_1 = ""

	return var_17_0, var_17_1
end

function var_0_0.GetStageData(arg_18_0)
	return BattleStageFactory.Produce(arg_18_0.stageType, arg_18_0.stageID, arg_18_0.activityID)
end

function var_0_0.LaunchBattle(arg_19_0, arg_19_1)
	BattleController.GetInstance():LaunchBattle(arg_19_1)
end

function var_0_0.CustomSaveTeam(arg_20_0)
	if ReserveTools.NeedCacheTeam(arg_20_0.stageType, arg_20_0.stageID) then
		local var_20_0 = arg_20_0:GetHeroIDList()
		local var_20_1 = arg_20_0:GetTrialIDList()

		ReserveTools.SetTeam(arg_20_0.reserveParams, var_20_0, var_20_1, arg_20_0.comboSkillID, arg_20_0.mimirID, arg_20_0.chipList, arg_20_0:GetCharChipBaseID())
	end
end

function var_0_0.CustomResetTeam(arg_21_0)
	ReserveAction.ResetContData(arg_21_0.reserveParams.reserveType, arg_21_0.reserveParams.contID, function()
		for iter_22_0 = 1, arg_21_0.heroPosMaxCount do
			arg_21_0.heroInfoList[iter_22_0]:SetData(0, 0, false)
		end

		arg_21_0.lockHeroList = {}
		arg_21_0.comboSkillID = 0
		arg_21_0.mimirID = 0
		arg_21_0.chipList = {}
	end)
end

function var_0_0.CustomGetTeamData(arg_23_0)
	local var_23_0, var_23_1, var_23_2, var_23_3 = ReserveTools.GetHeroList(arg_23_0.reserveParams)

	return var_23_0, var_23_1, var_23_2, var_23_3
end

function var_0_0.CustomChangeHeroTeam(arg_24_0, arg_24_1, arg_24_2)
	ReserveTools.SetHeroList(arg_24_0.reserveParams, arg_24_1, arg_24_2)
end

function var_0_0.CustomApplyRroposalHeroTeam(arg_25_0, arg_25_1, arg_25_2)
	ReserveTools.SetHeroList(arg_25_0.reserveParams, arg_25_1, arg_25_2)
end

function var_0_0.CustomRefreshHeroInfoList(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	return
end

function var_0_0.CustomGetSkinCfg(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	return arg_27_0.heroInfoList[arg_27_1].heroViewProxy:GetHeroBattleUsingSkinInfo(arg_27_2, {
		arg_27_3
	})
end

function var_0_0.CustomGetHeroPower(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	return arg_28_0.heroInfoList[arg_28_1].heroViewProxy:GetBattlePower(arg_28_2, arg_28_3)
end

function var_0_0.CustomGetHeroHP(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = 1
	local var_29_1 = 100

	return var_29_0, var_29_1
end

function var_0_0.CustomGetHeroEnergy(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	return 0
end

function var_0_0.CustomHeroBindRedPoint(arg_31_0, arg_31_1, arg_31_2)
	return
end

function var_0_0.CustomHeroUnBindRedPoint(arg_32_0, arg_32_1, arg_32_2)
	return
end

function var_0_0.CustomCheckComboSkill(arg_33_0)
	return
end

function var_0_0.CustomGetComboSkillID(arg_34_0)
	return ReserveTools.GetComboSkillID(arg_34_0.reserveParams)
end

function var_0_0.CustomSetComboSkillID(arg_35_0, arg_35_1)
	ReserveTools.SetComboSkillID(arg_35_0.reserveParams, arg_35_1)
end

function var_0_0.CustomMimirID(arg_36_0)
	return ReserveTools.GetMimirID(arg_36_0.reserveParams)
end

function var_0_0.CustomSetMimirID(arg_37_0, arg_37_1)
	ReserveTools.SetMimirID(arg_37_0.reserveParams, arg_37_1)
end

function var_0_0.CustomGetMimirChipList(arg_38_0)
	return ReserveTools.GetMimirChipList(arg_38_0.reserveParams)
end

function var_0_0.CustomInsertMimirChip(arg_39_0, arg_39_1)
	ReserveTools.InsertMimirChip(arg_39_0.reserveParams, arg_39_1)
end

function var_0_0.CustomRemoveMimirChip(arg_40_0, arg_40_1)
	ReserveTools.RemoveMimirChip(arg_40_0.reserveParams, arg_40_1)
end

function var_0_0.CustomSetMimirChipList(arg_41_0, arg_41_1)
	ReserveTools.SetMimirChipList(arg_41_0.reserveParams, arg_41_1)
end

function var_0_0.GetRaceEffect(arg_42_0)
	local var_42_0 = arg_42_0:GetHeroIDList()

	return BattleTools.GetMaxRaceData(var_42_0)
end

function var_0_0.GetStageInfoClass(arg_43_0)
	return SectionStageInfoView
end

function var_0_0.GetSelectHeroViewClass(arg_44_0)
	return SelectHeroBaseView
end

function var_0_0.GetHeroInfoItemClass(arg_45_0)
	return SectionSelectHeroInfoItem
end

function var_0_0.GetAdditionalViewClass(arg_46_0)
	return SectionAdditionalView
end

function var_0_0.GetMimirInfoViewClass(arg_47_0)
	return NewSectionMimirView
end

function var_0_0.GetComboSkillViewClass(arg_48_0)
	return NewSectionComboSkillView
end

function var_0_0.GetSectionSelectHeroInfoClass(arg_49_0)
	return SectionSelectHeroInfo
end

function var_0_0.GetHeroVoiceInfoViewClass(arg_50_0)
	return SectionHeroVoiceInfoView
end

function var_0_0.GotoHeroInfoUI(arg_51_0, arg_51_1)
	local var_51_0, var_51_1 = arg_51_0:CheckBeforeGotoHeroInfoUI(arg_51_1)

	if not var_51_0 then
		if var_51_1 then
			ShowTips(var_51_1)
		end

		return
	end

	local var_51_2 = arg_51_0:GetDefaultTeamInfoParams(arg_51_1)
	local var_51_3 = arg_51_0:GetCustomeTeamInfoParams(arg_51_1)

	for iter_51_0, iter_51_1 in pairs(var_51_3) do
		var_51_2[iter_51_0] = iter_51_1
	end

	JumpTools.OpenPageByJump(arg_51_0:GetHeroTeamInfoRoute(), var_51_2)
end

function var_0_0.CheckBeforeGotoHeroInfoUI(arg_52_0, arg_52_1)
	if not arg_52_0.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if arg_52_0.stageID and arg_52_0.stageID ~= 0 then
		local var_52_0, var_52_1 = BattleStageTools.GetRestrictHeroList(arg_52_0.stageType, arg_52_0.stageID)

		if type(var_52_0) == "table" then
			local var_52_2 = var_52_0[arg_52_1]

			if var_52_2[1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[var_52_2[1]] and HeroTools.IsNPC(var_52_2[1]) and (type(var_52_1) ~= "table" or var_52_1[arg_52_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end
	end

	return arg_52_0:CustomCheckBeforeGotoHeroInfoUI(arg_52_1)
end

function var_0_0.GetDefaultTeamInfoParams(arg_53_0, arg_53_1)
	return {
		isEnter = true,
		selectHeroPos = arg_53_1,
		stageID = arg_53_0.stageID,
		activityID = arg_53_0.activityID,
		stageType = arg_53_0.stageType,
		reserveParams = arg_53_0.reserveParams,
		heroDataType = arg_53_0.heroDataType,
		sectionProxy = arg_53_0,
		reorder = arg_53_0.needReorderTeam,
		hideInfoBtn = arg_53_0.needHideInfoBtn,
		canCleanTeam = arg_53_0.canCleanTeam,
		canUseOwnHero = arg_53_0.canUseOwnHero,
		canUseMultiMode = arg_53_0.canUseMultiMode
	}
end

function var_0_0.GotoReservesProposalUI(arg_54_0)
	local var_54_0 = arg_54_0:GetDefaultReserveProposalParams()
	local var_54_1 = arg_54_0:GetCustomeReserveProposalParams()

	for iter_54_0, iter_54_1 in pairs(var_54_1) do
		var_54_0[iter_54_0] = iter_54_1
	end

	JumpTools.OpenPageByJump(arg_54_0:GetHeroReserveProposalRoute(), var_54_0)
end

function var_0_0.GetDefaultReserveProposalParams(arg_55_0)
	local var_55_0 = arg_55_0:GetHeroIDList()
	local var_55_1 = arg_55_0:GetTrialIDList()

	return {
		isEnter = true,
		stageType = arg_55_0.stageType,
		stageID = arg_55_0.stageID,
		sectionProxy = arg_55_0,
		heroList = var_55_0,
		trialList = var_55_1,
		lockHeroList = arg_55_0.lockHeroList,
		comboSkillID = arg_55_0.comboSkillID,
		mimirID = arg_55_0.mimirID,
		chipList = arg_55_0.chipList,
		charChipBaseID = arg_55_0:GetCharChipBaseID()
	}
end

function var_0_0.CheckBeforeBattle(arg_56_0)
	if arg_56_0.heroInfoList[1].heroID == 0 then
		return false, "TEAM_ERROR_LEADER"
	end

	local var_56_0, var_56_1 = BattleStageTools.GetRestrictHeroList(arg_56_0.stageType, arg_56_0.stageID)

	if type(var_56_1) == "table" and var_56_1[arg_56_0.heroPosMaxCount] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		for iter_56_0 = 2, arg_56_0.heroPosMaxCount - 1 do
			if arg_56_0.heroInfoList[iter_56_0].heroID == 0 then
				return false, "TEAM_ERROR_NEED_MAX"
			end
		end
	end

	return arg_56_0:CustomCheckBeforeBattle()
end

function var_0_0.StartBattle(arg_57_0)
	local var_57_0, var_57_1 = arg_57_0:CheckBeforeBattle()

	if not var_57_0 then
		if var_57_1 then
			ShowTips(var_57_1)
		end

		return
	end

	arg_57_0:SaveTeam()

	local var_57_2 = arg_57_0:GetStageData()

	var_57_2:SetMultiple(arg_57_0.multiple)
	var_57_2:SetReserveParams(arg_57_0.reserveParams)
	var_57_2:Init()
	arg_57_0:LaunchBattle(var_57_2)
end

function var_0_0.SetReserveParams(arg_58_0, arg_58_1)
	arg_58_0.reserveParams = arg_58_1
end

function var_0_0.GetReserveParams(arg_59_0)
	return arg_59_0.reserveParams
end

function var_0_0.SaveTeam(arg_60_0)
	arg_60_0:CustomSaveTeam()
end

function var_0_0.ResetTeam(arg_61_0)
	arg_61_0:CustomResetTeam()
end

function var_0_0.GetHeroTeam(arg_62_0)
	local var_62_0, var_62_1, var_62_2, var_62_3 = arg_62_0:CustomGetTeamData()

	arg_62_0:RefreshHeroInfoList(var_62_0, var_62_3, var_62_1, var_62_2)

	local var_62_4 = {}

	for iter_62_0, iter_62_1 in ipairs(var_62_3) do
		if iter_62_1 ~= 0 then
			var_62_4[#var_62_4 + 1] = iter_62_1
		end
	end

	for iter_62_2, iter_62_3 in ipairs(arg_62_0.heroViewProxyDic) do
		iter_62_3:SetTempHeroList(var_62_4)
	end

	return var_62_0, var_62_1, var_62_2, var_62_3
end

function var_0_0.GetHeroIDList(arg_63_0)
	local var_63_0 = {}

	for iter_63_0 = 1, arg_63_0.heroPosMaxCount do
		var_63_0[iter_63_0] = arg_63_0.heroInfoList[iter_63_0].heroID
	end

	return var_63_0
end

function var_0_0.GetTrialIDList(arg_64_0)
	local var_64_0 = {}

	for iter_64_0 = 1, arg_64_0.heroPosMaxCount do
		var_64_0[iter_64_0] = arg_64_0.heroInfoList[iter_64_0].trialID
	end

	return var_64_0
end

function var_0_0.GetLockStateList(arg_65_0)
	local var_65_0 = {}

	for iter_65_0 = 1, arg_65_0.heroPosMaxCount do
		var_65_0[iter_65_0] = arg_65_0.heroInfoList[iter_65_0].isPosLock
	end

	return var_65_0
end

function var_0_0.GetLockHeroList(arg_66_0)
	return arg_66_0.lockHeroList
end

function var_0_0.ChangeHeroTeam(arg_67_0, arg_67_1, arg_67_2)
	arg_67_2 = arg_67_2 or {
		0,
		0,
		0
	}

	arg_67_0:CustomChangeHeroTeam(arg_67_1, arg_67_2)

	local var_67_0 = arg_67_0:GetLockStateList()

	arg_67_0:RefreshHeroInfoList(arg_67_1, arg_67_2, var_67_0, arg_67_0.lockHeroList)
end

function var_0_0.ApplyReserveProposal(arg_68_0, arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5, arg_68_6)
	arg_68_0:ApplyRroposalHeroTeam(arg_68_1, arg_68_2)
	arg_68_0:SetComboSkillID(arg_68_3)
	arg_68_0:SetMimirID(arg_68_4)
	arg_68_0:SetMimirChipList(arg_68_5)
	arg_68_0:SetCharChipBaseID(arg_68_6)
end

function var_0_0.ApplyRroposalHeroTeam(arg_69_0, arg_69_1, arg_69_2)
	arg_69_0:CustomApplyRroposalHeroTeam(arg_69_1, arg_69_2)

	local var_69_0 = arg_69_0:GetLockStateList()

	arg_69_0:RefreshHeroInfoList(arg_69_1, arg_69_2, var_69_0, arg_69_0.lockHeroList)
end

function var_0_0.RefreshHeroInfoList(arg_70_0, arg_70_1, arg_70_2, arg_70_3, arg_70_4)
	for iter_70_0 = 1, arg_70_0.heroPosMaxCount do
		if not arg_70_0.heroInfoList[iter_70_0] then
			arg_70_0.heroInfoList[iter_70_0] = arg_70_0:GetSectionSelectHeroInfoClass().New()
		end

		local var_70_0 = arg_70_1[iter_70_0] or 0
		local var_70_1 = arg_70_2[iter_70_0] or 0
		local var_70_2
		local var_70_3

		if var_70_1 ~= 0 then
			var_70_2 = HeroConst.HERO_DATA_TYPE.TRIAL
		else
			var_70_2 = arg_70_0.heroDataType
		end

		local var_70_4 = arg_70_0:GreateHeroViewProxy(var_70_2)
		local var_70_5 = arg_70_3[iter_70_0]
		local var_70_6 = table.indexof(arg_70_4, var_70_0) ~= false or table.indexof(arg_70_4, var_70_1) ~= false

		arg_70_0.heroInfoList[iter_70_0]:SetData(var_70_0, var_70_1, var_70_5, var_70_6)
		arg_70_0.heroInfoList[iter_70_0]:SetHeroDataType(var_70_2, var_70_4)
	end

	local var_70_7 = {}

	for iter_70_1, iter_70_2 in ipairs(arg_70_2) do
		if iter_70_2 ~= 0 then
			var_70_7[#var_70_7 + 1] = iter_70_2
		end
	end

	for iter_70_3, iter_70_4 in pairs(arg_70_0.heroViewProxyDic) do
		iter_70_4:SetTempHeroList(var_70_7)
	end

	arg_70_0.lockHeroList = arg_70_4

	arg_70_0:CustomRefreshHeroInfoList(arg_70_1, arg_70_2, arg_70_3, arg_70_4)
	manager.notify:Invoke(SECTION_CHANGE_HERO_TEAM, arg_70_1, arg_70_2)
end

function var_0_0.GetAddedHeroIDList(arg_71_0)
	return ReserveTools.GetAddedHeroIDList(arg_71_0.reserveParams)
end

function var_0_0.SetHeroDataType(arg_72_0, arg_72_1)
	arg_72_0.heroDataType = arg_72_1

	arg_72_0:GreateHeroViewProxy(arg_72_1)
end

function var_0_0.GreateHeroViewProxy(arg_73_0, arg_73_1)
	if not arg_73_0.heroViewProxyDic[arg_73_1] then
		arg_73_0.heroViewProxyDic[arg_73_1] = HeroViewDataProxy.New(arg_73_1)
	end

	return arg_73_0.heroViewProxyDic[arg_73_1]
end

function var_0_0.GetHeroViewProxy(arg_74_0)
	return arg_74_0:GreateHeroViewProxy(arg_74_0.heroDataType)
end

function var_0_0.CheckComboSkill(arg_75_0)
	if arg_75_0.stageID and arg_75_0.stageID ~= 0 then
		local var_75_0 = BattleStageTools.GetStageCfg(arg_75_0.stageType, arg_75_0.stageID)

		if var_75_0 and var_75_0.combo_skill_id and var_75_0.combo_skill_id ~= 0 then
			arg_75_0.customComboSkill = var_75_0.combo_skill_id
			arg_75_0.needComboSkillPanel = true
			arg_75_0.canChangeComboSkill = true

			return
		end

		if SectionSelectHeroTools.IsAllPosFullLock(arg_75_0.stageType, arg_75_0.stageID) then
			arg_75_0.needComboSkillPanel = false
			arg_75_0.canChangeComboSkill = false
		end
	end

	arg_75_0:CustomCheckComboSkill()
end

function var_0_0.GetComboSkillID(arg_76_0)
	arg_76_0.comboSkillID = arg_76_0:CustomGetComboSkillID()

	return arg_76_0.comboSkillID
end

function var_0_0.SetComboSkillID(arg_77_0, arg_77_1)
	arg_77_0.comboSkillID = arg_77_1

	arg_77_0:CustomSetComboSkillID(arg_77_1)
end

function var_0_0.CheckMimirInfo(arg_78_0)
	if arg_78_0.stageID and arg_78_0.stageID ~= 0 then
		local var_78_0 = BattleStageTools.GetStageCfg(arg_78_0.stageType, arg_78_0.stageID)

		if var_78_0 and type(var_78_0.chip_list) == "table" then
			arg_78_0.canChangeMimir = false
		end
	end
end

function var_0_0.GetMimirID(arg_79_0)
	local var_79_0
	local var_79_1, var_79_2, var_79_3, var_79_4, var_79_5 = BattleStageTools.GetStageFixedChipInfo(arg_79_0.stageType, arg_79_0.stageID)

	if var_79_1 then
		var_79_0 = var_79_2
		arg_79_0.chipList = var_79_3
	else
		var_79_0 = arg_79_0:CustomMimirID()
	end

	arg_79_0.mimirID = var_79_0

	return arg_79_0.mimirID
end

function var_0_0.SetMimirID(arg_80_0, arg_80_1)
	arg_80_0.mimirID = arg_80_1

	arg_80_0:CustomSetMimirID(arg_80_1)
end

function var_0_0.GetMimirChipList(arg_81_0)
	local var_81_0, var_81_1, var_81_2, var_81_3, var_81_4 = BattleStageTools.GetStageFixedChipInfo(arg_81_0.stageType, arg_81_0.stageID)

	if var_81_0 then
		-- block empty
	else
		var_81_2 = arg_81_0:CustomGetMimirChipList()
	end

	arg_81_0.chipList = var_81_2

	return arg_81_0.chipList
end

function var_0_0.GetMimirData(arg_82_0)
	local var_82_0 = arg_82_0:GetMimirID()
	local var_82_1 = arg_82_0:GetMimirChipList()

	return var_82_0, var_82_1
end

function var_0_0.InsertMimirChip(arg_83_0, arg_83_1)
	arg_83_0:CustomInsertMimirChip(arg_83_1)
	arg_83_0:GetMimirChipList()
end

function var_0_0.RemoveMimirChip(arg_84_0, arg_84_1)
	arg_84_0:CustomRemoveMimirChip(arg_84_1)
	arg_84_0:GetMimirChipList()
end

function var_0_0.SetMimirChipList(arg_85_0, arg_85_1)
	arg_85_0:CustomSetMimirChipList(arg_85_1)
	arg_85_0:GetMimirChipList()
end

function var_0_0.GetCharChipBaseID(arg_86_0)
	local var_86_0, var_86_1, var_86_2, var_86_3, var_86_4 = BattleStageTools.GetStageFixedChipInfo(arg_86_0.stageType, arg_86_0.stageID)

	if var_86_0 then
		return var_86_3
	end

	return ReserveTools.GetCharChipBaseID(arg_86_0.reserveParams)
end

function var_0_0.SetCharChipBaseID(arg_87_0, arg_87_1)
	ReserveTools.SetCharChipBaseID(arg_87_0.reserveParams, arg_87_1)
end

function var_0_0.GetCharChipExtraIDList(arg_88_0)
	local var_88_0, var_88_1, var_88_2, var_88_3, var_88_4 = BattleStageTools.GetStageFixedChipInfo(arg_88_0.stageType, arg_88_0.stageID)

	if var_88_0 then
		return var_88_4
	end

	return ReserveTools.GetCharChipExtraIDList(arg_88_0.reserveParams)
end

function var_0_0.IsCharChipBaseUnlock(arg_89_0, arg_89_1)
	return ChipTools.IsCharChipBaseUnlock(arg_89_1)
end

function var_0_0.GetCharChipExtraIDListUnlock(arg_90_0, arg_90_1)
	return ChipTools.GetCharChipExtraIDListUnlock(arg_90_1)
end

function var_0_0.IsCharChipBaseCanUnlock(arg_91_0, arg_91_1)
	return ChipTools.IsCharChipBaseCanUnlock(arg_91_1)
end

function var_0_0.IsCharChipExtraCanUnlock(arg_92_0, arg_92_1)
	return ChipTools.IsCharChipExtraCanUnlock(arg_92_1)
end

function var_0_0.IsCharChipExtraUnlock(arg_93_0, arg_93_1)
	return ChipTools.IsCharChipExtraUnlock(arg_93_1)
end

function var_0_0.IsCharChipCanOperate(arg_94_0, arg_94_1)
	return true
end

function var_0_0.IsUseMimirChip(arg_95_0)
	return arg_95_0:GetMimirID() ~= 0
end

function var_0_0.IsUseCharChip(arg_96_0)
	return arg_96_0:GetCharChipBaseID() ~= 0
end

return var_0_0
