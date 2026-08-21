local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("IlluIllustrationWidget", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.illuItemList_ = {}
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.GetItemHeight(arg_3_0)
	return 0
end

function var_0_1.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:Show(true)

	arg_4_0.index_ = arg_4_2
	arg_4_0.data_ = arg_4_1
	arg_4_0.chapterID_ = arg_4_1.chapterID
	arg_4_0.list = arg_4_1.list
	arg_4_0.isEditor_ = arg_4_3
	arg_4_0.objectType_ = arg_4_1.objectType

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.list) do
		if arg_4_0.illuItemList_[iter_4_0] == nil then
			local var_4_0 = Object.Instantiate(arg_4_0.itemGo_, arg_4_0.transform_)

			arg_4_0.illuItemList_[iter_4_0] = IlluIllustrationItem.New(var_4_0)
			var_4_0.name = iter_4_1
		end

		arg_4_0.illuItemList_[iter_4_0]:RefreshUI(iter_4_1, arg_4_0.isEditor_, arg_4_2)
		arg_4_0.illuItemList_[iter_4_0]:Show(true)
	end

	for iter_4_2 = #arg_4_0.list + 1, #arg_4_0.illuItemList_ do
		arg_4_0.illuItemList_[iter_4_2]:Show(false)
	end
end

function var_0_1.GetObjectType(arg_5_0)
	return arg_5_0.objectType_
end

function var_0_1.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_1.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.illuItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.illuItemList_ = nil

	var_0_1.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

return var_0_1
