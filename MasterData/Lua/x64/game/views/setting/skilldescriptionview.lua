local SkillDescriptionView = class("SkillDescriptionView", ReduxView)

function SkillDescriptionView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function SkillDescriptionView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.stageData = arg_2_3

	self:Init()
end

function SkillDescriptionView:IsInTable(arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if iter_3_1 == arg_3_1 then
			return true, iter_3_0
		end
	end

	return false
end

function SkillDescriptionView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function SkillDescriptionView:GetSkills(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = HeroCfg[arg_5_1]
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(HeroCfg[arg_5_1].equip_orange_skill) do
		if self:IsInTable(arg_5_2.weaponEffectID, WeaponServantCfg[iter_5_1[2]].effect) then
			var_5_1[iter_5_1[1]] = iter_5_1[3]
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0.astrolabe_skill) do
		for iter_5_4 = 0, arg_5_2.astrolabe.Length - 1 do
			if iter_5_3[2] == arg_5_2.astrolabe[iter_5_4] then
				var_5_1[iter_5_3[1]] = iter_5_3[3]

				break
			end
		end
	end

	local var_5_2 = self.stageData:GetType()
	local var_5_3 = {}
	local var_5_4 = {}

	if var_5_2 and (BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_5_2 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_5_2 or BattleConst.STAGE_TYPE_NEW.POLYHEDRON == var_5_2) then
		var_5_3 = self.stageData:GetSystemHeroTeam()
		var_5_4 = var_5_3
	else
		var_5_3, var_5_4 = self.stageData:GetHeroTeam()
	end

	local var_5_5

	if var_5_4[1] ~= nil and var_5_4[1] > 0 then
		var_5_5 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

		var_5_5:SetTempHeroList({
			var_5_4[1]
		})
	elseif var_5_3[1] ~= nil and var_5_3[1] > 0 then
		var_5_5 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

		var_5_5:SetTempHeroList({
			var_5_3[1]
		})
	end

	local var_5_6 = {}

	if ActivityMonsterCosplayCfg[arg_5_1] and self.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY then
		for iter_5_5, iter_5_6 in ipairs(ActivityMonsterCosplayCfg[arg_5_1].skill_list) do
			local var_5_7 = {
				id = iter_5_6,
				desc = ActivityMonsterCosplaySkillCfg[iter_5_6].skill_start_description,
				sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. ActivityMonsterCosplaySkillCfg[iter_5_6].skill_start_icon)
			}

			var_5_7.desc = string.gsub(var_5_7.desc, "\n\n", "\n")
			var_5_7.name = ActivityMonsterCosplaySkillCfg[iter_5_6].skill_name
			var_5_7.type = var_5_0.skill_subhead[iter_5_5]

			table.insert(var_5_6, var_5_7)
		end
	else
		for iter_5_7, iter_5_8 in ipairs(var_5_0.skills) do
			if iter_5_8 ~= 0 then
				local var_5_8 = {
					id = iter_5_8
				}

				if var_5_1[iter_5_8] then
					var_5_8.id = var_5_1[iter_5_8]
				end

				var_5_8.desc = var_5_5:GetSkillDesc(var_5_8.id, (not SkillTools.GetIsDodgeSkill(var_5_8.id) or nil) and arg_5_2.skillLevel[iter_5_7 - 1], true)
				var_5_8.desc = string.gsub(var_5_8.desc, "\n\n", "\n")

				if not HeroSkillCfg[var_5_8.id] then
					CustomLog.Log(debug.traceback(string.format("nil")))
				end

				var_5_8.name = HeroSkillCfg[var_5_8.id].name
				var_5_8.ele = HeroSkillCfg[var_5_8.id].element_type
				var_5_8.sprite = getSprite("Atlas/" .. arg_5_1, var_5_8.id)
				var_5_8.subType = PublicSkillCfg[var_5_8.id].skill_sub_type

				if var_5_8.subType == nil then
					var_5_8.subType = 0
				end

				var_5_8.subType = SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[var_5_8.subType][1]].annotation
				var_5_8.type = var_5_0.skill_subhead[iter_5_7]

				table.insert(var_5_6, var_5_8)
			end
		end
	end

	return var_5_6
end

