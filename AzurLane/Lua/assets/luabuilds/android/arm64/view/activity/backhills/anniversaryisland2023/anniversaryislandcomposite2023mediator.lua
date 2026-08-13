class = var_0_10000

local var_0_0 = "AnniversaryIslandComposite2023Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_FORMULA = "OPEN_FORMULA"
var_0_1.OPEN_STOREHOUSE = "AnniversaryIslandComposite2023Mediator:OPEN_STOREHOUSE"
var_0_1.OPEN_UPGRADE_PANEL = "AnniversaryIslandComposite2023Mediator:OPEN_UPGRADE_PANEL"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10004

	var_1_1(var_1_0, var_1_10004.WORKBENCH_COMPOSITE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.WORKBENCH_COMPOSITE, {
			formulaId = arg_2_1,
			repeats = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_STOREHOUSE, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		AnniversaryIslandStoreHouse2023Mediator = var_2_10007
		var_3_3.mediator = var_2_10007
		AnniversaryIslandStoreHouse2023Window = var_2_10007
		var_3_3.viewComponent = var_2_10007

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_UPGRADE_PANEL, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		AnniversaryIslandBuildingUpgrade2023WindowMediator = var_2_10007
		var_4_3.mediator = var_2_10007
		AnniversaryIslandBuildingUpgrade2023Window = var_2_10007
		var_4_3.viewComponent = var_2_10007

		local var_4_4 = {}

		table = var_2_10008

		local var_4_5 = var_2_10008.keyof

		AnniversaryIsland2023Scene = var_2_10010
		var_4_4.buildingID = var_4_5(var_2_10010.Buildings, "craft")
		var_4_3.data = var_4_4

		var_4_1(var_4_0, var_4_2(var_4_3), true)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	WorkBenchItemDetailMediator = var_4

	var_1_3(var_1_2, var_4.SHOW_DETAIL, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		WorkBenchItemDetailMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		WorkBenchItemDetailLayer = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = {
			material = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	getProxy = var_1_3
	SettingsProxy = var_1_2

	local var_1_4 = var_1_3(var_1_2)

	var_1.SetWorkbenchDailyTip(var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.WORKBENCH_COMPOSITE_DONE
	ActivityProxy = var_2
	var_6_0[2] = var_2.ACTIVITY_UPDATED
	var_6_0[3] = var_0_1.OPEN_FORMULA

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1
	local var_7_3 = arg_7_1.getBody(var_7_2)

	GAME = var_7_0

	local var_7_5

	if var_7_1 == var_7_0.WORKBENCH_COMPOSITE_DONE then
		local var_7_4 = arg_7_0.viewComponent

		var_7_5 = var_7_5.emit
		BaseUI = var_1_10007

		var_7_5(var_7_4, var_1_10007.ON_ACHIEVE, var_7_3)

		goto label_7_0
	end

	ActivityProxy = var_7_5

	if var_7_1 == var_7_5.ACTIVITY_UPDATED then
		local var_7_6 = var_7_3:getConfig("type")

		ActivityConst = var_7_2

		if var_7_6 ~= var_7_2.ACTIVITY_TYPE_WORKBENCH then
			local var_7_7 = var_7_3:getConfig("type")

			ActivityConst = var_5

			if var_7_7 ~= var_5.ACTIVITY_TYPE_VIRTUAL_BAG then
				do
					local var_7_8 = var_7_3:getConfig("type")

					ActivityConst = var_5

					if var_7_8 == var_5.ACTIVITY_TYPE_BUILDING_BUFF_2 then
						local var_7_9 = arg_7_0.viewComponent

						var_4.BuildActivityEnv(var_7_9)

						local var_7_10 = arg_7_0.viewComponent

						var_4.UpdateView(var_7_10)

						goto label_7_0

						if var_7_1 == var_0_1.OPEN_FORMULA then
							if not var_7_3 then
								return
							end

							local var_7_11 = arg_7_0.viewComponent

							var_4.OnReceiveFormualRequest(var_7_11, var_7_3)
						end
					end
				end

				::label_7_0::

				return
			end
		end
	end
end

function var_0_1.remove(arg_8_0)
	return
end

return var_0_1
