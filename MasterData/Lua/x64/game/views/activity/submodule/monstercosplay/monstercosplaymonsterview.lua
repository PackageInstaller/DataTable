local MonsterCosplayMonsterView = class("MonsterCosplayMonsterView", ReduxView)

function MonsterCosplayMonsterView:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStructureUI"
end

function MonsterCosplayMonsterView:UIParent()
	return manager.ui.uiMain.transform
end

function MonsterCosplayMonsterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonsterCosplayMonsterView:InitUI()
	self:BindCfgUI()

	self.controllerList1 = {
		self.skill1Go1_:GetController("up"),
		self.skill2Go1_:GetController("up"),
		self.skill3Go1_:GetController("up"),
		self.skill4Go1_:GetController("up"),
		(self.skill5Go1_:GetController("up"))
	}
	self.controllerList2 = {
		self.skill1Go2_:GetController("up"),
		self.skill2Go2_:GetController("up"),
		self.skill3Go2_:GetController("up"),
		self.skill4Go2_:GetController("up"),
		(self.skill5Go2_:GetController("up"))
	}
	self.showController = self.controller_:GetController("show")
	self.modelController = self.controller_:GetController("model")
end

function MonsterCosplayMonsterView:AddUIListener()
	for iter_5_0 = 1, 5 do
		self:AddBtnListenerScale(self["skill" .. iter_5_0 .. "Btn1_"], nil, function()
			self.showController:SetSelectedState("false")
			self.animator:Play("skill0" .. iter_5_0)
			JumpTools.OpenPageByJump("MonsterCosplaySkillInfo", {
				modelID = self.modelID,
				monsterSkill = ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id,
				index = iter_5_0,
				animator = self.animator
			})
			manager.redPoint:setTip("MonsterCosPlay" .. ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id, 0)

			for iter_6_0, iter_6_1 in pairs(self.skillToAffixTable[ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id]) do
				if self.modelData.enhancedSkill[iter_6_1] and TalentTreeCfg[iter_6_1].type == 2 or TalentTreeCfg[iter_6_1].type == 1 and self.viewCoreSkillTable[iter_6_1] then
					saveData("monsterCosplay", tostring(iter_6_1), "true")
				end
			end
		end)
		self:AddBtnListenerScale(self["skill" .. iter_5_0 .. "Btn2_"], nil, function()
			self.showController:SetSelectedState("false")
			self.animator:Play("skill0" .. iter_5_0)
			JumpTools.OpenPageByJump("MonsterCosplaySkillInfo", {
				modelID = self.modelID,
				monsterSkill = ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id,
				index = iter_5_0,
				animator = self.animator
			})
			manager.redPoint:setTip("MonsterCosPlay" .. ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id, 0)

			for iter_7_0, iter_7_1 in pairs(self.skillToAffixTable[ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_5_0]].id] or {}) do
				if self.modelData.enhancedSkill[iter_7_1] and TalentTreeCfg[iter_7_1].type == 2 or TalentTreeCfg[iter_7_1].type == 1 and self.viewCoreSkillTable[iter_7_1] then
					saveData("monsterCosplay", tostring(iter_7_1), "true")
				end
			end
		end)
	end
end

function MonsterCosplayMonsterView:UpdateBar()
	return
end

function MonsterCosplayMonsterView:UpdateView()
	for iter_9_0 = 1, 5 do
		self["skillName" .. iter_9_0 .. "Txt_"].text = ActivityMonsterCosplaySkillCfg[self.modelCfg.skill_list[iter_9_0]].skill_name

		self.controllerList[iter_9_0]:SetSelectedState(self:GetEnhancedCount(iter_9_0))
	end

	self.titleTxt_.text = GetI18NText(self.modelCfg.chapter_name)
end

function MonsterCosplayMonsterView:UpdateData()
	self.modelData = MonsterCosplayData:GetDataByPara("monsterData")[self.modelID]
	self.modelCfg = ActivityMonsterCosplayCfg[self.modelID]
	self.skillToAffixTable = MonsterCosplayData:GetDataByPara("skillToAffixTable")
	self.viewCoreSkillTable = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[self.modelID]

	local var_10_0 = self.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	self.displayStr = self.modelID == ActivityMonsterCosplayCfg.all[1] and "activity_monster_cosplay_bg_anjinshu" or "activity_monster_cosplay_bg_renma"

	for iter_10_0 = 1, 5 do
		self["skillName" .. iter_10_0 .. "Icon_"] = self["skillName" .. iter_10_0 .. "Icon" .. var_10_0 .. "_"]
		self["skillName" .. iter_10_0 .. "Txt_"] = self["skillName" .. iter_10_0 .. "Txt" .. var_10_0 .. "_"]
	end

	self.controllerList = self["controllerList" .. var_10_0]
	self.titleTxt_ = self["titleTxt" .. var_10_0 .. "_"]
