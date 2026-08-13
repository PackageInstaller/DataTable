local var_0_0 = {}
local var_0_1 = SplitPackMediatorResMap

function var_0_1.TryGetList(arg_1_0)
	local var_1_0 = var_0_1.TryGetConfigList(arg_1_0)
	local var_1_1 = var_0_1.TryGetLogicList(arg_1_0)

	return (var_0_1.MergeLuaArr(var_1_0, var_1_1))
end

function var_0_1.GetUIPreloadList(arg_2_0)
	local var_2_0 = arg_2_0.context.viewComponent
	local var_2_1 = var_1.preloadUIList(var_2_0)

	_ = var_2_0

	return (var_2_0.map(var_2_1, function(arg_3_0)
		return "ui/" .. arg_3_0
	end))
end

function var_0_1.GetBGMList(arg_4_0)
	local var_4_0 = arg_4_0.context.viewComponent

	if var_1.getBGM(var_4_0) then
		return {
			"cue/bgm-" .. var_2 .. ".b"
		}
	end

	return {}
end

function var_0_1.TryGetConfigList(arg_5_0)
	local var_5_0 = arg_5_0.context.viewComponent
	local var_5_1 = arg_5_0.context.mediator
	local var_5_2 = var_5_0.__cname
	local var_5_3 = var_5_1.__cname

	pg = var_1_10005

	local var_5_4 = var_1_10005.split_pack_config[var_5_3]
	local var_5_5 = {}

	if var_5_4 then
		var_5_5 = var_5_4.res_list
	end

	pg = var_1_10007

	local var_5_6 = var_1_10007.split_pack_config[var_5_2]
	local var_5_7 = {}

	if var_5_6 then
		var_5_7 = var_5_6.res_list
	end

	return (var_0_1.MergeLuaArr(var_5_5, var_5_7))
end

function var_0_1.TryGetLogicList(arg_6_0)
	local var_6_0 = arg_6_0.context.viewComponent
	local var_6_1 = arg_6_0.context.mediator
	local var_6_2 = var_6_0.__cname
	local var_6_3 = var_6_1.__cname
	local var_6_4 = var_0_1.LogicMap[var_6_3]
	local var_6_5 = {}

	if var_6_4 then
		type = var_1_10007

		if var_1_10007(var_6_4) == "function" then
			var_6_5 = var_6_4(arg_6_0)
		end
	end

	local var_6_6 = var_0_1.LogicMap[var_6_2]
	local var_6_7 = {}

	if var_6_6 then
		type = var_1_10009

		if var_1_10009(var_6_6) == "function" then
			var_6_7 = var_6_6(arg_6_0)
		end
	end

	local var_6_8 = {}

	if var_6_0.getResource then
		type = var_1_10011

		if var_1_10011(var_10) == "function" then
			var_6_8 = var_10(var_6_0)
		end
	end

	return (var_0_1.MergeLuaArr(var_6_5, var_6_7, var_6_8))
end

