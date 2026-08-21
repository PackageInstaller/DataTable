local var_0_0 = class("SkillDescriptionView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.stageData = arg_2_3

	arg_2_0:Init()
end

function var_0_0.IsInTable(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if iter_3_1 == arg_3_1 then
			return true, iter_3_0
		end
	end

	return false
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
	arg_4_0:OnEnter()
end

function var_0_0.GetSkills(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = HeroCfg[arg_5_1]
	local var_5_1 = arg_5_2.weaponEffectID
	local var_5_2 = arg_5_2.astrolabe
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0.equip_orange_skill) do
		if arg_5_0:IsInTable(var_5_1, WeaponServantCfg[iter_5_1[2]].effect) then
			var_5_3[iter_5_1[1]] = iter_5_1[3]
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0.astrolabe_skill) do
		for iter_5_4 = 0, var_5_2.Length - 1 do
			if iter_5_3[2] == var_5_2[iter_5_4] then
				var_5_3[iter_5_3[1]] = iter_5_3[3]

				break
			end
		end
	end

	local var_5_4 = arg_5_0.stageData:GetType()
	local var_5_5 = {}
	local var_5_6 = {}

	if var_5_4 and (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_5_4 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_5_4 or BattleConst.STAGE_TYPE_NEW.POLYHEDRON == var_5_4) then
		var_5_5 = arg_5_0.stageData:GetSystemHeroTeam()
		var_5_6 = var_5_5
	else
		var_5_5, var_5_6 = arg_5_0.stageData:GetHeroTeam()
	end

	local var_5_7

	if var_5_6[1] ~= nil and var_5_6[1] > 0 then
		var_5_7 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

		var_5_7:SetTempHeroList({
			var_5_6[1]
		})
	elseif var_5_5[1] ~= nil and var_5_5[1] > 0 then
		var_5_7 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

		var_5_7:SetTempHeroList({
			var_5_5[1]
		})
	end

	local var_5_8 = {}

	if ActivityMonsterCosplayCfg[arg_5_1] and arg_5_0.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY then
		local var_5_9 = ActivityMonsterCosplayCfg[arg_5_1]

		for iter_5_5, iter_5_6 in ipairs(var_5_9.skill_list) do
			local var_5_10 = ActivityMonsterCosplaySkillCfg[iter_5_6]
			local var_5_11 = {
				id = iter_5_6,
				desc = var_5_10.skill_start_description,
				sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. var_5_10.skill_start_icon)
			}

			var_5_11.desc = string.gsub(var_5_11.desc, "\n\n", "\n")
			var_5_11.name = var_5_10.skill_name
			var_5_11.type = var_5_0.skill_subhead[iter_5_5]

			table.insert(var_5_8, var_5_11)
		end
	else
		for iter_5_7, iter_5_8 in ipairs(var_5_0.skills) do
			if iter_5_8 ~= 0 then
				local var_5_12 = {
					id = iter_5_8
				}

				if var_5_3[iter_5_8] then
					var_5_12.id = var_5_3[iter_5_8]
				end

				local var_5_13 = SkillTools.GetIsDodgeSkill(var_5_12.id)
				local var_5_14 = 1

				if not var_5_13 then
					var_5_14 = arg_5_2.skillLevel[iter_5_7 - 1]
				end

				var_5_12.desc = var_5_7:GetSkillDesc(var_5_12.id, var_5_14, true)
				var_5_12.desc = string.gsub(var_5_12.desc, "\n\n", "\n")

				if not HeroSkillCfg[var_5_12.id] then
					CustomLog.Log(debug.traceback(string.format("nil")))
				end

				var_5_12.name = HeroSkillCfg[var_5_12.id].name
				var_5_12.ele = HeroSkillCfg[var_5_12.id].element_type
				var_5_12.sprite = getSprite("Atlas/" .. arg_5_1, var_5_12.id)
				var_5_12.subType = PublicSkillCfg[var_5_12.id].skill_sub_type

				if var_5_12.subType == nil then
					var_5_12.subType = 0
				end

				local var_5_15 = SkillSubTypeCfg.get_id_list_by_value[var_5_12.subType]

				var_5_12.subType = SkillSubTypeCfg[var_5_15[1]].annotation
				var_5_12.type = var_5_0.skill_subhead[iter_5_7]

				table.insert(var_5_8, var_5_12)
			end
		end
	end

	return var_5_8
end

function var_0_0.RefreshSkills(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.skillExplainList_) do
		iter_6_1:Show(false)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.skills) do
		if arg_6_0.skillExplainList_[iter_6_2] == nil then
			local var_6_0 = Object.Instantiate(arg_6_0.explainSkillTplGo_, arg_6_0.suitcontentSkillTrs_)

			arg_6_0.skillExplainList_[iter_6_2] = SkillExplainItem.New(var_6_0)
		end

		arg_6_0.skillExplainList_[iter_6_2]:Show(true)
		arg_6_0.skillExplainList_[iter_6_2]:RefreshData(iter_6_3)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.suitcontentSkillTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.suitcontentSkillTrs_)

	arg_6_0.timerSkill_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.suitcontentSkillTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.suitcontentSkillTrs_)
	end, 1, 1)

	arg_6_0.timerSkill_:Start()
