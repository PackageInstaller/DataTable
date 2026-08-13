class = var_0_10000

local var_0_0 = "IslandSelfCardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SET_CARD_NAME = "IslandSelfCardMediator.SET_CARD_NAME"
var_0_1.SET_CARD_PHOTO = "IslandSelfCardMediator.SET_CARD_PHOTO"
var_0_1.SET_CARD_WORD = "IslandSelfCardMediator.SET_CARD_WORD"
var_0_1.SET_CARD_ACHVS = "IslandSelfCardMediator.SET_CARD_ACHVS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SET_CARD_NAME, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ISLAND_SET_NAME, {
			currency = 1,
			name = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SET_CARD_WORD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.ISLAND_SET_CARD_WORD, {
			word = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SET_CARD_PHOTO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.ISLAND_SET_CARD_PHOTO
		local var_4_3 = {}

		IslandCard = var_2_10006
		var_4_3.type = var_2_10006.PHOTO_TYPE_ID
		tostring = var_6
		var_4_3.photo = var_6(arg_4_1)

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_CARD_ACHVS, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.ISLAND_SET_CARD_ACHVS, {
			achvIds = arg_5_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.ISLAND_SET_NAME_DONE
	GAME = var_2
	var_6_0[2] = var_2.ISLAND_SET_CARD_WORD_DONE
	GAME = var_2
	var_6_0[3] = var_2.ISLAND_SET_CARD_PHOTO_DONE
	GAME = var_2
	var_6_0[4] = var_2.ISLAND_SET_CARD_ACHVS_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GAME = var_7_1

	if var_7_0 == var_7_1.ISLAND_SET_NAME_DONE then
		local var_7_3 = arg_7_0.viewComponent

		var_4.OnSetNameDone(var_7_3, var_7_2.name)
	else
		GAME = var_4

		if var_7_0 == var_4.ISLAND_SET_CARD_WORD_DONE then
			local var_7_4 = arg_7_0.viewComponent

			var_4.OnSetWordDone(var_7_4, var_7_2.word)
		else
			GAME = var_4

			if var_7_0 == var_4.ISLAND_SET_CARD_PHOTO_DONE then
				local var_7_5 = arg_7_0.viewComponent

				var_4.OnSetPhotoDone(var_7_5, var_7_2.photo)
			else
				GAME = var_4

				if var_7_0 == var_4.ISLAND_SET_CARD_ACHVS_DONE then
					local var_7_6 = arg_7_0.viewComponent

					var_4.OnSetAchvsDone(var_7_6, var_7_2.achvIds)
				end
			end
		end
	end

	return
end

return var_0_1
