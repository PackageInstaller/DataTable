class = var_0_10000

local var_0_0 = "CollectionMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.EVENT_OBTAIN_SKIP = "CollectionMediator:EVENT_OBTAIN_SKIP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10002
	arg_1_0.collectionProxy = var_1_10001(var_1_10002)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setShipGroups
	local var_1_2 = arg_1_0.collectionProxy

	var_1_1(var_1_0, var_3.getGroups(var_1_2))

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_1.setAwards
	local var_1_5 = arg_1_0.collectionProxy

	var_1_4(var_1_3, var_3.getAwards(var_1_5))

	local var_1_6 = arg_1_0.viewComponent
	local var_1_7 = var_1.setCollectionRate
	local var_1_8 = arg_1_0.collectionProxy

	var_1_7(var_1_6, var_3.getCollectionRate(var_1_8))

	local var_1_9 = arg_1_0.viewComponent
	local var_1_10 = var_1.setLinkCollectionCount
	local var_1_11 = arg_1_0.collectionProxy

	var_1_10(var_1_9, var_3.getLinkCollectionCount(var_1_11))

	getProxy = var_1_10
	PlayerProxy = var_1_9

	local var_1_12 = var_1_10(var_1_9)
	local var_1_13 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_13, var_1_12:getRawData())

	getProxy = var_2
	BayProxy = var_1_13

	local var_1_14 = var_2(var_1_13)
	local var_1_15 = arg_1_0.viewComponent

	var_3.setProposeList(var_1_15, var_1_14:getProposeGroupList())

	local var_1_16 = arg_1_0
	local var_1_17 = arg_1_0.bind

	CollectionScene = var_5

	var_1_17(var_1_16, var_5.GET_AWARD, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.COLLECT_GET_AWARD, {
			id = arg_2_1,
			index = arg_2_2
		})

		return
	end)

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.bind

	CollectionScene = var_5

	var_1_19(var_1_18, var_5.SHOW_DETAIL, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_3_1(var_3_0, var_3_2, var_2_10006.SHIP_PROFILE, {
			showTrans = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.bind

	CollectionScene = var_5

	var_1_21(var_1_20, var_5.ACTIVITY_OP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.ACTIVITY_OPERATION, arg_4_1)

		return
	end)

	local var_1_22 = arg_1_0
	local var_1_23 = arg_1_0.bind

	CollectionScene = var_5

	var_1_23(var_1_22, var_5.BEGIN_STAGE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.BEGIN_STAGE, arg_5_1)

		return
	end)

	local var_1_24 = arg_1_0
	local var_1_25 = arg_1_0.bind

	CollectionScene = var_5

	var_1_25(var_1_24, var_5.ON_INDEX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		CustomIndexLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		var_6_3.data = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	local var_1_26 = arg_1_0.viewComponent
	local var_1_27 = var_3.updateCollectNotices
	local var_1_28 = arg_1_0.collectionProxy

	var_1_27(var_1_26, var_5.hasFinish(var_1_28))

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	CollectionProxy = var_1_10002
	var_7_0[1] = var_1_10002.AWARDS_UPDATE
	GAME = var_2
	var_7_0[2] = var_2.COLLECT_GET_AWARD_DONE
	PlayerProxy = var_2
	var_7_0[3] = var_2.UPDATED
	GAME = var_2
	var_7_0[4] = var_2.BEGIN_STAGE_DONE
	var_7_0[5] = var_0_1.EVENT_OBTAIN_SKIP

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	CollectionProxy = var_8_1

	if var_8_0 == var_8_1.AWARDS_UPDATE then
		local var_8_3 = arg_8_0.viewComponent

		var_4.setAwards(var_8_3, var_8_2)
	else
		GAME = var_4

		local var_8_6

		if var_8_0 == var_4.COLLECT_GET_AWARD_DONE then
			local var_8_4 = arg_8_0.viewComponent

			var_8_6.sortDisplay(var_8_4)

			local var_8_5 = arg_8_0.viewComponent

			var_8_6 = var_8_6.updateCollectNotices
			var_1_10007 = arg_8_0.collectionProxy

			var_8_6(var_8_5, var_1_10006.hasFinish(var_1_10007))

			local var_8_7 = arg_8_0.viewComponent

			var_8_6 = var_8_6.emit
			BaseUI = var_1_10006

			var_8_6(var_8_7, var_1_10006.ON_ACHIEVE, var_8_2.items)
		else
			PlayerProxy = var_8_6

			if var_8_0 == var_8_6.UPDATED then
				local var_8_8 = arg_8_0.viewComponent

				var_4.setPlayer(var_8_8, var_8_2)
			else
				GAME = var_4

				if var_8_0 == var_4.BEGIN_STAGE_DONE then
					local var_8_9 = arg_8_0
					local var_8_10 = arg_8_0.sendNotification

					GAME = var_1_10006

					local var_8_11 = var_1_10006.GO_SCENE

					SCENE = var_1_10007

					var_8_10(var_8_9, var_8_11, var_1_10007.COMBATLOAD, var_8_2)
				elseif var_8_0 == var_0_1.EVENT_OBTAIN_SKIP then
					local var_8_12 = arg_8_0.viewComponent

					var_4.skipIn(var_8_12, var_8_2.toggle, var_8_2.displayGroupId)
				end
			end
		end
	end

	return
end

return var_0_1
