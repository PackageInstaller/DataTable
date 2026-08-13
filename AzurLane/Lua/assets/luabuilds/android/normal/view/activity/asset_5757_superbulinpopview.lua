class = var_0_10000

local var_0_0 = "SuperBulinPopView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SuperBulinPopView"
end

function var_0_1.didEnter(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Bulin")

	arg_2_0.bulinAnim = var_1.GetComponent(var_2_1, "SpineAnimUI")

	local var_2_2 = arg_2_0.bulinAnim

	var_1.SetActionCallBack(var_2_2, nil)

	onButton = var_1

	var_1(arg_2_0, arg_2_0._tf, function()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_4_0)
				pg = var_3_10001

				local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_4_1 = var_1.ShowMsgBox
				local var_4_2 = {}

				i18n = var_3_10004
				var_4_2.content = var_3_10004("super_bulin")
				var_4_2.onYes = arg_4_0

				function var_4_2.onNo()
					local var_5_0 = arg_2_0

					var_0.closeView(var_5_0)

					return
				end

				var_4_1(var_4_0, var_4_2)

				return
			end,
			function(arg_6_0)
				local var_6_0 = arg_2_0.contextData.actId
				local var_6_1 = arg_2_0.contextData.stageId
				local var_6_2 = arg_2_0

				var_3.closeView(var_6_2)

				pg = var_3

				local var_6_3 = var_3.m02
				local var_6_4 = var_3.sendNotification

				GAME = var_3_10005

				local var_6_5 = var_3_10005.BEGIN_STAGE
				local var_6_6 = {
					warnMsg = "bulin_tip_other3"
				}

				SYSTEM_SIMULATION = var_3_10007
				var_6_6.system = var_3_10007
				var_6_6.stageId = var_6_1

				function var_6_6.exitCallback()
					getProxy = var_4_10000
					ActivityProxy = var_4_10001

					local var_7_0 = var_4_10000(var_4_10001)

					if var_0.getActivityById(var_7_0, var_6_0).data1 == 2 then
						return
					end

					var_1.data3 = 1

					var_0:updateActivity(var_1)

					return
				end

				var_6_4(var_6_3, var_6_5, var_6_6)

				return
			end
		})

		return
	end)

	pg = var_1

	local var_2_3 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_3, arg_2_0._tf)

	return
end

function var_0_1.willExit(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf)

	return
end

return var_0_1
