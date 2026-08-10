local var_0_0 = import("manager.tips.TipsShortItemView")
local var_0_1 = 1
local var_0_2 = class("TipsShortView")

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()

	arg_1_0.itemList_ = {}
	arg_1_0.queue_ = {}
end

function var_0_2.InitUI(arg_2_0)
	arg_2_0.tips_ = arg_2_0.transform_:Find("shortTip").gameObject
	arg_2_0.grid_ = arg_2_0.transform_:Find("shortGrid").gameObject
end

function var_0_2.ShowTips(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.itemList_ == nil then
		return
	end

	arg_3_0:GetFreeItem():RefreshUI(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_2.GetFreeItem(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList_) do
		if iter_4_1:IsFree() then
			table.insert(arg_4_0.queue_, iter_4_0)

			return iter_4_1
		end
	end

	if #arg_4_0.itemList_ < var_0_1 then
		local var_4_0 = var_0_0.New(arg_4_0, arg_4_0.tips_, arg_4_0.grid_)

		table.insert(arg_4_0.itemList_, var_4_0)
		table.insert(arg_4_0.queue_, #arg_4_0.itemList_)

		return var_4_0
	end

	local var_4_1 = arg_4_0.queue_[1]

	table.remove(arg_4_0.queue_, 1)
	table.insert(arg_4_0.queue_, var_4_1)
	arg_4_0.itemList_[var_4_1]:FastFinish()

	return arg_4_0.itemList_[var_4_1]
end

function var_0_2.Finish(arg_5_0)
	local var_5_0 = arg_5_0.queue_[1]

	table.remove(arg_5_0.queue_, 1)
	arg_5_0.itemList_[var_5_0]:SetFree(true)
end

function var_0_2.Dispose(arg_6_0)
	if arg_6_0.itemList_ then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
			iter_6_1:Dispose()
		end

		arg_6_0.itemList_ = nil
	end

	arg_6_0.tips_ = nil
	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
	arg_6_0.grid_ = nil
end

return var_0_2
