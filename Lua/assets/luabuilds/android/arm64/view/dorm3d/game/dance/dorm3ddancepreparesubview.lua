local var_0_0 = class("Dorm3dDancePrepareSubView", import("..Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0.prepareCucoloris = arg_1_0._tf:Find("bg/cucoloris")
	arg_1_0.songText = arg_1_0._tf:Find("bg/title/song")
	arg_1_0.performerText = arg_1_0._tf:Find("bg/title/performer")
	arg_1_0.hintText = arg_1_0._tf:Find("bg/hint")
	arg_1_0.gameConfig = pg.dorm3d_dance[arg_1_0.contextData.groupId]

	setText(arg_1_0.songText, arg_1_0.gameConfig.song_name)

	local var_1_0 = ShipGroup.getDefaultShipNameByGroupID(arg_1_0.contextData.groupId)

	setText(arg_1_0.performerText, i18n("dorm3d_cafe_minigame1", var_1_0))
	setText(arg_1_0.hintText, i18n("dorm3d_cafe_minigame2", var_1_0))

	return
end

function var_0_0.Flush(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.contextData.cucoloris do
		local var_2_0 = arg_2_0.prepareCucoloris:GetChild(iter_2_0 - 1)

		LoadImageSpriteAtlasAsync(arg_2_0.contextData.cucoloris[iter_2_0]:GetIcon(), "", var_2_0:Find("Image"), true)
	end

	return
end

return var_0_0
