class = var_0_10000

local var_0_0 = "FulankelinMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))
local var_0_2 = 71122

ActivityConst = var_0_0

local var_0_3 = var_0_0.Valleyhospital_ACT_ID

ActivityConst = var_3

local var_0_4 = var_3.Valleyhospital_ACT_ID

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.ad = var_1.Find(var_1_0, "AD")
	findTF = var_1
	arg_1_0.btnCollect = var_1(arg_1_0.ad, "btnCollect")
	findTF = var_1
	arg_1_0.btnSkin = var_1(arg_1_0.ad, "btnSkin")
	findTF = var_1
	arg_1_0.btnSkinText = var_1(arg_1_0.btnSkin, "bgTime/text")
	findTF = var_1
	arg_1_0.btnAct = var_1(arg_1_0.ad, "btnAct")
	findTF = var_1
	arg_1_0.btnActText = var_1(arg_1_0.btnAct, "bgTime/text")
	findTF = var_1
	arg_1_0.btnBuild = var_1(arg_1_0.ad, "btnBuild")
	findTF = var_1
	arg_1_0.btnBuildText = var_1(arg_1_0.btnBuild, "bgTime/text")
	GetComponent = var_1

	local var_1_1 = arg_1_0.btnCollect

	typeof = var_4
	Image = var_1_10006

	local var_1_2 = var_1(var_1_1, var_4(var_1_10006))

	var_1.SetNativeSize(var_1_2)

	GetComponent = var_1

	local var_1_3 = arg_1_0.btnSkin

	typeof = var_4
	Image = var_1_10006

	local var_1_4 = var_1(var_1_3, var_4(var_1_10006))

	var_1.SetNativeSize(var_1_4)

	GetComponent = var_1

	local var_1_5 = arg_1_0.btnAct

	typeof = var_4
	Image = var_1_10006

	local var_1_6 = var_1(var_1_5, var_4(var_1_10006))

	var_1.SetNativeSize(var_1_6)

	GetComponent = var_1

	local var_1_7 = arg_1_0.btnBuild

	typeof = var_4
	Image = var_1_10006

	local var_1_8 = var_1(var_1_7, var_4(var_1_10006))

	var_1.SetNativeSize(var_1_8)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.btnCollect, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.WORLD_COLLECTION
		local var_2_4 = {}

		WorldMediaCollectionScene = var_2_10006
		var_2_4.page = var_2_10006.PAGE_ALBUM

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)

	onButton = var_1

	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.btnSkin

	local function var_1_11()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SKINSHOP)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_9, var_1_10, var_1_11, var_1_10006)

	onButton = var_1

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.btnAct

	local function var_1_14()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.CLUE_MAP)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_12, var_1_13, var_1_14, var_1_10006)

	onButton = var_1

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.btnBuild

	local function var_1_17()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_5_3 = var_2_10004.GETBOAT
		local var_5_4 = {}

		BuildShipScene = var_2_10006
		var_5_4.page = var_2_10006.PAGE_BUILD

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_15, var_1_16, var_1_17, var_1_10006)

	return
end

function var_0_1.OnDataSetting(arg_6_0)
	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	arg_7_0:updateUI()

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	arg_8_0:updateUI()

	return
end

function var_0_1.updateUI(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()
	local var_9_1 = var_1.inTime

	pg = var_1_10004

	local var_9_2, var_9_3 = var_9_1(var_9_0, var_1_10004.shop_template[var_0_2].time)
	local var_9_4
	local var_9_6

	if var_9_3 then
		pg = var_9_6

		local var_9_5 = var_9_6.TimeMgr.GetInstance()

		var_9_6 = var_9_6.Table2ServerTime(var_9_5, var_9_3)
		skinCommdityTimeStamp = var_5
		var_9_4 = var_5(var_9_6)
	end

	pg = var_9_6

	local var_9_7 = var_9_6.TimeMgr.GetInstance()
	local var_9_8 = var_4.inTime

	pg = var_1_10007

	local var_9_9, var_9_10 = var_9_8(var_9_7, var_1_10007.activity_template[var_0_4].time)
	local var_9_11
	local var_9_12

	if var_9_10 then
		pg = var_9_12
		var_1_10009 = var_9_12.TimeMgr.GetInstance()
		var_9_12 = var_9_12.Table2ServerTime(var_1_10009, var_9_10)
		skinCommdityTimeStamp = var_8
		var_9_11 = var_8(var_9_12)
	end

	if var_9_4 then
		setText = var_9_12

		var_9_12(arg_9_0.btnSkinText, var_9_4)
	else
		setActive = var_9_12
		findTF = var_1_10009

		var_9_12(var_1_10009(arg_9_0.btnSkin, "bgTime"), false)
	end

	setText = var_9_12

	var_9_12(arg_9_0.btnActText, "")

	if var_9_11 then
		setText = var_9_12

		var_9_12(arg_9_0.btnBuildText, var_9_11)
	else
		setActive = var_9_12
		findTF = var_9

		var_9_12(var_9(arg_9_0.btnBuild, "bgTime"), false)
	end

	return
end

return var_0_1
