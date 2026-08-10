local var_0_0 = class("ActivityNoobFirstRechargeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1.gameObject
	arg_1_0.transform_ = arg_1_1
	arg_1_0.contentTrans_ = arg_1_1
	arg_1_0.contentViewList_ = {}
	arg_1_0.type_ = arg_1_2
	arg_1_0.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.contentViewList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.contentViewList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	if arg_3_0.curView_ then
		arg_3_0.curView_:SetActive(arg_3_1)
	end
end

function var_0_0.SetType(arg_4_0, arg_4_1)
	arg_4_0.type_ = arg_4_1
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	if arg_5_0.curView_ then
		arg_5_0.curView_:SetActive(false)
	end

	if not arg_5_0.contentViewList_[arg_5_1] then
		arg_5_0.contentViewList_[arg_5_1] = arg_5_0.contentClasss_[arg_5_1].New(arg_5_0.contentTrans_, arg_5_0.type_)
	end

	arg_5_0.curView_ = arg_5_0.contentViewList_[arg_5_1]

	arg_5_0.curView_:SetData(arg_5_1)
	arg_5_0.curView_:SetActive(true)
end

return var_0_0
