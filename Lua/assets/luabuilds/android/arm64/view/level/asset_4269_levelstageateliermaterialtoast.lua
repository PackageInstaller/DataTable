local LevelStageAtelierMaterialToast = class("LevelStageAtelierMaterialToast", import("view.base.BaseSubPanel"))

function LevelStageAtelierMaterialToast:getUIName()
	return "LevelStageAtelierMaterialToast"
end

function LevelStageAtelierMaterialToast:OnInit()
	return
end

function LevelStageAtelierMaterialToast:OnLoaded()
	return
end

local var_0_1 = 26
local var_0_2 = 47
local var_0_3 = 196

function LevelStageAtelierMaterialToast:Play(arg_4_1)
	setText(self._tf:Find("Title"), self.contextData.settings.title)

	local var_4_0 = self._tf:Find("Desc")
	local var_4_1 = 2

	while WorldMediaCollectionFileDetailLayer.getTextPreferredHeight(GetComponent(var_4_0, typeof(Text)), var_4_0.rect.width, self.contextData.settings.desc) > var_0_1 + var_0_2 * (var_4_1 - 1) do
		var_4_1 = var_4_1 + 1
	end

	CustomIndexLayer.Clone2Full(self._tf:Find("Lines"), var_4_1 + 1)
	setSizeDelta(self._tf, {
		x = self._tf.sizeDelta.x,
		y = var_0_3 + math.max(var_4_1 - 2, 0) * var_0_2
	})
	setText(var_4_0, self.contextData.settings.desc)

	if self.contextData.settings.icon then
		local var_4_2 = self.contextData.settings.iconScale or 1

		LoadImageSpriteAtlasAsync("ui/ryzaicon_atlas", self.contextData.settings.icon, self._tf:Find("Image"))
		setLocalScale(self._tf:Find("Image"), {
			x = var_4_2,
			y = var_4_2
		})
	end

	if self.contextData.settings.voice then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(self.contextData.settings.voice)
	end

	self._go.transform:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)
	GetComponent(self._tf, typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()
		existCall(arg_4_1)

		return
	end)

	return
end

function LevelStageAtelierMaterialToast:OnDestroy()
	LeanTween.cancel(self._go)

	return
end

return LevelStageAtelierMaterialToast
