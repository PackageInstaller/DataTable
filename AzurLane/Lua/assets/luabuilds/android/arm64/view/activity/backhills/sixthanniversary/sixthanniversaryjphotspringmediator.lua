class = var_0_10000

local var_0_0 = "SixthAnniversaryJPHotSpringMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.NewYearFestival.NewYearHotSpringMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.activity
		local var_2_1, var_2_2 = var_2.GetUpgradeCost(var_2_0)

		MsgboxMediator = var_2_0

		local var_2_3 = var_2_0.ShowMsgBox
		local var_2_4 = {}

		MSGBOX_TYPE_NORMAL = var_2_10007
		var_2_4.type = var_2_10007
		i18n = var_2_10007
		var_2_4.content = var_2_10007("jp6th_spring_tip1", var_2_2)
		var_2_4.contextSprites = {
			{
				path = "props/wenquanshoupai",
				name = "wenquanshoupai"
			}
		}

		function var_2_4.onYes()
			local var_3_0 = arg_1_0.activity

			if var_0.GetCoins(var_3_0) < var_2_2 then
				pg = var_1

				local var_3_1 = var_1.TipsMgr.GetInstance()
				local var_3_2 = var_1.ShowTips

				i18n = var_3_10004

				var_3_2(var_3_1, var_3_10004("jp6th_spring_tip2"))

				return
			end

			local var_3_3 = arg_1_0
			local var_3_4 = var_1.sendNotification

			GAME = var_3_10004

			local var_3_5 = var_3_10004.ACTIVITY_OPERATION
			local var_3_6 = {
				activity_id = arg_2_1
			}

			SpringActivity = var_6
			var_3_6.cmd = var_6.OPERATION_UNLOCK

			var_3_4(var_3_3, var_3_5, var_3_6)

			return
		end

		var_2_3(var_2_4)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.OnSelShips(var_4_0, arg_4_1, arg_4_2)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4
	arg_1_0.activity = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_HOTSPRING)

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1)
	arg_1_0:bind(var_0_1.OPEN_INFO, function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_5_2 = var_2_10003.New
		local var_5_3 = {}

		NewYearHotSpringShipSelectMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		NewYearHotSpringShipSelectLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {
			actId = var_0.id
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

return var_0_1
