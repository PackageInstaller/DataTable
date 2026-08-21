local var_0_0 = class("MonsterCosplaySkillUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayAffixPopUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, MonsterCosplaySkillUpItem)
	arg_4_0.skillList = LuaList.New(handler(arg_4_0, arg_4_0.skillIndexItem), arg_4_0.skillListGo_, MonsterCosplaySkillShowItem)
	arg_4_0.btnController = arg_4_0.controller_:GetController("btn")
	arg_4_0.coreController = arg_4_0.controller_:GetController("core")
	arg_4_0.titleController = arg_4_0.controller_:GetController("title")
	arg_4_0.skillInfoController = arg_4_0.controller_:GetController("skillinfo")
	arg_4_0.mainController = arg_4_0.mainController_:GetController("place")
	arg_4_0.colorController = arg_4_0.mainController_:GetController("state2")
	arg_4_0.color2Controller = arg_4_0.mainController_:GetController("state3")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.sureBtn_, nil, function()
		if arg_5_0.isCoreSkill then
			MonsterCosplayAction.ViewMonsterSkill(arg_5_0.monsterID, arg_5_0.coreSkillID)

			return
		end

		if arg_5_0.selectID == nil then
			ShowTips("ACTIVITY_MONSTER_COSPLAY_NO_CHOOSE_ERROR")

			return
		end

		MonsterCosplayAction.UpdateMonsterSkill(arg_5_0.monsterID, arg_5_0.affixList[arg_5_0.selectID])
	end)
	arg_5_0:AddBtnListener(arg_5_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("/MonsterCosplayMonster", {
			modelID = arg_5_0.monsterID
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsMaskBtn_, nil, function()
		SetActive(arg_5_0.tipsGo_, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.coreAffix then
			MonsterCosplayAction.ViewMonsterSkill(arg_5_0.monsterID, arg_5_0.coreAffix)
		end
	end)
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.affixList[arg_10_1], handler(arg_10_0, arg_10_0.ClickFunction), arg_10_1, arg_10_0.monsterData, arg_10_0.monsterID)
end

function var_0_0.skillIndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = TalentTreeCfg[arg_11_0.coreAffix]
	local var_11_1 = ActivityMonsterCosplaySkillCfg[var_11_0.stage]

	arg_11_2:SetData(var_11_1.affix_effect_skill_list[arg_11_1], arg_11_1, handler(arg_11_0, arg_11_0.ClickSkillCallBack))
end

function var_0_0.OnMonsterCoreSkill(arg_12_0, arg_12_1)
	arg_12_0:Back()

	if arg_12_1 == 0 then
		return
	end

	arg_12_0.params_.coreAffixID = nil
	arg_12_0.coreAffix = nil
end

function var_0_0.ClickFunction(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2:GetSelectedState() == "get" or arg_13_2:GetSelectedState() == "sel" then
		return
	end

	if arg_13_0.controller == nil then
		arg_13_0.controller = arg_13_2

		arg_13_0.controller:SetSelectedState("sel")
	else
		arg_13_0.controller:SetSelectedState("normal")

		arg_13_0.controller = arg_13_2
	end

	if arg_13_0.selectID ~= arg_13_1 then
		arg_13_0.selectID = arg_13_1

		arg_13_0.controller:SetSelectedState("sel")
	end

	arg_13_0.btnController:SetSelectedState("true")
end

function var_0_0.OnMonsterSkillUp(arg_14_0)
	ShowTips("SUCCESS_STRENGTHEN")
	arg_14_0:Back()
end

function var_0_0.UpdateBar(arg_15_0)
	return
end

function var_0_0.ClickSkillCallBack(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	SetActive(arg_16_0.tipsGo_, true)

	arg_16_0.tipsGo_.transform.position = arg_16_1.transform.position
	arg_16_0.tipsGo_.transform.anchoredPosition = Vector2(arg_16_0.tipsGo_.transform.anchoredPosition.x - arg_16_0.tipsGo_.transform.rect.width / 2 - arg_16_1.transform.rect.width, arg_16_0.tipsGo_.transform.anchoredPosition.y)

	if arg_16_3 == 1 then
		arg_16_0.skillDescTxt_.text = GetI18NText(arg_16_2.skill_start_description)
	else
		arg_16_0.skillDescTxt_.text = GetI18NText(arg_16_2.skill_new_description)
	end

	arg_16_0.skillNameTxt_.text = GetI18NText(arg_16_2.skill_name)
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.coreController:SetSelectedState(tostring(arg_17_0.isCoreSkill))
	arg_17_0.titleController:SetSelectedState(arg_17_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")

	if arg_17_0.isCoreSkill then
		local var_17_0 = TalentTreeCfg[arg_17_0.coreAffix]
		local var_17_1 = ActivityMonsterCosplaySkillCfg[var_17_0.stage]

		arg_17_0.skillInfoController:SetSelectedState(tostring(#var_17_1.affix_effect_skill_list == 0))
		arg_17_0.btnController:SetSelectedState("true")
		arg_17_0.skillList:StartScroll(#var_17_1.affix_effect_skill_list)

		arg_17_0.skillDesc_.text = GetI18NText(var_17_0.desc)
		arg_17_0.skillName_.text = GetI18NText(var_17_0.name)
		arg_17_0.affixDesc_.text = GetI18NText(var_17_1.affix_effect_skill_desc)
		arg_17_0.coreSkillIndexTxt_.text = GetI18NText(var_17_1.skill_index) or ""
		arg_17_0.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(arg_17_0.coreAffix)

		arg_17_0.mainController:SetSelectedState(tostring(table.indexof(ActivityMonsterCosplayCfg[arg_17_0.monsterID].skill_list, arg_17_0.coreSkillID)))
		TimeTools.StartAfterSeconds(0.6, function()
			SetActive(arg_17_0.affixGo_, true)

			if #var_17_1.affix_effect_skill_list ~= 0 then
				local var_18_0 = LeanTween.value(arg_17_0.affixGo_, 0, -290, 0.25)

				var_18_0:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_17_0.affixGo_.transform.anchoredPosition = Vector2(arg_19_0, 0)
				end))
				var_18_0:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_0.affixGo_)
					var_18_0:setOnUpdate(nil):setOnComplete(nil)
				end))
			end
		end, {})
	else
		arg_17_0.list:StartScroll(#arg_17_0.affixList)
	end

	arg_17_0.colorController:SetSelectedState(arg_17_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
	arg_17_0.color2Controller:SetSelectedState(arg_17_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
end

function var_0_0.UpdateData(arg_21_0)
	arg_21_0.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")
	arg_21_0.affixList = {}

	for iter_21_0, iter_21_1 in ipairs(ActivityMonsterCosplayCfg[arg_21_0.monsterID].skill_list) do
		if arg_21_0.skillToAffixTable[iter_21_1] ~= nil then
			for iter_21_2, iter_21_3 in ipairs(arg_21_0.skillToAffixTable[iter_21_1]) do
				if TalentTreeCfg[iter_21_3].type == 2 then
					table.insert(arg_21_0.affixList, iter_21_3)
				end
			end
		end
	end

	arg_21_0.isCoreSkill = arg_21_0.params_.coreAffixID ~= nil
	arg_21_0.coreAffix = arg_21_0.params_.coreAffixID

	if arg_21_0.coreAffix then
		arg_21_0.coreSkillID = TalentTreeCfg[arg_21_0.coreAffix].stage
	end

	arg_21_0.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[arg_21_0.monsterID]

	table.sort(arg_21_0.affixList, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_21_0.monsterData.enhancedSkill[arg_22_0]

		if var_22_0 == arg_21_0.monsterData.enhancedSkill[arg_22_1] then
			return arg_22_1 < arg_22_0
		else
			return var_22_0 == nil
		end
	end)
end

function var_0_0.OnEnter(arg_23_0)
	arg_23_0.selectID = nil
	arg_23_0.monsterID = arg_23_0.params_.modelID

	SetActive(arg_23_0.affixGo_, false)
	arg_23_0.btnController:SetSelectedState("false")
	arg_23_0:UpdateData()
	arg_23_0:UpdateView()
	SetActive(arg_23_0.tipsGo_, false)
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0.selectID = nil
	arg_24_0.monsterID = nil
	arg_24_0.controller = nil
	arg_24_0.params_.isCoreSkill = nil
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.list then
		arg_25_0.list:Dispose()

		arg_25_0.list = nil
	end

	if arg_25_0.skillList then
		arg_25_0.skillList:Dispose()

		arg_25_0.skillList = nil
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
