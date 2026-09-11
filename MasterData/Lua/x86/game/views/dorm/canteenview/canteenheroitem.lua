local CanteenHeroItem = class("CanteenHeroItem", ReduxView)

function CanteenHeroItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.clickFlag = arg_1_2

	self:InitUI()
	self:AddUIListener()
end

function CanteenHeroItem:InitUI()
	self:BindCfgUI()

	self.fatigueController = ControllerUtil.GetController(self.transform_, "fatigue")
	self.selController = ControllerUtil.GetController(self.transform_, "state")
	self.jobController = ControllerUtil.GetController(self.transform_, "work")
	self.skillController = ControllerUtil.GetController(self.transform_, "skill")
	self.sameNameController = ControllerUtil.GetController(self.transform_, "sameName")
	self.lockHeroController = self.controllers_:GetController("lock")
end

function CanteenHeroItem:SetFunction(arg_3_1)
	self.showWork = arg_3_1
end

function CanteenHeroItem:AddUIListener()
	self:AddBtnListener(self.heroitemBtn_, nil, function()
		if self.selFunc then
			self.selFunc(self.heroID)
		end
	end)
end

function CanteenHeroItem:ResetCharacterCallBack(arg_6_1)
	if arg_6_1 then
		self.selFunc = arg_6_1
	end
end

function CanteenHeroItem:RefreshUI(arg_7_1, arg_7_2, arg_7_3)
	self.heroID = arg_7_1

	if DormNpcTools:CheckIDIsNpc(arg_7_1) then
		self:RefreshNpcInfo(arg_7_1, arg_7_2, arg_7_3)
	else
		self:RefreshHeroInfo(arg_7_1, arg_7_2, arg_7_3)
	end
end

function CanteenHeroItem:RefreshHeroInfo(arg_8_1, arg_8_2, arg_8_3)
	self.heroIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_8_1)
	self.heroitemBtn_.interactable = true

	self.lockHeroController:SetSelectedState(BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_8_1) and "on" or "off")

	local var_8_0 = DormData:GetHeroFatigue(arg_8_1)

	self.curText_.text = var_8_0
	self.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	self.progressImg_.fillAmount = 1 - math.min(var_8_0 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	if var_8_0 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		self.fatigueController:SetSelectedState("lack")
	elseif var_8_0 > GameDisplayCfg.dorm_hero_fatigue_level.value[1] and var_8_0 <= GameDisplayCfg.dorm_hero_fatigue_level.value[2] then
		self.fatigueController:SetSelectedState("middle")
	else
		self.fatigueController:SetSelectedState("full")
	end

	local var_8_1 = DormData:GetHeroTemplateInfo(arg_8_1)

	self.jobController:SetSelectedState("false")

	if not self.showWork then
		if var_8_1.jobType then
			self.jobController:SetSelectedState("true")

			self.jobText_.text = GetI18NText(CanteenTools:GetJobName(var_8_1.jobType))

			if var_8_1.hero_id ~= arg_8_1 then
				self.selController:SetSelectedState("no")
			end
		elseif CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_8_1) then
			self.jobController:SetSelectedState("true")

			self.jobText_.text = GetTips("DORM_HERO_AT_TASK")
		end
	end

	local var_8_2 = DormSkillData:CheckSkillCanOpen(arg_8_3, arg_8_1)

	if #var_8_2 > 0 then
		self.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(var_8_2[1])

		self.skillController:SetSelectedState("true")
	else
		self.skillController:SetSelectedState("false")
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_8_1) then
		self.selController:SetSelectedState("no")

		self.heroitemBtn_.interactable = false

		return
	end

	local var_8_3

	if arg_8_2 and not DormNpcTools:CheckIDIsNpc(arg_8_2) then
		var_8_3 = HeroRecordCfg.get_id_list_by_hero_id[arg_8_2][1]
	end

	self.archiveID = HeroRecordCfg.get_id_list_by_hero_id[arg_8_1][1]

	self.sameNameController:SetSelectedState("false")

	if arg_8_2 == arg_8_1 then
		self.selController:SetSelectedState("sel")
	elseif self.archiveID == var_8_3 then
		if not var_8_1.jobType then
			self.sameNameController:SetSelectedState("true")
		end
	else
		self.selController:SetSelectedState("normal")
	end

	if var_8_1.jobType and var_8_1.hero_id ~= arg_8_1 then
		self.selController:SetSelectedState("no")

		self.heroitemBtn_.interactable = false
	end
end

function CanteenHeroItem:RefreshNpcInfo(arg_9_1, arg_9_2, arg_9_3)
	self.heroitemBtn_.interactable = true

	self.lockHeroController:SetSelectedState("off")

	self.heroIcon_.sprite = DormNpcTools:GetNpcHeadSprite(arg_9_1)

	if DormNpcTools:GetNpcFatigue(arg_9_1) < 0 then
		self.fatigueController:SetSelectedState("infinite")
	end

	local var_9_0 = DormSkillData:CheckSkillCanOpen(arg_9_3, arg_9_1)

	if #var_9_0 > 0 then
		self.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(var_9_0[1])

		self.skillController:SetSelectedState("true")
	else
		self.skillController:SetSelectedState("false")
	end

	if arg_9_2 == arg_9_1 then
		self.selController:SetSelectedState("sel")
	else
		self.selController:SetSelectedState("normal")
	end

	if not self.showWork then
		local var_9_1 = BackHomeNpcData:GetNpcInfoById(arg_9_1).jobType

		if var_9_1 then
			self.jobController:SetSelectedState("true")

			self.jobText_.text = CanteenTools:GetJobName(var_9_1)
		else
			self.jobController:SetSelectedState("false")
		end
	else
		self.jobController:SetSelectedState("false")
	end
end

function CanteenHeroItem:Dispose()
	CanteenHeroItem.super.Dispose(self)
end

return CanteenHeroItem
