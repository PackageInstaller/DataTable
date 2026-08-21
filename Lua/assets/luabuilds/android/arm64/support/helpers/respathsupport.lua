ResPathSupport = {}

local var_0_0 = ResPathSupport

ResPathSupport.ConstPath = {}
ResPathSupport.ConstPath.BG = {}
ResPathSupport.ConstPath.BG.CommonBG = "commonbg"
ResPathSupport.ConstPath.BG.ShipRarityBG = "bg/star_level_bg_%s%s"
ResPathSupport.ConstPath.BG.ShipRarityUI = "ui/star_level_bg_%s%s"
ResPathSupport.ConstPath.BG.ShipBGFixList = {
	"",
	"_0",
	"_1"
}
ResPathSupport.ConstPath.Sound = {}
ResPathSupport.ConstPath.Sound.Default = "cue/%s.b"
ResPathSupport.ConstPath.Sound.BGM = "cue/bgm-%s.b"
ResPathSupport.ConstPath.Painting = {}
ResPathSupport.ConstPath.Painting.Base = "painting/%s%s"
ResPathSupport.ConstPath.Painting.FixList = {
	"",
	"_blueprint",
	"_ex",
	"_hx",
	"_n",
	"_n_ex",
	"_n_hx",
	"_n_rw",
	"_pt_hx",
	"_rank",
	"_shophx",
	"_wjz",
	"_wjz_hx"
}
ResPathSupport.ConstPath.PaintingFace = {}
ResPathSupport.ConstPath.PaintingFace.Base = "paintingface/%s%s"
ResPathSupport.ConstPath.PaintingFace.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.PaintingShipYardIcon = {}
ResPathSupport.ConstPath.PaintingShipYardIcon.Base = "shipyardicon/%s%s"
ResPathSupport.ConstPath.PaintingShipYardIcon.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.PaintingSquareIcon = {}
ResPathSupport.ConstPath.PaintingSquareIcon.Base = "squareicon/%s%s"
ResPathSupport.ConstPath.PaintingSquareIcon.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.PaintingHeroHrzIcon = {}
ResPathSupport.ConstPath.PaintingHeroHrzIcon.Base = "herohrzicon/%s%s"
ResPathSupport.ConstPath.PaintingHeroHrzIcon.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.Live2D = {}
ResPathSupport.ConstPath.Live2D.Base = "live2d/%s%s"
ResPathSupport.ConstPath.Live2D.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.SpinePainting = {}
ResPathSupport.ConstPath.SpinePainting.Base = "spinepainting/%s%s"
ResPathSupport.ConstPath.SpinePainting.FixList = {
	"",
	"_hx"
}
ResPathSupport.ConstPath.SpineChar = {}
ResPathSupport.ConstPath.SpineChar.Base = "char/%s%s"
ResPathSupport.ConstPath.SpineChar.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
ResPathSupport.ConstPath.SpineQIcon = {}
ResPathSupport.ConstPath.SpineQIcon.Base = "qicon/%s%s"
ResPathSupport.ConstPath.SpineQIcon.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
ResPathSupport.ConstPath.SpineModel = {}
ResPathSupport.ConstPath.SpineModel.Base = "shipmodels/%s%s"
ResPathSupport.ConstPath.SpineModel.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
ResPathSupport.ConstPath.UI = {}
ResPathSupport.ConstPath.UI.Base = "ui"
ResPathSupport.ConstPath.UI.LivingAreaCover = "livingareacover"
ResPathSupport.ConstPath.UI.ActivityBanner = "activitybanner"
ResPathSupport.ConstPath.UI.LinkButton = "linkbutton"
ResPathSupport.ConstPath.UI.ShipSkillIcon = "skillicon"

