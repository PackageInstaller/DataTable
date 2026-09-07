local ShipAtlasBgBtn = class("ShipAtlasBgBtn", import("....PlayerVitae.btns.PlayerVitaeBGBtn"))

function ShipAtlasBgBtn:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	ShipAtlasBgBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.event = arg_1_3
	self.value = arg_1_4

	return
end

function ShipAtlasBgBtn:emit(...)
	self.event:emit(...)

	return
end

function ShipAtlasBgBtn:GetDefaultValue()
	return self.value
end

function ShipAtlasBgBtn:OnSwitch(arg_4_1)
	return true
end

function ShipAtlasBgBtn:OnSwitchDone()
	self:emit(SkinAtlasPreviewPage.ON_BG_SWITCH_DONE, self.flag)

	return
end

return ShipAtlasBgBtn
