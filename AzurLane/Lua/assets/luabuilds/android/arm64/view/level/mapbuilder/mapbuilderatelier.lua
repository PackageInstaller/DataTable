local var_0_0 = class("MapBuilderAtelier", import(".MapBuilderNormal"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPEATELIER
end

function var_0_0.OnShow(arg_2_0)
	var_0_0.super.OnShow(arg_2_0)
	setImageSprite(arg_2_0.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_lianjin"), true)

	return
end

function var_0_0.OnHide(arg_3_0)
	setImageSprite(arg_3_0.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_elite"), true)
	var_0_0.super.OnHide(arg_3_0)

	return
end

function var_0_0.UpdateButtons(arg_4_0)
	var_0_0.super.UpdateButtons(arg_4_0)
	setActive(arg_4_0.sceneParent.actAtelierBuffBtn, arg_4_0.data:getConfig("type") > Map.ACTIVITY_EASY)

	return
end

return var_0_0
