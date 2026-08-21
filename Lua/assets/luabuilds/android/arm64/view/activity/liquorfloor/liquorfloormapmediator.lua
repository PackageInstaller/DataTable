local var_0_0 = class("LiquorFloorMapMediator", import("view.base.ContextMediator"))

var_0_0.ADD_WORKPLACE = "LiquorFloorMapMediator:ADD_WORKPLACE"
var_0_0.ALL_WORKPLACE = "LiquorFloorMapMediator:ALL_WORKPLACE"
var_0_0.OPEN_CHUANWU = "LiquorFloorMapMediator:OPEN_CHUANWU"
var_0_0.UPGRADE_WORKPLACE = "LiquorFloorMapMediator:UPGRADE_WORKPLACE"
var_0_0.CLICK_BUBBLE = "LiquorFloorMapMediator:CLICK_BUBBLE"
var_0_0.GO_FIGHT = "LiquorFloorMapMediator:GO_FIGHT"
var_0_0.OPEN_CLUE_BOOK = "LiquorFloorMapMediator.OPEN_CLUE_BOOK"
var_0_0.OPEN_LAYER = "LiquorFloorMapMediator:OPEN_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0.upgradeplaceData = nil
	arg_1_0.indexplaceData = nil

	arg_1_0:bind(var_0_0.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:OnSelShips(arg_2_1, arg_2_2, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_0.ADD_WORKPLACE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = arg_1_0.activity.id,
			arg1 = arg_3_1,
			cmd = TownActivity2.OPERATION.SETTLE_GOLD
		})

		return
	end)
	arg_1_0:bind(var_0_0.ALL_WORKPLACE, function(arg_4_0)
		arg_1_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = arg_1_0.activity.id,
			cmd = TownActivity2.OPERATION.ALL_GOLD
		})

		return
	end)
	arg_1_0:bind(var_0_0.UPGRADE_WORKPLACE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_1_0.upgradeplaceData = arg_5_2
		arg_1_0.indexplaceData = arg_5_3

		arg_1_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = arg_1_0.activity.id,
			cmd = TownActivity2.OPERATION.UPGRADE_PLACE,
			arg1 = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.CLICK_BUBBLE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = arg_1_0.activity.id,
			cmd = TownActivity2.OPERATION.CLICK_BUBBLE,
			arg_list = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CLUE_BOOK, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = LiquorFloorBookLayer,
			mediator = LiquorFloorBookMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_FIGHT, function(arg_8_0, arg_8_1)
		local var_8_0 = getProxy(ChapterProxy)
		local var_8_1, var_8_2 = var_8_0:getLastMapForActivity()

		if var_8_1 then
			if not var_8_0:getMapById(var_8_1):isUnlock() then
				local var_8_3 = getProxy(ChapterProxy)
				local var_8_4 = var_8_3:getActiveChapter()

				var_8_1 = var_8_4 and var_8_4:getConfig("map")

				if not var_8_4 then
					var_8_1 = var_8_3:GetLastNormalMap()
				end

				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_8_4 and var_8_4.id,
					mapIdx = var_8_1
				})
			else
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_8_2,
					mapIdx = var_8_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_0.OPEN_LAYER, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(arg_9_1)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2)

	if not var_1_0 or var_1_0:isEnd() then
		assert(nil, "not exist act")

		return
	end

	arg_1_0.activity = var_1_0

	arg_1_0.viewComponent:SetActivity(var_1_0)

	return
end

function var_0_0.ChangeShips(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
		activity_id = arg_10_0.activity.id,
		cmd = TownActivity.OPERATION.CHANGE_SHIPS,
		kvargs1 = arg_10_1,
		arg1 = arg_10_2
	})

	return
end

function var_0_0.OnSelShips(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:GetSelectedShipIds(arg_11_2)
	local var_11_1 = {
		selectedMin = 0,
		callbackQuit = true,
		selectedMax = arg_11_0.activity:GetUnlockSlotCnt(),
		quitTeam = arg_11_2 ~= nil
	}

	var_11_1.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_11_1.selectedIds = Clone(var_11_0)
	var_11_1.preView = arg_11_0.viewComponent.__cname
	var_11_1.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_11_1.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_11_1.onSelected(arg_12_0, arg_12_1)
		arg_11_0:OnSelected(arg_11_1, arg_12_0, arg_12_1, arg_11_3)

		return
	end

	var_11_1.priorEquipUpShipIDList = _.filter(arg_11_0.activity:GetShipIds(), function(arg_13_0)
		return arg_13_0 > 0
	end)
	var_11_1.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_11_1.isLayer = true
	var_11_1.energyDisplay = true

	arg_11_0:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_11_1
	}))

	return