end

function var_0_0.GetRecommendCombo(arg_8_0, arg_8_1)
	local var_8_0 = HeroCfg[arg_8_1]
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.recommend_combo) do
		local var_8_2 = SkillComboRecommenderCfg[iter_8_1]

		table.insert(var_8_1, var_8_2)
	end

	return var_8_1
end

function var_0_0.RefreshCombos(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.skillComboList_) do
		iter_9_1:Show(false)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.combos) do
		if arg_9_0.skillComboList_[iter_9_2] == nil then
			local var_9_0 = Object.Instantiate(arg_9_0.explainComboTplGo_, arg_9_0.suitcontentComboTrs_)

			arg_9_0.skillComboList_[iter_9_2] = SkillComboItem.New(var_9_0)
		end

		arg_9_0.skillComboList_[iter_9_2]:Show(true)
		arg_9_0.skillComboList_[iter_9_2]:RefreshData(iter_9_3, arg_9_1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.suitcontentSkillTrs_)
end

function var_0_0.InitUI(arg_10_0)
	arg_10_0:BindCfgUI()

	arg_10_0.skillExplainList_ = {}
	arg_10_0.skillComboList_ = {}
	arg_10_0.explainController = ControllerUtil.GetController(arg_10_0.explainGo_.transform, "name")
	arg_10_0.technicController = ControllerUtil.GetController(arg_10_0.technicGo_.transform, "name")
	arg_10_0.nType = 1

	local var_10_0 = GetSceneDataForExcehange().roleDataInLua[0]
	local var_10_1 = SkinCfg[var_10_0.ID].hero

	if var_10_1 == 10079 or var_10_1 == 10025 then
		return
	end

	if arg_10_0.stageData and arg_10_0.stageData:GetIsCooperation() then
		local var_10_2 = PlayerData:GetPlayerInfo().userID
		local var_10_3 = arg_10_0.stageData:GetRoleDatas()

		for iter_10_0, iter_10_1 in ipairs(var_10_3) do
			if tostring(iter_10_1.UID) == tostring(var_10_2) then
				var_10_1 = SkinCfg[iter_10_1.ID].hero
			end
		end
	end

	arg_10_0.skills = arg_10_0:GetSkills(var_10_1, var_10_0)

	arg_10_0:RefreshSkills()

	arg_10_0.combos = arg_10_0:GetRecommendCombo(var_10_1)

	arg_10_0:RefreshCombos(var_10_1)
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddToggleListener(arg_11_0.explainTgl_, function(arg_12_0)
		SetActive(arg_11_0.skillpanelGo_, arg_12_0)
		arg_11_0.explainController:SetSelectedIndex(arg_12_0 and 0 or 1)
		arg_11_0.technicController:SetSelectedIndex(arg_12_0 and 1 or 0)

		if arg_12_0 then
			OperationRecorder.Record("battle", "skillExplain")

			if arg_11_0.hander_.RecordStaySkill then
				arg_11_0.hander_:RecordStaySkill(2)
			end

			arg_11_0.nType = 1
		end
	end)
	arg_11_0:AddToggleListener(arg_11_0.technicTgl_, function(arg_13_0)
		SetActive(arg_11_0.recommendpanelGo_, arg_13_0)
		arg_11_0.explainController:SetSelectedIndex(arg_13_0 and 1 or 0)
		arg_11_0.technicController:SetSelectedIndex(arg_13_0 and 0 or 1)

		if arg_13_0 then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.suitcontentComboTrs_)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.suitcontentComboTrs_)
			OperationRecorder.Record("battle", "recommend")

			if arg_11_0.hander_.RecordStaySkill then
				arg_11_0.hander_:RecordStaySkill(1)
			end

			arg_11_0.nType = 2
		end
	end)
end

function var_0_0.OnEnter(arg_14_0)
	local var_14_0 = GetSceneDataForExcehange().roleDataInLua[0]
	local var_14_1 = SkinCfg[var_14_0.ID].hero

	arg_14_0.explainTgl_.isOn = true

	SetActive(arg_14_0.technicGo_, arg_14_0.stageData:GetType() ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.timerSkill_ then
		arg_15_0.timerSkill_:Stop()
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.skillExplainList_) do
		iter_15_1:Dispose()
	end

	arg_15_0.skillExplainList_ = {}

	for iter_15_2, iter_15_3 in pairs(arg_15_0.skillComboList_) do
		iter_15_3:Dispose()
	end

	arg_15_0.skillComboList_ = {}
	arg_15_0.hander_ = nil
	arg_15_0.data = nil
end

return var_0_0
