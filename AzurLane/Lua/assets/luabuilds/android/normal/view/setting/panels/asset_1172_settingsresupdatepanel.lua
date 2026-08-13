class = var_0_10000

local var_0_0 = "SettingsResUpdatePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsResUpdate"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_resManage")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / RESOURCES"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.tpl = var_1.Find(var_4_0, "Tpl")

	local var_4_1 = arg_4_0._tf

	arg_4_0.iconTF = var_1.Find(var_4_1, "Icon")

	local var_4_2 = arg_4_0._tf

	arg_4_0.fullTF = var_1.Find(var_4_2, "options_full")

	local var_4_3 = arg_4_0._tf

	arg_4_0.mainTF = var_1.Find(var_4_3, "options_main")

	local var_4_4 = arg_4_0._tf

	arg_4_0.fullTitleText = var_1.Find(var_4_4, "options_full/Title/Text")

	local var_4_5 = arg_4_0._tf

	arg_4_0.mainTitleText = var_1.Find(var_4_5, "options_main/Title/Text")

	local var_4_6 = arg_4_0._tf

	arg_4_0.specialTitleText = var_1.Find(var_4_6, "options_special/Title/Text")
	setText = var_1

	local var_4_7 = arg_4_0.fullTitleText

	i18n = var_3

	var_1(var_4_7, var_3("Settings_title_resManage_All"))

	setText = var_1

	local var_4_8 = arg_4_0.mainTitleText

	i18n = var_3

	var_1(var_4_8, var_3("Settings_title_resManage_Main"))

	setText = var_1

	local var_4_9 = arg_4_0.specialTitleText

	i18n = var_3

	var_1(var_4_9, var_3("Settings_title_resManage_Sub"))

	local var_4_10 = arg_4_0._tf

	arg_4_0.fullGroupTF = var_1.Find(var_4_10, "options_full/MainGroup")

	local var_4_11 = arg_4_0._tf

	arg_4_0.mainContainerTF = var_1.Find(var_4_11, "options_main/list")

	local var_4_12 = arg_4_0._tf

	arg_4_0.specialContainerTF = var_1.Find(var_4_12, "options_special/list")
	GroupMainHelper = var_1

	local var_4_13 = not var_1.IsVerSameWithServer()

	setActive = var_4_12

	var_4_12(arg_4_0.fullTF, var_4_13)

	if var_4_13 then
		SettingsMainGroupBtn = var_4_12
		arg_4_0.mainGroupBtn = var_4_12.New(arg_4_0.fullGroupTF)
		GetComponent = var_4_12

		local var_4_14 = arg_4_0.mainTF

		typeof = var_4
		VerticalLayoutGroup = var_1_10005
		var_4_12 = var_4_12(var_4_14, var_4(var_1_10005)).padding
		var_4_12.top = 0
	else
		GetComponent = var_4_12

		local var_4_15 = arg_4_0.fullTF

		typeof = var_4
		VerticalLayoutGroup = var_1_10005
		var_4_12 = var_4_12(var_4_15, var_4(var_1_10005)).padding.top
		GetComponent = var_4_15

		local var_4_16 = arg_4_0.mainTF

		typeof = var_1_10005
		VerticalLayoutGroup = var_1_10006
		var_4_15(var_4_16, var_1_10005(var_1_10006)).padding.top = var_4_12
	end

	SettingsGalleryBtn = var_4_12

	local var_4_17 = var_4_12.New
	local var_4_18 = {
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF
	}

	getImageSprite = var_4

	local var_4_19 = arg_4_0.iconTF

	var_4_18.iconSP = var_4(var_5.Find(var_4_19, "GALLERY_PIC"))
	arg_4_0.galleryBtn = var_4_17(var_4_18)
	SettingsMangaBtn = var_2

	local var_4_20 = var_2.New
	local var_4_21 = {
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF
	}

	getImageSprite = var_4

	local var_4_22 = arg_4_0.iconTF

	var_4_21.iconSP = var_4(var_5.Find(var_4_22, "MANGA"))
	arg_4_0.mangaBtn = var_4_20(var_4_21)
	SettingsDormBtn = var_2

	local var_4_23 = var_2.New
	local var_4_24 = {
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF
	}

	getImageSprite = var_4

	local var_4_25 = arg_4_0.iconTF

	var_4_24.iconSP = var_4(var_5.Find(var_4_25, "DORM"))
	arg_4_0.dormBtn = var_4_23(var_4_24)
	SettingsMapBtn = var_2

	local var_4_26 = var_2.New
	local var_4_27 = {
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF
	}

	getImageSprite = var_4

	local var_4_28 = arg_4_0.iconTF

	var_4_27.iconSP = var_4(var_5.Find(var_4_28, "MAP"))
	arg_4_0.mapBtn = var_4_26(var_4_27)
	SettingsResRepairBtn = var_2

	local var_4_29 = var_2.New
	local var_4_30 = {
		isDel = false,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF
	}

	getImageSprite = var_4

	local var_4_31 = arg_4_0.iconTF

	var_4_30.iconSP = var_4(var_5.Find(var_4_31, "REPAIR"))
	arg_4_0.repairBtn = var_4_29(var_4_30)
	SettingsSoundBtn = var_2

	local var_4_32 = var_2.New
	local var_4_33 = {
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF
	}

	getImageSprite = var_4

	local var_4_34 = arg_4_0.iconTF

	var_4_33.iconSP = var_4(var_5.Find(var_4_34, "CV"))
	arg_4_0.soundBtn = var_4_32(var_4_33)
	SettingsLive2DBtn = var_2

	local var_4_35 = var_2.New
	local var_4_36 = {
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF
	}

	getImageSprite = var_4

	local var_4_37 = arg_4_0.iconTF

	var_4_36.iconSP = var_4(var_5.Find(var_4_37, "L2D"))
	arg_4_0.live2dBtn = var_4_35(var_4_36)
	SettingsMusicBtn = var_2

	local var_4_38 = var_2.New
	local var_4_39 = {
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF
	}

	getImageSprite = var_4

	local var_4_40 = arg_4_0.iconTF

	var_4_39.iconSP = var_4(var_5.Find(var_4_40, "GALLERY_BGM"))
	arg_4_0.musicBtn = var_4_38(var_4_39)
	LOCK_ISLAND_DISPLAY = var_2

	if var_2 then
		setActive = var_2

		var_2(arg_4_0.mapBtn._tf, false)
	end

	return
