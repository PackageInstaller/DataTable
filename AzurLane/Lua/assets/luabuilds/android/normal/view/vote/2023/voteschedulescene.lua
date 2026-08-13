class = var_0_10000

local var_0_0 = "VoteScheduleScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 3

function var_0_1.getUIName(arg_1_0)
	return "VoteScheduleUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "blur_panel/adapt/top/back_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.raceTpl = var_1.Find(var_2_1, "res/raceTpl")

	local var_2_2 = arg_2_0._tf

	arg_2_0.layoutTpl = var_1.Find(var_2_2, "res/layoutTpl")

	local var_2_3 = arg_2_0._tf

	arg_2_0.raceTpl1 = var_1.Find(var_2_3, "res/raceTpl1")

	local var_2_4 = arg_2_0._tf

	arg_2_0.layoutTpl1 = var_1.Find(var_2_4, "res/layoutTpl1")

	local var_2_5 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_5, "scrollrect/content")

	local var_2_6 = arg_2_0._tf

	arg_2_0.verLeftTpl = var_1.Find(var_2_6, "res/ver_left")

	local var_2_7 = arg_2_0._tf

	arg_2_0.verLeftTplClose = var_1.Find(var_2_7, "res/ver_left_close")

	local var_2_8 = arg_2_0._tf

	arg_2_0.verRightTpl = var_1.Find(var_2_8, "res/ver_right")

	local var_2_9 = arg_2_0._tf

	arg_2_0.verRightTplClose = var_1.Find(var_2_9, "res/ver_right_close")

	local var_2_10 = arg_2_0._tf

	arg_2_0.centTpl = var_1.Find(var_2_10, "res/cen")

	local var_2_11 = arg_2_0._tf

	arg_2_0.centTplClose = var_1.Find(var_2_11, "res/cen_close")

	local var_2_12 = arg_2_0._tf

	arg_2_0.hrzRightTpl = var_1.Find(var_2_12, "res/hrz_rigth")

	local var_2_13 = arg_2_0._tf

	arg_2_0.hrzRightTplClose = var_1.Find(var_2_13, "res/hrz_rigth_close")

	local var_2_14 = arg_2_0._tf

	arg_2_0.hrzLeftTpl = var_1.Find(var_2_14, "res/hrz_left")

	local var_2_15 = arg_2_0._tf

	arg_2_0.hrzLeftTplClose = var_1.Find(var_2_15, "res/hrz_left_close")

	local var_2_16 = arg_2_0._tf

	arg_2_0.lineContainer = var_1.Find(var_2_16, "scrollrect/content/line")
	arg_2_0.lineTpls = {}
	setText = var_1

	local var_2_17 = arg_2_0.raceTpl
	local var_2_18 = var_2.Find(var_2_17, "open/Text")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("vote_lable_voting"))

	setText = var_1

	local var_2_19 = arg_2_0.raceTpl
	local var_2_20 = var_2.Find(var_2_19, "close/Text")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("vote_lable_not_start"))

	setText = var_1

	local var_2_21 = arg_2_0.raceTpl1
	local var_2_22 = var_2.Find(var_2_21, "open/Text")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("vote_lable_voting"))

	setText = var_1

	local var_2_23 = arg_2_0.raceTpl1
	local var_2_24 = var_2.Find(var_2_23, "close/Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("vote_lable_not_start"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "title/Text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("vote_lable_title"))

	local var_2_27 = arg_2_0.layoutTpl
	local var_2_28 = var_1.GetComponent

	typeof = var_3
	LayoutElement = var_4
	arg_2_0.LayoutHeight = var_2_28(var_2_27, var_3(var_4)).preferredHeight

	local var_2_29 = arg_2_0.container
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	VerticalLayoutGroup = var_4
	arg_2_0.spacing = var_2_30(var_2_29, var_3(var_4)).spacing

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	pg = var_1_10001

	local var_3_3 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_3_3, false)

	seriesAsync = var_1

	var_1({
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.RequestFinishedVoteGroup(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			pg = var_2_10001

			local var_6_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_6_0)

			local var_6_1 = arg_3_0

			var_1.SetUp(var_6_1, arg_6_0)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.RequestFinishedVoteGroup(arg_8_0, arg_8_1)
	local var_8_0 = {}

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10003(var_1_10004.activity_vote.all) do
		pg = var_1_10008

		local var_8_1 = var_1_10008.TimeMgr.GetInstance()

		var_1_10008 = var_1_10008.parseTimeFromConfig
		pg = var_1_10010
		var_1_10008 = var_1_10008(var_8_1, var_1_10010.activity_vote[iter_8_1].time_vote[2])
		pg = var_8_1
		var_1_10010 = var_8_1.TimeMgr.GetInstance()

		if var_1_10008 <= var_9.GetServerTime(var_1_10010) then
			table = var_1_10010

			var_1_10010.insert(var_8_0, function(arg_9_0)
				local var_9_0 = arg_8_0
				local var_9_1 = var_1.emit

				VoteScheduleMediator = var_2_10003

				var_9_1(var_9_0, var_2_10003.FETCH_RANK, iter_8_1, arg_9_0)

				return
			end)
		end
	end

	seriesAsync = var_3

	var_3(var_8_0, arg_8_1)

	return
end

function var_0_1.SetUp(arg_10_0, arg_10_1)
	arg_10_0.voteIdList = arg_10_0:GetVoteIdList()
	arg_10_0.displayList = arg_10_0:GenDisplayList(arg_10_0.voteIdList)

	arg_10_0:ClearLines()

	local var_10_0 = arg_10_0:InitScheduleList()
	local var_10_1 = arg_10_0.lineContainer

	var_3.SetAsLastSibling(var_10_1)

	seriesAsync = var_3

	var_3({
		function(arg_11_0)
			Canvas = var_2_10001

			var_2_10001.ForceUpdateCanvases()

			onNextTick = var_1

			var_1(arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_10_0

			var_1.UpdateLinesPosition(var_12_0)

			local var_12_1 = arg_10_0

			var_1.ScrollTo(var_12_1, var_10_0)

			onNextTick = var_1

			var_1(arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0

			var_1.PlayAnimation(var_13_0, arg_13_0)

			return
		end
	}, arg_10_1)

	return
end

function var_0_1.PlayAnimation(arg_14_0, arg_14_1)
	local var_14_0 = 1

	local function var_14_1(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.GetComponent

		typeof = var_2_10005
		CanvasGroup = var_2_10006

		local var_15_2 = var_15_1(var_15_0, var_2_10005(var_2_10006))

		LeanTween = var_15_0

		local var_15_3 = var_15_0.value(arg_15_0.gameObject, 0, 1, 0.333)
		local var_15_4 = var_4.setOnUpdate

		System = var_6

		local var_15_5 = var_15_4(var_15_3, var_6.Action_float(function(arg_16_0)
			var_15_2.alpha = arg_16_0

			return
		end))
		local var_15_6 = var_4.setOnComplete

		System = var_6

		local var_15_7 = var_15_6(var_15_5, var_6.Action(arg_15_2))

		var_4.setDelay(var_15_7, arg_15_1 * var_14_0)

		var_14_0 = var_14_0 + 1

		return
	end

	local var_14_2 = {}

	pairs = var_1_10005

	local var_14_3

	if not arg_14_0.voteIdList then
		var_14_3 = {}
	end

	for iter_14_0, iter_14_1 in var_1_10005(var_14_3) do
		local var_14_4 = arg_14_0:GetRaceState(iter_14_1)
		local var_14_5 = arg_14_0.animationNodes[iter_14_1]
		local var_14_6 = var_14_4 == var_0_10

		ipairs = var_1_10013

		for iter_14_2, iter_14_3 in var_1_10013(var_14_5) do
			if var_14_6 then
				table = var_1_10018

				var_1_10018.insert(var_14_2, function(arg_17_0)
					var_14_1(iter_14_3, 0.066, arg_17_0)

					return
				end)
			else
				local var_14_7 = iter_14_3

				var_1_10018 = iter_14_3.GetComponent
				typeof = var_1_10020
				CanvasGroup = var_1_10021
				var_1_10018 = var_1_10018(var_14_7, var_1_10020(var_1_10021))
				var_1_10018.alpha = 1
			end
		end
	end

	parallelAsync = var_5

	var_5(var_14_2, function()
		arg_14_0.animationNodes = {}

		arg_14_1()

		return
	end)

	return
end

function var_0_1.ScrollTo(arg_19_0, arg_19_1)
	local var_19_0 = (arg_19_0.LayoutHeight + arg_19_0.spacing) * (arg_19_1 - 1) - 170

	setAnchoredPosition = var_3

	var_3(arg_19_0.container, {
		y = var_19_0
	})

	return
end

function var_0_1.ClearLines(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.lineTpls) do
		local var_20_0 = iter_20_1[1]

		Object = var_1_10007

		var_1_10007.Destroy(var_20_0.gameObject)
	end

	arg_20_0.lineTpls = {}

	return
end

local function var_0_11(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 == arg_21_1 then
		return arg_21_2
	else
		local var_21_0 = arg_21_0:TransformPoint(arg_21_2)
		local var_21_1 = arg_21_1
		local var_21_2 = arg_21_1.InverseTransformPoint(var_21_1, var_21_0)

		Vector3 = var_21_1

		return var_21_1(var_21_2.x, var_21_2.y, 0)
	end

	return
end

function var_0_1.UpdateLinesPosition(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.lineTpls) do
		local var_22_0 = var_0_11(iter_22_1[2], arg_22_0.lineContainer, iter_22_1[3])

		setAnchoredPosition = var_7

		var_7(iter_22_1[1], var_22_0)
	end

	return
end

function var_0_1.GetVoteIdList(arg_23_0)
	local var_23_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10002(var_1_10003.activity_vote.all) do
		table = var_1_10007

		var_1_10007.insert(var_23_0, iter_23_1)
	end

	table = var_2

	var_2.sort(var_23_0, function(arg_24_0, arg_24_1)
		pg = var_2_10002

		local var_24_0 = var_2_10002.activity_vote[arg_24_0]

		pg = var_2_10003

		local var_24_1 = var_2_10003.activity_vote[arg_24_1]

		pg = var_2_10004

		local var_24_2 = var_2_10004.TimeMgr.GetInstance()
		local var_24_3 = var_4.parseTimeFromConfig(var_24_2, var_24_0.time_vote[1])

		pg = var_24_2

		local var_24_4 = var_24_2.TimeMgr.GetInstance()

		return var_24_3 < var_5.parseTimeFromConfig(var_24_4, var_24_1.time_vote[1])
	end)

	return var_23_0
end

function var_0_1.GenDisplayList(arg_25_0, arg_25_1)
	local var_25_0 = {}

	if #arg_25_1 <= 4 then
		ipairs = var_3

		for iter_25_0, iter_25_1 in var_3(arg_25_1) do
			local var_25_1 = var_0_4

			if iter_25_0 == #arg_25_1 then
				var_25_1 = var_0_7
			end

			table = var_9

			var_9.insert(var_25_0, {
				{
					id = iter_25_1,
					dir = var_25_1
				}
			})
		end

		return var_25_0
	end

	table = var_3

	var_3.insert(var_25_0, {
		{
			id = arg_25_1[1],
			dir = var_0_2
		}
	})

	local var_25_2 = 0
	local var_25_3 = #arg_25_1 - 3

	for iter_25_2 = 2, var_25_3, 2 do
		var_25_2 = var_25_2 + 1

		local var_25_4 = iter_25_2 == var_25_3 or var_25_3 < iter_25_2 + 2
		local var_25_5

		if var_25_2 % 2 == 0 then
			table = var_25_5
			var_25_5 = var_25_5.insert

			local var_25_6 = var_25_0
			local var_25_7 = {}
			local var_25_8 = {
				id = arg_25_1[iter_25_2 + 1]
			}
			local var_25_9

			if not var_25_4 or not var_0_3 then
				var_25_9 = var_0_4
			end

			var_25_8.dir = var_25_9
			var_25_7[1] = var_25_8
			var_25_7[2] = {
				id = arg_25_1[iter_25_2],
				dir = var_0_6
			}

			var_25_5(var_25_6, var_25_7)
		else
			table = var_25_5

			local var_25_10 = var_25_5.insert
			local var_25_11 = var_25_0
			local var_25_12 = {
				{
					id = arg_25_1[iter_25_2],
					dir = var_0_5
				}
			}
			local var_25_13 = {
				id = arg_25_1[iter_25_2 + 1]
			}
			local var_25_14

			if not var_25_4 or not var_0_2 then
				var_25_14 = var_0_4
			end

			var_25_13.dir = var_25_14
			var_25_12[2] = var_25_13

			var_25_10(var_25_11, var_25_12)
		end
	end

	if #arg_25_1 % 2 == 0 then
		table = var_5

		var_5.insert(var_25_0, {
			{
				id = arg_25_1[#arg_25_1 - 2],
				dir = var_0_4
			}
		})
	end

	table = var_5

	var_5.insert(var_25_0, {
		{
			id = arg_25_1[#arg_25_1 - 1],
			dir = var_0_4
		}
	})

	table = var_5

	var_5.insert(var_25_0, {
		{
			id = arg_25_1[#arg_25_1],
			dir = var_0_7
		}
	})

	return var_25_0
end

function var_0_1.InitScheduleList(arg_26_0)
	arg_26_0.animationNodes = {}

	local var_26_0 = {}

	for iter_26_0 = 1, arg_26_0.container.childCount do
		var_1_10007 = arg_26_0.container

		if var_6.GetChild(var_1_10007, iter_26_0 - 1).name ~= "line" then
			table = var_1_10007

			var_1_10007.insert(var_26_0, var_6.gameObject)
		end
	end

	local var_26_1 = #var_26_0

	if 0 < var_26_1 then
		ipairs = var_26_1

		for iter_26_1, iter_26_2 in var_26_1(var_26_0) do
			Object = var_1_10007

			var_1_10007.Destroy(iter_26_2)
		end
	end

	local var_26_2 = {}

	ipairs = var_3

	for iter_26_3, iter_26_4 in var_3(arg_26_0.voteIdList) do
		var_26_2[iter_26_4] = arg_26_0:GetRaceState(iter_26_4)
	end

	local var_26_3 = 1

	ipairs = var_4

	for iter_26_5, iter_26_6 in var_4(arg_26_0.displayList) do
		local var_26_4

		var_1_10010 = iter_26_5 == #arg_26_0.displayList

		if var_1_10010 then
			cloneTplTo = var_1_10011
			var_26_4 = var_1_10011(arg_26_0.layoutTpl1, arg_26_0.container)
		else
			cloneTplTo = var_1_10011
			var_26_4 = var_1_10011(arg_26_0.layoutTpl, arg_26_0.container)
		end

		if arg_26_0:GenRaceList(var_26_4, iter_26_6, var_26_2, var_1_10010) then
			var_26_3 = iter_26_5
		end
	end

	local var_26_5 = false

	pairs = var_5

	for iter_26_7, iter_26_8 in var_5(var_26_2) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.activity_vote[iter_26_7].type
		VoteConst = var_1_10011

		if var_1_10010 == var_1_10011.RACE_TYPE_FINAL and iter_26_8 == var_0_9 then
			var_26_5 = true

			break
		end
	end

	if var_26_5 then
		cloneTplTo = var_5

		var_5(arg_26_0.layoutTpl, arg_26_0.container)
	end

	return var_26_3
end

function var_0_1.GenRaceList(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = false
	local var_27_1

	if arg_27_4 then
		UIItemList = var_1_10007
		var_27_1 = var_1_10007.New(arg_27_1:Find("content"), arg_27_0.raceTpl1)
	else
		UIItemList = var_1_10007
		var_27_1 = var_1_10007.New(arg_27_1:Find("content"), arg_27_0.raceTpl)
	end

	var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = arg_27_2[arg_28_1 + 1]

			table = var_4

			local var_28_1 = var_4.indexof(arg_27_0.voteIdList, var_28_0.id)
			local var_28_2

			if var_28_1 and var_28_1 > 0 then
				local var_28_3 = arg_27_0.voteIdList[var_28_1 + 1]

				var_28_2 = arg_27_3[var_28_3]
			end

			local var_28_4 = arg_27_3[var_28_0.id]
			local var_28_5 = arg_27_0

			var_7.UpdateRace(var_28_5, arg_28_2, var_28_0, var_28_4, var_28_2)

			if not var_27_0 and var_28_4 == var_0_9 then
				var_27_0 = true
			end
		end

		return
	end)
	var_27_1:align(#arg_27_2)

	return var_27_0
end

function var_0_1.GetRaceState(arg_29_0, arg_29_1)
	pg = var_1_10002

	local var_29_0 = var_1_10002.activity_vote[arg_29_1]

	pg = var_1_10003

	local var_29_1 = var_1_10003.TimeMgr.GetInstance()

	if var_3.inTime(var_29_1, var_29_0.time_vote) then
		return var_0_9
	else
		pg = var_29_1

		local var_29_2 = var_29_1.TimeMgr.GetInstance()
		local var_29_3 = var_4.parseTimeFromConfig(var_29_2, var_29_0.time_vote[2])

		pg = var_29_2

		local var_29_4 = var_29_2.TimeMgr.GetInstance()

		if var_29_3 <= var_5.GetServerTime(var_29_4) then
			return var_0_8
		else
			return var_0_10
		end
	end

	return
end

function var_0_1.UpdateRace(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	pg = var_1_10005

	local var_30_0 = var_1_10005.activity_vote[arg_30_2.id]
	local var_30_1 = arg_30_0:UpdateRaceLink(arg_30_1, arg_30_2, arg_30_4 and arg_30_4 ~= var_0_10)

	arg_30_0:UpdateRaceState(arg_30_1, var_30_0, arg_30_3)

	arg_30_0.animationNodes[arg_30_2.id] = {
		arg_30_1,
		var_30_1
	}

	return
end

local function var_0_12(arg_31_0, arg_31_1)
	if arg_31_1 == var_0_10 then
		return "border_close"
	else
		local var_31_0 = arg_31_0.type

		VoteConst = var_1_10003

		if var_31_0 == var_1_10003.RACE_TYPE_FINAL then
			return "border_finals"
		else
			return "border_open"
		end
	end

	return
end

local function var_0_13(arg_32_0, arg_32_1)
	if arg_32_1 == var_0_10 then
		return "frame_title_close"
	else
		local var_32_0 = arg_32_0.type

		VoteConst = var_1_10003

		if var_32_0 == var_1_10003.RACE_TYPE_FINAL then
			return "frame_title_finals"
		else
			local var_32_1 = arg_32_0.type

			VoteConst = var_3

			if var_32_1 == var_3.RACE_TYPE_RESURGENCE then
				return "frame_title_rec"
			else
				local var_32_2 = arg_32_0.type

				VoteConst = var_3

				if var_32_2 == var_3.RACE_TYPE_FUN then
					local var_32_3 = arg_32_0.sub_type

					VoteConst = var_3

					if var_32_3 == var_3.RACE_SUBTYPE_SIRE then
						return "frame_title_sire"
					else
						local var_32_4 = arg_32_0.sub_type

						VoteConst = var_3

						if var_32_4 == var_3.RACE_SUBTYPE_META then
							return "frame_title_META"
						else
							local var_32_5 = arg_32_0.sub_type

							VoteConst = var_3

							if var_32_5 == var_3.RACE_SUBTYPE_KID then
								return "frame_title_kid"
							end
						end
					end
				else
					return "frame_title"
				end
			end
		end
	end

	return
end

local function var_0_14(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.type

	VoteConst = var_1_10003

	if var_33_0 == var_1_10003.RACE_TYPE_FUN then
		local var_33_1 = arg_33_0.sub_type

		VoteConst = var_3

		if var_33_1 == var_3.RACE_SUBTYPE_SIRE then
			return "icon_sire"
		else
			local var_33_2 = arg_33_0.sub_type

			VoteConst = var_3

			if var_33_2 == var_3.RACE_SUBTYPE_META then
				return "icon_META"
			else
				local var_33_3 = arg_33_0.sub_type

				VoteConst = var_3

				if var_33_3 == var_3.RACE_SUBTYPE_KID then
					return "icon_kid"
				end
			end
		end
	end

	return nil
end

function var_0_1.UpdateRaceState(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_1:Find("border")
	local var_34_1 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_34_2 = var_34_1(var_34_0, var_6(var_1_10007))

	GetSpriteFromAtlas = var_34_0
	var_34_2.sprite = var_34_0("ui/VoteScheduleUI_atlas", var_0_12(arg_34_2, arg_34_3))

	local var_34_3 = arg_34_1:Find("title")
	local var_34_4 = var_4.GetComponent

	typeof = var_6
	Image = var_7

	local var_34_5 = var_34_4(var_34_3, var_6(var_7))

	GetSpriteFromAtlas = var_34_3
	var_34_5.sprite = var_34_3("ui/VoteScheduleUI_atlas", var_0_13(arg_34_2, arg_34_3))

	local var_34_6 = var_0_14(arg_34_2, arg_34_3)

	setActive = var_5

	var_5(arg_34_1:Find("title/content/icon"), var_34_6)

	local var_34_7

	if var_34_6 then
		var_34_7 = arg_34_1
		var_34_7 = arg_34_1.Find(var_34_7, "title/content/icon")

		local var_34_8 = var_5.GetComponent

		typeof = var_7
		Image = var_8

		local var_34_9 = var_34_8(var_34_7, var_7(var_8))

		GetSpriteFromAtlas = var_34_7
		var_34_9.sprite = var_34_7("ui/VoteScheduleUI_atlas", var_34_6)
	end

	local var_34_10

	if arg_34_3 ~= var_0_10 then
		var_34_10 = arg_34_2.type
		VoteConst = var_34_7

		if var_34_10 == var_34_7.RACE_TYPE_RESURGENCE then
			var_34_10 = "#074e51"

			goto label_34_0
		end
	end

	COLOR_WHITE = var_34_10

	::label_34_0::

	setText = var_34_7

	local var_34_11 = arg_34_1
	local var_34_12 = arg_34_1.Find(var_34_11, "title/content/Text")

	setColorStr = var_34_11

	var_34_7(var_34_12, var_34_11(arg_34_2.name, var_34_10))

	VoteGroup = var_34_7

	local var_34_13 = var_34_7.GetTimeDesc2(arg_34_2.time_vote, arg_34_2.type)

	setText = var_7

	local var_34_14 = arg_34_1
	local var_34_15 = arg_34_1.Find(var_34_14, "title/content/Text/Text")

	setColorStr = var_34_14

	var_7(var_34_15, var_34_14(var_34_13, var_34_10))

	setActive = var_7

	var_7(arg_34_1:Find("open"), arg_34_3 == var_0_9)

	setActive = var_7

	var_7(arg_34_1:Find("close"), arg_34_3 == var_0_10)

	setActive = var_7

	var_7(arg_34_1:Find("list"), arg_34_3 == var_0_8)

	getProxy = var_7
	VoteProxy = var_8

	local var_34_16 = var_7(var_8)
	local var_34_17 = var_7.RawGetTempVoteGroup(var_34_16, arg_34_2.id)

	UIItemList = var_34_16

	local var_34_18 = var_34_16.New(arg_34_1:Find("list"), arg_34_1:Find("list/ship_tpl"))

	var_8.make(var_34_18, function(arg_35_0, arg_35_1, arg_35_2)
		UIItemList = var_2_10003

		if arg_35_0 == var_2_10003.EventUpdate then
			local var_35_0 = arg_34_0

			var_3.UpdateRaceRank(var_35_0, var_34_17, arg_35_1 + 1, arg_35_2)
		end

		return
	end)

	local var_34_19 = arg_34_3 == var_0_8 and var_34_17 and #var_34_17:getList() >= 3 and 3 or 0

	var_8:align(var_34_19)

	onButton = var_10

	local var_34_20 = arg_34_0
	local var_34_21 = arg_34_1

	local function var_34_22()
		getProxy = var_2_10000
		VoteProxy = var_2_10001

		local var_36_0 = var_2_10000(var_2_10001)
		local var_36_1

		if not var_0.GetOpeningNonFunVoteGroup(var_36_0) then
			getProxy = var_36_1
			VoteProxy = var_36_0
			var_36_0 = var_36_1(var_36_0)
			var_36_1 = var_36_1.GetOpeningFunVoteGroup(var_36_0)
		end

		getProxy = var_36_0
		VoteProxy = var_2_10002

		local var_36_2 = var_36_0(var_2_10002)
		local var_36_5

		if var_1.RawGetVoteGroupByConfigId(var_36_2, arg_34_2.id) and var_36_1 and var_36_1.id == arg_34_2.id then
			getProxy = var_1
			ContextProxy = var_2

			local var_36_3 = var_1(var_2)

			if var_1.getCurrentContext(var_36_3) then
				local var_36_4 = var_1.mediator

				VoteMediator = var_36_5

				if var_36_4 == var_36_5 then
					var_36_5 = arg_34_0

					var_2.emit(var_36_5, var_0_1.ON_CLOSE)

					goto label_36_0
				end
			end

			var_36_5 = arg_34_0

			local var_36_6 = var_2.emit

			VoteScheduleMediator = var_2_10004

			var_36_6(var_36_5, var_2_10004.ON_VOTE)
		elseif var_34_17 then
			local var_36_7 = arg_34_0
			local var_36_8 = var_1.emit

			VoteScheduleMediator = var_36_5

			var_36_8(var_36_7, var_36_5.GO_RANK, var_34_17)
		end

		::label_36_0::

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_34_20, var_34_21, var_34_22, var_1_10014)

	return
end

function var_0_1.UpdateRaceRank(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if not arg_37_1 then
		setActive = var_1_10004

		var_1_10004(arg_37_3, false)

		return
	end

	local var_37_0 = arg_37_1:getList()[arg_37_2]

	VoteShipItem = var_1_10006

	local var_37_1 = var_1_10006.New(arg_37_3.gameObject)
	local var_37_2 = arg_37_1:GetRank(var_37_0)

	var_37_1:update(var_37_0, {
		rank = var_37_2
	})

	return
end

function var_0_1.UpdateRaceLink(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2.dir
	local var_38_1

	if var_38_0 == var_0_2 and arg_38_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.verLeftTpl, arg_38_0.lineContainer)
		table = var_6

		local var_38_2 = var_6.insert
		local var_38_3 = arg_38_0.lineTpls
		local var_38_4 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_4[3] = var_1_10009(-224.42, -203.2)

		var_38_2(var_38_3, var_38_4)
	elseif var_38_0 == var_0_2 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.verLeftTplClose, arg_38_0.lineContainer)
		table = var_6

		local var_38_5 = var_6.insert
		local var_38_6 = arg_38_0.lineTpls
		local var_38_7 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_7[3] = var_1_10009(-224.42, -203.2)

		var_38_5(var_38_6, var_38_7)
	elseif var_38_0 == var_0_3 and arg_38_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.verRightTpl, arg_38_0.lineContainer)
		table = var_6

		local var_38_8 = var_6.insert
		local var_38_9 = arg_38_0.lineTpls
		local var_38_10 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_10[3] = var_1_10009(224.42, -203.2)

		var_38_8(var_38_9, var_38_10)
	elseif var_38_0 == var_0_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.verRightTplClose, arg_38_0.lineContainer)
		table = var_6

		local var_38_11 = var_6.insert
		local var_38_12 = arg_38_0.lineTpls
		local var_38_13 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_13[3] = var_1_10009(224.42, -203.2)

		var_38_11(var_38_12, var_38_13)
	elseif var_38_0 == var_0_4 and arg_38_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.centTpl, arg_38_0.lineContainer)
		table = var_6

		local var_38_14 = var_6.insert
		local var_38_15 = arg_38_0.lineTpls
		local var_38_16 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_16[3] = var_1_10009(0, -203.2)

		var_38_14(var_38_15, var_38_16)
	elseif var_38_0 == var_0_4 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.centTplClose, arg_38_0.lineContainer)
		table = var_6

		local var_38_17 = var_6.insert
		local var_38_18 = arg_38_0.lineTpls
		local var_38_19 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_19[3] = var_1_10009(0, -203.2)

		var_38_17(var_38_18, var_38_19)
	elseif var_38_0 == var_0_5 and arg_38_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.hrzRightTpl, arg_38_0.lineContainer)
		table = var_6

		local var_38_20 = var_6.insert
		local var_38_21 = arg_38_0.lineTpls
		local var_38_22 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_22[3] = var_1_10009(447.2, 0)

		var_38_20(var_38_21, var_38_22)
	elseif var_38_0 == var_0_5 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.hrzRightTplClose, arg_38_0.lineContainer)
		table = var_6

		local var_38_23 = var_6.insert
		local var_38_24 = arg_38_0.lineTpls
		local var_38_25 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_25[3] = var_1_10009(447.2, 0)

		var_38_23(var_38_24, var_38_25)
	elseif var_38_0 == var_0_6 and arg_38_3 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.hrzLeftTpl, arg_38_0.lineContainer)
		table = var_6

		local var_38_26 = var_6.insert
		local var_38_27 = arg_38_0.lineTpls
		local var_38_28 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_28[3] = var_1_10009(-447.2, 0)

		var_38_26(var_38_27, var_38_28)
	elseif var_38_0 == var_0_6 then
		cloneTplTo = var_6
		var_38_1 = var_6(arg_38_0.hrzLeftTplClose, arg_38_0.lineContainer)
		table = var_6

		local var_38_29 = var_6.insert
		local var_38_30 = arg_38_0.lineTpls
		local var_38_31 = {
			var_38_1,
			arg_38_1
		}

		Vector2 = var_1_10009
		var_38_31[3] = var_1_10009(-447.2, 0)

		var_38_29(var_38_30, var_38_31)
	end

	return var_38_1
end

function var_0_1.onBackPressed(arg_39_0)
	var_0_1.super.onBackPressed(arg_39_0)

	return
end

function var_0_1.willExit(arg_40_0)
	return
end

return var_0_1
