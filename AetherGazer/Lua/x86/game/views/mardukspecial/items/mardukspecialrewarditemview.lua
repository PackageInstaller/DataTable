local var_0_0 = class("MardukSpecialRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.items_ = {
		MardukSpecialRewardConditionItemView.New(arg_3_0.itemGo1_),
		MardukSpecialRewardConditionItemView.New(arg_3_0.itemGo2_),
		MardukSpecialRewardConditionItemView.New(arg_3_0.itemGo3_)
	}
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.activityId_ = arg_6_2
	arg_6_0.quickTrainingCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[arg_6_0.activityId_].stage_id]
	arg_6_0.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_2]

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.nameLabel.text = GetI18NText(arg_7_0.quickTrainingCfg_.name)

	local var_7_0 = ActivityPointRewardCfg[arg_7_0.rewardIdList_[#arg_7_0.rewardIdList_]]

	arg_7_0.scoreLabel1_.text = MardukSpecialData:GetPoint(arg_7_0.activityId_)
	arg_7_0.scoreLabel2_.text = "/" .. var_7_0.need

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.items_) do
		iter_7_1:SetData(iter_7_0, arg_7_0.rewardIdList_[iter_7_0], arg_7_0.activityId_)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:AddEventListeners()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.items_) do
		iter_8_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items_) do
		iter_9_1:OnExit()
	end
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.data_ = nil

	if arg_11_0.items_ then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.items_) do
			iter_11_1:Dispose()
		end

		arg_11_0.items_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