end

function var_0_1.Dispose(arg_5_0)
	var_0_1.super.Dispose(arg_5_0)

	if arg_5_0:IsLoaded() then
		local var_5_0 = arg_5_0.repairBtn

		var_1.Dispose(var_5_0)

		arg_5_0.repairBtn = nil

		local var_5_1 = arg_5_0.live2dBtn

		var_1.Dispose(var_5_1)

		arg_5_0.live2dBtn = nil

		local var_5_2 = arg_5_0.galleryBtn

		var_1.Dispose(var_5_2)

		arg_5_0.galleryBtn = nil

		local var_5_3 = arg_5_0.soundBtn

		var_1.Dispose(var_5_3)

		arg_5_0.soundBtn = nil

		local var_5_4 = arg_5_0.musicBtn

		var_1.Dispose(var_5_4)

		arg_5_0.musicBtn = nil

		local var_5_5 = arg_5_0.mangaBtn

		var_1.Dispose(var_5_5)

		arg_5_0.mangaBtn = nil

		local var_5_6 = arg_5_0.dormBtn

		var_1.Dispose(var_5_6)

		arg_5_0.dormBtn = nil

		local var_5_7 = arg_5_0.mapBtn

		var_1.Dispose(var_5_7)

		arg_5_0.mapBtn = nil

		if arg_5_0.mainGroupBtn then
			local var_5_8 = arg_5_0.mainGroupBtn

			var_1.Dispose(var_5_8)

			arg_5_0.mainGroupBtn = nil
		end
	end

	return
end

return var_0_1
