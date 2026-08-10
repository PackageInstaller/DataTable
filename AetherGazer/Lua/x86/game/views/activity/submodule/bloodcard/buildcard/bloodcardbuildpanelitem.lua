local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("BloodCardBuildPanelItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.cardItemList_ = {}
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0:Show(true)

	arg_3_0.index_ = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if arg_3_0.cardItemList_[iter_3_0] == nil then
			local var_3_0 = Object.Instantiate(arg_3_0.itemGo_, arg_3_0.rectGo_)

			arg_3_0.cardItemList_[iter_3_0] = BloodCardVisualCardView.New(var_3_0)
		end

		arg_3_0.cardItemList_[iter_3_0]:SetData(iter_3_0, iter_3_1)
		arg_3_0.cardItemList_[iter_3_0]:SetUseNum("true")
		arg_3_0.cardItemList_[iter_3_0]:SetUsed(table.indexof(arg_3_4, iter_3_1) ~= false)
		arg_3_0.cardItemList_[iter_3_0]:SetNone(table.indexof(arg_3_5, iter_3_1) ~= false)
		arg_3_0.cardItemList_[iter_3_0]:SetGray(arg_3_3 == 0)
		arg_3_0.cardItemList_[iter_3_0]:SelectCard(arg_3_0.selectID_)
		arg_3_0.cardItemList_[iter_3_0]:SetOwnNum(arg_3_6[iter_3_1] or 0)
		SetActive(arg_3_0.cardItemList_[iter_3_0].gameObject_, true)
	end

	for iter_3_2 = #arg_3_1 + 1, #arg_3_0.cardItemList_ do
		SetActive(arg_3_0.cardItemList_[iter_3_2].gameObject_, false)
	end
end

function var_0_1.IsSelectID(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.cardItemList_) do
		if iter_4_1.id_ == arg_4_1 then
			return iter_4_1
		end
	end
end

function var_0_1.SetSelectID(arg_5_0, arg_5_1)
	arg_5_0.selectID_ = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.cardItemList_) do
		iter_5_1:SelectCard(arg_5_1)
	end
end

function var_0_1.RefreshNone(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.cardItemList_) do
		if iter_6_1.id_ == arg_6_1 then
			iter_6_1:SetNone(arg_6_2)
		end
	end
end

function var_0_1.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_1.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.cardItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.cardItemList_ = nil

	var_0_1.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

return var_0_1