end

function var_0_0.OnSelected(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Clone(arg_14_0.activity:GetShipIds())
	local var_14_2 = {}

	if arg_14_2 == nil or #arg_14_2 == 0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1 > 0 then
				table.insert(var_14_2, {
					value = 0,
					key = iter_14_0
				})
			end
		end
	else
		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			if not arg_14_2[iter_14_2] then
				table.insert(var_14_2, {
					value = 0,
					key = iter_14_2
				})
			elseif arg_14_2[iter_14_2] ~= iter_14_3 then
				table.insert(var_14_2, {
					key = iter_14_2,
					value = arg_14_2[iter_14_2]
				})
			end
		end
	end

	if #var_14_2 > 0 then
		arg_14_0:ChangeShips(var_14_2, arg_14_4)
	end

	existCall(arg_14_3)

	return
end

function var_0_0.GetSelectedShipIds(arg_15_0, arg_15_1)
	if arg_15_1 then
		local var_15_0 = arg_15_1.id or -1
		local var_15_1 = {}

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.activity:GetShipIds()) do
			local var_15_2 = iter_15_1 > 0 and getProxy(BayProxy):RawGetShipById(iter_15_1)

			if var_15_2 and var_15_2.id ~= var_15_0 then
				table.insert(var_15_1, var_15_2.id)
			end
		end

		return var_15_1
	end
end

function var_0_0.listNotificationInterests(arg_16_0)
	return {
		GAME.ACTIVITY_TOWN_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_AWARD_DOWN,
		GAME.TOTAL_TASK_UPDATED
	}
end

function var_0_0.handleNotification(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1:getBody()

	if var_17_0 == GAME.ACTIVITY_TOWN_OP_DONE then
		switch(var_17_1.cmd, {
			[TownActivity2.OPERATION.UPGRADE_PLACE] = function()
				arg_17_0.viewComponent:InitData()

				arg_17_0.placeData = arg_17_0.activity:GetPlaceList()

				arg_17_0.viewComponent:OnBox(arg_17_0.placeData[arg_17_0.indexplaceData], arg_17_0.indexplaceData, arg_17_0.activity)
				arg_17_0.viewComponent:OnBox(arg_17_0.placeData[arg_17_0.indexplaceData], arg_17_0.indexplaceData, arg_17_0.activity)

				arg_17_0.upgradeplaceData = nil
				arg_17_0.indexplaceData = nil

				return
			end,
			[TownActivity2.OPERATION.CHANGE_SHIPS] = function()
				arg_17_0.viewComponent:InitData()
				arg_17_0.viewComponent:UpdateBubbles()
				setActive(arg_17_0.viewComponent.box, false)

				return
			end,
			[TownActivity2.OPERATION.CLICK_BUBBLE] = function()
				arg_17_0.viewComponent:InitData()
				arg_17_0.viewComponent:UpdateBubbles()
				arg_17_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_1.awards)

				return
			end,
			[TownActivity2.OPERATION.SETTLE_GOLD] = function()
				arg_17_0.viewComponent:InitData()
				arg_17_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_1.awards)

				return
			end,
			[TownActivity2.OPERATION.ALL_GOLD] = function()
				arg_17_0.viewComponent:InitData()
				arg_17_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_1.awards)

				return
			end
		})
	elseif var_17_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_17_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TOWN2 then
			arg_17_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2)

			arg_17_0.viewComponent:SetActivity(arg_17_0.activity)
			arg_17_0.viewComponent:InitData()
		end
	elseif var_17_0 == GAME.SUBMIT_TASK_AWARD_DOWN or var_17_0 == GAME.TOTAL_TASK_UPDATED then
		arg_17_0.viewComponent:RefreshRedPoint()
	end

	arg_17_0.viewComponent:OnStoryList()

	return
end

return var_0_0
