require = var_0_10000

local var_0_0 = var_0_10000("Mgr/Pool/PoolUtil")

class = var_1

local var_0_1 = var_1("PoolPlural")
local var_0_2 = "UnityEngine.GameObject"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	getmetatable = var_1_10003

	if not var_1_10003(arg_1_1) or var_3[".name"] ~= var_0_2 then
		warning = var_4

		local var_1_0 = "Poolplural should use gameobject as prefab not transform "
		local var_1_1

		if not arg_1_1 or not arg_1_1.name then
			var_1_1 = "NIL"
		end

		var_4(var_1_0 .. var_1_1)
	end

	arg_1_0.prefab = arg_1_1
	arg_1_0.capacity = arg_1_2
	arg_1_0.index = 0
	arg_1_0.items = {}
	arg_1_0.balance = 0

	return
end

function var_0_1.Enqueue(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.balance = arg_2_0.balance - 1

	if #arg_2_0.items < arg_2_0.capacity and (arg_2_0.keep or not arg_2_2) then
		table = var_3

		var_3.insert(arg_2_0.items, arg_2_1)

		return false
	else
		var_0_0.Destroy(arg_2_1)

		return true
	end

	return
end

function var_0_1.Dequeue(arg_3_0)
	arg_3_0.balance = arg_3_0.balance + 1

	local var_3_0

	::label_3_0::

	IsNil = var_1_10002

	if var_1_10002(var_3_0) and #arg_3_0.items > 0 then
		repeat
			table = var_1_10002
			var_3_0 = var_1_10002.remove(arg_3_0.items)

			goto label_3_0
		until true
	end

	IsNil = var_1_10002

	if var_1_10002(var_3_0) then
		var_3_0 = arg_3_0:NewItem()
	end

	return var_3_0
end

function var_0_1.NewItem(arg_4_0)
	Object = var_1_10001

	return var_1_10001.Instantiate(arg_4_0.prefab)
end

function var_0_1.AllReturned(arg_5_0)
	return arg_5_0.balance == 0 and not arg_5_0.keep
end

function var_0_1.ClearPrefab(arg_6_0)
	var_0_0.Destroy(arg_6_0.prefab)

	arg_6_0.prefab = nil

	return
end

function var_0_1.ClearItems(arg_7_0)
	::label_7_0::

	local var_7_0 = #arg_7_0.items

	if 0 < var_7_0 then
		repeat
			local var_7_1 = var_0_0.Destroy

			table = var_2

			var_7_1(var_2.remove(arg_7_0.items))

			goto label_7_0
		until true
	end

	arg_7_0.balance = 0

	return
end

function var_0_1.SetKeep(arg_8_0, arg_8_1)
	arg_8_0.keep = arg_8_1

	return
end

function var_0_1.Clear(arg_9_0)
	arg_9_0:ClearPrefab()
	arg_9_0:ClearItems()

	return
end

return var_0_1
