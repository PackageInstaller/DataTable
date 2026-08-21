local var_0_0 = class("Dorm3dRTRoleTouchSubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0.touchConfigs = {}
	arg_1_0.uiList = UIItemList.New(arg_1_0._tf, arg_1_0._tf:Find("tpl"))

	arg_1_0.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_2_1 = arg_2_1 + 1

			local var_2_0 = arg_1_0.touchConfigs[arg_2_1]
			local var_2_1 = arg_1_0.touchConfigs[arg_2_1].furnitureName and i18n("dorm3d_touch2", arg_1_0.touchConfigs[arg_2_1].furnitureName) or i18n("dorm3d_touch")

			setText(arg_2_2:Find("bg/Text"), var_2_1)
			onButton(arg_1_0, arg_2_2, function()
				getProxy(Dorm3dChatProxy):TriggerEvent({
					{
						value = 1,
						event_type = arg_1_0.contextData.timeIndex == 1 and 111 or 116,
						ship_id = arg_1_0.cacheGroupId
					},
					{
						value = 1,
						event_type = 156,
						ship_id = arg_1_0.cacheGroupId
					}
				})
				arg_1_0.contextData.onClick(var_2_0.touchId)

				return
			end, SFX_DORM_CLICK)
		end

		return
	end)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.touchConfigs = arg_4_1:GetAllTouchIDByZone(arg_4_3, arg_4_2)
	arg_4_0.cacheGroupId = arg_4_2

	arg_4_0.uiList:align(#arg_4_0.touchConfigs)

	return
end

return var_0_0
