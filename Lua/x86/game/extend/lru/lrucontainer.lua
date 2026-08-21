local var_0_0 = class("LRUContainer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.limit = arg_1_1
	arg_1_0.recycleCb = arg_1_2
	arg_1_0.head = nil
	arg_1_0.tail = nil
	arg_1_0.map = {}
	arg_1_0.count = 0

	if arg_1_1 == -1 then
		arg_1_0.limit = 99999
	end
end

function var_0_0.Get(arg_2_0, arg_2_1)
	return arg_2_0.map[arg_2_1]
end

function var_0_0.Use(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.map[arg_3_1] and arg_3_0.count >= 1 then
		arg_3_0:MoveToFront(arg_3_1)

		return true
	else
		arg_3_0:AddToFront(arg_3_1, arg_3_2)

		if arg_3_0.count > arg_3_0.limit then
			local var_3_0 = arg_3_0:RemoveNode(arg_3_0.tail.key)

			if arg_3_0.recycleCb then
				arg_3_0.recycleCb(var_3_0.value)
			end
		end

		return false
	end
end

function var_0_0.RemoveNode(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.map[arg_4_1]

	if var_4_0 then
		if var_4_0.pre then
			var_4_0.pre.next = var_4_0.next
		end

		if var_4_0.next then
			var_4_0.next.pre = var_4_0.pre
		end

		if var_4_0 == arg_4_0.head then
			arg_4_0.head = var_4_0.next
		end

		if var_4_0 == arg_4_0.tail then
			arg_4_0.tail = var_4_0.pre
		end

		var_4_0.next = nil
		var_4_0.pre = nil
		arg_4_0.map[arg_4_1] = nil
		arg_4_0.count = arg_4_0.count - 1

		return var_4_0
	end

	return nil
end

function var_0_0.AddToFront(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.map[arg_5_1]

	if not var_5_0 then
		var_5_0 = LRUNode.New()
		var_5_0.value = arg_5_2
		var_5_0.key = arg_5_1
		arg_5_0.map[arg_5_1] = var_5_0
	end

	local var_5_1 = arg_5_0.head

	if not var_5_1 then
		arg_5_0.head = var_5_0
		arg_5_0.tail = var_5_0
		arg_5_0.count = arg_5_0.count + 1

		return true
	end

	var_5_0.next = var_5_1
	var_5_0.pre = var_5_1.pre
	var_5_1.pre = var_5_0
	arg_5_0.head = var_5_0
	arg_5_0.count = arg_5_0.count + 1

	return true
end

function var_0_0.MoveToFront(arg_6_0, arg_6_1)
	if not arg_6_0.map[arg_6_1] then
		return false
	end

	if arg_6_0.map[arg_6_1] == arg_6_0.head then
		return true
	end

	local var_6_0 = arg_6_0:RemoveNode(arg_6_1)

	if var_6_0 then
		arg_6_0:AddToFront(var_6_0.key, var_6_0.value)

		return true
	end

	return false
end

function var_0_0.Dispose(arg_7_0)
	local var_7_0 = arg_7_0.head

	while var_7_0 ~= nil do
		if arg_7_0.recycleCb then
			arg_7_0.recycleCb(var_7_0.value)
		end

		var_7_0 = var_7_0.next
	end
end

return var_0_0
