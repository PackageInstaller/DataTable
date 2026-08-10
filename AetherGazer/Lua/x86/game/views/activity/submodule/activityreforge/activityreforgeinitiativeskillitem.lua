local var_0_0 = class("ActivityReforgeInitiativeSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skillItemList_ = {}
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	arg_4_0.viewType_ = arg_4_1
	arg_4_0.skillList_ = arg_4_2
	arg_4_0.itemSelectHandler_ = arg_4_3
	arg_4_0.activityID_ = arg_4_4
	arg_4_0.levelID_ = arg_4_5
	arg_4_0.curSkillID_ = arg_4_7
	arg_4_0.slotText_.text = string.format(GetTips("ACTIVITY_REFORGE_SLOT"), arg_4_6)

	local var_4_0 = ActivityReforgeData:GetInitiativeSkillUseNum(arg_4_6) .. "/1"

	arg_4_0.slotNumText_.text = string.format(GetTips("ACTIVITY_REFORGE_USE_MAX"), var_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.skillList_) do
		if arg_4_0.skillItemList_[iter_4_0] == nil then
			local var_4_1 = Object.Instantiate(arg_4_0.itemGo_, arg_4_0.contentTrans_)

			arg_4_0.skillItemList_[iter_4_0] = ActivityReforgeSkillItem.New(var_4_1)
		end

		arg_4_0.skillItemList_[iter_4_0]:SetIsActive(true)
		arg_4_0.skillItemList_[iter_4_0]:SetData(arg_4_0.viewType_, arg_4_0.skillList_[iter_4_0], arg_4_0.itemSelectHandler_, arg_4_0.activityID_, arg_4_0.levelID_, arg_4_0.curSkillID_)
	end

	for iter_4_2 = #arg_4_0.skillList_ + 1, #arg_4_0.skillItemList_ do
		arg_4_0.skillItemList_[iter_4_2]:SetIsActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentTrans_)
end

function var_0_0.OnExit(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.skillItemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.skillItemList_) do
		arg_6_0.skillItemList_[iter_6_0]:Dispose()

		arg_6_0.skillItemList_[iter_6_0] = nil
	end

	arg_6_0.clickHandle_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
