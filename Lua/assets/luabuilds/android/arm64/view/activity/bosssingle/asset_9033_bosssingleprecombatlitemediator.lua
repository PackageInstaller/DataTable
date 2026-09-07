local BossSinglePreCombatLiteMediator = class("BossSinglePreCombatLiteMediator", import(".BossSinglePreCombatMediator"))

BossSinglePreCombatLiteMediator.ON_START = "PreCombatMediator:ON_START"
BossSinglePreCombatLiteMediator.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
BossSinglePreCombatLiteMediator.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
BossSinglePreCombatLiteMediator.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
BossSinglePreCombatLiteMediator.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
BossSinglePreCombatLiteMediator.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
BossSinglePreCombatLiteMediator.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
BossSinglePreCombatLiteMediator.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
BossSinglePreCombatLiteMediator.ON_AUTO = "BossSinglePreCombatMediator:ON_AUTO"
BossSinglePreCombatLiteMediator.ON_SUB_AUTO = "BossSinglePreCombatMediator:ON_SUB_AUTO"

function BossSinglePreCombatLiteMediator:register()
	self:bindEvent()

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	self.fleets = self.contextData.fleets

	self.viewComponent:SetFleets(self.contextData.fleets)
	self.viewComponent:SetPlayerInfo((getProxy(PlayerProxy):getData()))
	self.viewComponent:SetCurrentFleet(self.contextData.fleets[1].id)

	for iter_1_0, iter_1_1 in ipairs(self.contextData.fleets) do
		if iter_1_1:isSubmarineFleet() and iter_1_1:isLegalToFight() == true then
			self.viewComponent:SetSubFlag(true)

			break
		end
	end

	return
end

function BossSinglePreCombatLiteMediator:bindEvent()
	local function var_2_1()
		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs(self.contextData.fleets) do
			local var_3_1 = iter_3_1:GetCostSum().oil

			if self.contextData.costLimit[iter_3_0 == 1 and 1 or 2] > 0 then
				var_3_1 = math.min(var_3_1, self.contextData.costLimit[iter_3_0 == 1 and 1 or 2])
			end

			var_3_0 = var_3_0 + var_3_1
		end

		return var_3_0
	end

	self:bind(BossSinglePreCombatLiteMediator.ON_ABORT_EDIT, function(arg_4_0)
		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.ON_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoBtn(arg_5_1)

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		self:onAutoSubBtn(arg_6_1)

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		self:refreshEdit(arg_7_1)

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.OPEN_SHIP_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		self.contextData.form = PreCombatLayer.FORM_EDIT

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2:getShipIds()) do
			table.insert(var_8_0, self.ships[iter_8_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_8_1,
			shipVOs = var_8_0
		})

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		self:commitEdit(arg_9_1)

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.ON_START, function(arg_10_0, arg_10_1, arg_10_2)
		self.viewComponent:emit(BossSinglePreCombatLiteMediator.BEGIN_STAGE_PROXY, {
			curFleetId = arg_10_1,
			continuousBattleTimes = arg_10_2
		})

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_11_0, arg_11_1)
		self:addSubLayers(Context.New({
			mediator = BossSingleContinuousOperationWindowMediator,
			viewComponent = BossSingleContinuousOperationWindow,
			data = {
				mainFleetId = arg_11_1,
				stageId = self.contextData.stageId,
				system = self.contextData.system,
				oilCost = var_2_1()
			}
		}))

		return
	end)
	self:bind(BossSinglePreCombatLiteMediator.BEGIN_STAGE_PROXY, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.BEGIN_STAGE, {
			stageId = self.contextData.stageId,
			mainFleetId = arg_12_1.curFleetId,
			system = self.contextData.system,
			actId = self.contextData.actId,
			variableBuffList = self.contextData.buffList,
			continuousBattleTimes = arg_12_1.continuousBattleTimes,
			totalBattleTimes = arg_12_1.continuousBattleTimes,
			useVariableTicket = self.contextData.useTicket and 1 or 0
		})

		return
	end)

	return
end

function BossSinglePreCombatLiteMediator:refreshEdit(arg_13_1)
	local var_13_0 = getProxy(FleetProxy)

	var_13_0:updateActivityFleet(self.contextData.actId, arg_13_1.id, arg_13_1)
	self.viewComponent:SetFleets(var_13_0:getActivityFleets()[self.contextData.actId])
	self.viewComponent:UpdateFleetView(false)

	return
end

function BossSinglePreCombatLiteMediator:commitEdit(arg_14_1)
	getProxy(FleetProxy):commitActivityFleet(self.contextData.actId)
	arg_14_1()

	return
end

function BossSinglePreCombatLiteMediator:onAutoBtn(arg_15_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_15_1.isOn,
		toggle = arg_15_1.toggle
	})

	return
end

function BossSinglePreCombatLiteMediator:onAutoSubBtn(arg_16_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_16_1.isOn,
		toggle = arg_16_1.toggle
	})

	return
end

function BossSinglePreCombatLiteMediator:removeShipFromFleet(arg_17_1, arg_17_2)
	arg_17_1:removeShip(arg_17_2)

	return true
end

function BossSinglePreCombatLiteMediator:listNotificationInterests()
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		BossSinglePreCombatLiteMediator.CONTINUOUS_OPERATION
	}
end

function BossSinglePreCombatLiteMediator:handleNotification(arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_19_1)
	elseif var_19_0 == GAME.BEGIN_STAGE_ERRO then
		if var_19_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:closeView()

					return
				end
			})
		end
	elseif var_19_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		self.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_19_1)
	elseif var_19_0 == BossSinglePreCombatLiteMediator.CONTINUOUS_OPERATION then
		self.viewComponent:emit(PreCombatMediator.ON_START, var_19_1.mainFleetId, var_19_1.battleTimes)
	end

	return
end

return BossSinglePreCombatLiteMediator
