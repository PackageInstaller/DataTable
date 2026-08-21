local var_0_0 = class("TechnologyConst")

var_0_0.OPEN_TECHNOLOGY_TREE_SCENE = "TechnologyConst:OPEN_TECHNOLOGY_TREE_SCENE"
var_0_0.OPEN_SHIP_BUFF_DETAIL = "TechnologyConst:OPEN_SHIP_BUFF_DETAIL"
var_0_0.OPEN_TECHNOLOGY_NATION_LAYER = "TechnologyConst:OPEN_TECHNOLOGY_NATION_LAYER"
var_0_0.CLOSE_TECHNOLOGY_NATION_LAYER = "TechnologyConst:CLOSE_TECHNOLOGY_NATION_LAYER"
var_0_0.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION = "TechnologyConst:CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION"
var_0_0.OPEN_ALL_BUFF_DETAIL = "TechnologyConst:OPEN_ALL_BUFF_DETAIL"
var_0_0.UPDATE_REDPOINT_ON_TOP = "TechnologyConst:UPDATE_REDPOINT_ON_TOP"
var_0_0.CLICK_UP_TEC_BTN = "TechnologyConst:CLICK_UP_TEC_BTN"
var_0_0.START_TEC_BTN_SUCCESS = "TechnologyConst:START_TEC_BTN_SUCCESS"
var_0_0.FINISH_UP_TEC = "TechnologyConst:FINISH_UP_TEC"
var_0_0.FINISH_TEC_SUCCESS = "TechnologyConst:FINISH_TEC_SUCCESS"
var_0_0.GOT_TEC_CAMP_AWARD = "TechnologyConst:GOT_TEC_CAMP_AWARD"
var_0_0.GOT_TEC_CAMP_AWARD_ONESTEP = "TechnologyConst:GOT_TEC_CAMP_AWARD_ONESTEP"
var_0_0.SET_TEC_ATTR_ADDITION_FINISH = "TechnologyConst:SET_TEC_ATTR_ADDITION_FINISH"
var_0_0.SHIP_LEVEL_FOR_BUFF = 120
var_0_0.AtlasName = "ui/technologytreeui_atlas"
var_0_0.QUEUE_TOTAL_COUNT = 5
var_0_0.NationOrder = {
	Nation.US,
	Nation.EN,
	Nation.JP,
	Nation.DE,
	Nation.CN,
	Nation.SN,
	Nation.FF,
	Nation.MNF,
	Nation.ITA,
	Nation.NL,
	Nation.LDP
}
var_0_0.NationResName = {
	"nation_all_",
	"nation_baiying_",
	"nation_huangjia_",
	"nation_chongying_",
	"nation_tiexue_",
	"nation_donghuang_",
	"nation_beilian_",
	"nation_ziyou_",
	"nation_weixi_",
	"nation_sading_",
	"nation_yujinwangguo_",
	"nation_jinghuanlianmeng_"
}

if LOCK_NATION_HNLMS then
	table.removebyvalue(var_0_0.NationOrder, Nation.NL)
	table.removebyvalue(var_0_0.NationResName, "nation_yujinwangguo_")
end

var_0_0.TECH_NATION_ATTRS = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Armor,
	AttributeType.Hit,
	AttributeType.Dodge,
	AttributeType.Speed,
	AttributeType.Luck,
	AttributeType.AntiSub
}

function var_0_0.GetNationSpriteByIndex(arg_1_0)
	return GetSpriteFromAtlas(var_0_0.AtlasName, var_0_0.NationResName[arg_1_0] .. "01"), (GetSpriteFromAtlas(var_0_0.AtlasName, var_0_0.NationResName[arg_1_0] .. "02"))
end

