class = var_0_10000

local var_0_0 = "CommanderCatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.RESERVE_BOX = "CommanderCatMediator:RESERVE_BOX"
var_0_1.OPEN_HOME = "CommanderCatMediator:OPEN_HOME"
var_0_1.ON_SELECT = "CommanderCatMediator:ON_SELECT"
var_0_1.UPGRADE = "CommanderCatMediator:UPGRADE"
var_0_1.LOCK = "CommanderCatMediator:LOCK"
var_0_1.SKILL_INFO = "CommanderCatMediator:SKILL_INFO"
var_0_1.RENAME = "CommanderCatMediator:RENAME"
var_0_1.FETCH_NOT_LEARNED_TALENT = "CommanderCatMediator:FETCH_NOT_LEARNED_TALENT"
var_0_1.LEARN_TALENT = "CommanderCatMediator:LEARN_TALENT"
var_0_1.RESET_TALENT = "CommanderCatMediator:RESET_TALENT"
var_0_1.BATCH_GET = "CommanderCatMediator:BATCH_GET"
var_0_1.ONE_KEY = "CommanderCatMediator:ONE_KEY"
var_0_1.BATCH_BUILD = "CommanderCatMediator:BATCH_BUILD"
var_0_1.BUILD = "CommanderCatMediator:BUILD"
var_0_1.GET = "CommanderCatMediator:GET"
var_0_1.USE_QUICKLY_TOOL = "CommanderCatMediator:USE_QUICKLY_TOOL"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.USE_QUICKLY_TOOL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = {
				arg_2_3
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.COMMANDER_ON_OPEN_BOX, {
			id = arg_3_1,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUILD, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.COMMANDER_ON_BUILD, {
			tip = true,
			id = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.BATCH_BUILD, function(arg_5_0, arg_5_1)
		local var_5_0 = {}

		for iter_5_0 = 1, #arg_5_1 do
			local var_5_1 = arg_5_1[iter_5_0]

			table = var_2_10008

			var_2_10008.insert(var_5_0, function(arg_6_0)
				local var_6_0 = arg_1_0
				local var_6_1 = var_1.sendNotification

				GAME = var_3_10003

				var_6_1(var_6_0, var_3_10003.COMMANDER_ON_BUILD, {
					tip = false,
					id = var_5_1,
					callback = arg_6_0
				})

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_5_0, function()
			pg = var_3_10000

			local var_7_0 = var_3_10000.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_3_10002

			var_7_1(var_7_0, var_3_10002("commander_build_done"))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.ONE_KEY, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_1_0
		local var_8_1 = var_4.sendNotification

		GAME = var_2_10006

		var_8_1(var_8_0, var_2_10006.COMMANDER_QUICKLY_FINISH_BOXES, {
			itemCnt = arg_8_1,
			affectCnt = arg_8_2,
			finishCnt = arg_8_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.BATCH_GET, function(arg_9_0, arg_9_1)
		local var_9_0 = {}

		pairs = var_2_10003

		for iter_9_0, iter_9_1 in var_2_10003(arg_9_1) do
			local var_9_1 = iter_9_1
			local var_9_2 = iter_9_1.getState(var_9_1)

			CommanderBox = var_9_1

			if var_9_2 == var_9_1.STATE_FINISHED then
				table = var_9_2

				var_9_2.insert(var_9_0, iter_9_1.id)
			end
		end

		local var_9_3 = arg_1_0
		local var_9_4 = var_3.sendNotification

		GAME = var_5

		var_9_4(var_9_3, var_5.COMMANDER_ON_BATCH, {
			boxIds = var_9_0
		})

		return
	end)
	arg_1_0:bind(var_0_1.RESET_TALENT, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.COMMANDER_RESET_TALENTS, {
			id = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.LEARN_TALENT, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = arg_1_0
		local var_11_1 = var_4.sendNotification

		GAME = var_2_10006

		var_11_1(var_11_0, var_2_10006.COMMANDER_LEARN_TALENTS, {
			id = arg_11_1,
			talentId = arg_11_2,
			replaceid = arg_11_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_NOT_LEARNED_TALENT, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10004

		var_12_1(var_12_0, var_2_10004.COMMANDER_FETCH_NOT_LEARNED_TALENT, {
			id = arg_12_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.RENAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_1_0
		local var_13_1 = var_3.sendNotification

		GAME = var_2_10005

		var_13_1(var_13_0, var_2_10005.COMMANDER_RENAME, {
			commanderId = arg_13_1,
			name = arg_13_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.SKILL_INFO, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_14_2 = var_2_10004.New
		local var_14_3 = {}

		CommanderSkillMediator = var_2_10006
		var_14_3.mediator = var_2_10006
		NewCommanderSkillLayer = var_2_10006
		var_14_3.viewComponent = var_2_10006
		var_14_3.data = {
			skill = arg_14_1
		}

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)
	arg_1_0:bind(var_0_1.LOCK, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_1_0
		local var_15_1 = var_3.sendNotification

		GAME = var_2_10005

		var_15_1(var_15_0, var_2_10005.COMMANDER_LOCK, {
			commanderId = arg_15_1,
			flag = arg_15_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE, function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		local var_16_0 = arg_1_0
		local var_16_1 = var_4.sendNotification

		GAME = var_2_10006

		var_16_1(var_16_0, var_2_10006.COMMANDER_UPGRADE, {
			id = arg_16_1,
			materialIds = arg_16_2,
			skillId = arg_16_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_1_0
		local var_17_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_17_2 = var_2_10004.New
		local var_17_3 = {}

		ContextMediator = var_2_10006
		var_17_3.mediator = var_2_10006
		SelectCommanderCatForPlayScene = var_2_10006
		var_17_3.viewComponent = var_2_10006
		var_17_3.data = arg_17_1

		var_17_1(var_17_0, var_17_2(var_17_3))

		return
	end)
	arg_1_0:bind(var_0_1.RESERVE_BOX, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.sendNotification

		GAME = var_2_10004

		var_18_1(var_18_0, var_2_10004.COMMANDER_RESERVE_BOX, {
			count = arg_18_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_HOME, function(arg_19_0)
		local var_19_0 = arg_1_0
		local var_19_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_19_2 = var_2_10003.New
		local var_19_3 = {}

		CommanderHomeLayer = var_2_10005
		var_19_3.viewComponent = var_2_10005
		CommanderHomeMediator = var_2_10005
		var_19_3.mediator = var_2_10005

		var_19_1(var_19_0, var_19_2(var_19_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	GAME = var_1_10002
	var_20_0[1] = var_1_10002.COMMANDER_RESERVE_BOX_DONE
	GAME = var_2
	var_20_0[2] = var_2.COMMANDER_QUICKLY_FINISH_BOXES_ERROR
	GAME = var_2
	var_20_0[3] = var_2.COMMANDER_UPGRADE_DONE
	GAME = var_2
	var_20_0[4] = var_2.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE
	GAME = var_2
	var_20_0[5] = var_2.COMMANDER_LEARN_TALENTS_DONE
	GAME = var_2
	var_20_0[6] = var_2.COMMANDER_LOCK_DONE
	CommanderProxy = var_2
	var_20_0[7] = var_2.COMMANDER_UPDATED
	CommanderProxy = var_2
	var_20_0[8] = var_2.COMMANDER_ADDED
	CommanderProxy = var_2
	var_20_0[9] = var_2.COMMANDER_DELETED
	GAME = var_2
	var_20_0[10] = var_2.COMMANDER_CATTERY_OP_DONE
	GAME = var_2
	var_20_0[11] = var_2.ZERO_HOUR_OP_DONE
	GAME = var_2
	var_20_0[12] = var_2.PUT_COMMANDER_IN_CATTERY_DONE
	GAME = var_2
	var_20_0[13] = var_2.COMMANDER_ON_BUILD_DONE
	GAME = var_2
	var_20_0[14] = var_2.REFRESH_COMMANDER_BOXES_DONE
	GAME = var_2
	var_20_0[15] = var_2.COMMANDER_ON_OPEN_BOX_DONE
	GAME = var_2
	var_20_0[16] = var_2.COMMANDER_ON_BATCH_DONE
	PlayerProxy = var_2
	var_20_0[17] = var_2.UPDATED

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.getBody(var_21_1)

	GAME = var_21_1

	local var_21_4

	if var_21_0 == var_21_1.COMMANDER_RESERVE_BOX_DONE then
		local var_21_3 = arg_21_0.viewComponent

		var_21_4 = var_21_4.emit
		CommanderCatScene = var_1_10006

		var_21_4(var_21_3, var_1_10006.MSG_RESERVE_BOX, var_21_2.awards)

		goto label_21_0
	end

	PlayerProxy = var_21_4

	local var_21_6

	if var_21_0 == var_21_4.UPDATED then
		local var_21_5 = arg_21_0.viewComponent

		var_21_6 = var_21_6.emit
		CommanderCatScene = var_1_10006

		var_21_6(var_21_5, var_1_10006.MSG_RES_UPDATE)

		goto label_21_0
	end

	GAME = var_21_6

	local var_21_8

	if var_21_0 == var_21_6.COMMANDER_QUICKLY_FINISH_BOXES_ERROR then
		local var_21_7 = arg_21_0.viewComponent

		var_21_8 = var_21_8.emit
		CommanderCatScene = var_1_10006

		var_21_8(var_21_7, var_1_10006.MSG_QUICKLY_FINISH_TOOL_ERROR)

		goto label_21_0
	end

	GAME = var_21_8

	local var_21_10

	if var_21_0 == var_21_8.COMMANDER_UPGRADE_DONE then
		local var_21_9 = arg_21_0.viewComponent

		var_21_10 = var_21_10.emit
		CommanderCatScene = var_1_10006

		var_21_10(var_21_9, var_1_10006.MSG_UPGRADE, var_21_2.oldCommander, var_21_2.commander)

		goto label_21_0
	end

	GAME = var_21_10

	local var_21_12

	if var_21_0 == var_21_10.COMMANDER_LOCK_DONE then
		if var_21_2.flag == 1 then
			pg = var_21_12

			local var_21_11 = var_21_12.TipsMgr.GetInstance()

			var_21_12 = var_21_12.ShowTips
			i18n = var_1_10006

			var_21_12(var_21_11, var_1_10006("commander_lock_done"))
		elseif var_21_2.flag == 0 then
			pg = var_21_12

			local var_21_13 = var_21_12.TipsMgr.GetInstance()

			var_21_12 = var_21_12.ShowTips
			i18n = var_1_10006

			var_21_12(var_21_13, var_1_10006("commander_unlock_done"))
		end

		goto label_21_0
	end

	GAME = var_21_12

	local var_21_15

	if var_21_0 == var_21_12.COMMANDER_RENAME_DONE then
		pg = var_21_15

		local var_21_14 = var_21_15.TipsMgr.GetInstance()

		var_21_15 = var_21_15.ShowTips
		i18n = var_1_10006

		var_21_15(var_21_14, var_1_10006("commander_rename_success_tip"))

		goto label_21_0
	end

	GAME = var_21_15

	local var_21_17

	if var_21_0 == var_21_15.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE then
		local var_21_16 = arg_21_0.viewComponent

		var_21_17 = var_21_17.emit
		CommanderCatScene = var_1_10006

		var_21_17(var_21_16, var_1_10006.MSG_FETCH_TALENT_LIST)

		goto label_21_0
	end

	GAME = var_21_17

	local var_21_19

	if var_21_0 == var_21_17.COMMANDER_LEARN_TALENTS_DONE then
		local var_21_18 = arg_21_0.viewComponent

		var_21_19 = var_21_19.emit
		CommanderCatScene = var_1_10006

		var_21_19(var_21_18, var_1_10006.MSG_LEARN_TALENT)

		goto label_21_0
	end

	CommanderProxy = var_21_19

	if var_21_0 ~= var_21_19.COMMANDER_UPDATED then
		CommanderProxy = var_21_21

		if var_21_0 ~= var_21_21.COMMANDER_ADDED then
			CommanderProxy = var_21_21

			local var_21_21

			if var_21_0 == var_21_21.COMMANDER_DELETED then
				local var_21_20 = arg_21_0.viewComponent

				var_21_21 = var_21_21.emit
				CommanderCatScene = var_1_10006

				var_21_21(var_21_20, var_1_10006.MSG_UPDATE)

				goto label_21_0
			end

			GAME = var_21_21

			if var_21_0 ~= var_21_21.COMMANDER_CATTERY_OP_DONE then
				GAME = var_21_23

				if var_21_0 ~= var_21_23.ZERO_HOUR_OP_DONE then
					GAME = var_21_23

					local var_21_23

					if var_21_0 == var_21_23.PUT_COMMANDER_IN_CATTERY_DONE then
						local var_21_22 = arg_21_0.viewComponent

						var_21_23 = var_21_23.emit
						CommanderCatScene = var_1_10006

						var_21_23(var_21_22, var_1_10006.MSG_HOME_TIP)

						goto label_21_0
					end

					GAME = var_21_23

					if var_21_0 ~= var_21_23.COMMANDER_ON_BUILD_DONE then
						GAME = var_21_25

						do
							local var_21_25

							if var_21_0 == var_21_25.REFRESH_COMMANDER_BOXES_DONE then
								local var_21_24 = arg_21_0.viewComponent

								var_21_25 = var_21_25.emit
								CommanderCatScene = var_1_10006

								var_21_25(var_21_24, var_1_10006.MSG_BUILD)
							else
								GAME = var_21_25

								if var_21_0 == var_21_25.COMMANDER_ON_OPEN_BOX_DONE then
									pg = var_4

									local var_21_26 = var_4.UIMgr.GetInstance()

									var_4.LoadingOn(var_21_26, false)

									seriesAsync = var_4

									var_4({
										function(arg_22_0)
											local var_22_0 = arg_21_0.viewComponent
											local var_22_1 = var_1.emit

											CommanderCatScene = var_2_10003

											var_22_1(var_22_0, var_2_10003.MSG_OPEN_BOX, var_21_2.boxId, arg_22_0)

											return
										end,
										function(arg_23_0)
											pg = var_2_10001

											local var_23_0 = var_2_10001.UIMgr.GetInstance()

											var_1.LoadingOff(var_23_0)

											local var_23_1 = arg_21_0

											var_1.DisplayNewCommander(var_23_1, var_21_2.commander, arg_23_0)

											return
										end,
										function()
											local var_24_0 = arg_21_0.viewComponent
											local var_24_1 = var_0.emit

											CommanderCatScene = var_2_10002

											var_24_1(var_24_0, var_2_10002.MSG_BUILD)

											return
										end
									}, var_21_2.callback)
								else
									GAME = var_4

									if var_21_0 == var_4.COMMANDER_ON_BATCH_DONE then
										arg_21_0:BatchDisplayCommander(var_21_2.boxIds, var_21_2.commanders)
									end
								end
							end
						end

						::label_21_0::

						return
					end
				end
			end
		end
	end
end

function var_0_1.BatchDisplayCommander(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {}

	ipairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(arg_25_1) do
		table = var_1_10009

		var_1_10009.insert(var_25_0, function(arg_26_0)
			local var_26_0 = arg_25_0.viewComponent
			local var_26_1 = var_1.emit

			CommanderCatScene = var_2_10003

			var_26_1(var_26_0, var_2_10003.MSG_OPEN_BOX, iter_25_1, arg_26_0)

			return
		end)
	end

	getProxy = var_4
	CommanderProxy = var_5

	local var_25_1 = var_4(var_5)

	var_25_1.hasSkipFlag = false
	pg = var_25_1

	local var_25_2 = var_25_1.UIMgr.GetInstance()

	var_4.LoadingOn(var_25_2, false)

	parallelAsync = var_4

	var_4(var_25_0, function()
		pg = var_2_10000

		local var_27_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_27_0)

		local var_27_1 = {}

		ipairs = var_27_0

		for iter_27_0, iter_27_1 in var_27_0(arg_25_2) do
			table = var_2_10006

			var_2_10006.insert(var_27_1, function(arg_28_0)
				getProxy = var_3_10001
				CommanderProxy = var_3_10002

				if var_3_10001(var_3_10002).hasSkipFlag then
					local var_28_0 = iter_27_1

					if not var_1.ShouldTipLock(var_28_0) then
						arg_28_0()

						goto label_28_0
					end
				end

				do
					local var_28_1 = arg_25_0

					var_1.DisplayNewCommander(var_28_1, iter_27_1, arg_28_0)
				end

				::label_28_0::

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_27_1, function()
			local var_29_0 = arg_25_0.viewComponent
			local var_29_1 = var_0.emit

			CommanderCatScene = var_3_10002

			var_29_1(var_29_0, var_3_10002.MSG_BUILD)

			getProxy = var_29_1
			CommanderProxy = var_29_0
			var_29_1(var_29_0).hasSkipFlag = false

			local var_29_2 = arg_25_0.viewComponent
			local var_29_3 = var_0.emit

			CommanderCatScene = var_2

			var_29_3(var_29_2, var_2.MSG_BATCH_BUILD, arg_25_2)

			return
		end)

		return
	end)

	return
end

function var_0_1.DisplayNewCommander(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.addSubLayers

	Context = var_1_10005

	local var_30_2 = var_1_10005.New
	local var_30_3 = {}

	NewCommanderScene = var_1_10007
	var_30_3.viewComponent = var_1_10007
	NewCommanderMediator = var_1_10007
	var_30_3.mediator = var_1_10007
	var_30_3.data = {
		commander = arg_30_1,
		onExit = arg_30_2
	}

	var_30_1(var_30_0, var_30_2(var_30_3))

	return
end

function var_0_1.remove(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.ConnectionMgr.GetInstance()

	if var_1.isConnected(var_31_0) then
		local var_31_1 = arg_31_0
		local var_31_2 = arg_31_0.sendNotification

		GAME = var_1_10003

		var_31_2(var_31_1, var_1_10003.OPEN_OR_CLOSE_CATTERY, {
			open = false
		})
	end

	return
end

return var_0_1
