class = var_0_10000

local var_0_0 = "NavalAcademyMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_OPEN_CLASSROOM = "NavalAcademyMediator:ON_OPEN_CLASSROOM"
var_0_1.ON_OPEN_COMMANDER = "NavalAcademyMediator:ON_OPEN_COMMANDER"
var_0_1.ON_OPEN_COLLECTION = "NavalAcademyMediator:ON_OPEN_COLLECTION"
var_0_1.ON_OPEN_OILRESFIELD = "NavalAcademyMediator:ON_OPEN_OILRESFIELD"
var_0_1.ON_OPEN_GOLDRESFIELD = "NavalAcademyMediator:ON_OPEN_GOLDRESFIELD"
var_0_1.ON_OPEN_SUPPLYSHOP = "NavalAcademyMediator:ON_OPEN_SUPPLYSHOP"
var_0_1.ON_OPEN_TACTICROOM = "NavalAcademyMediator:ON_OPEN_TACTICROOM"
var_0_1.ON_OPEN_MINIGAMEHALL = "NavalAcademyMediator:ON_OPEN_MINIGAMEHALL"
var_0_1.UPGRADE_FIELD = "NavalAcademyMediator:UPGRADE_FIELD"
var_0_1.GO_SCENE = "NavalAcademyMediator:GO_SCENE"
var_0_1.OPEN_ACTIVITY_PANEL = "NavalAcademyMediator:OPEN_ACTIVITY_PANEL"
var_0_1.OPEN_ACTIVITY_SHOP = "NavalAcademyMediator:OPEN_ACTIVITY_SHOP"
var_0_1.OPEN_SCROLL = "NavalAcademyMediator:OPEN_SCROLL"
var_0_1.ACTIVITY_OP = "NavalAcademyMediator:ACTIVITY_OP"
var_0_1.TASK_GO = "NavalAcademyMediator:TASK_GO"
var_0_1.GO_TASK_SCENE = "NavalAcademyMediator:GO_TASK_SCENE"
var_0_1.ON_GET_CLASS_RES = "NavalAcademyMediator:ON_GET_CLASS_RES"
var_0_1.ON_GET_RES = "NavalAcademyMediator:ON_GET_RES"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_GET_CLASS_RES, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.HARVEST_CLASS_RES)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_RES, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.HARVEST_RES, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_TASK_SCENE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_4_1(var_4_0, var_4_2, var_2_10006.TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.TASK_GO, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ACTIVITY_OP, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.ACTIVITY_OPERATION, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SCROLL, function(arg_7_0, arg_7_1)
		assert = var_2_10002

		var_2_10002(false, "问卷系统已废弃")

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ACTIVITY_SHOP, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_8_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_8_3 = var_2_10005.SHOP
		local var_8_4 = {}

		NewShopsScene = var_2_10007
		var_8_4.warp = var_2_10007.TYPE_ACTIVITY

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ACTIVITY_PANEL, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_9_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_9_1(var_9_0, var_9_2, var_2_10006.ACTIVITY, {
			id = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.GO_SCENE, arg_10_1[1], arg_10_1[2])

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE_FIELD, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10005

		var_11_1(var_11_0, var_2_10005.SHOPPING, {
			count = 1,
			id = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_CLASSROOM, function(arg_12_0)
		local var_12_0 = arg_1_0
		local var_12_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_12_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_12_1(var_12_0, var_12_2, var_2_10005.CLASS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_COMMANDER, function(arg_13_0)
		local var_13_0 = arg_1_0
		local var_13_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_13_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_13_3 = var_2_10005.COMMANDERCAT
		local var_13_4 = {}

		CommanderCatScene = var_2_10007
		var_13_4.fleetType = var_2_10007.FLEET_TYPE_COMMON

		var_13_1(var_13_0, var_13_2, var_13_3, var_13_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_COLLECTION, function(arg_14_0)
		local var_14_0 = arg_1_0
		local var_14_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_14_2 = var_2_10004.New
		local var_14_3 = {}

		TrophyGalleryMediator = var_2_10007
		var_14_3.mediator = var_2_10007
		TrophyGalleryLayer = var_2_10007
		var_14_3.viewComponent = var_2_10007

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_GOLDRESFIELD, function(arg_15_0)
		local var_15_0 = arg_1_0.viewComponent

		var_1.OpenGoldResField(var_15_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_OILRESFIELD, function(arg_16_0)
		local var_16_0 = arg_1_0.viewComponent

		var_1.OpenOilResField(var_16_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_SUPPLYSHOP, function(arg_17_0)
		local var_17_0 = arg_1_0
		local var_17_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_17_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_17_3 = var_2_10005.SHOP
		local var_17_4 = {}

		NewShopsScene = var_2_10007
		var_17_4.warp = var_2_10007.TYPE_SHOP_STREET

		var_17_1(var_17_0, var_17_2, var_17_3, var_17_4)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_TACTICROOM, function(arg_18_0)
		local var_18_0 = arg_1_0
		local var_18_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_18_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_18_1(var_18_0, var_18_2, var_2_10005.NAVALTACTICS, {
			shipToLesson = arg_1_0.contextData.shipToLesson
		})

		arg_1_0.contextData.shipToLesson = nil

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_OPEN_MINIGAMEHALL, function(arg_19_0)
		local var_19_0 = arg_1_0
		local var_19_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_19_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_19_1(var_19_0, var_19_2, var_2_10005.GAME_HALL)

		return
	end)

	getProxy = var_1
	NavalAcademyProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.SetOilResField(var_1_2, var_1_1:GetOilVO())

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetGoldResField(var_1_3, var_1_1:GetGoldVO())

	local var_1_4 = arg_1_0.viewComponent

	var_2.SetClassResField(var_1_4, var_1_1:GetClassVO())

	getProxy = var_2
	PlayerProxy = var_1_4

	local var_1_5 = var_2(var_1_4)
	local var_1_6 = var_2.getData(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_3.SetPlayer(var_1_7, var_1_6)

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	GAME = var_1_10002
	var_20_0[1] = var_1_10002.LOAD_LAYERS
	GAME = var_2
	var_20_0[2] = var_2.REMOVE_LAYERS
	GAME = var_2
	var_20_0[3] = var_2.HARVEST_RES_DONE
	PlayerProxy = var_2
	var_20_0[4] = var_2.UPDATED
	NavalAcademyProxy = var_2
	var_20_0[5] = var_2.RESOURCE_UPGRADE
	NavalAcademyProxy = var_2
	var_20_0[6] = var_2.RESOURCE_UPGRADE_DONE
	CollectionProxy = var_2
	var_20_0[7] = var_2.TROPHY_UPDATE
	GAME = var_2
	var_20_0[8] = var_2.BEGIN_STAGE_DONE
	ActivityProxy = var_2
	var_20_0[9] = var_2.ACTIVITY_OPERATION_DONE
	GAME = var_2
	var_20_0[10] = var_2.HARVEST_CLASS_RES_DONE

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.getName(var_21_0)
	local var_21_2 = arg_21_1
	local var_21_3 = arg_21_1.getBody(var_21_2)

	GAME = var_21_0

	if var_21_1 == var_21_0.LOAD_LAYERS then
		var_1_10006 = arg_21_0.viewComponent

		var_4.OnAddLayer(var_1_10006)
	else
		GAME = var_4

		if var_21_1 == var_4.REMOVE_LAYERS then
			var_1_10006 = arg_21_0.viewComponent

			var_4.OnRemoveLayer(var_1_10006, var_21_3)
		else
			GAME = var_4

			local var_21_4

			if var_21_1 == var_4.HARVEST_RES_DONE then
				var_1_10006 = arg_21_0.viewComponent

				var_21_4.OnGetRes(var_1_10006, var_21_3.type, var_21_3.outPut)

				pg = var_21_4
				var_1_10006 = var_21_4.TipsMgr.GetInstance()
				var_21_4 = var_21_4.ShowTips
				i18n = var_1_10007

				var_21_4(var_1_10006, var_1_10007("battle_levelMediator_ok_takeResource"))
			else
				PlayerProxy = var_21_4

				if var_21_1 == var_21_4.UPDATED then
					var_1_10006 = arg_21_0.viewComponent

					var_4.UpdatePlayer(var_1_10006, var_21_3)
				else
					NavalAcademyProxy = var_4

					local var_21_5

					if var_21_1 == var_4.RESOURCE_UPGRADE then
						var_1_10006 = arg_21_0.viewComponent
						var_21_5 = var_21_5.UpdatePlayer
						getProxy = var_1_10007
						PlayerProxy = var_1_10009
						var_1_10009 = var_1_10007(var_1_10009)

						var_21_5(var_1_10006, var_1_10007.getData(var_1_10009))

						var_1_10006 = arg_21_0.viewComponent

						var_21_5.OnStartUpgradeResField(var_1_10006, var_21_3.resVO)
					else
						NavalAcademyProxy = var_21_5

						local var_21_6

						if var_21_1 == var_21_5.RESOURCE_UPGRADE_DONE then
							var_21_6 = var_21_3.field
							isa = var_21_2
							var_1_10007 = var_21_6
							GoldResourceField = var_1_10008

							local var_21_7

							if var_21_2(var_1_10007, var_1_10008) then
								pg = var_21_7
								var_21_7 = var_21_7.navalacademy_data_template[3].name
								pg = var_1_10006
								var_1_10008 = var_1_10006.TipsMgr.GetInstance()
								var_1_10006 = var_1_10006.ShowTips
								i18n = var_1_10009

								var_1_10006(var_1_10008, var_1_10009("main_navalAcademyScene_upgrade_complete", var_21_7, var_21_3.value))
							else
								isa = var_21_7
								var_1_10007 = var_21_6
								OilResourceField = var_1_10008

								local var_21_8

								if var_21_7(var_1_10007, var_1_10008) then
									pg = var_21_8
									var_21_8 = var_21_8.navalacademy_data_template[4].name
									pg = var_1_10006
									var_1_10008 = var_1_10006.TipsMgr.GetInstance()
									var_1_10006 = var_1_10006.ShowTips
									i18n = var_1_10009

									var_1_10006(var_1_10008, var_1_10009("main_navalAcademyScene_upgrade_complete", var_21_8, var_21_3.value))
								else
									isa = var_21_8
									var_1_10007 = var_21_6
									ClassResourceField = var_1_10008

									if var_21_8(var_1_10007, var_1_10008) then
										pg = var_5

										local var_21_9 = var_5.navalacademy_data_template[1].name

										pg = var_1_10006
										var_1_10008 = var_1_10006.TipsMgr.GetInstance()

										local var_21_10 = var_6.ShowTips

										i18n = var_1_10009

										var_21_10(var_1_10008, var_1_10009("main_navalAcademyScene_class_upgrade_complete", var_21_9, var_21_3.value, var_21_3.rate, var_21_3.exp))
									end
								end
							end

							var_1_10007 = arg_21_0.viewComponent

							var_5.OnResFieldLevelUp(var_1_10007, var_21_6)
						else
							CollectionProxy = var_21_6

							if var_21_1 == var_21_6.TROPHY_UPDATE then
								local var_21_11 = arg_21_0.viewComponent

								var_4.OnCollectionUpdate(var_21_11)
							else
								GAME = var_4

								local var_21_13

								if var_21_1 == var_4.BEGIN_STAGE_DONE then
									local var_21_12 = arg_21_0

									var_21_13 = arg_21_0.sendNotification
									GAME = var_1_10007

									local var_21_14 = var_1_10007.GO_SCENE

									SCENE = var_1_10008

									var_21_13(var_21_12, var_21_14, var_1_10008.COMBATLOAD, var_21_3)
								else
									ActivityProxy = var_21_13

									if var_21_1 == var_21_13.ACTIVITY_OPERATION_DONE then
										local var_21_15 = arg_21_0.viewComponent

										var_4.RefreshChars(var_21_15)
									else
										GAME = var_4

										if var_21_1 == var_4.HARVEST_CLASS_RES_DONE then
											local var_21_16 = arg_21_0.viewComponent

											var_4.OnGetRes(var_21_16, 3, var_21_3.value)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
