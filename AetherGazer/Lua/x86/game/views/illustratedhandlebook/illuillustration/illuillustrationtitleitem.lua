local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("IlluIllustrationTitleItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.GetItemHeight(arg_3_0)
	return 0
end

function var_0_1.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Show(true)

	arg_4_0.index_ = arg_4_2
	arg_4_0.data_ = arg_4_1
	arg_4_0.chapterID_ = arg_4_1.chapterID
	arg_4_0.objectType_ = arg_4_1.objectType
	arg_4_0.titleText_.text = ChapterClientCfg[arg_4_0.chapterID_].name
end

function var_0_1.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_1.GetObjectType(arg_6_0)
	return arg_6_0.objectType_
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

return var_0_1
