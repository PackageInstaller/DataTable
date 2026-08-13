class = var_0_10000

local var_0_0 = "CourtYardTopPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "main/topPanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "btns/topleft/return")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "btns/topleft/name/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.renameBtn = var_1.Find(var_2_4, "btns/topleft/name")

	local var_2_5 = arg_2_0._tf

	arg_2_0.comfortableBtn = var_1.Find(var_2_5, "btns/topright/comfortable")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "btns/topright/comfortable/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.comfortableTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "btns/topright/comfortable/icon")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.comfortableImg = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_12, "btns/topright/switch")

	local var_2_13 = arg_2_0.switchBtn
	local var_2_14 = var_1.Find(var_2_13, "Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.switchTxt = var_2_15(var_2_14, var_3(var_1_10004))
	CourtYardRenamePage = var_1
	arg_2_0.renamePage = var_1.New(arg_2_0._tf.parent.parent, arg_2_0.parent.event)
	CourtYardComfortablePage = var_1
	arg_2_0.comfortablePage = var_1.New(arg_2_0._tf.parent.parent, arg_2_0.parent.event)
	GetOrAddComponent = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "btns/topright")

	typeof = var_2_16
	CanvasGroup = var_4
	arg_2_0.cg = var_1(var_2_17, var_2_16(var_4))
	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "btns/topright/comfortable/label")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("word_comfort_level"))

	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_2.Find(var_2_20, "btns/topright/switch/label")

	i18n = var_2_20

	var_1(var_2_21, var_2_20("courtyard_label_floor"))

	return
end

