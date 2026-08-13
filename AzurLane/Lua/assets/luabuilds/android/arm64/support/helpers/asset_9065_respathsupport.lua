local var_0_0 = {}

ResPathSupport = ResPathSupport
var_0.ConstPath = {}
var_0.ConstPath.BG = {}
var_0.ConstPath.BG.CommonBG = "commonbg"
var_0.ConstPath.BG.ShipRarityBG = "bg/star_level_bg_%s%s"
var_0.ConstPath.BG.ShipRarityUI = "ui/star_level_bg_%s%s"
var_0.ConstPath.BG.ShipBGFixList = {
	"",
	"_0",
	"_1"
}
var_0.ConstPath.Sound = {}
var_0.ConstPath.Sound.Default = "cue/%s.b"
var_0.ConstPath.Sound.BGM = "cue/bgm-%s.b"
var_0.ConstPath.Painting = {}
var_0.ConstPath.Painting.Base = "painting/%s%s"
var_0.ConstPath.Painting.FixList = {
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
var_0.ConstPath.PaintingFace = {}
var_0.ConstPath.PaintingFace.Base = "paintingface/%s%s"
var_0.ConstPath.PaintingFace.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.PaintingShipYardIcon = {}
var_0.ConstPath.PaintingShipYardIcon.Base = "shipyardicon/%s%s"
var_0.ConstPath.PaintingShipYardIcon.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.PaintingSquareIcon = {}
var_0.ConstPath.PaintingSquareIcon.Base = "squareicon/%s%s"
var_0.ConstPath.PaintingSquareIcon.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.PaintingHeroHrzIcon = {}
var_0.ConstPath.PaintingHeroHrzIcon.Base = "herohrzicon/%s%s"
var_0.ConstPath.PaintingHeroHrzIcon.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.Live2D = {}
var_0.ConstPath.Live2D.Base = "live2d/%s%s"
var_0.ConstPath.Live2D.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.SpinePainting = {}
var_0.ConstPath.SpinePainting.Base = "spinepainting/%s%s"
var_0.ConstPath.SpinePainting.FixList = {
	"",
	"_hx"
}
var_0.ConstPath.SpineChar = {}
var_0.ConstPath.SpineChar.Base = "char/%s%s"
var_0.ConstPath.SpineChar.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
var_0.ConstPath.SpineQIcon = {}
var_0.ConstPath.SpineQIcon.Base = "qicon/%s%s"
var_0.ConstPath.SpineQIcon.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
var_0.ConstPath.SpineModel = {}
var_0.ConstPath.SpineModel.Base = "shipmodels/%s%s"
var_0.ConstPath.SpineModel.FixList = {
	"",
	"_hx",
	"_l",
	"_r"
}
var_0.ConstPath.UI = {}
var_0.ConstPath.UI.Base = "ui"
var_0.ConstPath.UI.LivingAreaCover = "livingareacover"
var_0.ConstPath.UI.ActivityBanner = "activitybanner"
var_0.ConstPath.UI.LinkButton = "linkbutton"
var_0.ConstPath.UI.ShipSkillIcon = "skillicon"

function var_0.MergeLuaArr(...)
	local var_1_0 = {}

	pairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001({
		...
	}) do
		if iter_1_1 then
			for iter_1_2 = 1, #iter_1_1 do
				var_1_0[#var_1_0 + 1] = iter_1_1[iter_1_2]
			end
		end
	end

	return var_1_0
end

function var_0.CombinePath(...)
	local var_2_0 = {
		...
	}

	table = var_1

	return var_1.concat(var_2_0, "/")
end

function var_0.GetSoundResList(arg_3_0)
	local var_3_0 = {
		var_0.ConstPath.Sound.Default,
		var_0.ConstPath.Sound.BGM
	}
	local var_3_1 = {}

	if arg_3_0 and #arg_3_0 > 0 then
		_ = var_3

		var_3.each(var_3_0, function(arg_4_0)
			table = var_2_10001

			local var_4_0 = var_2_10001.insert
			local var_4_1 = var_3_1

			string = var_2_10004

			var_4_0(var_4_1, var_2_10004.format(arg_4_0, arg_3_0))

			return
		end)
	end

	return var_3_1
end

function var_0.GetShipRarityBgList(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.ship_data_statistics[arg_5_0].rarity
	local var_5_1 = {
		var_5_0,
		var_5_0 + 1
	}
	local var_5_2 = var_0.ConstPath.BG.ShipBGFixList
	local var_5_3 = {
		var_0.ConstPath.BG.ShipRarityBG,
		var_0.ConstPath.BG.ShipRarityUI
	}
	local var_5_4 = {}

	_ = var_1_10007

	var_1_10007.each(var_5_3, function(arg_6_0)
		_ = var_2_10001

		var_2_10001.each(var_5_1, function(arg_7_0)
			_ = var_3_10001

			var_3_10001.each(var_5_2, function(arg_8_0)
				table = var_4_10001

				local var_8_0 = var_4_10001.insert
				local var_8_1 = var_5_4

				string = var_4_10004

				local var_8_2 = var_4_10004.lower

				string = var_4_10006

				var_8_0(var_8_1, var_8_2(var_4_10006.format(arg_6_0, arg_7_0, arg_8_0)))

				return
			end)

			return
		end)

		return
	end)

	return var_5_4
end

function var_0.GetShipSkinBgList(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.ship_skin_template[arg_9_0]
	local var_9_1 = {
		var_9_0.bg_sp,
		var_9_0.bg,
		var_9_0.rarity_bg
	}
	local var_9_2 = {
		var_0.ConstPath.BG.ShipRarityBG,
		var_0.ConstPath.BG.ShipRarityUI
	}
	local var_9_3 = {}

	_ = var_1_10005

	var_1_10005.each(var_9_2, function(arg_10_0)
		_ = var_2_10001

		var_2_10001.each(var_9_1, function(arg_11_0)
			if arg_11_0 and #arg_11_0 > 0 then
				table = var_1

				local var_11_0 = var_1.insert
				local var_11_1 = var_9_3

				string = var_3_10004

				local var_11_2 = var_3_10004.lower

				string = var_3_10006

				var_11_0(var_11_1, var_11_2(var_3_10006.format(arg_10_0, arg_11_0, "")))
			end

			return
		end)

		return
	end)

	return var_9_3
end

function var_0.GetSkillIconList(arg_12_0)
	local var_12_0 = var_0.ConstPath.UI.ShipSkillIcon

	pg = var_1_10002

	local var_12_1 = var_1_10002.ship_data_template[arg_12_0].buff_list_display
	local var_12_2 = {}

	_ = var_1_10004

	var_1_10004.each(var_12_1, function(arg_13_0)
		getSkillConfig = var_2_10001

		local var_13_0 = var_2_10001(arg_13_0)

		tostring = var_2_10002

		if var_2_10002(var_13_0.icon) then
			local var_13_1 = #var_2

			if 0 < var_13_1 then
				local var_13_2 = var_0.CombinePath(var_12_0, var_2)

				string = var_4

				local var_13_3 = var_4.lower(var_13_2)

				table = var_4

				var_4.insert(var_12_2, var_13_3)
			end
		end

		return
	end)

	return var_12_2
end

function var_0.GetSpineCharListByPrefabName(arg_14_0)
	local var_14_0 = var_0.ConstPath.SpineChar.Base
	local var_14_1 = var_0.ConstPath.SpineChar.FixList
	local var_14_2 = {}

	if arg_14_0 and #arg_14_0 > 0 then
		_ = var_4

		var_4.each(var_14_1, function(arg_15_0)
			table = var_2_10001

			local var_15_0 = var_2_10001.insert
			local var_15_1 = var_14_2

			string = var_2_10004

			local var_15_2 = var_2_10004.lower

			string = var_2_10006

			var_15_0(var_15_1, var_15_2(var_2_10006.format(var_14_0, arg_14_0, arg_15_0)))

			return
		end)
	end

	return var_14_2
end

function var_0.GetSpineQIconListByPrefabName(arg_16_0)
	local var_16_0 = var_0.ConstPath.SpineQIcon.Base
	local var_16_1 = var_0.ConstPath.SpineQIcon.FixList
	local var_16_2 = {}

	if arg_16_0 and #arg_16_0 > 0 then
		_ = var_4

		var_4.each(var_16_1, function(arg_17_0)
			table = var_2_10001

			local var_17_0 = var_2_10001.insert
			local var_17_1 = var_16_2

			string = var_2_10004

			local var_17_2 = var_2_10004.lower

			string = var_2_10006

			var_17_0(var_17_1, var_17_2(var_2_10006.format(var_16_0, arg_16_0, arg_17_0)))

			return
		end)
	end

	return var_16_2
end

function var_0.GetSpineModelsByPrefabName(arg_18_0)
	local var_18_0 = var_0.ConstPath.SpineModel.Base
	local var_18_1 = var_0.ConstPath.SpineModel.FixList
	local var_18_2 = {}

	if arg_18_0 and #arg_18_0 > 0 then
		_ = var_4

		var_4.each(var_18_1, function(arg_19_0)
			table = var_2_10001

			local var_19_0 = var_2_10001.insert
			local var_19_1 = var_18_2

			string = var_2_10004

			local var_19_2 = var_2_10004.lower

			string = var_2_10006

			var_19_0(var_19_1, var_19_2(var_2_10006.format(var_18_0, arg_18_0, arg_19_0)))

			return
		end)
	end

	return var_18_2
end

function var_0.GetPaintingListByPaintingName(arg_20_0)
	local var_20_0 = var_0.ConstPath.Painting.Base
	local var_20_1 = var_0.ConstPath.Painting.FixList
	local var_20_2 = {}

	if arg_20_0 and #arg_20_0 > 0 then
		_ = var_4

		var_4.each(var_20_1, function(arg_21_0)
			table = var_2_10001

			local var_21_0 = var_2_10001.insert
			local var_21_1 = var_20_2

			string = var_2_10004

			local var_21_2 = var_2_10004.lower

			string = var_2_10006

			var_21_0(var_21_1, var_21_2(var_2_10006.format(var_20_0, arg_20_0, arg_21_0)))

			return
		end)
	end

	return var_20_2
end

function var_0.GetPaintingFaceListByPaintingName(arg_22_0)
	local var_22_0 = var_0.ConstPath.PaintingFace.Base
	local var_22_1 = var_0.ConstPath.PaintingFace.FixList
	local var_22_2 = {}

	if arg_22_0 and #arg_22_0 > 0 then
		_ = var_4

		var_4.each(var_22_1, function(arg_23_0)
			table = var_2_10001

			local var_23_0 = var_2_10001.insert
			local var_23_1 = var_22_2

			string = var_2_10004

			local var_23_2 = var_2_10004.lower

			string = var_2_10006

			var_23_0(var_23_1, var_23_2(var_2_10006.format(var_22_0, arg_22_0, arg_23_0)))

			return
		end)
	end

	return var_22_2
end

function var_0.GetPaintingShipYardIconListByPaintingName(arg_24_0)
	local var_24_0 = var_0.ConstPath.PaintingShipYardIcon.Base
	local var_24_1 = var_0.ConstPath.PaintingShipYardIcon.FixList
	local var_24_2 = {}

	if arg_24_0 and #arg_24_0 > 0 then
		_ = var_4

		var_4.each(var_24_1, function(arg_25_0)
			table = var_2_10001

			local var_25_0 = var_2_10001.insert
			local var_25_1 = var_24_2

			string = var_2_10004

			local var_25_2 = var_2_10004.lower

			string = var_2_10006

			var_25_0(var_25_1, var_25_2(var_2_10006.format(var_24_0, arg_24_0, arg_25_0)))

			return
		end)
	end

	return var_24_2
end

function var_0.GetPaintingSquareIconListByPaintingName(arg_26_0)
	local var_26_0 = var_0.ConstPath.PaintingSquareIcon.Base
	local var_26_1 = var_0.ConstPath.PaintingSquareIcon.FixList
	local var_26_2 = {}

	if arg_26_0 and #arg_26_0 > 0 then
		_ = var_4

		var_4.each(var_26_1, function(arg_27_0)
			table = var_2_10001

			local var_27_0 = var_2_10001.insert
			local var_27_1 = var_26_2

			string = var_2_10004

			local var_27_2 = var_2_10004.lower

			string = var_2_10006

			var_27_0(var_27_1, var_27_2(var_2_10006.format(var_26_0, arg_26_0, arg_27_0)))

			return
		end)
	end

	return var_26_2
end

function var_0.GetPaintingHeroHrzIconListByPaintingName(arg_28_0)
	local var_28_0 = var_0.ConstPath.PaintingHeroHrzIcon.Base
	local var_28_1 = var_0.ConstPath.PaintingHeroHrzIcon.FixList
	local var_28_2 = {}

	if arg_28_0 and #arg_28_0 > 0 then
		_ = var_4

		var_4.each(var_28_1, function(arg_29_0)
			table = var_2_10001

			local var_29_0 = var_2_10001.insert
			local var_29_1 = var_28_2

			string = var_2_10004

			local var_29_2 = var_2_10004.lower

			string = var_2_10006

			var_29_0(var_29_1, var_29_2(var_2_10006.format(var_28_0, arg_28_0, arg_29_0)))

			return
		end)
	end

	return var_28_2
end

function var_0.GetShipSkinPaintingList(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.ship_skin_template[arg_30_0].painting

	return var_0.GetPaintingListByPaintingName(var_30_0)
end

function var_0.GetShipSkinPaintingFaceList(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.ship_skin_template[arg_31_0].painting

	return var_0.GetPaintingFaceListByPaintingName(var_31_0)
end

function var_0.GetShipSkinPaintingShipYardIconList(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.ship_skin_template[arg_32_0].painting

	return var_0.GetPaintingShipYardIconListByPaintingName(var_32_0)
end

function var_0.GetShipSkinPaintingSquareIconList(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.ship_skin_template[arg_33_0].painting

	return var_0.GetPaintingSquareIconListByPaintingName(var_33_0)
end

function var_0.GetShipSkinPaintingHeroHrzIconList(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.ship_skin_template[arg_34_0].painting

	return var_0.GetPaintingHeroHrzIconListByPaintingName(var_34_0)
end

function var_0.GetShipSkinSpineQIconList(arg_35_0)
	local var_35_0 = var_0.ConstPath.SpineQIcon.Base
	local var_35_1 = var_0.ConstPath.SpineQIcon.FixList

	pg = var_1_10003

	local var_35_2 = var_1_10003.ship_skin_template[arg_35_0].painting
	local var_35_3 = {}

	_ = var_1_10006

	var_1_10006.each(var_35_1, function(arg_36_0)
		table = var_2_10001

		local var_36_0 = var_2_10001.insert
		local var_36_1 = var_35_3

		string = var_2_10004

		var_36_0(var_36_1, var_2_10004.format(var_35_0, var_35_2, arg_36_0))

		return
	end)

	return var_35_3
end

function var_0.GetShipSkinSpineShipModelList(arg_37_0)
	local var_37_0 = var_0.ConstPath.SpineModel.Base
	local var_37_1 = var_0.ConstPath.SpineModel.FixList

	pg = var_1_10003

	local var_37_2 = var_1_10003.ship_skin_template[arg_37_0].painting
	local var_37_3 = {}

	_ = var_1_10006

	var_1_10006.each(var_37_1, function(arg_38_0)
		table = var_2_10001

		local var_38_0 = var_2_10001.insert
		local var_38_1 = var_37_3

		string = var_2_10004

		var_38_0(var_38_1, var_2_10004.format(var_37_0, var_37_2, arg_38_0))

		return
	end)

	return var_37_3
end

function var_0.GetShipSkinSpineCharList(arg_39_0)
	local var_39_0 = var_0.ConstPath.SpineChar.Base
	local var_39_1 = var_0.ConstPath.SpineChar.FixList

	pg = var_1_10003

	local var_39_2 = var_1_10003.ship_skin_template[arg_39_0].painting
	local var_39_3 = {}

	_ = var_1_10006

	var_1_10006.each(var_39_1, function(arg_40_0)
		table = var_2_10001

		local var_40_0 = var_2_10001.insert
		local var_40_1 = var_39_3

		string = var_2_10004

		var_40_0(var_40_1, var_2_10004.format(var_39_0, var_39_2, arg_40_0))

		return
	end)

	return var_39_3
end

function var_0.GetShipSkinLive2DList(arg_41_0)
	local var_41_0 = var_0.ConstPath.Live2D.Base
	local var_41_1 = var_0.ConstPath.Live2D.FixList

	pg = var_1_10003

	local var_41_2 = var_1_10003.ship_skin_template[arg_41_0].painting
	local var_41_3 = {}

	_ = var_1_10006

	var_1_10006.each(var_41_1, function(arg_42_0)
		table = var_2_10001

		local var_42_0 = var_2_10001.insert
		local var_42_1 = var_41_3

		string = var_2_10004

		var_42_0(var_42_1, var_2_10004.format(var_41_0, var_41_2, arg_42_0))

		return
	end)

	return var_41_3
end

function var_0.GetShipSkinSpinePaintingList(arg_43_0)
	local var_43_0 = var_0.ConstPath.SpinePainting.Base
	local var_43_1 = var_0.ConstPath.SpinePainting.FixList

	pg = var_1_10003

	local var_43_2 = var_1_10003.ship_skin_template[arg_43_0].painting
	local var_43_3 = {}

	_ = var_1_10006

	var_1_10006.each(var_43_1, function(arg_44_0)
		table = var_2_10001

		local var_44_0 = var_2_10001.insert
		local var_44_1 = var_43_3

		string = var_2_10004

		var_44_0(var_44_1, var_2_10004.format(var_43_0, var_43_2, arg_44_0))

		return
	end)

	return var_43_3
end

function var_0.GetShipSkinEffectList(arg_45_0)
	local var_45_0 = var_0.ConstPath.UI.Base
	local var_45_1 = {}

	pg = var_1_10003

	if var_1_10003.ship_skin_template[arg_45_0].special_effects then
		local var_45_2 = #var_3.special_effects

		if 0 < var_45_2 then
			local var_45_3 = var_3.special_effects[1]

			table = var_5

			var_5.insert(var_45_1, var_0.CombinePath(var_45_0, var_45_3))
		end
	end

	return var_45_1
end

function var_0.GetShipSkinSoundList(arg_46_0)
	pg = var_1_10001

	local var_46_0 = var_1_10001.ship_skin_template[arg_46_0].bgm
	local var_46_1 = {}

	if var_46_0 and #var_46_0 > 0 then
		var_46_1 = var_0.GetSoundResList(var_46_0)
	end

	return var_46_1
end

function var_0.GetShipAllRes(arg_47_0)
	local var_47_0 = arg_47_0.configId
	local var_47_1 = arg_47_0:getSkinId()
	local var_47_2 = {
		"spinematerials",
		"ui/lihui_qiehuan01",
		"ui/lihui_qiehuan02",
		"effect/jiehuntexiao"
	}
	local var_47_3 = var_0.GetShipRarityBgList(var_47_0)
	local var_47_4 = var_0.GetShipSkinBgList(var_47_1)
	local var_47_5 = var_0.GetSkillIconList(var_47_0)
	local var_47_6 = var_0.GetShipSkinSoundList(var_47_1)
	local var_47_7 = var_0.GetShipSkinSpineQIconList(var_47_1)
	local var_47_8 = var_0.GetShipSkinSpineShipModelList(var_47_1)
	local var_47_9 = var_0.GetShipSkinSpineCharList(var_47_1)
	local var_47_10 = var_0.GetShipSkinSpinePaintingList(var_47_1)
	local var_47_11 = var_0.GetShipSkinPaintingList(var_47_1)
	local var_47_12 = var_0.GetShipSkinPaintingFaceList(var_47_1)
	local var_47_13 = var_0.GetShipSkinPaintingShipYardIconList(var_47_1)
	local var_47_14 = var_0.GetShipSkinPaintingSquareIconList(var_47_1)
	local var_47_15 = var_0.GetShipSkinPaintingHeroHrzIconList(var_47_1)
	local var_47_16 = var_0.GetShipSkinEffectList(var_47_1)

	return (var_0.MergeLuaArr(var_47_2, var_47_3, var_47_4, var_47_5, var_47_6, var_47_7, var_47_8, var_47_9, var_47_10, var_47_11, var_47_12, var_47_13, var_47_14, var_47_15, var_47_16))
end

return
