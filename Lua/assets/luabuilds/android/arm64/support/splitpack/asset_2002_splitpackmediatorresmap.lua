local var_0_0 = {}

SplitPackMediatorResMap = var_0_0

function var_0_0.TryGetList(arg_1_0)
	return (var_0_0.MergeLuaArr(var_0_0.TryGetConfigList(arg_1_0), (var_0_0.TryGetLogicList(arg_1_0))))
end

function var_0_0:GetUIPreloadList()
	return (_.map(self.context.viewComponent:preloadUIList(), function(arg_3_0)
		return "ui/" .. arg_3_0
	end))
end

function var_0_0:GetBGMList()
	local var_4_0 = self.context.viewComponent:getBGM()

	if var_4_0 then
		return {
			"cue/bgm-" .. var_4_0 .. ".b"
		}
	end

	return {}
end

function var_0_0:TryGetConfigList()
	return (var_0_0.MergeLuaArr((pg.split_pack_config[self.context.mediator.__cname] or nil) and pg.split_pack_config[self.context.mediator.__cname].res_list, (pg.split_pack_config[self.context.viewComponent.__cname] or nil) and pg.split_pack_config[self.context.viewComponent.__cname].res_list))
end

function var_0_0:TryGetLogicList()
	local var_6_0 = {}

	if var_0_0.LogicMap[self.context.mediator.__cname] and type(var_0_0.LogicMap[self.context.mediator.__cname]) == "function" then
		var_6_0 = var_0_0.LogicMap[self.context.mediator.__cname](self)
	end

	local var_6_1 = var_0_0.LogicMap[self.context.viewComponent.__cname]

	return (var_0_0.MergeLuaArr(var_6_0, (var_0_0.LogicMap[self.context.viewComponent.__cname] and type(var_6_1) == "function" or nil) and var_6_1(self), (self.context.viewComponent.getResource and type(self.context.viewComponent.getResource) == "function" or nil) and self.context.viewComponent:getResource()))
end

function var_0_0.MergeLuaArr(...)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs({
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

var_0_0.LogicMap = {}

function var_0_0.LogicMap.LoginScene(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3, var_8_4 = getLoginConfig()
	local var_8_5 = {
		"effect/" .. var_8_1,
		"loadingbg_hx/" .. var_8_1,
		"loadingbg/" .. var_8_1
	}

	if var_8_2 and var_8_2 ~= "" then
		table.insert(var_8_5, "cue/bgm-" .. var_8_2 .. ".b")
	end

	return (var_0_0.MergeLuaArr(var_8_5, var_0_0.GetUIPreloadList(arg_8_0), (var_0_0.GetBGMList(arg_8_0))))
end

function var_0_0.LogicMap:CombatLoadUI()
	local var_9_0 = {}
	local var_9_1, var_9_2, var_9_3 = CombatLoadUI.GetTotalResourceList(self.context.data)

	if var_9_1 and #var_9_1 > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			iter_9_1 = string.lower(iter_9_1)

			table.insert(var_9_0, iter_9_1)
		end
	end

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(self), var_0_0.GetBGMList(self), CombatLoadUI.EnsureBaseBGList(), var_9_0, var_9_3))
end

function var_0_0.LogicMap:BattleScene()
	local var_10_0 = var_0_0.GetUIPreloadList(self)
	local var_10_1 = {}
	local var_10_2
	local var_10_3 = self.context.data

	table.insert(var_10_1, self.context.data.system == SYSTEM_WORLD and checkExist(pg.world_expedition_data[var_10_3.stageId], {
		"bgm"
	}) or "")
	table.insert(var_10_1, pg.expedition_data_template[var_10_3.stageId].bgm)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1 ~= "" then
			var_10_2 = iter_10_1

			break
		end
	end

	if #var_10_1 == 0 then
		var_10_2 = getBGM(self.context.viewComponent.__cname)
	end

	if var_10_2 then
		var_10_1 = {
			"cue/bgm-" .. var_10_2 .. ".b"
		}
	end

	return (var_0_0.MergeLuaArr(var_10_0, var_10_1))
end

function var_0_0.LogicMap.NewPlayerScene(arg_11_0)
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

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_11_0), var_0_0.GetBGMList(arg_11_0), var_11_0, var_11_1, var_11_2))
end

function var_0_0.LogicMap:SkillInfoLayer()
	local var_14_0 = {}

	table.insert(var_14_0, "skillicon/" .. getSkillConfig(self.context.data.skillId).icon)

	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(self), var_0_0.GetBGMList(self), var_14_0))
end

function var_0_0.LogicMap.NewMainScene(arg_15_0)
	return (var_0_0.MergeLuaArr(var_0_0.GetUIPreloadList(arg_15_0), (var_0_0.GetBGMList(arg_15_0))))
end

return var_0_0
