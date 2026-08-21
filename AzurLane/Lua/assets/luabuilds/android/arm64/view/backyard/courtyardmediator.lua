local var_0_0 = class("CourtYardMediator", import("..base.ContextMediator"))

var_0_0.SET_UP = "CourtYardMediator:SET_UP"
var_0_0.RENAME = "CourtYardMediator:RENAME"
var_0_0.FOLD = "CourtYardMediator:FOLD"
var_0_0.SWITCH = "CourtYardMediator:SWITCH"
var_0_0.GO_SHOP = "CourtYardMediator:GO_SHOP"
var_0_0.OPEN_DECORATION = "CourtYardMediator:OPEN_DECORATION"
var_0_0.SEL_TRAIN_SHIP = "CourtYardMediator:SEL_TRAIN_SHIP"
var_0_0.SEL_REST_SHIP = "CourtYardMediator:SEL_REST_SHIP"
var_0_0.GO_GRANARY = "CourtYardMediator:GO_GRANARY"
var_0_0.OPEN_ADD_EXP = "CourtYardMediator:OPEN_ADD_EXP"
var_0_0.CLOSE_ADD_EXP = "CourtYardMediator:CLOSE_ADD_EXP"
var_0_0.UN_LOCK_2FLOOR = "CourtYardMediator:UN_LOCK_2FLOOR"
var_0_0.GO_THEME_TEMPLATE = "CourtYardMediator:GO_THEME_TEMPLATE"
var_0_0.ON_ADD_VISITOR_SHIP = "CourtYardMediator:ON_ADD_VISITOR_SHIP"
var_0_0.ONE_KEY = "CourtYardMediator:ONE_KEY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ONE_KEY, function(arg_2_0)
		arg_1_0:sendNotification(GAME.BACKYARD_ONE_KEY)

		return
	end)
	arg_1_0:bind(var_0_0.ON_ADD_VISITOR_SHIP, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.BACKYARD_GET_VISITOR_SHIP, {
			callback = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_THEME_TEMPLATE, function(arg_4_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BACKYARD_THEME_TEMPLATE)

		return
	end)
	arg_1_0:bind(var_0_0.UN_LOCK_2FLOOR, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_GRANARY, function()
		arg_1_0:addSubLayers(Context.New({
			mediator = BackyardFeedMediator,
			viewComponent = BackyardFeedLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SEL_TRAIN_SHIP, function(arg_7_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = DormShip.FLOOR_1,
				MaxRsetPos = _courtyard:GetController():GetMaxCntForShip()
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SEL_REST_SHIP, function(arg_8_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = DormShip.FLOOR_2,
				MaxRsetPos = _courtyard:GetController():GetMaxCntForShip()
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOP, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewBackYardShopMediator,
			viewComponent = NewBackYardShopLayer,
			data = arg_9_1 and {
				onDeattch = function()
					arg_1_0.viewComponent:emit(var_0_0.OPEN_DECORATION)

					return
				end
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DECORATION, function(arg_11_0)
		_courtyard:GetController():EnterEditMode()

		return
	end)
	arg_1_0:bind(var_0_0.SWITCH, function(arg_12_0, arg_12_1)
		if getProxy(DormProxy).floor == arg_12_1 then
			return
		end

		_courtyard:Dispose()

		_courtyard = nil

		gcAll()
		arg_1_0.viewComponent:emit(var_0_0.SET_UP, arg_12_1)
		arg_1_0.viewComponent:SwitchFloorDone()

		return
	end)
	arg_1_0:bind(var_0_0.FOLD, function(arg_13_0, arg_13_1)
		arg_1_0.viewComponent:FoldPanel(arg_13_1)

		return
	end)
	arg_1_0:bind(var_0_0.RENAME, function(arg_14_0, arg_14_1)
		arg_1_0:sendNotification(GAME.BACKYARD_RENAME, arg_14_1)

		return
	end)
	arg_1_0:bind(var_0_0.SET_UP, function(arg_15_0, arg_15_1)
		getProxy(DormProxy).floor = arg_15_1
		arg_1_0.contextData.floor = arg_15_1
		_courtyard = CourtYardBridge.New(arg_1_0:GenCourtYardData(arg_15_1))

		return
	end)

	local var_1_0 = arg_1_0.contextData.dorm or getProxy(DormProxy):getRawData()

	arg_1_0.viewComponent:SetDorm(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_16_0)
	return {
		DormProxy.DORM_UPDATEED,
		DormProxy.INIMACY_AND_MONEY_ADD,
		DormProxy.SHIPS_EXP_ADDED,
		GAME.EXTEND_BACKYARD_AREA_DONE,
		GAME.BACKYARD_ADD_MONEY_DONE,
		GAME.BACKYARD_ADD_INTIMACY_DONE,
		GAME.BACKYARD_ONE_KEY_DONE,
		GAME.BACKYARD_SHIP_EXP_ADDED,
		GAME.OPEN_BACKYARD_SHOP,
		GAME.EXIT_SHIP_DONE,
		GAME.ADD_SHIP_DONE,
		GAME.LOAD_LAYERS,
		GAME.REMOVE_LAYERS,
		GAME.ON_APPLICATION_PAUSE,
		GAME.BUY_FURNITURE_DONE,
		GAME.ON_RECONNECTION,
		CourtYardEvent._EXTEND,
		CourtYardEvent._QUIT,
		CourtYardEvent._ENTER_MODE,
		CourtYardEvent._EXIT_MODE,
		CourtYardEvent._INITED,
		CourtYardEvent._NO_POS_TO_ADD_SHIP,
		CourtYardEvent._DRAG_ITEM,
		CourtYardEvent._DRAG_ITEM_END,
		CourtYardEvent._TOUCH_SHIP,
		CourtYardEvent._ADD_ITEM_FAILED,
		BackYardDecorationMediator.START_TAKE_THEME_PHOTO,
		BackYardDecorationMediator.END_TAKE_THEME_PHOTO
	}
end

function var_0_0.handleNotification(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1:getBody()
	local var_17_2 = arg_17_1:getType()

	if var_17_0 == DormProxy.SHIPS_EXP_ADDED then
		if arg_17_0.contextData.OpenShop then
			return
		end

		if var_17_1.isTipSettle then
			if not pg.NewGuideMgr.GetInstance():IsBusy() then
				arg_17_0:SettleExp(var_17_1)

				goto label_17_0
			end
		end

		if not arg_17_0.isTipFood then
			arg_17_0.viewComponent:ShowAddFoodTip()
		end

		::label_17_0::

		arg_17_0.isTipFood = true
	elseif var_17_0 == GAME.LOAD_LAYERS then
		-- block empty
	elseif var_17_0 == GAME.REMOVE_LAYERS then
		arg_17_0.viewComponent:OnRemoveLayer(var_17_1)
	elseif var_17_0 == CourtYardEvent._NO_POS_TO_ADD_SHIP then
		arg_17_0:sendNotification(GAME.EXIT_SHIP, {
			shipId = var_17_1
		})
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_notPosition_shipExit"))
		arg_17_0.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), BackYardConst.DORM_UPDATE_TYPE_SHIP)
	elseif var_17_0 == CourtYardEvent._ADD_ITEM_FAILED then
		getProxy(DormProxy):getRawData():GetTheme(getProxy(DormProxy).floor):DeleteFurniture(var_17_1)
	end

	arg_17_0:handleCourtyardNotification(var_17_0, var_17_1, var_17_2)

	return
end

function var_0_0.handleCourtyardNotification(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not _courtyard or not _courtyard:IsLoaed() then
		return
	end

	if arg_18_1 == CourtYardEvent._QUIT then
		arg_18_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif arg_18_1 == CourtYardEvent._INITED then
		arg_18_0.viewComponent:OnCourtYardLoaded()
	elseif arg_18_1 == GAME.LOAD_LAYERS then
		_courtyard:GetController():OnOpenLayerOrCloseLayer(true, arg_18_2.context.mediator == NewBackYardShipInfoMediator)
	elseif arg_18_1 == GAME.REMOVE_LAYERS then
		_courtyard:GetController():OnOpenLayerOrCloseLayer(false, arg_18_2.context.mediator == NewBackYardShipInfoMediator)
	elseif arg_18_1 == GAME.ON_APPLICATION_PAUSE and arg_18_2 then
		_courtyard:GetController():OnApplicationPaused()
	end

	if arg_18_0.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	if arg_18_1 == GAME.BACKYARD_ADD_MONEY_DONE then
		_courtyard:GetController():ClearShipCoin(arg_18_2.id)
	elseif arg_18_1 == GAME.EXIT_SHIP_DONE then
		_courtyard:GetController():ExitShip(arg_18_2.id)
	elseif arg_18_1 == GAME.BUY_FURNITURE_DONE then
		arg_18_0.viewComponent:OnAddFurniture()
	elseif arg_18_1 == GAME.ON_RECONNECTION then
		arg_18_0.viewComponent:OnReconnection()
	elseif arg_18_1 == GAME.ADD_SHIP_DONE then
		if getProxy(DormProxy).floor == arg_18_2.type then
			_courtyard:GetController():AddShip(getProxy(BayProxy):getShipById(arg_18_2.id), 0, 0)
		end
	elseif arg_18_1 == GAME.BACKYARD_ADD_INTIMACY_DONE then
		_courtyard:GetController():ClearShipIntimacy(arg_18_2.id)
	elseif arg_18_1 == GAME.BACKYARD_ONE_KEY_DONE then
		for iter_18_0, iter_18_1 in ipairs(arg_18_2.shipIds) do
			_courtyard:GetController():ClearShipCoin(iter_18_1.id)
			_courtyard:GetController():ClearShipIntimacy(iter_18_1.id)
		end
	elseif arg_18_1 == GAME.EXTEND_BACKYARD_AREA_DONE then
		_courtyard:GetController():LevelUp()
	elseif arg_18_1 == DormProxy.INIMACY_AND_MONEY_ADD then
		_courtyard:GetController():UpdateShipCoinAndIntimacy(arg_18_2.id, arg_18_2.money, arg_18_2.intimacy)
	elseif arg_18_1 == GAME.BACKYARD_SHIP_EXP_ADDED then
		_courtyard:GetController():AddShipExp(arg_18_2.id, arg_18_2.exp)
	elseif arg_18_1 == DormProxy.DORM_UPDATEED then
		arg_18_0.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), arg_18_3)
	elseif arg_18_1 == CourtYardEvent._ENTER_MODE then
		arg_18_0:addSubLayers(Context.New({
			mediator = BackYardDecorationMediator,
			viewComponent = BackYardDecrationLayer
		}))
		arg_18_0.viewComponent:OnEnterOrExitEdit(true)
	elseif arg_18_1 == CourtYardEvent._EXIT_MODE then
		arg_18_0.viewComponent:OnEnterOrExitEdit(false)
	elseif arg_18_1 == GAME.OPEN_BACKYARD_SHOP then
		arg_18_0.viewComponent:emit(var_0_0.GO_SHOP, true)
	elseif arg_18_1 == CourtYardEvent._EXTEND then
		arg_18_0:OnExtend()
	elseif arg_18_1 == BackYardDecorationMediator.START_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_18_0.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 0

		_courtyard:GetController():OnTakeThemePhoto()
	elseif arg_18_1 == BackYardDecorationMediator.END_TAKE_THEME_PHOTO then
		GetOrAddComponent(arg_18_0.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 1

		_courtyard:GetController():OnEndTakeThemePhoto()
	elseif arg_18_1 == CourtYardEvent._DRAG_ITEM then
		arg_18_0.viewComponent:BlockEvents()
	elseif arg_18_1 == CourtYardEvent._DRAG_ITEM_END then
		arg_18_0.viewComponent:UnBlockEvents()
	elseif arg_18_1 == CourtYardEvent._TOUCH_SHIP then
		local var_18_0 = getProxy(TaskProxy):GetBackYardInterActionTaskList()

		if var_18_0 and #var_18_0 > 0 then
			for iter_18_2, iter_18_3 in ipairs(var_18_0) do
				pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
					taskId = iter_18_3.id
				})
			end
		end
	end

	return
end

function var_0_0.SettleExp(arg_19_0, arg_19_1)
	if arg_19_0.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	local var_19_0 = getProxy(DormProxy):getRawData()
	local var_19_1 = getProxy(BayProxy)
	local var_19_2 = var_19_0:GetFloorShipCnt(DormShip.FLOOR_1)

	if var_19_2 ~= 0 and (arg_19_1.exp * var_19_2 ~= 0 or var_19_0.food ~= 0) then
		onNextTick(function()
			arg_19_0:addSubLayers(Context.New({
				mediator = BackYardSettlementMediator,
				viewComponent = BackYardSettlementLayer,
				data = {
					oldShips = arg_19_1.oldShips,
					newShips = arg_19_1.newShips,
					exp = arg_19_1.exp,
					food = arg_19_1.food,
					time = arg_19_1.time
				}
			}))

			return
		end)

		arg_19_0.contextData.settleShipExp = true
	end

	return
end

function var_0_0.OnExtend(arg_21_0)
	local var_21_9000

	if getProxy(BagProxy):getItemCountById(ITEM_BACKYARD_AREA_EXTEND) <= 0 then
		local var_21_0 = getProxy(DormProxy):getRawData()
		local var_21_1 = pg.shop_template[var_21_0.GetExpandId(var_21_9000)]

		_BackyardMsgBoxMgr:Show({
			content = i18n("backyard_buyExtendItem_question", var_21_1.resource_num .. Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_21_1.resource_type
			}).getName(var_21_0)),
			onYes = function()
				arg_21_0:sendNotification(GAME.SHOPPING, {
					count = 1,
					id = var_0
				})

				return
			end
		})
	else
		arg_21_0:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = ITEM_BACKYARD_AREA_EXTEND
		})
	end

	return
