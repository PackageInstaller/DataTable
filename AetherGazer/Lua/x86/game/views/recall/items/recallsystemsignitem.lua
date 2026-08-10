local var_0_0 = class("RecallSystemSignItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddBtnListener(arg_2_0.signBtn_, nil, function()
		local var_3_0 = ActivityRecallData:GetDataByPara("signActivityID")

		if ActivityRecallData:GetSevenDaySignIndex(arg_2_0.index) > 0 then
			ActivityRecallAction.RequireRecalledSign(var_3_0, arg_2_0.index)
		end
	end)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.item = CommonItemView.New(arg_4_0.m_item, true)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0 = ActivityRecallData:GetDataByPara("getRewardList")
	local var_6_1 = ActivityRecallData:GetDataByPara("signCount")

	CommonTools.SetCommonData(arg_6_0.item, {
		id = arg_6_0.data.reward[1],
		number = arg_6_0.data.reward[2],
		clickFun = function(arg_7_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_7_0.id,
				arg_7_0.number
			})
		end
	})
	SetActive(arg_6_0.canGetGo_, var_6_1 >= arg_6_0.index and var_6_0[arg_6_0.index] == nil)
	SetActive(arg_6_0.getGo_, var_6_0[arg_6_0.index] ~= nil)

	arg_6_0.dayTxt_.text = arg_6_0.data.day
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.item then
		arg_10_0.item:Dispose()

		arg_10_0.item = nil
	end
end

return var_0_0
