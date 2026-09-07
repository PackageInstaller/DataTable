local MapBuilderSenrankagura = class("MapBuilderSenrankagura", import(".MapBuilderNormal"))

function MapBuilderSenrankagura:GetType()
	return MapBuilder.TYPESENRANKAGURA
end

function MapBuilderSenrankagura:OnShow()
	MapBuilderSenrankagura.super.OnShow(self)
	setImageSprite(self.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_challenge"), true)

	return
end

function MapBuilderSenrankagura:OnHide()
	setImageSprite(self.sceneParent.actEliteBtn, GetSpriteFromAtlas("ui/levelmainscene_atlas", "btn_elite"), true)
	MapBuilderSenrankagura.super.OnHide(self)

	return
end

return MapBuilderSenrankagura
