class = var_0_10000

local var_0_0 = "WorldProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	BaseEntityPool = var_1_10001

	local var_1_0 = var_1_10001.New()

	BaseEntityBank = WPool

	local var_1_1 = var_1.New()
	local var_1_2 = WBank

	arg_1_0:BuildTestFunc()
	arg_1_0:on(33114, function(arg_2_0)
		arg_1_0.isProtoLock = arg_2_0.is_world_open == 0

		local var_2_0 = arg_1_0
		local var_2_1 = var_1.BuildWorld

		World = var_2_10004

		var_2_1(var_2_0, var_2_10004.TypeBase)

		local var_2_2 = arg_1_0.world

		underscore = var_2
		var_2_2.baseShipIds = var_2.rest(arg_2_0.ship_id_list, 1)

		local var_2_3 = arg_1_0.world

		underscore = var_2
		var_2_3.baseCmdIds = var_2.rest(arg_2_0.cmd_id_list, 1)

		local var_2_4 = arg_1_0.world

		var_1.UpdateProgress(var_2_4, arg_2_0.progress)

		pg = var_1

		local var_2_5 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_2_5, "inWorld")

		local var_2_6 = arg_1_0
		local var_2_7 = var_1.sendNotification

		GAME = var_4

		var_2_7(var_2_6, var_4.WORLD_GET_BOSS)

		return
	end)
	arg_1_0:on(33105, function(arg_3_0)
		local var_3_0 = arg_1_0.world
		local var_3_1 = var_1.GetActiveMap(var_3_0)

		assert = var_2_10002

		var_2_10002(var_3_1, "active map not exist.")

		local var_3_2 = arg_1_0
		local var_3_3 = var_2.NetBuildMapAttachmentCells(var_3_2, arg_3_0.pos_list)
		local var_3_4 = arg_1_0

		var_3.UpdateMapAttachmentCells(var_3_4, var_3_1.id, var_3_3)

		local var_3_5 = arg_1_0
		local var_3_6 = var_3.NetBuildFleetAttachUpdate(var_3_5, arg_3_0.pos_list)
		local var_3_7 = arg_1_0

		var_4.ApplyFleetAttachUpdate(var_3_7, var_3_1.id, var_3_6)

		WPool = var_4

		var_4:ReturnArray(var_3_6)

		return
	end)
	arg_1_0:on(33203, function(arg_4_0)
		local var_4_0 = arg_1_0.world
		local var_4_1 = var_1.GetTaskProxy(var_4_0)

		ipairs = var_2_10002

		for iter_4_0, iter_4_1 in var_2_10002(arg_4_0.update_list) do
			WorldTask = var_2_10007
			var_2_10007 = var_2_10007.New(iter_4_1)

			if var_4_1:getTaskById(var_2_10007.id) then
				var_4_1:updateTask(var_2_10007)
			else
				var_4_1:addTask(var_2_10007)

				local var_4_2 = arg_1_0
				local var_4_3 = var_8.sendNotification

				GAME = var_11

				var_4_3(var_4_2, var_11.WORLD_TRIGGER_TASK_DONE, {
					task = var_2_10007
				})
			end
		end

		return
	end)
	arg_1_0:on(33204, function(arg_5_0)
		local var_5_0 = arg_1_0.world
		local var_5_1 = var_1.GetTaskProxy(var_5_0)

		ipairs = var_2_10002

		for iter_5_0, iter_5_1 in var_2_10002(arg_5_0.delete_list) do
			var_5_1:deleteTask(iter_5_1)
		end

		return
	end)
	arg_1_0:on(33601, function(arg_6_0)
		local var_6_0 = arg_1_0

		var_1.NetUpdateAchievements(var_6_0, arg_6_0.target_list)

		return
	end)
	arg_1_0:on(34507, function(arg_7_0)
		if arg_1_0.world then
			local var_7_0 = arg_1_0.world
			local var_7_1 = var_1.GetBossProxy(var_7_0)

			WorldBoss = var_2_10002

			local var_7_2 = var_2_10002.New()
			local var_7_3 = var_2.Setup
			local var_7_4 = arg_7_0.boss_info

			Player = var_2_10007

			var_7_3(var_7_2, var_7_4, var_2_10007.New(arg_7_0.user_info))
			var_2:UpdateBossType(arg_7_0.type)

			local var_7_5 = var_2
			local var_7_6 = var_2.SetJoinTime

			pg = var_6

			local var_7_7 = var_6.TimeMgr.GetInstance()

			var_7_6(var_7_5, var_6.GetServerTime(var_7_7))

			if var_7_1.isSetup then
				var_7_1:ClearRank(var_2.id)
				var_7_1:UpdateCacheBoss(var_2)
			end

			if not var_7_1:IsSelfBoss(var_2) then
				local var_7_8 = arg_1_0.world
				local var_7_9 = var_3.IsSystemOpen

				WorldConst = var_6

				if var_7_9(var_7_8, var_6.SystemWorldBoss) then
					pg = var_3

					local var_7_10 = var_3.WorldBossTipMgr.GetInstance()

					var_3.Show(var_7_10, var_2)
				end
			end
		end

		return
	end)
	arg_1_0:on(34508, function(arg_8_0)
		local var_8_0 = arg_1_0.world

		if var_1.GetBossProxy(var_8_0).isSetup then
			local var_8_1 = arg_1_0
			local var_8_2 = var_2.sendNotification

			GAME = var_2_10005

			var_8_2(var_8_1, var_2_10005.WORLD_GET_BOSS_RANK, {
				bossId = arg_8_0.boss_id,
				callback = function()
					local var_9_0 = var_0

					var_0.updateBossHp(var_9_0, arg_8_0.boss_id, arg_8_0.hp)

					return
				end
			})
		end

		return
	end)

	return
