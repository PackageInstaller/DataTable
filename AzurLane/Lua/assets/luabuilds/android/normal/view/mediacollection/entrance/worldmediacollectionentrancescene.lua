class = var_0_10000

local var_0_0 = "WorldMediaCollectionEntranceScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionEntranceUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.recallBtn = var_1.Find(var_2_0, "Main/recall")

	local var_2_1 = arg_2_0._tf

	arg_2_0.recallBtn2 = var_1.Find(var_2_1, "Main/recall2")

	local var_2_2 = arg_2_0._tf

	arg_2_0.cryptolaliaBtn = var_1.Find(var_2_2, "Main/cryptolalia")

	local var_2_3 = arg_2_0._tf

	arg_2_0.archiveBtn = var_1.Find(var_2_3, "Main/archive")

	local var_2_4 = arg_2_0.archiveBtn

	arg_2_0.archiveLockTF = var_1.Find(var_2_4, "lock")

	local var_2_5 = arg_2_0._tf

	arg_2_0.recordBtn = var_1.Find(var_2_5, "Main/record")

	local var_2_6 = arg_2_0._tf

	arg_2_0.albumBtn = var_1.Find(var_2_6, "Main/album")
	setActive = var_1

	local var_2_7 = arg_2_0.albumBtn

	LOCK_ALBUM = var_3

	var_1(var_2_7, not var_3)

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "Main/empty")

	SetCompomentEnabled = var_2_8

	local var_2_10 = var_2_9
	local var_2_11 = "Image"

	LOCK_ALBUM = var_1_10005

	var_2_8(var_2_10, var_2_11, var_1_10005)

	setActive = var_2_8

	local var_2_12 = var_2_9
	local var_2_13 = var_2_9.Find(var_2_12, "Image")

	LOCK_ALBUM = var_2_12

	var_2_8(var_2_13, not var_2_12)

	setActive = var_2_8

	local var_2_14 = var_2_9
	local var_2_15 = var_2_9.Find(var_2_14, "Image1")

	LOCK_ALBUM = var_2_14

	var_2_8(var_2_15, var_2_14)

	local var_2_16 = arg_2_0._tf

	arg_2_0.optionBtn = var_2.Find(var_2_16, "Top/blur_panel/adapt/top/option")

	local var_2_17 = arg_2_0._tf

	arg_2_0.backBtn = var_2.Find(var_2_17, "Top/blur_panel/adapt/top/back_btn")
	setText = var_2

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "Main/empty/label")

	i18n = var_2_18

	var_2(var_2_19, var_2_18("cryptolalia_unopen"))

	setText = var_2

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "Main/empty1/label")

	i18n = var_2_20

	var_2(var_2_21, var_2_20("cryptolalia_unopen"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.optionBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.backBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.recallBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		WorldMediaCollectionEntranceMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.OPEN_RECALL)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.recallBtn2

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		WorldMediaCollectionEntranceMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.OPEN_NEWRECALL)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.cryptolaliaBtn

	local function var_3_14()
		LOCK_CRYPTOLALIA = var_2_10000

		if var_2_10000 then
			pg = var_2_10000

			local var_8_0 = var_2_10000.TipsMgr.GetInstance()
			local var_8_1 = var_0.ShowTips

			i18n = var_2_10002

			var_8_1(var_8_0, var_2_10002("word_comingSoon"))
		else
			local var_8_2 = arg_3_0
			local var_8_3 = var_0.emit

			WorldMediaCollectionEntranceMediator = var_2_10002

			var_8_3(var_8_2, var_2_10002.OPEN_CRYPTOLALIA)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	pg = var_1_10001

	local var_3_15 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_3_16 = var_1.isOpenSystem

	getProxy = var_3_13
	PlayerProxy = var_3_14

	local var_3_17 = var_3_13(var_3_14)
	local var_3_18 = var_3_16(var_3_15, var_3.getRawData(var_3_17).level, "WorldMediator")

	setActive = var_3_15

	var_3_15(arg_3_0.archiveLockTF, not var_3_18)

	onButton = var_3_15

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.archiveBtn

	local function var_3_21()
		if not var_3_18 then
			pg = var_0

			local var_9_0 = var_0.open_systems_limited[19]

			pg = var_2_10001
			var_2_10002 = var_2_10001.TipsMgr.GetInstance()

			local var_9_1 = var_1.ShowTips

			i18n = var_2_10003

			var_9_1(var_2_10002, var_2_10003("no_open_system_tip", var_9_0.name, var_9_0.level))

			return
		end

		local var_9_2 = arg_3_0
		local var_9_3 = var_0.emit

		WorldMediaCollectionEntranceMediator = var_2_10002

		var_9_3(var_9_2, var_2_10002.OPEN_ARCHIVE)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_15(var_3_19, var_3_20, var_3_21, var_1_10006)

	onButton = var_3_15

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.recordBtn

	local function var_3_24()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		WorldMediaCollectionEntranceMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.OPEN_RECORD)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_15(var_3_22, var_3_23, var_3_24, var_1_10006)

	onButton = var_3_15

	local var_3_25 = arg_3_0
	local var_3_26 = arg_3_0.albumBtn

	local function var_3_27()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		WorldMediaCollectionEntranceMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.OPEN_ALBUM)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_15(var_3_25, var_3_26, var_3_27, var_1_10006)

	return
end

function var_0_1.willExit(arg_12_0)
	return
end

return var_0_1
