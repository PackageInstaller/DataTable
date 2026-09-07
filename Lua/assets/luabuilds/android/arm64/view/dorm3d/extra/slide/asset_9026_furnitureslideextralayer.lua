local FurnitureSlideExtraLayer = class("FurnitureSlideExtraLayer", import("view.base.BaseUI"))

function FurnitureSlideExtraLayer:getUIName()
	return "Dorm3dFurnitureSlideExtraUI"
end

function FurnitureSlideExtraLayer:init()
	self.slideList = ApartmentProxy.GetSlideInviteList()

	self:InitUI()

	return
end

function FurnitureSlideExtraLayer:InitUI()
	self.queuePanel = self._tf:Find("top")
	self.performancePanel = self._tf:Find("performance")
	self.queueContainer = self._tf:Find("top/bg/container")
	self.performanceContainer = self._tf:Find("performance/line/container")

	setText(self._tf:Find("top/bg/Text"), i18n("3ddorm_beach_slide_tip2"))
	setText(self._tf:Find("performance/btn_invite/Text"), i18n("3ddorm_beach_slide_tip1"))

	self.queueItemList = UIItemList.New(self.queueContainer, self.queueContainer:Find("tpl"))
	self.performanceItemList = UIItemList.New(self.performanceContainer, self.performanceContainer:Find("tpl"))

	self.queueItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_1 + 1 > #self.slideList

		setActive(arg_4_2:Find("icon"), not (arg_4_1 + 1 > #self.slideList))
		setActive(arg_4_2:Find("front"), not var_4_0)
		setActive(arg_4_2:Find("plus"), var_4_0)

		if not var_4_0 then
			GetImageSpriteFromAtlasAsync(pg.dorm3d_resource[pg.dorm3d_resource.get_id_list_by_ship_group[self.slideList[arg_4_1 + 1]][2]].head_Icon, "", arg_4_2:Find("icon"), true)
		end

		return
	end)
	self.performanceItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = self.slideList[arg_5_1 + 1]

		if arg_5_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync(pg.dorm3d_resource[pg.dorm3d_resource.get_id_list_by_ship_group[self.slideList[arg_5_1 + 1]][2]].head_Icon, "", arg_5_2:Find("icon"), true)
			setText(arg_5_2:Find("name"), ShipGroup.getDefaultShipNameByGroupID(self.slideList[arg_5_1 + 1]))
			onButton(self, arg_5_2, function()
				self:emit(FurnitureSlideExtraMediator.GO_SLIDE_PERFORMANCE, var_5_0)

				return
			end, SFX_DORM_CLICK)
		end

		return
	end)
	onButton(self, self._tf:Find("top/bg"), function()
		self:emit(FurnitureSlideExtraMediator.OPEN_INVITE_LAYER, self.slideList)

		return
	end, SFX_DORM_CLICK)

	return
end

function FurnitureSlideExtraLayer:didEnter()
	self:HideInteraction()
	self:HidePerformance()

	return
end

function FurnitureSlideExtraLayer:UpdateSlideInviteList(arg_9_1, arg_9_2, arg_9_3)
	self.slideList = arg_9_1

	self:Flush()

	return
end

function FurnitureSlideExtraLayer:Flush()
	self.queueItemList:align(#self.slideList + 1)
	self.performanceItemList:align(#self.slideList)

	return
end

function FurnitureSlideExtraLayer:HandleDormUIState(arg_11_1)
	setActive(self._tf, arg_11_1 == "base")

	return
end

function FurnitureSlideExtraLayer:ShowInteraction()
	setActive(self.queuePanel, true)
	self.queueItemList:align(#self.slideList + 1)

	return
end

function FurnitureSlideExtraLayer:HideInteraction()
	setActive(self.queuePanel, false)

	return
end

function FurnitureSlideExtraLayer:ShowPerformance()
	setActive(self.performancePanel, true)
	self.performanceItemList:align(#self.slideList)

	return
end

function FurnitureSlideExtraLayer:HidePerformance()
	setActive(self.performancePanel, false)

	return
end

function FurnitureSlideExtraLayer:willExit()
	return
end

return FurnitureSlideExtraLayer
