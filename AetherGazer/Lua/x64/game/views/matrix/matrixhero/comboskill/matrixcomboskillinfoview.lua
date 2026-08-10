local var_0_0 = class("MatrixComboSkillInfoView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/MatrixHero/MatrixComboSkillInfoUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.comboSkillUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshComboSkillItem), arg_4_0.uiList_, MatrixComboSkillItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(arg_7_0.params_.heroId)

	arg_7_0.comboSkillUIList_:StartScroll(#arg_7_0.comboSkillList_, 1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.comboSkillUIList_ then
		arg_8_0.comboSkillUIList_:Dispose()

		arg_8_0.comboSkillUIList_ = nil
	end
end

function var_0_0.RefreshComboSkillItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(arg_9_0.comboSkillList_[arg_9_1])
end

return var_0_0
