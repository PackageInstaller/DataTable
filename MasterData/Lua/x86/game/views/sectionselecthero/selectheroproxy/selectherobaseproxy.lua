local SelectHeroBaseProxy = class("SelectHeroBaseProxy")

function SelectHeroBaseProxy:Ctor(arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or {}
	arg_1_2 = arg_1_2 or {}

	self:Init(arg_1_1, arg_1_2, arg_1_3)
end

function SelectHeroBaseProxy:Init(arg_2_1, arg_2_2, arg_2_3)
	self:InitBaseParams(arg_2_1)
	self:InitReserveParams(arg_2_2, arg_2_3)
	self:InitUIParams(arg_2_1)
	self:InitHeroTeamInfoViewParams(arg_2_1)
	self:InitCustomParams(arg_2_1)
	self:GetHeroTeam()
end

function SelectHeroBaseProxy:InitBaseParams(arg_3_1)
	self.stageID = arg_3_1.section or 0
	self.stageType = arg_3_1.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.activityID = arg_3_1.activityID
	self.multiple = arg_3_1.multiple or 1
end

function SelectHeroBaseProxy:InitReserveParams(arg_4_1, arg_4_2)
	self.reserveParams = arg_4_1 or ReserveTools.GetReserveParams(self.stageType, self.stageID, self.activityID)
	self.heroDataType = arg_4_2 or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy = HeroViewDataProxy.New(self.heroDataType)
	self.heroViewProxyDic = {}
	self.heroViewProxyDic[self.heroDataType] = self.heroViewProxy
	self.heroPosMaxCount = 3
	self.heroInfoList = {}
	self.lockHeroList = {}
	self.comboSkillID = 0
	self.mimirID = 0
	self.chipList = {}
end

function SelectHeroBaseProxy:InitUIParams(arg_5_1)
	self.isEnter = false
	self.barList = arg_5_1.customBarList or {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}
	self.canHeroDrag = true
	self.canChangeTeam = true
	self.needDisplayFilterLocalHero = true
	self.needHeroPower = true
	self.needRacePanel = true
	self.forceRace = -1
	self.needComboSkillPanel = true
	self.canChangeComboSkill = true
	self.needMimirPanel = true
	self.canChangeMimir = true
	self.needReserveProposalPanel = true
	self.canChangeReserveProposal = true
	self.needHeroHP = false
	self.needHeroAssistant = false
	self.needHeroEnergy = false
	self.forceChangePos = false

	self:CheckComboSkill()
	self:CheckMimirInfo()
end

function SelectHeroBaseProxy:InitHeroTeamInfoViewParams(arg_6_1)
	self.needReorderTeam = true
	self.needHideInfoBtn = false
	self.canCleanTeam = false
	self.canUseOwnHero = true
	self.canUseMultiMode = SectionSelectHeroTools.CanUseMultiMode(self.stageType, self.stageID)
end

function SelectHeroBaseProxy:InitCustomParams(arg_7_1)
	return
end

function SelectHeroBaseProxy:UpdateBar()
	manager.windowBar:SwitchBar(self.barList)
	manager.windowBar:RegistBackCallBack(function()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		gameContext:Back()
	end)
end

function SelectHeroBaseProxy:OnSectionSelectEnter()
	return
end

function SelectHeroBaseProxy:OnSectionSelectExit()
	return
end

function SelectHeroBaseProxy:CustomCheckBeforeGotoHeroInfoUI(arg_12_1)
	return true, ""
end

function SelectHeroBaseProxy:GetHeroTeamInfoRoute()
	return "/newHeroTeamInfo"
end

function SelectHeroBaseProxy:GetCustomeTeamInfoParams(arg_14_1)
	return {}
end

function SelectHeroBaseProxy:GetHeroReserveProposalRoute()
	return "/reservesUI"
end

function SelectHeroBaseProxy:GetCustomeReserveProposalParams()
	return {}
end

function SelectHeroBaseProxy:CustomCheckBeforeBattle()
	return true, ""
end

function SelectHeroBaseProxy:GetStageData()
	return BattleStageFactory.Produce(self.stageType, self.stageID, self.activityID)
end

function SelectHeroBaseProxy:LaunchBattle(arg_19_1)
	BattleController.GetInstance():LaunchBattle(arg_19_1)
end

function SelectHeroBaseProxy:CustomSaveTeam()
	if ReserveTools.NeedCacheTeam(self.stageType, self.stageID) then
		ReserveTools.SetTeam(self.reserveParams, self:GetHeroIDList(), self:GetTrialIDList(), self.comboSkillID, self.mimirID, self.chipList, self:GetCharChipBaseID())
	end
end

function SelectHeroBaseProxy:CustomResetTeam()
	ReserveAction.ResetContData(self.reserveParams.reserveType, self.reserveParams.contID, function()
		for iter_22_0 = 1, self.heroPosMaxCount do
			self.heroInfoList[iter_22_0]:SetData(0, 0, false)
		end

		self.lockHeroList = {}
		self.comboSkillID = 0
		self.mimirID = 0
		self.chipList = {}
	end)
end

function SelectHeroBaseProxy:CustomGetTeamData()
	local var_23_0, var_23_1, var_23_2, var_23_3 = ReserveTools.GetHeroList(self.reserveParams)

	return var_23_0, var_23_1, var_23_2, var_23_3
end

function SelectHeroBaseProxy:CustomChangeHeroTeam(arg_24_1, arg_24_2)
	ReserveTools.SetHeroList(self.reserveParams, arg_24_1, arg_24_2)
end

function SelectHeroBaseProxy:CustomApplyRroposalHeroTeam(arg_25_1, arg_25_2)
	ReserveTools.SetHeroList(self.reserveParams, arg_25_1, arg_25_2)
end

function SelectHeroBaseProxy:CustomRefreshHeroInfoList(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	return
end

function SelectHeroBaseProxy:CustomGetSkinCfg(arg_27_1, arg_27_2, arg_27_3)
	return self.heroInfoList[arg_27_1].heroViewProxy:GetHeroBattleUsingSkinInfo(arg_27_2, {
		arg_27_3
	})
end

function SelectHeroBaseProxy:CustomGetHeroPower(arg_28_1, arg_28_2, arg_28_3)
	return self.heroInfoList[arg_28_1].heroViewProxy:GetBattlePower(arg_28_2, arg_28_3)
end

function SelectHeroBaseProxy:CustomGetHeroHP(arg_29_1, arg_29_2, arg_29_3)
	return 1, 100
end

function SelectHeroBaseProxy:CustomGetHeroEnergy(arg_30_1, arg_30_2, arg_30_3)
	return 0
end

function SelectHeroBaseProxy:CustomHeroBindRedPoint(arg_31_1, arg_31_2)
	return
end

function SelectHeroBaseProxy:CustomHeroUnBindRedPoint(arg_32_1, arg_32_2)
	return
end

function SelectHeroBaseProxy:CustomCheckComboSkill()
	return
end

function SelectHeroBaseProxy:CustomGetComboSkillID()
	return ReserveTools.GetComboSkillID(self.reserveParams)
end

function SelectHeroBaseProxy:CustomSetComboSkillID(arg_35_1)
	ReserveTools.SetComboSkillID(self.reserveParams, arg_35_1)
end

function SelectHeroBaseProxy:CustomMimirID()
	return ReserveTools.GetMimirID(self.reserveParams)
end

function SelectHeroBaseProxy:CustomSetMimirID(arg_37_1)
	ReserveTools.SetMimirID(self.reserveParams, arg_37_1)
end

function SelectHeroBaseProxy:CustomGetMimirChipList()
	return ReserveTools.GetMimirChipList(self.reserveParams)
end

function SelectHeroBaseProxy:CustomInsertMimirChip(arg_39_1)
	ReserveTools.InsertMimirChip(self.reserveParams, arg_39_1)
end

function SelectHeroBaseProxy:CustomRemoveMimirChip(arg_40_1)
	ReserveTools.RemoveMimirChip(self.reserveParams, arg_40_1)
end

function SelectHeroBaseProxy:CustomSetMimirChipList(arg_41_1)
	ReserveTools.SetMimirChipList(self.reserveParams, arg_41_1)
end

function SelectHeroBaseProxy:GetRaceEffect()
	return BattleTools.GetMaxRaceData((self:GetHeroIDList()))
end

function SelectHeroBaseProxy:GetStageInfoClass()
	return SectionStageInfoView
end

function SelectHeroBaseProxy:GetSelectHeroViewClass()
	return SelectHeroBaseView
end

function SelectHeroBaseProxy:GetHeroInfoItemClass()
	return SectionSelectHeroInfoItem
end

function SelectHeroBaseProxy:GetAdditionalViewClass()
	return SectionAdditionalView
end

function SelectHeroBaseProxy:GetMimirInfoViewClass()
	return NewSectionMimirView
end

function SelectHeroBaseProxy:GetComboSkillViewClass()
	return NewSectionComboSkillView
end

function SelectHeroBaseProxy:GetSectionSelectHeroInfoClass()
	return SectionSelectHeroInfo
end

function SelectHeroBaseProxy:GetHeroVoiceInfoViewClass()
	return SectionHeroVoiceInfoView
end

function SelectHeroBaseProxy:GotoHeroInfoUI(arg_51_1)
	local var_51_0, var_51_1 = self:CheckBeforeGotoHeroInfoUI(arg_51_1)

	if not var_51_0 then
		if var_51_1 then
			ShowTips(var_51_1)
		end

		return
	end

	local var_51_2 = self:GetDefaultTeamInfoParams(arg_51_1)

	for iter_51_0, iter_51_1 in pairs((self:GetCustomeTeamInfoParams(arg_51_1))) do
		var_51_2[iter_51_0] = iter_51_1
	end

	JumpTools.OpenPageByJump(self:GetHeroTeamInfoRoute(), var_51_2)
end

function SelectHeroBaseProxy:CheckBeforeGotoHeroInfoUI(arg_52_1)
	if not self.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if self.stageID and self.stageID ~= 0 then
		local var_52_0, var_52_1 = BattleStageTools.GetRestrictHeroList(self.stageType, self.stageID)

		if type(var_52_0) == "table" then
			if var_52_0[arg_52_1][1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[var_52_0[arg_52_1][1]] and HeroTools.IsNPC(var_52_0[arg_52_1][1]) and (type(var_52_1) ~= "table" or var_52_1[arg_52_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end
	end

	return self:CustomCheckBeforeGotoHeroInfoUI(arg_52_1)
end

function SelectHeroBaseProxy:GetDefaultTeamInfoParams(arg_53_1)
	return {
		isEnter = true,
		selectHeroPos = arg_53_1,
		stageID = self.stageID,
		activityID = self.activityID,
		stageType = self.stageType,
		reserveParams = self.reserveParams,
		heroDataType = self.heroDataType,
		sectionProxy = self,
		reorder = self.needReorderTeam,
		hideInfoBtn = self.needHideInfoBtn,
		canCleanTeam = self.canCleanTeam,
		canUseOwnHero = self.canUseOwnHero,
		canUseMultiMode = self.canUseMultiMode
	}
end

function SelectHeroBaseProxy:GotoReservesProposalUI()
	local var_54_0 = self:GetDefaultReserveProposalParams()

	for iter_54_0, iter_54_1 in pairs((self:GetCustomeReserveProposalParams())) do
		var_54_0[iter_54_0] = iter_54_1
	end

	JumpTools.OpenPageByJump(self:GetHeroReserveProposalRoute(), var_54_0)
end

function SelectHeroBaseProxy:GetDefaultReserveProposalParams()
	return {
		isEnter = true,
		stageType = self.stageType,
		stageID = self.stageID,
		sectionProxy = self,
		heroList = self:GetHeroIDList(),
		trialList = self:GetTrialIDList(),
		lockHeroList = self.lockHeroList,
		comboSkillID = self.comboSkillID,
		mimirID = self.mimirID,
		chipList = self.chipList,
		charChipBaseID = self:GetCharChipBaseID()
	}
end

function SelectHeroBaseProxy:CheckBeforeBattle()
	if self.heroInfoList[1].heroID == 0 then
		return false, "TEAM_ERROR_LEADER"
	end

	local var_56_0, var_56_1 = BattleStageTools.GetRestrictHeroList(self.stageType, self.stageID)

	if type(var_56_1) == "table" and var_56_1[self.heroPosMaxCount] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
		for iter_56_0 = 2, self.heroPosMaxCount - 1 do
			if self.heroInfoList[iter_56_0].heroID == 0 then
				return false, "TEAM_ERROR_NEED_MAX"
			end
		end
	end

	return self:CustomCheckBeforeBattle()
end

function SelectHeroBaseProxy:StartBattle()
	local var_57_0, var_57_1 = self:CheckBeforeBattle()

	if not var_57_0 then
		if var_57_1 then
			ShowTips(var_57_1)
		end

		return
	end

	self:SaveTeam()

	local var_57_2 = self:GetStageData()

	var_57_2:SetMultiple(self.multiple)
	var_57_2:SetReserveParams(self.reserveParams)
	var_57_2:Init()
	self:LaunchBattle(var_57_2)
end

function SelectHeroBaseProxy:SetReserveParams(arg_58_1)
	self.reserveParams = arg_58_1
end

function SelectHeroBaseProxy:GetReserveParams()
	return self.reserveParams
end

function SelectHeroBaseProxy:SaveTeam()
	self:CustomSaveTeam()
end

function SelectHeroBaseProxy:ResetTeam()
	self:CustomResetTeam()
end

function SelectHeroBaseProxy:GetHeroTeam()
	local var_62_0, var_62_1, var_62_2, var_62_3 = self:CustomGetTeamData()

	self:RefreshHeroInfoList(var_62_0, var_62_3, var_62_1, var_62_2)

	local var_62_4 = {}

	for iter_62_0, iter_62_1 in ipairs(var_62_3) do
		if iter_62_1 ~= 0 then
			var_62_4[#var_62_4 + 1] = iter_62_1
		end
	end

	for iter_62_2, iter_62_3 in ipairs(self.heroViewProxyDic) do
		iter_62_3:SetTempHeroList(var_62_4)
	end

	return var_62_0, var_62_1, var_62_2, var_62_3
end

function SelectHeroBaseProxy:GetHeroIDList()
	local var_63_0 = {}

	for iter_63_0 = 1, self.heroPosMaxCount do
		var_63_0[iter_63_0] = self.heroInfoList[iter_63_0].heroID
	end

	return var_63_0
end

function SelectHeroBaseProxy:GetTrialIDList()
	local var_64_0 = {}

	for iter_64_0 = 1, self.heroPosMaxCount do
		var_64_0[iter_64_0] = self.heroInfoList[iter_64_0].trialID
	end

	return var_64_0
end

function SelectHeroBaseProxy:GetLockStateList()
	local var_65_0 = {}

	for iter_65_0 = 1, self.heroPosMaxCount do
		var_65_0[iter_65_0] = self.heroInfoList[iter_65_0].isPosLock
	end

	return var_65_0
end

function SelectHeroBaseProxy:GetLockHeroList()
	return self.lockHeroList
end

function SelectHeroBaseProxy:ChangeHeroTeam(arg_67_1, arg_67_2)
	arg_67_2 = arg_67_2 or {
		0,
		0,
		0
	}

	self:CustomChangeHeroTeam(arg_67_1, arg_67_2)
	self:RefreshHeroInfoList(arg_67_1, arg_67_2, self:GetLockStateList(), self.lockHeroList)
end

function SelectHeroBaseProxy:ApplyReserveProposal(arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5, arg_68_6)
	self:ApplyRroposalHeroTeam(arg_68_1, arg_68_2)
	self:SetComboSkillID(arg_68_3)
	self:SetMimirID(arg_68_4)
	self:SetMimirChipList(arg_68_5)
	self:SetCharChipBaseID(arg_68_6)
end

function SelectHeroBaseProxy:ApplyRroposalHeroTeam(arg_69_1, arg_69_2)
	self:CustomApplyRroposalHeroTeam(arg_69_1, arg_69_2)
	self:RefreshHeroInfoList(arg_69_1, arg_69_2, self:GetLockStateList(), self.lockHeroList)
end

function SelectHeroBaseProxy:RefreshHeroInfoList(arg_70_1, arg_70_2, arg_70_3, arg_70_4)
	for iter_70_0 = 1, self.heroPosMaxCount do
		self.heroInfoList[iter_70_0] = self.heroInfoList[iter_70_0] or self:GetSectionSelectHeroInfoClass().New()

		local var_70_0 = arg_70_1[iter_70_0] or 0
		local var_70_1 = arg_70_2[iter_70_0] or 0
		local var_70_2 = var_70_1 ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or self.heroDataType
		local var_70_3 = self:GreateHeroViewProxy(var_70_2)

		self.heroInfoList[iter_70_0]:SetData(var_70_0, var_70_1, arg_70_3[iter_70_0], table.indexof(arg_70_4, var_70_0) ~= false or table.indexof(arg_70_4, var_70_1) ~= false)
		self.heroInfoList[iter_70_0]:SetHeroDataType(var_70_2, nil)
	end

	local var_70_4 = {}

	for iter_70_1, iter_70_2 in ipairs(arg_70_2) do
		if iter_70_2 ~= 0 then
			var_70_4[#var_70_4 + 1] = iter_70_2
		end
	end

	for iter_70_3, iter_70_4 in pairs(self.heroViewProxyDic) do
		iter_70_4:SetTempHeroList(var_70_4)
	end

	self.lockHeroList = arg_70_4

	self:CustomRefreshHeroInfoList(arg_70_1, arg_70_2, arg_70_3, arg_70_4)
	manager.notify:Invoke(SECTION_CHANGE_HERO_TEAM, arg_70_1, arg_70_2)
end

function SelectHeroBaseProxy:GetAddedHeroIDList()
	return ReserveTools.GetAddedHeroIDList(self.reserveParams)
end

function SelectHeroBaseProxy:SetHeroDataType(arg_72_1)
	self.heroDataType = arg_72_1

	self:GreateHeroViewProxy(arg_72_1)
end

function SelectHeroBaseProxy:GreateHeroViewProxy(arg_73_1)
	self.heroViewProxyDic[arg_73_1] = self.heroViewProxyDic[arg_73_1] or HeroViewDataProxy.New(arg_73_1)

	return self.heroViewProxyDic[arg_73_1]
end

function SelectHeroBaseProxy:GetHeroViewProxy()
	return self:GreateHeroViewProxy(self.heroDataType)
end

function SelectHeroBaseProxy:CheckComboSkill()
	if self.stageID and self.stageID ~= 0 then
		local var_75_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageID)

		if var_75_0 and var_75_0.combo_skill_id and var_75_0.combo_skill_id ~= 0 then
			self.customComboSkill = var_75_0.combo_skill_id
			self.needComboSkillPanel = true
			self.canChangeComboSkill = true

			return
		end

		if SectionSelectHeroTools.IsAllPosFullLock(self.stageType, self.stageID) then
			self.needComboSkillPanel = false
			self.canChangeComboSkill = false
		end
	end

	self:CustomCheckComboSkill()
end

function SelectHeroBaseProxy:GetComboSkillID()
	self.comboSkillID = self:CustomGetComboSkillID()

	return self.comboSkillID
end

function SelectHeroBaseProxy:SetComboSkillID(arg_77_1)
	self.comboSkillID = arg_77_1

	self:CustomSetComboSkillID(arg_77_1)
end

function SelectHeroBaseProxy:CheckMimirInfo()
	if self.stageID and self.stageID ~= 0 then
		local var_78_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageID)

		if var_78_0 and type(var_78_0.chip_list) == "table" then
			self.canChangeMimir = false
		end
	end
end

function SelectHeroBaseProxy:GetMimirID()
	local var_79_0
	local var_79_1, var_79_2, var_79_3, var_79_4, var_79_5 = BattleStageTools.GetStageFixedChipInfo(self.stageType, self.stageID)

	if var_79_1 then
		var_79_0 = var_79_2
		self.chipList = var_79_3
	else
		var_79_0 = self:CustomMimirID()
	end

	self.mimirID = var_79_0

	return self.mimirID
end

function SelectHeroBaseProxy:SetMimirID(arg_80_1)
	self.mimirID = arg_80_1

	self:CustomSetMimirID(arg_80_1)
end

function SelectHeroBaseProxy:GetMimirChipList()
	local var_81_0, var_81_1, var_81_2, var_81_3, var_81_4 = BattleStageTools.GetStageFixedChipInfo(self.stageType, self.stageID)

	if var_81_0 then
		-- block empty
	else
		var_81_2 = self:CustomGetMimirChipList()
	end

	self.chipList = var_81_2

	return self.chipList
end

function SelectHeroBaseProxy:GetMimirData()
	return self:GetMimirID(), (self:GetMimirChipList())
end

function SelectHeroBaseProxy:InsertMimirChip(arg_83_1)
	self:CustomInsertMimirChip(arg_83_1)
	self:GetMimirChipList()
end

function SelectHeroBaseProxy:RemoveMimirChip(arg_84_1)
	self:CustomRemoveMimirChip(arg_84_1)
	self:GetMimirChipList()
end

function SelectHeroBaseProxy:SetMimirChipList(arg_85_1)
	self:CustomSetMimirChipList(arg_85_1)
	self:GetMimirChipList()
end

function SelectHeroBaseProxy:GetCharChipBaseID()
	local var_86_0, var_86_1, var_86_2, var_86_3, var_86_4 = BattleStageTools.GetStageFixedChipInfo(self.stageType, self.stageID)

	if var_86_0 then
		return var_86_3
	end

	return ReserveTools.GetCharChipBaseID(self.reserveParams)
end

function SelectHeroBaseProxy:SetCharChipBaseID(arg_87_1)
	ReserveTools.SetCharChipBaseID(self.reserveParams, arg_87_1)
end

function SelectHeroBaseProxy:GetCharChipExtraIDList()
	local var_88_0, var_88_1, var_88_2, var_88_3, var_88_4 = BattleStageTools.GetStageFixedChipInfo(self.stageType, self.stageID)

	if var_88_0 then
		return var_88_4
	end

	return ReserveTools.GetCharChipExtraIDList(self.reserveParams)
end

function SelectHeroBaseProxy:IsCharChipBaseUnlock(arg_89_1)
	return ChipTools.IsCharChipBaseUnlock(arg_89_1)
end

function SelectHeroBaseProxy:GetCharChipExtraIDListUnlock(arg_90_1)
	return ChipTools.GetCharChipExtraIDListUnlock(arg_90_1)
end

function SelectHeroBaseProxy:IsCharChipBaseCanUnlock(arg_91_1)
	return ChipTools.IsCharChipBaseCanUnlock(arg_91_1)
end

function SelectHeroBaseProxy:IsCharChipExtraCanUnlock(arg_92_1)
	return ChipTools.IsCharChipExtraCanUnlock(arg_92_1)
end

function SelectHeroBaseProxy:IsCharChipExtraUnlock(arg_93_1)
	return ChipTools.IsCharChipExtraUnlock(arg_93_1)
end

function SelectHeroBaseProxy:IsCharChipCanOperate(arg_94_1)
	return true
end

function SelectHeroBaseProxy:IsUseMimirChip()
	return self:GetMimirID() ~= 0
end

function SelectHeroBaseProxy:IsUseCharChip()
	return self:GetCharChipBaseID() ~= 0
end

return SelectHeroBaseProxy
