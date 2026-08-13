class = var_0_10000

local var_0_0 = "Dorm3dDancePrepareSubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.prepareCucoloris = var_1.Find(var_1_0, "bg/cucoloris")

	local var_1_1 = arg_1_0._tf

	arg_1_0.songText = var_1.Find(var_1_1, "bg/title/song")

	local var_1_2 = arg_1_0._tf

	arg_1_0.performerText = var_1.Find(var_1_2, "bg/title/performer")

	local var_1_3 = arg_1_0._tf

	arg_1_0.hintText = var_1.Find(var_1_3, "bg/hint")
	pg = var_1
	arg_1_0.gameConfig = var_1.dorm3d_dance[arg_1_0.contextData.groupId]
	setText = var_1

	var_1(arg_1_0.songText, arg_1_0.gameConfig.song_name)

	ShipGroup = var_1

	local var_1_4 = var_1.getDefaultShipNameByGroupID(arg_1_0.contextData.groupId)

	setText = var_2

	local var_1_5 = arg_1_0.performerText

	i18n = var_1_10005

	var_2(var_1_5, var_1_10005("dorm3d_cafe_minigame1", var_1_4))

	setText = var_2

	local var_1_6 = arg_1_0.hintText

	i18n = var_5

	var_2(var_1_6, var_5("dorm3d_cafe_minigame2", var_1_4))

	return
end

function var_0_1.Flush(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.contextData.cucoloris do
		local var_2_0 = arg_2_0.prepareCucoloris
		local var_2_1 = var_5.GetChild(var_2_0, iter_2_0 - 1)

		LoadImageSpriteAtlasAsync = var_1_10006

		local var_2_2 = arg_2_0.contextData.cucoloris[iter_2_0]

		var_1_10006(var_8.GetIcon(var_2_2), "", var_2_1:Find("Image"), true)
	end

	return
end

return var_0_1
