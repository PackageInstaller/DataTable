ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
class = ys

local var_0_1 = var_0("Sequence")

ys = var_0_10001
var_0_10001.Sequence = var_0_1
var_0_1.Name = ""
var_0_1._list = nil
var_0_1.Center = nil
var_0_1._wait = false

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.Name = arg_1_1
	ys = var_1_10003
	arg_1_0._list = var_1_10003.LinkList.New()
	arg_1_0.Center = arg_1_2

	arg_1_2:AddSeq(arg_1_0)

	return
end

function var_0_1.Dispose(arg_2_0)
	local var_2_0 = arg_2_0._list.Head

	for iter_2_0 = 1, arg_2_0._list.Count do
		local var_2_1 = var_2_0.Data

		var_6.Dispose(var_2_1)

		var_2_0 = var_2_0.Next
	end

	local var_2_2 = arg_2_0._list

	var_2.Clear(var_2_2)

	return
end

function var_0_1.Add(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._list

	var_2.AddLast(var_3_0, arg_3_1)

	return
end

function var_0_1.Wait(arg_4_0)
	arg_4_0._wait = true

	return
end

function var_0_1.Resume(arg_5_0)
	arg_5_0._wait = false

	return
end

function var_0_1.Update(arg_6_0)
	if arg_6_0._wait then
		return false
	end

	while arg_6_0._list.Count > 0 do
		if not arg_6_0._list.Head.Data.Finish then
			var_1:UpdateNode()

			if not var_1.Finish then
				return false
			else
				local var_6_0 = arg_6_0._list

				var_2.RemoveFirst(var_6_0)
			end
		else
			local var_6_1 = arg_6_0._list

			var_2.RemoveFirst(var_6_1)
		end
	end

	return true
end

function var_0_1.IsFinish(arg_7_0)
	local var_7_0 = arg_7_0._list.Head

	for iter_7_0 = 1, arg_7_0._list.Count do
		if not var_7_0.Data.Finish then
			return false
		end
	end

	return true
end

return
