class = var_0_10000

local var_0_0 = "FireworkAndSpringMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BackHills.TemplateMV.BackHillMediatorTemplate"))

var_0_1.EVENT_PT_OPERATION = "FireworkAndSpringMediator:event pt op"
var_0_1.ON_TASK_GO = "FireworkAndSpringMediator:event on task go"
var_0_1.ON_TASK_SUBMIT = "FireworkAndSpringMediator:event on task submit"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "FireworkAndSpringMediator:event on task submit one step"
var_0_1.ACTIVITY_OPERATION = "FireworkAndSpringMediator:event activity op"
var_0_1.OPEN_CHUANWU = "FireworkAndSpringMediator:Open chuanwu"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ACT_NEW_PT, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_TASK, arg_4_1.id, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_5_1,
			task_ids = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ACTIVITY_OPERATION, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_6_2 = var_2_10005.ACTIVITY_OPERATION
		local var_6_3 = {
			activity_id = arg_6_1
		}

		PuzzleActivity = var_2_10007
		var_6_3.cmd = var_2_10007.CMD_ACTIVATE
		var_6_3.arg1 = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHUANWU, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		local var_7_0 = arg_1_0

		var_5.OnSelShips(var_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)

		return
	end)

	return
end

function var_0_1.OnSelShips(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_8_0 = var_1_10005(var_1_10006)
	local var_8_1 = var_5.getActivityById(var_8_0, arg_8_1)
	local var_8_2 = arg_8_0:GetSelectedShipIds(arg_8_1, arg_8_3)
	local var_8_3 = {
		callbackQuit = true,
		selectedMax = arg_8_4,
		quitTeam = arg_8_3 ~= nil
	}

	pg = var_8

	local var_8_4 = var_8.ShipFlagMgr.GetInstance()

	var_8_3.ignoredIds = var_8.FilterShips(var_8_4, {
		isActivityNpc = true
	})
	Clone = var_8
	var_8_3.selectedIds = var_8(var_8_2)
	var_8_3.preView = arg_8_0.viewComponent.__cname
	ShipStatus = var_8
	var_8_3.hideTagFlags = var_8.TAG_HIDE_BACKYARD
	ShipStatus = var_8
	var_8_3.blockTagFlags = var_8.TAG_BLOCK_BACKYARD

	function var_8_3.onShip(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_8_0

		return var_3.OnShip(var_9_0, arg_9_0, arg_9_1, arg_9_2)
	end

	function var_8_3.onSelected(arg_10_0, arg_10_1)
		local var_10_0 = arg_8_0

		var_2.OnSelected(var_10_0, arg_8_1, arg_8_2, arg_10_0, arg_10_1)

		return
	end

	_ = var_8
	var_8_3.priorEquipUpShipIDList = var_8.filter(var_8_1:GetShipIds(), function(arg_11_0)
		return arg_11_0 > 0
	end)
	i18n = var_8
	var_8_3.leftTopWithFrameInfo = var_8("backyard_longpress_ship_tip")
	var_8_3.isLayer = true
	var_8_3.energyDisplay = true

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.addSubLayers

	Context = var_10

	local var_8_7 = var_10.New
	local var_8_8 = {}

	DockyardScene = var_1_10012
	var_8_8.viewComponent = var_1_10012
	DockyardMediator = var_1_10012
	var_8_8.mediator = var_1_10012
	var_8_8.data = var_8_3

	var_8_6(var_8_5, var_8_7(var_8_8))

	return
end

function var_0_1.GetSelectedShipIds(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if not arg_12_2 or not arg_12_2.id then
		var_12_0 = -1
	end

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_12_1 = var_1_10004(var_1_10005)
	local var_12_2 = var_4.getActivityById(var_12_1, arg_12_1)
	local var_12_3 = {}

	ipairs = var_6

	for iter_12_0, iter_12_1 in var_6(var_12_2:GetShipIds()) do
		local var_12_4

		if 0 < iter_12_1 then
			getProxy = var_11
			BayProxy = var_1_10012
			var_1_10012 = var_11(var_1_10012)
			var_12_4 = var_11.RawGetShipById(var_1_10012, iter_12_1)
		else
			var_12_4 = false
		end

		if false then
			var_12_4 = true
		end

		if var_12_4 and var_12_4.id ~= var_12_0 then
			table = var_1_10012

			var_1_10012.insert(var_12_3, var_12_4.id)
		end
	end

	return var_12_3
end

function var_0_1.OnShip(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	ShipStatus = var_1_10004

	local var_13_0, var_13_1 = var_1_10004.ShipStatusCheck("inBackyard", arg_13_1, function(arg_14_0)
		arg_13_2()

		return
	end)

	return var_13_0, var_13_1
end

function var_0_1.OnSelected(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_15_0 = var_1_10005(var_1_10006)
	local var_15_1 = var_5.getActivityById(var_15_0, arg_15_1)

	Clone = var_15_0

	local var_15_2 = var_15_1
	local var_15_3 = var_15_0(var_15_1.GetShipIds(var_15_2))

	_ = var_7

	local var_15_4 = var_7.each

	_ = var_15_2

	local var_15_5 = var_15_2.range
	local var_15_6 = var_15_1

	var_15_4(var_15_5(var_15_1.GetSlotCount(var_15_6)), function(arg_16_0)
		local var_16_0 = var_15_3
		local var_16_1

		if not var_15_3[arg_16_0] then
			var_16_1 = 0
		end

		var_16_0[arg_16_0] = var_16_1

		return
	end)

	if arg_15_3 == nil or #arg_15_3 == 0 then
		var_15_4 = var_15_3[arg_15_2]

		local var_15_8

		if 0 < var_15_4 then
			local var_15_7 = arg_15_0

			var_15_8 = arg_15_0.sendNotification
			GAME = var_15_6

			local var_15_9 = var_15_6.ACTIVITY_OPERATION
			local var_15_10 = {
				activity_id = var_15_1.id
			}

			Spring2Activity = var_12
			var_15_10.cmd = var_12.OPERATION_SETSHIP
			var_15_10.kvargs1 = {
				{
					value = 0,
					key = arg_15_2
				}
			}

			var_15_8(var_15_7, var_15_9, var_15_10)
		end

		existCall = var_15_8

		var_15_8(arg_15_4)

		return
	end

	_ = var_15_4

	local var_15_11 = var_15_4.filter(arg_15_3, function(arg_17_0)
		table = var_2_10001

		return not var_2_10001.contains(var_15_3, arg_17_0)
	end)

	table = var_8

	var_8.Foreach(var_15_3, function(arg_18_0, arg_18_1)
		if arg_18_1 ~= 0 then
			table = var_2_10002

			if var_2_10002.contains(arg_15_3, arg_18_1) then
				return
			end

			var_15_3[arg_18_0] = 0

			return
		end
	end)

	if #var_15_11 == 1 and var_15_3[arg_15_2] == 0 then
		var_15_3[arg_15_2] = var_15_11[1]
	else
		local var_15_12 = 0

		_ = var_9

		var_9.each(var_15_11, function(arg_19_0)
			while var_15_12 <= #var_15_3 do
				var_15_12 = var_15_12 + 1

				if var_15_3[var_15_12] == 0 then
					break
				end
			end

			var_15_3[var_15_12] = arg_19_0

			return
		end)
	end

	local var_15_13 = {}
	local var_15_14 = var_15_1
	local var_15_15 = var_15_1.GetShipIds(var_15_14)

	table = var_15_14

	var_15_14.Foreach(var_15_3, function(arg_20_0, arg_20_1)
		local var_20_0

		if not var_15_15[arg_20_0] then
			var_20_0 = 0
		end

		if var_20_0 ~= arg_20_1 then
			table = var_2_10003

			var_2_10003.insert(var_15_13, {
				key = arg_20_0,
				value = arg_20_1
			})
		end

		return
	end)

	if #var_15_13 > 0 then
		local var_15_16 = arg_15_0
		local var_15_17 = arg_15_0.sendNotification

		GAME = var_12

		local var_15_18 = var_12.ACTIVITY_OPERATION
		local var_15_19 = {
			activity_id = var_15_1.id
		}

		Spring2Activity = var_14
		var_15_19.cmd = var_14.OPERATION_SETSHIP
		var_15_19.kvargs1 = var_15_13

		var_15_17(var_15_16, var_15_18, var_15_19)
	end

	arg_15_4()

	return
end

function var_0_1.listNotificationInterests(arg_21_0)
	local var_21_0 = {}

	GAME = var_1_10002
	var_21_0[1] = var_1_10002.ACT_NEW_PT_DONE
	GAME = var_2
	var_21_0[2] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_21_0[3] = var_2.SUBMIT_AVATAR_TASK_DONE
	GAME = var_2
	var_21_0[4] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	ActivityProxy = var_2
	var_21_0[5] = var_2.ACTIVITY_SHOW_AWARDS
	ActivityProxy = var_2
	var_21_0[6] = var_2.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_21_0[7] = var_2.ACTIVITY_UPDATED

	return var_21_0
end

function var_0_1.handleNotification(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getName()
	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.getBody(var_22_1)

	GAME = var_22_1

	local var_22_3

	if var_22_0 == var_22_1.ACT_NEW_PT_DONE then
		var_1_10005 = arg_22_0.viewComponent
		var_22_3 = var_22_3.emit
		BaseUI = var_1_10006

		var_22_3(var_1_10005, var_1_10006.ON_ACHIEVE, var_22_2.awards, var_22_2.callback)

		var_1_10005 = arg_22_0.viewComponent

		var_22_3.UpdatePtData(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_3.UpdateMainPt(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_3.SetPtPanel(var_1_10005)

		goto label_22_0
	end

	GAME = var_22_3

	local var_22_4

	if var_22_0 == var_22_3.SUBMIT_TASK_DONE then
		var_1_10005 = arg_22_0.viewComponent
		var_22_4 = var_22_4.emit
		BaseUI = var_1_10006

		var_22_4(var_1_10005, var_1_10006.ON_ACHIEVE, var_22_2)

		var_1_10005 = arg_22_0.viewComponent

		var_22_4.UpdateTaskData(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_4.UpdatePtData(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_4.UpdateMainPt(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_4.SetTaskPanel(var_1_10005)

		var_1_10005 = arg_22_0.viewComponent

		var_22_4.UpdateSpringData(var_1_10005)

		goto label_22_0
	end

	GAME = var_22_4

	if var_22_0 ~= var_22_4.SUBMIT_AVATAR_TASK_DONE then
		GAME = var_22_5

		do
			local var_22_5

			if var_22_0 == var_22_5.SUBMIT_ACTIVITY_TASK_DONE then
				var_1_10005 = arg_22_0.viewComponent
				var_22_5 = var_22_5.emit
				BaseUI = var_1_10006

				var_22_5(var_1_10005, var_1_10006.ON_ACHIEVE, var_22_2.awards)

				var_1_10005 = arg_22_0.viewComponent

				var_22_5.UpdateTaskData(var_1_10005)

				var_1_10005 = arg_22_0.viewComponent

				var_22_5.UpdatePtData(var_1_10005)

				var_1_10005 = arg_22_0.viewComponent

				var_22_5.UpdateMainPt(var_1_10005)

				var_1_10005 = arg_22_0.viewComponent

				var_22_5.SetTaskPanel(var_1_10005)

				var_1_10005 = arg_22_0.viewComponent

				var_22_5.UpdateSpringData(var_1_10005)
			else
				ActivityProxy = var_22_5

				local var_22_6

				if var_22_0 == var_22_5.ACTIVITY_SHOW_AWARDS then
					var_1_10005 = arg_22_0.viewComponent
					var_22_6 = var_22_6.emit
					BaseUI = var_1_10006

					var_22_6(var_1_10005, var_1_10006.ON_ACHIEVE, var_22_2.awards)
				else
					ActivityProxy = var_22_6

					if var_22_0 == var_22_6.ACTIVITY_OPERATION_DONE then
						getProxy = var_4
						ActivityProxy = var_1_10005

						local var_22_7 = var_4(var_1_10005)
						local var_22_8 = var_4.getActivityById(var_22_7, var_22_2)
						local var_22_9 = var_4.getConfig(var_22_8, "type")

						ActivityConst = var_22_8

						if var_22_9 == var_22_8.ACTIVITY_TYPE_HOTSPRING_2 then
							local var_22_10 = arg_22_0.viewComponent

							var_5.UpdateSpringActivityAndUI(var_22_10)
						end
					else
						ActivityProxy = var_4

						if var_22_0 == var_4.ACTIVITY_UPDATED then
							local var_22_11 = var_22_2
							local var_22_12 = var_22_2.getConfig(var_22_11, "type")

							ActivityConst = var_22_11

							if var_22_12 == var_22_11.ACTIVITY_TYPE_PUZZLA then
								local var_22_13 = arg_22_0.viewComponent

								var_4.UpdateFireworkData(var_22_13)

								local var_22_14 = arg_22_0.viewComponent

								var_4.UpdatePtData(var_22_14)

								local var_22_15 = arg_22_0.viewComponent

								var_4.UpdateMainPt(var_22_15)

								local var_22_16 = arg_22_0.viewComponent

								var_4.SetFireWorkPanel(var_22_16)
							else
								local var_22_17 = var_22_2
								local var_22_18 = var_22_2.getConfig(var_22_17, "type")

								ActivityConst = var_22_17

								if var_22_18 == var_22_17.ACTIVITY_TYPE_HOTSPRING_2 then
									local var_22_19 = arg_22_0.viewComponent

									var_4.UpdateSpringActivityAndUI(var_22_19)
								end
							end
						end
					end
				end
			end
		end

		::label_22_0::

		local var_22_20 = arg_22_0.viewComponent

		var_4.SetTips(var_22_20)

		return
	end
end

return var_0_1
