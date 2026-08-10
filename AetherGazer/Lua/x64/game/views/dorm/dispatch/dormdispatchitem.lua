local var_0_0 = class("TowerStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddClickListen()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.skillDisplay = DormSkillDisplay.New(arg_2_0.m_skillDisplay)
	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.qualityController_ = ControllerUtil.GetController(arg_2_0.transform_, "quality")
	arg_2_0.viewModeController_ = ControllerUtil.GetController(arg_2_0.transform_, "viewmode")
	arg_2_0.moodController_ = ControllerUtil.GetController(arg_2_0.m_moodController, "expression")
end

function var_0_0.AddClickListen(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.id)
		end
	end)
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc = arg_5_1
end

function var_0_0.SetHeroIcon(arg_6_0, arg_6_1)
	arg_6_0.m_heroIcon.sprite = arg_6_1
end

function var_0_0.GetHeroCfg(arg_7_0)
	return HeroCfg[arg_7_0.id]
end

local function var_0_1(arg_8_0)
	return HeroTools.GetHeadSprite(HeroTools.HeroUsingSkinInfo(arg_8_0).id)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	if arg_9_0.id ~= arg_9_1 then
		arg_9_0.id = arg_9_1

		local var_9_0 = arg_9_0:GetHeroCfg()

		arg_9_0.m_heroIcon.sprite = var_0_1(arg_9_1)
		arg_9_0.m_name.text = GetI18NText(var_9_0.name)

		arg_9_0.qualityController_:SetSelectedIndex(var_9_0.rare)
		arg_9_0.skillDisplay:SetData(arg_9_1)
	end

	arg_9_0:UpdateMood()
end

function var_0_0.SetViewMode(arg_10_0, arg_10_1)
	arg_10_0.viewModeController_:SetSelectedState(arg_10_1)
end

function var_0_0.UpdateMood(arg_11_0)
	local var_11_0 = DormData:GetDormHero(arg_11_0.id)
	local var_11_1 = DormConst.DORM_HERO_MAX_MOOD
	local var_11_2 = var_11_0 and var_11_0:GetMood() or var_11_1

	arg_11_0.m_moodLab.text = var_11_2 .. "/" .. var_11_1
	arg_11_0.m_moodProcess.fillAmount = var_11_2 / var_11_1

	if var_11_2 == 0 then
		arg_11_0.moodController_:SetSelectedIndex(2)
	elseif var_11_2 >= 12 then
		arg_11_0.moodController_:SetSelectedIndex(0)
	else
		arg_11_0.moodController_:SetSelectedIndex(1)
	end

	if var_11_0 == nil or not var_11_0:GetIsInJobDuty() then
		arg_11_0.stateController_:SetSelectedIndex(0)
	else
		arg_11_0.m_workLab.text = GetI18NText(arg_11_0:GetJobName(var_11_0:GetCurJob()))

		if var_11_2 == 0 then
			arg_11_0.stateController_:SetSelectedIndex(2)
		else
			arg_11_0.stateController_:SetSelectedIndex(1)
		end
	end
end

function var_0_0.GetJobName(arg_12_0, arg_12_1)
	return "[JOB][" .. arg_12_1 .. "]"
end

function var_0_0.UpdateSelect(arg_13_0, arg_13_1)
	arg_13_0.selectController_:SetSelectedIndex(arg_13_1)
end

return var_0_0
