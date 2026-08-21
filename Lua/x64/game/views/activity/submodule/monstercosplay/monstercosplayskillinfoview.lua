local var_0_0 = class("MonsterCosplaySkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStructureInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:UpdateData()
	arg_4_0:UpdateView()
	arg_4_0:UpdateBar()
	SetActive(arg_4_0.tipsGo_, false)
end

function var_0_0.UpdateBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.animator:Play("skill0" .. arg_6_0.index .. "_back")

	arg_6_0.coreSkillCfg = nil

	manager.windowBar:HideBar()
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.upController = arg_7_0.controller_:GetController("up")
	arg_7_0.upNumController = arg_7_0.controller_:GetController("upNum")
	arg_7_0.cdController = arg_7_0.controller_:GetController("cd")
	arg_7_0.partController = arg_7_0.controller_:GetController("part")
	arg_7_0.stateController = arg_7_0.controller_:GetController("state")
	arg_7_0.controllerList = {
		{
			skill1Controller = arg_7_0.skill11Controller_:GetController("state"),
			skill2Controller = arg_7_0.skill12Controller_:GetController("state")
		},
		{
			skill1Controller = arg_7_0.skill21Controller_:GetController("state"),
			skill2Controller = arg_7_0.skill22Controller_:GetController("state")
		}
	}
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListenerScale(arg_8_0.bgBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.tipsBgBtn_, nil, function()
		SetActive(arg_8_0.tipsGo_, false)
	end)

	for iter_8_0 = 1, 8 do
		arg_8_0:AddBtnListenerScale(arg_8_0["skill1" .. iter_8_0 .. "Btn_"], nil, function()
			SetActive(arg_8_0.tipsGo_, true)

			local var_11_0 = ActivityMonsterCosplaySkillCfg[arg_8_0.coreSkillCfg.affix_effect_skill_list[math.ceil(iter_8_0 / 2)]]

			arg_8_0.tipsGo_.transform.position = arg_8_0["skill1" .. iter_8_0 .. "Btn_"].transform.position
			arg_8_0.tipsGo_.transform.anchoredPosition = Vector2(arg_8_0.tipsGo_.transform.anchoredPosition.x - arg_8_0.tipsGo_.transform.rect.width / 2 - arg_8_0["skill1" .. iter_8_0 .. "Btn_"].transform.rect.width, arg_8_0.tipsGo_.transform.anchoredPosition.y)

			if iter_8_0 % 2 == 1 then
				arg_8_0.tipsSkillNameTxt_.text = GetI18NText(var_11_0.skill_name)
				arg_8_0.tipsSkillDescTxt_.text = GetI18NText(var_11_0.skill_start_description)
			else
				arg_8_0.tipsSkillNameTxt_.text = GetI18NText(var_11_0.skill_name)
				arg_8_0.tipsSkillDescTxt_.text = GetI18NText(var_11_0.skill_new_description)
			end
		end)
		arg_8_0:AddBtnListenerScale(arg_8_0["skill2" .. iter_8_0 .. "Btn_"], nil, function()
			arg_8_0.tipsGo_.transform.position = arg_8_0["skill2" .. iter_8_0 .. "Btn_"].transform.position
			arg_8_0.tipsGo_.transform.anchoredPosition = Vector2(arg_8_0.tipsGo_.transform.anchoredPosition.x - arg_8_0.tipsGo_.transform.rect.width / 2 - arg_8_0["skill1" .. iter_8_0 .. "Btn_"].transform.rect.width, arg_8_0.tipsGo_.transform.anchoredPosition.y)

			SetActive(arg_8_0.tipsGo_, true)

			local var_12_0 = ActivityMonsterCosplaySkillCfg[arg_8_0.coreSkillCfg.affix_effect_skill_list[math.ceil(iter_8_0 / 2)]]

			if iter_8_0 % 2 == 1 then
				arg_8_0.tipsSkillNameTxt_.text = GetI18NText(var_12_0.skill_name)
				arg_8_0.tipsSkillDescTxt_.text = GetI18NText(var_12_0.skill_start_description)
			else
				arg_8_0.tipsSkillNameTxt_.text = GetI18NText(var_12_0.skill_name)
				arg_8_0.tipsSkillDescTxt_.text = GetI18NText(var_12_0.skill_new_description)
			end
		end)
	end
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0.skillID = arg_13_0.params_.monsterSkill
	arg_13_0.modelID = arg_13_0.params_.modelID
	arg_13_0.index = arg_13_0.params_.index
	arg_13_0.animator = arg_13_0.params_.animator
	arg_13_0.isCoreData = arg_13_0.params_.isCoreData
	arg_13_0.cfg = ActivityMonsterCosplaySkillCfg[arg_13_0.skillID]
	arg_13_0.modelData = MonsterCosplayData:GetDataByPara("monsterData")[arg_13_0.modelID]
	arg_13_0.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")[arg_13_0.skillID] or {}
	arg_13_0.viewCoreSkillTable = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[arg_13_0.modelID]

	local var_13_0 = arg_13_0.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	arg_13_0.stateController:SetSelectedState(tostring(var_13_0))

	arg_13_0.cdTxt_ = arg_13_0["cdTxt" .. var_13_0 .. "_"]
	arg_13_0.descTxt_ = arg_13_0["descTxt" .. var_13_0 .. "_"]
	arg_13_0.skillNameTxt_ = arg_13_0["skillNameTxt" .. var_13_0 .. "_"]
	arg_13_0.skillIcon_ = arg_13_0["skillIcon" .. var_13_0 .. "_"]
	arg_13_0.controller = arg_13_0.controllerList[var_13_0]

	for iter_13_0 = 1, 2 do
		arg_13_0["skill" .. iter_13_0 .. "Icon_"] = arg_13_0["skill" .. var_13_0 .. iter_13_0 .. "Icon_"]
		arg_13_0["skill" .. iter_13_0 .. "DescTxt_"] = arg_13_0["skill" .. var_13_0 .. iter_13_0 .. "DescTxt_"]
		arg_13_0["skill" .. iter_13_0 .. "IndexTxt_"] = arg_13_0["skill" .. var_13_0 .. iter_13_0 .. "IndexTxt_"]
		arg_13_0["lock" .. iter_13_0 .. "Txt_"] = arg_13_0["lock" .. var_13_0 .. iter_13_0 .. "Txt_"]
	end

	for iter_13_1 = 1, 4 do
		arg_13_0["core" .. iter_13_1 .. "Go_"] = arg_13_0["core" .. var_13_0 .. iter_13_1 .. "Go_"]
		arg_13_0["core" .. iter_13_1 .. "Txt_"] = arg_13_0["core" .. var_13_0 .. iter_13_1 .. "Txt_"]
		arg_13_0["core" .. iter_13_1 .. "normalIcon_"] = arg_13_0["core" .. var_13_0 .. iter_13_1 .. "normalIcon_"]
		arg_13_0["core" .. iter_13_1 .. "upIcon_"] = arg_13_0["core" .. var_13_0 .. iter_13_1 .. "upIcon_"]
	end
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0.cdController:SetSelectedState(tostring(arg_14_0.cfg.skill_cd ~= "0"))

	arg_14_0.cdTxt_.text = arg_14_0.cfg.skill_cd
	arg_14_0.skillNameTxt_.text = arg_14_0.cfg.skill_name
	arg_14_0.descTxt_.text = arg_14_0.cfg.skill_start_description

	arg_14_0.partController:SetSelectedState(tostring(arg_14_0.index))
	arg_14_0.upNumController:SetSelectedState(#arg_14_0.skillToAffixTable)
	arg_14_0.upController:SetSelectedState(tostring(arg_14_0:GetEnhancedCount()))
	SetActive(arg_14_0.upGo_, #arg_14_0.skillToAffixTable ~= 0)

	for iter_14_0 = 1, 4 do
		SetActive(arg_14_0["core" .. iter_14_0 .. "Go_"], false)
	end

	for iter_14_1 = 1, 2 do
		local var_14_0 = arg_14_0.skillToAffixTable[iter_14_1]
		local var_14_1 = TalentTreeCfg[var_14_0]

		if var_14_0 == nil then
			arg_14_0.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("none")
		else
			if arg_14_0.viewCoreSkillTable[var_14_0] then
				arg_14_0.coreSkillCfg = ActivityMonsterCosplaySkillCfg[var_14_1.stage]

				for iter_14_2 = 1, 4 do
					if iter_14_2 <= #arg_14_0.coreSkillCfg.affix_effect_skill_list then
						local var_14_2 = ActivityMonsterCosplaySkillCfg[arg_14_0.coreSkillCfg.affix_effect_skill_list[iter_14_2]]

						arg_14_0["core" .. iter_14_2 .. "Txt_"].text = GetI18NText(var_14_2.skill_name)
						arg_14_0["core" .. iter_14_2 .. "normalIcon_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. var_14_2.skill_start_icon)
						arg_14_0["core" .. iter_14_2 .. "upIcon_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. var_14_2.skill_new_icon)
					end

					SetActive(arg_14_0["core" .. iter_14_2 .. "Go_"], iter_14_2 <= #arg_14_0.coreSkillCfg.affix_effect_skill_list)
				end
			end

			if arg_14_0.modelData.enhancedSkill[var_14_0] == nil and arg_14_0.viewCoreSkillTable[var_14_0] ~= true then
				arg_14_0.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("lock")

				if arg_14_0.modelID == ActivityMonsterCosplayCfg.all[1] then
					arg_14_0["lock" .. iter_14_1 .. "Txt_"].text = GetTips("ACTIVITY_MONSTER_COSPLAY_ANJINSHU_TALENT_PUTONG_TIPS")
				else
					arg_14_0["lock" .. iter_14_1 .. "Txt_"].text = GetTips("ACTIVITY_MONSTER_COSPLAY_RENMA_TALENT_PUTONG_TIPS")
				end

				if var_14_1.type == 1 then
					arg_14_0["lock" .. iter_14_1 .. "Txt_"].text = ConditionCfg[var_14_1.unlock_condition[1]].desc
				end
			else
				arg_14_0.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("get1")

				arg_14_0["skill" .. iter_14_1 .. "DescTxt_"].text = GetI18NText(var_14_1.desc)
				arg_14_0["skill" .. iter_14_1 .. "Icon_"].sprite = MonsterCosplayData.GetAffixSprite(var_14_0)
			end
		end
	end

	arg_14_0.skillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. arg_14_0.cfg.skill_start_icon)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.GetEnhancedCount(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.skillToAffixTable) do
		if arg_16_0.modelData.enhancedSkill[iter_16_1] and TalentTreeCfg[iter_16_1].type == 2 then
			var_16_0 = var_16_0 + 1
		elseif TalentTreeCfg[iter_16_1].type == 1 and arg_16_0.viewCoreSkillTable[iter_16_1] then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

return var_0_0
