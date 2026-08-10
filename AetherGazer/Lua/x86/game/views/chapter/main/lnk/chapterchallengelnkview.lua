local var_0_0 = class("ChapterChallengeLnkView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.lnkItemList_ = {}

	for iter_1_0 = 1, 4 do
		arg_1_0.lnkItemList_[iter_1_0] = ChapterChallengeLnkItem.New(arg_1_0[string.format("item%s_", iter_1_0)])
	end
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		arg_2_0.lnkItemList_[iter_2_0 + #arg_2_0.lnkItemList_ - #arg_2_1]:SetData(arg_2_1[iter_2_0])
	end

	for iter_2_1 = 1, #arg_2_0.lnkItemList_ - #arg_2_1 do
		arg_2_0.lnkItemList_[iter_2_1]:Show(false)
	end
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.lnkItemList_) do
		iter_3_1:OnExit()
	end
end

function var_0_0.RefresLock(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.lnkItemList_) do
		iter_4_1:RefreshLockState()
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.lnkItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.lnkItemList_ = nil
	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

return var_0_0
