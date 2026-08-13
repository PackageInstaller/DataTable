class = var_0_10000

local var_0_0 = var_0_10000("TechnologyConst")

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

local var_0_1 = {}

Nation = var_2
var_0_1[1] = var_2.US
Nation = var_2
var_0_1[2] = var_2.EN
Nation = var_2
var_0_1[3] = var_2.JP
Nation = var_2
var_0_1[4] = var_2.DE
Nation = var_2
var_0_1[5] = var_2.CN
Nation = var_2
var_0_1[6] = var_2.SN
Nation = var_2
var_0_1[7] = var_2.FF
Nation = var_2
var_0_1[8] = var_2.MNF
Nation = var_2
var_0_1[9] = var_2.ITA
Nation = var_2
var_0_1[10] = var_2.NL
Nation = var_2
var_0_1[11] = var_2.LDP
var_0_0.NationOrder = var_0_1
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
LOCK_NATION_HNLMS = var_1

if var_1 then
	table = var_1

	local var_0_2 = var_1.removebyvalue

	var_0_10003 = var_0_0.NationOrder
	Nation = var_0_10004

	var_0_2(var_0_10003, var_0_10004.NL)

	table = var_0_2

	var_0_2.removebyvalue(var_0_0.NationResName, "nation_yujinwangguo_")
end

local var_0_3 = {}

AttributeType = var_2
var_0_3[1] = var_2.Durability
AttributeType = var_2
var_0_3[2] = var_2.Cannon
AttributeType = var_2
var_0_3[3] = var_2.Torpedo
AttributeType = var_2
var_0_3[4] = var_2.AntiAircraft
AttributeType = var_2
var_0_3[5] = var_2.Air
AttributeType = var_2
var_0_3[6] = var_2.Reload
AttributeType = var_2
var_0_3[7] = var_2.Armor
AttributeType = var_2
var_0_3[8] = var_2.Hit
AttributeType = var_2
var_0_3[9] = var_2.Dodge
AttributeType = var_2
var_0_3[10] = var_2.Speed
AttributeType = var_2
var_0_3[11] = var_2.Luck
AttributeType = var_2
var_0_3[12] = var_2.AntiSub
var_0_0.TECH_NATION_ATTRS = var_0_3

function var_0_0.GetNationSpriteByIndex(arg_1_0)
	GetSpriteFromAtlas = var_1_10001

	local var_1_0 = var_1_10001(var_0_0.AtlasName, var_0_0.NationResName[arg_1_0] .. "01")

	GetSpriteFromAtlas = var_1_10002

	local var_1_1 = var_1_10002(var_0_0.AtlasName, var_0_0.NationResName[arg_1_0] .. "02")

	return var_1_0, var_1_1
end

local var_0_4 = {}
local var_0_5 = {}

ShipType = var_0_10003
var_0_5[1] = var_0_10003.QuZhu
var_0_4[1] = var_0_5

local var_0_6 = {}

ShipType = var_3
var_0_6[1] = var_3.QingXun
var_0_4[2] = var_0_6

local var_0_7 = {}

ShipType = var_3
var_0_7[1] = var_3.ZhongXun
ShipType = var_3
var_0_7[2] = var_3.ChaoXun
var_0_4[3] = var_0_7

local var_0_8 = {}

ShipType = var_3
var_0_8[1] = var_3.QingHang
ShipType = var_3
var_0_8[2] = var_3.ZhengHang
var_0_4[4] = var_0_8

local var_0_9 = {}

ShipType = var_3
var_0_9[1] = var_3.ZhanXun
ShipType = var_3
var_0_9[2] = var_3.ZhanLie
var_0_4[5] = var_0_9

local var_0_10 = {}

ShipType = var_3
var_0_10[1] = var_3.QianTing
ShipType = var_3
var_0_10[2] = var_3.QianMu
var_0_4[6] = var_0_10

local var_0_11 = {}

