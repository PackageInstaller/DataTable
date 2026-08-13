ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
class = ys

local var_0_1 = var_0("SeqCenter")

ys = var_1
var_1.SeqCenter = var_0_1
var_0_1._list = nil
var_0_1._destroyed = false

function var_0_1.Ctor(arg_1_0, arg_1_1)
	ys = var_1_10002
	arg_1_0._list = var_1_10002.LinkList.New()

	return
end

function var_0_1.NewSeq(arg_2_0, arg_2_1)
	ys = var_1_10002

	return var_1_10002.Sequence.New(arg_2_1, arg_2_0)
end

function var_0_1.AddSeq(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._list

	var_2.AddLast(var_3_0, arg_3_1)

	return
end

function var_0_1.Update(arg_4_0)
	if arg_4_0._destroyed then
		return
	end

	local var_4_0 = arg_4_0._list.Head

	while var_4_0 ~= nil do
		local var_4_1 = var_4_0.Data

		var_2.Update(var_4_1)

		if arg_4_0._destroyed then
			return
		end

		if var_2:IsFinish() then
			local var_4_2 = var_4_0

			var_4_0 = var_4_0.Next

			local var_4_3 = arg_4_0._list

			var_4.Remove(var_4_3, var_4_2)
		else
			var_4_0 = var_4_0.Next
		end
	end

	return
end

function var_0_1.Dispose(arg_5_0)
	local var_5_0 = arg_5_0._list.Head

	for iter_5_0 = 1, arg_5_0._list.Count do
		var_5_0.Data.Dispose()

		var_5_0 = var_5_0.Next
	end

	arg_5_0._list = nil
	arg_5_0._destroyed = true

	return
end

function var_0_1.IsFinish(arg_6_0)
	if arg_6_0._list == nil then
		return true
	end

	local var_6_0 = arg_6_0._list.Head

	for iter_6_0 = 1, arg_6_0._list.Count do
		local var_6_1 = var_6_0.Data

		if not var_6.IsFinish(var_6_1) then
			return false
		end

		var_6_0 = var_6_0.Next
	end

	return true
end

return
