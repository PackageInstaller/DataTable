local IslandSelfCardMediator = class("IslandSelfCardMediator", import("view.base.ContextMediator"))

IslandSelfCardMediator.SET_CARD_NAME = "IslandSelfCardMediator.SET_CARD_NAME"
IslandSelfCardMediator.SET_CARD_PHOTO = "IslandSelfCardMediator.SET_CARD_PHOTO"
IslandSelfCardMediator.SET_CARD_WORD = "IslandSelfCardMediator.SET_CARD_WORD"
IslandSelfCardMediator.SET_CARD_ACHVS = "IslandSelfCardMediator.SET_CARD_ACHVS"

function IslandSelfCardMediator:register()
	self:bind(IslandSelfCardMediator.SET_CARD_NAME, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ISLAND_SET_NAME, {
			currency = 1,
			name = arg_2_1
		})

		return
	end)
	self:bind(IslandSelfCardMediator.SET_CARD_WORD, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ISLAND_SET_CARD_WORD, {
			word = arg_3_1
		})

		return
	end)
	self:bind(IslandSelfCardMediator.SET_CARD_PHOTO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ISLAND_SET_CARD_PHOTO, {
			type = IslandCard.PHOTO_TYPE_ID,
			photo = tostring(arg_4_1)
		})

		return
	end)
	self:bind(IslandSelfCardMediator.SET_CARD_ACHVS, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ISLAND_SET_CARD_ACHVS, {
			achvIds = arg_5_1
		})

		return
	end)

	return
end

function IslandSelfCardMediator:listNotificationInterests()
	return {
		GAME.ISLAND_SET_NAME_DONE,
		GAME.ISLAND_SET_CARD_WORD_DONE,
		GAME.ISLAND_SET_CARD_PHOTO_DONE,
		GAME.ISLAND_SET_CARD_ACHVS_DONE
	}
end

function IslandSelfCardMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.ISLAND_SET_NAME_DONE then
		self.viewComponent:OnSetNameDone(var_7_1.name)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_WORD_DONE then
		self.viewComponent:OnSetWordDone(var_7_1.word)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_PHOTO_DONE then
		self.viewComponent:OnSetPhotoDone(var_7_1.photo)
	elseif var_7_0 == GAME.ISLAND_SET_CARD_ACHVS_DONE then
		self.viewComponent:OnSetAchvsDone(var_7_1.achvIds)
	end

	return
end

return IslandSelfCardMediator
