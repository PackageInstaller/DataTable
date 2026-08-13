class = var_0_10000

local var_0_0 = var_0_10000("CardPoolMgr")
local var_0_1 = 5
local var_0_2 = 3

function var_0_0.Ctor(arg_1_0)
	GameObject = var_1_10001
	arg_1_0.poolRoot = var_1_10001.New("CardPoolRoot")
	arg_1_0.poolDic = {}

	return
end

function var_0_0.GetCardGameObjectById(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0.poolDic
	local var_2_1

	if not arg_2_0.poolDic[arg_2_1] then
		var_2_1 = {}
	end

	var_2_0[arg_2_1] = var_2_1

	if #arg_2_0.poolDic[arg_2_1] == 0 then
		pg = var_4

		local var_2_2 = var_4.bar_card[arg_2_1].unit_res

		pg = var_2_1
		var_2_1 = var_2_1.island_unit_item[var_2_2].model

		if arg_2_3 then
			LoadAny = var_1_10006
			var_1_10006 = var_1_10006(var_2_1, nil)
			Object = var_7

			local var_2_3 = var_7.Instantiate(var_1_10006)

			arg_2_2(var_2_3)
		else
			LoadAnyAsync = var_1_10006

			var_1_10006(var_2_1, "", nil, function(arg_3_0)
				Object = var_2_10001

				local var_3_0 = var_2_10001.Instantiate(arg_3_0)

				arg_2_2(var_3_0)

				return
			end)
		end
	else
		local var_2_4 = arg_2_0.poolDic[arg_2_1][1]

		IsNil = var_2_1

		if var_2_1(var_2_4) then
			table = var_5

			var_5.remove(arg_2_0.poolDic[arg_2_1], 1)
			arg_2_0:GetCardGameObjectById(arg_2_1, arg_2_2, arg_2_3)
		else
			setActive = var_5

			var_5(var_2_4.transform, true)

			table = var_5

			var_5.remove(arg_2_0.poolDic[arg_2_1], 1)
			arg_2_2(var_2_4)
		end
	end

	return
end

function var_0_0.ReturnGameObjectById(arg_4_0, arg_4_1, arg_4_2)
	IsNil = var_1_10003

	if var_1_10003(arg_4_2) then
		return
	end

	local var_4_0

	if arg_4_1 ~= 0 or not var_0_1 then
		var_4_0 = var_0_2
	end

	if var_4_0 <= #arg_4_0.poolDic[arg_4_1] then
		GameObject = var_4

		var_4.Destroy(arg_4_2.gameObject)
	else
		table = var_4

		var_4.insert(arg_4_0.poolDic[arg_4_1], arg_4_2)

		setActive = var_4

		var_4(arg_4_2.transform, false)

		setParent = var_4

		var_4(arg_4_2.transform, arg_4_0.poolRoot.transform, false)
	end

	return
end

function var_0_0.Destroy(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.poolDic) do
		for iter_5_2 = #iter_5_1, 1, -1 do
			local var_5_0 = iter_5_1[iter_5_2]

			GameObject = var_1_10011

			var_1_10011.Destroy(var_5_0.gameObject)
		end
	end

	arg_5_0.poolDic = {}

	if arg_5_0.poolRoot then
		GameObject = var_1

		var_1.Destroy(arg_5_0.poolRoot)

		arg_5_0.poolRoot = nil
	end

	return
end

return var_0_0
