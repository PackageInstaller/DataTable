class = var_0_10000

local var_0_0 = "LevelStageAtelierMaterialToast"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageAtelierMaterialToast"
end

function var_0_1.OnInit(arg_2_0)
	return
end

function var_0_1.OnLoaded(arg_3_0)
	return
end

local var_0_2 = 26
local var_0_3 = 47
local var_0_4 = 196

function var_0_1.Play(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.contextData.settings

	setText = var_1_10003

	local var_4_1 = arg_4_0._tf

	var_1_10003(var_5.Find(var_4_1, "Title"), var_4_0.title)

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_3.Find(var_4_2, "Desc")

	GetComponent = var_1_10004

	local var_4_4 = var_4_3

	typeof = var_4_1
	Text = var_1_10009

	local var_4_5 = var_1_10004(var_4_4, var_4_1(var_1_10009))

	WorldMediaCollectionFileDetailLayer = var_4_2

	local var_4_6 = var_4_2.getTextPreferredHeight(var_4_5, var_4_3.rect.width, var_4_0.desc)
	local var_4_7 = 2

	while var_0_2 + var_0_3 * (var_4_7 - 1) < var_4_6 do
		var_4_7 = var_4_7 + 1
	end

	CustomIndexLayer = var_7

	local var_4_8 = var_7.Clone2Full
	local var_4_9 = arg_4_0._tf

	var_4_8(var_9.Find(var_4_9, "Lines"), var_4_7 + 1)

	setSizeDelta = var_4_8

	local var_4_10 = arg_4_0._tf
	local var_4_11 = {
		x = arg_4_0._tf.sizeDelta.x
	}
	local var_4_12 = var_0_4

	math = var_12
	var_4_11.y = var_4_12 + var_12.max(var_4_7 - 2, 0) * var_0_3

	var_4_8(var_4_10, var_4_11)

	setText = var_4_8

	var_4_8(var_4_3, var_4_0.desc)

	local var_4_14, var_4_17

	if var_4_0.icon then
		local var_4_13

		if not var_4_0.iconScale then
			var_4_13 = 1
		end

		LoadImageSpriteAtlasAsync = var_8
		var_4_14 = "ui/ryzaicon_atlas"

		local var_4_15 = var_4_0.icon
		local var_4_16 = arg_4_0._tf

		var_8(var_4_14, var_4_15, var_4_17.Find(var_4_16, "Image"))

		setLocalScale = var_8
		var_4_17 = arg_4_0._tf

		var_8(var_4_14.Find(var_4_17, "Image"), {
			x = var_4_13,
			y = var_4_13
		})
	end

	if var_4_0.voice then
		pg = var_7

		local var_4_18 = var_7.CriMgr.GetInstance()

		var_7.PlaySoundEffect_V3(var_4_18, var_4_0.voice)
	end

	local var_4_19 = arg_4_0._go.transform
	local var_4_20 = var_7.SetParent

	pg = var_4_14

	var_4_20(var_4_19, var_4_14.UIMgr.GetInstance().OverlayToast, false)

	GetComponent = var_4_20

	local var_4_21 = arg_4_0._tf

	typeof = var_10
	DftAniEvent = var_4_17

	local var_4_22 = var_4_20(var_4_21, var_10(var_4_17))

	var_7.SetEndEvent(var_4_22, function()
		local var_5_0 = arg_4_0

		var_0.Destroy(var_5_0)

		existCall = var_0

		var_0(arg_4_1)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_6_0._go)

	return
end

return var_0_1
