local IslandSendDressUpMsgboxWindow = class("IslandSendDressUpMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandSendDressUpMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxForSendDress"
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function IslandSendDressUpMsgboxWindow:OnLoaded()
	IslandSendDressUpMsgboxWindow.super.OnLoaded(self)

	self.itemFrameTF = self._tf:Find("item/icon_bg/frame")
	self.itemIconTF = self._tf:Find("item/icon_bg/icon")
	self.ownNum = self._tf:Find("own/ownCount")

	return
end

function IslandSendDressUpMsgboxWindow:OnShow()
	IslandSendDressUpMsgboxWindow.super.OnShow(self)
	self:FlushDressItem(self.settings)

	return
end

function IslandSendDressUpMsgboxWindow:FlushDressItem(arg_4_1)
	if pg.island_dress_template[arg_4_1.configId].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[arg_4_1.configId].icon), "", self.itemIconTF)
	end

	if pg.island_dress_template[arg_4_1.configId].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[arg_4_1.configId].quality]), "", self.itemFrameTF)
	end

	setText(self.ownNum, getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetOwnDressCountByDressId(arg_4_1.configId))

	return
end

return IslandSendDressUpMsgboxWindow
