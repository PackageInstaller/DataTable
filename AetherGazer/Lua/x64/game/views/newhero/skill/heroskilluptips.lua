local var_0_0 = class("HeroSkillUpTips", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_skill/HeroSkillPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.costItemList = {}
	arg_4_0.titleController = arg_4_0.transCon_:GetController("title")
	arg_4_0.btnController = arg_4_0.transCon_:GetController("btnState")
	arg_4_0.stateController = arg_4_0.stateCon_:GetController("state")
	arg_4_0.jumpController = arg_4_0.jumpCon_:GetController("jump")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_noBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_yesBtn_, nil, function()
		if arg_5_0.isAttr then
			local var_8_0 = SkillTools.GetSkillIdIndex(arg_5_0.skillId)

			HeroAction.HeroSkillAttrUpgrade(arg_5_0.heroId, var_8_0, arg_5_0.targetLevel - arg_5_0.nowLv)
		else
			HeroAction.HeroSkillUpgrade(arg_5_0.heroId, arg_5_0.skillId, arg_5_0.targetLevel - arg_5_0.nowLv)
		end

		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.subBtn_, nil, function()
		arg_5_0.slider_.value = arg_5_0.targetLevel - 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		arg_5_0.slider_.value = arg_5_0.targetLevel + 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.goUpgradeBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroUpgrade", {
			heroId = arg_5_0.heroId,
			proxy = arg_5_0.heroViewDataProxy
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:InitData()

	if arg_12_0.nowLv < arg_12_0.maxLevel then
		local var_12_0 = arg_12_0:CheckMaxUpLv(arg_12_0.skillId, arg_12_0.targetLevel)

		arg_12_0:RefreshState(var_12_0)
		arg_12_0:RefreshUI()
	end
end

function var_0_0.OnTop(arg_13_0)
	if arg_13_0.nowLv >= arg_13_0.maxLevel then
		JumpTools.Back()
	end
end

function var_0_0.InitData(arg_14_0)
	arg_14_0.heroViewDataProxy = arg_14_0.params_.proxy
	arg_14_0.skillId = arg_14_0.params_.skillId
	arg_14_0.heroId = arg_14_0.params_.heroId
	arg_14_0.isAttr = arg_14_0.params_.isAttr or false
	arg_14_0.skillIndex = SkillTools.GetSkillIdIndex(arg_14_0.skillId)
	arg_14_0.nowLv = arg_14_0.isAttr and arg_14_0.heroViewDataProxy:GetSkillAttrLv(arg_14_0.heroId, arg_14_0.skillIndex) or arg_14_0.heroViewDataProxy:GetSkillLv(arg_14_0.heroId, arg_14_0.skillId)
	arg_14_0.maxUpLv = arg_14_0.isAttr and SkillTools.GetSkillAttrMaxUpLv(arg_14_0.skillId, arg_14_0.nowLv) or SkillTools.GetSkillMaxUpLv(arg_14_0.skillId, arg_14_0.nowLv)
	arg_14_0.minLevel = arg_14_0.nowLv + 1
	arg_14_0.maxLevel = arg_14_0.isAttr and HeroConst.MAX_SKILL_ATTR_LEVEL or HeroConst.MAX_SKILL_LEVEL
	arg_14_0.targetLevel = math.max(arg_14_0.minLevel, arg_14_0.maxUpLv)

	arg_14_0:InitSlider()
end

function var_0_0.InitSlider(arg_15_0)
	arg_15_0.slider_.minValue = arg_15_0.nowLv
	arg_15_0.slider_.maxValue = arg_15_0.maxLevel
	arg_15_0.slider_.value = arg_15_0.targetLevel

	if arg_15_0.maxLevel - arg_15_0.nowLv <= 1 then
		arg_15_0.subBtn_.interactable = false
		arg_15_0.addBtn_.interactable = false
	else
		arg_15_0.subBtn_.interactable = arg_15_0.targetLevel > arg_15_0.minLevel
		arg_15_0.addBtn_.interactable = arg_15_0.targetLevel < arg_15_0.maxLevel
	end

	arg_15_0.slider_.onValueChanged:AddListener(function(arg_16_0)
		arg_15_0.subBtn_.interactable = arg_16_0 > arg_15_0.minLevel
		arg_15_0.addBtn_.interactable = arg_16_0 < arg_15_0.maxLevel

		if arg_16_0 < arg_15_0.minLevel then
			arg_15_0.slider_.value = arg_15_0.minLevel
		else
			arg_15_0:OnTargetLevelChange(arg_16_0)
		end
	end)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.leftLvTxt_.text = arg_17_0.nowLv
	arg_17_0.rightLvTxt_.text = arg_17_0.targetLevel

	arg_17_0.titleController:SetSelectedState(tostring(arg_17_0.isAttr))

	for iter_17_0, iter_17_1 in pairs(arg_17_0.costItemList or {}) do
		iter_17_1.gameObject_:SetActive(false)
	end

	arg_17_0:CaculateMaterial()

	for iter_17_2, iter_17_3 in pairs(arg_17_0.costDataList) do
		local var_17_0 = arg_17_0.costItemList[iter_17_2]

		if not var_17_0 then
			var_17_0 = arg_17_0:CreateCostItem()
			arg_17_0.costItemList[iter_17_2] = var_17_0
		end

		var_17_0.gameObject_:SetActive(true)

		local var_17_1 = clone(ItemTemplateData)

		var_17_1.id = iter_17_3.id

		function var_17_1.clickFun(arg_18_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_18_0.id,
				arg_18_0.number
			})
		end

		local var_17_2 = ItemTools.getItemNum(iter_17_3.id)

		var_17_0:SetData(var_17_1)
		var_17_0:RefreshBottomText({
			var_17_2,
			iter_17_3.num
		})
		var_17_0:RefreshBottomRightText(true)
	end
