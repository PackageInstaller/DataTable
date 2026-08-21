local var_0_0 = class("SuperBulinPopView", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SuperBulinPopView"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.bulinAnim = arg_2_0._tf:Find("Bulin"):GetComponent("SpineAnimUI")

	arg_2_0.bulinAnim:SetActionCallBack(nil)
	onButton(arg_2_0, arg_2_0._tf, function()
		seriesAsync({
			function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("super_bulin"),
					onYes = arg_4_0,
					onNo = function()
						arg_2_0:closeView()

						return
					end
				})

				return
			end,
			function(arg_6_0)
				local var_6_0 = arg_2_0.contextData.actId

				arg_2_0:closeView()
				pg.m02:sendNotification(GAME.BEGIN_STAGE, {
					warnMsg = "bulin_tip_other3",
					system = SYSTEM_SIMULATION,
					stageId = arg_2_0.contextData.stageId,
					exitCallback = function()
						local var_7_0 = getProxy(ActivityProxy)
						local var_7_1 = var_7_0:getActivityById(var_6_0)

						if var_7_1.data1 == 2 then
							return
						end

						var_7_1.data3 = 1

						var_7_0:updateActivity(var_7_1)

						return
					end
				})

				return
			end
		})

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.willExit(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf)

	return
end

return var_0_0