end

function var_0_0.remove(arg_23_0)
	if _courtyard then
		_courtyard:Dispose()

		_courtyard = nil
	end

	return
end

function var_0_0.GenCourtYardData(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.contextData.mode or CourtYardConst.SYSTEM_DEFAULT
	local var_24_1
	local var_24_2

	if var_24_0 == CourtYardConst.SYSTEM_VISIT then
		var_24_1 = arg_24_0.contextData.dorm
		var_24_2 = CourtYardConst.STYLE_INNER
	elseif var_24_0 == CourtYardConst.SYSTEM_DEFAULT then
		var_24_1 = getProxy(DormProxy):getRawData()
		var_24_2 = CourtYardConst.STYLE_INNER
	elseif var_24_0 == CourtYardConst.SYSTEM_FEAST then
		var_24_1 = getProxy(FeastProxy):getRawData()
		var_24_2 = CourtYardConst.STYLE_FEAST
	elseif var_24_0 == CourtYardConst.SYSTEM_OUTSIDE then
		assert(false)

		var_24_2 = CourtYardConst.STYLE_OUTSIDE
	elseif var_24_0 == CourtYardConst.SYSTEM_EDIT_FEAST then
		var_24_1 = getProxy(DormProxy):getRawData()
		var_24_2 = CourtYardConst.STYLE_FEAST
	end

	local var_24_3 = var_24_1:GetMapSize()

	if var_24_0 == CourtYardConst.SYSTEM_EDIT_FEAST then
		var_24_3 = getProxy(FeastProxy):getRawData():GetMapSize()
	end

	;({
		system = var_24_0
	}).storeys = {
		[arg_24_1] = {
			id = arg_24_1,
			level = var_24_1.level,
			furnitures = var_24_1:GetPutFurnitureList(arg_24_1),
			ships = var_24_1:GetBayShipOnFloor(arg_24_1),
			popList = var_24_1:GetShipsMoneyAndIntimacy()
		}
	}
	;({
		system = var_24_0
	}).storeyId = arg_24_1
	;({
		system = var_24_0
	}).style = var_24_2
	;({
		system = var_24_0
	}).mapSize = var_24_3
	;({
		system = var_24_0
	}).name = arg_24_0.viewComponent:getUIName()
	;({
		system = var_24_0
	}).core = pg.m02

	return {
		system = var_24_0
	}
end

return var_0_0
