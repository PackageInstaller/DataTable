local var_0_0 = class("CardPoolMgr")
local var_0_1 = 5
local var_0_2 = 3

function var_0_0.Ctor(arg_1_0)
	arg_1_0.poolRoot = GameObject.New("CardPoolRoot")
	arg_1_0.poolDic = {}

	return
end

function var_0_0.GetCardGameObjectById(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.poolDic[arg_2_1] = arg_2_0.poolDic[arg_2_1] or {}

	if #arg_2_0.poolDic[arg_2_1] == 0 then
		if arg_2_3 then
			arg_2_2((Object.Instantiate((LoadAny(pg.island_unit_item[pg.bar_card[arg_2_1].unit_res].model, nil)))))
		else
			LoadAnyAsync(pg.island_unit_item[pg.bar_card[arg_2_1].unit_res].model, "", nil, function(arg_3_0)
				arg_2_2((Object.Instantiate(arg_3_0)))

				return
			end)
		end
	else
		local var_2_0 = arg_2_0.poolDic[arg_2_1][1]

		if IsNil(arg_2_0.poolDic[arg_2_1][1]) then
			table.remove(arg_2_0.poolDic[arg_2_1], 1)
			arg_2_0:GetCardGameObjectById(arg_2_1, arg_2_2, arg_2_3)
		else
			setActive(var_2_0.transform, true)
			table.remove(arg_2_0.poolDic[arg_2_1], 1)
			arg_2_2(var_2_0)
		end
	end

	return
end

function var_0_0.ReturnGameObjectById(arg_4_0, arg_4_1, arg_4_2)
	if IsNil(arg_4_2) then
		return
	end

	if arg_4_1 == 0 then
		local var_4_0 = var_0_1 or var_0_2

		if var_4_0 <= #arg_4_0.poolDic[arg_4_1] then
			GameObject.Destroy(arg_4_2.gameObject)
		else
			table.insert(arg_4_0.poolDic[arg_4_1], arg_4_2)
			setActive(arg_4_2.transform, false)
			setParent(arg_4_2.transform, arg_4_0.poolRoot.transform, false)
		end

		return
	end
end

function var_0_0.Destroy(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.poolDic) do
		for iter_5_2 = #iter_5_1, 1, -1 do
			GameObject.Destroy(iter_5_1[iter_5_2].gameObject)
		end
	end

	arg_5_0.poolDic = {}

	if arg_5_0.poolRoot then
		GameObject.Destroy(arg_5_0.poolRoot)

		arg_5_0.poolRoot = nil
	end

	return
end

return var_0_0