ShipType = var_3
var_0_11[1] = var_3.WeiXiu
ShipType = var_3
var_0_11[2] = var_3.ZhongPao
ShipType = var_3
var_0_11[3] = var_3.Yunshu
ShipType = var_3
var_0_11[4] = var_3.HangZhan
ShipType = var_3
var_0_11[5] = var_3.FengFanS
ShipType = var_3
var_0_11[6] = var_3.FengFanV
ShipType = var_3
var_0_11[7] = var_3.FengFanM
var_0_4[7] = var_0_11
var_0_0.TypeOrder = var_0_4
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
	GetSpriteFromAtlas = var_1_10001

	local var_2_0 = var_1_10001(var_0_0.AtlasName, var_0_0.TypeResName[arg_2_0] .. "01")

	GetSpriteFromAtlas = var_1_10002

	local var_2_1 = var_1_10002(var_0_0.AtlasName, var_0_0.TypeResName[arg_2_0] .. "02")

	return var_2_0, var_2_1
end

function var_0_0.ClassToGroupIDList()
	local var_3_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10001(var_1_10003.fleet_tech_ship_template.all) do
		pg = var_1_10006

		if var_3_0[var_1_10006.fleet_tech_ship_template[iter_3_1].class] then
			table = var_7

			var_7.insert(var_3_0[var_1_10006], iter_3_1)
		else
			var_3_0[var_1_10006] = {
				iter_3_1
			}
		end
	end

	return var_3_0
end