var_0_0.TypeOrder = {
	{
		ShipType.QuZhu
	},
	{
		ShipType.QingXun
	},
	{
		ShipType.ZhongXun,
		ShipType.ChaoXun
	},
	{
		ShipType.QingHang,
		ShipType.ZhengHang
	},
	{
		ShipType.ZhanXun,
		ShipType.ZhanLie
	},
	{
		ShipType.QianTing,
		ShipType.QianMu
	},
	{
		ShipType.WeiXiu,
		ShipType.ZhongPao,
		ShipType.Yunshu,
		ShipType.HangZhan,
		ShipType.FengFanS,
		ShipType.FengFanV,
		ShipType.FengFanM
	}
}
var_0_0.TypeResName = {
	"type_qvzhu_",
	"type_qingxun_",
	"type_zhongxun_",
	"type_hangmu_",
	"type_zhanlie_",
	"type_qianting_",
	"type_other_",
	"type_all_"
}

function var_0_0.GetTypeSpriteByIndex(arg_2_0)
	return GetSpriteFromAtlas(var_0_0.AtlasName, var_0_0.TypeResName[arg_2_0] .. "01"), (GetSpriteFromAtlas(var_0_0.AtlasName, var_0_0.TypeResName[arg_2_0] .. "02"))
end

function var_0_0.ClassToGroupIDList()
	for iter_3_0, iter_3_1 in ipairs(pg.fleet_tech_ship_template.all) do
		if ({})[pg.fleet_tech_ship_template[iter_3_1].class] then
			table.insert(({})[pg.fleet_tech_ship_template[iter_3_1].class], iter_3_1)
		else
			({})[pg.fleet_tech_ship_template[iter_3_1].class] = {
				iter_3_1
			}
		end
	end

	return {}
end

function var_0_0.GetOrderClassList()
	for iter_4_0, iter_4_1 in ipairs(pg.fleet_tech_ship_class.all) do
		if pg.fleet_tech_ship_class[iter_4_1].nation ~= Nation.META and pg.fleet_tech_ship_class[iter_4_1].nation ~= Nation.MOT then
			table.insert({}, iter_4_1)
		end
	end

	table.sort({}, function(arg_5_0, arg_5_1)
		local var_5_0 = pg.fleet_tech_ship_class[arg_5_0].t_level == pg.fleet_tech_ship_class[arg_5_1].t_level and pg.fleet_tech_ship_class[arg_5_0].t_level_1 > pg.fleet_tech_ship_class[arg_5_1].t_level_1 or pg.fleet_tech_ship_class[arg_5_0].t_level > pg.fleet_tech_ship_class[arg_5_1].t_level

		return var_5_0
	end)

	return {}
end

var_0_0.MetaClassConfig = nil
var_0_0.MotClassConfig = nil

