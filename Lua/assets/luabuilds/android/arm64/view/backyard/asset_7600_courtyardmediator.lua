local CourtYardMediator = class("CourtYardMediator", import("..base.ContextMediator"))

CourtYardMediator.SET_UP = "CourtYardMediator:SET_UP"
CourtYardMediator.RENAME = "CourtYardMediator:RENAME"
CourtYardMediator.FOLD = "CourtYardMediator:FOLD"
CourtYardMediator.SWITCH = "CourtYardMediator:SWITCH"
CourtYardMediator.GO_SHOP = "CourtYardMediator:GO_SHOP"
CourtYardMediator.OPEN_DECORATION = "CourtYardMediator:OPEN_DECORATION"
CourtYardMediator.SEL_TRAIN_SHIP = "CourtYardMediator:SEL_TRAIN_SHIP"
CourtYardMediator.SEL_REST_SHIP = "CourtYardMediator:SEL_REST_SHIP"
CourtYardMediator.GO_GRANARY = "CourtYardMediator:GO_GRANARY"
CourtYardMediator.OPEN_ADD_EXP = "CourtYardMediator:OPEN_ADD_EXP"
CourtYardMediator.CLOSE_ADD_EXP = "CourtYardMediator:CLOSE_ADD_EXP"
CourtYardMediator.UN_LOCK_2FLOOR = "CourtYardMediator:UN_LOCK_2FLOOR"
CourtYardMediator.GO_THEME_TEMPLATE = "CourtYardMediator:GO_THEME_TEMPLATE"
CourtYardMediator.ON_ADD_VISITOR_SHIP = "CourtYardMediator:ON_ADD_VISITOR_SHIP"
CourtYardMediator.ONE_KEY = "CourtYardMediator:ONE_KEY"

function CourtYardMediator:register()
	self:bind(CourtYardMediator.ONE_KEY, function(arg_2_0)
		self:sendNotification(GAME.BACKYARD_ONE_KEY)

		return
	end)
	self:bind(CourtYardMediator.ON_ADD_VISITOR_SHIP, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.BACKYARD_GET_VISITOR_SHIP, {
			callback = arg_3_1
		})

		return
	end)
	self:bind(CourtYardMediator.GO_THEME_TEMPLATE, function(arg_4_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BACKYARD_THEME_TEMPLATE)

		return
	end)
	self:bind(CourtYardMediator.UN_LOCK_2FLOOR, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(CourtYardMediator.GO_GRANARY, function()
		self:addSubLayers(Context.New({
			mediator = BackyardFeedMediator,
			viewComponent = BackyardFeedLayer
		}))

		return
	end)
	self:bind(CourtYardMediator.SEL_TRAIN_SHIP, function(arg_7_0)
		self:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = DormShip.FLOOR_1,
				MaxRsetPos = _courtyard:GetController():GetMaxCntForShip()
			}
		}))

		return
	end)
	self:bind(CourtYardMediator.SEL_REST_SHIP, function(arg_8_0)
		self:addSubLayers(Context.New({
			mediator = NewBackYardShipInfoMediator,
			viewComponent = NewBackYardShipInfoLayer,
			data = {
				type = DormShip.FLOOR_2,
				MaxRsetPos = _courtyard:GetController():GetMaxCntForShip()
			}
		}))

		return
	end)
	self:bind(CourtYardMediator.GO_SHOP, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			mediator = NewBackYardShopMediator,
			viewComponent = NewBackYardShopLayer,
			data = arg_9_1 and {
				onDeattch = function()
					self.viewComponent:emit(CourtYardMediator.OPEN_DECORATION)

					return
				end
			}
		}))

		return
	end)
	self:bind(CourtYardMediator.OPEN_DECORATION, function(arg_11_0)
		_courtyard:GetController():EnterEditMode()

		return
	end)
	self:bind(CourtYardMediator.SWITCH, function(arg_12_0, arg_12_1)
		if getProxy(DormProxy).floor == arg_12_1 then
			return
		end

		_courtyard:Dispose()

		_courtyard = nil

		gcAll()
		self.viewComponent:emit(CourtYardMediator.SET_UP, arg_12_1)
		self.viewComponent:SwitchFloorDone()

		return
	end)
	self:bind(CourtYardMediator.FOLD, function(arg_13_0, arg_13_1)
		self.viewComponent:FoldPanel(arg_13_1)

		return
	end)
	self:bind(CourtYardMediator.RENAME, function(arg_14_0, arg_14_1)
		self:sendNotification(GAME.BACKYARD_RENAME, arg_14_1)

		return
	end)
	self:bind(CourtYardMediator.SET_UP, function(arg_15_0, arg_15_1)
		getProxy(DormProxy).floor = arg_15_1
		self.contextData.floor = arg_15_1
		_courtyard = CourtYardBridge.New(self:GenCourtYardData(arg_15_1))

		return
	end)
	self.viewComponent:SetDorm(self.contextData.dorm or getProxy(DormProxy):getRawData())

	return
