local var_0_0 = class("NewComboSkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_skill/HeroSkillPopUPUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.comboSkillList = {}
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.backBtn_, function()
		JumpTools.Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.viewBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("video_play_comboskill_heroskill")
		DestroyLua()

		HeroCooperationBridge.entrance = ViewConst.SYSTEM_ID.HERO_SKILL
		HeroCooperationBridge.heroId = arg_4_0.heroId

		CooperateSkillBridge.Launcher()
	end)
end

function var_0_0.CreatComboSkill(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1 == 1 then
		var_7_0 = arg_7_0.empoweringskillGo_
	else
		var_7_0 = Object.Instantiate(arg_7_0.empoweringskillGo_, arg_7_0.contentTrs_)
	end

	arg_7_0.comboSkillList[arg_7_1] = NewComboSkillItem.New(var_7_0)

	return arg_7_0.comboSkillList[arg_7_1]
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.heroId = arg_8_0.params_.heroID

	arg_8_0:UpdateSkillList()
end

function var_0_0.UpdateSkillList(arg_9_0)
	arg_9_0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(arg_9_0.params_.heroID)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.comboSkillList) do
		SetActive(iter_9_1.gameObject_, false)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.comboSkillList_) do
		local var_9_0 = arg_9_0.comboSkillList[iter_9_2] or arg_9_0:CreatComboSkill(iter_9_2)

		SetActive(var_9_0.gameObject_, true)
		var_9_0:RefreshUI(iter_9_3, arg_9_0.heroId)
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.comboSkillList) do
		if iter_11_1 then
			iter_11_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
