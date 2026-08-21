local var_0_0 = class("MonsterCosplayMonsterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStructureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controllerList1 = {
		arg_4_0.skill1Go1_:GetController("up"),
		arg_4_0.skill2Go1_:GetController("up"),
		arg_4_0.skill3Go1_:GetController("up"),
		arg_4_0.skill4Go1_:GetController("up"),
		(arg_4_0.skill5Go1_:GetController("up"))
	}
	arg_4_0.controllerList2 = {
		arg_4_0.skill1Go2_:GetController("up"),
		arg_4_0.skill2Go2_:GetController("up"),
		arg_4_0.skill3Go2_:GetController("up"),
		arg_4_0.skill4Go2_:GetController("up"),
		(arg_4_0.skill5Go2_:GetController("up"))
	}
	arg_4_0.showController = arg_4_0.controller_:GetController("show")
	arg_4_0.modelController = arg_4_0.controller_:GetController("model")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 5 do
		arg_5_0:AddBtnListenerScale(arg_5_0["skill" .. iter_5_0 .. "Btn1_"], nil, function()
			arg_5_0.showController:SetSelectedState("false")
			arg_5_0.animator:Play("skill0" .. iter_5_0)

			local var_6_0 = ActivityMonsterCosplaySkillCfg[arg_5_0.modelCfg.skill_list[iter_5_0]]

			JumpTools.OpenPageByJump("MonsterCosplaySkillInfo", {
				modelID = arg_5_0.modelID,
				monsterSkill = var_6_0.id,
				index = iter_5_0,
				animator = arg_5_0.animator
			})
			manager.redPoint:setTip("MonsterCosPlay" .. var_6_0.id, 0)

			for iter_6_0, iter_6_1 in pairs(arg_5_0.skillToAffixTable[var_6_0.id]) do
				if arg_5_0.modelData.enhancedSkill[iter_6_1] and TalentTreeCfg[iter_6_1].type == 2 or TalentTreeCfg[iter_6_1].type == 1 and arg_5_0.viewCoreSkillTable[iter_6_1] then
					saveData("monsterCosplay", tostring(iter_6_1), "true")
				end
			end
		end)
		arg_5_0:AddBtnListenerScale(arg_5_0["skill" .. iter_5_0 .. "Btn2_"], nil, function()
			arg_5_0.showController:SetSelectedState("false")
			arg_5_0.animator:Play("skill0" .. iter_5_0)

			local var_7_0 = ActivityMonsterCosplaySkillCfg[arg_5_0.modelCfg.skill_list[iter_5_0]]

			JumpTools.OpenPageByJump("MonsterCosplaySkillInfo", {
				modelID = arg_5_0.modelID,
				monsterSkill = var_7_0.id,
				index = iter_5_0,
				animator = arg_5_0.animator
			})
			manager.redPoint:setTip("MonsterCosPlay" .. var_7_0.id, 0)

			for iter_7_0, iter_7_1 in pairs(arg_5_0.skillToAffixTable[var_7_0.id] or {}) do
				if arg_5_0.modelData.enhancedSkill[iter_7_1] and TalentTreeCfg[iter_7_1].type == 2 or TalentTreeCfg[iter_7_1].type == 1 and arg_5_0.viewCoreSkillTable[iter_7_1] then
					saveData("monsterCosplay", tostring(iter_7_1), "true")
				end
			end
		end)
	end
end

function var_0_0.UpdateBar(arg_8_0)
	return
end

function var_0_0.UpdateView(arg_9_0)
	for iter_9_0 = 1, 5 do
		local var_9_0 = ActivityMonsterCosplaySkillCfg[arg_9_0.modelCfg.skill_list[iter_9_0]]

		arg_9_0["skillName" .. iter_9_0 .. "Txt_"].text = var_9_0.skill_name

		arg_9_0.controllerList[iter_9_0]:SetSelectedState(arg_9_0:GetEnhancedCount(iter_9_0))
	end

	arg_9_0.titleTxt_.text = GetI18NText(arg_9_0.modelCfg.chapter_name)
end

function var_0_0.UpdateData(arg_10_0)
	arg_10_0.modelData = MonsterCosplayData:GetDataByPara("monsterData")[arg_10_0.modelID]
	arg_10_0.modelCfg = ActivityMonsterCosplayCfg[arg_10_0.modelID]
	arg_10_0.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")
	arg_10_0.viewCoreSkillTable = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[arg_10_0.modelID]

	local var_10_0 = arg_10_0.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	arg_10_0.displayStr = arg_10_0.modelID == ActivityMonsterCosplayCfg.all[1] and "activity_monster_cosplay_bg_anjinshu" or "activity_monster_cosplay_bg_renma"

	for iter_10_0 = 1, 5 do
		arg_10_0["skillName" .. iter_10_0 .. "Icon_"] = arg_10_0["skillName" .. iter_10_0 .. "Icon" .. var_10_0 .. "_"]
		arg_10_0["skillName" .. iter_10_0 .. "Txt_"] = arg_10_0["skillName" .. iter_10_0 .. "Txt" .. var_10_0 .. "_"]
	end

	arg_10_0.controllerList = arg_10_0["controllerList" .. var_10_0]
	arg_10_0.titleTxt_ = arg_10_0["titleTxt" .. var_10_0 .. "_"]
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.modelID = arg_11_0.params_.modelID

	arg_11_0.modelController:SetSelectedState(tostring(arg_11_0.modelID))
	arg_11_0:UpdateData()
	arg_11_0:UpdateView()

	arg_11_0.exitView_ = false

	manager.ui:SetMainCamera("soloHeartDemon")
	arg_11_0:LoadModel()
	arg_11_0:InitBackScene()
	arg_11_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_12_0)
	local var_12_0 = arg_12_0.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	for iter_12_0 = 1, 5 do
		local var_12_1 = arg_12_0.modelCfg.skill_list[iter_12_0]

		manager.redPoint:bindUIandKey(arg_12_0["skill" .. iter_12_0 .. "Trs" .. var_12_0 .. "_"].transform, "MonsterCosPlay" .. var_12_1)
	end
