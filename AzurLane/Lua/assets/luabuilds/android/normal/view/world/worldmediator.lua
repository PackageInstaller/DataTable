class = var_0_10000

local var_0_0 = "WorldMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OnMapOp = "WorldMediator.OnMapOp"
var_0_1.OnMapReq = "WorldMediator.OnMapReq"
var_0_1.OnOpenLayer = "WorldMediator.OnOpenLayer"
var_0_1.OnOpenScene = "WorldMediator.OnOpenScene"
var_0_1.OnChangeScene = "WorldMediator.OnChangeScene"
var_0_1.OnOpenMarkMap = "WorldMediator.OnOpenMarkMap"
var_0_1.OnTriggerTaskGo = "WorldMediator.OnTriggerTaskGo"
var_0_1.OnAutoSubmitTask = "WorldMediator.OnAutoSubmitTask"
var_0_1.OnNotificationOpenLayer = "WorldMediator.OnNotificationOpenLayer"
var_0_1.OnStart = "WorldMediator.OnStart"
var_0_1.OnStartPerform = "WorldMediator.OnStartPerform"
var_0_1.OnStartAutoSwitch = "WorldMediator.OnStartAutoSwitch"
var_0_1.OnMoveAndOpenLayer = "WorldMediator.OnMoveAndOpenLayer"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnMapOp, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.WORLD_MAP_OP, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.OnMapReq, function(arg_3_0, arg_3_1, arg_3_2)
		assert = var_2_10003

		var_2_10003(arg_1_0.fetchCallback == nil)

		arg_1_0.fetchCallback = arg_3_2

		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.WORLD_MAP_REQ, {
			mapId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenLayer, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.addSubLayers(var_4_0, arg_4_1, false, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenScene, function(arg_5_0, arg_5_1, ...)
		local var_5_0 = {}
		local var_5_1 = arg_1_0.viewComponent

		if var_3.GetInMap(var_5_1) then
			table = var_3

			var_3.insert(var_5_0, function(arg_6_0)
				local var_6_0 = arg_1_0.viewComponent

				var_1.EaseOutMapUI(var_6_0, arg_6_0)

				return
			end)
		else
			table = var_3

			var_3.insert(var_5_0, function(arg_7_0)
				local var_7_0 = arg_1_0.viewComponent

				var_1.EaseOutAtlasUI(var_7_0, arg_7_0)

				return
			end)
		end

		packEx = var_3

		local var_5_2 = var_3(...)

		pg = var_4

		local var_5_3 = var_4.UIMgr.GetInstance()

		var_4.LoadingOn(var_5_3)

		seriesAsync = var_4

		var_4(var_5_0, function()
			pg = var_3_10000

			local var_8_0 = var_3_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_8_0)

			local var_8_1 = arg_1_0
			local var_8_2 = var_0.sendNotification

			GAME = var_3_10002

			local var_8_3 = var_3_10002.GO_SCENE
			local var_8_4 = arg_5_1

			unpack = var_3_10004

			var_8_2(var_8_1, var_8_3, var_8_4, var_3_10004(var_5_2, 1, var_5_2.len))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OnChangeScene, function(arg_9_0, arg_9_1, ...)
		local var_9_0 = {}
		local var_9_1 = arg_1_0.viewComponent

		if var_3.GetInMap(var_9_1) then
			table = var_3

			var_3.insert(var_9_0, function(arg_10_0)
				local var_10_0 = arg_1_0.viewComponent

				var_1.EaseOutMapUI(var_10_0, arg_10_0)

				return
			end)
		else
			table = var_3

			var_3.insert(var_9_0, function(arg_11_0)
				local var_11_0 = arg_1_0.viewComponent

				var_1.EaseOutAtlasUI(var_11_0, arg_11_0)

				return
			end)
		end

		packEx = var_3

		local var_9_2 = var_3(...)

		pg = var_4

		local var_9_3 = var_4.UIMgr.GetInstance()

		var_4.LoadingOn(var_9_3)

		seriesAsync = var_4

		var_4(var_9_0, function()
			pg = var_3_10000

			local var_12_0 = var_3_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_12_0)

			local var_12_1 = arg_1_0
			local var_12_2 = var_0.sendNotification

			GAME = var_3_10002

			local var_12_3 = var_3_10002.CHANGE_SCENE
			local var_12_4 = arg_9_1

			unpack = var_3_10004

			var_12_2(var_12_1, var_12_3, var_12_4, var_3_10004(var_9_2, 1, var_9_2.len))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OnStart, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = arg_13_2.damageLevel
		local var_13_1 = arg_13_3

		if var_13_0 > arg_13_3.GetLimitDamageLevel(var_13_1) then
			nowWorld = var_13_0

			local var_13_2 = var_13_0()

			var_4.TriggerAutoFight(var_13_2, false)

			pg = var_4

			local var_13_3 = var_4.MsgboxMgr.GetInstance()
			local var_13_4 = var_4.ShowMsgBox

			var_13_1 = {
				hideYes = true
			}
			i18n = var_2_10007
			var_13_1.content = var_2_10007("world_low_morale")

			var_13_4(var_13_3, var_13_1)
		else
			local var_13_5 = arg_1_0
			local var_13_6 = var_4.sendNotification

			GAME = var_13_1

			local var_13_7 = var_13_1.BEGIN_STAGE
			local var_13_8 = {}

			SYSTEM_WORLD = var_2_10008
			var_13_8.system = var_2_10008
			var_13_8.stageId = arg_13_1

			local var_13_9

			if not arg_13_3:GetHP() or not (arg_13_3:GetHP() / arg_13_3:GetMaxHP()) then
				var_13_9 = nil
			end

			var_13_8.hpRate = var_13_9

			var_13_6(var_13_5, var_13_7, var_13_8)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OnStartPerform, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0
		local var_14_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_14_2 = var_2_10005.BEGIN_STAGE
		local var_14_3 = {}

		SYSTEM_PERFORM = var_2_10007
		var_14_3.system = var_2_10007
		var_14_3.stageId = arg_14_1
		var_14_3.exitCallback = arg_14_2

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end)
	arg_1_0:bind(var_0_1.OnAutoSubmitTask, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10004

		var_15_1(var_15_0, var_2_10004.WORLD_AUTO_SUMBMIT_TASK, {
			taskId = arg_15_1.id
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetPlayer

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRawData(var_1_2))

	return
end

function var_0_1.listNotificationInterests(arg_16_0)
	local var_16_0 = {}

	PlayerProxy = var_1_10002
	var_16_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_16_0[2] = var_2.WORLD_MAP_OP_DONE
	GAME = var_2
	var_16_0[3] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_16_0[4] = var_2.WORLD_STAMINA_EXCHANGE_DONE
	WorldInventoryMediator = var_2
	var_16_0[5] = var_2.OnMap
	WorldCollectionMediator = var_2
	var_16_0[6] = var_2.ON_MAP
	var_16_0[7] = var_0_1.OnOpenMarkMap
	GAME = var_2
	var_16_0[8] = var_2.WORLD_TRIGGER_TASK_DONE
	GAME = var_2
	var_16_0[9] = var_2.WORLD_SUMBMIT_TASK_DONE
	GAME = var_2
	var_16_0[10] = var_2.WORLD_AUTO_SUMBMIT_TASK_DONE
	GAME = var_2
	var_16_0[11] = var_2.WORLD_ITEM_USE_DONE
	GAME = var_2
	var_16_0[12] = var_2.WORLD_RETREAT_FLEET
	var_16_0[13] = var_0_1.OnTriggerTaskGo
	GAME = var_2
	var_16_0[14] = var_2.WORLD_MAP_REQ_DONE
	var_16_0[15] = var_0_1.OnNotificationOpenLayer
	GAME = var_2
	var_16_0[16] = var_2.WORLD_TRIGGER_AUTO_FIGHT
	GAME = var_2
	var_16_0[17] = var_2.WORLD_TRIGGER_AUTO_SWITCH
	var_16_0[18] = var_0_1.OnStartAutoSwitch
	var_16_0[19] = var_0_1.OnMoveAndOpenLayer
	WorldGuider = var_2

	local var_16_1 = var_2.GetInstance()
	local var_16_2 = var_2.GetWorldGuiderNotifies(var_16_1)

	_ = var_16_1

	var_16_1.each(var_16_2, function(arg_17_0)
		var_16_0[#var_16_0 + 1] = arg_17_0

		return
	end)

	return var_16_0
end

function var_0_1.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1
	local var_18_2 = arg_18_1.getBody(var_18_1)

	WorldGuider = var_18_1

	local var_18_3 = var_18_1.GetInstance()

	var_4.WorldGuiderNotifyHandler(var_18_3, var_18_0, var_18_2, arg_18_0.viewComponent)

	nowWorld = var_4

	local var_18_4 = var_4()

	switch = var_18_3

	local var_18_5 = var_18_0
	local var_18_6 = {}

	GAME = var_8
	var_18_6[var_8.WORLD_MAP_OP_DONE] = function()
		local var_19_0 = var_18_2.mapOp
		local var_19_1 = arg_18_0.viewComponent
		local var_19_2 = var_1.GetCommand(var_19_1, var_19_0.depth)

		if var_18_2.result ~= 0 then
			var_19_2:OpDone()

			if var_18_2.result == 2 then
				local var_19_3 = var_18_4.staminaMgr

				var_2.Show(var_19_3)
			end

			return
		end

		local var_19_4 = {}
		local var_19_5
		local var_19_6 = arg_18_0.viewComponent

		var_4.RegistMapOp(var_19_6, var_19_0)

		local var_19_7 = #var_19_0.drops
		local var_19_9

		if 0 < var_19_7 then
			local var_19_8 = var_19_0.op

			WorldConst = var_19_9

			if var_19_8 == var_19_9.OpReqCatSalvage then
				var_19_9 = var_18_4
				var_19_9 = var_4.GetFleet(var_19_9, var_19_0.id)

				local var_19_10 = var_4.GetSalvageScoreRarity(var_19_9)

				if var_18_4.isAutoFight then
					local var_19_11 = var_18_4

					var_19_9.AddAutoInfo(var_19_11, "salvage", {
						drops = var_19_0.drops,
						rarity = var_19_10
					})
				else
					table = var_19_9

					var_19_9.insert(var_19_4, function(arg_20_0)
						local var_20_0 = arg_18_0.viewComponent
						local var_20_1 = var_1.DisplayAwards
						local var_20_2 = var_19_0.drops
						local var_20_3 = {
							title = "commander"
						}

						tostring = var_3_10005
						var_20_3.titleExtra = var_3_10005(var_19_10)

						var_20_1(var_20_0, var_20_2, var_20_3, arg_20_0)

						return
					end)
				end
			elseif var_18_4.isAutoFight then
				var_19_9 = var_18_4

				var_4.AddAutoInfo(var_19_9, "drops", var_19_0.drops)
			else
				table = var_4

				var_4.insert(var_19_4, function(arg_21_0)
					local var_21_0 = arg_18_0.viewComponent

					var_1.DisplayAwards(var_21_0, var_19_0.drops, {}, arg_21_0)

					return
				end)
			end
		end

		if var_19_0.routine then
			function var_19_5()
				var_19_0.routine(var_19_0)

				return
			end

			goto label_19_0
		end

		local var_19_12 = var_19_0.op

		WorldConst = var_19_9
		var_18_0 = var_19_9.ReqName[var_19_12]
		assert = var_5

		var_5(var_18_0, "invalid operation: " .. var_19_12)

		WorldConst = var_5

		if var_19_12 == var_5.OpReqTask then
			goto label_19_0
		end

		WorldConst = var_5

		if var_19_12 ~= var_5.OpReqPressingMap then
			WorldConst = var_5

			if var_19_12 == var_5.OpReqCatSalvage then
				local var_19_13 = var_19_4

				var_19_4 = {}

				function var_19_5()
					local var_23_0 = var_19_2

					var_0.OpDone(var_23_0, var_18_0 .. "Done", var_19_0, var_19_13)

					return
				end
			else
				function var_19_5()
					local var_24_0 = var_19_2

					var_0.OpDone(var_24_0, var_18_0 .. "Done", var_19_0)

					return
				end
			end

			::label_19_0::

			seriesAsync = var_19_12

			var_19_12(var_19_4, var_19_5)

			return
		end
	end
	PlayerProxy = var_8
	var_18_6[var_8.UPDATED] = function()
		local var_25_0 = arg_18_0.viewComponent
		local var_25_1 = var_0.SetPlayer

		getProxy = var_2_10002
		PlayerProxy = var_2_10003

		local var_25_2 = var_2_10002(var_2_10003)

		var_25_1(var_25_0, var_2.getRawData(var_25_2))

		return
	end
	GAME = var_8
	var_18_6[var_8.BEGIN_STAGE_DONE] = function()
		local var_26_0 = arg_18_0
		local var_26_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_26_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_26_1(var_26_0, var_26_2, var_2_10003.COMBATLOAD, var_18_2)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_STAMINA_EXCHANGE_DONE] = function()
		local var_27_0 = arg_18_0.viewComponent

		if not var_0.GetInMap(var_27_0) then
			local var_27_1 = arg_18_0.viewComponent.svFloatPanel

			if var_0.isShowing(var_27_1) then
				var_0:UpdateCost()
			end
		end

		return
	end
	WorldInventoryMediator = var_8
	var_18_6[var_8.OnMap] = function()
		local var_28_0 = arg_18_0.viewComponent

		var_0.Op(var_28_0, "OpFocusTargetEntrance", var_18_2)

		return
	end
	WorldCollectionMediator = var_8
	var_18_6[var_8.ON_MAP] = function()
		local var_29_0 = arg_18_0.viewComponent

		var_0.Op(var_29_0, "OpFocusTargetEntrance", var_18_2)

		return
	end
	var_18_6[var_0_1.OnOpenMarkMap] = function()
		local var_30_0 = arg_18_0.viewComponent

		var_0.Op(var_30_0, "OpShowMarkOverview", var_18_2)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_TRIGGER_TASK_DONE] = function()
		pg = var_2_10000

		local var_31_0 = var_2_10000.WorldToastMgr.GetInstance()

		var_0.ShowToast(var_31_0, var_18_2.task, false)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_SUMBMIT_TASK_DONE] = function()
		local var_32_0 = {}

		if #var_18_2.task.config.task_ed > 0 then
			table = var_2

			var_2.insert(var_32_0, function(arg_33_0)
				pg = var_3_10001

				local var_33_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_33_0, var_0.config.task_ed, arg_33_0, true)

				return
			end)
		end

		if var_18_2.drops and #var_18_2.drops > 0 then
			if var_18_4.isAutoFight then
				local var_32_1 = var_18_4

				var_2.AddAutoInfo(var_32_1, "drops", var_18_2.drops)
			else
				table = var_2

				var_2.insert(var_32_0, function(arg_34_0)
					local var_34_0 = arg_18_0.viewComponent

					var_1.DisplayAwards(var_34_0, var_18_2.drops, {}, arg_34_0)

					return
				end)
			end
		end

		ipairs = var_2

		for iter_32_0, iter_32_1 in var_2(var_18_2.expfleets) do
			table = var_2_10007

			var_2_10007.insert(var_32_0, function(arg_35_0)
				local var_35_0 = iter_32_1.oldships
				local var_35_1 = iter_32_1.newships
				local var_35_2 = arg_18_0.viewComponent
				local var_35_3 = var_3.emit

				BaseUI = var_3_10005

				var_35_3(var_35_2, var_3_10005.ON_SHIP_EXP, {
					title = "without word",
					oldShips = var_35_0,
					newShips = var_35_1
				}, arg_35_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_32_0, function()
			pg = var_3_10000

			local var_36_0 = var_3_10000.WorldToastMgr.GetInstance()

			var_0.ShowToast(var_36_0, var_0, true)

			return
		end)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_AUTO_SUMBMIT_TASK_DONE] = function()
		local var_37_0 = {}

		if #var_18_2.task.config.task_ed > 0 then
			table = var_2

			var_2.insert(var_37_0, function(arg_38_0)
				pg = var_3_10001

				local var_38_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_38_0, var_0.config.task_ed, arg_38_0, true)

				return
			end)
		end

		if var_18_2.drops and #var_18_2.drops > 0 then
			if var_18_4.isAutoFight then
				local var_37_1 = var_18_4

				var_2.AddAutoInfo(var_37_1, "drops", var_18_2.drops)
			else
				table = var_2

				var_2.insert(var_37_0, function(arg_39_0)
					local var_39_0 = arg_18_0.viewComponent

					var_1.DisplayAwards(var_39_0, var_18_2.drops, {}, arg_39_0)

					return
				end)
			end
		end

		ipairs = var_2

		for iter_37_0, iter_37_1 in var_2(var_18_2.expfleets) do
			table = var_2_10007

			var_2_10007.insert(var_37_0, function(arg_40_0)
				local var_40_0 = iter_37_1.oldships
				local var_40_1 = iter_37_1.newships
				local var_40_2 = arg_18_0.viewComponent
				local var_40_3 = var_3.emit

				BaseUI = var_3_10005

				var_40_3(var_40_2, var_3_10005.ON_SHIP_EXP, {
					title = "without word",
					oldShips = var_40_0,
					newShips = var_40_1
				}, arg_40_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_37_0, function()
			pg = var_3_10000

			local var_41_0 = var_3_10000.WorldToastMgr.GetInstance()

			var_0.ShowToast(var_41_0, var_0, true)

			local var_41_1 = arg_18_0.viewComponent
			local var_41_2 = var_0.GetCommand(var_41_1)

			var_0.OpDone(var_41_2, "OpAutoSubmitTaskDone", var_0)

			return
		end)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_ITEM_USE_DONE] = function()
		local var_42_0 = var_18_2.item
		local var_42_1 = var_18_2.drops
		local var_42_2 = {}

		switch = var_2_10003

		local var_42_3 = var_42_0:getWorldItemType()
		local var_42_4 = {}

		WorldItem = var_2_10006
		var_42_4[var_2_10006.UsageWorldClean] = function()
			table = var_3_10000

			var_3_10000.insert(var_42_2, function(arg_44_0)
				pg = var_4_10001

				local var_44_0 = var_4_10001.gameset.world_story_recycle_item.description[1]

				pg = var_4_10002

				local var_44_1 = var_4_10002.NewStoryMgr.GetInstance()

				var_2.Play(var_44_1, var_44_0, arg_44_0, true)

				return
			end)

			table = var_0

			var_0.insert(var_42_2, function(arg_45_0)
				local var_45_0 = arg_18_0.viewComponent

				var_1.GetAllPessingAward(var_45_0, arg_45_0)

				return
			end)

			return
		end
		WorldItem = var_6
		var_42_4[var_6.UsageWorldFlag] = function()
			table = var_3_10000

			var_3_10000.insert(var_42_2, function(arg_47_0)
				pg = var_4_10001

				local var_47_0 = var_4_10001.gameset.world_story_treasure_item.description[1]

				pg = var_4_10002

				local var_47_1 = var_4_10002.NewStoryMgr.GetInstance()

				var_2.Play(var_47_1, var_47_0, arg_47_0, true)

				return
			end)

			return
		end
		WorldItem = var_6
		var_42_4[var_6.UsageWorldBuff] = function()
			local var_48_0 = var_42_0
			local var_48_1, var_48_2 = var_0.getItemWorldBuff(var_48_0)
			local var_48_3 = var_48_2 * var_42_0.count

			table = var_2

			var_2.insert(var_42_2, function(arg_49_0)
				local var_49_0 = {
					id = var_48_1,
					floor = var_48_3
				}
				local var_49_1 = var_18_4
				local var_49_2 = var_2.GetGlobalBuff(var_49_1, var_48_1)

				var_49_0.before = var_2.GetFloor(var_49_2)

				local var_49_3 = arg_18_0.viewComponent

				var_2.ShowSubView(var_49_3, "GlobalBuff", {
					var_49_0,
					arg_49_0
				})

				return
			end)

			table = var_2

			var_2.insert(var_42_2, function(arg_50_0)
				local var_50_0 = var_18_4

				var_1.AddGlobalBuff(var_50_0, var_48_1, var_48_3)
				arg_50_0()

				return
			end)

			return
		end
		WorldItem = var_6
		var_42_4[var_6.UsageWorldFlag] = function()
			switch = var_3_10000

			local var_51_0 = var_42_0

			var_3_10000(var_1.getItemFlagKey(var_51_0), {
				function()
					table = var_4_10000

					var_4_10000.insert(var_42_2, function(arg_53_0)
						local var_53_0 = var_18_4

						if not var_1.GetActiveMap(var_53_0).visionFlag then
							local var_53_1 = var_18_4

							if var_2.IsMapVisioned(var_53_1, var_1.id) then
								var_1:UpdateVisionFlag(true)
							end
						end

						arg_53_0()

						return
					end)

					return
				end
			})

			return
		end

		var_2_10003(var_42_3, var_42_4)

		if #var_42_1 > 0 then
			if var_18_4.isAutoFight then
				local var_42_5 = var_18_4

				var_3.AddAutoInfo(var_42_5, "drops", var_42_1)
			else
				table = var_3

				var_3.insert(var_42_2, function(arg_54_0)
					local var_54_0 = arg_18_0.viewComponent

					var_1.DisplayAwards(var_54_0, var_42_1, {}, arg_54_0)

					return
				end)
			end
		end

		seriesAsync = var_3

		var_3(var_42_2, function()
			return
		end)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_RETREAT_FLEET] = function()
		local var_56_0 = var_18_4
		local var_56_1 = var_0.GetFleet(var_56_0)
		local var_56_2 = arg_18_0.viewComponent

		var_1.Op(var_56_2, "OpReqRetreat", var_56_1)

		return
	end
	var_18_6[var_0_1.OnTriggerTaskGo] = function()
		local var_57_0 = arg_18_0.viewComponent

		var_0.Op(var_57_0, "OpTaskGoto", var_18_2.taskId)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_MAP_REQ_DONE] = function()
		assert = var_2_10000

		var_2_10000(arg_18_0.fetchCallback)

		existCall = var_2_10000

		var_2_10000(arg_18_0.fetchCallback)

		arg_18_0.fetchCallback = nil

		return
	end
	var_18_6[var_0_1.OnNotificationOpenLayer] = function()
		local var_59_0 = arg_18_0

		var_0.addSubLayers(var_59_0, var_18_2.context)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_TRIGGER_AUTO_FIGHT] = function()
		local var_60_0 = arg_18_0.viewComponent

		var_0.UpdateAutoFightDisplay(var_60_0)

		return
	end
	GAME = var_8
	var_18_6[var_8.WORLD_TRIGGER_AUTO_SWITCH] = function()
		local var_61_0 = arg_18_0.viewComponent

		var_0.UpdateAutoSwitchDisplay(var_61_0)

		return
	end
	var_18_6[var_0_1.OnStartAutoSwitch] = function()
		local var_62_0 = arg_18_0.viewComponent

		var_0.StartAutoSwitch(var_62_0)

		return
	end
	var_18_6[var_0_1.OnMoveAndOpenLayer] = function()
		local var_63_0 = arg_18_0.viewComponent

		var_0.MoveAndOpenLayer(var_63_0, var_18_2)

		return
	end

	var_18_3(var_18_5, var_18_6)

	return
end

return var_0_1
