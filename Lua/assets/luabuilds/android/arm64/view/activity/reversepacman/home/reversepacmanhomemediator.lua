local ReversePacmanHomeMediator = class("ReversePacmanHomeMediator", import("view.backYard.CourtYardMediator"))

ReversePacmanHomeMediator.SET_UP = "ReversePacmanHomeMediator::SET_UP"
ReversePacmanHomeMediator.GO_GAME_SCENE = "ReversePacmanHomeMediator::GO_GAME_SCENE"

function ReversePacmanHomeMediator:register()
	self:bind(ReversePacmanHomeMediator.SET_UP, function(arg_2_0, arg_2_1)
		_courtyard = CourtYardBridge.New((self:GenCourtYardData(arg_2_1)))

		return
	end)
	self:bind(ReversePacmanHomeMediator.GO_GAME_SCENE, function(arg_3_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.REVERSE_PACMAN_SELECT)

		return
	end)

	return
end

function ReversePacmanHomeMediator:listNotificationInterests()
	return {
		CourtYardEvent._QUIT,
		CourtYardEvent._INITED,
		GAME.REVERSE_PACMAN_HIRE_ROLE_DONE,
		GAME.REVERSE_PACMAN_REFRESH_TIP
	}
end

function ReversePacmanHomeMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()
	local var_5_2 = arg_5_1:getType()

	if var_5_0 == CourtYardEvent._QUIT then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_5_0 == CourtYardEvent._INITED then
		self.viewComponent:OnCourtYardLoaded()
	elseif var_5_0 == GAME.REVERSE_PACMAN_HIRE_ROLE_DONE then
		local var_5_3 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[var_5_1].skin_id].ship_group).id

		_courtyard:GetController():AddShip(ReversePacmanDormShip.New({
			id = var_5_3,
			configId = var_5_3,
			skin_id = pg.activity_chasing_character[var_5_1].skin_id,
			roleID = var_5_1
		}), 0, 0)
		self.viewComponent:RefreshBtns()
		self.viewComponent:RefreshTips()
	elseif var_5_0 == GAME.REVERSE_PACMAN_REFRESH_TIP then
		self.viewComponent:RefreshTips()
	end

	return
end

function ReversePacmanHomeMediator:remove()
	if _courtyard then
		_courtyard:Dispose()

		_courtyard = nil
	end

	return
end

return ReversePacmanHomeMediator
