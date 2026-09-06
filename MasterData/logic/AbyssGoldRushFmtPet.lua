-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushFmtPet.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushFmtPet", package.seeall)

local AbyssGoldRushFmtPet = class("AbyssGoldRushFmtPet", CustomRightCell)

AbyssGoldRushFmtPet.prefabUrl = "ui/views/abyssgoldrush/abyssgoldrushfmtpet.prefab"

function AbyssGoldRushFmtPet:buildUI()
	self._buffIcon = goutil.findChild(self.mainGO, "buffIcon")
end

function AbyssGoldRushFmtPet:onUpdateView(res)
	if string.nilorempty(res) then
		uGuiUtil.clearImage(self._buffIcon)
		GameUtil.SetActive(self._buffIcon, false)
	else
		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(res))
		GameUtil.SetActive(self._buffIcon, true)
	end
end

return AbyssGoldRushFmtPet
