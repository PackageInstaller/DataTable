local var_0_0 = class("MailRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onResize_ = arg_1_2

	arg_1_0:InitUI()

	arg_1_0.rewardItemList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0 = #arg_2_0.rewardItemList_, 1, -1 do
		arg_2_0.rewardItemList_[iter_2_0]:Dispose()

		arg_2_0.rewardItemList_[iter_2_0] = nil
	end

	arg_2_0.rewardItemList_ = nil

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.item_ = arg_3_0:FindGo("CommonItem")
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.data_ = arg_4_1

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.data_.reward_item) do
		if arg_5_0.rewardItemList_[iter_5_0] == nil then
			arg_5_0.rewardItemList_[iter_5_0] = RewardItem.New(arg_5_0.item_, arg_5_0.gameObject_)

			arg_5_0.rewardItemList_[iter_5_0]:UpdateCommonItemAni()
		end

		arg_5_0.rewardItemList_[iter_5_0]:SetData({
			iter_5_1.id,
			iter_5_1.num
		})
	end

	SetActive(arg_5_0.gameObject_, true)

	if arg_5_0.onResize_ ~= nil then
		arg_5_0.onResize_()
	end
end

function var_0_0.GetHeight(arg_6_0)
	return arg_6_0.transform_.rect.height
end

return var_0_0
