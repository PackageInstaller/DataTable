local MonsterCosplaySkillUpView = class("MonsterCosplaySkillUpView", ReduxView)

function MonsterCosplaySkillUpView:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayAffixPopUI"
end

function MonsterCosplaySkillUpView:UIParent()
	return manager.ui.uiPop.transform
end

function MonsterCosplaySkillUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonsterCosplaySkillUpView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.indexItem), self.uiListGo_, MonsterCosplaySkillUpItem)
	self.skillList = LuaList.New(handler(self, self.skillIndexItem), self.skillListGo_, MonsterCosplaySkillShowItem)
	self.btnController = self.controller_:GetController("btn")
	self.coreController = self.controller_:GetController("core")
	self.titleController = self.controller_:GetController("title")
	self.skillInfoController = self.controller_:GetController("skillinfo")
	self.mainController = self.mainController_:GetController("place")
	self.colorController = self.mainController_:GetController("state2")
	self.color2Controller = self.mainController_:GetController("state3")
end

function MonsterCosplaySkillUpView:AddUIListener()
	self:AddBtnListener(self.sureBtn_, nil, function()
		if self.isCoreSkill then
			MonsterCosplayAction.ViewMonsterSkill(self.monsterID, self.coreSkillID)

			return
		end

		if self.selectID == nil then
			ShowTips("ACTIVITY_MONSTER_COSPLAY_NO_CHOOSE_ERROR")

			return
		end

		MonsterCosplayAction.UpdateMonsterSkill(self.monsterID, self.affixList[self.selectID])
	end)
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("/MonsterCosplayMonster", {
			modelID = self.monsterID
		})
	end)
	self:AddBtnListener(self.tipsMaskBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.coreAffix then
			MonsterCosplayAction.ViewMonsterSkill(self.monsterID, self.coreAffix)
		end
	end)
end

function MonsterCosplaySkillUpView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.affixList[arg_10_1], handler(self, self.ClickFunction), arg_10_1, self.monsterData, self.monsterID)
end

function MonsterCosplaySkillUpView:skillIndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(ActivityMonsterCosplaySkillCfg[TalentTreeCfg[self.coreAffix].stage].affix_effect_skill_list[arg_11_1], arg_11_1, handler(self, self.ClickSkillCallBack))
end

function MonsterCosplaySkillUpView:OnMonsterCoreSkill(arg_12_1)
	self:Back()

	if arg_12_1 == 0 then
		return
	end

	self.params_.coreAffixID = nil
	self.coreAffix = nil
end

function MonsterCosplaySkillUpView:ClickFunction(arg_13_1, arg_13_2)
	if arg_13_2:GetSelectedState() == "get" or arg_13_2:GetSelectedState() == "sel" then
		return
	end

	if self.controller == nil then
		self.controller = arg_13_2

		self.controller:SetSelectedState("sel")
	else
		self.controller:SetSelectedState("normal")

		self.controller = arg_13_2
	end

	if self.selectID ~= arg_13_1 then
		self.selectID = arg_13_1

		self.controller:SetSelectedState("sel")
	end

	self.btnController:SetSelectedState("true")
end

function MonsterCosplaySkillUpView:OnMonsterSkillUp()
	ShowTips("SUCCESS_STRENGTHEN")
	self:Back()
end

function MonsterCosplaySkillUpView:UpdateBar()
	return
end

function MonsterCosplaySkillUpView:ClickSkillCallBack(arg_16_1, arg_16_2, arg_16_3)
	SetActive(self.tipsGo_, true)

	self.tipsGo_.transform.position = arg_16_1.transform.position
	self.tipsGo_.transform.anchoredPosition = Vector2(self.tipsGo_.transform.anchoredPosition.x - self.tipsGo_.transform.rect.width / 2 - arg_16_1.transform.rect.width, self.tipsGo_.transform.anchoredPosition.y)
	self.skillDescTxt_.text = arg_16_3 == 1 and GetI18NText(arg_16_2.skill_start_description) or GetI18NText(arg_16_2.skill_new_description)
	self.skillNameTxt_.text = GetI18NText(arg_16_2.skill_name)
