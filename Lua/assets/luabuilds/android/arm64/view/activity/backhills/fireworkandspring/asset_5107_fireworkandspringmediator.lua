local FireworkAndSpringMediator = class("FireworkAndSpringMediator", import("view.activity.BackHills.TemplateMV.BackHillMediatorTemplate"))

FireworkAndSpringMediator.EVENT_PT_OPERATION = "FireworkAndSpringMediator:event pt op"
FireworkAndSpringMediator.ON_TASK_GO = "FireworkAndSpringMediator:event on task go"
FireworkAndSpringMediator.ON_TASK_SUBMIT = "FireworkAndSpringMediator:event on task submit"
FireworkAndSpringMediator.ON_TASK_SUBMIT_ONESTEP = "FireworkAndSpringMediator:event on task submit one step"
FireworkAndSpringMediator.ACTIVITY_OPERATION = "FireworkAndSpringMediator:event activity op"
FireworkAndSpringMediator.OPEN_CHUANWU = "FireworkAndSpringMediator:Open chuanwu"

function FireworkAndSpringMediator:register()
	self:bind(FireworkAndSpringMediator.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_2_1)

		return
	end)
	self:bind(FireworkAndSpringMediator.ON_TASK_GO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	self:bind(FireworkAndSpringMediator.ON_TASK_SUBMIT, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SUBMIT_TASK, arg_4_1.id, arg_4_2)

		return
	end)
	self:bind(FireworkAndSpringMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_5_1,
			task_ids = arg_5_2
		})

		return
	end)
	self:bind(FireworkAndSpringMediator.ACTIVITY_OPERATION, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = arg_6_1,
			cmd = PuzzleActivity.CMD_ACTIVATE,
			arg1 = arg_6_2
		})

		return
	end)
	self:bind(FireworkAndSpringMediator.OPEN_CHUANWU, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		self:OnSelShips(arg_7_1, arg_7_2, arg_7_3, arg_7_4)

		return
	end)

	return
end

function FireworkAndSpringMediator:OnSelShips(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = getProxy(ActivityProxy):getActivityById(arg_8_1)
	local var_8_1 = self:GetSelectedShipIds(arg_8_1, arg_8_3)
	local var_8_2 = {
		callbackQuit = true,
		selectedMax = arg_8_4,
		quitTeam = arg_8_3 ~= nil
	}

	var_8_2.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_8_2.selectedIds = Clone(var_8_1)
	var_8_2.preView = self.viewComponent.__cname
	var_8_2.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_8_2.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_8_2.onShip(arg_9_0, arg_9_1, arg_9_2)
		return self:OnShip(arg_9_0, arg_9_1, arg_9_2)
	end

	function var_8_2.onSelected(arg_10_0, arg_10_1)
		self:OnSelected(arg_8_1, arg_8_2, arg_10_0, arg_10_1)

		return
	end

	var_8_2.priorEquipUpShipIDList = _.filter(var_8_0:GetShipIds(), function(arg_11_0)
		return arg_11_0 > 0
	end)
	var_8_2.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_8_2.isLayer = true
	var_8_2.energyDisplay = true

	self:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_8_2
	}))

	return
end