function ResPathSupport.MergeLuaArr(...)
	for iter_1_0, iter_1_1 in pairs({
		...
	}) do
		if iter_1_1 then
			for iter_1_2 = 1, #iter_1_1 do
				({})[#{} + 1] = iter_1_1[iter_1_2]
			end
		end
	end

	return {}
end

function ResPathSupport.CombinePath(...)
	return table.concat({
		...
	}, "/")
end

function ResPathSupport.GetSoundResList(arg_3_0)
	local var_3_0 = {}

	if arg_3_0 and #arg_3_0 > 0 then
		_.each({
			var_0_0.ConstPath.Sound.Default,
			var_0_0.ConstPath.Sound.BGM
		}, function(arg_4_0)
			table.insert(var_3_0, string.format(arg_4_0, arg_3_0))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetShipRarityBgList(arg_5_0)
	local var_5_0 = {
		pg.ship_data_statistics[arg_5_0].rarity,
		pg.ship_data_statistics[arg_5_0].rarity + 1
	}
	local var_5_1 = var_0_0.ConstPath.BG.ShipBGFixList
	local var_5_2 = {}

	_.each({
		var_0_0.ConstPath.BG.ShipRarityBG,
		var_0_0.ConstPath.BG.ShipRarityUI
	}, function(arg_6_0)
		_.each(var_5_0, function(arg_7_0)
			_.each(var_5_1, function(arg_8_0)
				table.insert(var_5_2, string.lower(string.format(arg_6_0, arg_7_0, arg_8_0)))

				return
			end)

			return
		end)

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinBgList(arg_9_0)
	local var_9_0 = {
		pg.ship_skin_template[arg_9_0].bg_sp,
		pg.ship_skin_template[arg_9_0].bg,
		pg.ship_skin_template[arg_9_0].rarity_bg
	}
	local var_9_1 = {}

	_.each({
		var_0_0.ConstPath.BG.ShipRarityBG,
		var_0_0.ConstPath.BG.ShipRarityUI
	}, function(arg_10_0)
		_.each(var_9_0, function(arg_11_0)
			if arg_11_0 and #arg_11_0 > 0 then
				table.insert(var_9_1, string.lower(string.format(arg_10_0, arg_11_0, "")))
			end

			return
		end)

		return
	end)

	return {}
end

function ResPathSupport.GetSkillIconList(arg_12_0)
	local var_12_0 = var_0_0.ConstPath.UI.ShipSkillIcon
	local var_12_1 = {}

	_.each(pg.ship_data_template[arg_12_0].buff_list_display, function(arg_13_0)
		local var_13_0 = tostring(getSkillConfig(arg_13_0).icon)

		if var_13_0 and #var_13_0 > 0 then
			table.insert(var_12_1, (string.lower((var_0_0.CombinePath(var_12_0, var_13_0)))))
		end

		return
	end)

	return {}
end

function ResPathSupport.GetSpineCharListByPrefabName(arg_14_0)
	local var_14_0 = var_0_0.ConstPath.SpineChar.Base
	local var_14_1 = {}

	if arg_14_0 and #arg_14_0 > 0 then
		_.each(var_0_0.ConstPath.SpineChar.FixList, function(arg_15_0)
			table.insert(var_14_1, string.lower(string.format(var_14_0, arg_14_0, arg_15_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetSpineQIconListByPrefabName(arg_16_0)
	local var_16_0 = var_0_0.ConstPath.SpineQIcon.Base
	local var_16_1 = {}

	if arg_16_0 and #arg_16_0 > 0 then
		_.each(var_0_0.ConstPath.SpineQIcon.FixList, function(arg_17_0)
			table.insert(var_16_1, string.lower(string.format(var_16_0, arg_16_0, arg_17_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetSpineModelsByPrefabName(arg_18_0)
	local var_18_0 = var_0_0.ConstPath.SpineModel.Base
	local var_18_1 = {}

	if arg_18_0 and #arg_18_0 > 0 then
		_.each(var_0_0.ConstPath.SpineModel.FixList, function(arg_19_0)
			table.insert(var_18_1, string.lower(string.format(var_18_0, arg_18_0, arg_19_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetPaintingListByPaintingName(arg_20_0)
	local var_20_0 = var_0_0.ConstPath.Painting.Base
	local var_20_1 = {}

	if arg_20_0 and #arg_20_0 > 0 then
		_.each(var_0_0.ConstPath.Painting.FixList, function(arg_21_0)
			table.insert(var_20_1, string.lower(string.format(var_20_0, arg_20_0, arg_21_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetPaintingFaceListByPaintingName(arg_22_0)
	local var_22_0 = var_0_0.ConstPath.PaintingFace.Base
	local var_22_1 = {}

	if arg_22_0 and #arg_22_0 > 0 then
		_.each(var_0_0.ConstPath.PaintingFace.FixList, function(arg_23_0)
			table.insert(var_22_1, string.lower(string.format(var_22_0, arg_22_0, arg_23_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetPaintingShipYardIconListByPaintingName(arg_24_0)
	local var_24_0 = var_0_0.ConstPath.PaintingShipYardIcon.Base
	local var_24_1 = {}

	if arg_24_0 and #arg_24_0 > 0 then
		_.each(var_0_0.ConstPath.PaintingShipYardIcon.FixList, function(arg_25_0)
			table.insert(var_24_1, string.lower(string.format(var_24_0, arg_24_0, arg_25_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetPaintingSquareIconListByPaintingName(arg_26_0)
	local var_26_0 = var_0_0.ConstPath.PaintingSquareIcon.Base
	local var_26_1 = {}

	if arg_26_0 and #arg_26_0 > 0 then
		_.each(var_0_0.ConstPath.PaintingSquareIcon.FixList, function(arg_27_0)
			table.insert(var_26_1, string.lower(string.format(var_26_0, arg_26_0, arg_27_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetPaintingHeroHrzIconListByPaintingName(arg_28_0)
	local var_28_0 = var_0_0.ConstPath.PaintingHeroHrzIcon.Base
	local var_28_1 = {}

	if arg_28_0 and #arg_28_0 > 0 then
		_.each(var_0_0.ConstPath.PaintingHeroHrzIcon.FixList, function(arg_29_0)
			table.insert(var_28_1, string.lower(string.format(var_28_0, arg_28_0, arg_29_0)))

			return
		end)
	end

	return {}
end

function ResPathSupport.GetShipSkinPaintingList(arg_30_0)
	return var_0_0.GetPaintingListByPaintingName(pg.ship_skin_template[arg_30_0].painting)
end

function ResPathSupport.GetShipSkinPaintingFaceList(arg_31_0)
	return var_0_0.GetPaintingFaceListByPaintingName(pg.ship_skin_template[arg_31_0].painting)
end

function ResPathSupport.GetShipSkinPaintingShipYardIconList(arg_32_0)
	return var_0_0.GetPaintingShipYardIconListByPaintingName(pg.ship_skin_template[arg_32_0].painting)
end

function ResPathSupport.GetShipSkinPaintingSquareIconList(arg_33_0)
	return var_0_0.GetPaintingSquareIconListByPaintingName(pg.ship_skin_template[arg_33_0].painting)
end

function ResPathSupport.GetShipSkinPaintingHeroHrzIconList(arg_34_0)
	return var_0_0.GetPaintingHeroHrzIconListByPaintingName(pg.ship_skin_template[arg_34_0].painting)
end

function ResPathSupport.GetShipSkinSpineQIconList(arg_35_0)
	local var_35_0 = var_0_0.ConstPath.SpineQIcon.Base
	local var_35_1 = pg.ship_skin_template[arg_35_0].painting
	local var_35_2 = {}

	_.each(var_0_0.ConstPath.SpineQIcon.FixList, function(arg_36_0)
		table.insert(var_35_2, string.format(var_35_0, var_35_1, arg_36_0))

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinSpineShipModelList(arg_37_0)
	local var_37_0 = var_0_0.ConstPath.SpineModel.Base
	local var_37_1 = pg.ship_skin_template[arg_37_0].painting
	local var_37_2 = {}

	_.each(var_0_0.ConstPath.SpineModel.FixList, function(arg_38_0)
		table.insert(var_37_2, string.format(var_37_0, var_37_1, arg_38_0))

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinSpineCharList(arg_39_0)
	local var_39_0 = var_0_0.ConstPath.SpineChar.Base
	local var_39_1 = pg.ship_skin_template[arg_39_0].painting
	local var_39_2 = {}

	_.each(var_0_0.ConstPath.SpineChar.FixList, function(arg_40_0)
		table.insert(var_39_2, string.format(var_39_0, var_39_1, arg_40_0))

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinLive2DList(arg_41_0)
	local var_41_0 = var_0_0.ConstPath.Live2D.Base
	local var_41_1 = pg.ship_skin_template[arg_41_0].painting
	local var_41_2 = {}

	_.each(var_0_0.ConstPath.Live2D.FixList, function(arg_42_0)
		table.insert(var_41_2, string.format(var_41_0, var_41_1, arg_42_0))

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinSpinePaintingList(arg_43_0)
	local var_43_0 = var_0_0.ConstPath.SpinePainting.Base
	local var_43_1 = pg.ship_skin_template[arg_43_0].painting
	local var_43_2 = {}

	_.each(var_0_0.ConstPath.SpinePainting.FixList, function(arg_44_0)
		table.insert(var_43_2, string.format(var_43_0, var_43_1, arg_44_0))

		return
	end)

	return {}
end

function ResPathSupport.GetShipSkinEffectList(arg_45_0)
	if pg.ship_skin_template[arg_45_0].special_effects and #pg.ship_skin_template[arg_45_0].special_effects > 0 then
		table.insert({}, var_0_0.CombinePath(var_0_0.ConstPath.UI.Base, pg.ship_skin_template[arg_45_0].special_effects[1]))
	end

	return {}
end

function ResPathSupport.GetShipSkinSoundList(arg_46_0)
	local var_46_0 = {}

	if pg.ship_skin_template[arg_46_0].bgm and #pg.ship_skin_template[arg_46_0].bgm > 0 then
		var_46_0 = var_0_0.GetSoundResList(pg.ship_skin_template[arg_46_0].bgm)
	end

	return var_46_0
end

function ResPathSupport.GetShipAllRes(arg_47_0)
	local var_47_0 = arg_47_0:getSkinId()

	return (var_0_0.MergeLuaArr({
		"spinematerials",
		"ui/lihui_qiehuan01",
		"ui/lihui_qiehuan02",
		"effect/jiehuntexiao"
	}, var_0_0.GetShipRarityBgList(arg_47_0.configId), var_0_0.GetShipSkinBgList(var_47_0), var_0_0.GetSkillIconList(arg_47_0.configId), var_0_0.GetShipSkinSoundList(var_47_0), var_0_0.GetShipSkinSpineQIconList(var_47_0), var_0_0.GetShipSkinSpineShipModelList(var_47_0), var_0_0.GetShipSkinSpineCharList(var_47_0), var_0_0.GetShipSkinSpinePaintingList(var_47_0), var_0_0.GetShipSkinPaintingList(var_47_0), var_0_0.GetShipSkinPaintingFaceList(var_47_0), var_0_0.GetShipSkinPaintingShipYardIconList(var_47_0), var_0_0.GetShipSkinPaintingSquareIconList(var_47_0), var_0_0.GetShipSkinPaintingHeroHrzIconList(var_47_0), (var_0_0.GetShipSkinEffectList(var_47_0))))
end

return
