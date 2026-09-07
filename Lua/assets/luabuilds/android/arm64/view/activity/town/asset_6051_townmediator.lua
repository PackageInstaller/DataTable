local TownMediator = class("TownMediator", import("view.base.ContextMediator"))

TownMediator.OPEN_CHUANWU = "TownMediator:OPEN_CHUANWU"
TownMediator.UPGRADE_TOWN = "TownMediator:UPGRADE_TOWN"
TownMediator.UPGRADE_WORKPLACE = "TownMediator:UPGRADE_WORKPLACE"
TownMediator.CLICK_BUBBLE = "TownMediator:CLICK_BUBBLE"

function TownMediator:register()
	self:bind(TownMediator.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2)
		self:OnSelShips(arg_2_1, arg_2_2)

		return
	end)
	self:bind(TownMediator.UPGRADE_TOWN, function(arg_3_0)
		self:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = self.activity.id,
			cmd = TownActivity.OPERATION.UPGRADE_TOWN
		})

		return
	end)
	self:bind(TownMediator.UPGRADE_WORKPLACE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = self.activity.id,
			cmd = TownActivity.OPERATION.UPGRADE_PLACE,
			arg1 = arg_4_1
		})

		return
	end)
	self:bind(TownMediator.CLICK_BUBBLE, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = self.activity.id,
			cmd = TownActivity.OPERATION.CLICK_BUBBLE,
			arg_list = arg_5_1
		})

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_1_0 or var_1_0:isEnd() then
		assert(nil, "not exist act")

		return
	end

	self.activity = var_1_0

	self.viewComponent:SetActivity(var_1_0)

	return
end

function TownMediator:ChangeShips(arg_6_1)
	self:sendNotification(GAME.ACTIVITY_TOWN_OP, {
		activity_id = self.activity.id,
		cmd = TownActivity.OPERATION.CHANGE_SHIPS,
		kvargs1 = arg_6_1
	})

	return
end

function TownMediator:OnSelShips(arg_7_1, arg_7_2)
	local var_7_0 = self:GetSelectedShipIds(arg_7_2)
	local var_7_1 = {
		selectedMin = 0,
		callbackQuit = true,
		selectedMax = self.activity:GetUnlockSlotCnt(),
		quitTeam = arg_7_2 ~= nil
	}

	var_7_1.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_7_1.selectedIds = Clone(var_7_0)
	var_7_1.preView = self.viewComponent.__cname
	var_7_1.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_7_1.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_7_1.onSelected(arg_8_0, arg_8_1)
		self:OnSelected(arg_7_1, arg_8_0, arg_8_1)

		return
	end

	var_7_1.priorEquipUpShipIDList = _.filter(self.activity:GetShipIds(), function(arg_9_0)
		return arg_9_0 > 0
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

function TownMediator:OnSelected(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Clone(self.activity:GetShipIds())
	local var_10_2 = {}

	if arg_10_2 == nil or #arg_10_2 == 0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if iter_10_1 > 0 then
				table.insert(var_10_2, {
					value = 0,
					key = iter_10_0
				})
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(var_10_0) do
			if not arg_10_2[iter_10_2] then
				table.insert(var_10_2, {
					value = 0,
					key = iter_10_2
				})
			elseif arg_10_2[iter_10_2] ~= iter_10_3 then
				table.insert(var_10_2, {
					key = iter_10_2,
					value = arg_10_2[iter_10_2]
				})
			end
		end
	end

	if #var_10_2 > 0 then
		self:ChangeShips(var_10_2)
	end

	existCall(arg_10_3)

	return
end

function TownMediator:GetSelectedShipIds(arg_11_1)
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

function TownMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_TOWN_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function TownMediator:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == GAME.ACTIVITY_TOWN_OP_DONE then
		switch(var_13_1.cmd, {
			[TownActivity.OPERATION.UPGRADE_TOWN] = function()
				local var_14_0 = pg.activity_town_level[self.activity:GetTownLevel()]

				seriesAsync({
					function(arg_15_0)
						self.viewComponent:OnTownUpgrade(arg_15_0)

						return
					end,
					function(arg_16_0)
						if var_14_0.unlock_story ~= "" then
							pg.NewStoryMgr.GetInstance():Play(var_14_0.unlock_story, arg_16_0)
						else
							arg_16_0()
						end

						return
					end,
					function(arg_17_0)
						if #var_14_0.unlock_work[1] > 0 or #var_14_0.unlock_work[2] > 0 then
							self:addSubLayers(Context.New({
								mediator = TownUnlockMediator,
								viewComponent = TownUnlockLayer,
								data = {
									newIds = var_14_0.unlock_work[1],
									limitIds = var_14_0.unlock_work[2],
									removeFunc = arg_17_0
								}
							}))
						else
							arg_17_0()
						end

						return
					end
				}, function()
					return
				end)

				return
			end,
			[TownActivity.OPERATION.UPGRADE_PLACE] = function()
				seriesAsync({
					function(arg_20_0)
						self.viewComponent:OnPlaceUpgrade(arg_20_0)

						return
					end,
					function(arg_21_0)
						self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1.awards)

						return
					end
				}, function()
					return
				end)

				return
			end,
			[TownActivity.OPERATION.CHANGE_SHIPS] = function()
				self.viewComponent:UpdateShips()
				self.viewComponent:UpdateInfoPage()

				return
			end,
			[TownActivity.OPERATION.CLICK_BUBBLE] = function()
				self.viewComponent:UpdateBubbles()
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1.awards)

				return
			end
		})
	elseif var_13_0 == ActivityProxy.ACTIVITY_UPDATED and var_13_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TOWN then
		self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

		self.viewComponent:SetActivity(self.activity)
		self.viewComponent:UpdateGold()
		self.viewComponent:OnExpUpdate()
	end

	return
end

return TownMediator
