local var_0_0 = class("LevelStageAtelierMaterialToast", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "LevelStageAtelierMaterialToast"
end

function var_0_0.OnInit(arg_2_0)
	return
end

function var_0_0.OnLoaded(arg_3_0)
	return
end

local var_0_1 = 26
local var_0_2 = 47
local var_0_3 = 196

function var_0_0.Play(arg_4_0, arg_4_1)
	setText(arg_4_0._tf:Find("Title"), arg_4_0.contextData.settings.title)

	local var_4_0 = arg_4_0._tf:Find("Desc")
	local var_4_1 = 2

	while WorldMediaCollectionFileDetailLayer.getTextPreferredHeight(GetComponent(var_4_0, typeof(Text)), var_4_0.rect.width, arg_4_0.contextData.settings.desc) > var_0_1 + var_0_2 * (var_4_1 - 1) do
		var_4_1 = var_4_1 + 1
	end

	CustomIndexLayer.Clone2Full(arg_4_0._tf:Find("Lines"), var_4_1 + 1)
	setSizeDelta(arg_4_0._tf, {
		x = arg_4_0._tf.sizeDelta.x,
		y = var_0_3 + math.max(var_4_1 - 2, 0) * var_0_2
	})
	setText(var_4_0, arg_4_0.contextData.settings.desc)

	if arg_4_0.contextData.settings.icon then
		local var_4_2 = arg_4_0.contextData.settings.iconScale or 1

		LoadImageSpriteAtlasAsync("ui/ryzaicon_atlas", arg_4_0.contextData.settings.icon, arg_4_0._tf:Find("Image"))
		setLocalScale(arg_4_0._tf:Find("Image"), {
			x = var_4_2,
			y = var_4_2
		})
	end

	if arg_4_0.contextData.settings.voice then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_4_0.contextData.settings.voice)
	end

	arg_4_0._go.transform:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)
	GetComponent(arg_4_0._tf, typeof(DftAniEvent)):SetEndEvent(function()
		arg_4_0:Destroy()
		existCall(arg_4_1)

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	LeanTween.cancel(arg_6_0._go)

	return
end

return var_0_0
