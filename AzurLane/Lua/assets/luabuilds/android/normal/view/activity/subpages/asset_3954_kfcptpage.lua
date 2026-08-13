class = var_0_10000

local var_0_0 = "KFCPTPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

var_0_1.SpineCharName = {
	"lafei_11",
	"lingbo_14"
}
var_0_1.SpineCharActionName = "stand_normal"
var_0_1.SpineShopActionSpeed = {
	0.8,
	1,
	1.2
}

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_3.Find(var_1_1, "sdBtn")

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_2_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003.SKINSHOP)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_0, var_1_2, var_1_3, var_5)

	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.battleBtn

	local function var_1_6()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_3_1(var_3_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_4, var_1_5, var_1_6, var_5)

	onButton = var_1

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.getBtn

	local function var_1_9()
		local var_4_0 = {}
		local var_4_1 = arg_1_0.ptData
		local var_4_2 = var_1.GetAward(var_4_1)

		getProxy = var_4_1
		PlayerProxy = var_2_10003

		local var_4_3 = var_4_1(var_2_10003)
		local var_4_4 = var_2.getRawData(var_4_3)

		pg = var_4_3

		local var_4_5 = var_4_3.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10005

		if var_2_10005 then
			var_2_10005 = 0
		else
			getProxy = var_2_10005
			BagProxy = var_2_10006
			var_2_10006 = var_2_10005(var_2_10006)
			var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_4_5)
		end

		Task = var_2_10006

		local var_4_6, var_4_7 = var_2_10006.StaticJudgeOverflow(var_4_4.gold, var_4_4.oil, var_2_10005, true, true, {
			{
				var_4_2.type,
				var_4_2.id,
				var_4_2.count
			}
		})

		if var_4_6 then
			table = var_8

			var_8.insert(var_4_0, function(arg_5_0)
				pg = var_3_10001

				local var_5_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_5_1 = var_1.ShowMsgBox
				local var_5_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_5_2.type = var_3_10004
				i18n = var_3_10004
				var_5_2.content = var_3_10004("award_max_warning")
				var_5_2.items = var_4_7
				var_5_2.onYes = arg_5_0

				var_5_1(var_5_0, var_5_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_4_0, function()
			local var_6_0 = arg_1_0.ptData
			local var_6_1, var_6_2 = var_0.GetResProgress(var_6_0)
			local var_6_3 = arg_1_0
			local var_6_4 = var_2.emit

			ActivityMediator = var_3_10004

			local var_6_5 = var_3_10004.EVENT_PT_OPERATION
			local var_6_6 = {
				cmd = 1
			}
			local var_6_7 = arg_1_0.ptData

			var_6_6.activity_id = var_6.GetId(var_6_7)
			var_6_6.arg1 = var_6_2

			var_6_4(var_6_3, var_6_5, var_6_6)

			local var_6_8 = arg_1_0

			var_2.SetLocalData(var_6_8)

			return
		end)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_7, var_1_8, var_1_9, var_5)

	local var_1_10 = arg_1_0.bg

	arg_1_0.sdContainer = var_1.Find(var_1_10, "sdcontainer")
	arg_1_0.sdSpine = nil
	arg_1_0.sdName = arg_1_0.GetRandomName()
	GetSpineRequestPackage = var_1

	local var_1_11 = var_1.New(arg_1_0.sdName, function(arg_7_0)
		SetParent = var_2_10001

		var_2_10001(arg_7_0, arg_1_0.sdContainer)

		arg_1_0.sdSpine = arg_7_0

		local var_7_0 = arg_1_0.sdSpine.transform

		Vector3 = var_2
		var_7_0.localScale = var_2.one

		local var_7_1 = arg_1_0.sdSpine

		if var_1.GetComponent(var_7_1, "SpineAnimUI") then
			var_1:SetAction(var_0_1.SpineCharActionName, 0)
		end

		arg_1_0.sdSpineLRQ = nil

		return
	end)

	arg_1_0.sdSpineLRQ = var_1.Start(var_1_11)

	local var_1_12 = arg_1_0.bg

	arg_1_0.shopSpine = var_1.Find(var_1_12, "shop/shop")

	local var_1_13 = arg_1_0.shopSpine

	arg_1_0.shopAnim = var_1.GetComponent(var_1_13, "SpineAnimUI")

	local var_1_14 = arg_1_0.shopSpine

	arg_1_0.shopGraphic = var_1.GetComponent(var_1_14, "SkeletonGraphic")

	local var_1_15 = arg_1_0.shopAnim

	var_1.SetAction(var_1_15, "normal", 0)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	var_0_1.super.OnUpdateFlush(arg_8_0)

	local var_8_0 = arg_8_0.ptData
	local var_8_1, var_8_2, var_8_3 = var_1.GetResProgress(var_8_0)

	setText = var_1_10004

	local var_8_4 = arg_8_0.progress

	if 1 <= var_8_3 then
		setColorStr = var_6

		local var_8_5

		if not var_6(var_8_1, "#ffc563") then
			var_8_5 = var_8_1
		end

		var_1_10004(var_8_4, var_8_5 .. "/" .. var_8_2)

		local var_8_6 = arg_8_0.ptData

		if var_4.CanGetMorePt(var_8_6) then
			arg_8_0:GetLocalData()

			if arg_8_0.finishCount == 0 then
				local var_8_7 = arg_8_0.shopAnim

				var_4.SetAction(var_8_7, "normal", 0)
			else
				local var_8_8 = arg_8_0.shopAnim

				var_4.SetAction(var_8_8, "action", 0)

				arg_8_0.shopGraphic.timeScale = var_0_1.SpineShopActionSpeed[arg_8_0.finishCount]
			end
		else
			local var_8_9 = arg_8_0.shopAnim

			var_4.SetAction(var_8_9, "action", 0)

			arg_8_0.shopGraphic.timeScale = var_0_1.SpineShopActionSpeed[#var_0_1.SpineShopActionSpeed]
		end

		return
	end
end

function var_0_1.GetLocalData(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)

	arg_9_0.playerId = var_1.getData(var_9_0).id
	pg = var_1

	local var_9_1 = var_1.TimeMgr.GetInstance()

	arg_9_0.curDay = var_1.DiffDay(var_9_1, arg_9_0.ptData.startTime, var_1:GetServerTime()) + 1
	PlayerPrefs = var_2
	arg_9_0.finishCount = var_2.GetInt("kfc_pt_" .. arg_9_0.playerId .. "_day_" .. arg_9_0.curDay)

	return
end

function var_0_1.SetLocalData(arg_10_0)
	arg_10_0.finishCount = arg_10_0.finishCount + 1

	local var_10_0

	if not (#var_0_1.SpineShopActionSpeed > arg_10_0.finishCount) or not arg_10_0.finishCount then
		var_10_0 = var_1
	end

	arg_10_0.finishCount = var_10_0
	PlayerPrefs = var_10_0

	var_10_0.SetInt("kfc_pt_" .. arg_10_0.playerId .. "_day_" .. arg_10_0.curDay, arg_10_0.finishCount)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.GetRandomName()
	local var_11_0 = var_0_1.SpineCharName

	math = var_1_10001

	return var_11_0[var_1_10001.random(#var_0_1.SpineCharName)]
end

function var_0_1.OnDestroy(arg_12_0)
	if arg_12_0.sdSpineLRQ then
		var_1_10002 = arg_12_0.sdSpineLRQ

		var_1.Stop(var_1_10002)

		arg_12_0.sdSpineLRQ = nil
	end

	if arg_12_0.sdSpine then
		local var_12_0 = arg_12_0.sdSpine.transform

		Vector3 = var_1_10002
		var_12_0.localScale = var_1_10002.one
		pg = var_12_0

		local var_12_1 = var_12_0.PoolMgr.GetInstance()

		var_1.ReturnSpineChar(var_12_1, arg_12_0.sdName, arg_12_0.sdSpine)

		arg_12_0.sdSpine = nil
		arg_12_0.sdName = nil
	end

	return
end

return var_0_1
