local PlayerVitaeMediator = class("PlayerVitaeMediator", import("..base.ContextMediator"))

PlayerVitaeMediator.CHANGE_SKIN = "PlayerVitaeMediator:CHANGE_SKIN"
PlayerVitaeMediator.ON_ATTIRE = "PlayerVitaeMediator:ON_ATTIRE"
PlayerVitaeMediator.CHANGE_MANIFESTO = "PlayerVitaeMediator:CHANGE_MANIFESTO"
PlayerVitaeMediator.ON_CHANGE_PLAYER_NAME = "PlayerVitaeMediator:ON_CHANGE_PLAYER_NAME"
PlayerVitaeMediator.CHANGE_PAINTS = "PlayerVitaeMediator:CHANGE_PAINTS"
PlayerVitaeMediator.CHANGE_PAINT = "PlayerVitaeMediator:CHANGE_PAINT"
PlayerVitaeMediator.CHANGE_RANDOM_SETTING = "PlayerVitaeMediator:CHANGE_RANDOM_SETTING"
PlayerVitaeMediator.GO_SCENE = "PlayerVitaeMediator:GO_SCENE"
PlayerVitaeMediator.ON_SWITCH_RANDOM_FLAG_SHIP_BTN = "PlayerVitaeMediator:ON_SWITCH_RANDOM_FLAG_SHIP_BTN"
PlayerVitaeMediator.OPEN_CRYPTOLALIA = "PlayerVitaeMediator:OPEN_CRYPTOLALIA"
PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR = "PlayerVitaeMediator:ON_SEL_EDUCATE_CHAR"
PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL = "PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL"

function PlayerVitaeMediator:register()
	self:bind(PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR, function(arg_2_0)
		self:addSubLayers(Context.New({
			mediator = EducateCharDockMediator,
			viewComponent = EducateCharDockScene,
			data = {
				OnSelected = function(arg_3_0)
					self:sendNotification(GAME.CHANGE_EDUCATE, {
						id = arg_3_0
					})

					return
				end
			}
		}))

		return
	end)
	self:bind(PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ACCEPT_LOVE_LETTER_MAIL, {
			activity_id = arg_4_1
		})

		return
	end)
	self:bind(PlayerVitaeMediator.OPEN_CRYPTOLALIA, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.CRYPTOLALIA, {
			groupId = arg_5_1
		})

		return
	end)
	self:bind(PlayerVitaeMediator.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.RANDOM_FLAG_SHIP, {
			isOn = arg_6_1
		})

		return
	end)
	self:bind(PlayerVitaeMediator.GO_SCENE, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.GO_SCENE, arg_7_1, arg_7_2)

		return
	end)
	self:bind(PlayerVitaeMediator.CHANGE_RANDOM_SETTING, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.CHANGE_RANDOM_SHIP_AND_SKIN_SETTING, arg_8_1)

		return
	end)
	self:bind(PlayerVitaeMediator.CHANGE_SKIN, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			mediator = SwitchSkinMediator,
			viewComponent = SwitchSkinLayer,
			data = {
				shipVO = arg_9_1
			}
		}))

		return
	end)
	self:bind(PlayerVitaeMediator.CHANGE_PAINTS, function(arg_10_0, arg_10_1, arg_10_2)
		self:sendNotification(GAME.CHANGE_PLAYER_ICON, {
			after = arg_10_1,
			callback = arg_10_2
		})

		return
	end)
	self:bind(PlayerVitaeMediator.ON_CHANGE_PLAYER_NAME, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.CHANGE_PLAYER_NAME, {
			name = arg_11_1
		})

		return
	end)
	self:bind(PlayerVitaeMediator.ON_ATTIRE, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.ATTIRE)

		return
	end)
	self:bind(PlayerVitaeMediator.CHANGE_MANIFESTO, function(arg_13_0, arg_13_1)
		self:sendNotification(GAME.CHANGE_PLAYER_MANIFESTO, {
			manifesto = arg_13_1
		})

		return
	end)
	self:bind(PlayerVitaeMediator.CHANGE_PAINT, function(arg_14_0, arg_14_1)
		local var_14_0 = getProxy(PlayerProxy):getRawData()
		local var_14_1 = var_14_0:GetShipPhantomMarks()

		if arg_14_1 then
			table.removebyvalue(var_14_1, arg_14_1:GetShipPhantomMark())
		end

		self.contextData.showSelectCharacters = true

		local var_14_2, var_14_3 = PlayerVitaeShipsPage.GetSlotMaxCnt()
		local var_14_4 = {
			callbackQuit = true,
			selectedMax = var_14_3,
			hideTagFlags = ShipStatus.TAG_HIDE_ADMIRAL,
			selectedIds = {},
			selectedMarks = var_14_1
		}

		var_14_4.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		function var_14_4.onSelected(arg_15_0, arg_15_1)
			self.contextData.showSelectCharacters = false

			self:sendNotification(GAME.CHANGE_PLAYER_ICON, {
				after = self:ReSortShipIds(var_14_0:GetShipPhantomMarks(), arg_15_0),
				callback = arg_15_1
			})

			return
		end

		self:addSubLayers(Context.New({
			viewComponent = PlayerVitaeDockyardScene,
			mediator = DockyardMediator,
			data = var_14_4
		}))

		return
	end)

	return
