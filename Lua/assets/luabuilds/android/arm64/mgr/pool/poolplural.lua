local var_0_0 = require("Mgr/Pool/PoolUtil")
local var_0_1 = class("PoolPlural")
local var_0_2 = "UnityEngine.GameObject"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = getmetatable(arg_1_1)

	if not var_1_0 or var_1_0[".name"] ~= var_0_2 then
		local var_1_2 = "Poolplural should use gameobject as prefab not transform "

		if arg_1_1 then
			local var_1_3 = arg_1_1.name or "NIL"

			var_1_1(var_1_2 .. var_1_3)

			arg_1_0.prefab = arg_1_1
			arg_1_0.capacity = arg_1_2
			arg_1_0.index = 0
			arg_1_0.items = {}
			arg_1_0.balance = 0

			return
		end
	end
end

function var_0_1.Enqueue(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.balance = arg_2_0.balance - 1

	if #arg_2_0.items < arg_2_0.capacity and (arg_2_0.keep or not arg_2_2) then
		table.insert(arg_2_0.items, arg_2_1)

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

	while IsNil(var_3_0) and #arg_3_0.items > 0 do
		var_3_0 = table.remove(arg_3_0.items)
	end

	if IsNil(var_3_0) then
		var_3_0 = arg_3_0:NewItem()
	end

	return var_3_0
end

function var_0_1.NewItem(arg_4_0)
	return Object.Instantiate(arg_4_0.prefab)
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
	while #arg_7_0.items > 0 do
		var_0_0.Destroy(table.remove(arg_7_0.items))
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
