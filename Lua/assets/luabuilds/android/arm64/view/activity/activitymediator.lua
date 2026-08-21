local var_0_0 = class("ActivityMediator", import("..base.ContextMediator"))

var_0_0.EVENT_GO_SCENE = "event go scene"
var_0_0.EVENT_OPERATION = "event operation"
var_0_0.GO_SHOPS_LAYER = "event go shop layer"
var_0_0.GO_SHOPS_LAYER_STEEET = "event go shop layer in shopstreet"
var_0_0.BATTLE_OPERA = "event difficult sel"
var_0_0.GO_BACKYARD = "event go backyard"
var_0_0.GO_LOTTERY = "event go lottery"
var_0_0.EVENT_COLORING_ACHIEVE = "event coloring achieve"
var_0_0.ON_TASK_SUBMIT = "event on task submit"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"
var_0_0.ON_TASK_GO = "event on task go"
var_0_0.OPEN_LAYER = "event OPEN_LAYER"
var_0_0.CLOSE_LAYER = "event CLOSE_LAYER"
var_0_0.EVENT_PT_OPERATION = "event pt op"
var_0_0.BLACKWHITEGRID = "black white grid"
var_0_0.MEMORYBOOK = "memory book"
var_0_0.RETURN_AWARD_OP = "event return award op"
var_0_0.SHOW_AWARD_WINDOW = "event show award window"
var_0_0.GO_DODGEM = "event go dodgem"
var_0_0.GO_SUBMARINE_RUN = "event go sumbarine run"
var_0_0.ON_SIMULATION_COMBAT = "event simulation combat"
var_0_0.ON_AIRFIGHT_COMBAT = "event perform airfight combat"
var_0_0.SPECIAL_BATTLE_OPERA = "special battle opera"
var_0_0.NEXT_DISPLAY_AWARD = "next display awards"
var_0_0.GO_PRAY_POOL = "go pray pool"
var_0_0.SELECT_ACTIVITY = "event select activity"
var_0_0.FETCH_INSTARGRAM = "fetch instagram"
var_0_0.MUSIC_GAME_OPERATOR = "get music game final prize"
var_0_0.SHOW_NEXT_ACTIVITY = "show next activity"
var_0_0.OPEN_RED_PACKET_LAYER = "ActivityMediator:OPEN_RED_PACKET_LAYER"
var_0_0.GO_MINI_GAME = "ActivityMediator.GO_MINI_GAME"
var_0_0.GO_DECODE_MINI_GAME = "ActivityMediator:GO_DECODE_MINI_GAME"
var_0_0.ON_BOBING_RESULT = "on bobing result"
var_0_0.ACTIVITY_PERMANENT = "ActivityMediator.ACTIVITY_PERMANENT"
var_0_0.FINISH_ACTIVITY_PERMANENT = "ActivityMediator.FINISH_ACTIVITY_PERMANENT"
var_0_0.ON_SHAKE_BEADS_RESULT = "on shake beads result"
var_0_0.GO_PERFORM_COMBAT = "ActivityMediator.GO_PERFORM_COMBAT"
var_0_0.ON_AWARD_WINDOW = "ActivityMediator:ON_AWARD_WINDOW"
var_0_0.GO_CARDPUZZLE_COMBAT = "ActivityMediator.GO_CARDPUZZLE_COMBAT"
var_0_0.CHARGE = "ActivityMediator.CHARGE"
var_0_0.BUY_ITEM = "ActivityMediator.BUY_ITEM"
var_0_0.OPEN_CHARGE_ITEM_PANEL = "ActivityMediator.OPEN_CHARGE_ITEM_PANEL"
var_0_0.OPEN_CHARGE_BIRTHDAY = "ActivityMediator.OPEN_CHARGE_BIRTHDAY"
var_0_0.STORE_DATE = "ActivityMediator.STORE_DATE"
var_0_0.ON_ACT_SHOPPING = "ActivityMediator.ON_ACT_SHOPPING"
var_0_0.GO_MONOPOLY2024 = "ActivityMediator:GO_MONOPOLY2024"
var_0_0.GO_MONOPOLY2026 = "ActivityMediator:GO_MONOPOLY2026"
var_0_0.ON_ACTIVITY_TASK_SUBMIT = "ActivityMediator.ON_ACTIVITY_TASK_SUBMIT"
var_0_0.ON_ACTIVITY_TASK_LIST_SUBMIT = "ActivityMediator.ON_ACTIVITY_TASK_LIST_SUBMIT"
var_0_0.GO_CHANGE_SHOP = "go Change shop"
var_0_0.GO_Activity_level = "go Activity level"
var_0_0.ON_ADD_SUBLAYER = "ActivityMediator.ON_ADD_SUBLAYER"
var_0_0.GO_SPECIAL_EXERCISE = "go Special exercise"
var_0_0.GO_SINGLE_PRECOMBAT = "ActivityMediator.GO_SINGLE_PRECOMBAT"
var_0_0.ON_BOSSRUSH_MAP = "ActivityMediator.ON_BOSSRUSH_MAP"
var_0_0.SKIP_ACTIVITY_MAP = "ActivityMediator.SKIP_ACTIVITY_MAP"
var_0_0.OPEN_MINI_PROGRAM = "ActivityMediator.OPEN_MINI_PROGRAM"
var_0_0.ON_COLLAB_BOSSRUSH_MAP = "ActivityMediator.ON_COLLAB_BOSSRUSH_MAP"
var_0_0.OPEN_CULTIVATING_PLANT = "ActivityMediator.OPEN_CULTIVATING_PLANT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_MONOPOLY2024, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = MonopolyCar2024Mediator,
			viewComponent = MonopolyCar2024Scene,
			data = {
				actId = arg_2_1
			},
			onRemoved = arg_2_2
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_MONOPOLY2026, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = MonopolyCar2024Mediator,
			viewComponent = MonopolyCar2026Scene,
			data = {
				actId = arg_3_1
			},
			onRemoved = arg_3_2
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_AWARD_WINDOW, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_1_0.viewComponent:ShowAwardWindow(arg_4_1, arg_4_2, arg_4_3, arg_4_4)

		return
	end)
	arg_1_0:bind(var_0_0.GO_CHANGE_SHOP, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_1_0:bind(var_0_0.GO_Activity_level, function(arg_6_0)
		local var_6_0 = getProxy(ChapterProxy)
		local var_6_1, var_6_2 = var_6_0:getLastMapForActivity()

		if var_6_1 then
			if not var_6_0:getMapById(var_6_1):isUnlock() then
				local var_6_3 = getProxy(ChapterProxy)
				local var_6_4 = var_6_3:getActiveChapter()

				var_6_1 = var_6_4 and var_6_4:getConfig("map")

				if not var_6_4 then
					var_6_1 = var_6_3:GetLastNormalMap()
				end

				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_6_4 and var_6_4.id,
					mapIdx = var_6_1
				})
			else
				if not chapter then
					var_6_1 = var_6_0:GetLastNormalMap()
				end

				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_6_2,
					mapIdx = var_6_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_0.ON_COLLAB_BOSSRUSH_MAP, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_DAL_COLLAB)

		return
	end)
	arg_1_0:bind(var_0_0.ON_BOSSRUSH_MAP, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

		return
	end)
	arg_1_0:bind(var_0_0.GO_DECODE_MINI_GAME, function(arg_9_0)
		pg.m02:sendNotification(GAME.REQUEST_MINI_GAME, {
			type = MiniGameRequestCommand.REQUEST_HUB_DATA,
			callback = function()
				pg.m02:sendNotification(GAME.GO_MINI_GAME, 11)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_MINI_GAME, function(arg_11_0, arg_11_1)
		pg.m02:sendNotification(GAME.GO_MINI_GAME, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBMARINE_RUN, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SUBMARINE_RUN,
			stageId = arg_12_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_DODGEM, function(arg_13_0)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_DODGEM,
			stageId = ys.Battle.BattleConfig.BATTLE_DODGEM_STAGES[math.random(#ys.Battle.BattleConfig.BATTLE_DODGEM_STAGES)]
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SIMULATION_COMBAT, function(arg_14_0, arg_14_1, arg_14_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_14_1.stageId,
			warnMsg = arg_14_1.warnMsg,
			exitCallback = arg_14_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_AIRFIGHT_COMBAT, function(arg_15_0, arg_15_1, arg_15_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_AIRFIGHT,
			stageId = arg_15_1.stageId,
			exitCallback = arg_15_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.RETURN_AWARD_OP, function(arg_16_0, arg_16_1)
		if arg_16_1.cmd == ActivityConst.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW then
			arg_1_0.viewComponent:ShowWindow(ReturnerAwardWindow, arg_16_1.arg1)
		elseif arg_16_1.cmd == ActivityConst.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW then
			arg_1_0.viewComponent:ShowWindow(TaskAwardWindow, arg_16_1.arg1)
		else
			arg_1_0:sendNotification(GAME.RETURN_AWARD_OP, arg_16_1)
		end

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_AWARD_WINDOW, function(arg_17_0, arg_17_1, arg_17_2)
		arg_1_0.viewComponent:ShowWindow(arg_17_1, arg_17_2)

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_PT_OPERATION, function(arg_18_0, arg_18_1)
		arg_1_0:sendNotification(GAME.ACT_NEW_PT, arg_18_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_LAYER, function(arg_19_0, arg_19_1)
		arg_1_0:addSubLayers(arg_19_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RED_PACKET_LAYER, function(arg_20_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_LAYER, function(arg_21_0, arg_21_1)
		local var_21_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_21_1)

		if var_21_0 then
			arg_1_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_21_0
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_OPERATION, function(arg_22_0, arg_22_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_22_1)

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GO_SCENE, function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_1 == SCENE.SUMMER_FEAST then
			pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI1", function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SUMMER_FEAST)

				return
			end)
		else
			arg_1_0:sendNotification(GAME.GO_SCENE, arg_23_1, arg_23_2)
		end

		return
	end)
	arg_1_0:bind(var_0_0.BLACKWHITEGRID, function()
		if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACKWHITE) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = BlackWhiteGridLayer,
			mediator = BlackWhiteGridMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.MEMORYBOOK, function()
		if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = MemoryBookLayer,
			mediator = MemoryBookMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER, function(arg_27_0, arg_27_1)
		if not getProxy(ActivityProxy):getActivityById(arg_27_1.actId) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_27_1 or {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOPS_LAYER_STEEET, function(arg_28_0, arg_28_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_28_1 or {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})

		return
	end)
	arg_1_0:bind(var_0_0.BATTLE_OPERA, function()
		local var_29_0 = getProxy(ChapterProxy)
		local var_29_1, var_29_2 = var_29_0:getLastMapForActivity()

		if var_29_1 then
			if not var_29_0:getMapById(var_29_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_29_2,
					mapIdx = var_29_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_0.SKIP_ACTIVITY_MAP, function(arg_30_0, arg_30_1)
		local var_30_0 = getProxy(ChapterProxy)
		local var_30_1, var_30_2 = var_30_0:getLastMapForActivity(arg_30_1)

		if var_30_1 then
			if not var_30_0:getMapById(var_30_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_30_2,
					mapIdx = var_30_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_0.OPEN_MINI_PROGRAM, function(arg_31_0)
		pg.SdkMgr.GetInstance():OpenMiniProgram()

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CULTIVATING_PLANT, function(arg_32_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CultivatingPlantMediator,
			viewComponent = CultivatingPlantScene
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_SPECIAL_EXERCISE, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACT_BOSS_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_0.SPECIAL_BATTLE_OPERA, function()
		local var_34_0 = getProxy(ChapterProxy)
		local var_34_1, var_34_2 = var_34_0:getLastMapForActivity()

		if var_34_1 then
			if not var_34_0:getMapById(var_34_1):isUnlock() then
				local var_34_3 = getProxy(ChapterProxy)
				local var_34_4 = var_34_3:getActiveChapter()

				var_34_1 = var_34_4 and var_34_4:getConfig("map")

				if not var_34_4 then
					var_34_1 = var_34_3:GetLastNormalMap()
				end

				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_34_4 and var_34_4.id,
					mapIdx = var_34_1
				})
			else
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_34_2,
					mapIdx = var_34_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_0.ON_ADD_SUBLAYER, function(arg_35_0, arg_35_1)
		arg_1_0:addSubLayers(arg_35_1)

		return
	end)
	arg_1_0:bind(var_0_0.GO_LOTTERY, function(arg_36_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = LotteryMediator,
			viewComponent = LotteryLayer,
			data = {
				activityId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY).id
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_BACKYARD, function(arg_37_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_COLORING_ACHIEVE, function(arg_38_0, arg_38_1)
		arg_1_0:sendNotification(GAME.COLORING_ACHIEVE, arg_38_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_39_0, arg_39_1, arg_39_2)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_39_1.id, arg_39_2)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_40_0, arg_40_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_40_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_41_0, arg_41_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_41_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_PRAY_POOL, function(arg_42_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT, {
			goToPray = true
		})

		return
	end)
	arg_1_0:bind(var_0_0.FETCH_INSTARGRAM, function(arg_43_0, ...)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_FETCH, ...)

		return
	end)
	arg_1_0:bind(var_0_0.MUSIC_GAME_OPERATOR, function(arg_44_0, ...)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)
	arg_1_0:bind(var_0_0.SELECT_ACTIVITY, function(arg_45_0, arg_45_1)
		arg_1_0.viewComponent:verifyTabs(arg_45_1)

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_NEXT_ACTIVITY, function(arg_46_0, arg_46_1)
		arg_1_0:showNextActivity(arg_46_1)

		return
	end)
	arg_1_0:bind(var_0_0.ACTIVITY_PERMANENT, function(arg_47_0, arg_47_1)
		if PlayerPrefs.GetString("permanent_time", "") ~= pg.gameset.permanent_mark.description then
			PlayerPrefs.SetString("permanent_time", pg.gameset.permanent_mark.description)
			arg_1_0.viewComponent:updateEntrances()
		end

		local var_47_0 = getProxy(ActivityPermanentProxy):getDoingActivity(ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY)

		if var_47_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_permanent_tips3"))
			arg_1_0.viewComponent:verifyTabs(var_47_0.id)
		else
			arg_1_0:addSubLayers(Context.New({
				mediator = ActivityPermanentMediator,
				viewComponent = ActivityPermanentLayer,
				data = {
					finishId = arg_47_1
				}
			}))
		end

		return
	end)
	arg_1_0:bind(var_0_0.FINISH_ACTIVITY_PERMANENT, function(arg_48_0)
		local var_48_0 = getProxy(ActivityPermanentProxy):getDoingActivity(ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY)

		assert(var_48_0:canPermanentFinish(), "error permanent activity finish")
		arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_FINISH, {
			activity_id = var_48_0.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_PERFORM_COMBAT, function(arg_49_0, arg_49_1, arg_49_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_49_1.stageId,
			memory = arg_49_1.memory
		})

		return
	end)
	arg_1_0:bind(var_0_0.NEXT_DISPLAY_AWARD, function(arg_50_0, arg_50_1, arg_50_2)
		arg_1_0.nextDisplayAwards = arg_50_1

		return
	end)
	arg_1_0:bind(var_0_0.GO_CARDPUZZLE_COMBAT, function(arg_51_0, arg_51_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_CARDPUZZLE,
			combatID = arg_51_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHARGE, function(arg_52_0, arg_52_1)
		arg_1_0:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_52_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_53_0, arg_53_1, arg_53_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_53_1,
			count = arg_53_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_PANEL, function(arg_54_0, arg_54_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_54_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_55_0, arg_55_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.STORE_DATE, function(arg_56_0, arg_56_1)
		({
			activity_id = arg_56_1.actId
		}).intValue = arg_56_1.intValue or 0
		;({
			activity_id = arg_56_1.actId
		}).strValue = arg_56_1.strValue or ""
		;({
			activity_id = arg_56_1.actId
		}).callback = arg_56_1.callback

		arg_1_0:sendNotification(GAME.ACTIVITY_STORE_DATE, {
			activity_id = arg_56_1.actId
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACT_SHOPPING, function(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = arg_57_1,
			cmd = arg_57_2,
			arg1 = arg_57_3,
			arg2 = arg_57_4,
			callback = arg_57_5
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_TASK_SUBMIT, function(arg_58_0, arg_58_1)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_58_1.activityId,
			task_ids = {
				arg_58_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_TASK_LIST_SUBMIT, function(arg_59_0, arg_59_1)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_59_1.activityId,
			task_ids = arg_59_1.ids
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SINGLE_PRECOMBAT, function(arg_60_0, arg_60_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = BossSinglePreCombatLiteMediator,
			viewComponent = BossSinglePreCombatLiteLayer,
			data = {
				system = arg_60_1.system,
				stageId = arg_60_1.stageId,
				actId = arg_60_1.activityID,
				fleets = arg_60_1.fleets
			}
		}))

		return
	end)
	arg_1_0.viewComponent:setActivities(arg_1_0:getDisplayActivity())

	local var_1_0 = getProxy(PlayerProxy):getRawData()

	arg_1_0.viewComponent:setPlayer(var_1_0)
	arg_1_0.viewComponent:setFlagShip((getProxy(BayProxy):getShipById(var_1_0.character)))

	return
end

function var_0_0.getDisplayActivity(arg_61_0)
	return getProxy(ActivityProxy):getPanelActivities()
end

function var_0_0.initNotificationHandleDic(arg_62_0)
	arg_62_0.handleDic = {
		[GAME.SURVEY_DONE] = function(arg_63_0, arg_63_1)
			arg_63_0.viewComponent:removeActivity(arg_63_1:getBody().id)

			return
		end,
		[ActivityProxy.ACTIVITY_ADDED] = function(arg_64_0, arg_64_1)
			local var_64_0 = arg_64_1:getBody()

			if var_64_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LOTTERY then
				return
			end

			arg_64_0.viewComponent:updateActivity(var_64_0)

			if ActivityConst.AOERLIANG_TASK_ID == var_64_0.id then
				arg_64_0.viewComponent:update_task_list_auto_aoerliang(var_64_0)
			end

			return
		end,
		[ActivityProxy.ACTIVITY_UPDATED] = function(...)
			arg_62_0.handleDic[ActivityProxy.ACTIVITY_ADDED](...)

			return
		end,
		[ActivityProxy.ACTIVITY_DELETED] = function(arg_66_0, arg_66_1)
			arg_66_0.viewComponent:removeActivity((arg_66_1:getBody()))

			return
		end,
		[ActivityProxy.ACTIVITY_OPERATION_DONE] = function(arg_67_0, arg_67_1)
			local var_67_0 = arg_67_1:getBody()
			local var_67_1 = getProxy(ActivityProxy):getActivityById(var_67_0)

			if var_67_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
				arg_67_0.viewComponent:updateActivity()
			end

			if MonthSignPage.ShouldPlaySpEffect(var_67_1) then
				if arg_67_0.viewComponent.pageDic[var_67_1.id] then
					arg_67_0.viewComponent.pageDic[var_67_1.id]:ActionInvoke("TryShowSpEffect", function()
						arg_67_0:showNextActivity(var_67_1:getConfig("page_core"))

						return
					end)

					return
				end
			end

			if ActivityConst.AOERLIANG_TASK_ID == var_67_0 then
				return
			end

			arg_67_0:showNextActivity(var_67_1:getConfig("page_core"))

			return
		end,
		[ActivityProxy.ACTIVITY_SHOW_AWARDS] = function(arg_69_0, arg_69_1)
			local var_69_0 = arg_69_1:getBody()

			if arg_69_0.nextDisplayAwards and #arg_69_0.nextDisplayAwards > 0 then
				for iter_69_0 = 1, #arg_69_0.nextDisplayAwards do
					table.insert(var_69_0.awards, arg_69_0.nextDisplayAwards[iter_69_0])
				end
			end

			arg_69_0.nextDisplayAwards = {}

			arg_69_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_69_0.awards, var_69_0.callback)

			return
		end,
		[ActivityProxy.ACTIVITY_SHOW_BB_RESULT] = function(arg_70_0, arg_70_1)
			arg_70_0.viewComponent:emit(ActivityMediator.ON_BOBING_RESULT, (arg_70_1:getBody()))

			return
		end,
		[ActivityProxy.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT] = function(arg_71_0, arg_71_1)
			local var_71_0 = arg_71_1:getBody()

			arg_71_0.viewComponent.pageDic[var_71_0.activityID]:showLotteryAwardResult(var_71_0.awards, var_71_0.number, var_71_0.callback)

			return
		end,
		[ActivityProxy.ACTIVITY_SHOW_SHAKE_BEADS_RESULT] = function(arg_72_0, arg_72_1)
			arg_72_0.viewComponent:emit(ActivityMediator.ON_SHAKE_BEADS_RESULT, (arg_72_1:getBody()))

			return
		end,
		[GAME.SUBMIT_TASK_DONE] = function(arg_73_0, arg_73_1)
			arg_73_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_73_1:getBody(), function()
				arg_73_0.viewComponent:updateTaskLayers()

				return
			end)

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_75_0, arg_75_1)
			arg_75_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_75_1:getBody().awards, function()
				arg_75_0.viewComponent:checkAutoHideActivity()
				arg_75_0.viewComponent:updateTaskLayers()
				existCall(var_0.callback)

				return
			end)

			return
		end,
		[GAME.ACT_NEW_PT_DONE] = function(arg_77_0, arg_77_1)
			arg_77_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_77_1:getBody().awards, function()
				arg_77_0.viewComponent:updateTaskLayers()
				existCall(var_0.callback)

				return
			end)

			return
		end,
		[GAME.BEGIN_STAGE_DONE] = function(arg_79_0, arg_79_1)
			arg_79_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, (arg_79_1:getBody()))

			return
		end,
		[GAME.RETURN_AWARD_OP_DONE] = function(arg_80_0, arg_80_1)
			arg_80_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_80_1:getBody().awards)

			return
		end,
		[VoteProxy.VOTE_ORDER_BOOK_DELETE] = function(arg_81_0, arg_81_1)
			return
		end,
		[VoteProxy.VOTE_ORDER_BOOK_UPDATE] = function(...)
			arg_62_0.handleDic[VoteProxy.VOTE_ORDER_BOOK_DELETE](...)

			return
		end,
		[GAME.REMOVE_LAYERS] = function(arg_83_0, arg_83_1)
			if arg_83_1:getBody().context.mediator == VoteFameHallMediator then
				arg_83_0.viewComponent:updateEntrances()
			end

			return
		end,
		[GAME.MONOPOLY_AWARD_DONE] = function(arg_84_0, arg_84_1)
			local var_84_0 = arg_84_1:getBody()

			if arg_84_0.viewComponent.pageDic[arg_84_0.viewComponent.activity.id] and arg_84_0.viewComponent.pageDic[arg_84_0.viewComponent.activity.id].activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY and arg_84_0.viewComponent.pageDic[arg_84_0.viewComponent.activity.id].onAward then
				arg_84_0.viewComponent.pageDic[arg_84_0.viewComponent.activity.id]:onAward(var_84_0.awards, var_84_0.callback)
			elseif var_84_0.autoFlag then
				arg_84_0.viewComponent:emit(BaseUI.ON_ACHIEVE_AUTO, var_84_0.awards, 1, var_84_0.callback)
			else
				arg_84_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_84_0.awards, var_84_0.callback)
			end

			return
		end,
		[GAME.SEND_MINI_GAME_OP_DONE] = function(arg_85_0, arg_85_1)
			local var_85_0 = arg_85_1:getBody()

			seriesAsync({
				function(arg_86_0)
					if #var_85_0.awards > 0 then
						if arg_85_0.viewComponent then
							arg_85_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_85_0.awards, arg_86_0)
						else
							arg_85_0:emit(BaseUI.ON_ACHIEVE, var_85_0.awards, arg_86_0)
						end
					else
						arg_86_0()
					end

					return
				end
			}, function()
				arg_85_0.viewComponent:updateTaskLayers()

				return
			end)

			return
		end,
		[GAME.ACTIVITY_PERMANENT_START_DONE] = function(arg_88_0, arg_88_1)
			local var_88_0 = arg_88_1:getBody()

			if not getProxy(ActivityPermanentProxy):IsNormalActivityId(var_88_0.id) then
				return
			end

			arg_88_0.viewComponent:verifyTabs(var_88_0.id)

			return
		end,
		[GAME.ACTIVITY_PERMANENT_FINISH_DONE] = function(arg_89_0, arg_89_1)
			local var_89_0 = arg_89_1:getBody()

			if not getProxy(ActivityPermanentProxy):IsNormalActivityId(var_89_0.activity_id) then
				return
			end

			arg_89_0.viewComponent:emit(ActivityMediator.ACTIVITY_PERMANENT, var_89_0.activity_id)

			return
		end,
		[GAME.MEMORYBOOK_UNLOCK_AWARD_DONE] = function(arg_90_0, arg_90_1)
			arg_90_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_90_1:getBody().awards)

			return
		end,
		[GAME.CHARGE_SUCCESS] = function(arg_91_0, arg_91_1)
			arg_91_0.viewComponent:updateTaskLayers()
			arg_91_0.viewComponent:OnChargeSuccess((Goods.Create({
				shop_id = arg_91_1:getBody().shopId
			}, Goods.TYPE_CHARGE)))

			return
		end,
		[GAME.SHOPPING_DONE] = function(arg_92_0, arg_92_1)
			warning("yzh")
			arg_92_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_92_1:getBody().awards, function()
				arg_92_0.viewComponent:updateTaskLayers()

				return
			end)

			return
		end,
		[GAME.ACT_MANUAL_SIGN_DONE] = function(arg_94_0, arg_94_1)
			arg_94_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_94_1:getBody().awards)

			return
		end,
		[ActivityProxy.ACTIVITY_SHOP_SHOW_AWARDS] = function(arg_95_0, arg_95_1)
			arg_95_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_95_1:getBody().awards, function()
				local var_96_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_UR_EXCHANGE)

				if var_96_0 and not var_96_0:isShow() and var_96_0:isCorePage(arg_95_0.contextData.coreName) then
					arg_95_0.viewComponent:removeActivity(var_96_0.id)
				end

				arg_95_0.viewComponent:updateTaskLayers()
				existCall(var_0.callback)

				return
			end)

			return
		end
	}

	return
