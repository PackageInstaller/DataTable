local DOAYearHotSpringMediator = class("DOAYearHotSpringMediator", import("view.base.ContextMediator"))

DOAYearHotSpringMediator.UNLOCK_SLOT = "UNLOCK_SLOT"
DOAYearHotSpringMediator.OPEN_INFO = "OPEN_INFO"
DOAYearHotSpringMediator.OPEN_CHUANWU = "DOAYearHotSpringMediator:Open chuanwu"

function DOAYearHotSpringMediator:register()
	self:bind(DOAYearHotSpringMediator.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0, var_2_1 = self.activity:GetUpgradeCost()

		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_NORMAL,
			content = i18n("hotspring_expand", var_2_1),
			contextSprites = {
				{
					path = "props/wenquanshoupai",
					name = "wenquanshoupai"
				}
			},
			onYes = function()
				if self.activity:GetCoins() < var_2_1 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("hotspring_tip2"))

					return
				end

				self:sendNotification(GAME.ACTIVITY_OPERATION, {
					activity_id = arg_2_1,
					cmd = SpringActivity.OPERATION_UNLOCK
				})

				return
			end
		})

		return
	end)
	self:bind(DOAYearHotSpringMediator.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		self:OnSelShips(arg_4_1, arg_4_2)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	self.activity = var_1_0

	self.viewComponent:SetActivity(var_1_0)
	self:bind(DOAYearHotSpringMediator.OPEN_INFO, function()
		self:addSubLayers(Context.New({
			mediator = DOAYearHotSpringShipSelectMediator,
			viewComponent = DOAYearHotSpringShipSelectLayer,
			data = {
				actId = var_1_0.id
			}
		}))

		return
	end)

	return
end

function DOAYearHotSpringMediator:GetGetSlotCount()
	return self.activity:GetSlotCount()
end

function DOAYearHotSpringMediator:OnSelShips(arg_7_1, arg_7_2)
	local var_7_0 = self:GetSelectedShipIds(arg_7_2)
	local var_7_1 = {
		callbackQuit = true,
		selectedMax = self:GetGetSlotCount(),
		quitTeam = arg_7_2 ~= nil
	}

	var_7_1.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_7_1.selectedIds = Clone(var_7_0)
	var_7_1.preView = self.viewComponent.__cname
	var_7_1.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_7_1.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_7_1.onShip(arg_8_0, arg_8_1, arg_8_2)
		return self:OnShip(arg_8_0, arg_8_1, arg_8_2)
	end

	function var_7_1.onSelected(arg_9_0, arg_9_1)
		self:OnSelected(arg_7_1, arg_9_0, arg_9_1)

		return
	end

	var_7_1.priorEquipUpShipIDList = _.filter(self.activity:GetShipIds(), function(arg_10_0)
		return arg_10_0 > 0
	end)
	var_7_1.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_7_1.isLayer = true
	var_7_1.energyDisplay = true

	self:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_7_1
	}))

	return
end

function DOAYearHotSpringMediator:GetSelectedShipIds(arg_11_1)
	local var_11_0

	if arg_11_1 then
		var_11_0 = arg_11_1.id or -1
	end

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(self.activity:GetShipIds()) do
		local var_11_2 = iter_11_1 > 0 and getProxy(BayProxy):RawGetShipById(iter_11_1)

		if var_11_2 and var_11_2.id ~= var_11_0 then
			table.insert(var_11_1, var_11_2.id)
		end
	end

	return var_11_1
end

function DOAYearHotSpringMediator:OnShip(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1 = ShipStatus.ShipStatusCheck("inBackyard", arg_12_1, function(arg_13_0)
		arg_12_2()

		return
	end)

	return var_12_0, var_12_1
end

function DOAYearHotSpringMediator:OnSelected(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = Clone(self.activity:GetShipIds())

	_.each(_.range(self.activity:GetSlotCount()), function(arg_15_0)
		var_14_0[arg_15_0] = var_14_0[arg_15_0] or 0

		return
	end)

	if arg_14_2 == nil or #arg_14_2 == 0 then
		if var_14_0[arg_14_1] > 0 then
			self:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = self.activity.id,
				cmd = SpringActivity.OPERATION_SETSHIP,
				kvargs1 = {
					{
						value = 0,
						key = arg_14_1
					}
				}
			})
		end

		existCall(arg_14_3)

		return
	end

	local var_14_1 = _.filter(arg_14_2, function(arg_16_0)
		return not table.contains(var_14_0, arg_16_0)
	end)

	table.Foreach(var_14_0, function(arg_17_0, arg_17_1)
		if arg_17_1 == 0 or table.contains(arg_14_2, arg_17_1) then
			return
		end

		var_14_0[arg_17_0] = 0

		return
	end)

	if #var_14_1 == 1 and var_14_0[arg_14_1] == 0 then
		var_14_0[arg_14_1] = var_14_1[1]
	else
		local var_14_2 = 0

		_.each(var_14_1, function(arg_18_0)
			while var_14_2 <= #var_14_0 do
				var_14_2 = var_14_2 + 1

				if var_14_0[var_14_2] == 0 then
					break
				end
			end

			var_14_0[var_14_2] = arg_18_0

			return
		end)
	end

	local var_14_3 = {}
	local var_14_4 = self.activity:GetShipIds()

	table.Foreach(var_14_0, function(arg_19_0, arg_19_1)
		if (var_14_4[arg_19_0] or 0) ~= arg_19_1 then
			table.insert(var_14_3, {
				key = arg_19_0,
				value = arg_19_1
			})
		end

		return
	end)

	if #var_14_3 > 0 then
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = self.activity.id,
			cmd = SpringActivity.OPERATION_SETSHIP,
			kvargs1 = var_14_3
		})
	end

	arg_14_3()

	return
end

function DOAYearHotSpringMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		DOAYearHotSpringMediator.OPEN_CHUANWU,
		DOAYearHotSpringMediator.UNLOCK_SLOT
	}
end

function DOAYearHotSpringMediator:handleNotification(arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == nil then
		-- block empty
	elseif var_21_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1.awards, var_21_1.callback)
	elseif var_21_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_21_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
			self.activity = var_21_1

			self.viewComponent:SetActivity(var_21_1)
			self.viewComponent:UpdateView()
		end
	elseif var_21_0 == DOAYearHotSpringMediator.OPEN_CHUANWU then
		self.viewComponent:emit(DOAYearHotSpringMediator.OPEN_CHUANWU, unpack(var_21_1))
	elseif var_21_0 == DOAYearHotSpringMediator.UNLOCK_SLOT then
		self.viewComponent:emit(DOAYearHotSpringMediator.UNLOCK_SLOT, var_21_1)
	end

	return
end

function DOAYearHotSpringMediator:remove()
	return
end

return DOAYearHotSpringMediator