end

function CourtYardMediator:listNotificationInterests()
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

function CourtYardMediator:handleNotification(arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1:getBody()
	local var_17_2 = arg_17_1:getType()

	if var_17_0 == DormProxy.SHIPS_EXP_ADDED then
		if self.contextData.OpenShop then
			return
		end

		if var_17_1.isTipSettle then
			if not pg.NewGuideMgr.GetInstance():IsBusy() then
				self:SettleExp(var_17_1)

				goto label_17_0
			end
		end

		if not self.isTipFood then
			self.viewComponent:ShowAddFoodTip()
		end

		::label_17_0::

		self.isTipFood = true
	elseif var_17_0 == GAME.LOAD_LAYERS then
		-- block empty
	elseif var_17_0 == GAME.REMOVE_LAYERS then
		self.viewComponent:OnRemoveLayer(var_17_1)
	elseif var_17_0 == CourtYardEvent._NO_POS_TO_ADD_SHIP then
		self:sendNotification(GAME.EXIT_SHIP, {
			shipId = var_17_1
		})
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_notPosition_shipExit"))
		self.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), BackYardConst.DORM_UPDATE_TYPE_SHIP)
	elseif var_17_0 == CourtYardEvent._ADD_ITEM_FAILED then
		getProxy(DormProxy):getRawData():GetTheme(getProxy(DormProxy).floor):DeleteFurniture(var_17_1)
	end

	self:handleCourtyardNotification(var_17_0, var_17_1, var_17_2)

	return
end