function var_0_1.OnRegister(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.renameBtn

	local function var_3_2()
		if arg_3_0.cg.blocksRaycasts then
			local var_4_0 = arg_3_0.renamePage

			var_0.ExecuteAction(var_4_0, "Flush")
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.backBtn

	local function var_3_5()
		_courtyard = var_2_10000

		local var_5_0 = var_2_10000:GetController()

		var_0.Quit(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.comfortableBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.comfortablePage

		var_0.ExecuteAction(var_6_0, "Show", arg_3_0.dorm)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.switchBtn

	local function var_3_11()
		local var_7_0 = arg_3_0.contextData.floor == 1 and 2 or 1
		local var_7_1 = arg_3_0.dorm

		if not var_2.isUnlockFloor(var_7_1, var_7_0) then
			local var_7_2 = arg_3_0

			var_2.UnLockTip(var_7_2)
		else
			local var_7_3 = arg_3_0
			local var_7_4 = var_2.emit

			CourtYardMediator = var_4

			var_7_4(var_7_3, var_4.SWITCH, var_7_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.UnLockTip(arg_8_0)
	local var_8_0 = arg_8_0.dorm
	local var_8_1

	if not var_1.IsMaxLevel(var_8_0) then
		pg = var_8_1
		var_8_0 = var_8_1.TipsMgr.GetInstance()
		var_8_1 = var_8_1.ShowTips
		i18n = var_1_10003

		var_8_1(var_8_0, var_1_10003("sec_floor_limit_tip"))

		return
	end

	ShopArgs = var_8_1

	local var_8_2 = var_8_1.DORM_FLOOR_ID

	pg = var_8_0

	local var_8_3 = var_8_0.shop_template[var_8_2].resource_num

	_BackyardMsgBoxMgr = var_1_10003

	local var_8_4 = var_1_10003
	local var_8_5 = var_1_10003.Show
	local var_8_6 = {}

	i18n = var_1_10006
	var_8_6.content = var_1_10006("backyard_open_2floor", var_8_3)

	function var_8_6.onYes()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		CourtYardMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.UN_LOCK_2FLOOR, var_8_2, 1)

		return
	end

	var_8_5(var_8_4, var_8_6)

	return
end

function var_0_1.UpdateFloor(arg_10_0)
	local var_10_0

	if not arg_10_0.contextData.floor then
		var_10_0 = 1
	end

	arg_10_0.switchTxt.text = var_10_0 .. "F"

	return
end

function var_0_1.OnVisitRegister(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		_courtyard = var_2_10000

		local var_12_0 = var_2_10000:GetController()

		var_0.Quit(var_12_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10005)

	return
end

function var_0_1.OnVisitFlush(arg_13_0)
	arg_13_0:OnFlush()

	return
end

function var_0_1.OnFlush(arg_14_0, arg_14_1)
	if not arg_14_1 then
		bit = var_1_10002
		var_1_10002 = var_1_10002.bor
		BackYardConst = var_1_10003

		local var_14_0 = var_1_10003.DORM_UPDATE_TYPE_NAME

		BackYardConst = var_1_10004
		arg_14_1 = var_1_10002(var_14_0, var_1_10004.DORM_UPDATE_TYPE_LEVEL)
	end

	bit = var_1_10002

	local var_14_1 = var_1_10002.band
	local var_14_2 = arg_14_1

	BackYardConst = var_1_10004

	if var_14_1(var_14_2, var_1_10004.DORM_UPDATE_TYPE_NAME) > 0 then
		arg_14_0:FlushName()
	end

	bit = var_2

	local var_14_3 = var_2.band
	local var_14_4 = arg_14_1

	BackYardConst = var_4

	if var_14_3(var_14_4, var_4.DORM_UPDATE_TYPE_LEVEL) > 0 then
		arg_14_0:FlushComfortable()
		arg_14_0:UpdateFloor()
	end

	return
end

function var_0_1.FlushName(arg_15_0)
	local var_15_0 = arg_15_0.dorm
	local var_15_2

	if not var_1.GetName(var_15_0) or var_15_2 == "" then
		getProxy = var_15_0
		PlayerProxy = var_1_10004

		local var_15_1 = var_15_0(var_1_10004)

		var_15_2 = var_3.getRawData(var_15_1).name
		arg_15_0.nameTxt.text = var_15_2
	else
		arg_15_0.nameTxt.text = var_15_2
	end

	return
end

function var_0_1.FlushComfortable(arg_16_0)
	local var_16_0 = arg_16_0.dorm
	local var_16_1 = var_1.getComfortable(var_16_0)

	arg_16_0.comfortableTxt.text = var_16_1

	local var_16_2 = var_1
	local var_16_3 = var_1.GetComfortableLevel(var_16_2, var_16_1)

	LoadSpriteAtlasAsync = var_16_2

	var_16_2("ui/CourtyardUI_atlas", "express_" .. var_16_3, function(arg_17_0)
		if arg_16_0.exited then
			return
		end

		arg_16_0.comfortableImg.sprite = arg_17_0

		local var_17_0 = arg_16_0.comfortableImg

		var_1.SetNativeSize(var_17_0)

		return
	end)

	return
end

function var_0_1.GetMoveY(arg_18_0)
	return {
		{
			arg_18_0._tf,
			1
		}
	}
end

function var_0_1.OnEnterEditMode(arg_19_0)
	arg_19_0.cg.blocksRaycasts = false

	return
end

function var_0_1.OnExitEditMode(arg_20_0)
	arg_20_0.cg.blocksRaycasts = true

	return
end

function var_0_1.onBackPressed(arg_21_0)
	local var_21_0 = arg_21_0.renamePage

	if var_1.GetLoaded(var_21_0) then
		local var_21_1 = arg_21_0.renamePage

		if var_1.isShowing(var_21_1) then
			local var_21_2 = arg_21_0.renamePage

			var_1.Hide(var_21_2)

			return true
		end
	end

	return false
end

function var_0_1.OnDispose(arg_22_0)
	arg_22_0.exited = true

	if arg_22_0.renamePage then
		local var_22_0 = arg_22_0.renamePage

		var_1.Destroy(var_22_0)

		arg_22_0.renamePage = nil
	end

	if arg_22_0.comfortablePage then
		local var_22_1 = arg_22_0.comfortablePage

		var_1.Destroy(var_22_1)

		arg_22_0.comfortablePage = nil
	end

	return
end

return var_0_1