end

function var_0_0.showNextActivity(arg_97_0, arg_97_1)
	local var_97_0 = getProxy(ActivityProxy)

	if not var_97_0 then
		return
	end

	local var_97_1 = var_97_0:findNextAutoActivity(arg_97_1)

	if var_97_1 then
		if var_97_1.id == ActivityConst.BLACK_FRIDAY_SIGNIN_ACT_ID then
			arg_97_0.contextData.showByNextAct = true

			arg_97_0.viewComponent:verifyTabs(ActivityConst.BLACK_FRIDAY_ACT_ID)
		else
			arg_97_0.viewComponent:verifyTabs(var_97_1.id)
		end

		local var_97_2 = var_97_1:getConfig("type")

		if var_97_2 == ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN then
			arg_97_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = var_97_1.id
			})
		elseif var_97_2 == ActivityConst.ACTIVITY_TYPE_MONTHSIGN then
			arg_97_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_97_1.id,
				cmd = var_97_1:getSpecialData("reMonthSignDay") ~= nil and 3 or 1,
				arg1 = var_97_1:getSpecialData("reMonthSignDay")
			})
		elseif var_97_2 == ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN then
			arg_97_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_97_1.id,
				cmd = var_97_1.data1 < 7 and 1 or 2
			})
		elseif var_97_1.id == ActivityConst.SHADOW_PLAY_ID then
			var_97_1.clientData1 = 1

			arg_97_0:showNextActivity(arg_97_1)
		end

		goto label_97_0
	end

	::label_97_0::

	if not arg_97_0.viewComponent.activity then
		local var_97_3 = arg_97_0.contextData.id

		if not arg_97_0.contextData.id then
			if arg_97_0.contextData.type then
				var_97_3 = checkExist(_.detect(arg_97_0:getDisplayActivity(), function(arg_98_0)
					return arg_98_0:getConfig("type") == arg_97_0.contextData.type
				end), {
					"id"
				}) or 0

				arg_97_0.viewComponent:verifyTabs(var_97_3)

				return
			end
		end
	end
end

return var_0_0
