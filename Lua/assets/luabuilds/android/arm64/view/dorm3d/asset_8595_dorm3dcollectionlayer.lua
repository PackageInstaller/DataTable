local Dorm3dCollectionLayer = class("Dorm3dCollectionLayer", import("view.base.BaseUI"))

function Dorm3dCollectionLayer:getUIName()
	return "Dorm3dCollectionUI"
end

function Dorm3dCollectionLayer:SetApartment(arg_2_1)
	self.contextData.apartment = arg_2_1

	return
end

function Dorm3dCollectionLayer:SetRoom(arg_3_1)
	self.room = getProxy(ApartmentProxy):getRoom(arg_3_1)

	return
end

function Dorm3dCollectionLayer:init()
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_PANEL)

	local var_4_0 = self._tf:Find("window")

	eachChild(var_4_0:Find("toggles"), function(arg_6_0)
		onToggle(self, arg_6_0, function(arg_7_0)
			if arg_7_0 then
				self:SetPage(arg_6_0.name)
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_4_1 = var_4_0:Find("content")

	self.memoryView = Dorm3dMemorySubView.New(var_4_1:Find("memory"), self.event, self.contextData)
	self.collectItemView = Dorm3dCollectionItemSubView.New(var_4_1:Find("item"), self.event, self.contextData)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function Dorm3dCollectionLayer:SetPage(arg_8_1)
	for iter_8_0, iter_8_1 in pairs({
		memory = self.memoryView,
		item = self.collectItemView
	}) do
		if iter_8_0 == arg_8_1 then
			iter_8_1:Show()
		else
			iter_8_1:Hide()
		end
	end

	return
end

function Dorm3dCollectionLayer:didEnter()
	if self.room:isPersonalRoom() then
		triggerToggle(self._tf:Find("window/toggles/memory"), true)
	else
		triggerToggle(self._tf:Find("window/toggles/item"), true)
		setActive(self._tf:Find("window/toggles/memory"), false)
	end

	return
end

function Dorm3dCollectionLayer:onBackPressed()
	Dorm3dCollectionLayer.super.onBackPressed(self)

	return
end

function Dorm3dCollectionLayer:willExit()
	self.memoryView:Dispose()
	self.collectItemView:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return Dorm3dCollectionLayer
