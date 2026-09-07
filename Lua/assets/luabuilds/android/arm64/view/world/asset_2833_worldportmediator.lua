local WorldPortMediator = class("WorldPortMediator", import("..base.ContextMediator"))

WorldPortMediator.OnOpenBay = "WorldPortMediator.OnOpenBay"
WorldPortMediator.OnTaskGoto = "WorldPortMediator.OnTaskGoto"
WorldPortMediator.OnAccepetTask = "WorldPortMediator.OnAccepetTask"
WorldPortMediator.OnSubmitTask = "WorldPortMediator.OnSubmitTask"
WorldPortMediator.OnReqPort = "WorldPortMediator.OnReqPort"
WorldPortMediator.OnBuyGoods = "WorldPortMediator.OnBuyGoods"
WorldPortMediator.OnBuyNShopGoods = "WorldPortMediator.OnBuyNShopGoods"

function WorldPortMediator:register()
	self:bind(WorldPortMediator.OnOpenBay, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMax = 1,
			selectedMin = 0,
			mode = DockyardScene.MODE_WORLD,
			hideTagFlags = ShipStatus.TAG_HIDE_WORLD
		})

		return
	end)
	self:bind(WorldPortMediator.OnTaskGoto, function(arg_3_0, arg_3_1)
		self.viewComponent:closeView()
		self:sendNotification(WorldMediator.OnTriggerTaskGo, {
			taskId = arg_3_1
		})

		return
	end)
	self:bind(WorldPortMediator.OnAccepetTask, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.WORLD_TRIGGER_TASK, {
			taskId = arg_4_1.id,
			portId = arg_4_2
		})

		return
	end)
	self:bind(WorldPortMediator.OnSubmitTask, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.WORLD_SUMBMIT_TASK, {
			taskId = arg_5_1.id
		})

		return
	end)
	self:bind(WorldPortMediator.OnReqPort, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.WORLD_PORT_REQ, {
			mapId = arg_6_1
		})

		return
	end)
	self:bind(WorldPortMediator.OnBuyGoods, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.WORLD_PORT_SHOPPING, {
			goods = arg_7_1
		})

		return
	end)
	self:bind(WorldPortMediator.OnBuyNShopGoods, function(arg_8_0, arg_8_1, arg_8_2)
		self:sendNotification(GAME.WORLD_PORT_NEW_SHOPPING, {
			goods = arg_8_1,
			count = arg_8_2
		})

		return
	end)
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

	local var_1_0 = nowWorld()

	self.viewComponent:SetAtlas(var_1_0:GetAtlas())
	self.viewComponent:SetPort(var_1_0:GetActiveMap():GetPort())
	self:CheckTaskNotify(var_1_0:GetTaskProxy())

	return
end

function WorldPortMediator:initNotificationHandleDic()
	self.handleDic = {
		[PlayerProxy.UPDATED] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

			return
		end,
		[GAME.WORLD_PORT_SHOPPING_DONE] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_11_1:getBody().drops)
			arg_11_0.viewComponent:UpdateCDTip()

			return
		end,
		[GAME.WORLD_PORT_NEW_SHOPPING_DONE] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_12_1:getBody().drops)

			return
		end
	}

	return
end

function WorldPortMediator:CheckTaskNotify(arg_13_1)
	for iter_13_0, iter_13_1 in pairs((arg_13_1:getTasks())) do
		if iter_13_1:getState() == WorldTask.STATE_ONGOING and iter_13_1.config.complete_condition == WorldConst.TaskTypeArrivePort then
			local var_13_0 = WBank:Fetch(WorldMapOp)

			var_13_0.op = WorldConst.OpReqTask

			self:sendNotification(GAME.WORLD_MAP_OP, var_13_0)
		end
	end

	return
end

return WorldPortMediator
