local Dorm3dSlideInviteLayer = class("Dorm3dSlideInviteLayer", import("view.dorm3d.Dorm3dInviteLayer"))

function Dorm3dSlideInviteLayer:init()
	Dorm3dSlideInviteLayer.super.init(self)
	setText(self.rtSelectPanel:Find("window/title/Text"), i18n("3ddorm_beach_slide_tip4"))
	setText(self.rtSelectPanel:Find("window/character/title"), i18n("3ddorm_beach_slide_tip5"))

	self.selectCountTip = i18n("3ddorm_beach_slide_tip6")

	GetImageSpriteFromAtlasAsync("ui/3dd_select_atlas", "title_slide", self.rtInvitePanel:Find("window/title"))

	return
end

function Dorm3dSlideInviteLayer:ShowInvitePanel()
	Dorm3dSlideInviteLayer.super.ShowInvitePanel(self)
	GetImageSpriteFromAtlasAsync("dorm3dselect/slide_invite", "", self.rtInvitePanel:Find("window/Image"))
	setText(self.rtInvitePanel:Find("window/Text"), i18n("dorm3d_data_go", i18n("3ddorm_beach_slide_tip3")))
	onButton(self, self.rtInvitePanel:Find("window/btn_confirm"), function()
		local var_3_0 = {}

		if #self.selectIds >= 3 and not ApartmentProxy.CheckDeviceRAMEnough() then
			table.insert(var_3_0, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("drom3d_beach_memory_limit_tip"),
					onYes = arg_4_0
				})

				return
			end)
		end

		seriesAsync(var_3_0, function()
			local var_5_0 = getProxy(ApartmentProxy)
			local var_5_1 = ApartmentProxy.GetRoomInviteList(self.contextData.roomId)
			local var_5_2, var_5_3, var_5_4 = table.Diff(var_5_1, self.selectIds)
			local var_5_5 = self.selectIds

			if #var_5_3 > 0 then
				var_5_0:SetRoomInviteList(self.contextData.roomId, table.mergeArray(var_5_1, var_5_3), function()
					var_5_0:SetSlideInviteList(var_5_5)

					return
				end)
			else
				var_5_0:SetSlideInviteList(self.selectIds)
			end

			self:closeView()

			return
		end)

		return
	end, SFX_DORM_CLICK)

	return
end

function Dorm3dSlideInviteLayer:didEnter()
	self.selectIds = self.contextData.groupIds

	self:ShowInvitePanel()

	return
end

return Dorm3dSlideInviteLayer
