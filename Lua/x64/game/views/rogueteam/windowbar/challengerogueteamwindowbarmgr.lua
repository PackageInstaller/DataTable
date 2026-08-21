local var_0_0 = class("ChallengeRogueTeamWindowBarMgr", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueTeamWindowBarUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_3_0:UIName()), manager.ui.uiPop.transform)
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	arg_3_0:BindCfgUI()

	arg_3_0.itemList_ = {}
	arg_3_0.onUpdateBarHandler_ = handler(arg_3_0, arg_3_0.OnUpdateBar)
	arg_3_0.createFlag_ = true
end

function var_0_0.SwitchBar(arg_4_0, arg_4_1)
	if not arg_4_0.createFlag_ then
		arg_4_0:Init()
	end

	arg_4_0:Show(true)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if arg_4_0.itemList_[iter_4_0] == nil then
			arg_4_0.itemList_[iter_4_0] = ChallengeRogueTeamWindowBarItem.New(arg_4_0.currencyItem_, arg_4_0.currencyList_)
		end

		arg_4_0.itemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #arg_4_1 + 1, #arg_4_0.itemList_ do
		arg_4_0.itemList_[iter_4_2]:Show(false)
	end

	arg_4_0.transform_:SetAsLastSibling()
end

function var_0_0.PlayAnimator(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList_) do
		iter_5_1:PlayAnimator(arg_5_1)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	if arg_6_1 ~= true then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
			iter_6_1:Show(false)
		end
	end

	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.HideBar(arg_7_0)
	arg_7_0:Show(false)
end

function var_0_0.OnUpdateBar(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList_) do
		iter_8_1:RefreshUI()
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.createFlag_ then
		arg_9_0.onUpdateBarHandler_ = nil

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.itemList_ = nil

		var_0_0.super.Dispose(arg_9_0)
		Object.Destroy(arg_9_0.gameObject_)

		arg_9_0.transform_ = nil
		arg_9_0.gameObject_ = nil
		arg_9_0.createFlag_ = false
	end
end

return var_0_0
