local var_0_0 = class("ActivityNoobSignView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.contentTrans_ = arg_1_1
	arg_1_0.contenViewList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.contenViewList_) do
		iter_2_1:Dispose()
	end

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	if arg_3_0.curView_ then
		arg_3_0.curView_:SetActive(arg_3_1)
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	if arg_4_0.curView_ then
		arg_4_0.curView_:SetActive(false)
	end

	if not arg_4_0.contenViewList_[arg_4_1] then
		arg_4_0.contenViewList_[arg_4_1] = ActivityNoobSignContentView.New(arg_4_0.contentTrans_, arg_4_1)
	end

	arg_4_0.curView_ = arg_4_0.contenViewList_[arg_4_1]

	arg_4_0.curView_:SetData(arg_4_1)
	arg_4_0.curView_:SetActive(true)
end

return var_0_0