end

function var_0_1.timeCall(arg_10_0)
	local var_10_0 = {}

	ProxyRegister = var_1_10002
	var_10_0[var_1_10002.DayCall] = function(arg_11_0)
		nowWorld = var_2_10001

		local var_11_0 = var_2_10001()

		pg = var_2_10002

		local var_11_1 = var_2_10002.TimeMgr.GetInstance()

		if var_2.GetServerWeek(var_11_1) == 1 then
			var_11_0.staminaMgr.staminaExchangeTimes = 0
		end

		if var_11_0 then
			local var_11_2 = var_11_0:GetBossProxy()

			var_3.increasePt(var_11_2)
			var_3:ClearSummonPtDailyAcc()
			var_3:ClearSummonPtOldAcc()
		end

		return
	end

	return var_10_0
end

function var_0_1.remove(arg_12_0)
	if arg_12_0.world then
		local var_12_0 = arg_12_0.world
		local var_12_1 = var_1.GetBossProxy(var_12_0)

		var_1.Dispose(var_12_1)
	end

	removeWorld = var_1

	var_1()

	WPool = var_1

	var_1:Dispose()

	local var_12_2

	WBank = WPool

	var_1:Dispose()

	local var_12_3
	local var_12_4 = WBank

	return
end

function var_0_1.BuildTestFunc(arg_13_0)
	PlayerPrefs = var_1_10001

	if not var_1_10001.GetInt("world_skip_battle") then
		local var_13_0 = 0
	end

	local var_13_1 = world_skip_battle

	local function var_13_2()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_14_0 = var_2_10000(var_2_10002)
		local var_14_1 = var_0.getRawData(var_14_0)

		if var_0.CheckIdentityFlag(var_14_1) then
			world_skip_battle = var_1

			local var_14_2 = 1 - var_1

			PlayerPrefs = world_skip_battle

			local var_14_3 = var_1.SetInt
			local var_14_4 = "world_skip_battle"

			world_skip_battle = var_2_10004

			var_14_3(var_14_4, var_2_10004)

			PlayerPrefs = var_14_3

			var_14_3.Save()

			pg = var_1

			local var_14_5 = var_1.TipsMgr.GetInstance()
			local var_14_6 = var_1.ShowTips

			world_skip_battle = var_2_10004

			var_14_6(var_14_5, var_2_10004 == 1 and "已开启大世界战斗跳略" or "已关闭大世界战斗跳略")
		end

		return
	end

	IsUnityEditor = switch_world_skip_battle

	if var_1 then
		local function var_13_3()
			pg = var_2_10000

			local var_15_0 = var_2_10000.m02
			local var_15_1 = var_0.retrieveMediator

			WorldMediator = var_2_10003

			if var_15_1(var_15_0, var_2_10003.__cname) then
				local var_15_2 = var_0.viewComponent

				var_1.ShowSubView(var_15_2, "DebugPanel")
			end

			return
		end

		pg = display_world_debug_panel

		local var_13_4 = var_1.UIMgr.GetInstance()

		var_1.AddWorldTestButton(var_13_4, "WorldDebug", function()
			WorldConst = var_2_10000
			var_2_10000.Debug = true

			return
		end)
	end

	return
end

function var_0_1.BuildWorld(arg_17_0, arg_17_1, arg_17_2)
	World = var_1_10003

	local var_17_0 = var_1_10003.New
	local var_17_1 = arg_17_1
	local var_17_3

	if arg_17_0.world then
		local var_17_2 = arg_17_0.world

		var_17_3 = var_17_3.Dispose
		tobool = var_1_10009
		var_17_3 = var_17_3(var_17_2, var_1_10009(arg_17_2))
	end

	arg_17_0.world = var_17_0(var_17_1, var_17_3)
	pg = var_3

	local var_17_4 = var_3.ShipFlagMgr.GetInstance()

	var_3.UpdateFlagShips(var_17_4, "inWorld")

	return