end

function var_0_0.CreateCostItem(arg_19_0)
	local var_19_0 = GameObject.Instantiate(arg_19_0.commonitemGo_, arg_19_0.rewardpanelTrs_)

	return CommonItemView.New(var_19_0)
end

function var_0_0.OnTargetLevelChange(arg_20_0, arg_20_1)
	if arg_20_0.targetLevel == arg_20_1 then
		return
	end

	arg_20_0.targetLevel = arg_20_1

	local var_20_0 = arg_20_0:CheckMaxUpLv(arg_20_0.skillId, arg_20_1)

	arg_20_0:RefreshState(var_20_0)
	arg_20_0:RefreshUI()
end

function var_0_0.CheckMaxUpLv(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = SkillTools.GetMainHeroId(arg_21_1)
	local var_21_1 = HeroData:GetHeroData(var_21_0)
	local var_21_2 = SkillTools.GetSkillIdIndex(arg_21_1)
	local var_21_3 = {}
	local var_21_4 = {}

	for iter_21_0 = arg_21_0.nowLv + 1, arg_21_2 do
		local var_21_5

		if arg_21_0.isAttr then
			local var_21_6 = SkillTools.GetSkillAttrCfg(var_21_1.id, var_21_2, iter_21_0)

			var_21_5 = var_21_6 and var_21_6.cost or nil
		else
			var_21_5 = SkillCfg[iter_21_0 - 1]["skill_cost" .. var_21_2]

			local var_21_7 = SkillCfg[iter_21_0 - 1]["skill_limit" .. var_21_2]

			if var_21_7 > var_21_1.break_level then
				var_21_3.heroUpgradeLack = true
				var_21_3.needUpgradeTimes = var_21_7
				var_21_3.nowUpgradeTimes = var_21_1.break_level
			end
		end

		for iter_21_1, iter_21_2 in pairs(var_21_5) do
			local var_21_8 = iter_21_2[1]
			local var_21_9 = iter_21_2[2]
			local var_21_10 = var_21_4[var_21_8]

			if not var_21_10 then
				var_21_10 = ItemTools.getItemNum(var_21_8)
				var_21_4[var_21_8] = var_21_10
			end

			if var_21_10 < var_21_9 then
				var_21_3.materialLack = true

				break
			end

			var_21_4[var_21_8] = var_21_4[var_21_8] - var_21_9
		end

		if var_21_3.materialLack then
			break
		end
	end

	return var_21_3
end

function var_0_0.RefreshState(arg_22_0, arg_22_1)
	local var_22_0 = not arg_22_1.heroUpgradeLack and not arg_22_1.materialLack

	arg_22_0.jumpController:SetSelectedState(arg_22_1.heroUpgradeLack and "show" or "hide")
	arg_22_0.stateController:SetSelectedState(var_22_0 and "normal" or "lack")

	if arg_22_1.heroUpgradeLack then
		arg_22_0.conditionText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), arg_22_1.needUpgradeTimes) .. string.format("(%s/%s)", arg_22_1.nowUpgradeTimes, arg_22_1.needUpgradeTimes)
	elseif arg_22_1.materialLack then
		arg_22_0.conditionText_.text = arg_22_0.isAttr and GetTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT") or GetTips("ERROR_HERO_NO_SKILL_UP_MAT")
	elseif var_22_0 then
		arg_22_0.stateController:SetSelectedState("normal")

		arg_22_0.middleText_.text = string.format(GetTips("LEVELUP_DIFF"), arg_22_0.targetLevel - arg_22_0.nowLv)
	end

	arg_22_0.btnController:SetSelectedState(tostring(var_22_0))
end

function var_0_0.CaculateMaterial(arg_23_0)
	local var_23_0 = arg_23_0.isAttr and SkillTools.GetSkillAttrUpCostNum(arg_23_0.skillId, arg_23_0.heroId, arg_23_0.nowLv, arg_23_0.targetLevel - arg_23_0.nowLv) or SkillTools.GetSkillUpCostNum(arg_23_0.skillId, arg_23_0.nowLv, arg_23_0.targetLevel - arg_23_0.nowLv)

	arg_23_0.costDataList = {}

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		table.insert(arg_23_0.costDataList, {
			id = iter_23_0,
			num = iter_23_1
		})
	end
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0.slider_.onValueChanged:RemoveAllListeners()
end

function var_0_0.Dispose(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.costItemList or {}) do
		if iter_25_1 then
			iter_25_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