function SkillDescriptionView:RefreshSkills()
	for iter_6_0, iter_6_1 in ipairs(self.skillExplainList_) do
		iter_6_1:Show(false)
	end

	for iter_6_2, iter_6_3 in ipairs(self.skills) do
		if self.skillExplainList_[iter_6_2] == nil then
			self.skillExplainList_[iter_6_2] = SkillExplainItem.New((Object.Instantiate(self.explainSkillTplGo_, self.suitcontentSkillTrs_)))
		end

		self.skillExplainList_[iter_6_2]:Show(true)
		self.skillExplainList_[iter_6_2]:RefreshData(iter_6_3)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentSkillTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentSkillTrs_)

	self.timerSkill_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentSkillTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentSkillTrs_)
	end, 1, 1)

	self.timerSkill_:Start()
end

function SkillDescriptionView:GetRecommendCombo(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(HeroCfg[arg_8_1].recommend_combo) do
		table.insert(var_8_0, SkillComboRecommenderCfg[iter_8_1])
	end

	return var_8_0
end

function SkillDescriptionView:RefreshCombos(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.skillComboList_) do
		iter_9_1:Show(false)
	end

	for iter_9_2, iter_9_3 in ipairs(self.combos) do
		if self.skillComboList_[iter_9_2] == nil then
			self.skillComboList_[iter_9_2] = SkillComboItem.New((Object.Instantiate(self.explainComboTplGo_, self.suitcontentComboTrs_)))
		end

		self.skillComboList_[iter_9_2]:Show(true)
		self.skillComboList_[iter_9_2]:RefreshData(iter_9_3, arg_9_1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentSkillTrs_)
end

function SkillDescriptionView:InitUI()
	self:BindCfgUI()

	self.skillExplainList_ = {}
	self.skillComboList_ = {}
	self.explainController = ControllerUtil.GetController(self.explainGo_.transform, "name")
	self.technicController = ControllerUtil.GetController(self.technicGo_.transform, "name")
	self.nType = 1

	local var_10_0 = GetSceneDataForExcehange().roleDataInLua[0]
	local var_10_1 = SkinCfg[var_10_0.ID].hero

	if SkinCfg[var_10_0.ID].hero == 10079 or var_10_1 == 10025 then
		return
	end

	if self.stageData and self.stageData:GetIsCooperation() then
		local var_10_2 = PlayerData:GetPlayerInfo().userID

		for iter_10_0, iter_10_1 in ipairs((self.stageData:GetRoleDatas())) do
			if tostring(iter_10_1.UID) == tostring(var_10_2) then
				var_10_1 = SkinCfg[iter_10_1.ID].hero
			end
		end
	end

	self.skills = self:GetSkills(var_10_1, var_10_0)

	self:RefreshSkills()

	self.combos = self:GetRecommendCombo(var_10_1)

	self:RefreshCombos(var_10_1)
end

function SkillDescriptionView:AddUIListener()
	self:AddToggleListener(self.explainTgl_, function(arg_12_0)
		SetActive(self.skillpanelGo_, arg_12_0)
		self.explainController:SetSelectedIndex(arg_12_0 and 0 or 1)
		self.technicController:SetSelectedIndex(arg_12_0 and 1 or 0)

		if arg_12_0 then
			OperationRecorder.Record("battle", "skillExplain")

			if self.hander_.RecordStaySkill then
				self.hander_:RecordStaySkill(2)
			end

			self.nType = 1
		end
	end)
	self:AddToggleListener(self.technicTgl_, function(arg_13_0)
		SetActive(self.recommendpanelGo_, arg_13_0)
		self.explainController:SetSelectedIndex(arg_13_0 and 1 or 0)
		self.technicController:SetSelectedIndex(arg_13_0 and 0 or 1)

		if arg_13_0 then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentComboTrs_)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.suitcontentComboTrs_)
			OperationRecorder.Record("battle", "recommend")

			if self.hander_.RecordStaySkill then
				self.hander_:RecordStaySkill(1)
			end

			self.nType = 2
		end
	end)
end

function SkillDescriptionView:OnEnter()
	local var_14_0 = SkinCfg[GetSceneDataForExcehange().roleDataInLua[0].ID].hero

	self.explainTgl_.isOn = true

	SetActive(self.technicGo_, self.stageData:GetType() ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY)
end

function SkillDescriptionView:Dispose()
	SkillDescriptionView.super.Dispose(self)

	if self.timerSkill_ then
		self.timerSkill_:Stop()
	end

	for iter_15_0, iter_15_1 in pairs(self.skillExplainList_) do
		iter_15_1:Dispose()
	end

	self.skillExplainList_ = {}

	for iter_15_2, iter_15_3 in pairs(self.skillComboList_) do
		iter_15_3:Dispose()
	end

	self.skillComboList_ = {}
	self.hander_ = nil
	self.data = nil
end

return SkillDescriptionView