function var_0_0.CreateMetaClassConfig()
	if var_0_0.MetaClassConfig or var_0_0.MotClassConfig then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(pg.fleet_tech_ship_class.all) do
		if pg.fleet_tech_ship_class[iter_6_1].nation == Nation.META then
			if var_0_0.MetaClassConfig == nil then
				var_0_0.MetaClassConfig = {}
			end

			local var_6_0 = pg.fleet_tech_ship_class[iter_6_1].t_level

			if var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level] == nil then
				var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level] = {}
			end

			if var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships == nil then
				var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships = {}
			end

			local var_6_1 = i18n("meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level)

			if var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1] == nil then
				var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1] = {}
			end

			if var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList == nil then
				var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList = {}
			end

			if not table.contains(var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList, pg.fleet_tech_ship_class[iter_6_1].t_level_1) then
				table.insert(var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList, pg.fleet_tech_ship_class[iter_6_1].t_level_1)
			end

			local var_6_2 = var_0_0.MetaClassConfig["meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level]

			var_6_2.id = "meta_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level
			var_6_2.name = var_6_1
			var_6_2.nation = pg.fleet_tech_ship_class[iter_6_1].nation
			var_6_2.t_level = var_6_0

			table.insert(var_6_2.ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1], pg.fleet_tech_ship_class[iter_6_1].ships[1])
		elseif pg.fleet_tech_ship_class[iter_6_1].nation == Nation.MOT then
			if var_0_0.MotClassConfig == nil then
				var_0_0.MotClassConfig = {}
			end

			local var_6_3 = pg.fleet_tech_ship_class[iter_6_1].t_level

			if var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level] == nil then
				var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level] = {}
			end

			if var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships == nil then
				var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships = {}
			end

			local var_6_4 = i18n("mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level)

			if var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1] == nil then
				var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1] = {}
			end

			if var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList == nil then
				var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList = {}
			end

			if not table.contains(var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList, pg.fleet_tech_ship_class[iter_6_1].t_level_1) then
				table.insert(var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level].indexList, pg.fleet_tech_ship_class[iter_6_1].t_level_1)
			end

			local var_6_5 = var_0_0.MotClassConfig["mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level]

			var_6_5.id = "mot_class_t_level_" .. pg.fleet_tech_ship_class[iter_6_1].t_level
			var_6_5.name = var_6_4
			var_6_5.nation = pg.fleet_tech_ship_class[iter_6_1].nation
			var_6_5.t_level = var_6_3

			table.insert(var_6_5.ships[pg.fleet_tech_ship_class[iter_6_1].t_level_1], pg.fleet_tech_ship_class[iter_6_1].ships[1])
		end
	end

	if var_0_0.MetaClassConfig then
		for iter_6_2, iter_6_3 in pairs(var_0_0.MetaClassConfig) do
			local var_6_6 = {}

			for iter_6_4, iter_6_5 in ipairs(iter_6_3.indexList) do
				_.each(iter_6_3.ships[iter_6_5], function(arg_7_0)
					table.insert(var_6_6, arg_7_0)

					return
				end)
			end

			iter_6_3.ships = {}
		end
	end

	if var_0_0.MotClassConfig then
		for iter_6_6, iter_6_7 in pairs(var_0_0.MotClassConfig) do
			local var_6_7 = {}

			for iter_6_8, iter_6_9 in ipairs(iter_6_7.indexList) do
				_.each(iter_6_7.ships[iter_6_9], function(arg_8_0)
					table.insert(var_6_7, arg_8_0)

					return
				end)
			end

			iter_6_7.ships = {}
		end
	end

	return
end

function var_0_0.GetOrderMetaClassList(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(pg.gameset.meta_tech_sort.description) do
		for iter_9_2, iter_9_3 in pairs(var_0_0.MetaClassConfig) do
			if iter_9_1 == iter_9_3.t_level then
				table.insert({}, iter_9_3)

				break
			end
		end
	end

	for iter_9_4, iter_9_5 in ipairs({}) do
		local var_9_0 = (not arg_9_0 or #arg_9_0 == 0) and iter_9_5.ships or _.select(iter_9_5.ships, function(arg_10_0)
			return table.contains(arg_9_0, (var_0_0.GetShipTypeByGroupID(arg_10_0)))
		end)

		if #var_9_0 > 0 then
			table.insert({}, iter_9_5.id)
		end
	end

	return {}
end

function var_0_0.GetOrderMotClassList(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(pg.gameset.tech_sort_mot.description) do
		for iter_11_2, iter_11_3 in pairs(var_0_0.MotClassConfig) do
			if iter_11_1 == iter_11_3.t_level then
				table.insert({}, iter_11_3)

				break
			end
		end
	end

	for iter_11_4, iter_11_5 in ipairs({}) do
		local var_11_0 = (not arg_11_0 or #arg_11_0 == 0) and iter_11_5.ships or _.select(iter_11_5.ships, function(arg_12_0)
			return table.contains(arg_11_0, (var_0_0.GetShipTypeByGroupID(arg_12_0)))
		end)

		if #var_11_0 > 0 then
			table.insert({}, iter_11_5.id)
		end
	end

	return {}
end

function var_0_0.GetMetaClassConfig(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.MetaClassConfig[arg_13_0]
	local var_13_1 = (not arg_13_1 or #arg_13_1 == 0) and var_0_0.MetaClassConfig[arg_13_0].ships or _.select(var_0_0.MetaClassConfig[arg_13_0].ships, function(arg_14_0)
		return table.contains(arg_13_1, (var_0_0.GetShipTypeByGroupID(arg_14_0)))
	end)

	return {
		id = var_13_0.id,
		name = var_13_0.name,
		nation = var_13_0.nation,
		ships = var_13_1
	}
end

function var_0_0.GetMotClassConfig(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.MotClassConfig[arg_15_0]
	local var_15_1 = (not arg_15_1 or #arg_15_1 == 0) and var_0_0.MotClassConfig[arg_15_0].ships or _.select(var_0_0.MotClassConfig[arg_15_0].ships, function(arg_16_0)
		return table.contains(arg_15_1, (var_0_0.GetShipTypeByGroupID(arg_16_0)))
	end)

	return {
		id = var_15_0.id,
		name = var_15_0.name,
		nation = var_15_0.nation,
		ships = var_15_1
	}
end

function var_0_0.GetShipTypeByGroupID(arg_17_0)
	return ShipGroup.getDefaultShipConfig(arg_17_0).type
end

function var_0_0.isNormalActOn()
	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS)
	local var_18_1 = var_18_0 and not var_18_0:isEnd()
	local var_18_2 = false
	local var_18_3 = false

	if var_18_1 then
		local var_18_4 = getProxy(ChapterProxy):getChapterById(var_18_0:getConfig("config_data")[1])
		local var_18_5

		if var_18_4 then
			::label_18_0::

			var_18_2 = var_18_4:isClear()
			var_18_5 = getProxy(TaskProxy)
		end

		var_18_3 = _.any(_.flatten(var_18_0:getConfig("config_data")[3]), function(arg_19_0)
			local var_19_0 = var_18_5:getTaskById(arg_19_0)

			return var_19_0 and var_19_0:isFinish() and not var_19_0:isReceive()
		end)
	end

	return var_18_1 and var_18_2, var_18_3
end

function var_0_0.isTecActOn()
	if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "ShipBluePrintMediator") then
		return false
	end

	local var_20_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)

	if not (var_20_0 and not var_20_0:isEnd()) then
		return false
	end

	local var_20_1 = getProxy(ChapterProxy):getChapterById(var_20_0:getConfig("config_data")[1])

	if not (var_20_1 and var_20_1:isClear()) then
		return false
	end

	local var_20_2 = getProxy(TaskProxy)

	if var_20_0.data1 ~= 0 and var_20_0.data2 ~= 0 then
		local var_20_3 = var_20_2:getTaskById(var_20_0:getConfig("config_data")[3][var_20_0.data1][2])

		if var_20_3 and var_20_3:isReceive() and #var_20_0.data1_list + var_20_0.data2 + 1 == #var_20_0:getConfig("config_data")[3] + 1 then
			return false
		end
	end

	local var_20_4 = false

	if var_20_0.data1 == 0 then
		var_20_4 = true
	else
		local var_20_5 = var_20_0:getConfig("config_data")[3][var_20_0.data1]

		var_20_4 = underscore.any({
			function()
				return underscore.any(var_20_5[1], function(arg_22_0)
					local var_22_0 = var_20_2:getTaskVO(arg_22_0)

					return var_22_0 and var_22_0:getTaskStatus() == 1
				end)
			end,
			function()
				local var_23_0 = var_20_2:getTaskVO(var_20_5[2])

				return var_23_0 and var_23_0:getTaskStatus() == 1
			end,
			function()
				local var_24_0 = var_20_2:getTaskVO(var_20_5[2])

				if var_24_0 and var_24_0:isReceive() then
					return #var_20_0.data1_list + var_20_0.data2 + 1 < #var_20_0:getConfig("config_data")[3] + 1
				else
					return false
				end

				return
			end
		}, function(arg_25_0)
			return arg_25_0()
		end)
	end

	return true, var_20_4
end

return var_0_0
