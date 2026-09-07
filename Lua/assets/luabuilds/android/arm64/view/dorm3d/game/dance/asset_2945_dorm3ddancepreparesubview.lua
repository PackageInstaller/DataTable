local Dorm3dDancePrepareSubView = class("Dorm3dDancePrepareSubView", import("..Dorm3dGameBaseSubView"))

function Dorm3dDancePrepareSubView:Init()
	self.prepareCucoloris = self._tf:Find("bg/cucoloris")
	self.songText = self._tf:Find("bg/title/song")
	self.performerText = self._tf:Find("bg/title/performer")
	self.hintText = self._tf:Find("bg/hint")
	self.gameConfig = pg.dorm3d_dance[self.contextData.groupId]

	setText(self.songText, self.gameConfig.song_name)

	local var_1_0 = ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId)

	setText(self.performerText, i18n("dorm3d_cafe_minigame1", var_1_0))
	setText(self.hintText, i18n("dorm3d_cafe_minigame2", var_1_0))

	return
end

function Dorm3dDancePrepareSubView:Flush()
	for iter_2_0 = 1, #self.contextData.cucoloris do
		LoadImageSpriteAtlasAsync(self.contextData.cucoloris[iter_2_0]:GetIcon(), "", self.prepareCucoloris:GetChild(iter_2_0 - 1):Find("Image"), true)
	end

	return
end

return Dorm3dDancePrepareSubView
