class = var_0_10000

local var_0_0 = "Summary"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.TimeMgr.GetInstance()

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)

	arg_1_0.name = var_3.getData(var_1_1).name

	local var_1_2 = var_1_0

	arg_1_0.registerTime = var_1_0.STimeDescC(var_1_2, arg_1_1.register_date, "%Y.%m.%d")
	getProxy = var_3
	ActivityProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = var_3.getActivityByType

	ActivityConst = var_5

	local var_1_5 = var_1_4(var_1_3, var_5.ACTIVITY_TYPE_SUMMARY)
	local var_1_6 = var_3.getStartTime(var_1_5)

	math = var_1_5

	local var_1_7 = var_1_5.max

	math = var_6
	arg_1_0.days = var_1_7(var_6.ceil((var_1_6 - arg_1_1.register_date) / 0), 0) + 1
	getProxy = var_5
	UserProxy = var_6

	local var_1_8 = var_5(var_6)
	local var_1_9 = var_5.getRawData(var_1_8)

	getProxy = var_1_8
	ServerProxy = var_7

	local var_1_10 = var_1_8(var_7)
	local var_1_11 = var_6.getRawData(var_1_10)
	local var_1_12

	if not var_1_9 or not var_1_9.server then
		var_1_12 = 0
	end

	local var_1_13

	if not var_1_11[var_1_12] or not var_6.name then
		var_1_13 = ""
	end

	arg_1_0.serverName = var_1_13
	math = var_1_13

	local var_1_14 = var_1_13.max(arg_1_1.chapter_id, 101)

	pg = var_8
	arg_1_0.chapterName = var_8.chapter_template[var_1_14].chapter_name .. " " .. var_8.name
	arg_1_0.guildName = arg_1_1.guild_name
	arg_1_0.proposeCount = arg_1_1.marry_number
	arg_1_0.medalCount = arg_1_1.medal_number
	arg_1_0.furnitureCount = arg_1_1.furniture_number
	arg_1_0.furnitureWorth = arg_1_1.furniture_worth
	arg_1_0.flagShipId = arg_1_1.character_id
	arg_1_0.firstLadyId = arg_1_1.first_lady_id
	arg_1_0.isProPose = arg_1_0.proposeCount > 0
	arg_1_0.firstProposeName = ""

	if arg_1_0.firstLadyId > 0 then
		Ship = var_9

		local var_1_15 = var_9.New({
			configId = arg_1_0.firstLadyId
		})

		arg_1_0.firstProposeName = var_9.getConfig(var_1_15, "name")
	end

	if arg_1_1.first_lady_name ~= "" then
		arg_1_0.firstProposeName = arg_1_1.first_lady_name
	end

	math = var_9
	arg_1_0.proposeTime = var_9.ceil((var_1_6 - arg_1_1.first_lady_time) / 0) + 1

	local var_1_16 = var_1_0

	arg_1_0.firstLadyTime = var_1_0.STimeDescC(var_1_16, arg_1_1.first_lady_time, "%Y-%m-%d %H:%M")
	arg_1_0.unMarryShipId = 100001
	getProxy = var_9
	ActivityProxy = var_1_16

	local var_1_17 = var_9(var_1_16)
	local var_1_18 = var_9.getActivityByType

	ActivityConst = var_11

	local var_1_19 = var_1_18(var_1_17, var_11.ACTIVITY_TYPE_SUMMARY)

	arg_1_0.furnitures = {}
	pairs = var_10
	getProxy = var_11
	DormProxy = var_12

	local var_1_20 = var_11(var_12)

	for iter_1_0, iter_1_1 in var_10(var_11.getRawData(var_1_20).furnitures) do
		arg_1_0.furnitures[iter_1_1.id] = iter_1_1
	end

	underscore = var_10
	arg_1_0.medalList = var_10.filter(var_1_19:getConfig("config_data"), function(arg_2_0)
		tobool = var_2_10001

		return var_2_10001(arg_1_0.furnitures[arg_2_0])
	end)
	getProxy = var_10
	AttireProxy = var_11

	local var_1_21 = var_10(var_11)

	underscore = var_11
	arg_1_0.iconFrameList = var_11.filter(var_1_19:getConfig("config_client")[1], function(arg_3_0)
		local var_3_0 = var_1_21
		local var_3_1 = var_1.getAttireFrame

		AttireConst = var_2_10003

		local var_3_2 = var_3_1(var_3_0, var_2_10003.TYPE_ICON_FRAME, arg_3_0[1])

		return var_1.isOwned(var_3_2)
	end)
	arg_1_0.worldProgressTask = arg_1_1.world_max_task
	string = var_11
	arg_1_0.collectionNum = var_11.format("%0.1f", arg_1_1.collect_num / var_1_19:getConfig("config_client")[2] * 100)
	math = var_11
	arg_1_0.powerRaw = var_11.floor(arg_1_1.combat^0.667)
	arg_1_0.totalShipNum = arg_1_1.ship_num_total
	arg_1_0.topShipNum = arg_1_1.ship_num_120
	arg_1_0.bestShipNum = arg_1_1.ship_num_125
	arg_1_0.maxIntimacyNum = arg_1_1.love200_num
	arg_1_0.skinNum = arg_1_1.skin_num
	arg_1_0.skinShipNum = arg_1_1.skin_ship_num
	arg_1_0.skinId = 0

	local var_1_22 = {}

	ipairs = var_12
	getProxy = var_13
	ShipSkinProxy = var_14

	local var_1_23 = var_13(var_14)

	for iter_1_2, iter_1_3 in var_12(var_13.GetShopShowingSkins(var_1_23)) do
		if iter_1_3.buyCount > 0 then
			var_1_22[iter_1_3:getSkinId()] = true
		end
	end

	getProxy = var_12
	BayProxy = var_13

	local var_1_24 = var_12(var_13)

	ipairs = var_13
	getProxy = var_14
	PlayerProxy = iter_1_2

	local var_1_25 = var_14(iter_1_2)

	for iter_1_4, iter_1_5 in var_13(var_14.getRawData(var_1_25).characters) do
		if var_1_24:getShipById(iter_1_5) and var_1_22[var_18.skinId] then
			arg_1_0.skinId = var_18:getSkinId()

			break
		end
	end

	if arg_1_0.skinId == 0 then
		underscore = var_13

		if #var_13.keys(var_1_22) > 0 then
			math = var_14

			local var_1_26 = var_14.max
			local var_1_27 = 1

			math = iter_1_4

			local var_1_28 = iter_1_4.ceil

			math = iter_1_5
			arg_1_0.skinId = var_13[var_1_26(var_1_27, var_1_28(iter_1_5.random() * #var_13))]
		end
	end

	return
end

function var_0_1.hasGuild(arg_4_0)
	local var_4_0

	if arg_4_0.guildName then
		var_4_0 = arg_4_0.guildName ~= ""
	end

	return var_4_0
end

function var_0_1.hasMedal(arg_5_0)
	return arg_5_0.medalCount > 0
end

return var_0_1
