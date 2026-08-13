class = var_0_10000

local var_0_0 = "CourtYardMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SET_UP = "CourtYardMediator:SET_UP"
var_0_1.RENAME = "CourtYardMediator:RENAME"
var_0_1.FOLD = "CourtYardMediator:FOLD"
var_0_1.SWITCH = "CourtYardMediator:SWITCH"
var_0_1.GO_SHOP = "CourtYardMediator:GO_SHOP"
var_0_1.OPEN_DECORATION = "CourtYardMediator:OPEN_DECORATION"
var_0_1.SEL_TRAIN_SHIP = "CourtYardMediator:SEL_TRAIN_SHIP"
var_0_1.SEL_REST_SHIP = "CourtYardMediator:SEL_REST_SHIP"
var_0_1.GO_GRANARY = "CourtYardMediator:GO_GRANARY"
var_0_1.OPEN_ADD_EXP = "CourtYardMediator:OPEN_ADD_EXP"
var_0_1.CLOSE_ADD_EXP = "CourtYardMediator:CLOSE_ADD_EXP"
var_0_1.UN_LOCK_2FLOOR = "CourtYardMediator:UN_LOCK_2FLOOR"
var_0_1.GO_THEME_TEMPLATE = "CourtYardMediator:GO_THEME_TEMPLATE"
var_0_1.ON_ADD_VISITOR_SHIP = "CourtYardMediator:ON_ADD_VISITOR_SHIP"
var_0_1.ONE_KEY = "CourtYardMediator:ONE_KEY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ONE_KEY, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.BACKYARD_ONE_KEY)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ADD_VISITOR_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.BACKYARD_GET_VISITOR_SHIP, {
			callback = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_THEME_TEMPLATE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_4_1(var_4_0, var_4_2, var_2_10005.BACKYARD_THEME_TEMPLATE)

		return
	end)
	arg_1_0:bind(var_0_1.UN_LOCK_2FLOOR, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_GRANARY, function()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_6_2 = var_2_10003.New
		local var_6_3 = {}

		BackyardFeedMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		BackyardFeedLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.SEL_TRAIN_SHIP, function(arg_7_0)
		_courtyard = var_2_10001

		local var_7_0 = var_2_10001:GetController()
		local var_7_1 = var_1.GetMaxCntForShip(var_7_0)
		local var_7_2 = arg_1_0
		local var_7_3 = var_2.addSubLayers

		Context = var_2_10005

		local var_7_4 = var_2_10005.New
		local var_7_5 = {}

		NewBackYardShipInfoMediator = var_2_10008
		var_7_5.mediator = var_2_10008
		NewBackYardShipInfoLayer = var_2_10008
		var_7_5.viewComponent = var_2_10008

		local var_7_6 = {}

		DormShip = var_2_10009
		var_7_6.type = var_2_10009.FLOOR_1
		var_7_6.MaxRsetPos = var_7_1
		var_7_5.data = var_7_6

		var_7_3(var_7_2, var_7_4(var_7_5))

		return
	end)
	arg_1_0:bind(var_0_1.SEL_REST_SHIP, function(arg_8_0)
		_courtyard = var_2_10001

		local var_8_0 = var_2_10001:GetController()
		local var_8_1 = var_1.GetMaxCntForShip(var_8_0)
		local var_8_2 = arg_1_0
		local var_8_3 = var_2.addSubLayers

		Context = var_2_10005

		local var_8_4 = var_2_10005.New
		local var_8_5 = {}

		NewBackYardShipInfoMediator = var_2_10008
		var_8_5.mediator = var_2_10008
		NewBackYardShipInfoLayer = var_2_10008
		var_8_5.viewComponent = var_2_10008

		local var_8_6 = {}

		DormShip = var_2_10009
		var_8_6.type = var_2_10009.FLOOR_2
		var_8_6.MaxRsetPos = var_8_1
		var_8_5.data = var_8_6

		var_8_3(var_8_2, var_8_4(var_8_5))

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOP, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 and {
			onDeattch = function()
				local var_10_0 = arg_1_0.viewComponent

				var_0.emit(var_10_0, var_0_1.OPEN_DECORATION)

				return
			end
		}
		local var_9_1 = arg_1_0
		local var_9_2 = var_3.addSubLayers

		Context = var_2_10006

		local var_9_3 = var_2_10006.New
		local var_9_4 = {}

		NewBackYardShopMediator = var_2_10009
		var_9_4.mediator = var_2_10009
		NewBackYardShopLayer = var_2_10009
		var_9_4.viewComponent = var_2_10009
		var_9_4.data = var_9_0

		var_9_2(var_9_1, var_9_3(var_9_4))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DECORATION, function(arg_11_0)
		_courtyard = var_2_10001

		local var_11_0 = var_2_10001:GetController()

		var_1.EnterEditMode(var_11_0)

		return
	end)
	arg_1_0:bind(var_0_1.SWITCH, function(arg_12_0, arg_12_1)
		getProxy = var_2_10002
		DormProxy = var_2_10004

		if var_2_10002(var_2_10004).floor == arg_12_1 then
			return
		end

		_courtyard = var_2

		var_2:Dispose()

		local var_12_0

		gcAll = _courtyard

		var_2()

		local var_12_1 = arg_1_0.viewComponent

		var_2.emit(var_12_1, var_0_1.SET_UP, arg_12_1)

		local var_12_2 = arg_1_0.viewComponent

		var_2.SwitchFloorDone(var_12_2)

		return
	end)
	arg_1_0:bind(var_0_1.FOLD, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0.viewComponent

		var_2.FoldPanel(var_13_0, arg_13_1)

		return
	end)
	arg_1_0:bind(var_0_1.RENAME, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10005

		var_14_1(var_14_0, var_2_10005.BACKYARD_RENAME, arg_14_1)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.SET_UP, function(arg_15_0, arg_15_1)
		getProxy = var_2_10002
		DormProxy = var_2_10004
		var_2_10002(var_2_10004).floor = arg_15_1

		local var_15_0 = arg_1_0.contextData

		var_15_0.floor = arg_15_1
		CourtYardBridge = var_15_0

		local var_15_1 = var_15_0.New
		local var_15_2 = arg_1_0
		local var_15_3 = var_15_1(var_4.GenCourtYardData(var_15_2, arg_15_1))
		local var_15_4 = _courtyard

		return
	end)

	local var_1_2

	if not arg_1_0.contextData.dorm then
		getProxy = var_1_2
		DormProxy = var_1_0

		local var_1_1 = var_1_2(var_1_0)

		var_1_2 = var_1_2.getRawData(var_1_1)
	end

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetDorm(var_1_3, var_1_2)

	return