end

function var_0_0.UnBindRedPoint(arg_13_0)
	local var_13_0 = arg_13_0.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	for iter_13_0 = 1, 5 do
		local var_13_1 = arg_13_0.modelCfg.skill_list[iter_13_0]

		manager.redPoint:unbindUIandKey(arg_13_0["skill" .. iter_13_0 .. "Trs" .. var_13_0 .. "_"].transform, "MonsterCosPlay" .. var_13_1)
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_14_0.showController:SetSelectedState("true")
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()

	arg_15_0.exitView_ = true

	manager.ui:ResetMainCamera()
	arg_15_0:UnloadModel()
	arg_15_0:DestroyBackScene()
	arg_15_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.LoadModel(arg_17_0)
	if arg_17_0.currentBossTemplateID == arg_17_0.modelID then
		return
	end

	arg_17_0:UnloadModel()

	arg_17_0.currentBossTemplateID = arg_17_0.modelID

	local var_17_0 = ActivityMonsterCosplayCfg[arg_17_0.modelID]

	arg_17_0.loadIndex = manager.resourcePool:AsyncLoad("MonsterCosplay/" .. var_17_0.model, ASSET_TYPE.TPOSE, function(arg_18_0)
		if arg_17_0.exitView_ or arg_17_0.currentBossTemplateID ~= arg_17_0.modelID then
			manager.resourcePool:DestroyOrReturn(arg_18_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_18_0 = var_17_0.model_pos
		local var_18_1 = var_17_0.model_rot
		local var_18_2 = var_17_0.model_scale

		arg_17_0.bossModel = arg_18_0
		arg_17_0.animator = arg_17_0.bossModel.transform:Find("ani_panel"):GetComponent("Animator")

		arg_17_0.animator:Play("skill01_back")

		local var_18_3 = arg_17_0.bossModel.transform:Find("ani_panel/Model")

		var_18_3.transform.localPosition = Vector3(var_18_0[1], var_18_0[2], var_18_0[3])
		var_18_3.transform.localEulerAngles = Vector3(var_18_1[1], var_18_1[2], var_18_1[3])
		var_18_3.transform.localScale = Vector3(var_18_2[1], var_18_2[2], var_18_2[3])
	end)
end

function var_0_0.InitBackScene(arg_19_0)
	local var_19_0 = "UI/Common/MonsterCosplayBackgroundQuad"
	local var_19_1 = GameDisplayCfg[arg_19_0.displayStr]
	local var_19_2 = ActivityMonsterCosplayCfg[arg_19_0.modelID]

	arg_19_0.backGround_ = manager.resourcePool:Get(var_19_0, ASSET_TYPE.SCENE)
	arg_19_0.backGroundTrs_ = arg_19_0.backGround_.transform

	arg_19_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_19_3 = var_19_1.value

	arg_19_0.backGroundTrs_.localPosition = Vector3(var_19_3[1], var_19_3[2], var_19_3[3])
	arg_19_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_19_4 = var_19_1.scale

	arg_19_0.backGroundTrs_.localScale = Vector3(var_19_4[1], var_19_4[2], var_19_4[3])
	arg_19_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(var_19_2.bg_pic)
end

function var_0_0.DestroyBackScene(arg_20_0)
	if arg_20_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_20_0.backGround_, ASSET_TYPE.SCENE)

		arg_20_0.backGround_ = nil
	end
end

function var_0_0.UnloadModel(arg_21_0)
	if arg_21_0.bossModel ~= nil then
		manager.resourcePool:DestroyOrReturn(arg_21_0.bossModel, ASSET_TYPE.TPOSE)

		arg_21_0.bossModel = nil

		manager.resourcePool:StopAsyncQuest(arg_21_0.loadIndex)

		arg_21_0.loadIndex = nil
		arg_21_0.currentBossTemplateID = nil
	end
end

function var_0_0.GetEnhancedCount(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.skillToAffixTable[arg_22_0.modelCfg.skill_list[arg_22_1]] or {}) do
		if arg_22_0.modelData.enhancedSkill[iter_22_1] and TalentTreeCfg[iter_22_1].type == 2 then
			var_22_0 = var_22_0 + 1
		elseif TalentTreeCfg[iter_22_1].type == 1 and arg_22_0.viewCoreSkillTable[iter_22_1] then
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

return var_0_0
