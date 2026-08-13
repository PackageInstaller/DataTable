class = var_0_10000

local var_0_0 = "Dorm3dRTRoleTouchSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0.touchConfigs = {}
	UIItemList = var_1

	local var_1_0 = var_1.New
	local var_1_1 = arg_1_0._tf
	local var_1_2 = arg_1_0._tf

	arg_1_0.uiList = var_1_0(var_1_1, var_3.Find(var_1_2, "tpl"))

	local var_1_3 = arg_1_0.uiList

	var_1.make(var_1_3, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			arg_2_1 = arg_2_1 + 1

			local var_2_0 = arg_1_0.touchConfigs[arg_2_1]

			setText = var_2_10004

			local var_2_1 = arg_2_2:Find("bg/Text")

			if var_2_0.furnitureName then
				i18n = var_2_2

				local var_2_2

				if not var_2_2("dorm3d_touch2", var_2_0.furnitureName) then
					i18n = var_2_2
					var_2_2 = var_2_2("dorm3d_touch")
				end

				var_2_10004(var_2_1, var_2_2)

				onButton = var_2_10004

				local var_2_3 = arg_1_0
				local var_2_4 = arg_2_2

				local function var_2_5()
					getProxy = var_3_10000
					Dorm3dChatProxy = var_3_10001

					local var_3_0 = var_3_10000(var_3_10001)

					var_0.TriggerEvent(var_3_0, {
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
				end

				SFX_DORM_CLICK = var_2_10008

				var_2_10004(var_2_3, var_2_4, var_2_5, var_2_10008)

				return
			end
		end
	end)

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.touchConfigs = arg_4_1:GetAllTouchIDByZone(arg_4_3, arg_4_2)
	arg_4_0.cacheGroupId = arg_4_2

	local var_4_0 = arg_4_0.uiList

	var_4.align(var_4_0, #arg_4_0.touchConfigs)

	return
end

return var_0_1
