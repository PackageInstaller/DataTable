local TowerStageItem = class("TowerStageItem", ReduxView)

function TowerStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddClickListen()
end

function TowerStageItem:InitUI()
	self:BindCfgUI()

	self.skillDisplay = DormSkillDisplay.New(self.m_skillDisplay)
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.qualityController_ = ControllerUtil.GetController(self.transform_, "quality")
	self.viewModeController_ = ControllerUtil.GetController(self.transform_, "viewmode")
	self.moodController_ = ControllerUtil.GetController(self.m_moodController, "expression")
end

function TowerStageItem:AddClickListen()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function TowerStageItem:RegistCallBack(arg_5_1)
	self.clickFunc = arg_5_1
end

function TowerStageItem:SetHeroIcon(arg_6_1)
	self.m_heroIcon.sprite = arg_6_1
end

function TowerStageItem:GetHeroCfg()
	return HeroCfg[self.id]
end

local function var_0_1(arg_8_0)
	return HeroTools.GetHeadSprite(HeroTools.HeroUsingSkinInfo(arg_8_0).id)
end

function TowerStageItem:SetData(arg_9_1)
	if self.id ~= arg_9_1 then
		self.id = arg_9_1

		local var_9_0 = self:GetHeroCfg()

		self.m_heroIcon.sprite = var_0_1(arg_9_1)
		self.m_name.text = GetI18NText(var_9_0.name)

		self.qualityController_:SetSelectedIndex(var_9_0.rare)
		self.skillDisplay:SetData(arg_9_1)
	end

	self:UpdateMood()
end

function TowerStageItem:SetViewMode(arg_10_1)
	self.viewModeController_:SetSelectedState(arg_10_1)
end

function TowerStageItem:UpdateMood()
	local var_11_0 = DormData:GetDormHero(self.id)
	local var_11_1 = DormConst.DORM_HERO_MAX_MOOD
	local var_11_2 = var_11_0 and var_11_0:GetMood() or var_11_1

	self.m_moodLab.text = var_11_2 .. "/" .. DormConst.DORM_HERO_MAX_MOOD
	self.m_moodProcess.fillAmount = var_11_2 / var_11_1

	if var_11_2 == 0 then
		self.moodController_:SetSelectedIndex(2)
	elseif var_11_2 >= 12 then
		self.moodController_:SetSelectedIndex(0)
	else
		self.moodController_:SetSelectedIndex(1)
	end

	if var_11_0 == nil or not var_11_0:GetIsInJobDuty() then
		self.stateController_:SetSelectedIndex(0)
	else
		self.m_workLab.text = GetI18NText(self:GetJobName(var_11_0:GetCurJob()))

		if var_11_2 == 0 then
			self.stateController_:SetSelectedIndex(2)
		else
			self.stateController_:SetSelectedIndex(1)
		end
	end
end

function TowerStageItem:GetJobName(arg_12_1)
	return "[JOB][" .. arg_12_1 .. "]"
end

function TowerStageItem:UpdateSelect(arg_13_1)
	self.selectController_:SetSelectedIndex(arg_13_1)
end

return TowerStageItem