function var_0_0.GetOrderClassList()
	local var_4_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10001(var_1_10003.fleet_tech_ship_class.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.fleet_tech_ship_class[iter_4_1].nation
		Nation = var_1_10007

		if var_1_10006 ~= var_1_10007.META then
			Nation = var_1_10007

			if var_1_10006 ~= var_1_10007.MOT then
				table = var_1_10007

				var_1_10007.insert(var_4_0, iter_4_1)
			end
		end
	end

	local function var_4_1(arg_5_0, arg_5_1)
		pg = var_2_10002

		local var_5_0 = var_2_10002.fleet_tech_ship_class[arg_5_0]

		pg = var_2_10003

		local var_5_1 = var_2_10003.fleet_tech_ship_class[arg_5_1]
		local var_5_2

		if var_5_0.t_level == var_5_1.t_level then
			var_5_2 = var_5_0.t_level_1 > var_5_1.t_level_1
		else
			var_5_2 = var_5_0.t_level > var_5_1.t_level
		end

		return var_5_2
	end

	table = var_2

	var_2.sort(var_4_0, var_4_1)

	return var_4_0
end

var_0_0.MetaClassConfig = nil
var_0_0.MotClassConfig = nil

function var_0_0.CreateMetaClassConfig()
	if var_0_0.MetaClassConfig or var_0_0.MotClassConfig then
		return
	end

	ipairs = var_0
	pg = var_1_10002

	for iter_6_0, iter_6_1 in var_0(var_1_10002.fleet_tech_ship_class.all) do
		pg = var_1_10005

		local var_6_0 = var_1_10005.fleet_tech_ship_class[iter_6_1].nation

		Nation = var_1_10007

		if var_6_0 == var_1_10007.META then
			if var_0_0.MetaClassConfig == nil then
				var_1_10007 = var_0_0
				var_1_10007.MetaClassConfig = {}
			end

			var_1_10007 = var_1_10005.t_level

			local var_6_1 = "meta_class_t_level_" .. var_1_10007

			if var_0_0.MetaClassConfig[var_6_1] == nil then
				var_0_0.MetaClassConfig[var_6_1] = {}
			end

			local var_6_2

			if var_0_0.MetaClassConfig[var_6_1].ships == nil then
				var_6_2 = var_0_0.MetaClassConfig[var_6_1]
				var_6_2.ships = {}
			end

			i18n = var_6_2

			local var_6_3 = var_6_2(var_6_1)
			local var_6_4 = var_1_10005.t_level_1

			if var_0_0.MetaClassConfig[var_6_1].ships[var_6_4] == nil then
				var_0_0.MetaClassConfig[var_6_1].ships[var_6_4] = {}
			end

			local var_6_5

			if var_0_0.MetaClassConfig[var_6_1].indexList == nil then
				var_6_5 = var_0_0.MetaClassConfig[var_6_1]
				var_6_5.indexList = {}
			end

			table = var_6_5

			if not var_6_5.contains(var_0_0.MetaClassConfig[var_6_1].indexList, var_6_4) then
				table = var_11

				var_11.insert(var_0_0.MetaClassConfig[var_6_1].indexList, var_6_4)
			end

			local var_6_6 = var_0_0.MetaClassConfig[var_6_1]

			var_6_6.id = var_6_1
			var_6_6.name = var_6_3
			var_6_6.nation = var_6_0
			var_6_6.t_level = var_1_10007
			table = var_1_10012

			var_1_10012.insert(var_6_6.ships[var_6_4], var_1_10005.ships[1])
		else
			Nation = var_1_10007

			if var_6_0 == var_1_10007.MOT then
				if var_0_0.MotClassConfig == nil then
					var_1_10007 = var_0_0
					var_1_10007.MotClassConfig = {}
				end

				var_1_10007 = var_1_10005.t_level

				local var_6_7 = "mot_class_t_level_" .. var_1_10007

				if var_0_0.MotClassConfig[var_6_7] == nil then
					var_0_0.MotClassConfig[var_6_7] = {}
				end

				local var_6_8

				if var_0_0.MotClassConfig[var_6_7].ships == nil then
					var_6_8 = var_0_0.MotClassConfig[var_6_7]
					var_6_8.ships = {}
				end

				i18n = var_6_8

				local var_6_9 = var_6_8(var_6_7)
				local var_6_10 = var_1_10005.t_level_1

				if var_0_0.MotClassConfig[var_6_7].ships[var_6_10] == nil then
					var_0_0.MotClassConfig[var_6_7].ships[var_6_10] = {}
				end

				local var_6_11

				if var_0_0.MotClassConfig[var_6_7].indexList == nil then
					var_6_11 = var_0_0.MotClassConfig[var_6_7]
					var_6_11.indexList = {}
				end

				table = var_6_11

				if not var_6_11.contains(var_0_0.MotClassConfig[var_6_7].indexList, var_6_10) then
					table = var_11

					var_11.insert(var_0_0.MotClassConfig[var_6_7].indexList, var_6_10)
				end

				local var_6_12 = var_0_0.MotClassConfig[var_6_7]

				var_6_12.id = var_6_7
				var_6_12.name = var_6_9
				var_6_12.nation = var_6_0
				var_6_12.t_level = var_1_10007
				table = var_1_10012

				var_1_10012.insert(var_6_12.ships[var_6_10], var_1_10005.ships[1])
			end
		end
	end

	if var_0_0.MetaClassConfig then
		pairs = var_0

		for iter_6_2, iter_6_3 in var_0(var_0_0.MetaClassConfig) do
			local var_6_13 = iter_6_3.indexList
			local var_6_14 = {}

			ipairs = var_1_10007

			for iter_6_4, iter_6_5 in var_1_10007(var_6_13) do
				_ = var_1_10012

				var_1_10012.each(iter_6_3.ships[iter_6_5], function(arg_7_0)
					table = var_2_10001

					var_2_10001.insert(var_6_14, arg_7_0)

					return
				end)
			end

			iter_6_3.ships = var_6_14
		end
	end

	if var_0_0.MotClassConfig then
		pairs = var_0

		for iter_6_6, iter_6_7 in var_0(var_0_0.MotClassConfig) do
			local var_6_15 = iter_6_7.indexList
			local var_6_16 = {}

			ipairs = var_1_10007

			for iter_6_8, iter_6_9 in var_1_10007(var_6_15) do
				_ = var_1_10012

				var_1_10012.each(iter_6_7.ships[iter_6_9], function(arg_8_0)
					table = var_2_10001

					var_2_10001.insert(var_6_16, arg_8_0)

					return
				end)
			end

			iter_6_7.ships = var_6_16
		end
	end

	return
end

function var_0_0.GetOrderMetaClassList(arg_9_0)
	local var_9_0 = {}

	pg = var_1_10002

	local var_9_1 = var_1_10002.gameset.meta_tech_sort.description
	local var_9_2 = {}

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(var_9_1) do
		pairs = var_1_10009

		for iter_9_2, iter_9_3 in var_1_10009(var_0_0.MetaClassConfig) do
			if iter_9_1 == iter_9_3.t_level then
				table = var_14

				var_14.insert(var_9_2, iter_9_3)

				break
			end
		end
	end

	ipairs = var_4

	for iter_9_4, iter_9_5 in var_4(var_9_2) do
		local var_9_3 = iter_9_5.ships
		local var_9_4

		if not arg_9_0 or #arg_9_0 == 0 then
			var_9_4 = var_9_3
		else
			_ = var_1_10011
			var_9_4 = var_1_10011.select(var_9_3, function(arg_10_0)
				local var_10_0 = var_0_0.GetShipTypeByGroupID(arg_10_0)

				table = var_2_10002

				return var_2_10002.contains(arg_9_0, var_10_0)
			end)
		end

		if #var_9_4 > 0 then
			table = var_1_10011

			var_1_10011.insert(var_9_0, iter_9_5.id)
		end
	end

	return var_9_0
end

function var_0_0.GetOrderMotClassList(arg_11_0)
	local var_11_0 = {}

	pg = var_1_10002

	local var_11_1 = var_1_10002.gameset.tech_sort_mot.description
	local var_11_2 = {}

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_1) do
		pairs = var_1_10009

		for iter_11_2, iter_11_3 in var_1_10009(var_0_0.MotClassConfig) do
			if iter_11_1 == iter_11_3.t_level then
				table = var_14

				var_14.insert(var_11_2, iter_11_3)

				break
			end
		end
	end

	ipairs = var_4

	for iter_11_4, iter_11_5 in var_4(var_11_2) do
		local var_11_3 = iter_11_5.ships
		local var_11_4

		if not arg_11_0 or #arg_11_0 == 0 then
			var_11_4 = var_11_3
		else
			_ = var_1_10011
			var_11_4 = var_1_10011.select(var_11_3, function(arg_12_0)
				local var_12_0 = var_0_0.GetShipTypeByGroupID(arg_12_0)

				table = var_2_10002

				return var_2_10002.contains(arg_11_0, var_12_0)
			end)
		end

		if #var_11_4 > 0 then
			table = var_1_10011

			var_1_10011.insert(var_11_0, iter_11_5.id)
		end
	end

	return var_11_0
