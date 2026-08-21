local var_0_0 = class("ChapterPlot19StoryCollectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()

	arg_1_0.itemList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.itemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = ChapterStoryCollectCfg[arg_3_1]

	arg_3_0.titleText_.text = var_3_0.title_name

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0.story_id_list) do
		if ChapterTools.HasReadEventID(iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		if arg_3_0.itemList_[iter_3_2] == nil then
			arg_3_0.itemList_[iter_3_2] = ChapterPlot19StoryCollectStoryItem.New(arg_3_0.storyItem_, arg_3_0.gameObject_)
		end

		arg_3_0.itemList_[iter_3_2]:SetData(iter_3_3)
	end

	for iter_3_4 = #arg_3_0.itemList_, #var_3_1 + 1, -1 do
		arg_3_0.itemList_[iter_3_4]:Show(false)
	end
end

return var_0_0
