local NewBackYardShipInfoMediator = class("NewBackYardShipInfoMediator", import("...base.ContextMediator"))

NewBackYardShipInfoMediator.EXTEND = "NewBackYardShipInfoMediator:EXTEND"
NewBackYardShipInfoMediator.OPEN_CHUANWU = "NewBackYardShipInfoMediator:OPEN_CHUANWU"
NewBackYardShipInfoMediator.UPDATE_SHIPS = "NewBackYardShipInfoMediator:UPDATE_SHIPS"
NewBackYardShipInfoMediator.LOOG_PRESS_SHIP = "NewBackYardShipInfoMediator:LOOG_PRESS_SHIP"

function NewBackYardShipInfoMediator:register()
	self:bind(NewBackYardShipInfoMediator.EXTEND, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_2_1
		})

		return
	end)
	self:bind(NewBackYardShipInfoMediator.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		self.contextData.type = arg_3_1

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	self:bind(NewBackYardShipInfoMediator.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		self.contextData.type = arg_4_1

		self:OnSelShips(arg_4_1, arg_4_2)

		return
	end)

	return
end

function NewBackYardShipInfoMediator:OnSelShips(arg_5_1, arg_5_2)
	local var_5_0 = getProxy(DormProxy):getRawData()
	local var_5_1, var_5_2, var_5_3 = self:GetSelectedShips(var_5_0, arg_5_1, arg_5_2)
	local var_5_4 = {
		callbackQuit = true,
		selectedMax = self:GetMaxSel(var_5_0, arg_5_1),
		quitTeam = arg_5_2 ~= nil
	}

	var_5_4.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_5_4.selectedIds = var_5_3
	var_5_4.preView = self.viewComponent.__cname
	var_5_4.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_5_4.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_5_4.onShip(arg_6_0, arg_6_1, arg_6_2)
		return self:OnShip(var_5_2, arg_6_0, arg_6_1, arg_6_2)
	end

	function var_5_4.onSelected(arg_7_0, arg_7_1)
		self:OnSelected(arg_5_1, arg_5_2, arg_7_0, function()
			self:sendNotification(NewBackYardShipInfoMediator.UPDATE_SHIPS)
			arg_7_1()

			return
		end)

		return
	end

	var_5_4.priorEquipUpShipIDList = {}

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		table.insert(var_5_4.priorEquipUpShipIDList, iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		table.insert(var_5_4.priorEquipUpShipIDList, iter_5_3)
	end

	var_5_4.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_5_4.isLayer = true
	var_5_4.energyDisplay = true

	self:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_5_4
	}))

	return
end

function NewBackYardShipInfoMediator:GetMaxSel(arg_9_1, arg_9_2)
	local var_9_0 = 0

	if arg_9_2 == DormShip.FLOOR_1 then
		var_9_0 = arg_9_1.exp_pos
	elseif arg_9_2 == DormShip.FLOOR_2 then
		var_9_0 = arg_9_1.rest_pos
	end

	return var_9_0
end

function NewBackYardShipInfoMediator:GetSelectedShips(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0

	if arg_10_3 then
		var_10_0 = arg_10_3.id or -1
	end

	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1:GetShips()) do
		local var_10_4 = getProxy(BayProxy):RawGetShipById(iter_10_1.id)

		if iter_10_1:IsSameFloor(arg_10_2) then
			table.insert(var_10_1, var_10_4.id)

			if var_10_4.id ~= var_10_0 then
				table.insert(var_10_3, var_10_4.id)
			end
		else
			table.insert(var_10_2, var_10_4.id)
		end
	end

	return var_10_1, var_10_2, var_10_3
end

function NewBackYardShipInfoMediator:OnShip(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if #arg_11_4 > self.contextData.MaxRsetPos then
		local var_11_1 = i18n("backyard_no_pos_for_ship")

		return
	end

	if table.contains(arg_11_1, arg_11_2.id) then
		local var_11_3 = i18n("backyard_backyardShipInfoMediator_shipState_rest")

		return
	end

	local var_11_4, var_11_5 = ShipStatus.ShipStatusCheck("inBackyard", arg_11_2, function(arg_12_0)
		arg_11_3()

		return
	end)

	return var_11_4, var_11_5
end

function NewBackYardShipInfoMediator:OnSelected(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = getProxy(DormProxy):getRawData():GetDicBayShipOnFloor(arg_13_1)

	pg.UIMgr.GetInstance():LoadingOn()

	if arg_13_3 == nil or #arg_13_3 == 0 then
		if arg_13_2 then
			self:sendNotification(GAME.EXIT_SHIP, {
				shipId = arg_13_2.id,
				callback = arg_13_4
			})
		else
			arg_13_4()
		end

		pg.UIMgr.GetInstance():LoadingOff()

		return
	end

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if not table.contains(arg_13_3, iter_13_0) then
			table.insert(var_13_1, function(arg_14_0)
				self:sendNotification(GAME.EXIT_SHIP, {
					shipId = iter_13_0,
					callback = arg_14_0
				})

				return
			end)
		end
	end

	self.contextData.shipIdToAdd = {}

	for iter_13_2, iter_13_3 in ipairs(arg_13_3) do
		if not var_13_0[iter_13_3] then
			table.insert(self.contextData.shipIdToAdd, {
				iter_13_3,
				arg_13_1
			})
		end
	end

	if self.contextData.shipIdToAdd and #self.contextData.shipIdToAdd > 0 then
		for iter_13_4, iter_13_5 in ipairs(self.contextData.shipIdToAdd) do
			table.insert(var_13_1, function(arg_15_0)
				self:sendNotification(GAME.ADD_SHIP, {
					id = iter_13_5[1],
					type = iter_13_5[2],
					callBack = arg_15_0
				})

				return
			end)
		end
	end

	if #var_13_1 > 0 then
		seriesAsync(var_13_1, function()
			self.contextData.shipIdToAdd = nil

			pg.UIMgr.GetInstance():LoadingOff()
			arg_13_4()

			return
		end)
	else
		pg.UIMgr.GetInstance():LoadingOff()
		arg_13_4()
	end

	return
end

function NewBackYardShipInfoMediator:listNotificationInterests()
	return {
		GAME.EXTEND_BACKYARD_DONE,
		NewBackYardShipInfoMediator.UPDATE_SHIPS
	}
end

function NewBackYardShipInfoMediator:handleNotification(arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.EXTEND_BACKYARD_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoMediator_ok_unlock"))
		self.viewComponent:UpdateSlots()
	elseif var_18_0 == NewBackYardShipInfoMediator.UPDATE_SHIPS then
		self.viewComponent:UpdateSlots()
	end

	return
end

return NewBackYardShipInfoMediator
