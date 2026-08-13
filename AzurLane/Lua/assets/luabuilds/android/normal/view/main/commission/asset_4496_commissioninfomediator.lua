class = var_0_10000

local var_0_0 = "CommissionInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.FINISH_EVENT = "CommissionInfoMediator.FINISH_EVENT"
var_0_1.FINISH_CLASS = "CommissionInfoMediator.FINISH_CLASS"
var_0_1.GET_OIL_RES = "CommissionInfoMediator.GET_OIL_RES"
var_0_1.GET_GOLD_RES = "CommissionInfoMediator.GET_GOLD_RES"
var_0_1.ON_ACTIVE_EVENT = "CommissionInfoMediator.ON_ACTIVE_EVENT"
var_0_1.ON_ACTIVE_CLASS = "CommissionInfoMediator.ON_ACTIVE_CLASS"
var_0_1.ON_ACTIVE_TECH = "CommissionInfoMediator.ON_ACTIVE_TECH"
var_0_1.ON_TECH_FINISHED = "CommissionInfoMediator.ON_TECH_FINISHED"
var_0_1.ON_TECH_QUEUE_FINISH = "CommissionInfoMediator.ON_TECH_QUEUE_FINISH"
var_0_1.ON_INS = "CommissionInfoMediator.ON_INS"
var_0_1.ON_UR_ACTIVITY = "CommissionInfoMediator:ON_UR_ACTIVITY"
var_0_1.ON_CRUSING = "CommissionInfoMediator.ON_CRUSING"
var_0_1.GET_CLASS_RES = "CommissionInfoMediator:GET_CLASS_RES"
var_0_1.FINISH_CLASS_ALL = "CommissionInfoMediator:FINISH_CLASS_ALL"
var_0_1.GO_META_BOSS = "CommissionInfoMediator:GO_META_BOSS"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_1, var_1_0:getData())
	arg_1_0:bind(var_0_1.GO_META_BOSS, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.WORLDBOSS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UR_ACTIVITY, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.ACTIVITY
		local var_3_4 = {}

		ActivityConst = var_2_10006
		var_3_4.id = var_2_10006.UR_ITEM_ACT_ID

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CRUSING, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.CRUSING)

		return
	end)
	arg_1_0:bind(var_0_1.GET_CLASS_RES, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.HARVEST_CLASS_RES)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TECH_QUEUE_FINISH, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.FINISH_QUEUE_TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TECH_FINISHED, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.FINISH_TECHNOLOGY, {
			id = arg_7_1.id,
			pool_id = arg_7_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_1.FINISH_EVENT, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0.contextData.oneStepFinishEventCount = arg_8_2
		arg_1_0.contextData.inFinished = true

		local var_8_0 = arg_1_0
		local var_8_1 = var_4.sendNotification

		GAME = var_2_10006

		var_8_1(var_8_0, var_2_10006.EVENT_FINISH, {
			id = arg_8_1.id,
			callback = function()
				arg_1_0.contextData.inFinished = nil

				return
			end,
			onConfirm = function()
				if arg_8_3 then
					arg_8_3()
				end

				local var_10_0

				if arg_1_0.contextData.oneStepFinishEventCount then
					var_10_0 = arg_1_0.contextData
					var_10_0.oneStepFinishEventCount = arg_1_0.contextData.oneStepFinishEventCount - 1

					if arg_1_0.contextData.oneStepFinishEventCount <= 0 then
						MainMetaSkillSequence = var_10_0

						local var_10_1 = var_10_0.New()

						var_10_0.Execute(var_10_1)
					end
				else
					MainMetaSkillSequence = var_10_0

					local var_10_2 = var_10_0.New()

					var_0.Execute(var_10_2)
				end

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.FINISH_CLASS, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = arg_1_0
		local var_11_1 = var_4.sendNotification

		GAME = var_2_10006

		var_11_1(var_11_0, var_2_10006.CANCEL_LEARN_TACTICS, {
			shipId = arg_11_1,
			type = arg_11_2,
			onConfirm = arg_11_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_EVENT, function(arg_12_0)
		local var_12_0 = arg_1_0
		local var_12_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_12_1(var_12_0, var_12_2, var_2_10004.EVENT)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_CLASS, function(arg_13_0)
		local var_13_0 = arg_1_0
		local var_13_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_13_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_13_1(var_13_0, var_13_2, var_2_10004.NAVALTACTICS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVE_TECH, function(arg_14_0)
		local var_14_0 = arg_1_0
		local var_14_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_14_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_14_1(var_14_0, var_14_2, var_2_10004.TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_1.GET_OIL_RES, function(arg_15_0)
		local var_15_0 = arg_1_0
		local var_15_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_15_2 = var_2_10003.HARVEST_RES

		PlayerConst = var_2_10004

		var_15_1(var_15_0, var_15_2, var_2_10004.ResOil)

		return
	end)
	arg_1_0:bind(var_0_1.GET_GOLD_RES, function(arg_16_0)
		local var_16_0 = arg_1_0
		local var_16_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_16_2 = var_2_10003.HARVEST_RES

		PlayerConst = var_2_10004

		var_16_1(var_16_0, var_16_2, var_2_10004.ResGold)

		return
	end)
	arg_1_0:bind(var_0_1.ON_INS, function(arg_17_0)
		local var_17_0 = arg_1_0
		local var_17_1 = var_1.sendNotification

		GAME = var_2_10003

		var_17_1(var_17_0, var_2_10003.ON_OPEN_INS_LAYER)

		local var_17_2 = arg_1_0.viewComponent
		local var_17_3 = var_1.emit

		BaseUI = var_3

		var_17_3(var_17_2, var_3.ON_CLOSE)

		return
	end)
	arg_1_0:bind(var_0_1.FINISH_CLASS_ALL, function()
		local var_18_0 = arg_1_0
		local var_18_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_18_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_18_1(var_18_0, var_18_2, var_2_10003.NAVALTACTICS)

		return
	end)
	arg_1_0:Notify()

	return
end

function var_0_1.Notify(arg_19_0)
	local var_19_0 = arg_19_0.viewComponent

	var_1.NotifyIns(var_19_0)

	local var_19_1 = arg_19_0.viewComponent

	var_1.UpdateLinkPanel(var_19_1)

	return
end

function var_0_1.continueClass(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_20_0 = var_1_10004(var_1_10005)
	local var_20_1 = var_4.getShipById(var_20_0, arg_20_1)

	getProxy = var_20_0
	BagProxy = var_7

	local var_20_2 = var_20_0(var_7)
	local var_20_3 = var_6.getItemsByType

	Item = var_1_10009

	local var_20_4 = var_20_3(var_20_2, var_1_10009.LESSON_TYPE)

	table = var_20_2

	if var_20_2.getCount(var_20_4 or {}) <= 0 then
		pg = var_8

		local var_20_5 = var_8.TipsMgr.GetInstance()
		local var_20_6 = var_8.ShowTips

		i18n = var_1_10010

		var_20_6(var_20_5, var_1_10010("tactics_no_lesson"))

		return
	end

	local var_20_7 = arg_20_0
	local var_20_8 = arg_20_0.sendNotification

	GAME = var_1_10010

	local var_20_9 = var_1_10010.GO_SCENE

	SCENE = var_1_10011

	var_20_8(var_20_7, var_20_9, var_1_10011.NAVALTACTICS, {
		shipToLesson = {
			shipId = arg_20_1,
			skillIndex = var_20_1:getSkillIndex(arg_20_2),
			index = arg_20_3
		}
	})

	return
end

function var_0_1.listNotificationInterests(arg_21_0)
	local var_21_0 = {}

	PlayerProxy = var_1_10002
	var_21_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_21_0[2] = var_2.HARVEST_RES_DONE
	GAME = var_2
	var_21_0[3] = var_2.EVENT_LIST_UPDATE
	GAME = var_2
	var_21_0[4] = var_2.EVENT_FINISH_UPDATE
	GAME = var_2
	var_21_0[5] = var_2.EVENT_SHOW_AWARDS
	GAME = var_2
	var_21_0[6] = var_2.CANCEL_LEARN_TACTICS_DONE
	GAME = var_2
	var_21_0[7] = var_2.FINISH_TECHNOLOGY_DONE
	GAME = var_2
	var_21_0[8] = var_2.FINISH_QUEUE_TECHNOLOGY_DONE

	return var_21_0
end

function var_0_1.handleNotification(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getName()
	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.getBody(var_22_1)

	PlayerProxy = var_22_1

	if var_22_0 == var_22_1.UPDATED then
		var_1_10005 = arg_22_0.viewComponent

		var_4.OnPlayerUpdate(var_1_10005, var_22_2)

		goto label_22_0
	end

	GAME = var_4

	local var_22_3

	if var_22_0 == var_4.HARVEST_RES_DONE then
		var_22_3 = nil

		if var_22_2.type == 2 then
			i18n = var_1_10005
			var_22_3 = var_1_10005("word_oil")
		elseif var_22_2.type == 1 then
			i18n = var_1_10005
			var_22_3 = var_1_10005("word_gold")
		end

		pg = var_1_10005
		var_1_10006 = var_1_10005.TipsMgr.GetInstance()
		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10007

		var_1_10005(var_1_10006, var_1_10007("commission_get_award", var_22_3, var_22_2.outPut))

		goto label_22_0
	end

	GAME = var_22_3

	if var_22_0 ~= var_22_3.EVENT_LIST_UPDATE then
		GAME = var_22_4

		do
			local var_22_4

			if var_22_0 == var_22_4.EVENT_FINISH_UPDATE then
				getProxy = var_22_4
				EventProxy = var_1_10005
				var_22_4 = var_22_4(var_1_10005)
				var_1_10006 = arg_22_0.viewComponent

				var_1_10005.OnUpdateEventInfo(var_1_10006)
			else
				GAME = var_22_4

				local var_22_5

				if var_22_0 == var_22_4.EVENT_SHOW_AWARDS then
					var_22_5 = nil
					coroutine = var_1_10005

					var_1_10005.wrap(function()
						if #var_22_2.oldShips > 0 then
							local var_23_0 = arg_22_0.viewComponent
							local var_23_1 = var_0.emit

							BaseUI = var_2_10002
							var_2_10002 = var_2_10002.ON_SHIP_EXP

							local var_23_2 = {}

							pg = var_2_10004
							var_23_2.title = var_2_10004.collection_template[var_22_2.eventId].title
							var_23_2.oldShips = var_22_2.oldShips
							var_23_2.newShips = var_22_2.newShips
							var_23_2.isCri = var_22_2.isCri

							var_23_1(var_23_0, var_2_10002, var_23_2, var_22_5)

							coroutine = var_23_1

							var_23_1.yield()
						end

						local var_23_3 = arg_22_0.viewComponent
						local var_23_4 = var_0.emit

						BaseUI = var_2_10002

						var_23_4(var_23_3, var_2_10002.ON_ACHIEVE, var_22_2.awards, function()
							if var_22_2.onConfirm then
								var_22_2.onConfirm()
							end

							return
						end)

						return
					end)()
				else
					GAME = var_22_5

					local var_22_7

					if var_22_0 == var_22_5.CANCEL_LEARN_TACTICS_DONE then
						local var_22_6 = arg_22_0.viewComponent

						var_22_7.OnUpdateClass(var_22_6)

						var_22_7 = var_22_2.totalExp

						local var_22_8 = var_22_2.oldSkill

						var_1_10006 = var_22_2.newSkill
						getProxy = var_1_10007
						BayProxy = var_1_10008

						local var_22_9 = var_1_10007(var_1_10008)
						local var_22_10 = var_7.getShipById(var_22_9, var_22_2.shipId)
						local var_22_11 = var_1_10006.id
						local var_22_12
						local var_22_15

						if var_1_10006.level > var_22_8.level then
							i18n = var_22_15

							local var_22_13 = "tactics_end_to_learn"
							local var_22_14 = var_22_10

							var_1_10012 = var_22_10.getName(var_22_14)
							getSkillName = var_22_14
							var_22_15 = var_22_15(var_22_13, var_1_10012, var_22_14(var_22_11), var_22_7)
							i18n = var_22_13
							var_22_12 = var_22_15 .. var_22_13("tactics_skill_level_up", var_22_8.level, var_1_10006.level)
						else
							i18n = var_22_15

							local var_22_16 = "tactics_end_to_learn"
							local var_22_17 = var_22_10

							var_1_10012 = var_22_10.getName(var_22_17)
							getSkillName = var_22_17
							var_22_12 = var_22_15(var_22_16, var_1_10012, var_22_17(var_22_11), var_22_7)
						end

						pg = var_22_15

						if var_22_15.skill_data_template[var_22_11].max_level <= var_1_10006.level then
							var_1_10012 = arg_22_0

							arg_22_0.HandleClassMaxLevel(var_1_10012, var_22_10, var_22_2, var_22_11, var_22_7)
						else
							local var_22_18 = var_22_12

							i18n = var_1_10012

							local var_22_19 = var_22_18 .. var_1_10012("tactics_continue_to_learn")

							pg = var_22_18

							local var_22_20 = var_22_18.MsgboxMgr.GetInstance()

							var_11.ShowMsgBox(var_22_20, {
								modal = true,
								hideNo = false,
								hideClose = true,
								content = var_22_19,
								onYes = function()
									arg_22_0.openMsgBox = false

									local var_25_0 = arg_22_0

									var_0.continueClass(var_25_0, var_22_2.shipId, var_22_11, var_22_2.id)

									return
								end,
								onNo = function()
									arg_22_0.openMsgBox = false

									return
								end
							})
						end
					else
						GAME = var_22_7

						local var_22_23

						if var_22_0 == var_22_7.FINISH_TECHNOLOGY_DONE then
							local var_22_21 = arg_22_0.viewComponent

							var_22_23.OnUpdateTechnology(var_22_21)

							if #var_22_2.items > 0 then
								local var_22_22 = arg_22_0.viewComponent

								var_22_23 = var_22_23.emit
								BaseUI = var_1_10006

								var_22_23(var_22_22, var_1_10006.ON_AWARD, {
									animation = true,
									items = var_22_2.items
								})
							end
						else
							GAME = var_22_23

							if var_22_0 == var_22_23.FINISH_QUEUE_TECHNOLOGY_DONE then
								local var_22_24 = arg_22_0.viewComponent

								var_4.OnUpdateTechnology(var_22_24)

								local var_22_25 = {}

								ipairs = var_22_24

								for iter_22_0, iter_22_1 in var_22_24(var_22_2.dropInfos) do
									if #iter_22_1 > 0 then
										table = var_10

										var_10.insert(var_22_25, function(arg_27_0)
											local var_27_0 = arg_22_0.viewComponent
											local var_27_1 = var_1.emit

											BaseUI = var_2_10003

											var_27_1(var_27_0, var_2_10003.ON_AWARD, {
												animation = true,
												items = iter_22_1,
												removeFunc = arg_27_0
											})

											return
										end)
									end
								end

								seriesAsync = var_5

								var_5(var_22_25, function()
									getProxy = var_2_10000
									TechnologyProxy = var_2_10001

									local var_28_0 = var_2_10000(var_2_10001)

									if var_0.getActivateTechnology(var_28_0) and var_0:isCompleted() then
										local var_28_1 = arg_22_0
										local var_28_2 = var_1.sendNotification

										GAME = var_2_10003

										var_28_2(var_28_1, var_2_10003.FINISH_TECHNOLOGY, {
											id = var_0.id,
											pool_id = var_0.poolId
										})
									end

									return
								end)
							end
						end
					end
				end
			end
		end

		::label_22_0::

		return
	end
end

function var_0_1.HandleClassMaxLevel(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	i18n = var_1_10005

	local var_29_0 = "tactics_end_to_learn"
	local var_29_1 = arg_29_1
	local var_29_2 = arg_29_1.getName(var_29_1)

	getSkillName = var_29_1

	local var_29_3 = var_1_10005(var_29_0, var_29_2, var_29_1(arg_29_3), arg_29_4)
	local var_29_4 = arg_29_1
	local var_29_5 = arg_29_1.getSkillList(var_29_4)

	_ = var_29_4

	if var_29_4.all(var_29_5, function(arg_30_0)
		ShipSkill = var_2_10001

		local var_30_0 = var_2_10001.New(arg_29_1.skills[arg_30_0])

		return var_1.IsMaxLevel(var_30_0)
	end) then
		local var_29_6 = var_29_3

		i18n = var_8

		local var_29_7 = var_29_6 .. var_8("tactics_continue_to_learn_other_ship_skill")

		pg = var_8

		local var_29_8 = var_8.MsgboxMgr.GetInstance()

		var_8.ShowMsgBox(var_29_8, {
			modal = true,
			hideClose = true,
			content = var_29_7,
			onYes = function()
				local var_31_0 = arg_29_0
				local var_31_1 = var_0.sendNotification

				GAME = var_2_10002

				local var_31_2 = var_2_10002.GO_SCENE

				SCENE = var_2_10003

				var_31_1(var_31_0, var_31_2, var_2_10003.NAVALTACTICS)

				return
			end
		})
	else
		local var_29_9 = var_29_3

		i18n = var_8

		local var_29_10 = var_29_9 .. var_8("tactics_continue_to_learn_other_skill")

		pg = var_8

		local var_29_11 = var_8.MsgboxMgr.GetInstance()

		var_8.ShowMsgBox(var_29_11, {
			modal = true,
			hideClose = true,
			content = var_29_10,
			onYes = function()
				local var_32_0 = arg_29_0
				local var_32_1 = var_0.sendNotification

				GAME = var_2_10002

				local var_32_2 = var_2_10002.GO_SCENE

				SCENE = var_2_10003

				var_32_1(var_32_0, var_32_2, var_2_10003.NAVALTACTICS, {
					shipToLesson = {
						shipId = arg_29_2.shipId,
						index = arg_29_2.id
					}
				})

				return
			end
		})
	end

	return
end

return var_0_1
