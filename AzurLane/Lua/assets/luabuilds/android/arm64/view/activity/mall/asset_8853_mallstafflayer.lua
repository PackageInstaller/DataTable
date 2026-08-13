class = var_0_10000

local var_0_0 = "MallStaffLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.ATTR_INFOS = {
	{
		"ring_yellow",
		"#ffe59b"
	},
	{
		"ring_green",
		"#9ecf76"
	},
	{
		"ring_blue",
		"#769acf"
	}
}

function var_0_1.getUIName(arg_1_0)
	return "MallStaffUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBackBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiHomeBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.quickExitFunc(var_4_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiHelpBtn

	local function var_2_8()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.mall_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10006)

	UIItemList = var_1_10001

	local var_2_9 = var_1_10001.New
	local var_2_10 = arg_2_0.uiFloorsTF
	local var_2_11 = arg_2_0.uiFloorsTF

	arg_2_0.floorsUIList = var_2_9(var_2_10, var_4.Find(var_2_11, "tpl"))

	local var_2_12 = arg_2_0.floorsUIList

	var_1.make(var_2_12, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventInit then
			local var_6_0 = arg_2_0

			var_3.InitFloorTpl(var_6_0, arg_6_1, arg_6_2)
		else
			UIItemList = var_3

			if arg_6_0 == var_3.EventUpdate then
				local var_6_1 = arg_2_0

				var_3.UpdateFloorTpl(var_6_1, arg_6_1, arg_6_2)
			end
		end

		return
	end)

	UIItemList = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0.uiTargetTF
	local var_2_15 = arg_2_0.uiTargetTF

	arg_2_0.targetUIList = var_2_13(var_2_14, var_4.Find(var_2_15, "tpl"))

	local var_2_16 = arg_2_0.targetUIList

	var_1.make(var_2_16, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_2_0

			var_3.UpdateTargetTpl(var_7_0, arg_7_1, arg_7_2)
		end

		return
	end)

	local var_2_17 = arg_2_0.uiScrollTF

	arg_2_0.scrollCom = var_1.GetComponent(var_2_17, "LScrollRect")

	function arg_2_0.scrollCom.onInitItem(arg_8_0)
		local var_8_0 = arg_2_0

		var_1.OnInitStaffItem(var_8_0, arg_8_0)

		return
	end

	local var_2_18 = arg_2_0.scrollCom

	function var_2_18.onUpdateItem(arg_9_0, arg_9_1)
		local var_9_0 = arg_2_0

		var_2.OnUpdateStaffItem(var_9_0, arg_9_0, arg_9_1)

		return
	end

	setText = var_2_18

	local var_2_19 = arg_2_0.uiTitleText

	i18n = var_4

	var_2_18(var_2_19, var_4("mall_title"))

	setText = var_2_18

	local var_2_20 = arg_2_0.uiTitleEnText

	i18n = var_4

	var_2_18(var_2_20, var_4("mall_title_en"))

	setText = var_2_18

	local var_2_21 = arg_2_0.uiFloorsTF
	local var_2_22 = var_3.Find(var_2_21, "tpl/lock/Text")

	i18n = var_4

	var_2_18(var_2_22, var_4("mall_floor_lock"))

	eachChild = var_2_18

	local var_2_23 = arg_2_0.uiRankTF

	var_2_18(var_3.Find(var_2_23, "open"), function(arg_10_0)
		setText = var_2_10001

		local var_10_0 = arg_10_0

		MallUtil = var_2_10004

		local var_10_1 = var_2_10004.RANK2NAME

		tonumber = var_2_10005

		var_2_10001(var_10_0, var_10_1[var_2_10005(arg_10_0.name)])

		return
	end)

	return
end

function var_0_1.didEnter(arg_11_0)
	arg_11_0.curFloorId = arg_11_0.contextData.floorId

	arg_11_0:UpdateData()
	arg_11_0:UpdateView()

	return
end

