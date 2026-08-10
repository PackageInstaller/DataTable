local var_0_0 = class("StoryChapterView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityID_ = arg_1_2

	arg_1_0:BindCfgUI()

	arg_1_0.btnList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityStoryChapterCfg.get_id_list_by_activity_id[arg_1_2]) do
		arg_1_0.btnList_[iter_1_0] = StoryChapterBtnView.New(arg_1_0[string.format("btnChapter%s_", iter_1_0)], iter_1_1)
	end
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.btnList_) do
		iter_2_1:OnEnter(arg_2_1)
	end

	arg_2_0:RefreshUI(arg_2_1)
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.btnList_) do
		iter_3_1:OnExit()
	end
end

function var_0_0.OnUpdate(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.btnList_) do
		iter_4_1:OnUpdate(arg_4_1)
	end

	arg_4_0:RefreshUI(arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.btnList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.btnList_ = nil
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = ActivityStoryChapterCfg[arg_6_1].activity_id

	SetActive(arg_6_0.gameObject_, var_6_0 == arg_6_0.activityID_)
end

return var_0_0