end

function MonsterCosplaySkillUpView:UpdateView()
	self.coreController:SetSelectedState(tostring(self.isCoreSkill))
	self.titleController:SetSelectedState(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")

	if self.isCoreSkill then
		local var_17_0 = TalentTreeCfg[self.coreAffix]
		local var_17_1 = ActivityMonsterCosplaySkillCfg[TalentTreeCfg[self.coreAffix].stage]

		self.skillInfoController:SetSelectedState(tostring(#ActivityMonsterCosplaySkillCfg[TalentTreeCfg[self.coreAffix].stage].affix_effect_skill_list == 0))
		self.btnController:SetSelectedState("true")
		self.skillList:StartScroll(#var_17_1.affix_effect_skill_list)

		self.skillDesc_.text = GetI18NText(var_17_0.desc)
		self.skillName_.text = GetI18NText(var_17_0.name)
		self.affixDesc_.text = GetI18NText(var_17_1.affix_effect_skill_desc)
		self.coreSkillIndexTxt_.text = GetI18NText(var_17_1.skill_index) or ""
		self.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(self.coreAffix)

		self.mainController:SetSelectedState(tostring(table.indexof(ActivityMonsterCosplayCfg[self.monsterID].skill_list, self.coreSkillID)))
		TimeTools.StartAfterSeconds(0.6, function()
			SetActive(self.affixGo_, true)

			if #var_17_1.affix_effect_skill_list ~= 0 then
				local var_18_0 = LeanTween.value(self.affixGo_, 0, -290, 0.25)

				var_18_0:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					self.affixGo_.transform.anchoredPosition = Vector2(arg_19_0, 0)
				end))
				var_18_0:setOnComplete(System.Action(function()
					LeanTween.cancel(self.affixGo_)
					var_18_0:setOnUpdate(nil):setOnComplete(nil)
				end))
			end
		end, {})
	else
		self.list:StartScroll(#self.affixList)
	end

	self.colorController:SetSelectedState(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
	self.color2Controller:SetSelectedState(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "1" or "2")
end

function MonsterCosplaySkillUpView:UpdateData()
	self.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")
	self.affixList = {}

	for iter_21_0, iter_21_1 in ipairs(ActivityMonsterCosplayCfg[self.monsterID].skill_list) do
		if self.skillToAffixTable[iter_21_1] ~= nil then
			for iter_21_2, iter_21_3 in ipairs(self.skillToAffixTable[iter_21_1]) do
				if TalentTreeCfg[iter_21_3].type == 2 then
					table.insert(self.affixList, iter_21_3)
				end
			end
		end
	end

	self.isCoreSkill = self.params_.coreAffixID ~= nil
	self.coreAffix = self.params_.coreAffixID

	if self.coreAffix then
		self.coreSkillID = TalentTreeCfg[self.coreAffix].stage
	end

	self.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[self.monsterID]

	table.sort(self.affixList, function(arg_22_0, arg_22_1)
		local var_22_0 = self.monsterData.enhancedSkill[arg_22_0]

		if self.monsterData.enhancedSkill[arg_22_0] == self.monsterData.enhancedSkill[arg_22_1] then
			return arg_22_1 < arg_22_0
		else
			return var_22_0 == nil
		end
	end)
end

function MonsterCosplaySkillUpView:OnEnter()
	self.selectID = nil
	self.monsterID = self.params_.modelID

	SetActive(self.affixGo_, false)
	self.btnController:SetSelectedState("false")
	self:UpdateData()
	self:UpdateView()
	SetActive(self.tipsGo_, false)
end

function MonsterCosplaySkillUpView:OnExit()
	self.selectID = nil
	self.monsterID = nil
	self.controller = nil
	self.params_.isCoreSkill = nil
end

function MonsterCosplaySkillUpView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	if self.skillList then
		self.skillList:Dispose()

		self.skillList = nil
	end

	MonsterCosplaySkillUpView.super.Dispose(self)
end

return MonsterCosplaySkillUpView
