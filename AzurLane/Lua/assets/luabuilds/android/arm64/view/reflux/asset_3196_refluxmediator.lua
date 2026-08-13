class = var_0_10000

local var_0_0 = "RefluxMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OnTaskSubmit = "RefluxMediator.OnTaskSubmit"
var_0_1.OnTaskGo = "RefluxMediator.OnTaskGo"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "RefluxMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_1.OPEN_CHARGE_ITEM_BOX = "RefluxMediator:OPEN_CHARGE_ITEM_BOX"
var_0_1.OPEN_CHARGE_BIRTHDAY = "RefluxMediator:OPEN_CHARGE_BIRTHDAY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnTaskSubmit, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SUBMIT_TASK, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.OnTaskGo, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		ChargeItemPanelMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		ChargeItemPanelLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			panelConfig = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_BOX, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		ChargeItemBoxMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		ChargeItemBoxLayer = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = {
			panelConfig = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_6_2 = var_2_10005.New
		local var_6_3 = {}

		ChargeBirthdayMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		ChargeBirthdayLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008
		var_6_3.data = {}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.REFLUX_SIGN_DONE
	GAME = var_2
	var_7_0[2] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_7_0[3] = var_2.REFLUX_GET_PT_AWARD_DONE
	TaskProxy = var_2
	var_7_0[4] = var_2.TASK_UPDATED
	TaskProxy = var_2
	var_7_0[5] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_7_0[6] = var_2.TASK_DELETE
	GAME = var_2
	var_7_0[7] = var_2.SHOPPING_DONE
	GAME = var_2
	var_7_0[8] = var_2.CHARGE_CONFIRM_FAILED
	GAME = var_2
	var_7_0[9] = var_2.CHARGED_LIST_UPDATED
	GAME = var_2
	var_7_0[10] = var_2.ZERO_HOUR_OP_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GAME = var_8_0

	local var_8_5

	if var_8_1 == var_8_0.REFLUX_SIGN_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.signView) then
			local var_8_3 = arg_8_0.viewComponent.signView

			var_8_5.updateUI(var_8_3)

			local var_8_4 = arg_8_0.viewComponent

			var_8_5 = var_8_5.emit
			BaseUI = var_7

			var_8_5(var_8_4, var_7.ON_ACHIEVE, var_8_2.awards)
		end

		local var_8_6 = arg_8_0.viewComponent

		var_8_5.updateRedPotList(var_8_6)

		goto label_8_0
	end

	GAME = var_8_5

	local var_8_7

	if var_8_1 == var_8_5.SUBMIT_TASK_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.taskView) then
			var_8_7 = #var_8_2

			if 0 < var_8_7 then
				local var_8_8 = arg_8_0.viewComponent.taskView

				var_8_7 = var_8_7.calcLastSubmitTaskPT(var_8_8)
				table = var_5

				var_5.insert(var_8_2, var_8_7)

				local var_8_9 = arg_8_0.viewComponent
				local var_8_10 = var_5.emit

				BaseUI = var_8

				var_8_10(var_8_9, var_8.ON_ACHIEVE, var_8_2)
			end
		end

		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.ptView) then
			local var_8_11 = arg_8_0.viewComponent.ptView

			var_8_7.updateUI(var_8_11)
		end

		local var_8_12 = arg_8_0.viewComponent

		var_8_7.updateRedPotList(var_8_12)

		goto label_8_0
	end

	TaskProxy = var_8_7

	if var_8_1 ~= var_8_7.TASK_UPDATED then
		TaskProxy = var_4

		if var_8_1 ~= var_4.TASK_REMOVED then
			TaskProxy = var_4

			if var_8_1 == var_4.TASK_DELETE then
				if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.taskView) then
					local var_8_13 = arg_8_0.viewComponent.taskView

					var_4.updateUI(var_8_13)
				end

				local var_8_14 = arg_8_0.viewComponent

				var_4.updateRedPotList(var_8_14)
			else
				GAME = var_4

				local var_8_16

				if var_8_1 == var_4.REFLUX_GET_PT_AWARD_DONE then
					if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.ptView) then
						local var_8_15 = arg_8_0.viewComponent

						var_8_16 = var_8_16.emit
						BaseUI = var_7

						var_8_16(var_8_15, var_7.ON_ACHIEVE, var_8_2.awards)

						local var_8_17 = arg_8_0.viewComponent.ptView

						var_8_16.updateAfterServer(var_8_17)
					end

					local var_8_18 = arg_8_0.viewComponent

					var_8_16.updateRedPotList(var_8_18)
				else
					GAME = var_8_16

					local var_8_20

					if var_8_1 == var_8_16.SHOPPING_DONE then
						if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.shopView) then
							local var_8_19 = arg_8_0.viewComponent

							var_8_20 = var_8_20.emit
							BaseUI = var_7

							var_8_20(var_8_19, var_7.ON_ACHIEVE, var_8_2.awards)

							local var_8_21 = arg_8_0.viewComponent.shopView

							var_8_20.updateUI(var_8_21)
						end
					else
						GAME = var_8_20

						if var_8_1 == var_8_20.CHARGE_CONFIRM_FAILED then
							-- block empty
						else
							GAME = var_4

							if var_8_1 == var_4.CHARGED_LIST_UPDATED then
								if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.shopView) then
									local var_8_22 = arg_8_0.viewComponent.shopView

									var_4.updateUI(var_8_22)
								end
							else
								GAME = var_4

								if var_8_1 == var_4.ZERO_HOUR_OP_DONE then
									local var_8_23 = arg_8_0.viewComponent

									var_4.closeView(var_8_23)
								end
							end
						end
					end
				end
			end

			::label_8_0::

			return
		end
	end
end

function var_0_1.isCanUpdateView(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1:GetLoaded() then
		return true
	else
		return false
	end

	return
end

return var_0_1