function FireworkAndSpringMediator:GetSelectedShipIds(arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_2 then
		var_12_0 = arg_12_2.id or -1
	end

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(getProxy(ActivityProxy):getActivityById(arg_12_1):GetShipIds()) do
		local var_12_2 = iter_12_1 > 0 and getProxy(BayProxy):RawGetShipById(iter_12_1)

		if var_12_2 and var_12_2.id ~= var_12_0 then
			table.insert(var_12_1, var_12_2.id)
		end
	end

	return var_12_1
end

function FireworkAndSpringMediator:OnShip(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0, var_13_1 = ShipStatus.ShipStatusCheck("inBackyard", arg_13_1, function(arg_14_0)
		arg_13_2()

		return
	end)

	return var_13_0, var_13_1
end

function FireworkAndSpringMediator:OnSelected(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = getProxy(ActivityProxy):getActivityById(arg_15_1)
	local var_15_1 = Clone(var_15_0:GetShipIds())

	_.each(_.range(var_15_0:GetSlotCount()), function(arg_16_0)
		var_15_1[arg_16_0] = var_15_1[arg_16_0] or 0

		return
	end)

	if arg_15_3 == nil or #arg_15_3 == 0 then
		if var_15_1[arg_15_2] > 0 then
			self:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_15_0.id,
				cmd = Spring2Activity.OPERATION_SETSHIP,
				kvargs1 = {
					{
						value = 0,
						key = arg_15_2
					}
				}
			})
		end

		existCall(arg_15_4)

		return
	end

	local var_15_2 = _.filter(arg_15_3, function(arg_17_0)
		return not table.contains(var_15_1, arg_17_0)
	end)

	table.Foreach(var_15_1, function(arg_18_0, arg_18_1)
		if arg_18_1 == 0 or table.contains(arg_15_3, arg_18_1) then
			return
		end

		var_15_1[arg_18_0] = 0

		return
	end)

	if #var_15_2 == 1 and var_15_1[arg_15_2] == 0 then
		var_15_1[arg_15_2] = var_15_2[1]
	else
		local var_15_3 = 0

		_.each(var_15_2, function(arg_19_0)
			while var_15_3 <= #var_15_1 do
				var_15_3 = var_15_3 + 1

				if var_15_1[var_15_3] == 0 then
					break
				end
			end

			var_15_1[var_15_3] = arg_19_0

			return
		end)
	end

	local var_15_4 = {}
	local var_15_5 = var_15_0:GetShipIds()

	table.Foreach(var_15_1, function(arg_20_0, arg_20_1)
		if (var_15_5[arg_20_0] or 0) ~= arg_20_1 then
			table.insert(var_15_4, {
				key = arg_20_0,
				value = arg_20_1
			})
		end

		return
	end)

	if #var_15_4 > 0 then
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = var_15_0.id,
			cmd = Spring2Activity.OPERATION_SETSHIP,
			kvargs1 = var_15_4
		})
	end

	arg_15_4()

	return
end

function FireworkAndSpringMediator:listNotificationInterests()
	return {
		GAME.ACT_NEW_PT_DONE,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_AVATAR_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function FireworkAndSpringMediator:handleNotification(arg_22_1)
	local var_22_0 = arg_22_1:getName()
	local var_22_1 = arg_22_1:getBody()

	if var_22_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_1.awards, var_22_1.callback)
		self.viewComponent:UpdatePtData()
		self.viewComponent:UpdateMainPt()
		self.viewComponent:SetPtPanel()
	elseif var_22_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_1)
		self.viewComponent:UpdateTaskData()
		self.viewComponent:UpdatePtData()
		self.viewComponent:UpdateMainPt()
		self.viewComponent:SetTaskPanel()
		self.viewComponent:UpdateSpringData()
	elseif var_22_0 == GAME.SUBMIT_AVATAR_TASK_DONE or var_22_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_1.awards)
		self.viewComponent:UpdateTaskData()
		self.viewComponent:UpdatePtData()
		self.viewComponent:UpdateMainPt()
		self.viewComponent:SetTaskPanel()
		self.viewComponent:UpdateSpringData()
	elseif var_22_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_1.awards)
	elseif var_22_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		if getProxy(ActivityProxy):getActivityById(var_22_1):getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
			self.viewComponent:UpdateSpringActivityAndUI()
		end
	elseif var_22_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_22_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			self.viewComponent:UpdateFireworkData()
			self.viewComponent:UpdatePtData()
			self.viewComponent:UpdateMainPt()
			self.viewComponent:SetFireWorkPanel()
		elseif var_22_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
			self.viewComponent:UpdateSpringActivityAndUI()
		end
	end

	self.viewComponent:SetTips()

	return
end

return FireworkAndSpringMediator
