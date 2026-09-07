local Dorm3dAccompanyLayer = class("Dorm3dAccompanyLayer", import("view.base.BaseUI"))

function Dorm3dAccompanyLayer:getUIName()
	return "Dorm3dAccompanyWindow"
end

function Dorm3dAccompanyLayer:init()
	self.rtPanel = self._tf:Find("panel")

	onButton(self, self.rtPanel:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtPanel:Find("window/btn_close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.richText = self.rtPanel:Find("window/Text"):GetComponent("RichText")

	self.richText:AddSprite("stamina", self._tf:Find("res/stamina"):GetComponent(typeof(Image)).sprite)

	return
end

function Dorm3dAccompanyLayer:HideInvitePanel()
	self.selectIds = nil

	setActive(self.rtPanel, false)

	return
end

function Dorm3dAccompanyLayer:didEnter()
	self.room = getProxy(ApartmentProxy):getRoom(self.contextData.roomId)

	local var_6_0 = pg.dorm3d_accompany.get_id_list_by_ship_id[self.contextData.groupId]
	local var_6_1 = self.rtPanel:Find("window/content")

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
				onButton(self, arg_7_2:Find("Image"), function()
					if not var_7_1 then
						pg.TipsMgr.GetInstance():ShowTips(var_7_2)
					elseif var_7_3:needDownload() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_accompany_not_download", var_7_3:getConfig("room")))
					else
						self.contextData.confirmFunc(var_7_0)
						self:closeView()
					end

					return
				end, SFX_CONFIRM)
				setText(self.rtPanel:Find("window/Text"), i18n("dorm3d_collection_cost_tip"))
			else
				setText(arg_7_2:Find("empty/Image/Text"), i18n("dorm3d_accompany_locked"))
			end
		end

		return
	end)
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)

	return
end

function Dorm3dAccompanyLayer:willExit()
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtPanel, self.rtLayer)

	return
end

return Dorm3dAccompanyLayer
