class = var_0_10000

local var_0_0 = "ResolveEquipmentMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_RESOLVE = "ResolveEquipmentMediator:ON_RESOLVE"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_RESOLVE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.DESTROY_EQUIPMENTS, {
			equipments = arg_2_1
		})

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_3, var_1_2)

	local var_1_4 = arg_1_0.contextData.Equipments

	assert = var_1_1

	var_1_1(var_1_4, "equipmentVOs can not be nil")

	local var_1_5 = arg_1_0.viewComponent

	var_3.setEquipments(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.DESTROY_EQUIPMENTS_DONE
	GAME = var_2
	var_3_0[2] = var_2.CANCEL_LIMITED_OPERATION

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.DESTROY_EQUIPMENTS_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.HideDestroyCondirm(var_4_3)

		getProxy = var_4
		ContextProxy = var_4_3

		local var_4_4 = var_4(var_4_3)

		if var_4.getCurrentContext(var_4_4) and var_4.mediator.__cname ~= "EquipmentMediator" then
			table = var_5

			if var_5.getCount(var_4_2) ~= 0 then
				local var_4_5 = arg_4_0.viewComponent
				local var_4_6 = var_5.emit

				BaseUI = var_1_10008

				local var_4_7 = var_1_10008.ON_AWARD
				local var_4_8 = {
					items = var_4_2
				}

				AwardInfoLayer = var_1_10010
				var_4_8.title = var_1_10010.TITLE.ITEM

				function var_4_8.removeFunc()
					local var_5_0 = arg_4_0.viewComponent

					var_0.OnResolveEquipDone(var_5_0)

					return
				end

				var_4_6(var_4_5, var_4_7, var_4_8)

				goto label_4_0
			end
		end

		local var_4_9 = arg_4_0.viewComponent

		var_5.OnResolveEquipDone(var_4_9)
	else
		GAME = var_4

		if var_4_1 == var_4.CANCEL_LIMITED_OPERATION then
			-- block empty
		end
	end

	::label_4_0::

	return
end

return var_0_1
