local MonsterCosplaySkillInfoView = class("MonsterCosplaySkillInfoView", ReduxView)

function MonsterCosplaySkillInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStructureInfoUI"
end

function MonsterCosplaySkillInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function MonsterCosplaySkillInfoView:Init()
	self:InitUI()
	self:AddListeners()
end

function MonsterCosplaySkillInfoView:OnEnter()
	self:UpdateData()
	self:UpdateView()
	self:UpdateBar()
	SetActive(self.tipsGo_, false)
end

function MonsterCosplaySkillInfoView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MonsterCosplaySkillInfoView:OnExit()
	self.animator:Play("skill0" .. self.index .. "_back")

	self.coreSkillCfg = nil

	manager.windowBar:HideBar()
end

function MonsterCosplaySkillInfoView:InitUI()
	self:BindCfgUI()

	self.upController = self.controller_:GetController("up")
	self.upNumController = self.controller_:GetController("upNum")
	self.cdController = self.controller_:GetController("cd")
	self.partController = self.controller_:GetController("part")
	self.stateController = self.controller_:GetController("state")
	self.controllerList = {
		{
			skill1Controller = self.skill11Controller_:GetController("state"),
			skill2Controller = self.skill12Controller_:GetController("state")
		},
		{
			skill1Controller = self.skill21Controller_:GetController("state"),
			skill2Controller = self.skill22Controller_:GetController("state")
		}
	}
end

