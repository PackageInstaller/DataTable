class = var_0_10000

local var_0_0 = "AwardInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_DROP = "AwardInfoMediator:ON_DROP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DROP, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_2_1.type

		DROP_TYPE_EQUIP = var_2_10004

		if var_2_0 == var_2_10004 then
			local var_2_1 = arg_1_0
			local var_2_2 = var_3.addSubLayers

			Context = var_2_10006
			var_2_10006 = var_2_10006.New

			local var_2_3 = {}

			EquipmentInfoMediator = var_2_10009
			var_2_3.mediator = var_2_10009
			EquipmentInfoLayer = var_2_10009
			var_2_3.viewComponent = var_2_10009
			var_2_10009 = {
				equipmentId = arg_2_1:getConfig("id")
			}
			EquipmentInfoMediator = var_10
			var_2_10009.type = var_10.TYPE_DISPLAY
			var_2_10009.onRemoved = arg_2_2
			var_2_3.data = var_2_10009

			var_2_2(var_2_1, var_2_10006(var_2_3))
		else
			local var_2_4 = arg_2_1.type

			DROP_TYPE_SPWEAPON = var_2_10004

			if var_2_4 == var_2_10004 then
				local var_2_5 = arg_1_0

				var_2_4 = var_2_4.addSubLayers
				Context = var_2_10006

				local var_2_6 = var_2_10006.New
				local var_2_7 = {}

				SpWeaponInfoMediator = var_2_10009
				var_2_7.mediator = var_2_10009
				SpWeaponInfoLayer = var_2_10009
				var_2_7.viewComponent = var_2_10009

				local var_2_8 = {
					spWeaponConfigId = arg_2_1:getConfig("id")
				}

				SpWeaponInfoLayer = var_10
				var_2_8.type = var_10.TYPE_DISPLAY
				var_2_8.onRemoved = arg_2_2
				var_2_7.data = var_2_8

				var_2_4(var_2_5, var_2_6(var_2_7))
			else
				pg = var_2_4

				local var_2_9 = var_2_4.MsgboxMgr.GetInstance()
				local var_2_10 = var_3.ShowMsgBox
				local var_2_11 = {}

				MSGBOX_TYPE_SINGLE_ITEM = var_2_10007
				var_2_11.type = var_2_10007
				var_2_11.drop = arg_2_1
				var_2_11.onNo = arg_2_2
				var_2_11.onYes = arg_2_2

				var_2_10(var_2_9, var_2_11)
			end
		end

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.STORY_BEGIN
	GAME = var_2
	var_3_0[2] = var_2.STORY_END
	GAME = var_2
	var_3_0[3] = var_2.STORY_NEXT

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 ~= var_4_0.STORY_BEGIN then
		GAME = var_4

		if var_4_1 == var_4.STORY_NEXT then
			local var_4_3 = arg_4_0.viewComponent

			var_4.ShowOrHideSpriteMask(var_4_3, false)
		else
			GAME = var_4

			if var_4_1 == var_4.STORY_END then
				local var_4_4 = arg_4_0.viewComponent

				var_4.ShowOrHideSpriteMask(var_4_4, true)
			end
		end

		return
	end
end

return var_0_1
