pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("NodeMgr")

pg = var_1
var_1.NodeMgr = var_0_1

function var_0_1.Ctor(arg_1_0)
	return
end

var_0_1.NodeBase = {}

function var_0_1.RigisterNode(arg_2_0, arg_2_1)
	var_0_1.NodeBase[arg_2_0] = arg_2_1

	return
end

function var_0_1.Ctor(arg_3_0)
	return
end

local function var_0_2(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.NodeBase[arg_4_2[1]] == nil then
		assert = var_5

		var_5(false, "配置的节点不存在，检查“没配置串并”、“拼写错误”或“没补include”~ ：" .. arg_4_2[1])

		return
	end

	local var_4_0 = var_4.New(arg_4_1, arg_4_2)

	arg_4_3:Add(var_4_0)

	return
end

local function var_0_3(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	assert = var_1_10004
	type = var_1_10005

	local var_5_0 = var_1_10005(arg_5_2) == "table"
	local var_5_1 = "节点信息解析错误:"

	tostring = var_1_10007

	var_1_10004(var_5_0, var_5_1 .. var_1_10007(arg_5_2))

	if arg_5_2._parallel == nil then
		var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3)

		return
	end

	if var_4 == true then
		var_5_0 = var_0_1.NodeBase.Guide.New(arg_5_1)

		arg_5_3:Add(var_5_0)

		ipairs = var_6

		for iter_5_0, iter_5_1 in var_6(arg_5_2) do
			local var_5_2 = arg_5_3.Center
			local var_5_3 = var_11.NewSeq(var_5_2, iter_5_0)

			arg_5_1:AddSeq(var_5_3)

			ys = var_12

			local var_5_4 = var_12.Battle.NodeData.New(arg_5_1:GetUnit(), {}, var_5_3)

			var_5_0:AddFollow(var_5_3, var_5_4)
			var_0_3(arg_5_0, var_5_4, iter_5_1, var_5_3)
		end
	else
		ipairs = var_5_0

		for iter_5_2, iter_5_3 in var_5_0(arg_5_2) do
			var_0_3(arg_5_0, arg_5_1, iter_5_3, arg_5_3)
		end
	end

	return
end

function var_0_1.GenNode(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_3(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

	ipairs = var_4

	for iter_6_0, iter_6_1 in var_4(arg_6_1:GetAllSeq()) do
		iter_6_1:Update()
	end

	return
end

return
