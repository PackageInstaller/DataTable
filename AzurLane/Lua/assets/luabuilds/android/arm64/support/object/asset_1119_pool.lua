pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
require = var_0_10001

local var_0_1 = var_0_10001("Mgr/Pool/PoolUtil")

class = var_0_10002
var_0.Pool = var_0_10002("Pool")

function var_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	assert = var_1_10007

	var_1_10007(arg_1_2, "template or transform should exist")

	arg_1_0.template = arg_1_2
	arg_1_0.keepParent = arg_1_5
	arg_1_0.parentTF = arg_1_1
	arg_1_0.templateActive = arg_1_2.activeSelf
	arg_1_0.parentActive = arg_1_1.gameObject.activeSelf
	arg_1_0.keepActive = arg_1_6
	arg_1_0.min = arg_1_3
	ys = var_7
	arg_1_0.list = var_7.LinkList.New()
	arg_1_0.map = {}
	arg_1_0.usedEnd = nil
	arg_1_0.resizeTime = arg_1_4

	return
end

function var_2.InitSize(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or arg_2_0.min

	local var_2_0 = {}

	for iter_2_0 = 1, arg_2_1 do
		var_2_0[iter_2_0] = arg_2_0:GetObject()
	end

	for iter_2_1 = 1, arg_2_1 do
		arg_2_0:Recycle(var_2_0[iter_2_1])
	end

	return arg_2_0
end

function var_2.SetInitFuncs(arg_3_0, arg_3_1)
	arg_3_0.initFunc = arg_3_1

	return
end

function var_2.SetRecycleFuncs(arg_4_0, arg_4_1)
	arg_4_0.recycleFunc = arg_4_1

	return
end

function var_2.IsEmpty(arg_5_0)
	return arg_5_0.usedEnd == arg_5_0.list.Tail
end

function var_2.GetRootTF(arg_6_0)
	return arg_6_0.parentTF
end

function var_2.GetObject(arg_7_0)
	local var_7_0
	local var_7_1 = arg_7_0.usedEnd

	if not arg_7_0:IsEmpty() then
		if var_7_1 == nil then
			var_7_1 = arg_7_0.list.Head
		else
			var_7_1 = arg_7_0.usedEnd.Next
		end

		while var_7_1 do
			local var_7_2

			if var_7_1.Data then
				IsNil = var_7_2

				if not var_7_2(var_7_0) and var_7_0.transform then
					IsNil = var_7_2

					if not var_7_2(var_7_0.transform) then
						arg_7_0.usedEnd = var_7_1
						var_7_2 = arg_7_0.map
						var_7_2[var_7_0] = var_7_1
						LuaHelper = var_7_2

						var_7_2.ResetTF(var_7_0.transform)

						if not arg_7_0.keepActive and arg_7_0.parentActive then
							var_7_0:SetActive(true)
						end

						break
					end
				end
			end

			var_7_2 = arg_7_0.map
			var_7_2[var_7_0] = nil
			var_7_2 = var_7_1.Next

			local var_7_3 = arg_7_0.list

			var_4.Remove(var_7_3, var_7_1)

			var_7_1 = var_7_2
		end
	else
		Object = var_7_2
		var_7_0 = var_7_2.Instantiate(arg_7_0.template)

		if not arg_7_0.templateActive then
			var_7_0:SetActive(true)
		end

		if arg_7_0.keepParent then
			local var_7_4 = var_7_0.transform

			var_3.SetParent(var_7_4, arg_7_0.parentTF, false)
		end

		if arg_7_0.initFunc then
			arg_7_0.initFunc(var_7_0)
		end

		local var_7_5 = arg_7_0.list

		arg_7_0.usedEnd = var_3.AddLast(var_7_5, var_7_0)
		arg_7_0.map[var_7_0] = var_3
	end

	return var_7_0
end

function var_2.ResetParent(arg_8_0, arg_8_1)
	arg_8_0.parentTF = arg_8_1

	local var_8_0 = arg_8_0.list

	for iter_8_0 in var_2.Iterator(var_8_0) do
		local var_8_1 = iter_8_0.Data.transform

		var_6.SetParent(var_8_1, arg_8_0.parentTF, false)
	end

	return
end

function var_2.Recycle(arg_9_0, arg_9_1)
	if arg_9_0.map[arg_9_1] == nil then
		return
	end

	arg_9_0.map[arg_9_1] = nil

	if not arg_9_0.keepActive and arg_9_0.parentActive then
		arg_9_1:SetActive(false)
	end

	if not arg_9_0.keepParent then
		LuaHelper = var_3

		var_3.SetGOParentTF(arg_9_1, arg_9_0.parentTF, false)
	end

	if arg_9_0.recycleFunc then
		arg_9_0.recycleFunc(arg_9_1)
	end

	if arg_9_0.usedEnd == var_2 then
		arg_9_0.usedEnd = var_2.Before
	end

	local var_9_0 = arg_9_0.list

	var_3.Remove(var_9_0, var_2)

	local var_9_1 = arg_9_0.list

	var_3.AddNodeLast(var_9_1, var_2)

	local var_9_2 = var_0.TimeMgr.GetInstance()

	var_2.liveTime = var_3.GetCombatTime(var_9_2) + arg_9_0.resizeTime

	return
end

function var_2.AllRecycle(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.map) do
		table = var_1_10007

		var_1_10007.insert(var_10_0, iter_10_0)
	end

	ipairs = var_2

	for iter_10_2, iter_10_3 in var_2(var_10_0) do
		arg_10_0:Recycle(iter_10_3)
	end

	return
end

function var_2.Resize(arg_11_0)
	if arg_11_0.list.Count <= arg_11_0.min then
		return
	end

	local var_11_0

	if arg_11_0.usedEnd then
		var_11_0 = arg_11_0.usedEnd.Next
	else
		var_11_0 = arg_11_0.list.Head
	end

	local var_11_1 = var_0.TimeMgr.GetInstance()
	local var_11_2 = var_2.GetCombatTime(var_11_1)
	local var_11_3 = 0

	while var_11_0 do
		if var_11_2 < var_11_0.liveTime then
			break
		end

		var_0_1.Destroy(var_11_0.Data)

		local var_11_4 = var_11_0.Next
		local var_11_5 = arg_11_0.list

		var_5.Remove(var_11_5, var_11_0)

		var_11_0 = var_11_4

		if var_11_3 + 1 >= 6 or arg_11_0.list.Count <= arg_11_0.min then
			break
		end
	end

	return
end

function var_2.Dispose(arg_12_0)
	local var_12_0 = arg_12_0.list

	for iter_12_0 in var_1.Iterator(var_12_0) do
		var_0_1.Destroy(iter_12_0.Data)
	end

	arg_12_0.list = nil
	arg_12_0.map = nil
	arg_12_0.last = nil
	arg_12_0.template = nil
	arg_12_0.parentTF = nil

	return
end

return