end

function var_0_0.GetMetaClassConfig(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.MetaClassConfig[arg_13_0].ships
	local var_13_1

	if not arg_13_1 or #arg_13_1 == 0 then
		var_13_1 = var_13_0
	else
		_ = var_1_10005
		var_13_1 = var_1_10005.select(var_13_0, function(arg_14_0)
			local var_14_0 = var_0_0.GetShipTypeByGroupID(arg_14_0)

			table = var_2_10002

			return var_2_10002.contains(arg_13_1, var_14_0)
		end)
	end

	return {
		id = var_2.id,
		name = var_2.name,
		nation = var_2.nation,
		ships = var_13_1
	}
end

function var_0_0.GetMotClassConfig(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.MotClassConfig[arg_15_0].ships
	local var_15_1

	if not arg_15_1 or #arg_15_1 == 0 then
		var_15_1 = var_15_0
	else
		_ = var_1_10005
		var_15_1 = var_1_10005.select(var_15_0, function(arg_16_0)
			local var_16_0 = var_0_0.GetShipTypeByGroupID(arg_16_0)

			table = var_2_10002

			return var_2_10002.contains(arg_15_1, var_16_0)
		end)
	end

	return {
		id = var_2.id,
		name = var_2.name,
		nation = var_2.nation,
		ships = var_15_1
	}
end

function var_0_0.GetShipTypeByGroupID(arg_17_0)
	ShipGroup = var_1_10001

	return var_1_10001.getDefaultShipConfig(arg_17_0).type
end

function var_0_0.isNormalActOn()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_18_0 = var_1_10000(var_1_10002)
	local var_18_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_18_2 = var_18_1(var_18_0, var_1_10003.ACTIVITY_TYPE_GUIDE_TASKS) and not var_0:isEnd()
	local var_18_3 = false
	local var_18_4 = false

	if var_18_2 then
		local var_18_5 = var_0
		local var_18_6 = var_0.getConfig(var_18_5, "config_data")[1]

		getProxy = var_1_10005
		ChapterProxy = var_7

		local var_18_7 = var_1_10005(var_7)

		var_18_3 = var_5.getChapterById(var_18_7, var_18_6) and var_5:isClear()
		_ = var_18_5

		local var_18_8 = var_18_5.flatten(var_0:getConfig("config_data")[3])

		getProxy = var_18_7
		TaskProxy = var_1_10009

		local var_18_9 = var_18_7(var_1_10009)

		_ = var_8
		var_18_4 = var_8.any(var_18_8, function(arg_19_0)
			local var_19_0 = var_18_9
			local var_19_1

			if var_1.getTaskById(var_19_0, arg_19_0) and var_1:isFinish() then
				var_19_1 = not var_1:isReceive()
			end

			return var_19_1
		end)
	end

	return var_18_2 and var_18_3, var_18_4
end

function var_0_0.isTecActOn()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_20_0 = var_1_10000(var_1_10002)
	local var_20_1 = var_0.getRawData(var_20_0)

	pg = var_1_10002

	local var_20_2 = var_1_10002.SystemOpenMgr.GetInstance()

	if not var_2.isOpenSystem(var_20_2, var_20_1.level, "ShipBluePrintMediator") then
		return false
	end

	getProxy = var_20_0
	ActivityProxy = var_5

	local var_20_3 = var_20_0(var_5)
	local var_20_4 = var_3.getActivityByType

	ActivityConst = var_6

	local var_20_5, var_20_6

	if var_20_4(var_20_3, var_6.ACTIVITY_TYPE_FRESH_TEC_CATCHUP) then
		::label_20_0::

		var_20_5 = var_3
		var_20_6 = not var_3.isEnd(var_20_5)
	end

	if not var_20_6 then
		return false
	end

	local var_20_7 = var_3:getConfig("config_data")[1]

	getProxy = var_20_5
	ChapterProxy = var_8

	local var_20_8 = var_20_5(var_8)

	if not (var_6.getChapterById(var_20_8, var_20_7) and var_6:isClear()) then
		return false
	end

	getProxy = var_20_8
	TaskProxy = var_1_10010

	local var_20_9 = var_20_8(var_1_10010)

	if var_3.data1 ~= 0 and var_3.data2 ~= 0 then
		local var_20_10 = var_3:getConfig("config_data")[3][var_3.data1]

		if var_20_9:getTaskById(var_20_10[2]) and var_10:isReceive() and #var_3.data1_list + var_3.data2 + 1 == #var_3:getConfig("config_data")[3] + 1 then
			return false
		end
	end

	local var_20_11 = false

	if var_3.data1 == 0 then
		var_20_11 = true
	else
		local var_20_12 = var_3:getConfig("config_data")[3][var_3.data1]

		underscore = var_11
		var_20_11 = var_11.any({
			function()
				underscore = var_2_10000

				return var_2_10000.any(var_20_12[1], function(arg_22_0)
					local var_22_0 = var_20_9

					return var_1.getTaskVO(var_22_0, arg_22_0) and var_1:getTaskStatus() == 1
				end)
			end,
			function()
				local var_23_0 = var_20_9

				return var_0.getTaskVO(var_23_0, var_20_12[2]) and var_0:getTaskStatus() == 1
			end,
			function()
				local var_24_0 = var_20_9

				if var_0.getTaskVO(var_24_0, var_20_12[2]) and var_0:isReceive() then
					local var_24_1 = #var_0.data1_list + var_0.data2 + 1
					local var_24_2 = var_0

					return var_24_1 < #var_2.getConfig(var_24_2, "config_data")[3] + 1
				else
					return false
				end

				return
			end
		}, function(arg_25_0)
			return arg_25_0()
		end)
	end

	return true, var_20_11
end

return var_0_0
