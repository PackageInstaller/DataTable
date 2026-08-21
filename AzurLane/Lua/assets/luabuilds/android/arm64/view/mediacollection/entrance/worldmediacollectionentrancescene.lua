local var_0_0 = class("WorldMediaCollectionEntranceScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionEntranceUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.recallBtn = arg_2_0._tf:Find("Main/recall")
	arg_2_0.recallBtn2 = arg_2_0._tf:Find("Main/recall2")
	arg_2_0.cryptolaliaBtn = arg_2_0._tf:Find("Main/cryptolalia")
	arg_2_0.archiveBtn = arg_2_0._tf:Find("Main/archive")
	arg_2_0.archiveLockTF = arg_2_0.archiveBtn:Find("lock")
	arg_2_0.recordBtn = arg_2_0._tf:Find("Main/record")
	arg_2_0.albumBtn = arg_2_0._tf:Find("Main/album")

	setActive(arg_2_0.albumBtn, not LOCK_ALBUM)

	local var_2_0 = arg_2_0._tf:Find("Main/empty")

	SetCompomentEnabled(var_2_0, "Image", LOCK_ALBUM)
	setActive(var_2_0:Find("Image"), not LOCK_ALBUM)
	setActive(var_2_0:Find("Image1"), LOCK_ALBUM)

	arg_2_0.optionBtn = arg_2_0._tf:Find("Top/blur_panel/adapt/top/option")
	arg_2_0.backBtn = arg_2_0._tf:Find("Top/blur_panel/adapt/top/back_btn")

	setText(arg_2_0._tf:Find("Main/empty/label"), i18n("cryptolalia_unopen"))
	setText(arg_2_0._tf:Find("Main/empty1/label"), i18n("cryptolalia_unopen"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.optionBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.recallBtn, function()
		arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_RECALL)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.recallBtn2, function()
		arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_NEWRECALL)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cryptolaliaBtn, function()
		if LOCK_CRYPTOLALIA then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))
		else
			arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_CRYPTOLALIA)
		end

		return
	end, SFX_PANEL)
	setActive(arg_3_0.archiveLockTF, not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "WorldMediator"))
	onButton(arg_3_0, arg_3_0.archiveBtn, function()
		if not var_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("no_open_system_tip", pg.open_systems_limited[19].name, pg.open_systems_limited[19].level))

			return
		end

		arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_ARCHIVE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.recordBtn, function()
		arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_RECORD)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.albumBtn, function()
		arg_3_0:emit(WorldMediaCollectionEntranceMediator.OPEN_ALBUM)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.willExit(arg_12_0)
	return
end

return var_0_0