end

function MonsterCosplayMonsterView:OnEnter()
	self.modelID = self.params_.modelID

	self.modelController:SetSelectedState(tostring(self.modelID))
	self:UpdateData()
	self:UpdateView()

	self.exitView_ = false

	manager.ui:SetMainCamera("soloHeartDemon")
	self:LoadModel()
	self:InitBackScene()
	self:BindRedPoint()
end

function MonsterCosplayMonsterView:BindRedPoint()
	local var_12_0 = self.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	for iter_12_0 = 1, 5 do
		manager.redPoint:bindUIandKey(self["skill" .. iter_12_0 .. "Trs" .. var_12_0 .. "_"].transform, "MonsterCosPlay" .. self.modelCfg.skill_list[iter_12_0])
	end
end

function MonsterCosplayMonsterView:UnBindRedPoint()
	local var_13_0 = self.modelID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	for iter_13_0 = 1, 5 do
		manager.redPoint:unbindUIandKey(self["skill" .. iter_13_0 .. "Trs" .. var_13_0 .. "_"].transform, "MonsterCosPlay" .. self.modelCfg.skill_list[iter_13_0])
	end
end

function MonsterCosplayMonsterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.showController:SetSelectedState("true")
end

function MonsterCosplayMonsterView:OnExit()
	manager.windowBar:HideBar()

	self.exitView_ = true

	manager.ui:ResetMainCamera()
	self:UnloadModel()
	self:DestroyBackScene()
	self:UnBindRedPoint()
end

function MonsterCosplayMonsterView:Dispose()
	MonsterCosplayMonsterView.super.Dispose(self)
end

function MonsterCosplayMonsterView:LoadModel()
	if self.currentBossTemplateID == self.modelID then
		return
	end

	self:UnloadModel()

	self.currentBossTemplateID = self.modelID

	local var_17_0 = ActivityMonsterCosplayCfg[self.modelID]

	self.loadIndex = manager.resourcePool:AsyncLoad("MonsterCosplay/" .. ActivityMonsterCosplayCfg[self.modelID].model, ASSET_TYPE.TPOSE, function(arg_18_0)
		if self.exitView_ or self.currentBossTemplateID ~= self.modelID then
			manager.resourcePool:DestroyOrReturn(arg_18_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_18_0 = var_17_0.model_pos

		self.bossModel = arg_18_0
		self.animator = self.bossModel.transform:Find("ani_panel"):GetComponent("Animator")

		self.animator:Play("skill01_back")

		local var_18_1 = self.bossModel.transform:Find("ani_panel/Model")

		var_18_1.transform.localPosition = Vector3(var_18_0[1], var_18_0[2], var_18_0[3])
		var_18_1.transform.localEulerAngles = Vector3(var_17_0.model_rot[1], var_17_0.model_rot[2], var_17_0.model_rot[3])
		var_18_1.transform.localScale = Vector3(var_17_0.model_scale[1], var_17_0.model_scale[2], var_17_0.model_scale[3])
	end)
end

function MonsterCosplayMonsterView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/MonsterCosplayBackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg[self.displayStr].value[1], GameDisplayCfg[self.displayStr].value[2], GameDisplayCfg[self.displayStr].value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg[self.displayStr].scale[1], GameDisplayCfg[self.displayStr].scale[2], GameDisplayCfg[self.displayStr].scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(ActivityMonsterCosplayCfg[self.modelID].bg_pic)
end

function MonsterCosplayMonsterView:DestroyBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function MonsterCosplayMonsterView:UnloadModel()
	if self.bossModel ~= nil then
		manager.resourcePool:DestroyOrReturn(self.bossModel, ASSET_TYPE.TPOSE)

		self.bossModel = nil

		manager.resourcePool:StopAsyncQuest(self.loadIndex)

		self.loadIndex = nil
		self.currentBossTemplateID = nil
	end
end

function MonsterCosplayMonsterView:GetEnhancedCount(arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(self.skillToAffixTable[self.modelCfg.skill_list[arg_22_1]] or {}) do
		if self.modelData.enhancedSkill[iter_22_1] and TalentTreeCfg[iter_22_1].type == 2 then
			var_22_0 = var_22_0 + 1
		elseif TalentTreeCfg[iter_22_1].type == 1 and self.viewCoreSkillTable[iter_22_1] then
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

return MonsterCosplayMonsterView