end

function PlayerVitaeMediator:ReSortShipIds(arg_16_1, arg_16_2)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs({
		{
			arg_16_1,
			-1
		},
		{
			arg_16_2,
			1
		}
	}) do
		local var_16_1, var_16_2 = unpack(iter_16_1)

		for iter_16_2, iter_16_3 in ipairs(var_16_1) do
			var_16_0[iter_16_3] = defaultValue(var_16_0[iter_16_3], 0) + var_16_2
		end
	end

	local var_16_3 = {}
	local var_16_4 = 1
	local var_16_5 = 1

	while #var_16_3 < #arg_16_2 do
		while var_16_4 <= #arg_16_1 and var_16_0[arg_16_1[var_16_4]] == 0 do
			table.insert(var_16_3, arg_16_1[var_16_4])

			var_16_4 = var_16_4 + 1
		end

		var_16_4 = var_16_4 + 1

		while var_16_5 <= #arg_16_2 and var_16_0[arg_16_2[var_16_5]] == 0 do
			var_16_5 = var_16_5 + 1
		end

		if arg_16_2[var_16_5] then
			table.insert(var_16_3, arg_16_2[var_16_5])

			var_16_5 = var_16_5 + 1
		end
	end

	return var_16_3
end

function PlayerVitaeMediator:listNotificationInterests()
	return {
		GAME.CHANGE_PLAYER_NAME_DONE,
		SetShipSkinCommand.SKIN_UPDATED,
		GAME.UPDATE_SKINCONFIG,
		GAME.CHANGE_PLAYER_ICON_DONE,
		PaintingGroupConst.NotifyPaintingDownloadFinish,
		GAME.CHANGE_EDUCATE_DONE,
		GAME.CLEAR_EDUCATE_TIP,
		GAME.CHANGE_SKIN_UPDATE,
		GAME.ACCEPT_LOVE_LETTER_MAIL_DONE
	}
end

function PlayerVitaeMediator:handleNotification(arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.CHANGE_PLAYER_NAME_DONE then
		self.viewComponent:OnPlayerNameChange()
	elseif var_18_0 == SetShipSkinCommand.SKIN_UPDATED then
		self.viewComponent:OnShipSkinChanged(var_18_1.ship:GetShipPhantomMark())
	elseif var_18_0 == GAME.UPDATE_SKINCONFIG then
		self.viewComponent:ReloadPanting(var_18_1.skinId)
	elseif var_18_0 == GAME.CHANGE_PLAYER_ICON_DONE then
		self.viewComponent:RefreshShips()
	elseif var_18_0 == PaintingGroupConst.NotifyPaintingDownloadFinish then
		self.viewComponent:updateSwitchSkinBtnTag()

		if self.viewComponent.shipsPage and self.viewComponent.shipsPage:GetLoaded() then
			self.viewComponent.shipsPage:UpdateCardPaintingTag()
		end
	elseif var_18_0 == GAME.CHANGE_EDUCATE_DONE then
		self.viewComponent:UpdatePainting(true)

		if self.viewComponent.shipsPage and self.viewComponent.shipsPage:GetLoaded() then
			self.viewComponent.shipsPage:UpdateEducateChar()
		end
	elseif var_18_0 == GAME.CLEAR_EDUCATE_TIP then
		if self.viewComponent.shipsPage and self.viewComponent.shipsPage:GetLoaded() then
			self.viewComponent.shipsPage:UpdateEducateCharTrTip()
		end
	elseif var_18_0 == GAME.CHANGE_SKIN_UPDATE then
		self.viewComponent:OnShipSkinChanged(var_18_1)
		self.viewComponent:RefreshShips()
		self.viewComponent:UpdatePainting(true)
	elseif var_18_0 == GAME.ACCEPT_LOVE_LETTER_MAIL_DONE and self.viewComponent.shipsPage and self.viewComponent.shipsPage:GetLoaded() then
		self.viewComponent.shipsPage:UpdateGetMailBtn()
	end

	return
end

return PlayerVitaeMediator
