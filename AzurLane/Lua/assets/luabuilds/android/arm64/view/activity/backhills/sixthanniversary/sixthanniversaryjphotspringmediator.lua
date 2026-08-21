local var_0_0 = class("SixthAnniversaryJPHotSpringMediator", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0, var_2_1 = arg_1_0.activity:GetUpgradeCost()

		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_NORMAL,
			content = i18n("jp6th_spring_tip1", var_2_1),
			contextSprites = {
				{
					path = "props/wenquanshoupai",
					name = "wenquanshoupai"
				}
			},
			onYes = function()
				if arg_1_0.activity:GetCoins() < var_2_1 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_spring_tip2"))

					return
				end

				arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
					activity_id = arg_2_1,
					cmd = SpringActivity.OPERATION_UNLOCK
				})

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:OnSelShips(arg_4_1, arg_4_2)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	arg_1_0.activity = var_1_0

	arg_1_0.viewComponent:SetActivity(var_1_0)
	arg_1_0:bind(var_0_0.OPEN_INFO, function()
		arg_1_0:addSubLayers(Context.New({
			mediator = NewYearHotSpringShipSelectMediator,
			viewComponent = NewYearHotSpringShipSelectLayer,
			data = {
				actId = var_1_0.id
			}
		}))

		return
	end)

	return
end

return var_0_0
