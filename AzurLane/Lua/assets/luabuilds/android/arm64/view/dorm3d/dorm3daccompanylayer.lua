local var_0_0 = class("Dorm3dAccompanyLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dAccompanyWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtPanel = arg_2_0._tf:Find("panel")

	onButton(arg_2_0, arg_2_0.rtPanel:Find("bg"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.rtPanel:Find("window/btn_close"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)

	arg_2_0.richText = arg_2_0.rtPanel:Find("window/Text"):GetComponent("RichText")

	arg_2_0.richText:AddSprite("stamina", arg_2_0._tf:Find("res/stamina"):GetComponent(typeof(Image)).sprite)

	return
end

function var_0_0.HideInvitePanel(arg_5_0)
	arg_5_0.selectIds = nil

	setActive(arg_5_0.rtPanel, false)

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0.room = getProxy(ApartmentProxy):getRoom(arg_6_0.contextData.roomId)

	local var_6_0 = pg.dorm3d_accompany.get_id_list_by_ship_id[arg_6_0.contextData.groupId]
	local var_6_1 = arg_6_0.rtPanel:Find("window/content")

	UIItemList.StaticAlign(var_6_1, var_6_1:GetChild(0), 3, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = var_6_0[arg_7_1]

			setActive(arg_7_2:Find("empty"), not var_6_0[arg_7_1])
			setActive(arg_7_2:Find("Image"), var_6_0[arg_7_1])

			if var_6_0[arg_7_1] then
				local var_7_1, var_7_2 = ApartmentProxy.CheckUnlockConfig(pg.dorm3d_accompany[var_6_0[arg_7_1]].unlock)
				local var_7_3 = getProxy(ApartmentProxy):getRoom(pg.dorm3d_accompany[var_6_0[arg_7_1]].resource_room)

				GetImageSpriteFromAtlasAsync("dorm3daccompany/" .. pg.dorm3d_accompany[var_6_0[arg_7_1]].image, "", arg_7_2:Find("Image"))
				setGray(arg_7_2:Find("Image"), not var_7_1, false)
				setActive(arg_7_2:Find("Image/mask"), not var_7_1)
				onButton(arg_6_0, arg_7_2:Find("Image"), function()
					if not var_7_1 then
						pg.TipsMgr.GetInstance():ShowTips(var_7_2)
					elseif var_7_3:needDownload() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_accompany_not_download", var_7_3:getConfig("room")))
					else
						arg_6_0.contextData.confirmFunc(var_7_0)
						arg_6_0:closeView()
					end

					return
				end, SFX_CONFIRM)
				setText(arg_6_0.rtPanel:Find("window/Text"), i18n("dorm3d_collection_cost_tip"))
			else
				setText(arg_7_2:Find("empty/Image/Text"), i18n("dorm3d_accompany_locked"))
			end
		end

		return
	end)
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)

	return
end

function var_0_0.willExit(arg_9_0)
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.rtPanel, arg_9_0.rtLayer)

	return
end

return var_0_0
