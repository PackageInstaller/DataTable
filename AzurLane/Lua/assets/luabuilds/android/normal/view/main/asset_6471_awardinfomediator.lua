class = var_0_10000

local var_0_0 = "AwardInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_DROP = "AwardInfoMediator:ON_DROP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DROP, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_2_1.type

		DROP_TYPE_EQUIP = var_2_10004

		if var_2_0 == var_2_10004 then
			var_2_10004 = arg_1_0

			local var_2_1 = var_3.addSubLayers

			Context = var_2_10005
			var_2_10005 = var_2_10005.New
			var_2_10006 = {}
			EquipmentInfoMediator = var_2_10007
			var_2_10006.mediator = var_2_10007
			EquipmentInfoLayer = var_2_10007
			var_2_10006.viewComponent = var_2_10007
			var_2_10007 = {
				equipmentId = arg_2_1:getConfig("id")
			}
			EquipmentInfoMediator = var_8
			var_2_10007.type = var_8.TYPE_DISPLAY
			var_2_10007.onRemoved = arg_2_2
			var_2_10006.data = var_2_10007

			var_2_1(var_2_10004, var_2_10005(var_2_10006))
		else
			local var_2_2 = arg_2_1.type

			DROP_TYPE_SPWEAPON = var_2_10004

			if var_2_2 == var_2_10004 then
				local var_2_3 = arg_1_0

				var_2_2 = var_2_2.addSubLayers
				Context = var_2_10005

				local var_2_4 = var_2_10005.New

				var_2_10006 = {}
				SpWeaponInfoMediator = var_2_10007
				var_2_10006.mediator = var_2_10007
				SpWeaponInfoLayer = var_2_10007
				var_2_10006.viewComponent = var_2_10007

				local var_2_5 = {
					spWeaponConfigId = arg_2_1:getConfig("id")
				}

				SpWeaponInfoLayer = var_8
				var_2_5.type = var_8.TYPE_DISPLAY
				var_2_5.onRemoved = arg_2_2
				var_2_10006.data = var_2_5

				var_2_2(var_2_3, var_2_4(var_2_10006))
			else
				pg = var_2_2

				local var_2_6 = var_2_2.MsgboxMgr.GetInstance()
				local var_2_7 = var_3.ShowMsgBox
				local var_2_8 = {}

				MSGBOX_TYPE_SINGLE_ITEM = var_2_10006
				var_2_8.type = var_2_10006
				var_2_8.drop = arg_2_1
				var_2_8.onNo = arg_2_2
				var_2_8.onYes = arg_2_2

				var_2_7(var_2_6, var_2_8)
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
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 ~= var_4_1.STORY_BEGIN then
		GAME = var_4

		if var_4_0 == var_4.STORY_NEXT then
			local var_4_3 = arg_4_0.viewComponent

			var_4.ShowOrHideSpriteMask(var_4_3, false)
		else
			GAME = var_4

			if var_4_0 == var_4.STORY_END then
				local var_4_4 = arg_4_0.viewComponent

				var_4.ShowOrHideSpriteMask(var_4_4, true)
			end
		end

		return
	end
end

return var_0_1
