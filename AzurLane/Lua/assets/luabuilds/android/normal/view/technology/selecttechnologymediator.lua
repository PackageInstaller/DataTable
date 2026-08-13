class = var_0_10000

local var_0_0 = "SelectTechnologyMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_BLUEPRINT = "SelectTechnologyMediator:ON_BLUEPRINT"
var_0_1.ON_TECHNOLOGY = "SelectTechnologyMediator:ON_TECHNOLOGY"
var_0_1.ON_TRANSFORM_EQUIPMENT = "SelectTechnologyMediator:ON_TRANSFORM_EQUIPMENT"
var_0_1.ON_META = "SelectTechnologyMediator:ON_META"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TECHNOLOGY, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_2_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BLUEPRINT, function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_3_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.SHIPBLUEPRINT)

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	TechnologyConst = var_3

	var_1_1(var_1_0, var_3.OPEN_TECHNOLOGY_TREE_SCENE, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.TECHNOLOGY_TREE_SCENE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRANSFORM_EQUIPMENT, function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.EQUIPMENT_TRANSFORM)

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.ON_META, function()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_6_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.METACHARACTER)

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_2

	local var_1_3 = var_1(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_4, var_1_3:getData())

	local var_1_5 = var_0_1.onTechnologyNotify()
	local var_1_6 = arg_1_0.viewComponent

	var_3.notifyTechnology(var_1_6, var_1_5)

	local var_1_7 = var_0_1.onBlueprintNotify()
	local var_1_8 = arg_1_0.viewComponent

	var_4.notifyBlueprint(var_1_8, var_1_7)

	getProxy = var_4
	TechnologyNationProxy = var_1_8

	local var_1_9 = var_4(var_1_8)
	local var_1_10 = var_4.getShowRedPointTag(var_1_9)
	local var_1_11 = arg_1_0.viewComponent

	var_5.notifyFleet(var_1_11, var_1_10)

	MetaCharacterConst = var_5

	local var_1_12 = var_5.isMetaMainEntRedPoint()
	local var_1_13 = arg_1_0.viewComponent

	var_6.notifyMeta(var_1_13, var_1_12)

	return
end

function var_0_1.onTechnologyNotify()
	getProxy = var_1_10000
	TechnologyProxy = var_1_10001

	local var_7_0 = var_1_10000(var_1_10001)
	local var_7_2

	if #var_0.getPlanningTechnologys(var_7_0) > 0 then
		local var_7_1 = var_0[#var_0]

		var_7_2 = var_1.isCompleted(var_7_1)
	else
		var_7_2 = false
	end

	if false then
		var_7_2 = true
	end

	return var_7_2
end

function var_0_1.onBlueprintNotify()
	getProxy = var_1_10000
	TechnologyProxy = var_1_10001

	local var_8_0 = var_1_10000(var_1_10001)

	PlayerPrefs = var_1_10001

	local var_8_1 = var_1_10001.GetString("technology_day_mark", "")

	pg = var_2

	local var_8_2 = var_2.TimeMgr.GetInstance()

	if var_8_1 ~= var_2.CurrentSTimeDesc(var_8_2, "%Y/%m/%d", true) and var_8_0:CheckPursuingCostTip() then
		return true
	end

	local var_8_3 = var_8_0:getBluePrints()
	local var_8_4 = var_8_0

	if not var_8_0.getBuildingBluePrint(var_8_4) then
		_ = var_8_4

		local var_8_5 = var_8_4.any

		_ = var_4

		return var_8_5(var_4.values(var_8_3), function(arg_9_0)
			local var_9_0 = arg_9_0
			local var_9_1 = arg_9_0.getState(var_9_0)

			ShipBluePrint = var_9_0

			local var_9_2 = var_9_1 == var_9_0.STATE_LOCK
			local var_9_3, var_9_4 = arg_9_0:isFinishPrevTask()

			return var_9_2 and var_9_3
		end)
	else
		local var_8_6 = var_2
		local var_8_7 = var_2.getState(var_8_6)

		ShipBluePrint = var_8_6

		if var_8_7 == var_8_6.STATE_DEV_FINISHED then
			return true
		end

		local var_8_8 = false
		local var_8_9 = var_2
		local var_8_10 = var_2.getTaskIds(var_8_9)

		_ = var_8_9

		return var_8_9.any(var_8_10, function(arg_10_0)
			local var_10_0 = var_0
			local var_10_1 = var_1.getTaskStateById(var_10_0, arg_10_0)

			getProxy = var_10_0
			TaskProxy = var_3

			local var_10_2 = var_10_0(var_3)
			local var_10_3 = var_2.isFinishPrevTasks(var_10_2, arg_10_0)

			ShipBluePrint = var_10_2

			local var_10_4

			if var_10_2.TASK_STATE_OPENING then
				var_10_4 = var_10_3
			end

			local var_10_5

			if var_10_1 ~= var_10_4 then
				ShipBluePrint = var_10_4

				if var_10_1 ~= var_10_4.TASK_STATE_ACHIEVED then
					var_10_5 = false

					goto label_10_0
				end
			end

			var_10_5 = true

			::label_10_0::

			return var_10_5
		end)
	end

	return false
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	PlayerProxy = var_1_10002
	var_11_0[1] = var_1_10002.UPDATED

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.getBody(var_12_1)

	PlayerProxy = var_12_1

	if var_12_0 == var_12_1.UPDATED then
		local var_12_3 = arg_12_0.viewComponent

		var_4.setPlayer(var_12_3, var_12_2)
	end

	return
end

return var_0_1
