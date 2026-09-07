local ShipAtlasLive2dBtn = class("ShipAtlasLive2dBtn", import("....PlayerVitae.btns.PlayerVitaeLive2dBtn"))

function ShipAtlasLive2dBtn:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	ShipAtlasLive2dBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.event = arg_1_3
	self.value = arg_1_4

	return
end

function ShipAtlasLive2dBtn:emit(...)
	self.event:emit(...)

	return
end

function ShipAtlasLive2dBtn:GetDefaultValue()
	return self.value
end

function ShipAtlasLive2dBtn:OnSwitch(arg_4_1)
	return true
end

function ShipAtlasLive2dBtn:OnSwitchDone()
	self:emit(SkinAtlasPreviewPage.ON_L2D_SWITCH_DONE, self.flag)

	return
end

return ShipAtlasLive2dBtn
