local MapBuilderAtelier = class("MapBuilderAtelier", import(".MapBuilderNormal"))

function MapBuilderAtelier:GetType()
	return MapBuilder.TYPEATELIER
end

function MapBuilderAtelier:OnShow()
	MapBuilderAtelier.super.OnShow(self)
	setImageSprite(self.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_lianjin"), true)

	return
end

function MapBuilderAtelier:OnHide()
	setImageSprite(self.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_elite"), true)
	MapBuilderAtelier.super.OnHide(self)

	return
end

function MapBuilderAtelier:UpdateButtons()
	MapBuilderAtelier.super.UpdateButtons(self)
	setActive(self.sceneParent.actAtelierBuffBtn, self.data:getConfig("type") > Map.ACTIVITY_EASY)

	return
end

return MapBuilderAtelier
