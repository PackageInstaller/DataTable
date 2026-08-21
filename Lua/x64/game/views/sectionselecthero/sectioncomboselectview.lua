local var_0_0 = class("SectionComboSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationSkillPopUPUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillItemList_ = {}
	arg_4_0.chooseSkillHandler_ = handler(arg_4_0, arg_4_0.OnChooseSkill)
end

function var_0_0.GetComboSkillItemView(arg_5_0)
	return SectionComboSelectItem
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.heroList_ = arg_8_0.params_.heroList
	arg_8_0.trialHeroList_ = arg_8_0.params_.trailList
	arg_8_0.stageType_ = arg_8_0.params_.stageType
	arg_8_0.stageID_ = arg_8_0.params_.stageID
	arg_8_0.sectionProxy_ = arg_8_0.params_.targetSectionProxy
	arg_8_0.customComboSkillID_ = arg_8_0.params_.customComboSkillID
	arg_8_0.comboSkillID_ = arg_8_0.params_.customComboSkillID or arg_8_0.params_.comboSkillID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.comboSkillIDList_ = arg_9_0:GetComboSkillList()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.comboSkillIDList_) do
		if not arg_9_0.skillItemList_[iter_9_0] then
			local var_9_0 = Object.Instantiate(arg_9_0.skillItemGo_, arg_9_0.contentTrans_)

			arg_9_0.skillItemList_[iter_9_0] = arg_9_0:GetComboSkillItemView().New(var_9_0)

			arg_9_0.skillItemList_[iter_9_0]:RegistChooseCallback(arg_9_0.chooseSkillHandler_)
		end

		arg_9_0.skillItemList_[iter_9_0]:SetData(arg_9_0.stageType_, arg_9_0.stageID_, iter_9_1, arg_9_0.comboSkillID_ == iter_9_1, arg_9_0.heroList_)
	end

	for iter_9_2 = #arg_9_0.comboSkillIDList_ + 1, #arg_9_0.skillItemList_ do
		arg_9_0.skillItemList_[iter_9_2]:Show(false)
	end
end

function var_0_0.GetComboSkillList(arg_10_0)
	if arg_10_0.comboSkillID_ == arg_10_0.customComboSkillID_ then
		return {
			arg_10_0.comboSkillID_
		}
	else
		return ComboSkillTools.GetComboSkillList(arg_10_0.heroList_, true)
	end
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillItemList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.skillItemList_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnShowComboSkillDesc(arg_12_0)
	FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.contentTrans_)
	end, 1, 1):Start()
end

function var_0_0.OnChooseSkill(arg_14_0, arg_14_1)
	arg_14_0:SetComboSkillID(arg_14_1)
	manager.notify:CallUpdateFunc(COMBO_SKILL_SELECT, arg_14_1)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_14_1)
end

function var_0_0.SetComboSkillID(arg_15_0, arg_15_1)
	arg_15_0.sectionProxy_:SetComboSkillID(arg_15_1)
end

return var_0_0
