class = var_0_10000

local var_0_0 = "PlayerVitaeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.CHANGE_SKIN = "PlayerVitaeMediator:CHANGE_SKIN"
var_0_1.ON_ATTIRE = "PlayerVitaeMediator:ON_ATTIRE"
var_0_1.CHANGE_MANIFESTO = "PlayerVitaeMediator:CHANGE_MANIFESTO"
var_0_1.ON_CHANGE_PLAYER_NAME = "PlayerVitaeMediator:ON_CHANGE_PLAYER_NAME"
var_0_1.CHANGE_PAINTS = "PlayerVitaeMediator:CHANGE_PAINTS"
var_0_1.CHANGE_PAINT = "PlayerVitaeMediator:CHANGE_PAINT"
var_0_1.CHANGE_RANDOM_SETTING = "PlayerVitaeMediator:CHANGE_RANDOM_SETTING"
var_0_1.GO_SCENE = "PlayerVitaeMediator:GO_SCENE"
var_0_1.ON_SWITCH_RANDOM_FLAG_SHIP_BTN = "PlayerVitaeMediator:ON_SWITCH_RANDOM_FLAG_SHIP_BTN"
var_0_1.OPEN_CRYPTOLALIA = "PlayerVitaeMediator:OPEN_CRYPTOLALIA"
var_0_1.ON_SEL_EDUCATE_CHAR = "PlayerVitaeMediator:ON_SEL_EDUCATE_CHAR"
var_0_1.ON_GET_LOVE_LETTER_MAIL = "PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SEL_EDUCATE_CHAR, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		EducateCharDockMediator = var_2_10007
		var_2_3.mediator = var_2_10007
		EducateCharDockScene = var_2_10007
		var_2_3.viewComponent = var_2_10007
		var_2_3.data = {
			OnSelected = function(arg_3_0)
				local var_3_0 = arg_1_0
				local var_3_1 = var_1.sendNotification

				GAME = var_3_10004

				var_3_1(var_3_0, var_3_10004.CHANGE_EDUCATE, {
					id = arg_3_0
				})

				return
			end
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_LOVE_LETTER_MAIL, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.ACCEPT_LOVE_LETTER_MAIL, {
			activity_id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CRYPTOLALIA, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_5_1(var_5_0, var_5_2, var_2_10006.CRYPTOLALIA, {
			groupId = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.RANDOM_FLAG_SHIP, {
			isOn = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		var_7_1(var_7_0, var_2_10006.GO_SCENE, arg_7_1, arg_7_2)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_RANDOM_SETTING, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.CHANGE_RANDOM_SHIP_AND_SKIN_SETTING, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_9_2 = var_2_10005.New
		local var_9_3 = {}

		SwitchSkinMediator = var_2_10008
		var_9_3.mediator = var_2_10008
		SwitchSkinLayer = var_2_10008
		var_9_3.viewComponent = var_2_10008
		var_9_3.data = {
			shipVO = arg_9_1
		}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_PAINTS, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_1_0
		local var_10_1 = var_3.sendNotification

		GAME = var_2_10006

		var_10_1(var_10_0, var_2_10006.CHANGE_PLAYER_ICON, {
			after = arg_10_1,
			callback = arg_10_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHANGE_PLAYER_NAME, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10005

		var_11_1(var_11_0, var_2_10005.CHANGE_PLAYER_NAME, {
			name = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ATTIRE, function()
		local var_12_0 = arg_1_0
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_12_1(var_12_0, var_12_2, var_2_10004.ATTIRE)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_MANIFESTO, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0
		local var_13_1 = var_2.sendNotification

		GAME = var_2_10005

		var_13_1(var_13_0, var_2_10005.CHANGE_PLAYER_MANIFESTO, {
			manifesto = arg_13_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_PAINT, function(arg_14_0, arg_14_1)
		local var_14_0 = {}

		getProxy = var_2_10003
		PlayerProxy = var_2_10005

		local var_14_1 = var_2_10003(var_2_10005)
		local var_14_2 = var_3.getRawData(var_14_1)
		local var_14_3 = var_3.GetShipPhantomMarks(var_14_2)

		if arg_14_1 then
			table = var_14_1

			var_14_1.removebyvalue(var_14_3, arg_14_1:GetShipPhantomMark())
		end

		local var_14_4 = arg_1_0.contextData

		var_14_4.showSelectCharacters = true
		PlayerVitaeShipsPage = var_14_4

		local var_14_5, var_14_6 = var_14_4.GetSlotMaxCnt()
		local var_14_7 = {
			callbackQuit = true,
			selectedMax = var_14_6
		}

		ShipStatus = var_2_10008
		var_14_7.hideTagFlags = var_2_10008.TAG_HIDE_ADMIRAL
		var_14_7.selectedIds = var_14_0
		var_14_7.selectedMarks = var_14_3
		pg = var_8

		local var_14_8 = var_8.ShipFlagMgr.GetInstance()

		var_14_7.ignoredIds = var_8.FilterShips(var_14_8, {
			isActivityNpc = true
		})

		function var_14_7.onSelected(arg_15_0, arg_15_1)
			local var_15_0 = arg_1_0
			local var_15_1 = var_2.ReSortShipIds
			local var_15_2 = var_0
			local var_15_3 = var_15_1(var_15_0, var_5.GetShipPhantomMarks(var_15_2), arg_15_0)

			arg_1_0.contextData.showSelectCharacters = false

			local var_15_4 = arg_1_0
			local var_15_5 = var_3.sendNotification

			GAME = var_6

			var_15_5(var_15_4, var_6.CHANGE_PLAYER_ICON, {
				after = var_15_3,
				callback = arg_15_1
			})

			return
		end

		local var_14_9 = arg_1_0
		local var_14_10 = var_8.addSubLayers

		Context = var_11

		local var_14_11 = var_11.New
		local var_14_12 = {}

		PlayerVitaeDockyardScene = var_2_10014
		var_14_12.viewComponent = var_2_10014
		DockyardMediator = var_2_10014
		var_14_12.mediator = var_2_10014
		var_14_12.data = var_14_7

		var_14_10(var_14_9, var_14_11(var_14_12))

		return
	end)

	return
end

function var_0_1.ReSortShipIds(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	ipairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004({
		{
			arg_16_1,
			-1
		},
		{
			arg_16_2,
			1
		}
	}) do
		unpack = var_1_10009

		local var_16_1

		var_1_10009, var_16_1 = var_1_10009(iter_16_1)
		ipairs = var_11

		for iter_16_2, iter_16_3 in var_11(var_1_10009) do
			defaultValue = var_1_10016
			var_16_0[iter_16_3] = var_1_10016(var_16_0[iter_16_3], 0) + var_16_1
		end
	end

	local var_16_2 = {}
	local var_16_3 = 1
	local var_16_4 = 1

	while #var_16_2 < #arg_16_2 do
		while var_16_3 <= #arg_16_1 and var_16_0[arg_16_1[var_16_3]] == 0 do
			table = var_7

			var_7.insert(var_16_2, arg_16_1[var_16_3])

			var_16_3 = var_16_3 + 1
		end

		var_16_3 = var_16_3 + 1

		while var_16_4 <= #arg_16_2 and var_16_0[arg_16_2[var_16_4]] == 0 do
			var_16_4 = var_16_4 + 1
		end

		if arg_16_2[var_16_4] then
			table = var_7

			var_7.insert(var_16_2, arg_16_2[var_16_4])

			var_16_4 = var_16_4 + 1
		end
	end

	return var_16_2
end

function var_0_1.listNotificationInterests(arg_17_0)
	local var_17_0 = {}

	GAME = var_1_10002
	var_17_0[1] = var_1_10002.CHANGE_PLAYER_NAME_DONE
	SetShipSkinCommand = var_2
	var_17_0[2] = var_2.SKIN_UPDATED
	GAME = var_2
	var_17_0[3] = var_2.UPDATE_SKINCONFIG
	GAME = var_2
	var_17_0[4] = var_2.CHANGE_PLAYER_ICON_DONE
	PaintingGroupConst = var_2
	var_17_0[5] = var_2.NotifyPaintingDownloadFinish
	GAME = var_2
	var_17_0[6] = var_2.CHANGE_EDUCATE_DONE
	GAME = var_2
	var_17_0[7] = var_2.CLEAR_EDUCATE_TIP
	GAME = var_2
	var_17_0[8] = var_2.CHANGE_SKIN_UPDATE
	GAME = var_2
	var_17_0[9] = var_2.ACCEPT_LOVE_LETTER_MAIL_DONE

	return var_17_0
end

function var_0_1.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1
	local var_18_1 = arg_18_1.getName(var_18_0)
	local var_18_2 = arg_18_1:getBody()

	GAME = var_18_0

	if var_18_1 == var_18_0.CHANGE_PLAYER_NAME_DONE then
		local var_18_3 = arg_18_0.viewComponent

		var_4.OnPlayerNameChange(var_18_3)
	else
		SetShipSkinCommand = var_4

		local var_18_5

		if var_18_1 == var_4.SKIN_UPDATED then
			local var_18_4 = arg_18_0.viewComponent

			var_18_5 = var_18_5.OnShipSkinChanged

			local var_18_6 = var_18_2.ship

			var_18_5(var_18_4, var_7.GetShipPhantomMark(var_18_6))
		else
			GAME = var_18_5

			if var_18_1 == var_18_5.UPDATE_SKINCONFIG then
				local var_18_7 = arg_18_0.viewComponent

				var_4.ReloadPanting(var_18_7, var_18_2.skinId)
			else
				GAME = var_4

				if var_18_1 == var_4.CHANGE_PLAYER_ICON_DONE then
					local var_18_8 = arg_18_0.viewComponent

					var_4.RefreshShips(var_18_8)
				else
					PaintingGroupConst = var_4

					if var_18_1 == var_4.NotifyPaintingDownloadFinish then
						local var_18_9 = arg_18_0.viewComponent

						var_4.updateSwitchSkinBtnTag(var_18_9)

						if arg_18_0.viewComponent.shipsPage then
							local var_18_10 = arg_18_0.viewComponent.shipsPage

							if var_4.GetLoaded(var_18_10) then
								local var_18_11 = arg_18_0.viewComponent.shipsPage

								var_4.UpdateCardPaintingTag(var_18_11)
							end
						end
					else
						GAME = var_4

						if var_18_1 == var_4.CHANGE_EDUCATE_DONE then
							local var_18_12 = arg_18_0.viewComponent

							var_4.UpdatePainting(var_18_12, true)

							if arg_18_0.viewComponent.shipsPage then
								local var_18_13 = arg_18_0.viewComponent.shipsPage

								if var_4.GetLoaded(var_18_13) then
									local var_18_14 = arg_18_0.viewComponent.shipsPage

									var_4.UpdateEducateChar(var_18_14)
								end
							end
						else
							GAME = var_4

							if var_18_1 == var_4.CLEAR_EDUCATE_TIP then
								if arg_18_0.viewComponent.shipsPage then
									local var_18_15 = arg_18_0.viewComponent.shipsPage

									if var_4.GetLoaded(var_18_15) then
										local var_18_16 = arg_18_0.viewComponent.shipsPage

										var_4.UpdateEducateCharTrTip(var_18_16)
									end
								end
							else
								GAME = var_4

								if var_18_1 == var_4.CHANGE_SKIN_UPDATE then
									local var_18_17 = arg_18_0.viewComponent

									var_4.OnShipSkinChanged(var_18_17, var_18_2)

									local var_18_18 = arg_18_0.viewComponent

									var_4.RefreshShips(var_18_18)

									local var_18_19 = arg_18_0.viewComponent

									var_4.UpdatePainting(var_18_19, true)
								else
									GAME = var_4

									if var_18_1 == var_4.ACCEPT_LOVE_LETTER_MAIL_DONE and arg_18_0.viewComponent.shipsPage then
										local var_18_20 = arg_18_0.viewComponent.shipsPage

										if var_4.GetLoaded(var_18_20) then
											local var_18_21 = arg_18_0.viewComponent.shipsPage

											var_4.UpdateGetMailBtn(var_18_21)
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