function var_0_1.MergeLuaArr(...)
	local var_7_0 = {}

	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001({
		...
	}) do
		if iter_7_1 then
			for iter_7_2 = 1, #iter_7_1 do
				var_7_0[#var_7_0 + 1] = iter_7_1[iter_7_2]
			end
		end
	end

	return var_7_0
end

var_0_1.LogicMap = {}

function var_0_1.LogicMap.LoginScene(arg_8_0)
	local var_8_0 = var_0_1.GetUIPreloadList(arg_8_0)
	local var_8_1 = var_0_1.GetBGMList(arg_8_0)

	getLoginConfig = var_3

	local var_8_2, var_8_3, var_8_4, var_8_5, var_8_6 = var_3()
	local var_8_7 = {
		"effect/" .. var_8_3,
		"loadingbg_hx/" .. var_8_3,
		"loadingbg/" .. var_8_3
	}

	if var_8_4 and var_8_4 ~= "" then
		local var_8_8 = "cue/bgm-" .. var_8_4 .. ".b"

		table = var_10

		var_10.insert(var_8_7, var_8_8)
	end

	return (var_0_1.MergeLuaArr(var_8_7, var_8_0, var_8_1))
end

function var_0_1.LogicMap.CombatLoadUI(arg_9_0)
	local var_9_0 = var_0_1.GetUIPreloadList(arg_9_0)
	local var_9_1 = var_0_1.GetBGMList(arg_9_0)

	CombatLoadUI = var_3

	local var_9_2 = var_3.EnsureBaseBGList()
	local var_9_3 = {}

	CombatLoadUI = var_1_10005

	local var_9_4, var_9_5, var_9_6 = var_1_10005.GetTotalResourceList(arg_9_0.context.data)

	if var_9_4 and #var_9_4 > 0 then
		ipairs = var_8

		for iter_9_0, iter_9_1 in var_8(var_9_4) do
			string = var_1_10013
			iter_9_1 = var_1_10013.lower(iter_9_1)
			table = var_1_10013

			var_1_10013.insert(var_9_3, iter_9_1)
		end
	end

	return (var_0_1.MergeLuaArr(var_9_0, var_9_1, var_9_2, var_9_3, var_9_6))
end

function var_0_1.LogicMap.BattleScene(arg_10_0)
	local var_10_0 = var_0_1.GetUIPreloadList(arg_10_0)
	local var_10_1 = {}
	local var_10_2
	local var_10_3 = arg_10_0.context.data

	table = var_1_10005

	local var_10_4 = var_1_10005.insert
	local var_10_5 = var_10_1
	local var_10_6 = var_10_3.system

	SYSTEM_WORLD = var_1_10008

	if var_10_6 == var_1_10008 then
		checkExist = var_10_6
		pg = var_1_10008

		local var_10_7

		if not var_10_6(var_1_10008.world_expedition_data[var_10_3.stageId], {
			"bgm"
		}) then
			var_10_7 = ""
		end

		var_10_4(var_10_5, var_10_7)

		table = var_10_4

		local var_10_8 = var_10_4.insert
		local var_10_9 = var_10_1

		pg = var_10_7

		var_10_8(var_10_9, var_10_7.expedition_data_template[var_10_3.stageId].bgm)

		ipairs = var_10_8

		for iter_10_0, iter_10_1 in var_10_8(var_10_1) do
			if iter_10_1 ~= "" then
				var_10_2 = iter_10_1

				break
			end
		end

		if #var_10_1 == 0 then
			getBGM = var_5
			var_10_2 = var_5(arg_10_0.context.viewComponent.__cname)
		end

		if var_10_2 then
			local var_10_10 = "cue/bgm-" .. var_10_2 .. ".b"

			var_10_1 = {
				var_10_10
			}
		end

		return (var_0_1.MergeLuaArr(var_10_0, var_10_1))
	end
end

function var_0_1.LogicMap.NewPlayerScene(arg_11_0)
	local var_11_0 = var_0_1.GetUIPreloadList(arg_11_0)
	local var_11_1 = var_0_1.GetBGMList(arg_11_0)
	local var_11_2 = {}
	local var_11_3 = {}
	local var_11_4 = {}
	local var_11_5 = {
		101171,
		201211,
		401231
	}

	_ = var_1_10007

	var_1_10007.each(var_11_5, function(arg_12_0)
		PaintingGroupConst = var_2_10001

		var_2_10001.AddPaintingNameByShipConfigID(var_11_2, arg_12_0)

		pg = var_1

		local var_12_0 = var_1.ship_data_template[arg_12_0]

		_ = var_2

		var_2.each(var_12_0.buff_list_display, function(arg_13_0)
			getSkillConfig = var_3_10001

			local var_13_0 = var_3_10001(arg_13_0)

			table = var_2

			var_2.insert(var_11_3, "skillicon/" .. var_13_0.icon)

			return
		end)

		Ship = var_2

		local var_12_1 = var_2.New({
			configId = arg_12_0
		})
		local var_12_2 = var_2.getPrefab(var_12_1)

		table = var_12_1

		var_12_1.insert(var_11_4, "char/" .. var_12_2)

		table = var_4

		var_4.insert(var_11_4, "char/" .. var_12_2 .. "_hx")

		return
	end)

	return (var_0_1.MergeLuaArr(var_11_0, var_11_1, var_11_2, var_11_3, var_11_4))
end

function var_0_1.LogicMap.SkillInfoLayer(arg_14_0)
	local var_14_0 = var_0_1.GetUIPreloadList(arg_14_0)
	local var_14_1 = var_0_1.GetBGMList(arg_14_0)
	local var_14_2 = {}
	local var_14_3 = arg_14_0.context.data.skillId

	getSkillConfig = var_1_10006

	local var_14_4 = var_1_10006(var_14_3)

	table = var_7

	var_7.insert(var_14_2, "skillicon/" .. var_14_4.icon)

	return (var_0_1.MergeLuaArr(var_14_0, var_14_1, var_14_2))
end

function var_0_1.LogicMap.NewMainScene(arg_15_0)
	local var_15_0 = var_0_1.GetUIPreloadList(arg_15_0)
	local var_15_1 = var_0_1.GetBGMList(arg_15_0)

	return (var_0_1.MergeLuaArr(var_15_0, var_15_1))
end

return var_0_1
