ys = ys or {}

local var_0_0 = class("SeqCenter")

ys.SeqCenter = var_0_0
var_0_0._list = nil
var_0_0._destroyed = false

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._list = ys.LinkList.New()

	return
end

function var_0_0.NewSeq(arg_2_0, arg_2_1)
	return ys.Sequence.New(arg_2_1, arg_2_0)
end

function var_0_0.AddSeq(arg_3_0, arg_3_1)
	arg_3_0._list:AddLast(arg_3_1)

	return
end

function var_0_0.Update(arg_4_0)
	if arg_4_0._destroyed then
		return
	end

	local var_4_0 = arg_4_0._list.Head

	while var_4_0 ~= nil do
		var_4_0.Data:Update()

		if arg_4_0._destroyed then
			return
		end

		if var_4_0.Data:IsFinish() then
			var_4_0 = var_4_0.Next

			arg_4_0._list:Remove(var_4_0)
		else
			var_4_0 = var_4_0.Next
		end
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0 = 1, arg_5_0._list.Count do
		arg_5_0._list.Head.Data.Dispose()
	end

	arg_5_0._list = nil
	arg_5_0._destroyed = true

	return
end

function var_0_0.IsFinish(arg_6_0)
	if arg_6_0._list == nil then
		return true
	end

	local var_6_0 = arg_6_0._list.Head

	for iter_6_0 = 1, arg_6_0._list.Count do
		if not var_6_0.Data:IsFinish() then
			return false
		end

		var_6_0 = var_6_0.Next
	end

	return true
end

return
