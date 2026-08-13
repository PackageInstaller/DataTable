class = var_0_10000

local var_0_0 = "CorePageNewPtTemplatePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

var_0_1.OFFSET = 0.00042
var_0_1.SHOW_COUNT = 8
var_0_1.AWARD_OFFSET = 1e-05

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_1, "get_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.shopBtn = var_1.Find(var_1_2, "exchange_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.content = var_1.Find(var_1_3, "award_list/content")

	local var_1_4 = arg_1_0.bg

	arg_1_0.awardTpl = var_1.Find(var_1_4, "award")

	local var_1_5 = arg_1_0.bg

	arg_1_0.sptf = var_1.Find(var_1_5, "sp_award")

	local var_1_6 = arg_1_0.bg

	arg_1_0.spAward = var_1.Find(var_1_6, "sp_award/award")

	local var_1_7 = arg_1_0.bg

	arg_1_0.ptCount = var_1.Find(var_1_7, "ptCount")

	local var_1_8 = arg_1_0.bg

	arg_1_0.getBtnGray = var_1.Find(var_1_8, "gray")

	local var_1_9 = arg_1_0.bg

	arg_1_0.get = var_1.Find(var_1_9, "Obtained")
	GetComponent = var_1
	arg_1_0.scrollCom = var_1(arg_1_0.content, "LScrollRect")

	local var_1_10 = arg_1_0.scrollCom

	function var_1_10.onUpdateItem(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.UpdateAward
		local var_2_2 = arg_2_0

		tf = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005(arg_2_1))

		return
	end

	setActive = var_1_10

	var_1_10(arg_1_0.awardTpl, false)

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	if arg_3_0.ptData then
		local var_3_0 = arg_3_0.ptData

		var_1.Update(var_3_0, arg_3_0.activity)
	else
		local var_3_1 = arg_3_0.activity

		arg_3_0.highValueItemSort = var_1.getConfig(var_3_1, "config_client").highValueItemSort
		ActivityPtData = var_1
		arg_3_0.ptData = var_1.New(arg_3_0.activity)
		arg_3_0.awardList = {}
		pairs = var_1

		for iter_3_0, iter_3_1 in var_1(arg_3_0.ptData.dropList) do
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_3_2 = arg_3_0.awardList
			local var_3_3 = {}

			Drop = var_1_10009
			var_3_3.drop = var_1_10009.New({
				type = iter_3_1[1],
				id = iter_3_1[2],
				count = iter_3_1[3]
			})
			table = var_1_10009
			var_3_3.isImportant = var_1_10009.contains(arg_3_0.highValueItemSort, iter_3_0)
			var_3_3.target = arg_3_0.ptData.targets[iter_3_0]

			var_1_10006(var_3_2, var_3_3)
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getBtn

	local function var_4_2()
		local var_5_0 = arg_4_0.ptData
		local var_5_1 = var_0.GetMaxAvailableTargetIndex(var_5_0)
		local var_5_2 = arg_4_0.ptData

		if var_5_1 == var_1.GetLevel(var_5_2) then
			return
		end

		local var_5_3 = {}

		getProxy = var_1
		PlayerProxy = var_5_2

		local var_5_4 = var_1(var_5_2)
		local var_5_5 = var_1.getRawData(var_5_4)

		pg = var_5_4

		local var_5_6 = var_5_4.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10004

		if var_2_10004 then
			var_2_10004 = 0
		else
			getProxy = var_2_10004
			BagProxy = var_2_10005

			local var_5_7 = var_2_10004(var_2_10005)

			var_2_10004 = var_2_10004.GetLimitCntById(var_5_7, var_5_6)
		end

		local var_5_8 = arg_4_0.ptData
		local var_5_9 = var_5.GetAllAvailableAwards(var_5_8)

		Task = var_5_8

		local var_5_10, var_5_11 = var_5_8.StaticJudgeOverflow(var_5_5.gold, var_5_5.oil, var_2_10004, true, true, var_5_9)

		if var_5_10 then
			table = var_8

			var_8.insert(var_5_3, function(arg_6_0)
				pg = var_3_10001

				local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_6_1 = var_1.ShowMsgBox
				local var_6_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_6_2.type = var_3_10004
				i18n = var_3_10004
				var_6_2.content = var_3_10004("award_max_warning")
				var_6_2.items = var_5_11
				var_6_2.onYes = arg_6_0

				var_6_1(var_6_0, var_6_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_5_3, function()
			local var_7_0 = arg_4_0.ptData
			local var_7_1 = var_0.GetCurrTarget(var_7_0)
			local var_7_2 = arg_4_0
			local var_7_3 = var_1.emit

			ActivityMediator = var_3_10003

			local var_7_4 = var_3_10003.EVENT_PT_OPERATION
			local var_7_5 = {
				cmd = 4
			}
			local var_7_6 = arg_4_0.ptData

			var_7_5.activity_id = var_5.GetId(var_7_6)
			var_7_5.arg1 = var_7_1

			var_7_3(var_7_2, var_7_4, var_7_5)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	local var_4_3 = arg_4_0.activity
	local var_4_4 = var_1.getConfig(var_4_3, "config_client").shopLinkActID

	getProxy = var_4_3
	ActivityProxy = var_3

	local var_4_5 = var_4_3(var_3)
	local var_4_6 = var_2.getActivityById(var_4_5, var_4_4)

	onButton = var_4_5

	var_4_5(arg_4_0, arg_4_0.shopBtn, function()
		if var_4_6 then
			local var_8_0 = var_4_6

			if var_0.isEnd(var_8_0) then
				pg = var_0

				local var_8_1 = var_0.TipsMgr.GetInstance()
				local var_8_2 = var_0.ShowTips

				i18n = var_2_10002

				var_8_2(var_8_1, var_2_10002("common_activity_end"))

				return
			end

			local var_8_3 = arg_4_0
			local var_8_4 = var_0.emit

			ActivityMediator = var_2_10002

			local var_8_5 = var_2_10002.GO_SHOPS_LAYER
			local var_8_6 = {}

			NewShopsScene = var_2_10004
			var_8_6.warp = var_2_10004.TYPE_ACTIVITY

			local var_8_7

			if var_4_6 then
				var_8_7 = var_4_6.id
			end

			var_8_6.actId = var_8_7

			var_8_4(var_8_3, var_8_5, var_8_6)

			return
		end
	end)

	local var_4_7 = arg_4_0.scrollCom

	var_3.SetTotalCount(var_4_7, #arg_4_0.awardList)
	arg_4_0:BuildPhaseAwardScrollPos()

	local var_4_8 = arg_4_0.scrollCom.onValueChanged

	var_3.AddListener(var_4_8, function(arg_9_0)
		local var_9_0 = arg_4_0

		var_1.UpdateNextAward(var_9_0, arg_9_0.x)

		return
	end)
	arg_4_0:UpdateNextAward(arg_4_0.scrollCom.value)

	return
end

function var_0_1.BuildPhaseAwardScrollPos(arg_10_0)
	local var_10_0 = arg_10_0.scrollCom
	local var_10_1 = var_1.HeadIndexToValue(var_10_0, #arg_10_0.awardList - var_0_1.SHOW_COUNT)
	local var_10_2 = arg_10_0.scrollCom

	arg_10_0.impTotalPos = var_10_1 - var_2.HeadIndexToValue(var_10_2, 0)
	arg_10_0.importantPos = {}
	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.awardList) do
		if iter_10_1.isImportant then
			table = var_6

			local var_10_3 = var_6.insert
			local var_10_4 = arg_10_0.importantPos
			local var_10_5 = {
				index = iter_10_0
			}
			local var_10_6 = arg_10_0.scrollCom

			var_10_5.pos = var_9.HeadIndexToValue(var_10_6, iter_10_0 - var_0_1.SHOW_COUNT) / arg_10_0.impTotalPos

			var_10_3(var_10_4, var_10_5)
		end
	end

	return
end

function var_0_1.UpdateNextAward(arg_11_0, arg_11_1)
	math = var_1_10002
	arg_11_1 = var_1_10002.min(arg_11_1, 1)
	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.importantPos) do
		if arg_11_1 + var_0_1.AWARD_OFFSET < iter_11_1.pos then
			setActive = var_7

			var_7(arg_11_0.sptf, true)
			arg_11_0:UpdateAward(iter_11_1.index - 1, arg_11_0.spAward)

			break
		elseif iter_11_0 == #arg_11_0.importantPos then
			setActive = var_7

			var_7(arg_11_0.sptf, false)
		end
	end

	return
end

function var_0_1.UpdateAward(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1
	local var_12_1 = arg_12_0.awardList[var_12_0].drop

	updateDrop = var_1_10005

	var_1_10005(arg_12_2:Find("icon"), var_12_1)

	setText = var_1_10005

	var_1_10005(arg_12_2:Find("pt"), arg_12_0.awardList[var_12_0].target)

	local var_12_2 = arg_12_0.ptData

	if not (var_12_0 <= var_5.GetLevel(var_12_2)) then
		local var_12_3 = arg_12_0.ptData
		local var_12_4

		if not (var_12_0 <= var_6.GetMaxAvailableTargetIndex(var_12_3)) then
			var_12_4 = false
		else
			var_12_4 = true
		end

		local var_12_5 = not var_5 and not var_12_4

		setActive = var_8

		var_8(arg_12_2:Find("got"), var_5)

		setActive = var_8

		var_8(arg_12_2:Find("get"), var_12_4)

		setActive = var_8

		var_8(arg_12_2:Find("lock"), var_12_5)

		onButton = var_8

		local var_12_6 = arg_12_0
		local var_12_7 = arg_12_2

		local function var_12_8()
			local var_13_0 = arg_12_0
			local var_13_1 = var_0.emit

			BaseUI = var_2_10002

			var_13_1(var_13_0, var_2_10002.ON_DROP, var_12_1)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_12_6, var_12_7, var_12_8, var_1_10012)

		return
	end
end

function var_0_1.OnUpdateFlush(arg_14_0)
	local var_14_0 = var_0_1.OFFSET
	local var_14_1 = arg_14_0.ptData
	local var_14_2 = var_14_0 * var_2.GetLevel(var_14_1)

	isActive = var_2

	local var_14_4

	if var_2(arg_14_0._tf) then
		local var_14_3 = arg_14_0.scrollCom

		var_14_4 = var_14_4.ScrollTo
		math = var_1_10004
		var_1_10004 = var_1_10004.clamp

		local var_14_5 = arg_14_0.scrollCom
		local var_14_6 = var_5.HeadIndexToValue
		local var_14_7 = arg_14_0.ptData

		var_14_4(var_14_3, var_1_10004(var_14_6(var_14_5, var_7.GetLevel(var_14_7)) / arg_14_0.impTotalPos + var_14_2, 0, 1), true)
	end

	setText = var_14_4

	local var_14_8 = arg_14_0.get

	i18n = var_1_10004

	var_14_4(var_14_8, var_1_10004("word_got_pt"))

	setText = var_14_4

	var_14_4(arg_14_0.ptCount, arg_14_0.ptData.count)

	setActive = var_14_4

	local var_14_9 = arg_14_0.getBtnGray
	local var_14_10 = arg_14_0.ptData
	local var_14_11 = var_4.GetMaxAvailableTargetIndex(var_14_10)
	local var_14_12 = arg_14_0.ptData

	var_14_4(var_14_9, var_14_11 == var_5.GetLevel(var_14_12))

	setActive = var_14_4

	local var_14_13 = arg_14_0.getBtn
	local var_14_14 = arg_14_0.ptData
	local var_14_15 = var_4.GetMaxAvailableTargetIndex(var_14_14)
	local var_14_16 = arg_14_0.ptData

	var_14_4(var_14_13, var_14_15 ~= var_5.GetLevel(var_14_16))

	return
end

function var_0_1.GetWorldPtData(arg_15_0, arg_15_1)
	pg = var_1_10002

	local var_15_0 = var_1_10002.TimeMgr.GetInstance()
	local var_15_1 = var_2.GetServerTime(var_15_0)

	ActivityMainScene = var_15_0

	local var_15_2

	if not var_15_0.Data2Time then
		var_15_2 = 0
	end

	if arg_15_1 <= var_15_1 - var_15_2 then
		ActivityMainScene = var_2
		pg = var_15_2

		local var_15_3 = var_15_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_15_3)

		local var_15_4 = arg_15_0
		local var_15_5 = arg_15_0.emit

		ActivityMediator = var_15_3

		local var_15_6 = var_15_3.EVENT_PT_OPERATION
		local var_15_7 = {
			cmd = 2
		}
		local var_15_8 = arg_15_0.ptData

		var_15_7.activity_id = var_6.GetId(var_15_8)

		var_15_5(var_15_4, var_15_6, var_15_7)
	end

	return
end

return var_0_1
