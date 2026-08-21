local var_0_0 = class("SPHeroChallengeTrainStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.offsetController = arg_5_0.controller:GetController("offset")
	arg_5_0.stateController = arg_5_0.controller:GetController("state")
	arg_5_0.affixItem = {}

	for iter_5_0 = 1, 3 do
		arg_5_0.affixItem[iter_5_0] = SPHeroChallengeAffixItem.New(arg_5_0["progressdesc" .. iter_5_0 .. "Go_"])

		arg_5_0.affixItem[iter_5_0]:SetClickListener(function()
			arg_5_0:CloseAllAffix()
		end)
	end
end

function var_0_0.CloseAllAffix(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.affixItem) do
		iter_7_1:CloseAffix()
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.trainType = arg_8_0.params_.trainType

	if arg_8_0.params_.playAnimation then
		arg_8_0.animator:Play("Fx_SPHeroChallengeTrainStageUI_cx", 0, 0)

		arg_8_0.params_.playAnimation = nil
	end

	arg_8_0.activityID = SPHeroChallengeData:GetActivityID()
	arg_8_0.info = SPHeroChallengeData:GetCurActivityInfo()

	arg_8_0:RefreshProficiency()
	arg_8_0:RefreshTrainEffectDesc()
	arg_8_0:RefreshStageInfo()
	arg_8_0:RefreshBar()
	arg_8_0:RefreshBackBtnState()
	arg_8_0:RefreshTrainIconAndName()
end

function var_0_0.OnTop(arg_9_0)
	return
end

function var_0_0.OnBehind(arg_10_0)
	arg_10_0:RefreshBackBtnState()
end

function var_0_0.RefreshBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
			groupIndex = SpHeroChallengeConst.ChapterType.train
		})
	end)
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.backBtn_, nil, function()
		if arg_14_0:IsOpenSectionView() then
			arg_14_0:Back()
			arg_14_0:RefreshBackBtnState()
		end
	end)
end

function var_0_0.RegisterEvents(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.stageInfoList then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.stageInfoList) do
			iter_17_1:Dispose()
		end
	end

	if arg_17_0.affixItem then
		for iter_17_2, iter_17_3 in ipairs(arg_17_0.affixItem) do
			iter_17_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.RefreshProficiency(arg_18_0)
	if arg_18_0.info then
		local var_18_0, var_18_1 = arg_18_0.info:GetTrainNumByType(arg_18_0.trainType)
		local var_18_2 = string.format("%.2f", var_18_0 / var_18_1)

		arg_18_0.sliderSlr_.value = var_18_2
		arg_18_0.curNumText_.text = math.min(var_18_0, var_18_1)
	end
end

function var_0_0.RefreshTrainEffectDesc(arg_19_0)
	if arg_19_0.affixItem then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.affixItem) do
			iter_19_1:RefreshUI(arg_19_0.trainType, iter_19_0)
		end
	end
end

function var_0_0.RefreshStageInfo(arg_20_0)
	local var_20_0 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[arg_20_0.trainType]

	if not arg_20_0.stageInfoList then
		arg_20_0.stageInfoList = {}

		for iter_20_0 = 1, #var_20_0 do
			arg_20_0.stageInfoList[iter_20_0] = SPHeroChallengeTrainStageItem.New(arg_20_0["trainstageitem" .. iter_20_0 .. "Go_"])
		end
	end

	for iter_20_1 = 1, #var_20_0 do
		arg_20_0.stageInfoList[iter_20_1]:RefreshUI(var_20_0[iter_20_1], arg_20_0.stageID, iter_20_1)
		arg_20_0.stageInfoList[iter_20_1]:RegisterClickCallBack(handler(arg_20_0, arg_20_0.ClickStageHandle))
	end
end

function var_0_0.ClickStageHandle(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.stageID = arg_21_1
	arg_21_0.selectIndex = arg_21_2

	JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
		section = arg_21_0.stageID,
		sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
		activityId = arg_21_0.params_.activityId,
		challengeType = SpHeroChallengeConst.ChapterType.train
	})
	arg_21_0:RefreshBackBtnState(arg_21_2)
	arg_21_0:RefreshStageInfo()
end

function var_0_0.IsOpenSectionView(arg_22_0)
	return arg_22_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.RefreshBackBtnState(arg_23_0)
	if arg_23_0:IsOpenSectionView() then
		SetActive(arg_23_0.backBtn_.gameObject, true)

		if arg_23_0.selectIndex then
			arg_23_0.offsetController:SetSelectedState(tostring(arg_23_0.selectIndex))
		end
	else
		SetActive(arg_23_0.backBtn_.gameObject, false)
		arg_23_0.offsetController:SetSelectedState("ori")
	end
end

function var_0_0.RefreshTrainIconAndName(arg_24_0)
	local var_24_0, var_24_1 = SPHeroChallengeTools:GetTrainNameAndIcon(arg_24_0.trainType)

	arg_24_0.name.text = var_24_0
	arg_24_0.icon.sprite = var_24_1
	arg_24_0.descText_.text = var_24_0 .. GetTips("TIP_CLEARTIMES")

	arg_24_0.stateController:SetSelectedState(tostring(arg_24_0.trainType))
end

return var_0_0
