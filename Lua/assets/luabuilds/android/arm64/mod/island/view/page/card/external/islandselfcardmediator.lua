local var_0_0 = class("IslandSelfCardMediator", import("view.base.ContextMediator"))

var_0_0.SET_CARD_NAME = "IslandSelfCardMediator.SET_CARD_NAME"
var_0_0.SET_CARD_PHOTO = "IslandSelfCardMediator.SET_CARD_PHOTO"
var_0_0.SET_CARD_WORD = "IslandSelfCardMediator.SET_CARD_WORD"
var_0_0.SET_CARD_ACHVS = "IslandSelfCardMediator.SET_CARD_ACHVS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SET_CARD_NAME, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ISLAND_SET_NAME, {
			currency = 1,
			name = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_CARD_WORD, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ISLAND_SET_CARD_WORD, {
			word = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_CARD_PHOTO, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.ISLAND_SET_CARD_PHOTO, {
			type = IslandCard.PHOTO_TYPE_ID,
			photo = tostring(arg_4_1)
		})

		return
	end)
	arg_1_0:bind(var_0_0.SET_CARD_ACHVS, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.ISLAND_SET_CARD_ACHVS, {
			achvIds = arg_5_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GAME.ISLAND_SET_NAME_DONE,
		GAME.ISLAND_SET_CARD_WORD_DONE,
		GAME.ISLAND_SET_CARD_PHOTO_DONE,
		GAME.ISLAND_SET_CARD_ACHVS_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.ISLAND_SET_NAME_DONE then
		arg_7_0.viewComponent:OnSetNameDone(var_7_1.name)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_WORD_DONE then
		arg_7_0.viewComponent:OnSetWordDone(var_7_1.word)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_PHOTO_DONE then
		arg_7_0.viewComponent:OnSetPhotoDone(var_7_1.photo)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_ACHVS_DONE then
		arg_7_0.viewComponent:OnSetAchvsDone(var_7_1.achvIds)
	end

	return
end

return var_0_0
