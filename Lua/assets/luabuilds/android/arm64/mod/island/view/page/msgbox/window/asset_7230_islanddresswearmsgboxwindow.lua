local IslandDressWearMsgboxWindow = class("IslandDressWearMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandDressWearMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxForDressWear"
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function IslandDressWearMsgboxWindow:OnLoaded()
	IslandDressWearMsgboxWindow.super.OnLoaded(self)

	self.dressRect = self._tf:Find("dress_container/dress"):GetComponent("LScrollRect")

	function self.dressRect.onUpdateItem(arg_3_0, arg_3_1)
		self:OnDressUpdateItem(arg_3_0, arg_3_1)

		return
	end

	return
end

function IslandDressWearMsgboxWindow:OnShow()
	IslandDressWearMsgboxWindow.super.OnShow(self)
	self.dressRect:SetTotalCount(#self.settings.needconfirmDressList, 0)

	return
end

function IslandDressWearMsgboxWindow:OnDressUpdateItem(arg_5_1, arg_5_2)
	if pg.island_dress_template[self.settings.needconfirmDressList[arg_5_1 + 1].dress_id].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[self.settings.needconfirmDressList[arg_5_1 + 1].dress_id].icon), "", arg_5_2.transform:Find("icon"))
	end

	if pg.island_dress_template[self.settings.needconfirmDressList[arg_5_1 + 1].dress_id].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[self.settings.needconfirmDressList[arg_5_1 + 1].dress_id].quality]), "", arg_5_2.transform:Find("frame"))
	end

	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(self.settings.needconfirmDressList[arg_5_1 + 1].ship_id), "", arg_5_2.transform:Find("shipHold/ship_icon"))

	return
end

function IslandDressWearMsgboxWindow:OnDestroy()
	IslandDressWearMsgboxWindow.super.OnDestroy(self)
	ClearLScrollrect(self.dressRect)

	return
end

return IslandDressWearMsgboxWindow
