local var_0_0 = class("CanteenHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.clickFlag = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.fatigueController = ControllerUtil.GetController(arg_2_0.transform_, "fatigue")
	arg_2_0.selController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.jobController = ControllerUtil.GetController(arg_2_0.transform_, "work")
	arg_2_0.skillController = ControllerUtil.GetController(arg_2_0.transform_, "skill")
	arg_2_0.sameNameController = ControllerUtil.GetController(arg_2_0.transform_, "sameName")
	arg_2_0.lockHeroController = arg_2_0.controllers_:GetController("lock")
end

function var_0_0.SetFunction(arg_3_0, arg_3_1)
	arg_3_0.showWork = arg_3_1
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.heroitemBtn_, nil, function()
		if arg_4_0.selFunc then
			arg_4_0.selFunc(arg_4_0.heroID)
		end
	end)
end

function var_0_0.ResetCharacterCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.selFunc = arg_6_1
	end
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.heroID = arg_7_1

	if DormNpcTools:CheckIDIsNpc(arg_7_1) then
		arg_7_0:RefreshNpcInfo(arg_7_1, arg_7_2, arg_7_3)
	else
		arg_7_0:RefreshHeroInfo(arg_7_1, arg_7_2, arg_7_3)
	end
end

function var_0_0.RefreshHeroInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.heroIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_8_1)
	arg_8_0.heroitemBtn_.interactable = true

	local var_8_0 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_8_1)

	arg_8_0.lockHeroController:SetSelectedState(var_8_0 and "on" or "off")

	local var_8_1 = DormData:GetHeroFatigue(arg_8_1)

	arg_8_0.curText_.text = var_8_1
	arg_8_0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	arg_8_0.progressImg_.fillAmount = 1 - math.min(var_8_1 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	local var_8_2 = GameDisplayCfg.dorm_hero_fatigue_level.value

	if var_8_1 <= var_8_2[1] then
		arg_8_0.fatigueController:SetSelectedState("lack")
	elseif var_8_1 > var_8_2[1] and var_8_1 <= var_8_2[2] then
		arg_8_0.fatigueController:SetSelectedState("middle")
	else
		arg_8_0.fatigueController:SetSelectedState("full")
	end

	local var_8_3 = DormData:GetHeroTemplateInfo(arg_8_1)

	arg_8_0.jobController:SetSelectedState("false")

	if not arg_8_0.showWork then
		local var_8_4 = var_8_3.jobType

		if var_8_4 then
			arg_8_0.jobController:SetSelectedState("true")

			arg_8_0.jobText_.text = GetI18NText(CanteenTools:GetJobName(var_8_4))

			if var_8_3.hero_id ~= arg_8_1 then
				arg_8_0.selController:SetSelectedState("no")
			end
		elseif CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_8_1) then
			arg_8_0.jobController:SetSelectedState("true")

			arg_8_0.jobText_.text = GetTips("DORM_HERO_AT_TASK")
		end
	end

	local var_8_5 = DormSkillData:CheckSkillCanOpen(arg_8_3, arg_8_1)

	if #var_8_5 > 0 then
		local var_8_6 = var_8_5[1]

		arg_8_0.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(var_8_6)

		arg_8_0.skillController:SetSelectedState("true")
	else
		arg_8_0.skillController:SetSelectedState("false")
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_8_1) then
		arg_8_0.selController:SetSelectedState("no")

		arg_8_0.heroitemBtn_.interactable = false

		return
	end

	local var_8_7

	if arg_8_2 and not DormNpcTools:CheckIDIsNpc(arg_8_2) then
		var_8_7 = HeroRecordCfg.get_id_list_by_hero_id[arg_8_2][1]
	end

	arg_8_0.archiveID = HeroRecordCfg.get_id_list_by_hero_id[arg_8_1][1]

	arg_8_0.sameNameController:SetSelectedState("false")

	if arg_8_2 == arg_8_1 then
		arg_8_0.selController:SetSelectedState("sel")
	elseif arg_8_0.archiveID == var_8_7 then
		if not var_8_3.jobType then
			arg_8_0.sameNameController:SetSelectedState("true")
		end
	else
		arg_8_0.selController:SetSelectedState("normal")
	end

	if var_8_3.jobType and var_8_3.hero_id ~= arg_8_1 then
		arg_8_0.selController:SetSelectedState("no")

		arg_8_0.heroitemBtn_.interactable = false
	end
end

function var_0_0.RefreshNpcInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.heroitemBtn_.interactable = true

	arg_9_0.lockHeroController:SetSelectedState("off")

	arg_9_0.heroIcon_.sprite = DormNpcTools:GetNpcHeadSprite(arg_9_1)

	if DormNpcTools:GetNpcFatigue(arg_9_1) < 0 then
		arg_9_0.fatigueController:SetSelectedState("infinite")
	end

	local var_9_0 = DormSkillData:CheckSkillCanOpen(arg_9_3, arg_9_1)

	if #var_9_0 > 0 then
		local var_9_1 = var_9_0[1]

		arg_9_0.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(var_9_1)

		arg_9_0.skillController:SetSelectedState("true")
	else
		arg_9_0.skillController:SetSelectedState("false")
	end

	if arg_9_2 == arg_9_1 then
		arg_9_0.selController:SetSelectedState("sel")
	else
		arg_9_0.selController:SetSelectedState("normal")
	end

	if not arg_9_0.showWork then
		local var_9_2 = BackHomeNpcData:GetNpcInfoById(arg_9_1).jobType

		if var_9_2 then
			arg_9_0.jobController:SetSelectedState("true")

			arg_9_0.jobText_.text = CanteenTools:GetJobName(var_9_2)
		else
			arg_9_0.jobController:SetSelectedState("false")
		end
	else
		arg_9_0.jobController:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
