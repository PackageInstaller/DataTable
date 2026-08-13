class = var_0_10000

local var_0_0 = "TechnologyTreeNationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	TechnologyConst = var_1_10003

	var_1_1(var_1_0, var_1_10003.CLICK_UP_TEC_BTN, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.START_CAMP_TEC, {
			tecID = arg_2_1,
			levelID = arg_2_2
		})

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	TechnologyConst = var_3

	var_1_3(var_1_2, var_3.FINISH_UP_TEC, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.FINISH_CAMP_TEC, {
			tecID = arg_3_1,
			levelID = arg_3_2
		})

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	TechnologyConst = var_3

	var_1_5(var_1_4, var_3.OPEN_ALL_BUFF_DETAIL, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_4_2 = var_2_10002.New
		local var_4_3 = {}

		AllBuffDetailMediator = var_2_10004
		var_4_3.mediator = var_2_10004
		AllBuffDetailLayer = var_2_10004
		var_4_3.viewComponent = var_2_10004
		var_4_3.data = {}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	TechnologyConst = var_1_10002
	var_5_0[1] = var_1_10002.START_TEC_BTN_SUCCESS
	TechnologyConst = var_2
	var_5_0[2] = var_2.FINISH_TEC_SUCCESS
	TechnologyConst = var_2
	var_5_0[3] = var_2.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION
	TechnologyConst = var_2
	var_5_0[4] = var_2.GOT_TEC_CAMP_AWARD
	TechnologyConst = var_2
	var_5_0[5] = var_2.GOT_TEC_CAMP_AWARD_ONESTEP

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	getProxy = var_6_1
	TechnologyNationProxy = var_1_10005

	local var_6_3 = var_6_1(var_1_10005)

	var_4.refreshRedPoint(var_6_3)

	TechnologyConst = var_4

	if var_6_0 == var_4.START_TEC_BTN_SUCCESS then
		local var_6_4 = arg_6_0.viewComponent

		var_4.updateTecListData(var_6_4)

		local var_6_5 = arg_6_0.viewComponent

		var_4.updateTecItem(var_6_5, var_6_2)

		local var_6_6 = arg_6_0.viewComponent

		var_4.updateAllTecItemRp(var_6_6)
	else
		TechnologyConst = var_4

		if var_6_0 == var_4.FINISH_TEC_SUCCESS then
			local var_6_7 = arg_6_0.viewComponent

			var_4.updateTecListData(var_6_7)

			local var_6_8 = arg_6_0.viewComponent

			var_4.updateTecItem(var_6_8, var_6_2)

			local var_6_9 = arg_6_0.viewComponent

			var_4.updateAllTecItemRp(var_6_9)
		else
			TechnologyConst = var_4

			if var_6_0 == var_4.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION then
				local var_6_10 = arg_6_0.viewComponent

				var_4.closeMyself(var_6_10)
			else
				TechnologyConst = var_4

				local var_6_11

				if var_6_0 == var_4.GOT_TEC_CAMP_AWARD then
					var_6_11 = var_6_2.awardList

					local var_6_12 = var_6_2.groupID
					local var_6_13 = var_6_2.tecID
					local var_6_14 = arg_6_0.viewComponent

					var_1_10007.updateTecItem(var_6_14, var_6_12)

					local var_6_15 = arg_6_0.viewComponent

					var_1_10007.updateOneStepBtn(var_6_15)

					local var_6_16 = arg_6_0.viewComponent

					var_1_10007.updateAllTecItemRp(var_6_16)

					local var_6_17 = arg_6_0.viewComponent

					var_1_10007 = var_1_10007.emit
					BaseUI = var_9

					var_1_10007(var_6_17, var_9.ON_ACHIEVE, var_6_11)
				else
					TechnologyConst = var_6_11

					if var_6_0 == var_6_11.GOT_TEC_CAMP_AWARD_ONESTEP then
						local var_6_18 = var_6_2.awardList
						local var_6_19 = arg_6_0.viewComponent

						var_5.updateTecItemList(var_6_19)

						local var_6_20 = arg_6_0.viewComponent

						var_5.updateOneStepBtn(var_6_20)

						local var_6_21 = arg_6_0.viewComponent
						local var_6_22 = var_5.emit

						BaseUI = var_1_10007

						var_6_22(var_6_21, var_1_10007.ON_ACHIEVE, var_6_18)
					end
				end
			end
		end
	end

	return
end

return var_0_1
