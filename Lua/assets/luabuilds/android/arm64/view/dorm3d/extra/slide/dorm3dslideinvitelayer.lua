local var_0_0 = class("Dorm3dSlideInviteLayer", import("view.dorm3d.Dorm3dInviteLayer"))

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)
	setText(arg_1_0.rtSelectPanel:Find("window/title/Text"), i18n("3ddorm_beach_slide_tip4"))
	setText(arg_1_0.rtSelectPanel:Find("window/character/title"), i18n("3ddorm_beach_slide_tip5"))

	arg_1_0.selectCountTip = i18n("3ddorm_beach_slide_tip6")

	GetImageSpriteFromAtlasAsync("ui/3dd_select_atlas", "title_slide", arg_1_0.rtInvitePanel:Find("window/title"))

	return
end

function var_0_0.ShowInvitePanel(arg_2_0)
	var_0_0.super.ShowInvitePanel(arg_2_0)
	GetImageSpriteFromAtlasAsync("dorm3dselect/slide_invite", "", arg_2_0.rtInvitePanel:Find("window/Image"))
	setText(arg_2_0.rtInvitePanel:Find("window/Text"), i18n("dorm3d_data_go", i18n("3ddorm_beach_slide_tip3")))
	onButton(arg_2_0, arg_2_0.rtInvitePanel:Find("window/btn_confirm"), function()
		if #arg_2_0.selectIds >= 3 and not ApartmentProxy.CheckDeviceRAMEnough() then
			table.insert({}, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("drom3d_beach_memory_limit_tip"),
					onYes = arg_4_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_5_0 = getProxy(ApartmentProxy)
			local var_5_1 = ApartmentProxy.GetRoomInviteList(arg_2_0.contextData.roomId)
			local var_5_2, var_5_3, var_5_4 = table.Diff(var_5_1, arg_2_0.selectIds)
			local var_5_5 = arg_2_0.selectIds

			if #var_5_3 > 0 then
				var_5_0:SetRoomInviteList(arg_2_0.contextData.roomId, table.mergeArray(var_5_1, var_5_3), function()
					var_5_0:SetSlideInviteList(var_5_5)

					return
				end)
			else
				var_5_0:SetSlideInviteList(arg_2_0.selectIds)
			end

			arg_2_0:closeView()

			return
		end)

		return
	end, SFX_DORM_CLICK)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0.selectIds = arg_7_0.contextData.groupIds

	arg_7_0:ShowInvitePanel()

	return
end

return var_0_0
