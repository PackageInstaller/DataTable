local var_0_0 = class("PlayerVitaeMediator", import("..base.ContextMediator"))

var_0_0.CHANGE_SKIN = "PlayerVitaeMediator:CHANGE_SKIN"
var_0_0.ON_ATTIRE = "PlayerVitaeMediator:ON_ATTIRE"
var_0_0.CHANGE_MANIFESTO = "PlayerVitaeMediator:CHANGE_MANIFESTO"
var_0_0.ON_CHANGE_PLAYER_NAME = "PlayerVitaeMediator:ON_CHANGE_PLAYER_NAME"
var_0_0.CHANGE_PAINTS = "PlayerVitaeMediator:CHANGE_PAINTS"
var_0_0.CHANGE_PAINT = "PlayerVitaeMediator:CHANGE_PAINT"
var_0_0.CHANGE_RANDOM_SETTING = "PlayerVitaeMediator:CHANGE_RANDOM_SETTING"
var_0_0.GO_SCENE = "PlayerVitaeMediator:GO_SCENE"
var_0_0.ON_SWITCH_RANDOM_FLAG_SHIP_BTN = "PlayerVitaeMediator:ON_SWITCH_RANDOM_FLAG_SHIP_BTN"
var_0_0.OPEN_CRYPTOLALIA = "PlayerVitaeMediator:OPEN_CRYPTOLALIA"
var_0_0.ON_SEL_EDUCATE_CHAR = "PlayerVitaeMediator:ON_SEL_EDUCATE_CHAR"
var_0_0.ON_GET_LOVE_LETTER_MAIL = "PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SEL_EDUCATE_CHAR, function(arg_2_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = EducateCharDockMediator,
			viewComponent = EducateCharDockScene,
			data = {
				OnSelected = function(arg_3_0)
					arg_1_0:sendNotification(GAME.CHANGE_EDUCATE, {
						id = arg_3_0
					})

					return
				end
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_LOVE_LETTER_MAIL, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.ACCEPT_LOVE_LETTER_MAIL, {
			activity_id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CRYPTOLALIA, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CRYPTOLALIA, {
			groupId = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.RANDOM_FLAG_SHIP, {
			isOn = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_7_1, arg_7_2)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_RANDOM_SETTING, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.CHANGE_RANDOM_SHIP_AND_SKIN_SETTING, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_SKIN, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = SwitchSkinMediator,
			viewComponent = SwitchSkinLayer,
			data = {
				shipVO = arg_9_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_PAINTS, function(arg_10_0, arg_10_1, arg_10_2)
		arg_1_0:sendNotification(GAME.CHANGE_PLAYER_ICON, {
			after = arg_10_1,
			callback = arg_10_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHANGE_PLAYER_NAME, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.CHANGE_PLAYER_NAME, {
			name = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ATTIRE, function()
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ATTIRE)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_MANIFESTO, function(arg_13_0, arg_13_1)
		arg_1_0:sendNotification(GAME.CHANGE_PLAYER_MANIFESTO, {
			manifesto = arg_13_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_PAINT, function(arg_14_0, arg_14_1)
		local var_14_0 = getProxy(PlayerProxy):getRawData()
		local var_14_1 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()

		if arg_14_1 then
			table.removebyvalue(var_14_1, arg_14_1:GetShipPhantomMark())
		end

		arg_1_0.contextData.showSelectCharacters = true

		local var_14_2, var_14_3 = PlayerVitaeShipsPage.GetSlotMaxCnt()

		;({
			callbackQuit = true,
			selectedMax = var_14_3,
			hideTagFlags = ShipStatus.TAG_HIDE_ADMIRAL,
			selectedIds = {},
			selectedMarks = var_14_1
		}).ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})
		;({
			callbackQuit = true,
			selectedMax = var_14_3,
			hideTagFlags = ShipStatus.TAG_HIDE_ADMIRAL,
			selectedIds = {},
			selectedMarks = var_14_1
		}).onSelected = function(arg_15_0, arg_15_1)
			arg_1_0.contextData.showSelectCharacters = false

			arg_1_0:sendNotification(GAME.CHANGE_PLAYER_ICON, {
				after = arg_1_0:ReSortShipIds(var_14_0:GetShipPhantomMarks(), arg_15_0),
				callback = arg_15_1
			})

			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = PlayerVitaeDockyardScene,
			mediator = DockyardMediator,
			data = {
				callbackQuit = true,
				selectedMax = var_14_3,
				hideTagFlags = ShipStatus.TAG_HIDE_ADMIRAL,
				selectedIds = {},
				selectedMarks = var_14_1
			}
		}))

		return
	end)

	return
end

function var_0_0.ReSortShipIds(arg_16_0, arg_16_1, arg_16_2)
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
		local var_16_0, var_16_1 = unpack(iter_16_1)

		for iter_16_2, iter_16_3 in ipairs(var_16_0) do
			({})[iter_16_3] = defaultValue(({})[iter_16_3], 0) + var_16_1
		end
	end

	local var_16_2 = 1
	local var_16_3 = 1

	while #{} < #arg_16_2 do
		while var_16_2 <= #arg_16_1 and ({})[arg_16_1[var_16_2]] == 0 do
			table.insert({}, arg_16_1[var_16_2])

			var_16_2 = var_16_2 + 1
		end

		var_16_2 = var_16_2 + 1

		while var_16_3 <= #arg_16_2 and ({})[arg_16_2[var_16_3]] == 0 do
			var_16_3 = var_16_3 + 1
		end

		if arg_16_2[var_16_3] then
			table.insert({}, arg_16_2[var_16_3])

			var_16_3 = var_16_3 + 1
		end
	end

	return {}
end

function var_0_0.listNotificationInterests(arg_17_0)
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

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.CHANGE_PLAYER_NAME_DONE then
		arg_18_0.viewComponent:OnPlayerNameChange()
	elseif var_18_0 == SetShipSkinCommand.SKIN_UPDATED then
		arg_18_0.viewComponent:OnShipSkinChanged(var_18_1.ship:GetShipPhantomMark())
	elseif var_18_0 == GAME.UPDATE_SKINCONFIG then
		arg_18_0.viewComponent:ReloadPanting(var_18_1.skinId)
	elseif var_18_0 == GAME.CHANGE_PLAYER_ICON_DONE then
		arg_18_0.viewComponent:RefreshShips()
	elseif var_18_0 == PaintingGroupConst.NotifyPaintingDownloadFinish then
		arg_18_0.viewComponent:updateSwitchSkinBtnTag()

		if arg_18_0.viewComponent.shipsPage and arg_18_0.viewComponent.shipsPage:GetLoaded() then
			arg_18_0.viewComponent.shipsPage:UpdateCardPaintingTag()
		end
	elseif var_18_0 == GAME.CHANGE_EDUCATE_DONE then
		arg_18_0.viewComponent:UpdatePainting(true)

		if arg_18_0.viewComponent.shipsPage and arg_18_0.viewComponent.shipsPage:GetLoaded() then
			arg_18_0.viewComponent.shipsPage:UpdateEducateChar()
		end
	elseif var_18_0 == GAME.CLEAR_EDUCATE_TIP then
		if arg_18_0.viewComponent.shipsPage and arg_18_0.viewComponent.shipsPage:GetLoaded() then
			arg_18_0.viewComponent.shipsPage:UpdateEducateCharTrTip()
		end
	elseif var_18_0 == GAME.CHANGE_SKIN_UPDATE then
		arg_18_0.viewComponent:OnShipSkinChanged(var_18_1)
		arg_18_0.viewComponent:RefreshShips()
		arg_18_0.viewComponent:UpdatePainting(true)
	elseif var_18_0 == GAME.ACCEPT_LOVE_LETTER_MAIL_DONE and arg_18_0.viewComponent.shipsPage and arg_18_0.viewComponent.shipsPage:GetLoaded() then
		arg_18_0.viewComponent.shipsPage:UpdateGetMailBtn()
	end

	return
end

return var_0_0