end

function var_0_1.listNotificationInterests(arg_16_0)
	local var_16_0 = {}

	DormProxy = var_1_10002
	var_16_0[1] = var_1_10002.DORM_UPDATEED
	DormProxy = var_2
	var_16_0[2] = var_2.INIMACY_AND_MONEY_ADD
	DormProxy = var_2
	var_16_0[3] = var_2.SHIPS_EXP_ADDED
	GAME = var_2
	var_16_0[4] = var_2.EXTEND_BACKYARD_AREA_DONE
	GAME = var_2
	var_16_0[5] = var_2.BACKYARD_ADD_MONEY_DONE
	GAME = var_2
	var_16_0[6] = var_2.BACKYARD_ADD_INTIMACY_DONE
	GAME = var_2
	var_16_0[7] = var_2.BACKYARD_ONE_KEY_DONE
	GAME = var_2
	var_16_0[8] = var_2.BACKYARD_SHIP_EXP_ADDED
	GAME = var_2
	var_16_0[9] = var_2.OPEN_BACKYARD_SHOP
	GAME = var_2
	var_16_0[10] = var_2.EXIT_SHIP_DONE
	GAME = var_2
	var_16_0[11] = var_2.ADD_SHIP_DONE
	GAME = var_2
	var_16_0[12] = var_2.LOAD_LAYERS
	GAME = var_2
	var_16_0[13] = var_2.REMOVE_LAYERS
	GAME = var_2
	var_16_0[14] = var_2.ON_APPLICATION_PAUSE
	GAME = var_2
	var_16_0[15] = var_2.BUY_FURNITURE_DONE
	GAME = var_2
	var_16_0[16] = var_2.ON_RECONNECTION
	CourtYardEvent = var_2
	var_16_0[17] = var_2._EXTEND
	CourtYardEvent = var_2
	var_16_0[18] = var_2._QUIT
	CourtYardEvent = var_2
	var_16_0[19] = var_2._ENTER_MODE
	CourtYardEvent = var_2
	var_16_0[20] = var_2._EXIT_MODE
	CourtYardEvent = var_2
	var_16_0[21] = var_2._INITED
	CourtYardEvent = var_2
	var_16_0[22] = var_2._NO_POS_TO_ADD_SHIP
	CourtYardEvent = var_2
	var_16_0[23] = var_2._DRAG_ITEM
	CourtYardEvent = var_2
	var_16_0[24] = var_2._DRAG_ITEM_END
	CourtYardEvent = var_2
	var_16_0[25] = var_2._TOUCH_SHIP
	CourtYardEvent = var_2
	var_16_0[26] = var_2._ADD_ITEM_FAILED
	BackYardDecorationMediator = var_2
	var_16_0[27] = var_2.START_TAKE_THEME_PHOTO
	BackYardDecorationMediator = var_2
	var_16_0[28] = var_2.END_TAKE_THEME_PHOTO

	return var_16_0
