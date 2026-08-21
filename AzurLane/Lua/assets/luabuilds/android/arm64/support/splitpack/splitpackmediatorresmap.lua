local var_0_0 = {}

SplitPackMediatorResMap = {}
;({}).TryGetList = function(arg_1_0)
	return (var_0_0.MergeLuaArr(var_0_0.TryGetConfigList(arg_1_0), (var_0_0.TryGetLogicList(arg_1_0))))
end
;({}).GetUIPreloadList = function(arg_2_0)
	return (_.map(arg_2_0.context.viewComponent:preloadUIList(), function(arg_3_0)
		return "ui/" .. arg_3_0
	end))
end
;({}).GetBGMList = function(arg_4_0)
	local var_4_0 = arg_4_0.context.viewComponent:getBGM()

	if var_4_0 then
		return {
			"cue/bgm-" .. var_4_0 .. ".b"
		}
	end

	return {}
end
;({}).TryGetConfigList = function(arg_5_0)
	local var_5_0 = {}

	if pg.split_pack_config[arg_5_0.context.mediator.__cname] then
		var_5_0 = pg.split_pack_config[arg_5_0.context.mediator.__cname].res_list
	end

	local var_5_1 = pg.split_pack_config[arg_5_0.context.viewComponent.__cname]
	local var_5_2 = {}

	if pg.split_pack_config[arg_5_0.context.viewComponent.__cname] then
		var_5_2 = var_5_1.res_list
	end

	return (var_0_0.MergeLuaArr(var_5_0, var_5_2))
end
;({}).TryGetLogicList = function(arg_6_0)
	local var_6_0 = {}

	if var_0_0.LogicMap[arg_6_0.context.mediator.__cname] and type(var_0_0.LogicMap[arg_6_0.context.mediator.__cname]) == "function" then
		var_6_0 = var_0_0.LogicMap[arg_6_0.context.mediator.__cname](arg_6_0)
	end

	local var_6_1 = var_0_0.LogicMap[arg_6_0.context.viewComponent.__cname]
	local var_6_2 = {}

	if var_0_0.LogicMap[arg_6_0.context.viewComponent.__cname] and type(var_6_1) == "function" then
		var_6_2 = var_6_1(arg_6_0)
	end

	local var_6_3 = {}

	if arg_6_0.context.viewComponent.getResource and type(arg_6_0.context.viewComponent.getResource) == "function" then
		var_6_3 = arg_6_0.context.viewComponent:getResource()
	end

	return (var_0_0.MergeLuaArr(var_6_0, var_6_2, var_6_3))
end
;({}).MergeLuaArr = function(...)
	for iter_7_0, iter_7_1 in ipairs({
		...
	}) do
		if iter_7_1 then
			for iter_7_2 = 1, #iter_7_1 do
				({})[#{} + 1] = iter_7_1[iter_7_2]
			end
		end
	end

	return {}
end
;({}).LogicMap = {}
;({}).LogicMap.LoginScene = function(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3, var_8_4 = getLoginConfig()

	if var_8_2 and var_8_2 ~= "" then
		table.insert({
			"effect/" .. var_8_1,
			"loadingbg_hx/" .. var_8_1,
			"loadingbg/" .. var_8_1
		}, "cue/bgm-" .. var_8_2 .. ".b")
	end

	return (var_0_0.MergeLuaArr({
		"effect/" .. var_8_1,
		"loadingbg_hx/" .. var_8_1,
		"loadingbg/" .. var_8_1
	}, var_0_0.GetUIPreloadList(arg_8_0), (var_0_0.GetBGMList(arg_8_0))))
end
;({}).LogicMap.CombatLoadUI = function(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = CombatLoadUI.GetTotalResourceList(arg_9_0.context.data)

	if var_9_0 and #var_9_0 > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			iter_9_1 = string.lower(iter_9_1)

			table.insert({}, iter_9_1)
		end
	end

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_9_0), var_0_0.GetBGMList(arg_9_0), CombatLoadUI.EnsureBaseBGList(), {}, var_9_2))
end
;({}).LogicMap.BattleScene = function(arg_10_0)
	local var_10_0 = var_0_0.GetUIPreloadList(arg_10_0)
	local var_10_1 = {}
	local var_10_2
	local var_10_3 = arg_10_0.context.data
	local var_10_4 = arg_10_0.context.data.system == SYSTEM_WORLD and checkExist(pg.world_expedition_data[var_10_3.stageId], {
		"bgm"
	}) or ""

	table.insert({}, var_10_4)
	table.insert(var_10_1, pg.expedition_data_template[var_10_3.stageId].bgm)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1 ~= "" then
			var_10_2 = iter_10_1

			break
		end
	end

	if #var_10_1 == 0 then
		var_10_2 = getBGM(arg_10_0.context.viewComponent.__cname)
	end

	if var_10_2 then
		var_10_1 = {
			"cue/bgm-" .. var_10_2 .. ".b"
		}
	end

	return (var_0_0.MergeLuaArr(var_10_0, var_10_1))
end
;({}).LogicMap.NewPlayerScene = function(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	_.each({
		101171,
		201211,
		401231
	}, function(arg_12_0)
		PaintingGroupConst.AddPaintingNameByShipConfigID(var_11_0, arg_12_0)
		_.each(pg.ship_data_template[arg_12_0].buff_list_display, function(arg_13_0)
			table.insert(var_11_1, "skillicon/" .. getSkillConfig(arg_13_0).icon)

			return
		end)

		local var_12_0 = Ship.New({
			configId = arg_12_0
		}):getPrefab()

		table.insert(var_11_2, "char/" .. var_12_0)
		table.insert(var_11_2, "char/" .. var_12_0 .. "_hx")

		return
	end)

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_11_0), var_0_0.GetBGMList(arg_11_0), {}, {}, {}))
end
;({}).LogicMap.SkillInfoLayer = function(arg_14_0)
	table.insert({}, "skillicon/" .. getSkillConfig(arg_14_0.context.data.skillId).icon)

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_14_0), var_0_0.GetBGMList(arg_14_0), {}))
end
;({}).LogicMap.NewMainScene = function(arg_15_0)
	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_15_0), (var_0_0.GetBGMList(arg_15_0))))
end

return {}
