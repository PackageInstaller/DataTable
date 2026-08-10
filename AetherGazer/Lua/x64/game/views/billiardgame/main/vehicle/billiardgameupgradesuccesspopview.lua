local var_0_0 = class("BilliardGameUpgradeSuccessPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffUpgradePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
	arg_3_0:AddUIListener()
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillItemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
		manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, true)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.skillList_ = arg_7_0.params_.skillList

	arg_7_0:RefreshSkillList()
end

function var_0_0.RefreshSkillList(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.skillList_) do
		local var_8_0 = arg_8_0:GetFreeSkillItem()

		var_8_0:SetSkillData(iter_8_1, true)

		var_8_0.isFree = false

		SetActive(var_8_0.gameObject_, true)
	end
end

function var_0_0.GetFreeSkillItem(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.skillItemList_ do
		local var_9_0 = arg_9_0.skillItemList_[iter_9_0]

		if var_9_0 and var_9_0.isFree then
			return var_9_0
		end
	end

	local var_9_1 = Object.Instantiate(arg_9_0.skillItemGo_, arg_9_0.skillContain_)

	skillItem = BilliardGameSmallSkillItemView.New(var_9_1)

	table.insert(arg_9_0.skillItemList_, skillItem)

	return skillItem
end

function var_0_0.ReturnSkillItem(arg_10_0, arg_10_1)
	arg_10_1.isFree = true

	SetActive(arg_10_1.gameObject_, false)
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.skillItemList_ do
		local var_12_0 = arg_12_0.skillItemList_[iter_12_0]

		if not var_12_0.isFree then
			arg_12_0:ReturnSkillItem(var_12_0)
		end
	end
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.skillItemList_) do
		if iter_13_1 then
			iter_13_1:Dispose()
		end
	end

	arg_13_0.skillItemList_ = {}

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
