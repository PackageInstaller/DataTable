ys = ys or {}

local var_0_0 = class("Sequence")

ys.Sequence = var_0_0
var_0_0.Name = ""
var_0_0._list = nil
var_0_0.Center = nil
var_0_0._wait = false

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.Name = arg_1_1
	arg_1_0._list = ys.LinkList.New()
	arg_1_0.Center = arg_1_2

	arg_1_2:AddSeq(arg_1_0)

	return
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0 = 1, arg_2_0._list.Count do
		arg_2_0._list.Head.Data:Dispose()
	end

	arg_2_0._list:Clear()

	return
end

function var_0_0.Add(arg_3_0, arg_3_1)
	arg_3_0._list:AddLast(arg_3_1)

	return
end

function var_0_0.Wait(arg_4_0)
	arg_4_0._wait = true

	return
end

function var_0_0.Resume(arg_5_0)
	arg_5_0._wait = false

	return
end

function var_0_0.Update(arg_6_0)
	if arg_6_0._wait then
		return false
	end

	while arg_6_0._list.Count > 0 do
		if not arg_6_0._list.Head.Data.Finish then
			arg_6_0._list.Head.Data:UpdateNode()

			if not arg_6_0._list.Head.Data.Finish then
				return false
			else
				arg_6_0._list:RemoveFirst()
			end
		else
			arg_6_0._list:RemoveFirst()
		end
	end

	return true
end

function var_0_0.IsFinish(arg_7_0)
	for iter_7_0 = 1, arg_7_0._list.Count do
		if not arg_7_0._list.Head.Data.Finish then
			return false
		end
	end

	return true
end

return
