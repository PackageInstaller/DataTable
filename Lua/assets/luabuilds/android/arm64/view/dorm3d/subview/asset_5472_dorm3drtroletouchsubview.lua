local Dorm3dRTRoleTouchSubView = class("Dorm3dRTRoleTouchSubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function Dorm3dRTRoleTouchSubView:Init()
	self.touchConfigs = {}
	self.uiList = UIItemList.New(self._tf, self._tf:Find("tpl"))

	self.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_2_1 = arg_2_1 + 1

			local var_2_0 = self.touchConfigs[arg_2_1]

			setText(arg_2_2:Find("bg/Text"), self.touchConfigs[arg_2_1].furnitureName and i18n("dorm3d_touch2", self.touchConfigs[arg_2_1].furnitureName) or i18n("dorm3d_touch"))
			onButton(self, arg_2_2, function()
				getProxy(Dorm3dChatProxy):TriggerEvent({
					{
						value = 1,
						event_type = self.contextData.timeIndex == 1 and 111 or 116,
						ship_id = self.cacheGroupId
					},
					{
						value = 1,
						event_type = 156,
						ship_id = self.cacheGroupId
					}
				})
				self.contextData.onClick(var_2_0.touchId)

				return
			end, SFX_DORM_CLICK)
		end

		return
	end)

	return
end

function Dorm3dRTRoleTouchSubView:Flush(arg_4_1, arg_4_2, arg_4_3)
	self.touchConfigs = arg_4_1:GetAllTouchIDByZone(arg_4_3, arg_4_2)
	self.cacheGroupId = arg_4_2

	self.uiList:align(#self.touchConfigs)

	return
end

return Dorm3dRTRoleTouchSubView
