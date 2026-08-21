local var_0_0 = class("SPHeroChallengeScheduleTypeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.type = arg_1_3
	arg_1_0.gameObject_ = GameObject.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:InitItem()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.InitItem(arg_4_0)
	arg_4_0.typeName.text = SPHeroChallengeTools:GetScheduleTypeName(arg_4_0.type)

	local var_4_0 = ActivityHeroChallengeScheduleCfg.get_id_list_by_type[arg_4_0.type]

	if var_4_0 and not arg_4_0.scheduleList then
		arg_4_0.scheduleList = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			arg_4_0.scheduleList[iter_4_1] = SPHeroChallengeScheduleDailyItem.New(arg_4_0.scheduleItem, arg_4_0.contentTrs_, iter_4_1)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentTrs_)
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.scheduleList then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.scheduleList) do
			if iter_5_1:RefreshUI() then
				iter_5_1.transform_:SetAsLastSibling()
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.contentTrs_)
	end
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.scheduleList then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.scheduleList) do
			iter_6_1:Dispose()
		end
	end

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
