class = var_0_10000

local var_0_0 = "MapBuilderSenrankagura"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderNormal"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESENRANKAGURA
end

function var_0_1.OnShow(arg_2_0)
	var_0_1.super.OnShow(arg_2_0)

	GetSpriteFromAtlas = var_1

	local var_2_0 = var_1("ui/levelmainscene_atlas", "btn_challenge")

	setImageSprite = var_2

	var_2(arg_2_0.sceneParent.actEliteBtn, var_2_0, true)

	return
end

function var_0_1.OnHide(arg_3_0)
	GetSpriteFromAtlas = var_1_10001

	local var_3_0 = var_1_10001("ui/levelmainscene_atlas", "btn_elite")

	setImageSprite = var_2

	var_2(arg_3_0.sceneParent.actEliteBtn, var_3_0, true)
	var_0_1.super.OnHide(arg_3_0)

	return
end

return var_0_1