function var_0_1.UpdateData(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_12_0.activity = var_12_1(var_12_0, var_1_10004.ACTIVITY_TYPE_MALL)

	local var_12_2 = arg_12_0.activity

	arg_12_0.level = var_1.GetLevelData(var_12_2).level

	local var_12_3 = arg_12_0.activity

	arg_12_0.floorList = var_1.GetFloorList(var_12_3)

	local var_12_4 = arg_12_0.activity

	arg_12_0.staffList = var_1.GetStaffList(var_12_4)
	arg_12_0.cards = {}

	return
end

function var_0_1.UpdateView(arg_13_0)
	local var_13_0 = arg_13_0.floorsUIList

	var_1.align(var_13_0, #arg_13_0.floorList)

	triggerButton = var_1

	local var_13_1 = arg_13_0.floorsUIList.container
	local var_13_2 = var_3.Find

	tostring = var_1_10006

	var_1(var_13_2(var_13_1, var_1_10006(arg_13_0.curFloorId)))

	return
end

function var_0_1.InitFloorTpl(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2.name = arg_14_0.floorList[arg_14_1 + 1].id
	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/mallstaffui_atlas", var_3.id .. "f", arg_14_2:Find("unsel/f"), true)

	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/mallstaffui_atlas", var_3.id .. "f_sel", arg_14_2:Find("sel/f"), true)

	return
end

function var_0_1.UpdateFloorTpl(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.floorList[arg_15_1 + 1]

	setActive = var_4

	var_4(arg_15_2:Find("lock"), not var_15_0:IsUnlock())

	local var_15_1 = var_15_0.id == arg_15_0.curFloorId

	setActive = var_5

	var_5(arg_15_2:Find("sel"), var_15_1)

	setActive = var_5

	var_5(arg_15_2:Find("unsel"), not var_15_1)

	if not var_15_0:IsUnlock() then
		setActive = var_5

		var_5(arg_15_2:Find("staffs"), false)

		return
	end

	setActive = var_5

	var_5(arg_15_2:Find("staffs"), true)

	local var_15_2 = var_15_0:GetStaffList()

	UIItemList = var_6

	var_6.StaticAlign(arg_15_2:Find("staffs"), arg_15_2:Find("staffs/tpl"), #var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_2[arg_16_1 + 1]
			local var_16_1 = arg_15_0.activity
			local var_16_2 = var_4.GetStaff(var_16_1, var_16_0)

			setActive = var_2_10005

			var_2_10005(arg_16_2:Find("icon"), var_16_2)

			if var_16_2 then
				MallStaffCard = var_2_10005

				var_2_10005.StaticUpdateIcon(arg_16_2:Find("icon"), var_16_2.tid)
			end

			onButton = var_2_10005

			var_2_10005(arg_15_0, arg_16_2, function()
				if arg_15_0.curFloorId ~= var_15_0.id then
					triggerButton = var_0

					var_0(arg_15_2)

					return
				end

				if not var_16_2 then
					return
				end

				local var_17_0 = arg_15_0.activity

				var_0.SetFloorStaff(var_17_0, var_15_0.id, arg_16_1 + 1, 0)

				local var_17_1 = arg_15_0

				var_0.UpdateView(var_17_1)

				return
			end)
		end

		return
	end)

	onButton = var_6

	var_6(arg_15_0, arg_15_2, function()
		local var_18_0 = var_15_0

		if not var_0.IsUnlock(var_18_0) then
			return
		end

		arg_15_0.curFloorId = var_15_0.id

		local var_18_1 = arg_15_0.floorsUIList

		var_0.eachActive(var_18_1, function(arg_19_0, arg_19_1)
			local var_19_0 = arg_15_0.floorList[arg_19_0 + 1].id == arg_15_0.curFloorId

			setActive = var_3

			var_3(arg_19_1:Find("sel"), var_19_0)

			setActive = var_3

			var_3(arg_19_1:Find("unsel"), not var_19_0)

			eachChild = var_3

			var_3(arg_19_1:Find("staffs"), function(arg_20_0)
				setActive = var_4_10001

				var_4_10001(arg_20_0:Find("c_sel"), var_19_0)

				setActive = var_4_10001

				var_4_10001(arg_20_0:Find("c"), not var_19_0)

				return
			end)

			return
		end)
		var_0_1.CheckUpdateFloorStaffs(arg_15_0.activity)

		local var_18_2 = arg_15_0

		var_0.UpdataRight(var_18_2)

		return
	end)

	return
end

function var_0_1.UpdataRight(arg_21_0)
	underscore = var_1_10001

	local var_21_0 = var_1_10001.select
	local var_21_1 = arg_21_0.activity
	local var_21_2 = var_3.GetFloor(var_21_1, arg_21_0.curFloorId)

	arg_21_0.selIds = var_21_0(var_3.GetStaffList(var_21_2), function(arg_22_0)
		return arg_22_0 ~= 0
	end)
	GetImageSpriteFromAtlasAsync = var_1

	var_1("ui/mallstaffui_atlas", "title_" .. arg_21_0.curFloorId .. "f", arg_21_0.uiRightTitleTF, true)

	arg_21_0.allAttrDatas = {}

	local var_21_3 = arg_21_0.activity
	local var_21_4 = var_1.GetFloor(var_21_3, arg_21_0.curFloorId)

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(var_21_4:GetTargetInfos(arg_21_0.level)) do
		table = var_7

		var_7.insert(arg_21_0.allAttrDatas, {
			cur = 0,
			id = iter_21_0,
			base = iter_21_1[1],
			max = iter_21_1[2]
		})
	end

	ipairs = var_2

	for iter_21_2, iter_21_3 in var_2(var_21_4:GetStaffList()) do
		if iter_21_3 ~= 0 then
			local var_21_5 = arg_21_0.activity
			local var_21_6 = var_7.GetStaff(var_21_5, iter_21_3)

			ipairs = var_1_10008

			for iter_21_4, iter_21_5 in var_1_10008(var_21_6:GetAttrList()) do
				arg_21_0.allAttrDatas[iter_21_4].cur = arg_21_0.allAttrDatas[iter_21_4].cur + iter_21_5
			end
		end
	end

	underscore = var_2
	arg_21_0.showAttrDatas = var_2.select(arg_21_0.allAttrDatas, function(arg_23_0)
		return arg_23_0.base ~= 0 and arg_23_0.max ~= 0
	end)
	table = var_2

	local var_21_7 = var_2.sort
	local var_21_8 = arg_21_0.showAttrDatas

	CompareFuncs = var_5

	var_21_7(var_21_8, var_5({
		function(arg_24_0)
			return arg_24_0.id
		end
	}))

	underscore = var_21_7

	local var_21_9 = var_21_7.reduce(arg_21_0.showAttrDatas, 0, function(arg_25_0, arg_25_1)
		return arg_25_0 + arg_25_1.cur
	end)

	underscore = var_3

	local var_21_10 = var_3.reduce(arg_21_0.showAttrDatas, 0, function(arg_26_0, arg_26_1)
		return arg_26_0 + arg_26_1.base
	end)

	MallUtil = var_4

	local var_21_11 = var_4.GetFloorRank(var_21_9, var_21_10)

	MallUtil = var_5

	local var_21_12 = var_21_11 ~= var_5.FLOOR_RANK.CLOSE

	setActive = var_6

	local var_21_13 = arg_21_0.uiRankTF

	var_6(var_8.Find(var_21_13, "open"), var_21_12)

	setActive = var_6

	local var_21_14 = arg_21_0.uiRankTF

	var_6(var_8.Find(var_21_14, "close"), not var_21_12)

	if var_21_12 then
		eachChild = var_6

		local var_21_15 = arg_21_0.uiRankTF

		var_6(var_8.Find(var_21_15, "open"), function(arg_27_0)
			setActive = var_2_10001

			local var_27_0 = arg_27_0

			tonumber = var_2_10004

			var_2_10001(var_27_0, var_2_10004(arg_27_0.name) == var_21_11)

			return
		end)
	end

	local var_21_16 = arg_21_0.targetUIList

	var_6.align(var_21_16, #arg_21_0.showAttrDatas)
	arg_21_0:SortList()

	local var_21_17 = arg_21_0.scrollCom

	var_6.SetTotalCount(var_21_17, #arg_21_0.staffList)

	return
end

function var_0_1.SortList(arg_28_0)
	table = var_1_10001

	local var_28_0 = var_1_10001.sort
	local var_28_1 = arg_28_0.staffList

	CompareFuncs = var_1_10004

	var_28_0(var_28_1, var_1_10004({
		function(arg_29_0)
			local var_29_0 = arg_29_0
			local var_29_1, var_29_2 = arg_29_0.GetStatusInfos(var_29_0)

			MallStaff = var_29_0

			return var_29_1 == var_29_0.STATUS.ORDER and 1 or 0
		end,
		function(arg_30_0)
			local var_30_0 = arg_30_0
			local var_30_1, var_30_2 = arg_30_0.GetStatusInfos(var_30_0)

			MallStaff = var_30_0

			return var_30_1 == var_30_0.STATUS.FLOOR and var_30_2.floorId ~= arg_28_0.curFloorId and 1 or 0
		end,
		function(arg_31_0)
			return -arg_31_0.id
		end
	}))

	return
end

function var_0_1.UpdateTargetTpl(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.showAttrDatas[arg_32_1 + 1].id

	GetImageSpriteFromAtlasAsync = var_1_10005

	var_1_10005("ui/mallstaffui_atlas", "attr" .. var_32_0, arg_32_2:Find("icon"), true)

	local var_32_1 = arg_32_0:GetAttrInfos(var_3)

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("ui/mallstaffui_atlas", var_32_1[1], arg_32_2:Find("ring/v"), true)

	setFillAmount = var_1_10006

	var_1_10006(arg_32_2:Find("ring/r"), var_3.base / var_3.max)

	setFillAmount = var_1_10006

	var_1_10006(arg_32_2:Find("ring/v"), var_3.cur / var_3.max)

	setText = var_1_10006

	local var_32_2 = arg_32_2:Find("bg/Text")

	setColorStr = var_9

	local var_32_3

	if not var_9(var_3.cur, var_32_1[2]) then
		var_32_3 = var_3.cur
	end

	var_1_10006(var_32_2, var_32_3 .. "/" .. var_3.max)

	return
end

function var_0_1.GetAttrInfos(arg_33_0, arg_33_1)
	if arg_33_1.cur >= arg_33_1.max then
		return var_0_1.ATTR_INFOS[3]
	end

	if arg_33_1.cur >= arg_33_1.base then
		return var_0_1.ATTR_INFOS[2]
	end

	return var_0_1.ATTR_INFOS[1]
end

function var_0_1.OnInitStaffItem(arg_34_0, arg_34_1)
	MallStaffCard = var_1_10002

	local var_34_0 = var_1_10002.New(arg_34_1)

	onButton = var_1_10003

	local var_34_1 = arg_34_0
	local var_34_2 = var_34_0._go

	local function var_34_3()
		local var_35_0 = arg_34_0.activity
		local var_35_1 = var_0.GetFloor(var_35_0, arg_34_0.curFloorId)

		if not var_0.GetEmptyIdx(var_35_1) then
			pg = var_2_10001

			local var_35_2 = var_2_10001.TipsMgr.GetInstance()
			local var_35_3 = var_1.ShowTips

			i18n = var_2_10004

			var_35_3(var_35_2, var_2_10004("mall_staff_position_full_tip"))

			return
		end

		local var_35_4 = var_34_0.staff
		local var_35_5, var_35_6 = var_1.GetStatusInfos(var_35_4)

		MallStaff = var_35_4

		if var_35_5 == var_35_4.STATUS.ORDER then
			return
		end

		MallStaff = var_3

		if var_35_5 == var_3.STATUS.FLOOR and var_35_6.floorId == arg_34_0.curFloorId then
			return
		end

		seriesAsync = var_3

		var_3({
			function(arg_36_0)
				local var_36_0 = var_35_5

				MallStaff = var_3_10002

				if var_36_0 == var_3_10002.STATUS.FLOOR then
					pg = var_36_0

					local var_36_1 = var_36_0.MsgboxMgr.GetInstance()
					local var_36_2 = var_1.ShowMsgBox
					local var_36_3 = {}

					i18n = var_3_10005
					var_36_3.content = var_3_10005("mall_change_floor_sure")

					function var_36_3.onYes()
						local var_37_0 = arg_34_0.activity

						var_0.SetFloorStaff(var_37_0, var_35_6.floorId, var_35_6.floorIdx, 0)
						arg_36_0()

						return
					end

					var_36_2(var_36_1, var_36_3)
				else
					arg_36_0()
				end

				return
			end
		}, function()
			local var_38_0 = arg_34_0.activity

			var_0.SetFloorStaff(var_38_0, arg_34_0.curFloorId, var_0, var_34_0.id)

			local var_38_1 = arg_34_0

			var_0.UpdateView(var_38_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_34_1, var_34_2, var_34_3, var_1_10008)

	arg_34_0.cards[arg_34_1] = var_34_0

	return
end

function var_0_1.OnUpdateStaffItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0

	if not arg_39_0.cards[arg_39_2] then
		arg_39_0:OnInitStaffItem(arg_39_2)

		var_39_0 = arg_39_0.cards[arg_39_2]
	end

	local var_39_1 = arg_39_0.staffList[arg_39_1 + 1]

	underscore = var_5

	local var_39_2 = var_5.map(arg_39_0.showAttrDatas, function(arg_40_0)
		return arg_40_0.id
	end)

	var_39_0:Update(var_39_1, arg_39_0.selIds, true, var_39_2)

	return
end

function var_0_1.willExit(arg_41_0)
	var_0_1.CheckUpdateFloorStaffs(arg_41_0.activity)

	ClearLScrollrect = var_1

	var_1(arg_41_0.scrollCom)

	pairs = var_1

	for iter_41_0, iter_41_1 in var_1(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	return
end

function var_0_1.CheckUpdateFloorStaffs(arg_42_0, arg_42_1)
	if arg_42_0:NeedUpdateFloorStaff() then
		pg = var_2

		local var_42_0 = var_2.m02
		local var_42_1 = var_2.sendNotification

		GAME = var_1_10005

		local var_42_2 = var_1_10005.ACTIVITY_MALL_OP
		local var_42_3 = {
			activity_id = arg_42_0.id
		}

		ActivityMallOPCommand = var_7
		var_42_3.cmd = var_7.CMD.SET_FLOOR_STAFF
		var_42_3.arg_list = arg_42_0:GetFloorStaffList()
		var_42_3.callback = arg_42_1

		var_42_1(var_42_0, var_42_2, var_42_3)
	end

	return
end

return var_0_1
