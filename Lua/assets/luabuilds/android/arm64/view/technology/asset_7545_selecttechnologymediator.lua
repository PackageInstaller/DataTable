local SelectTechnologyMediator = class("SelectTechnologyMediator", import("..base.ContextMediator"))

SelectTechnologyMediator.ON_BLUEPRINT = "SelectTechnologyMediator:ON_BLUEPRINT"
SelectTechnologyMediator.ON_TECHNOLOGY = "SelectTechnologyMediator:ON_TECHNOLOGY"
SelectTechnologyMediator.ON_TRANSFORM_EQUIPMENT = "SelectTechnologyMediator:ON_TRANSFORM_EQUIPMENT"
SelectTechnologyMediator.ON_META = "SelectTechnologyMediator:ON_META"

function SelectTechnologyMediator:register()
	self:bind(SelectTechnologyMediator.ON_TECHNOLOGY, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)

		return
	end)
	self:bind(SelectTechnologyMediator.ON_BLUEPRINT, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT)

		return
	end)
	self:bind(TechnologyConst.OPEN_TECHNOLOGY_TREE_SCENE, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY_TREE_SCENE)

		return
	end)
	self:bind(SelectTechnologyMediator.ON_TRANSFORM_EQUIPMENT, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPMENT_TRANSFORM)

		return
	end)
	self:bind(SelectTechnologyMediator.ON_META, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER)

		return
	end)
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
	self.viewComponent:notifyTechnology((SelectTechnologyMediator.onTechnologyNotify()))
	self.viewComponent:notifyBlueprint((SelectTechnologyMediator.onBlueprintNotify()))
	self.viewComponent:notifyFleet((getProxy(TechnologyNationProxy):getShowRedPointTag()))
	self.viewComponent:notifyMeta((MetaCharacterConst.isMetaMainEntRedPoint()))

	return
end

function SelectTechnologyMediator.onTechnologyNotify()
	local var_7_0 = getProxy(TechnologyProxy):getPlanningTechnologys()

	return #var_7_0 > 0 and var_7_0[#var_7_0]:isCompleted()
end

function SelectTechnologyMediator.onBlueprintNotify()
	local var_8_0 = getProxy(TechnologyProxy)

	if PlayerPrefs.GetString("technology_day_mark", "") ~= pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d", true) and var_8_0:CheckPursuingCostTip() then
		return true
	end

	local var_8_1 = var_8_0:getBluePrints()
	local var_8_2 = var_8_0:getBuildingBluePrint()

	if not var_8_2 then
		return _.any(_.values(var_8_1), function(arg_9_0)
			local var_9_0 = arg_9_0:getState() == ShipBluePrint.STATE_LOCK
			local var_9_1, var_9_2 = arg_9_0:isFinishPrevTask()

			return var_9_0 and var_9_1
		end)
	else
		if var_8_2:getState() == ShipBluePrint.STATE_DEV_FINISHED then
			return true
		end

		return _.any(var_8_2:getTaskIds(), function(arg_10_0)
			local var_10_0 = var_8_2:getTaskStateById(arg_10_0)

			return var_10_0 == (ShipBluePrint.TASK_STATE_OPENING and getProxy(TaskProxy):isFinishPrevTasks(arg_10_0)) or var_10_0 == ShipBluePrint.TASK_STATE_ACHIEVED
		end)
	end

	return false
end

function SelectTechnologyMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED
	}
end

function SelectTechnologyMediator:handleNotification(arg_12_1)
	if arg_12_1:getName() == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer((arg_12_1:getBody()))
	end

	return
end

return SelectTechnologyMediator