end

function var_0_1.handleNotification(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1
	local var_17_2 = arg_17_1.getBody(var_17_1)
	local var_17_3 = arg_17_1:getType()

	DormProxy = var_17_1

	if var_17_0 == var_17_1.SHIPS_EXP_ADDED then
		if arg_17_0.contextData.OpenShop then
			return
		end

		if var_17_2.isTipSettle then
			pg = var_5
			var_1_10007 = var_5.NewGuideMgr.GetInstance()

			if not var_5.IsBusy(var_1_10007) then
				var_1_10007 = arg_17_0

				arg_17_0.SettleExp(var_1_10007, var_17_2)

				goto label_17_0
			end
		end

		if not arg_17_0.isTipFood then
			var_1_10007 = arg_17_0.viewComponent

			var_5.ShowAddFoodTip(var_1_10007)
		end

		::label_17_0::

		arg_17_0.isTipFood = true
	else
		GAME = var_5

		if var_17_0 == var_5.LOAD_LAYERS then
			-- block empty
		else
			GAME = var_5

			if var_17_0 == var_5.REMOVE_LAYERS then
				var_1_10007 = arg_17_0.viewComponent

				var_5.OnRemoveLayer(var_1_10007, var_17_2)
			else
				CourtYardEvent = var_5

				local var_17_4

				if var_17_0 == var_5._NO_POS_TO_ADD_SHIP then
					var_1_10007 = arg_17_0
					var_17_4 = arg_17_0.sendNotification
					GAME = var_1_10008

					var_17_4(var_1_10007, var_1_10008.EXIT_SHIP, {
						shipId = var_17_2
					})

					pg = var_17_4
					var_1_10007 = var_17_4.TipsMgr.GetInstance()
					var_17_4 = var_17_4.ShowTips
					i18n = var_8

					var_17_4(var_1_10007, var_8("backyard_notPosition_shipExit"))

					var_1_10007 = arg_17_0.viewComponent
					var_17_4 = var_17_4.UpdateDorm
					getProxy = var_8
					DormProxy = var_10

					local var_17_5 = var_8(var_10)
					local var_17_6 = var_8.getRawData(var_17_5)

					BackYardConst = var_1_10009

					var_17_4(var_1_10007, var_17_6, var_1_10009.DORM_UPDATE_TYPE_SHIP)
				else
					CourtYardEvent = var_17_4

					if var_17_0 == var_17_4._ADD_ITEM_FAILED then
						getProxy = var_5
						DormProxy = var_1_10007

						local var_17_7 = var_5(var_1_10007)
						local var_17_8 = var_5.getRawData(var_17_7)
						local var_17_9 = var_5.GetTheme

						getProxy = var_1_10009
						DormProxy = var_1_10011

						local var_17_10 = var_17_9(var_17_8, var_1_10009(var_1_10011).floor)

						var_6.DeleteFurniture(var_17_10, var_17_2)
					end
				end
			end
		end
	end

	arg_17_0:handleCourtyardNotification(var_17_0, var_17_2, var_17_3)

	return
end

function var_0_1.handleCourtyardNotification(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	_courtyard = var_1_10004

	if var_1_10004 then
		_courtyard = var_1_10004
		var_1_10006 = var_1_10004

		if not var_1_10004.IsLoaed(var_1_10006) then
			return
		end

		CourtYardEvent = var_1_10004

		local var_18_0

		if arg_18_1 == var_1_10004._QUIT then
			var_1_10006 = arg_18_0.viewComponent
			var_18_0 = var_18_0.emit
			BaseUI = iter_18_0

			var_18_0(var_1_10006, iter_18_0.ON_BACK)
		else
			CourtYardEvent = var_18_0

			if arg_18_1 == var_18_0._INITED then
				var_1_10006 = arg_18_0.viewComponent

				var_4.OnCourtYardLoaded(var_1_10006)
			else
				GAME = var_4

				local var_18_1

				if arg_18_1 == var_4.LOAD_LAYERS then
					var_18_1 = arg_18_2.context.mediator
					NewBackYardShipInfoMediator = var_1_10005
					var_18_1 = var_18_1 == var_1_10005
					_courtyard = var_1_10005
					iter_18_0 = var_1_10005
					iter_18_0 = var_1_10005.GetController(iter_18_0)

					var_1_10005.OnOpenLayerOrCloseLayer(iter_18_0, true, var_18_1)
				else
					GAME = var_18_1

					local var_18_2

					if arg_18_1 == var_18_1.REMOVE_LAYERS then
						var_18_2 = arg_18_2.context.mediator
						NewBackYardShipInfoMediator = var_1_10005
						var_18_2 = var_18_2 == var_1_10005
						_courtyard = var_1_10005
						iter_18_0 = var_1_10005
						iter_18_0 = var_1_10005.GetController(iter_18_0)

						var_1_10005.OnOpenLayerOrCloseLayer(iter_18_0, false, var_18_2)
					else
						GAME = var_18_2

						if arg_18_1 == var_18_2.ON_APPLICATION_PAUSE and arg_18_2 then
							_courtyard = var_4
							var_1_10006 = var_4
							var_1_10006 = var_4.GetController(var_1_10006)

							var_4.OnApplicationPaused(var_1_10006)
						end
					end
				end
			end
		end

		local var_18_3 = arg_18_0.contextData.mode

		CourtYardConst = var_1_10005

		if var_18_3 == var_1_10005.SYSTEM_VISIT then
			return
		end

		GAME = var_18_3

		if arg_18_1 == var_18_3.BACKYARD_ADD_MONEY_DONE then
			_courtyard = var_4
			var_1_10006 = var_4
			var_1_10006 = var_4.GetController(var_1_10006)

			var_4.ClearShipCoin(var_1_10006, arg_18_2.id)
		else
			GAME = var_4

			if arg_18_1 == var_4.EXIT_SHIP_DONE then
				_courtyard = var_4
				var_1_10006 = var_4
				var_1_10006 = var_4.GetController(var_1_10006)

				var_4.ExitShip(var_1_10006, arg_18_2.id)
			else
				GAME = var_4

				if arg_18_1 == var_4.BUY_FURNITURE_DONE then
					var_1_10006 = arg_18_0.viewComponent

					var_4.OnAddFurniture(var_1_10006)
				else
					GAME = var_4

					if arg_18_1 == var_4.ON_RECONNECTION then
						var_1_10006 = arg_18_0.viewComponent

						var_4.OnReconnection(var_1_10006)
					else
						GAME = var_4

						local var_18_4

						if arg_18_1 == var_4.ADD_SHIP_DONE then
							getProxy = var_18_4
							BayProxy = var_1_10006
							var_1_10006 = var_18_4(var_1_10006)
							var_18_4 = var_18_4.getShipById(var_1_10006, arg_18_2.id)
							getProxy = var_5
							DormProxy = iter_18_0

							if var_5(iter_18_0).floor == arg_18_2.type then
								_courtyard = var_5
								iter_18_0 = var_5
								iter_18_0 = var_5.GetController(iter_18_0)

								var_5.AddShip(iter_18_0, var_18_4, 0, 0)
							end
						else
							GAME = var_18_4

							if arg_18_1 == var_18_4.BACKYARD_ADD_INTIMACY_DONE then
								_courtyard = var_4
								var_1_10006 = var_4
								var_1_10006 = var_4.GetController(var_1_10006)

								var_4.ClearShipIntimacy(var_1_10006, arg_18_2.id)
							else
								GAME = var_4

								if arg_18_1 == var_4.BACKYARD_ONE_KEY_DONE then
									ipairs = var_4

									for iter_18_0, iter_18_1 in var_4(arg_18_2.shipIds) do
										_courtyard = var_1_10009

										local var_18_5 = var_1_10009:GetController()

										var_1_10009.ClearShipCoin(var_18_5, iter_18_1.id)

										_courtyard = var_1_10009

										local var_18_6 = var_1_10009:GetController()

										var_1_10009.ClearShipIntimacy(var_18_6, iter_18_1.id)
									end
								else
									GAME = var_4

									if arg_18_1 == var_4.EXTEND_BACKYARD_AREA_DONE then
										_courtyard = var_4
										var_1_10006 = var_4
										var_1_10006 = var_4.GetController(var_1_10006)

										var_4.LevelUp(var_1_10006)
									else
										DormProxy = var_4

										local var_18_7

										if arg_18_1 == var_4.INIMACY_AND_MONEY_ADD then
											var_18_7 = arg_18_2.id

											local var_18_8 = arg_18_2.money

											var_1_10006 = arg_18_2.intimacy
											_courtyard = iter_18_0
											var_1_10009 = iter_18_0
											var_1_10009 = iter_18_0.GetController(var_1_10009)

											iter_18_0.UpdateShipCoinAndIntimacy(var_1_10009, var_18_7, var_18_8, var_1_10006)
										else
											GAME = var_18_7

											if arg_18_1 == var_18_7.BACKYARD_SHIP_EXP_ADDED then
												_courtyard = var_4
												var_1_10006 = var_4
												var_1_10006 = var_4.GetController(var_1_10006)

												var_4.AddShipExp(var_1_10006, arg_18_2.id, arg_18_2.exp)
											else
												DormProxy = var_4

												local var_18_9

												if arg_18_1 == var_4.DORM_UPDATEED then
													var_1_10006 = arg_18_0.viewComponent
													var_18_9 = var_18_9.UpdateDorm
													getProxy = iter_18_0
													DormProxy = var_1_10009
													var_1_10009 = iter_18_0(var_1_10009)

													var_18_9(var_1_10006, iter_18_0.getRawData(var_1_10009), arg_18_3)
												else
													CourtYardEvent = var_18_9

													local var_18_10

													if arg_18_1 == var_18_9._ENTER_MODE then
														var_1_10006 = arg_18_0
														var_18_10 = arg_18_0.addSubLayers
														Context = iter_18_0
														iter_18_0 = iter_18_0.New
														var_1_10009 = {}
														BackYardDecorationMediator = var_1_10010
														var_1_10009.mediator = var_1_10010
														BackYardDecrationLayer = var_1_10010
														var_1_10009.viewComponent = var_1_10010

														var_18_10(var_1_10006, iter_18_0(var_1_10009))

														var_1_10006 = arg_18_0.viewComponent

														var_18_10.OnEnterOrExitEdit(var_1_10006, true)
													else
														CourtYardEvent = var_18_10

														if arg_18_1 == var_18_10._EXIT_MODE then
															var_1_10006 = arg_18_0.viewComponent

															var_4.OnEnterOrExitEdit(var_1_10006, false)
														else
															GAME = var_4

															if arg_18_1 == var_4.OPEN_BACKYARD_SHOP then
																var_1_10006 = arg_18_0.viewComponent

																var_4.emit(var_1_10006, var_0_1.GO_SHOP, true)
															else
																CourtYardEvent = var_4

																if arg_18_1 == var_4._EXTEND then
																	var_1_10006 = arg_18_0

																	arg_18_0.OnExtend(var_1_10006)
																else
																	BackYardDecorationMediator = var_4

																	local var_18_11

																	if arg_18_1 == var_4.START_TAKE_THEME_PHOTO then
																		GetOrAddComponent = var_18_11
																		var_1_10006 = arg_18_0.viewComponent.mainTF
																		typeof = iter_18_0
																		CanvasGroup = var_1_10009
																		var_18_11 = var_18_11(var_1_10006, iter_18_0(var_1_10009))
																		var_18_11.alpha = 0
																		_courtyard = var_18_11
																		var_1_10006 = var_18_11
																		var_1_10006 = var_18_11.GetController(var_1_10006)

																		var_18_11.OnTakeThemePhoto(var_1_10006)
																	else
																		BackYardDecorationMediator = var_18_11

																		local var_18_12

																		if arg_18_1 == var_18_11.END_TAKE_THEME_PHOTO then
																			GetOrAddComponent = var_18_12
																			var_1_10006 = arg_18_0.viewComponent.mainTF
																			typeof = iter_18_0
																			CanvasGroup = var_1_10009
																			var_18_12 = var_18_12(var_1_10006, iter_18_0(var_1_10009))
																			var_18_12.alpha = 1
																			_courtyard = var_18_12
																			var_1_10006 = var_18_12
																			var_1_10006 = var_18_12.GetController(var_1_10006)

																			var_18_12.OnEndTakeThemePhoto(var_1_10006)
																		else
																			CourtYardEvent = var_18_12

																			if arg_18_1 == var_18_12._DRAG_ITEM then
																				var_1_10006 = arg_18_0.viewComponent

																				var_4.BlockEvents(var_1_10006)
																			else
																				CourtYardEvent = var_4

																				if arg_18_1 == var_4._DRAG_ITEM_END then
																					var_1_10006 = arg_18_0.viewComponent

																					var_4.UnBlockEvents(var_1_10006)
																				else
																					CourtYardEvent = var_4

																					if arg_18_1 == var_4._TOUCH_SHIP then
																						getProxy = var_4
																						TaskProxy = var_1_10006

																						local var_18_13 = var_4(var_1_10006)

																						if var_4.GetBackYardInterActionTaskList(var_18_13) and #var_4 > 0 then
																							ipairs = var_5

																							for iter_18_2, iter_18_3 in var_5(var_4) do
																								pg = var_1_10010

																								local var_18_14 = var_1_10010.m02

																								var_1_10010 = var_1_10010.sendNotification
																								GAME = var_1_10013

																								var_1_10010(var_18_14, var_1_10013.UPDATE_TASK_PROGRESS, {
																									taskId = iter_18_3.id
																								})
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
			end
		end

		return
	end
end

function var_0_1.SettleExp(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.contextData.mode

	CourtYardConst = var_1_10003

	if var_19_0 == var_1_10003.SYSTEM_VISIT then
		return
	end

	getProxy = var_19_0
	DormProxy = var_1_10004

	local var_19_1 = var_19_0(var_1_10004)
	local var_19_2 = var_2.getRawData(var_19_1)

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_19_3 = var_1_10004(var_1_10006)
	local var_19_4 = var_19_2
	local var_19_5 = var_19_2.GetFloorShipCnt

	DormShip = var_1_10008

	local var_19_6 = var_19_5(var_19_4, var_1_10008.FLOOR_1)
	local var_19_7 = arg_19_1.exp * var_19_6

	if var_19_6 ~= 0 and (var_19_7 ~= 0 or var_19_2.food ~= 0) then
		onNextTick = var_19_4

		var_19_4(function()
			local var_20_0 = arg_19_0
			local var_20_1 = var_0.addSubLayers

			Context = var_2_10003

			local var_20_2 = var_2_10003.New
			local var_20_3 = {}

			BackYardSettlementMediator = var_2_10006
			var_20_3.mediator = var_2_10006
			BackYardSettlementLayer = var_2_10006
			var_20_3.viewComponent = var_2_10006
			var_20_3.data = {
				oldShips = arg_19_1.oldShips,
				newShips = arg_19_1.newShips,
				exp = arg_19_1.exp,
				food = arg_19_1.food,
				time = arg_19_1.time
			}

			var_20_1(var_20_0, var_20_2(var_20_3))

			return
		end)

		arg_19_0.contextData.settleShipExp = true
	end

	return
end

function var_0_1.OnExtend(arg_21_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = var_1.getItemCountById

	ITEM_BACKYARD_AREA_EXTEND = var_1_10004

	if var_21_1(var_21_0, var_1_10004) <= 0 then
		getProxy = var_2
		DormProxy = var_1_10004

		local var_21_2 = var_2(var_1_10004)
		local var_21_3 = var_2.getRawData(var_21_2)
		local var_21_4 = var_2.GetExpandId(var_21_3)

		pg = var_21_0

		local var_21_5 = var_21_0.shop_template[var_21_4]

		Drop = var_21_3

		local var_21_6 = var_21_3.New
		local var_21_7 = {}

		DROP_TYPE_RESOURCE = var_1_10007
		var_21_7.type = var_1_10007
		var_21_7.id = var_21_5.resource_type

		local var_21_8 = var_21_6(var_21_7)
		local var_21_9 = var_4.getName(var_21_8)

		_BackyardMsgBoxMgr = var_1_10005
		var_1_10007 = var_1_10005
		var_1_10005 = var_1_10005.Show

		local var_21_10 = {}

		i18n = var_1_10009
		var_21_10.content = var_1_10009("backyard_buyExtendItem_question", var_21_5.resource_num .. var_21_9)

		function var_21_10.onYes()
			local var_22_0 = arg_21_0
			local var_22_1 = var_0.sendNotification

			GAME = var_2_10003

			var_22_1(var_22_0, var_2_10003.SHOPPING, {
				count = 1,
				id = var_21_4
			})

			return
		end

		var_1_10005(var_1_10007, var_21_10)
	else
		local var_21_11 = arg_21_0
		local var_21_12 = arg_21_0.sendNotification

		GAME = var_1_10005

		local var_21_13 = var_1_10005.USE_ITEM
		local var_21_14 = {
			count = 1
		}

		ITEM_BACKYARD_AREA_EXTEND = var_1_10007
		var_21_14.id = var_1_10007

		var_21_12(var_21_11, var_21_13, var_21_14)
	end

	return
end

function var_0_1.remove(arg_23_0)
	_courtyard = var_1_10001

	if var_1_10001 then
		_courtyard = var_1_10001

		var_1_10001:Dispose()

		local var_23_0
		local var_23_1 = _courtyard
	end

	return
end

function var_0_1.GenCourtYardData(arg_24_0, arg_24_1)
	local var_24_0

	if not arg_24_0.contextData.mode then
		CourtYardConst = var_24_0
		var_24_0 = var_24_0.SYSTEM_DEFAULT
	end

	local var_24_1
	local var_24_2

	CourtYardConst = var_1_10005

	if var_24_0 == var_1_10005.SYSTEM_VISIT then
		var_24_1 = arg_24_0.contextData.dorm
		CourtYardConst = var_5
		var_24_2 = var_5.STYLE_INNER
	else
		CourtYardConst = var_5

		if var_24_0 == var_5.SYSTEM_DEFAULT then
			getProxy = var_5
			DormProxy = var_1_10007
			var_1_10007 = var_5(var_1_10007)
			var_24_1 = var_5.getRawData(var_1_10007)
			CourtYardConst = var_5
			var_24_2 = var_5.STYLE_INNER
		else
			CourtYardConst = var_5

			if var_24_0 == var_5.SYSTEM_FEAST then
				getProxy = var_5
				FeastProxy = var_1_10007
				var_1_10007 = var_5(var_1_10007)
				var_24_1 = var_5.getRawData(var_1_10007)
				CourtYardConst = var_5
				var_24_2 = var_5.STYLE_FEAST
			else
				CourtYardConst = var_5

				if var_24_0 == var_5.SYSTEM_OUTSIDE then
					assert = var_5

					var_5(false)

					CourtYardConst = var_5
					var_24_2 = var_5.STYLE_OUTSIDE
				else
					CourtYardConst = var_5

					if var_24_0 == var_5.SYSTEM_EDIT_FEAST then
						getProxy = var_5
						DormProxy = var_1_10007

						local var_24_3 = var_5(var_1_10007)

						var_24_1 = var_5.getRawData(var_24_3)
						CourtYardConst = var_5
						var_24_2 = var_5.STYLE_FEAST
					end
				end
			end
		end
	end

	local var_24_4 = var_24_1:GetMapSize()

	CourtYardConst = var_1_10006

	if var_24_0 == var_1_10006.SYSTEM_EDIT_FEAST then
		getProxy = var_6
		FeastProxy = var_1_10008

		local var_24_5 = var_6(var_1_10008)
		local var_24_6 = var_6.getRawData(var_24_5)

		var_24_4 = var_6.GetMapSize(var_24_6)
	end

	local var_24_7 = {
		[arg_24_1] = {
			id = arg_24_1,
			level = var_24_1.level,
			furnitures = var_24_1:GetPutFurnitureList(arg_24_1),
			ships = var_24_1:GetBayShipOnFloor(arg_24_1),
			popList = var_24_1:GetShipsMoneyAndIntimacy()
		}
	}
	local var_24_8 = {
		system = var_24_0,
		storeys = var_24_7,
		storeyId = arg_24_1,
		style = var_24_2,
		mapSize = var_24_4
	}
	local var_24_9 = arg_24_0.viewComponent

	var_24_8.name = var_8.getUIName(var_24_9)
	pg = var_8
	var_24_8.core = var_8.m02

	return var_24_8
end

return var_0_1
