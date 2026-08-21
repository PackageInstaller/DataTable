pg = pg or {}

local var_0_0 = pg
local var_0_1 = require("Mgr/Pool/PoolUtil")
local var_0_2 = class("Pool")

pg.Pool = var_0_2

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	assert(arg_1_2, "template or transform should exist")

	arg_1_0.template = arg_1_2
	arg_1_0.keepParent = arg_1_5
	arg_1_0.parentTF = arg_1_1
	arg_1_0.templateActive = arg_1_2.activeSelf
	arg_1_0.parentActive = arg_1_1.gameObject.activeSelf
	arg_1_0.keepActive = arg_1_6
	arg_1_0.min = arg_1_3
	arg_1_0.list = ys.LinkList.New()
	arg_1_0.map = {}
	arg_1_0.usedEnd = nil
	arg_1_0.resizeTime = arg_1_4

	return
end

function var_0_2.InitSize(arg_2_0, arg_2_1)
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

function var_0_2.SetInitFuncs(arg_3_0, arg_3_1)
	arg_3_0.initFunc = arg_3_1

	return
end

function var_0_2.SetRecycleFuncs(arg_4_0, arg_4_1)
	arg_4_0.recycleFunc = arg_4_1

	return
end

function var_0_2.IsEmpty(arg_5_0)
	return arg_5_0.usedEnd == arg_5_0.list.Tail
end

function var_0_2.GetRootTF(arg_6_0)
	return arg_6_0.parentTF
end

function var_0_2.GetObject(arg_7_0)
	local var_7_0
	local var_7_1 = arg_7_0.usedEnd

	if not arg_7_0:IsEmpty() then
		var_7_1 = var_7_1 == nil and arg_7_0.list.Head or arg_7_0.usedEnd.Next

		while var_7_1 do
			var_7_0 = var_7_1.Data

			if var_7_1.Data and not IsNil(var_7_0) and var_7_0.transform and not IsNil(var_7_0.transform) then
				arg_7_0.usedEnd = var_7_1
				arg_7_0.map[var_7_0] = var_7_1

				LuaHelper.ResetTF(var_7_0.transform)

				if not arg_7_0.keepActive and arg_7_0.parentActive then
					var_7_0:SetActive(true)
				end

				break
			end

			arg_7_0.map[var_7_0] = nil
			var_7_1 = var_7_1.Next, arg_7_0.list:Remove(var_7_1)
		end
	else
		var_7_0 = Object.Instantiate(arg_7_0.template)

		if not arg_7_0.templateActive then
			var_7_0:SetActive(true)
		end

		if arg_7_0.keepParent then
			var_7_0.transform:SetParent(arg_7_0.parentTF, false)
		end

		if arg_7_0.initFunc then
			arg_7_0.initFunc(var_7_0)
		end

		local var_7_2 = arg_7_0.list:AddLast(var_7_0)

		arg_7_0.usedEnd = var_7_2
		arg_7_0.map[var_7_0] = var_7_2
	end

	return var_7_0
end

function var_0_2.ResetParent(arg_8_0, arg_8_1)
	arg_8_0.parentTF = arg_8_1

	for iter_8_0 in arg_8_0.list:Iterator() do
		iter_8_0.Data.transform:SetParent(arg_8_0.parentTF, false)
	end

	return
end

function var_0_2.Recycle(arg_9_0, arg_9_1)
	if arg_9_0.map[arg_9_1] == nil then
		return
	end

	arg_9_0.map[arg_9_1] = nil

	if not arg_9_0.keepActive and arg_9_0.parentActive then
		arg_9_1:SetActive(false)
	end

	if not arg_9_0.keepParent then
		LuaHelper.SetGOParentTF(arg_9_1, arg_9_0.parentTF, false)
	end

	if arg_9_0.recycleFunc then
		arg_9_0.recycleFunc(arg_9_1)
	end

	if arg_9_0.usedEnd == arg_9_0.map[arg_9_1] then
		arg_9_0.usedEnd = arg_9_0.map[arg_9_1].Before
	end

	arg_9_0.list:Remove(arg_9_0.map[arg_9_1])
	arg_9_0.list:AddNodeLast(arg_9_0.map[arg_9_1])

	arg_9_0.map[arg_9_1].liveTime = var_0_0.TimeMgr.GetInstance():GetCombatTime() + arg_9_0.resizeTime

	return
end

function var_0_2.AllRecycle(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.map) do
		table.insert({}, iter_10_0)
	end

	for iter_10_2, iter_10_3 in ipairs({}) do
		arg_10_0:Recycle(iter_10_3)
	end

	return
end

function var_0_2.Resize(arg_11_0)
	if arg_11_0.list.Count <= arg_11_0.min then
		return
	end

	local var_11_0 = arg_11_0.usedEnd and arg_11_0.usedEnd.Next or arg_11_0.list.Head
	local var_11_1 = var_0_0.TimeMgr.GetInstance():GetCombatTime()
	local var_11_2 = 0

	while var_11_0 do
		if var_11_1 < var_11_0.liveTime then
			break
		end

		var_0_1.Destroy(var_11_0.Data)

		var_11_0 = var_11_0.Next, arg_11_0.list:Remove(var_11_0)
		var_11_2 = var_11_2 + 1

		if var_11_2 >= 6 or arg_11_0.list.Count <= arg_11_0.min then
			break
		end
	end

	return
end

function var_0_2.Dispose(arg_12_0)
	for iter_12_0 in arg_12_0.list:Iterator() do
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
