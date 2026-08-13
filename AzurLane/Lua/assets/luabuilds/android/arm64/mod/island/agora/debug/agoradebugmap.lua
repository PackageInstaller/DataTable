class = var_0_10000

local var_0_0 = "AgoraDebugMap"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandBaseOpView"))

Color = var_0_10001

local var_0_2 = var_0_10001.New(1, 0, 0, 1)

Color = var_0_0

local var_0_3 = var_0_0.New(0, 1, 0, 1)

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraDebugUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	setParent = var_1_10002

	local var_2_0 = arg_2_1

	pg = var_1_10005

	var_1_10002(var_2_0, var_1_10005.UIMgr.GetInstance().UIMain)

	local var_2_1 = arg_2_1.transform

	arg_2_0.tpl = var_2.Find(var_2_1, "Image")
	arg_2_0.items = {}
	arg_2_0.isInited = false

	arg_2_0:GenMap(arg_2_0.view.agora.map)

	return
end

function var_0_1.GenMap(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = 0

	pairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_1) do
		pairs = var_1_10009

		for iter_3_2, iter_3_3 in var_1_10009(iter_3_1) do
			table = var_1_10014

			var_1_10014.insert(var_3_0, function(arg_4_0)
				var_3_1 = var_3_1 + 1

				if arg_3_0.exited then
					arg_4_0()

					return
				end

				local var_4_0 = arg_3_0
				local var_4_1 = var_1.CreateItem
				local var_4_2 = {}

				Vector2 = var_2_10005
				var_4_2.position = var_2_10005(iter_3_0, iter_3_2)
				var_4_2.flag = iter_3_3

				var_4_1(var_4_0, var_4_2)

				if var_3_1 % 50 == 0 then
					onNextTick = var_1

					var_1(arg_4_0)
				else
					arg_4_0()
				end

				return
			end)
		end
	end

	seriesAsync = var_4

	var_4(var_3_0, function()
		arg_3_0.isInited = true

		local var_5_0 = arg_3_0

		var_0.FlushAll(var_5_0, arg_3_1)

		return
	end)

	return
end

function var_0_1.FlushAll(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_1) do
		pairs = var_1_10007

		for iter_6_2, iter_6_3 in var_1_10007(iter_6_1) do
			local var_6_0 = arg_6_0
			local var_6_1 = arg_6_0.UpdateItem

			Vector2 = var_1_10015

			var_6_1(var_6_0, var_1_10015(iter_6_0, iter_6_2), iter_6_3)
		end
	end

	return
end

function var_0_1.CreateItem(arg_7_0, arg_7_1)
	cloneTplTo = var_1_10002

	local var_7_0 = var_1_10002(arg_7_0.tpl, arg_7_0.tpl.transform.parent)

	var_7_0.name = arg_7_1.position.x .. "_" .. arg_7_1.position.y
	Vector3 = var_3

	local var_7_1 = var_3(10, 10, 0)
	local var_7_2 = var_7_0.transform

	Vector3 = var_5
	var_7_2.localPosition = var_5(arg_7_1.position.x * var_7_1.x, arg_7_1.position.y * var_7_1.y, 0)

	if not arg_7_0.items[arg_7_1.position.x] then
		arg_7_0.items[arg_7_1.position.x] = {}
	end

	arg_7_0.items[arg_7_1.position.x][arg_7_1.position.y] = var_7_0

	return
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.isInited then
		return
	end

	local var_8_0 = arg_8_0.items[arg_8_1.x][arg_8_1.y]
	local var_8_1 = var_3.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_8_2 = var_8_1(var_8_0, var_1_10007(var_1_10009))
	local var_8_3

	if not arg_8_2 or not var_0_3 then
		var_8_3 = var_0_2
	end

	var_8_2.color = var_8_3

	return
end

function var_0_1.OnDestroy(arg_9_0)
	arg_9_0.exited = true

	return
end

return var_0_1
