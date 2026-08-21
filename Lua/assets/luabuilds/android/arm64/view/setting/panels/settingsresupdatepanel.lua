local var_0_0 = class("SettingsResUpdatePanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsResUpdate"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_resManage")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / RESOURCES"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.tpl = arg_4_0._tf:Find("Tpl")
	arg_4_0.iconTF = arg_4_0._tf:Find("Icon")
	arg_4_0.fullTF = arg_4_0._tf:Find("options_full")
	arg_4_0.mainTF = arg_4_0._tf:Find("options_main")
	arg_4_0.fullTitleText = arg_4_0._tf:Find("options_full/Title/Text")
	arg_4_0.mainTitleText = arg_4_0._tf:Find("options_main/Title/Text")
	arg_4_0.specialTitleText = arg_4_0._tf:Find("options_special/Title/Text")

	setText(arg_4_0.fullTitleText, i18n("Settings_title_resManage_All"))
	setText(arg_4_0.mainTitleText, i18n("Settings_title_resManage_Main"))
	setText(arg_4_0.specialTitleText, i18n("Settings_title_resManage_Sub"))

	arg_4_0.fullGroupTF = arg_4_0._tf:Find("options_full/MainGroup")
	arg_4_0.mainContainerTF = arg_4_0._tf:Find("options_main/list")
	arg_4_0.specialContainerTF = arg_4_0._tf:Find("options_special/list")

	local var_4_0 = not GroupMainHelper.IsVerSameWithServer()

	setActive(arg_4_0.fullTF, var_4_0)

	if var_4_0 then
		arg_4_0.mainGroupBtn = SettingsMainGroupBtn.New(arg_4_0.fullGroupTF)
		GetComponent(arg_4_0.mainTF, typeof(VerticalLayoutGroup)).padding.top = 0
	else
		GetComponent(arg_4_0.mainTF, typeof(VerticalLayoutGroup)).padding.top = GetComponent(arg_4_0.fullTF, typeof(VerticalLayoutGroup)).padding.top
	end

	arg_4_0.galleryBtn = SettingsGalleryBtn.New({
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("GALLERY_PIC"))
	})
	arg_4_0.mangaBtn = SettingsMangaBtn.New({
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("MANGA"))
	})
	arg_4_0.dormBtn = SettingsDormBtn.New({
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("DORM"))
	})
	arg_4_0.mapBtn = SettingsMapBtn.New({
		isDel = true,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("MAP"))
	})
	arg_4_0.repairBtn = SettingsResRepairBtn.New({
		isDel = false,
		tpl = arg_4_0.tpl,
		container = arg_4_0.specialContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("REPAIR"))
	})
	arg_4_0.soundBtn = SettingsSoundBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("CV"))
	})
	arg_4_0.live2dBtn = SettingsLive2DBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("L2D"))
	})
	arg_4_0.musicBtn = SettingsMusicBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.mainContainerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("GALLERY_BGM"))
	})

	if LOCK_ISLAND_DISPLAY then
		setActive(arg_4_0.mapBtn._tf, false)
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if arg_5_0:IsLoaded() then
		arg_5_0.repairBtn:Dispose()

		arg_5_0.repairBtn = nil

		arg_5_0.live2dBtn:Dispose()

		arg_5_0.live2dBtn = nil

		arg_5_0.galleryBtn:Dispose()

		arg_5_0.galleryBtn = nil

		arg_5_0.soundBtn:Dispose()

		arg_5_0.soundBtn = nil

		arg_5_0.musicBtn:Dispose()

		arg_5_0.musicBtn = nil

		arg_5_0.mangaBtn:Dispose()

		arg_5_0.mangaBtn = nil

		arg_5_0.dormBtn:Dispose()

		arg_5_0.dormBtn = nil

		arg_5_0.mapBtn:Dispose()

		arg_5_0.mapBtn = nil

		if arg_5_0.mainGroupBtn then
			arg_5_0.mainGroupBtn:Dispose()

			arg_5_0.mainGroupBtn = nil
		end
	end

	return
end

return var_0_0