end

function var_0_1.NetFullUpdate(arg_18_0, arg_18_1)
	arg_18_0.isProtoLock = arg_18_1.is_world_open == 0

	arg_18_0:NetUpdateWorld(arg_18_1.world, arg_18_1.global_flag_list, arg_18_1.camp)
	arg_18_0:NetUpdateWorldDefaultFleets(arg_18_1.fleet_list)
	arg_18_0:NetUpdateWorldAchievements(arg_18_1.target_list, arg_18_1.target_fetch_list)
	arg_18_0:NetUpdateWorldCountInfo(arg_18_1.count_info)
	arg_18_0:NetUpdateWorldMapPressing(arg_18_1.clean_chapter)
	arg_18_0:NetUpdateWorldPressingAward(arg_18_1.chapter_award)
	arg_18_0:NetUpdateWorldShopGoods(arg_18_1.out_shop_buy_list)
	arg_18_0:NetUpdateWorldPortShopMark(arg_18_1.port_list, arg_18_1.new_flag_port_list)

	return
end

function var_0_1.NetUpdateWorld(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0.world

	var_4.SetRealm(var_19_0, arg_19_3)

	var_4.activateTime = arg_19_1.time
	var_4.expiredTime = arg_19_1.last_change_group_timestamp
	var_4.roundIndex = arg_19_1.round
	var_4.submarineSupport = arg_19_1.submarine_state == 1

	local var_19_1 = var_4.staminaMgr

	var_5.Setup(var_19_1, {
		arg_19_1.action_power,
		arg_19_1.action_power_extra,
		arg_19_1.last_recover_timestamp,
		arg_19_1.action_power_fetch_count
	})

	underscore = var_5
	var_4.gobalFlag = var_5.map(arg_19_2, function(arg_20_0)
		return arg_20_0 > 0
	end)

	local var_19_2 = var_4:GetAtlas()
	local var_19_3 = var_5.SetCostMapList

	_ = var_9

	var_19_3(var_19_2, var_9.rest(arg_19_1.chapter_list, 1))

	local var_19_4 = var_5
	local var_19_5 = var_5.SetSairenEntranceList

	_ = var_9

	var_19_5(var_19_4, var_9.rest(arg_19_1.sairen_chapter, 1))
	var_5:InitWorldNShopGoods(arg_19_1.goods_list)
	var_4:SetFleets(arg_19_0:NetBuildMapFleetList(arg_19_1.group_list))

	local var_19_6 = arg_19_1.map_id
	local var_19_7

	if 0 < var_19_6 then
		_ = var_19_6
		var_19_7 = var_19_6.detect(arg_19_1.chapter_list, function(arg_21_0)
			return arg_21_0.random_id == arg_19_1.map_id
		end)
	else
		var_19_7 = false
	end

	if false then
		var_19_7 = true
	end

	assert = var_7

	local var_19_8 = arg_19_1.map_id
	local var_19_9 = 0 < var_19_8

	tobool = var_10

	var_7(var_19_9 == var_10(var_19_7), "error active map info:" .. arg_19_1.map_id)

	if var_19_7 then
		local var_19_10 = arg_19_1.enter_map_id
		local var_19_11 = var_19_7.random_id
		local var_19_12 = var_19_7.template_id
		local var_19_13 = var_4
		local var_19_14 = var_4.GetEntrance(var_19_13, var_19_10)
		local var_19_15 = var_4
		local var_19_16 = var_4.GetMap(var_19_15, var_19_11)

		assert = var_19_13

		var_19_13(var_19_14, "entrance not exist: " .. var_19_10)

		assert = var_19_13

		var_19_13(var_19_16, "map not exist: " .. var_19_11)

		assert = var_19_13
		pg = var_14

		var_19_13(var_14.world_chapter_template[var_19_12], "world_chapter_template not exist: " .. var_19_12)

		assert = var_19_13

		var_19_13(#arg_19_1.group_list > 0, "amount of group_list is not enough.")
		var_19_14:UpdateActive(true)
		var_19_16:UpdateGridId(var_19_12)

		local var_19_17 = arg_19_1.group_list[1].id

		table = var_19_15
		var_19_16.findex = var_19_15.indexof(var_4.fleets, var_4:GetFleet(var_19_17))

		var_19_16:BindFleets(var_4.fleets)
		var_19_16:UpdateActive(true)
	end

	local var_19_18 = var_4:GetInventoryProxy()

	var_7.Setup(var_19_18, arg_19_1.item_list)

	local var_19_19 = var_4:GetTaskProxy()

	var_8.Setup(var_19_19, arg_19_1.task_list)

	var_8.taskFinishCount = arg_19_1.task_finish_count
	_ = var_9

	var_9.each(arg_19_1.cd_list, function(arg_22_0)
		var_0.cdTimeList[arg_22_0.id] = arg_22_0.time

		return
	end)

	_ = var_9

	var_9.each(arg_19_1.buff_list, function(arg_23_0)
		local var_23_0 = var_0.globalBuffDic
		local var_23_1 = arg_23_0.id

		WorldBuff = var_2_10003
		var_23_0[var_23_1] = var_2_10003.New()

		local var_23_2 = var_0.globalBuffDic[arg_23_0.id]

		var_1.Setup(var_23_2, {
			id = arg_23_0.id,
			floor = arg_23_0.stack
		})

		return
	end)

	underscore = var_9

	var_9.each(arg_19_1.month_boss, function(arg_24_0)
		var_0.lowestHP[arg_24_0.key] = arg_24_0.value

		return
	end)

	return
end

function var_0_1.NetUpdateWorldDefaultFleets(arg_25_0, arg_25_1)
	local var_25_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_25_1, function(arg_26_0)
		WorldBaseFleet = var_2_10001

		local var_26_0 = var_2_10001.New()

		var_1.Setup(var_26_0, arg_26_0)

		table = var_2

		var_2.insert(var_25_0, var_1)

		return
	end)

	table = var_3

	var_3.sort(var_25_0, function(arg_27_0, arg_27_1)
		return arg_27_0.id < arg_27_1.id
	end)

	local var_25_1 = arg_25_0.world

	var_3.SetDefaultFleets(var_25_1, var_25_0)

	return
end

function var_0_1.NetUpdateWorldAchievements(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.world.achievements = {}

	arg_28_0:NetUpdateAchievements(arg_28_1)

	local var_28_0 = arg_28_0.world

	var_28_0.achieveEntranceStar = {}
	_ = var_28_0

	var_28_0.each(arg_28_2, function(arg_29_0)
		ipairs = var_2_10001

		for iter_29_0, iter_29_1 in var_2_10001(arg_29_0.star_list) do
			local var_29_0 = arg_28_0.world

			var_6.SetAchieveSuccess(var_29_0, arg_29_0.id, iter_29_1)
		end

		return
	end)

	return
end

function var_0_1.NetUpdateWorldCountInfo(arg_30_0, arg_30_1)
	arg_30_0.world.stepCount = arg_30_1.step_count
	arg_30_0.world.treasureCount = arg_30_1.treasure_count
	arg_30_0.world.activateCount = arg_30_1.activate_count

	local var_30_0 = arg_30_0.world
	local var_30_1 = var_2.GetCollectionProxy(var_30_0)

	var_2.Setup(var_30_1, arg_30_1.collection_list)

	local var_30_2 = arg_30_0.world

	var_3.UpdateProgress(var_30_2, arg_30_1.task_progress)

	return
end

function var_0_1.NetUpdateActiveMap(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0.world
	local var_31_1 = var_4.GetActiveEntrance(var_31_0)
	local var_31_2 = arg_31_0.world
	local var_31_3 = var_5.GetActiveMap(var_31_2)

	if var_5.NeedClear(var_31_3) and var_31_1.becomeSairen and var_31_1:GetSairenMapId() == var_5.id then
		local var_31_4 = arg_31_0.world
		local var_31_5 = var_6.GetAtlas(var_31_4)

		var_6.RemoveSairenEntrance(var_31_5, var_31_1)
	end

	local var_31_6 = arg_31_0.world
	local var_31_7 = var_6.GetEntrance(var_31_6, arg_31_1)

	assert = var_31_2

	var_31_2(var_31_7, "entrance not exist: " .. arg_31_1)

	if var_31_1.id ~= var_31_7.id then
		var_31_1:UpdateActive(false)
		var_31_7:UpdateActive(true)
	end

	local var_31_8 = arg_31_0.world
	local var_31_9 = var_7.GetMap(var_31_8, arg_31_2)

	assert = var_8

	var_8(var_31_9, "map not exist: " .. arg_31_2)

	if var_5.id ~= var_31_9.id then
		var_5:UpdateActive(false)
		var_5:RemoveFleetsCarries()
		var_5:UnbindFleets()

		var_31_9.findex = var_5.findex
		var_5.findex = nil

		var_31_9:UpdateGridId(arg_31_3)
		var_31_9:BindFleets(arg_31_0.world.fleets)
		var_31_9:UpdateActive(true)
	end

	local var_31_10 = arg_31_0.world

	var_8.OnSwitchMap(var_31_10)

	return
end

function var_0_1.NetUpdateMap(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.id.random_id
	local var_32_1 = arg_32_1.id.template_id

	assert = var_1_10004
	pg = var_1_10006

	var_1_10004(var_1_10006.world_chapter_random[var_32_0], "world_chapter_random not exist: " .. var_32_0)

	assert = var_1_10004
	pg = var_6

	var_1_10004(var_6.world_chapter_template[var_32_1], "world_chapter_template not exist: " .. var_32_1)

	local var_32_2 = {}

	_ = var_1_10005

	var_1_10005.each(arg_32_1.state_flag, function(arg_33_0)
		var_32_2[arg_33_0] = true

		return
	end)

	local var_32_3 = arg_32_0.world
	local var_32_4 = var_5.GetMap(var_32_3, var_32_0)

	var_5.UpdateClearFlag(var_32_4, var_32_2[1])

	local var_32_5 = var_5
	local var_32_6 = var_5.UpdateVisionFlag
	local var_32_8

	if not var_32_2[2] then
		local var_32_7 = arg_32_0.world

		var_32_8 = var_9.IsMapVisioned(var_32_7, var_32_0)
	end

	var_32_6(var_32_5, var_32_8)
	arg_32_0:NetUpdateMapDiscoveredCells(var_5.id, var_32_2[3], arg_32_1.cell_list)

	local var_32_9 = arg_32_0:NetBuildMapAttachmentCells(arg_32_1.pos_list)

	arg_32_0:UpdateMapAttachmentCells(var_5.id, var_32_9)

	local var_32_10 = arg_32_0:NetBuildFleetAttachUpdate(arg_32_1.pos_list)

	arg_32_0:ApplyFleetAttachUpdate(var_5.id, var_32_10)

	WPool = var_8

	var_8:ReturnArray(var_32_10)

	local var_32_11 = arg_32_0:NetBulidTerrainUpdate(arg_32_1.land_list)

	arg_32_0:ApplyTerrainUpdate(var_5.id, var_32_11)

	WPool = var_9

	var_9:ReturnArray(var_32_11)
	var_5:SetValid(true)

	return
end

function var_0_1.NetUpdateMapDiscoveredCells(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0.world
	local var_34_1 = var_4.GetMap(var_34_0, arg_34_1)

	assert = var_1_10005

	var_1_10005(var_34_1, "map not exist: " .. arg_34_1)

	if arg_34_2 then
		pairs = var_1_10005

		for iter_34_0, iter_34_1 in var_1_10005(var_34_1.cells) do
			iter_34_1:UpdateDiscovered(true)
		end
	else
		_ = var_1_10005

		var_1_10005.each(arg_34_3, function(arg_35_0)
			local var_35_0 = var_34_1
			local var_35_1 = var_1.GetCell(var_35_0, arg_35_0.pos.row, arg_35_0.pos.column)

			assert = var_2_10002

			var_2_10002(var_35_1, "cell not exist: " .. arg_35_0.pos.row .. ", " .. arg_35_0.pos.column)
			var_35_1:UpdateDiscovered(true)

			return
		end)
	end

	return
end

function var_0_1.NetUpdateMapPort(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.world
	local var_36_1 = var_3.GetMap(var_36_0, arg_36_1)

	assert = var_1_10004

	var_1_10004(var_36_1, "map not exist: " .. arg_36_1)

	local var_36_2 = var_36_1:GetPort(arg_36_2.port_id)

	assert = var_36_0

	var_36_0(var_36_2, "port not exist: " .. arg_36_2.port_id)

	local var_36_3 = var_36_2
	local var_36_4 = var_36_2.UpdateTaskIds

	_ = var_8

	var_36_4(var_36_3, var_8.rest(arg_36_2.task_list, 1))

	local var_36_5 = var_36_2
	local var_36_6 = var_36_2.UpdateGoods

	_ = var_8

	var_36_6(var_36_5, var_8.map(arg_36_2.goods_list, function(arg_37_0)
		WPool = var_2_10001

		local var_37_0 = var_2_10001
		local var_37_1 = var_2_10001.Get

		WorldGoods = var_2_10004

		local var_37_2 = var_37_1(var_37_0, var_2_10004)

		var_1.Setup(var_37_2, arg_37_0)

		return var_1
	end))
	var_36_2:UpdateExpiredTime(arg_36_2.next_refresh_time)

	return
end

function var_0_1.NetUpdateAchievements(arg_38_0, arg_38_1)
	_ = var_1_10002

	var_1_10002.each(arg_38_1, function(arg_39_0)
		local var_39_0 = arg_38_0.world
		local var_39_1 = var_1.GetAchievement(var_39_0, arg_39_0.id)
		local var_39_2 = arg_38_0.world
		local var_39_3 = var_2.DispatchEvent

		World = var_2_10005

		var_39_3(var_39_2, var_2_10005.EventAchieved, var_39_1:NetUpdate(arg_39_0.process_list))

		return
	end)

	return
end

function var_0_1.NetBuildMapFleetList(arg_40_0, arg_40_1)
	local var_40_0 = {}

	if arg_40_1 then
		local var_40_1 = #arg_40_1

		if 0 < var_40_1 then
			_ = var_40_1

			var_40_1.each(arg_40_1, function(arg_41_0)
				WorldMapFleet = var_2_10001

				local var_41_0 = var_2_10001.New()

				var_1.Setup(var_41_0, arg_41_0)

				table = var_2

				var_2.insert(var_40_0, var_1)

				return
			end)

			table = var_3

			var_3.sort(var_40_0, function(arg_42_0, arg_42_1)
				return arg_42_0.id < arg_42_1.id
			end)

			local var_40_2 = {}

			FleetType = var_4
			var_40_2[var_4.Normal] = 1
			FleetType = var_4
			var_40_2[var_4.Submarine] = 1
			_ = var_4

			var_4.each(var_40_0, function(arg_43_0)
				local var_43_0 = arg_43_0:GetFleetType()

				arg_43_0.index = var_40_2[var_43_0]
				var_40_2[var_43_0] = var_40_2[var_43_0] + 1

				return
			end)
		end
	end

	return var_40_0
end

function var_0_1.NetBuildPortShipList(arg_44_0, arg_44_1)
	_ = var_1_10002

	return var_1_10002.map(arg_44_1, function(arg_45_0)
		WPool = var_2_10001

		local var_45_0 = var_2_10001
		local var_45_1 = var_2_10001.Get

		WorldMapShip = var_2_10004

		local var_45_2 = var_45_1(var_45_0, var_2_10004)

		var_1.Setup(var_45_2, arg_45_0)

		return var_1
	end)
end

function var_0_1.NetResetWorld(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.sendNotification

	GAME = var_1_10004

	var_46_1(var_46_0, var_1_10004.SEND_CMD, {
		cmd = "world",
		arg1 = "reset"
	})

	local var_46_2 = arg_46_0
	local var_46_3 = arg_46_0.sendNotification

	GAME = var_4

	var_46_3(var_46_2, var_4.SEND_CMD, {
		cmd = "kick"
	})

	return
end

function var_0_1.NetBuildMapAttachmentCells(arg_47_0, arg_47_1)
	local var_47_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_47_1, function(arg_48_0)
		local var_48_0 = var_47_0

		WorldMapCell = var_2_10002
		var_48_0[var_2_10002.GetName(arg_48_0.pos.row, arg_48_0.pos.column)] = {
			pos = {
				row = arg_48_0.pos.row,
				column = arg_48_0.pos.column
			},
			attachmentList = arg_48_0.item_list
		}

		return
	end)

	pairs = var_3

	for iter_47_0, iter_47_1 in var_3(var_47_0) do
		local var_47_1 = {}

		_ = var_1_10009

		var_1_10009.each(iter_47_1.attachmentList, function(arg_49_0)
			WPool = var_2_10001

			local var_49_0 = var_2_10001
			local var_49_1 = var_2_10001.Get

			WorldMapAttachment = var_2_10004

			local var_49_2 = var_49_1(var_49_0, var_2_10004)
			local var_49_3 = var_1.Setup

			setmetatable = var_2_10005

			var_49_3(var_49_2, var_2_10005({
				pos = iter_47_1.pos
			}, {
				__index = arg_49_0
			}))

			table = var_49_3

			var_49_3.insert(var_47_1, var_1)

			return
		end)

		iter_47_1.attachmentList = var_47_1
	end

	return var_47_0
end

function var_0_1.UpdateMapAttachmentCells(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0.world
	local var_50_1 = var_3.GetMap(var_50_0, arg_50_1)

	assert = var_1_10004

	var_1_10004(var_50_1, "map not exist: " .. arg_50_1)

	pairs = var_1_10004

	for iter_50_0, iter_50_1 in var_1_10004(arg_50_2) do
		for iter_50_2 = #var_50_1:GetCell(iter_50_1.pos.row, iter_50_1.pos.column).attachments, 1, -1 do
			local var_50_2 = var_10[iter_50_2]

			WorldMapAttachment = var_1_10016

			if not var_1_10016.IsFakeType(var_10[iter_50_2].type) then
				_ = var_1_10016

				if not var_1_10016.any(iter_50_1.attachmentList, function(arg_51_0)
					return var_50_2.type == arg_51_0.type and var_50_2.id == arg_51_0.id
				end) then
					var_9:RemoveAttachment(iter_50_2)
				end
			end
		end

		_ = var_11

		var_11.each(iter_50_1.attachmentList, function(arg_52_0)
			local var_52_0 = arg_52_0.type

			WorldMapAttachment = var_2_10002

			if var_52_0 ~= var_2_10002.TypeFleet then
				_ = var_52_0

				if var_52_0.detect(var_0.attachments, function(arg_53_0)
					return arg_53_0.type == arg_52_0.type and arg_53_0.id == arg_52_0.id
				end) then
					var_1:UpdateFlag(arg_52_0.flag)
					var_1:UpdateData(arg_52_0.data, arg_52_0.effects)

					local var_52_1 = var_50_1

					var_2.AddPhaseDisplay(var_52_1, var_1:UpdateBuffList(arg_52_0.buffList))
				else
					local var_52_2 = var_0

					var_2.AddAttachment(var_52_2, arg_52_0)
				end
			end

			return
		end)
	end

	return
end

function var_0_1.NetBuildFleetAttachUpdate(arg_54_0, arg_54_1)
	local var_54_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_54_1, function(arg_55_0)
		local var_55_0 = {
			row = arg_55_0.pos.row,
			column = arg_55_0.pos.column
		}

		_ = var_2

		var_2.each(arg_55_0.item_list, function(arg_56_0)
			local var_56_0 = arg_56_0.item_type

			WorldMapAttachment = var_3_10002

			if var_56_0 == var_3_10002.TypeFleet then
				WPool = var_56_0

				local var_56_1 = var_56_0
				local var_56_2 = var_56_0.Get

				NetFleetAttachUpdate = var_3_10004

				local var_56_3 = var_56_2(var_56_1, var_3_10004)
				local var_56_4 = var_1.Setup

				setmetatable = var_3_10005

				var_56_4(var_56_3, var_3_10005({
					pos = var_55_0
				}, {
					__index = arg_56_0
				}))

				table = var_56_4

				var_56_4.insert(var_54_0, var_1)
			end

			return
		end)

		return
	end)

	return var_54_0
end

function var_0_1.ApplyFleetAttachUpdate(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0.world
	local var_57_1 = var_3.GetMap(var_57_0, arg_57_1)

	assert = var_1_10004

	var_1_10004(var_57_1, "map not exist: " .. arg_57_1)

	_ = var_1_10004

	var_1_10004.each(arg_57_2, function(arg_58_0)
		local var_58_0 = var_57_1

		var_1.UpdateFleetLocation(var_58_0, arg_58_0.id, arg_58_0.row, arg_58_0.column)

		return
	end)

	return
end

function var_0_1.NetBulidTerrainUpdate(arg_59_0, arg_59_1)
	_ = var_1_10002

	return var_1_10002.map(arg_59_1, function(arg_60_0)
		WPool = var_2_10001

		local var_60_0 = var_2_10001
		local var_60_1 = var_2_10001.Get

		NetTerrainUpdate = var_2_10004

		local var_60_2 = var_60_1(var_60_0, var_2_10004)

		var_1.Setup(var_60_2, arg_60_0)

		return var_1
	end)
end

function var_0_1.ApplyTerrainUpdate(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_0.world
	local var_61_1 = var_3.GetMap(var_61_0, arg_61_1)

	assert = var_1_10004

	var_1_10004(var_61_1, "map not exist: " .. arg_61_1)

	_ = var_1_10004

	var_1_10004.each(arg_61_2, function(arg_62_0)
		local var_62_0 = var_61_1
		local var_62_1 = var_1.GetCell(var_62_0, arg_62_0.row, arg_62_0.column)
		local var_62_2 = var_61_1

		if var_2.FindFleet(var_62_2, var_62_1.row, var_62_1.column) then
			local var_62_3 = var_61_1

			var_3.CheckFleetUpdateFOV(var_62_3, var_2, function()
				local var_63_0 = var_62_1
				local var_63_1 = var_0.UpdateTerrain
				local var_63_2 = arg_62_0

				var_63_1(var_63_0, var_3.GetTerrain(var_63_2), arg_62_0.terrainDir, arg_62_0.terrainStrong)

				return
			end)
		else
			var_62_1:UpdateTerrain(arg_62_0:GetTerrain(), arg_62_0.terrainDir, arg_62_0.terrainStrong)
		end

		return
	end)

	return
end

function var_0_1.NetBuildFleetUpdate(arg_64_0, arg_64_1)
	_ = var_1_10002

	return var_1_10002.map(arg_64_1, function(arg_65_0)
		WPool = var_2_10001

		local var_65_0 = var_2_10001
		local var_65_1 = var_2_10001.Get

		NetFleetUpdate = var_2_10004

		local var_65_2 = var_65_1(var_65_0, var_2_10004)

		var_1.Setup(var_65_2, arg_65_0)

		return var_1
	end)
end

function var_0_1.ApplyFleetUpdate(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_0.world
	local var_66_1 = var_3.GetMap(var_66_0, arg_66_1)

	assert = var_1_10004

	var_1_10004(var_66_1, "map not exist: " .. arg_66_1)

	_ = var_1_10004

	var_1_10004.each(arg_66_2, function(arg_67_0)
		local var_67_0 = var_66_1
		local var_67_1 = var_1.GetFleet(var_67_0, arg_67_0.id)

		assert = var_2_10002

		var_2_10002(var_67_1, "fleet not exist: " .. arg_67_0.id)

		local var_67_2 = var_66_1

		var_2.CheckFleetUpdateFOV(var_67_2, var_67_1, function()
			local var_68_0 = var_67_1

			var_0.UpdateBuffs(var_68_0, arg_67_0.buffs)

			return
		end)

		return
	end)

	return
end

function var_0_1.NetBuildShipUpdate(arg_69_0, arg_69_1)
	_ = var_1_10002

	return var_1_10002.map(arg_69_1, function(arg_70_0)
		WPool = var_2_10001

		local var_70_0 = var_2_10001
		local var_70_1 = var_2_10001.Get

		NetShipUpdate = var_2_10004

		local var_70_2 = var_70_1(var_70_0, var_2_10004)

		var_1.Setup(var_70_2, arg_70_0)

		return var_1
	end)
end

function var_0_1.ApplyShipUpdate(arg_71_0, arg_71_1)
	_ = var_1_10002

	var_1_10002.each(arg_71_1, function(arg_72_0)
		local var_72_0 = arg_71_0.world
		local var_72_1 = var_1.GetShip(var_72_0, arg_72_0.id)

		assert = var_2_10002

		var_2_10002(var_72_1, "ship not exist: " .. arg_72_0.id)
		var_72_1:UpdateHpRant(arg_72_0.hpRant)

		return
	end)

	return
end

function var_0_1.NetUpdateWorldSairenChapter(arg_73_0, arg_73_1)
	_ = var_1_10002

	local var_73_0 = var_1_10002.rest(arg_73_1, 1)
	local var_73_1 = arg_73_0.world
	local var_73_2 = var_3.GetAtlas(var_73_1)

	var_3.SetSairenEntranceList(var_73_2, var_73_0)

	return
end

function var_0_1.NetUpdateWorldMapPressing(arg_74_0, arg_74_1)
	_ = var_1_10002

	local var_74_0 = var_1_10002.rest(arg_74_1, 1)
	local var_74_1 = arg_74_0.world
	local var_74_2 = var_3.GetAtlas(var_74_1)

	var_3.SetPressingMarkList(var_74_2, var_74_0)

	local var_74_3 = arg_74_0.world
	local var_74_4 = var_3.GetAtlas(var_74_3)

	var_3.InitPortMarkNShopList(var_74_4)

	return
end

function var_0_1.NetUpdateWorldShopGoods(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.world

	var_2.InitWorldShopGoods(var_75_0)

	local var_75_1 = arg_75_0.world

	var_2.UpdateWorldShopGoods(var_75_1, arg_75_1)

	return
end

function var_0_1.NetUpdateWorldPressingAward(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0.world
	local var_76_1 = var_2.GetAtlas(var_76_0)

	_ = var_1_10003

	var_1_10003.each(arg_76_1, function(arg_77_0)
		local var_77_0 = arg_77_0.id
		local var_77_1 = {
			id = arg_77_0.award,
			flag = arg_77_0.flag == 1
		}

		arg_76_0.world.pressingAwardDic[var_77_0] = var_77_1

		if not var_77_1.flag then
			local var_77_2 = var_76_1

			var_3.MarkMapTransport(var_77_2, var_77_0)
		end

		return
	end)

	return
end

function var_0_1.NetUpdateWorldPortShopMark(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = arg_78_0.world
	local var_78_1 = var_3.GetAtlas(var_78_0)

	var_3.SetPortMarkList(var_78_1, arg_78_1, arg_78_2)

	return
end

function var_0_1.NetBuildSalvageUpdate(arg_79_0, arg_79_1)
	_ = var_1_10002

	return var_1_10002.map(arg_79_1, function(arg_80_0)
		WPool = var_2_10001

		local var_80_0 = var_2_10001
		local var_80_1 = var_2_10001.Get

		NetSalvageUpdate = var_2_10004

		local var_80_2 = var_80_1(var_80_0, var_2_10004)

		var_1.Setup(var_80_2, arg_80_0)

		return var_1
	end)
end

function var_0_1.ApplySalvageUpdate(arg_81_0, arg_81_1)
	_ = var_1_10002

	var_1_10002.each(arg_81_1, function(arg_82_0)
		local var_82_0 = arg_81_0.world
		local var_82_1 = var_1.GetFleet(var_82_0, arg_82_0.id)

		assert = var_2_10002

		var_2_10002(var_82_1, "fleet not exit: " .. arg_82_0.id)
		var_82_1:UpdateCatSalvage(arg_82_0.step, arg_82_0.list, arg_82_0.mapId)

		return
	end)

	return
end

return var_0_1