function CourtYardMediator:handleCourtyardNotification(arg_18_1, arg_18_2, arg_18_3)
	if not _courtyard or not _courtyard:IsLoaed() then
		return
	end

	if arg_18_1 == CourtYardEvent._QUIT then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif arg_18_1 == CourtYardEvent._INITED then
		self.viewComponent:OnCourtYardLoaded()
	elseif arg_18_1 == GAME.LOAD_LAYERS then
		_courtyard:GetController():OnOpenLayerOrCloseLayer(true, arg_18_2.context.mediator == NewBackYardShipInfoMediator)
	elseif arg_18_1 == GAME.REMOVE_LAYERS then
		_courtyard:GetController():OnOpenLayerOrCloseLayer(false, arg_18_2.context.mediator == NewBackYardShipInfoMediator)
	elseif arg_18_1 == GAME.ON_APPLICATION_PAUSE and arg_18_2 then
		_courtyard:GetController():OnApplicationPaused()
	end

	if self.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	if arg_18_1 == GAME.BACKYARD_ADD_MONEY_DONE then
		_courtyard:GetController():ClearShipCoin(arg_18_2.id)
	elseif arg_18_1 == GAME.EXIT_SHIP_DONE then
		_courtyard:GetController():ExitShip(arg_18_2.id)
	elseif arg_18_1 == GAME.BUY_FURNITURE_DONE then
		self.viewComponent:OnAddFurniture()
	elseif arg_18_1 == GAME.ON_RECONNECTION then
		self.viewComponent:OnReconnection()
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
		self.viewComponent:UpdateDorm(getProxy(DormProxy):getRawData(), arg_18_3)
	elseif arg_18_1 == CourtYardEvent._ENTER_MODE then
		self:addSubLayers(Context.New({
			mediator = BackYardDecorationMediator,
			viewComponent = BackYardDecrationLayer
		}))
		self.viewComponent:OnEnterOrExitEdit(true)
	elseif arg_18_1 == CourtYardEvent._EXIT_MODE then
		self.viewComponent:OnEnterOrExitEdit(false)
	elseif arg_18_1 == GAME.OPEN_BACKYARD_SHOP then
		self.viewComponent:emit(CourtYardMediator.GO_SHOP, true)
	elseif arg_18_1 == CourtYardEvent._EXTEND then
		self:OnExtend()
	elseif arg_18_1 == BackYardDecorationMediator.START_TAKE_THEME_PHOTO then
		GetOrAddComponent(self.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 0

		_courtyard:GetController():OnTakeThemePhoto()
	elseif arg_18_1 == BackYardDecorationMediator.END_TAKE_THEME_PHOTO then
		GetOrAddComponent(self.viewComponent.mainTF, typeof(CanvasGroup)).alpha = 1

		_courtyard:GetController():OnEndTakeThemePhoto()
	elseif arg_18_1 == CourtYardEvent._DRAG_ITEM then
		self.viewComponent:BlockEvents()
	elseif arg_18_1 == CourtYardEvent._DRAG_ITEM_END then
		self.viewComponent:UnBlockEvents()
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

function CourtYardMediator:SettleExp(arg_19_1)
	if self.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	local var_19_0 = getProxy(DormProxy):getRawData()
	local var_19_1 = getProxy(BayProxy)
	local var_19_2 = var_19_0:GetFloorShipCnt(DormShip.FLOOR_1)

	if var_19_2 ~= 0 and (arg_19_1.exp * var_19_2 ~= 0 or var_19_0.food ~= 0) then
		onNextTick(function()
			self:addSubLayers(Context.New({
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

		self.contextData.settleShipExp = true
	end

	return
end

function CourtYardMediator:OnExtend()
	if getProxy(BagProxy):getItemCountById(ITEM_BACKYARD_AREA_EXTEND) <= 0 then
		local var_21_0 = getProxy(DormProxy):getRawData()
		local var_21_1 = var_21_0:GetExpandId()

		_BackyardMsgBoxMgr:Show({
			content = i18n("backyard_buyExtendItem_question", pg.shop_template[var_21_1].resource_num .. Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = pg.shop_template[var_21_1].resource_type
			}).getName(var_21_0)),
			onYes = function()
				self:sendNotification(GAME.SHOPPING, {
					count = 1,
					id = var_21_1
				})

				return
			end
		})
	else
		self:sendNotification(GAME.USE_ITEM, {
			count = 1,
			id = ITEM_BACKYARD_AREA_EXTEND
		})
	end

	return
end

function CourtYardMediator:remove()
	if _courtyard then
		_courtyard:Dispose()

		_courtyard = nil
	end

	return
end

function CourtYardMediator:GenCourtYardData(arg_24_1)
	local var_24_0 = self.contextData.mode or CourtYardConst.SYSTEM_DEFAULT
	local var_24_1
	local var_24_2

	if var_24_0 == CourtYardConst.SYSTEM_VISIT then
		var_24_1 = self.contextData.dorm
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
	local var_24_4

	if var_24_0 == CourtYardConst.SYSTEM_EDIT_FEAST then
		var_24_3 = getProxy(FeastProxy):getRawData():GetMapSize()
		var_24_4 = {
			system = var_24_0
		}
	end

	var_24_4.storeys = {
		[arg_24_1] = {
			id = arg_24_1,
			level = var_24_1.level,
			furnitures = var_24_1:GetPutFurnitureList(arg_24_1),
			ships = var_24_1:GetBayShipOnFloor(arg_24_1),
			popList = var_24_1:GetShipsMoneyAndIntimacy()
		}
	}
	var_24_4.storeyId = arg_24_1
	var_24_4.style = var_24_2
	var_24_4.mapSize = var_24_3
	var_24_4.name = self.viewComponent:getUIName()
	var_24_4.core = pg.m02

	return var_24_4
end

return CourtYardMediator
