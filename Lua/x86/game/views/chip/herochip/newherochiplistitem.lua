local var_0_0 = class("NewHeroChipListItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chipItemGo_ = arg_1_2

	arg_1_0:BindCfgUI()

	arg_1_0.chipItemList_ = {}
end

function var_0_0.RefreshUI(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.chipList_) do
		local var_2_0 = arg_2_0.chipItemList_[iter_2_0]

		if var_2_0 == nil then
			local var_2_1 = Object.Instantiate(arg_2_0.chipItemGo_, arg_2_0.chipContent_)

			var_2_0 = NewHeroChipItem.New(var_2_1)
			arg_2_0.chipItemList_[iter_2_0] = var_2_0

			var_2_0:SetCallBack(arg_2_0.chipClickCallBack_)
		end

		SetActive(var_2_0.gameObject_, true)
		var_2_0:SetData(arg_2_0.chipList_[iter_2_0], arg_2_0.curChipID_)
	end

	for iter_2_2 = #arg_2_0.chipList_ + 1, #arg_2_0.chipItemList_ do
		SetActive(arg_2_0.chipItemList_[iter_2_2].gameObject_, false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.chipContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.transform_)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.heroID_ = arg_3_1
	arg_3_0.chipList_ = arg_3_2
	arg_3_0.curChipID_ = arg_3_3

	arg_3_0:RefreshUI()
end

function var_0_0.SetChipClickCallBack(arg_4_0, arg_4_1)
	arg_4_0.chipClickCallBack_ = arg_4_1
end

function var_0_0.SetIsShow(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.chipItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.chipItemList_ = nil
	arg_6_0.chipClickCallBack_ = nil
end

return var_0_0
