local var_0_0 = class("MapBuilderSenrankagura", import(".MapBuilderNormal"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESENRANKAGURA
end

function var_0_0.OnShow(arg_2_0)
	var_0_0.super.OnShow(arg_2_0)
	setImageSprite(arg_2_0.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_challenge"), true)

	return
end

function var_0_0.OnHide(arg_3_0)
	setImageSprite(arg_3_0.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_elite"), true)
	var_0_0.super.OnHide(arg_3_0)

	return
end

return var_0_0