function MonsterCosplaySkillInfoView:AddListeners()
	self:AddBtnListenerScale(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale(self.tipsBgBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)

	for iter_8_0 = 1, 8 do
		self:AddBtnListenerScale(self["skill1" .. iter_8_0 .. "Btn_"], nil, function()
			SetActive(self.tipsGo_, true)

			local var_11_0 = ActivityMonsterCosplaySkillCfg[self.coreSkillCfg.affix_effect_skill_list[math.ceil(iter_8_0 / 2)]]

			self.tipsGo_.transform.position = self["skill1" .. iter_8_0 .. "Btn_"].transform.position
			self.tipsGo_.transform.anchoredPosition = Vector2(self.tipsGo_.transform.anchoredPosition.x - self.tipsGo_.transform.rect.width / 2 - self["skill1" .. iter_8_0 .. "Btn_"].transform.rect.width, self.tipsGo_.transform.anchoredPosition.y)

			if iter_8_0 % 2 == 1 then
				self.tipsSkillNameTxt_.text = GetI18NText(var_11_0.skill_name)
				self.tipsSkillDescTxt_.text = GetI18NText(var_11_0.skill_start_description)
			else
				self.tipsSkillNameTxt_.text = GetI18NText(var_11_0.skill_name)
				self.tipsSkillDescTxt_.text = GetI18NText(var_11_0.skill_new_description)
			end
		end)
		self:AddBtnListenerScale(self["skill2" .. iter_8_0 .. "Btn_"], nil, function()
			self.tipsGo_.transform.position = self["skill2" .. iter_8_0 .. "Btn_"].transform.position
			self.tipsGo_.transform.anchoredPosition = Vector2(self.tipsGo_.transform.anchoredPosition.x - self.tipsGo_.transform.rect.width / 2 - self["skill1" .. iter_8_0 .. "Btn_"].transform.rect.width, self.tipsGo_.transform.anchoredPosition.y)

			SetActive(self.tipsGo_, true)

			local var_12_0 = ActivityMonsterCosplaySkillCfg[self.coreSkillCfg.affix_effect_skill_list[math.ceil(iter_8_0 / 2)]]

			if iter_8_0 % 2 == 1 then
				self.tipsSkillNameTxt_.text = GetI18NText(var_12_0.skill_name)
				self.tipsSkillDescTxt_.text = GetI18NText(var_12_0.skill_start_description)
			else
				self.tipsSkillNameTxt_.text = GetI18NText(var_12_0.skill_name)
				self.tipsSkillDescTxt_.text = GetI18NText(var_12_0.skill_new_description)
			end
		end)
	end
end

function MonsterCosplaySkillInfoView:UpdateData()
	self.skillID = self.params_.monsterSkill
	self.modelID = self.params_.modelID
	self.index = self.params_.index
	self.animator = self.params_.animator
	self.isCoreData = self.params_.isCoreData
	self.cfg = ActivityMonsterCosplaySkillCfg[self.skillID]
	self.modelData = MonsterCosplayData:GetDataByPara("monsterData")[self.modelID]
	self.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")[self.skillID] or {}
	self.viewCoreSkillTable = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[self.modelID]

	local var_13_0 = self.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	self.stateController:SetSelectedState(tostring(self.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2))

	self.cdTxt_ = self["cdTxt" .. var_13_0 .. "_"]
	self.descTxt_ = self["descTxt" .. var_13_0 .. "_"]
	self.skillNameTxt_ = self["skillNameTxt" .. var_13_0 .. "_"]
	self.skillIcon_ = self["skillIcon" .. var_13_0 .. "_"]
	self.controller = self.controllerList[var_13_0]

	for iter_13_0 = 1, 2 do
		self["skill" .. iter_13_0 .. "Icon_"] = self["skill" .. var_13_0 .. iter_13_0 .. "Icon_"]
		self["skill" .. iter_13_0 .. "DescTxt_"] = self["skill" .. var_13_0 .. iter_13_0 .. "DescTxt_"]
		self["skill" .. iter_13_0 .. "IndexTxt_"] = self["skill" .. var_13_0 .. iter_13_0 .. "IndexTxt_"]
		self["lock" .. iter_13_0 .. "Txt_"] = self["lock" .. var_13_0 .. iter_13_0 .. "Txt_"]
	end

	for iter_13_1 = 1, 4 do
		self["core" .. iter_13_1 .. "Go_"] = self["core" .. var_13_0 .. iter_13_1 .. "Go_"]
		self["core" .. iter_13_1 .. "Txt_"] = self["core" .. var_13_0 .. iter_13_1 .. "Txt_"]
		self["core" .. iter_13_1 .. "normalIcon_"] = self["core" .. var_13_0 .. iter_13_1 .. "normalIcon_"]
		self["core" .. iter_13_1 .. "upIcon_"] = self["core" .. var_13_0 .. iter_13_1 .. "upIcon_"]
	end
end

function MonsterCosplaySkillInfoView:UpdateView()
	self.cdController:SetSelectedState(tostring(self.cfg.skill_cd ~= "0"))

	self.cdTxt_.text = self.cfg.skill_cd
	self.skillNameTxt_.text = self.cfg.skill_name
	self.descTxt_.text = self.cfg.skill_start_description

	self.partController:SetSelectedState(tostring(self.index))
	self.upNumController:SetSelectedState(#self.skillToAffixTable)
	self.upController:SetSelectedState(tostring(self:GetEnhancedCount()))
	SetActive(self.upGo_, #self.skillToAffixTable ~= 0)

	for iter_14_0 = 1, 4 do
		SetActive(self["core" .. iter_14_0 .. "Go_"], false)
	end

	for iter_14_1 = 1, 2 do
		local var_14_0 = TalentTreeCfg[self.skillToAffixTable[iter_14_1]]

		if self.skillToAffixTable[iter_14_1] == nil then
			self.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("none")
		else
			if self.viewCoreSkillTable[self.skillToAffixTable[iter_14_1]] then
				self.coreSkillCfg = ActivityMonsterCosplaySkillCfg[var_14_0.stage]

				for iter_14_2 = 1, 4 do
					if iter_14_2 <= #self.coreSkillCfg.affix_effect_skill_list then
						self["core" .. iter_14_2 .. "Txt_"].text = GetI18NText(ActivityMonsterCosplaySkillCfg[self.coreSkillCfg.affix_effect_skill_list[iter_14_2]].skill_name)
						self["core" .. iter_14_2 .. "normalIcon_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. ActivityMonsterCosplaySkillCfg[self.coreSkillCfg.affix_effect_skill_list[iter_14_2]].skill_start_icon)
						self["core" .. iter_14_2 .. "upIcon_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. ActivityMonsterCosplaySkillCfg[self.coreSkillCfg.affix_effect_skill_list[iter_14_2]].skill_new_icon)
					end

					SetActive(self["core" .. iter_14_2 .. "Go_"], iter_14_2 <= #self.coreSkillCfg.affix_effect_skill_list)
				end
			end

			if self.modelData.enhancedSkill[self.skillToAffixTable[iter_14_1]] == nil and self.viewCoreSkillTable[self.skillToAffixTable[iter_14_1]] ~= true then
				self.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("lock")

				self["lock" .. iter_14_1 .. "Txt_"].text = self.modelID == ActivityMonsterCosplayCfg.all[1] and GetTips("ACTIVITY_MONSTER_COSPLAY_ANJINSHU_TALENT_PUTONG_TIPS") or GetTips("ACTIVITY_MONSTER_COSPLAY_RENMA_TALENT_PUTONG_TIPS")

				if var_14_0.type == 1 then
					self["lock" .. iter_14_1 .. "Txt_"].text = ConditionCfg[var_14_0.unlock_condition[1]].desc
				end
			else
				self.controller["skill" .. iter_14_1 .. "Controller"]:SetSelectedState("get1")

				self["skill" .. iter_14_1 .. "DescTxt_"].text = GetI18NText(var_14_0.desc)
				self["skill" .. iter_14_1 .. "Icon_"].sprite = MonsterCosplayData.GetAffixSprite(self.skillToAffixTable[iter_14_1])
			end
		end
	end

	self.skillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. self.cfg.skill_start_icon)
end

function MonsterCosplaySkillInfoView:Dispose()
	MonsterCosplaySkillInfoView.super.Dispose(self)
end

function MonsterCosplaySkillInfoView:GetEnhancedCount()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(self.skillToAffixTable) do
		if self.modelData.enhancedSkill[iter_16_1] and TalentTreeCfg[iter_16_1].type == 2 then
			var_16_0 = var_16_0 + 1
		elseif TalentTreeCfg[iter_16_1].type == 1 and self.viewCoreSkillTable[iter_16_1] then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

return MonsterCosplaySkillInfoView
