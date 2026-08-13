ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001
var_0.LinkList = var_0_10001("LinkList")

local var_0_1 = var_0.LinkList

var_0_1.Head = nil
var_0_1.Tail = nil
var_0_1.Count = 0

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Clear(arg_2_0)
	arg_2_0.Head = nil
	arg_2_0.Tail = nil
	arg_2_0.Count = 0

	return
end

function var_0_1.NewNode(arg_3_0, arg_3_1)
	return {
		Data = arg_3_1
	}
end

function var_0_1.IsEmpty(arg_4_0)
	return arg_4_0.Count == 0
end

function var_0_1.AddBefore(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		return nil
	end

	local var_5_0 = arg_5_0:NewNode(arg_5_2)

	if arg_5_1.Before ~= nil then
		arg_5_1.Before.Next = var_5_0
	end

	var_5_0.Before = arg_5_1.Before
	var_5_0.Next = arg_5_1
	arg_5_1.Before = var_5_0

	if arg_5_0.Head == arg_5_1 then
		arg_5_0.Head = var_5_0
	end

	arg_5_0.Count = arg_5_0.Count + 1

	return var_5_0
end

function var_0_1.AddAfter(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return nil
	end

	local var_6_0 = arg_6_0:NewNode(arg_6_2)

	if arg_6_1.Next ~= nil then
		arg_6_1.Next.Before = var_6_0
	end

	var_6_0.Next = arg_6_1.Next
	arg_6_1.Next = var_6_0
	var_6_0.Before = arg_6_1

	if arg_6_0.Tail == arg_6_1 then
		arg_6_0.Tail = var_6_0
	end

	arg_6_0.Count = arg_6_0.Count + 1

	return var_6_0
end

function var_0_1.AddFirst(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:NewNode(arg_7_1)

	return arg_7_0:AddNodeFirst(var_7_0)
end

function var_0_1.AddNodeFirst(arg_8_0, arg_8_1)
	if arg_8_0.Head ~= nil then
		arg_8_0.Head.Before = arg_8_1
	end

	arg_8_1.Next = arg_8_0.Head
	arg_8_1.Before = nil
	arg_8_0.Head = arg_8_1

	if arg_8_0.Tail == nil then
		arg_8_0.Tail = arg_8_1
	end

	arg_8_0.Count = arg_8_0.Count + 1

	return arg_8_1
end

function var_0_1.AddLast(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:NewNode(arg_9_1)

	return arg_9_0:AddNodeLast(var_9_0)
end

function var_0_1.AddNodeLast(arg_10_0, arg_10_1)
	if arg_10_0.Tail ~= nil then
		arg_10_0.Tail.Next = arg_10_1
	end

	arg_10_1.Before = arg_10_0.Tail
	arg_10_1.Next = nil
	arg_10_0.Tail = arg_10_1

	if arg_10_0.Head == nil then
		arg_10_0.Head = arg_10_1
	end

	arg_10_0.Count = arg_10_0.Count + 1

	return arg_10_1
end

function var_0_1.CopyTo(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == nil then
		return
	end

	if arg_11_2 == nil then
		arg_11_2 = 1
	end

	local var_11_0 = arg_11_0.Head

	for iter_11_0 = 1, arg_11_0.Count do
		table = var_1_10008

		var_1_10008.insert(arg_11_1, arg_11_2, var_11_0.Data)

		var_11_0 = var_11_0.Next
		arg_11_2 = arg_11_2 + 1
	end

	return
end

function var_0_1.Find(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.Head

	for iter_12_0 = 1, arg_12_0.Count do
		if var_12_0.Data == arg_12_1 then
			return var_12_0
		end

		var_12_0 = var_12_0.Next
	end

	return nil
end

function var_0_1.FindLast(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.Tail

	for iter_13_0 = 1, arg_13_0.Count do
		if var_13_0.Data == arg_13_1 then
			return var_13_0
		end

		var_13_0 = var_13_0.Before
	end

	return nil
end

function var_0_1.RemoveFirst(arg_14_0)
	arg_14_0:Remove(arg_14_0.Head)

	return
end

function var_0_1.RemoveLast(arg_15_0)
	arg_15_0:Remove(arg_15_0.Tail)

	return
end

function var_0_1.Remove(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return
	end

	if arg_16_0.Head == arg_16_1 then
		arg_16_0.Head = arg_16_1.Next
	end

	if arg_16_0.Tail == arg_16_1 then
		arg_16_0.Tail = arg_16_1.Before
	end

	if arg_16_1.Next ~= nil then
		arg_16_1.Next.Before = arg_16_1.Before
	end

	if arg_16_1.Before ~= nil then
		arg_16_1.Before.Next = arg_16_1.Next
	end

	arg_16_0.Count = arg_16_0.Count - 1

	return
end

function var_0_1.RemoveData(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:Find(arg_17_1)

	arg_17_0:Remove(var_17_0)

	return var_17_0
end

local function var_0_2(arg_18_0, arg_18_1)
	if arg_18_1 == nil then
		return arg_18_0.Head
	else
		return arg_18_1.Next
	end

	return
end

function var_0_1.Iterator(arg_19_0)
	return var_0_2, arg_19_0
end

function var_0_1.Show(arg_20_0)
	print = var_1_10001

	var_1_10001("-------- list ++ begin --------")

	for iter_20_0 in arg_20_0:Iterator() do
		print = var_1_10005

		var_1_10005(iter_20_0.Data)
	end

	print = var_1

	var_1("-------- list -- end ----------")

	return
end

return
