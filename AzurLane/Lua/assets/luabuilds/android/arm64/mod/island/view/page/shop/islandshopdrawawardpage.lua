class = var_0_10000

local var_0_0 = "IslandShopDrawAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDrawAwardPage"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2.event, arg_2_2.contextData)

	arg_2_0.viewComponent = arg_2_2

	return
end

function var_0_1.OnLoaded(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.rtDisplayPanel, false)

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.bannerRectDic = {}
	eachChild = var_1

	var_1(arg_4_0.rtMiddle, function(arg_5_0, arg_5_1)
		setText = var_2_10002

		local var_5_0 = arg_5_0:Find("got/Text")

		i18n = var_2_10005

		var_2_10002(var_5_0, var_2_10005("island_draw_get"))

		local var_5_1 = arg_5_0.name

		switch = var_2_10003

		var_2_10003(var_5_1, {
			S = function()
				setText = var_3_10000

				local var_6_0 = arg_5_0
				local var_6_1 = var_2.Find(var_6_0, "state_sequence/Text")

				i18n = var_3_10003

				var_3_10000(var_6_1, var_3_10003("选择"))

				setText = var_3_10000

				local var_6_2 = arg_5_0
				local var_6_3 = var_2.Find(var_6_2, "finish/Text")

				i18n = var_3

				var_3_10000(var_6_3, var_3("island_draw_null"))

				onButton = var_3_10000

				local var_6_4 = arg_4_0
				local var_6_5 = arg_5_0
				local var_6_6 = var_3.Find(var_6_5, "state_sequence")

				local function var_6_7()
					local var_7_0 = arg_4_0

					var_0.OpenChangeListWindow(var_7_0)

					return
				end

				SFX_PANEL = var_6_5

				var_3_10000(var_6_4, var_6_6, var_6_7, var_6_5)

				onButton = var_3_10000

				local var_6_8 = arg_4_0
				local var_6_9 = arg_5_0
				local var_6_10 = var_3.Find(var_6_9, "btn_sequence")

				local function var_6_11()
					local var_8_0 = arg_4_0

					var_0.OpenChangeListWindow(var_8_0)

					return
				end

				SFX_PANEL = var_6_9

				var_3_10000(var_6_8, var_6_10, var_6_11, var_6_9)

				local var_6_12 = arg_4_0.bannerRectDic
				local var_6_13 = var_5_1

				BannerScrollRect4IslandDrawAward = var_6_8

				local var_6_14 = var_6_8.New
				local var_6_15 = arg_5_0
				local var_6_16 = var_4.Find(var_6_15, "mask/view/container")
				local var_6_17 = arg_5_0

				var_6_12[var_6_13] = var_6_14(var_6_16, var_5.Find(var_6_17, "dots"))

				return
			end,
			A = function()
				local var_9_0 = arg_4_0.bannerRectDic
				local var_9_1 = var_5_1

				BannerScrollRect4IslandDrawAward = var_3_10002

				local var_9_2 = var_3_10002.New
				local var_9_3 = arg_5_0
				local var_9_4 = var_4.Find(var_9_3, "mask/view/container")
				local var_9_5 = arg_5_0

				var_9_0[var_9_1] = var_9_2(var_9_4, var_5.Find(var_9_5, "dots"))

				return
			end,
			select = function()
				setText = var_3_10000

				local var_10_0 = arg_5_0
				local var_10_1 = var_2.Find(var_10_0, "count_word/Text")

				i18n = var_3_10003

				var_3_10000(var_10_1, var_3_10003("island_draw_num"))

				setText = var_3_10000

				local var_10_2 = arg_5_0
				local var_10_3 = var_2.Find(var_10_2, "btn_select/Text")

				i18n = var_3

				var_3_10000(var_10_3, var_3("island_draw_pick"))

				onButton = var_3_10000

				local var_10_4 = arg_4_0
				local var_10_5 = arg_5_0
				local var_10_6 = var_3.Find(var_10_5, "btn_select")

				local function var_10_7()
					local var_11_0 = arg_4_0

					var_0.OpenSelectAwardWindow(var_11_0)

					return
				end

				SFX_PANEL = var_10_5

				var_3_10000(var_10_4, var_10_6, var_10_7, var_10_5)

				local var_10_8 = arg_4_0.bannerRectDic
				local var_10_9 = var_5_1

				BannerScrollRect4IslandDrawAward = var_10_4

				local var_10_10 = var_10_4.New
				local var_10_11 = arg_5_0
				local var_10_12 = var_4.Find(var_10_11, "mask/view/container")
				local var_10_13 = arg_5_0

				var_10_8[var_10_9] = var_10_10(var_10_12, var_5.Find(var_10_13, "dots"))

				return
			end
		})

		return
	end)

	setText = var_1

	local var_4_0 = arg_4_0.rtTitle
	local var_4_1 = var_3.Find(var_4_0, "Text")

	i18n = var_4

	var_1(var_4_1, var_4("island_draw_time"))

	setText = var_1

	local var_4_2 = arg_4_0.btnAll
	local var_4_3 = var_3.Find(var_4_2, "Text")

	i18n = var_4

	var_1(var_4_3, var_4("island_draw_reward"))

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.btnAll

	local function var_4_6()
		local var_12_0 = arg_4_0

		var_0.OpenAllAwardWindow(var_12_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_4, var_4_5, var_4_6, var_6)

	setText = var_1

	local var_4_7 = arg_4_0.btnDraw
	local var_4_8 = var_3.Find(var_4_7, "Text")

	i18n = var_4_5

	var_1(var_4_8, var_4_5("island_draw_lottery"))

	onButton = var_1

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.btnDraw

	local function var_4_11()
		local var_13_0 = arg_4_0.activity

		if var_0.GetTimesLeft(var_13_0) < 1 then
			pg = var_0

			local var_13_1 = var_0.TipsMgr.GetInstance()
			local var_13_2 = var_0.ShowTips

			i18n = var_2_10003

			var_13_2(var_13_1, var_2_10003("island_draw_float"))

			return
		end

		local var_13_3 = arg_4_0

		var_0.TryDraw(var_13_3, 1)

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_9, var_4_10, var_4_11, var_6)

	setText = var_1

	local var_4_12 = arg_4_0.btnDrawTen
	local var_4_13 = var_3.Find(var_4_12, "Text")

	i18n = var_4_10

	var_1(var_4_13, var_4_10("island_draw_lottery"))

	onButton = var_1

	local var_4_14 = arg_4_0
	local var_4_15 = arg_4_0.btnDrawTen

	local function var_4_16()
		local var_14_0 = arg_4_0.activity

		if var_0.GetTimesLeft(var_14_0) < 10 then
			pg = var_0

			local var_14_1 = var_0.TipsMgr.GetInstance()
			local var_14_2 = var_0.ShowTips

			i18n = var_2_10003

			var_14_2(var_14_1, var_2_10003("island_draw_float"))

			return
		end

		local var_14_3 = arg_4_0

		var_0.TryDraw(var_14_3, 10)

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_14, var_4_15, var_4_16, var_6)

	onButton = var_1

	local var_4_17 = arg_4_0
	local var_4_18 = arg_4_0.rtDisplayPanel
	local var_4_19 = var_4.Find(var_4_18, "bg")

	local function var_4_20()
		if arg_4_0.inAnim then
			return
		end

		local var_15_0 = arg_4_0

		var_0.HideDrawAwardWindow(var_15_0)

		return
	end

	SFX_CANCEL = var_4_18

	var_1(var_4_17, var_4_19, var_4_20, var_4_18)

	return
end

function var_0_1.TryDraw(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.activity

	if var_2.GetDrawTimes(var_16_0) < arg_16_1 then
		Goods = var_1_10003

		local var_16_1 = var_1_10003.Create
		local var_16_2 = {}
		local var_16_3 = arg_16_0.activity

		var_16_2.id = var_6.GetDrawConfig(var_16_3, "shop")
		Goods = var_6

		local var_16_4 = var_16_1(var_16_2, var_6.TYPE_SHOPSTREET)
		local var_16_5 = var_3.GetConsume(var_16_4)
		local var_16_6 = arg_16_0.rawIconDic
		local var_16_7

		if not arg_16_0.rawIconDic.diamond then
			GetSpriteFromAtlas = var_16_7
			var_16_7 = var_16_7(var_16_5:getIcon(), "")
		end

		var_16_6.diamond = var_16_7
		var_1_10007 = arg_16_0.viewComponent

		local var_16_8 = var_5.ShowMsgBox
		local var_16_9 = {}

		IslandMsgBox = var_9
		var_16_9.type = var_9.TYPE_COMMON
		i18n = var_9

		local var_16_10 = "island_draw_tip3"

		string = var_1_10012

		local var_16_11 = var_1_10012.format("<icon name=diamond w=0.76 h=0.76/>×%d", var_16_5.count * (arg_16_1 - var_2))

		string = var_1_10013
		var_16_9.content = var_9(var_16_10, var_16_11, var_1_10013.format("<icon name=ticket w=0.76 h=0.76/>×%d", arg_16_1 - var_2))

		function var_16_9.onYes()
			local var_17_0 = var_16_5

			if var_0.getOwnedCount(var_17_0) < var_16_5.count * (arg_16_1 - var_0) then
				local var_17_1 = arg_16_0

				var_0.ShowChargeWindow(var_17_1)
			else
				local var_17_2 = arg_16_0
				local var_17_3 = var_0.emit

				IslandMediator = var_3

				var_17_3(var_17_2, var_3.SHOPPING, var_0.id, arg_16_1 - var_0)
			end

			return
		end

		var_16_9.rawIconDic = arg_16_0.rawIconDic

		var_16_8(var_1_10007, var_16_9)
	else
		local var_16_12 = arg_16_0.viewComponent
		local var_16_13 = var_3.ShowMsgBox
		local var_16_14 = {}

		IslandMsgBox = var_1_10007
		var_16_14.type = var_1_10007.TYPE_COMMON
		i18n = var_7
		var_16_14.content = var_7("island_draw_ready")

		function var_16_14.onYes()
			local var_18_0 = arg_16_0
			local var_18_1 = var_0.emit

			IslandMediator = var_2_10003

			var_18_1(var_18_0, var_2_10003.DRAW_AWARD_OPERATION, {
				op = "do_draw",
				activity_id = arg_16_0.activity.id,
				count = arg_16_1
			})

			return
		end

		var_16_13(var_16_12, var_16_14)
	end

	return
end

function var_0_1.ShowChargeWindow(arg_19_0)
	local var_19_0 = arg_19_0.viewComponent
	local var_19_1 = var_1.ShowMsgBox
	local var_19_2 = {}

	IslandMsgBox = var_1_10005
	var_19_2.type = var_1_10005.TYPE_COMMON
	i18n = var_5
	var_19_2.content = var_5("island_draw_tip4")

	function var_19_2.onYes()
		local var_20_0 = arg_19_0.viewComponent
		local var_20_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_20_2 = var_2_10003.CHANGE_SCENE

		SCENE = var_2_10004

		local var_20_3 = var_2_10004.CHARGE
		local var_20_4 = {}

		ChargeScene = var_2_10006
		var_20_4.wrap = var_2_10006.TYPE_DIAMOND

		var_20_1(var_20_0, var_20_2, var_20_3, var_20_4)

		return
	end

	var_19_1(var_19_0, var_19_2)

	return
end

function var_0_1.UpdateActivity(arg_21_0, arg_21_1)
	arg_21_0.activity = arg_21_1

	local var_21_0 = arg_21_0.activity
	local var_21_1 = var_2.GetList(var_21_0)

	eachChild = var_1_10003

	var_1_10003(arg_21_0.rtMiddle, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.name

		switch = var_2_10003

		var_2_10003(var_22_0, {
			S = function()
				setActive = var_3_10000

				local var_23_0 = arg_22_0

				var_3_10000(var_2.Find(var_23_0, "mask"), var_21_1)

				setActive = var_3_10000

				local var_23_1 = arg_22_0

				var_3_10000(var_2.Find(var_23_1, "btn_sequence"), var_21_1)

				setActive = var_3_10000

				local var_23_2 = arg_22_0

				var_3_10000(var_2.Find(var_23_2, "state_sequence"), not var_21_1)

				local var_23_4

				if var_21_1 then
					local var_23_3 = arg_21_0.activity

					var_23_4 = var_23_4.GetShowRankList(var_23_3, var_22_0)

					local var_23_5 = arg_21_0.bannerRectDic[var_22_0]

					var_3_10001.Reset(var_23_5)

					ipairs = var_3_10001

					for iter_23_0, iter_23_1 in var_3_10001(var_23_4) do
						local var_23_6 = arg_21_0.bannerRectDic[var_22_0]
						local var_23_7 = var_6.AddChild(var_23_6)

						pg = var_7

						local var_23_8 = var_7.island_draw_reward[iter_23_1]

						GetImageSpriteFromAtlasAsync = var_23_6

						var_23_6("island/IslandDrawAwardIcon/" .. var_23_8.show, "", var_23_7:Find("Image"), true)
					end

					local var_23_9 = arg_21_0.bannerRectDic[var_22_0]

					var_3_10001.SetTriggerDotCall(var_23_9, function(arg_24_0)
						local var_24_0 = var_23_4[arg_24_0]

						setActive = var_4_10002

						local var_24_1 = arg_22_0
						local var_24_2 = var_4.Find(var_24_1, "got")
						local var_24_3 = arg_21_0.activity

						var_4_10002(var_24_2, var_5.GetLastItemCount(var_24_3, var_24_0) == 0)

						return
					end)

					local var_23_10 = arg_21_0.bannerRectDic[var_22_0]

					var_3_10001.SetUp(var_23_10)
				else
					setActive = var_23_4

					local var_23_11 = arg_22_0

					var_23_4(var_2.Find(var_23_11, "got"), false)
				end

				local var_23_12 = arg_21_0.activity
				local var_23_13 = var_0.GetTimesLeft(var_23_12, var_22_0)

				setText = var_3_10001

				local var_23_14 = arg_22_0
				local var_23_15 = var_3.Find(var_23_14, "times_left/Text")

				if 0 < var_23_13 then
					i18n = var_23_16

					local var_23_16

					if not var_23_16("island_draw_last") then
						i18n = var_23_16
						var_23_16 = var_23_16("island_draw_null")
					end

					var_3_10001(var_23_15, var_23_16)

					setText = var_3_10001

					local var_23_17 = arg_22_0

					var_3_10001(var_3.Find(var_23_17, "times_left/times"), var_23_13 > 0 and var_23_13 or "")

					return
				end
			end,
			A = function()
				setActive = var_3_10000

				local var_25_0 = arg_22_0

				var_3_10000(var_2.Find(var_25_0, "got"), false)

				local var_25_1 = arg_21_0.activity
				local var_25_2 = var_0.GetTimesLeft(var_25_1, var_22_0)

				setText = var_3_10001

				local var_25_3 = arg_22_0
				local var_25_4 = var_3.Find(var_25_3, "times_left/Text")

				if 0 < var_25_2 then
					i18n = var_25_5

					local var_25_5

					if not var_25_5("island_draw_last") then
						i18n = var_25_5
						var_25_5 = var_25_5("island_draw_null")
					end

					var_3_10001(var_25_4, var_25_5)

					setText = var_3_10001

					local var_25_6 = arg_22_0

					var_3_10001(var_3.Find(var_25_6, "times_left/times"), var_25_2 > 0 and var_25_2 or "")

					local var_25_7 = arg_21_0.activity
					local var_25_8 = var_1.GetShowRankList(var_25_7, var_22_0)
					local var_25_9 = arg_21_0.bannerRectDic[var_22_0]

					var_2.Reset(var_25_9)

					ipairs = var_2

					for iter_25_0, iter_25_1 in var_2(var_25_8) do
						local var_25_10 = arg_21_0.bannerRectDic[var_22_0]
						local var_25_11 = var_7.AddChild(var_25_10)

						pg = var_8

						local var_25_12 = var_8.island_draw_reward[iter_25_1]

						GetImageSpriteFromAtlasAsync = var_25_10

						var_25_10("island/IslandDrawAwardIcon/" .. var_25_12.show, "", var_25_11:Find("Image"), true)
					end

					local var_25_13 = arg_21_0.bannerRectDic[var_22_0]

					var_2.SetTriggerDotCall(var_25_13, function(arg_26_0)
						local var_26_0 = var_25_8[arg_26_0]

						setActive = var_4_10002

						local var_26_1 = arg_22_0
						local var_26_2 = var_4.Find(var_26_1, "got")
						local var_26_3 = arg_21_0.activity

						var_4_10002(var_26_2, var_5.GetLastItemCount(var_26_3, var_26_0) == 0)

						return
					end)

					local var_25_14 = arg_21_0.bannerRectDic[var_22_0]

					var_2.SetUp(var_25_14, 1)

					return
				end
			end,
			select = function()
				setActive = var_3_10000

				local var_27_0 = arg_22_0

				var_3_10000(var_2.Find(var_27_0, "got"), false)

				local var_27_1 = arg_21_0.activity
				local var_27_2 = var_0.GetDrawCount(var_27_1)
				local var_27_3 = arg_21_0.activity
				local var_27_4

				if not var_1.GetNextCountAwardTimes(var_27_3) then
					var_27_4 = 0
				end

				setText = var_27_1

				local var_27_5 = arg_22_0
				local var_27_6 = var_4.Find(var_27_5, "count_word")

				string = var_5

				var_27_1(var_27_6, var_5.format("%d/%d", var_27_2, var_27_4))

				setActive = var_27_1

				local var_27_7 = arg_22_0

				var_27_1(var_4.Find(var_27_7, "btn_select/on"), var_27_4 > 0 and var_27_4 <= var_27_2)

				local var_27_8 = arg_21_0.activity
				local var_27_9 = var_2.GetCountAwards(var_27_8)
				local var_27_10 = arg_21_0.bannerRectDic[var_22_0]

				var_3.Reset(var_27_10)

				ipairs = var_3

				for iter_27_0, iter_27_1 in var_3(var_27_9) do
					unpack = var_27_11

					local var_27_11, var_27_12 = var_27_11(iter_27_1)
					local var_27_13 = arg_21_0.bannerRectDic[var_22_0]
					local var_27_14 = var_10.AddChild(var_27_13)

					pg = var_11

					local var_27_15 = var_11.island_draw_reward[var_27_11]

					GetImageSpriteFromAtlasAsync = var_27_13

					var_27_13("island/IslandDrawAwardIcon/" .. var_27_15.show, "", var_27_14:Find("Image"), true)
				end

				local var_27_16 = arg_21_0.bannerRectDic[var_22_0]

				var_3.SetTriggerDotCall(var_27_16, function(arg_28_0)
					unpack = var_4_10001

					local var_28_0, var_28_1 = var_4_10001(var_27_9[arg_28_0])

					setActive = var_3

					local var_28_2 = arg_22_0

					var_3(var_5.Find(var_28_2, "got"), not var_28_1)

					return
				end)

				local var_27_17 = arg_21_0.bannerRectDic[var_22_0]

				var_3.SetUp(var_27_17, 2)

				return
			end
		}, function()
			setActive = var_3_10000

			local var_29_0 = arg_22_0

			var_3_10000(var_2.Find(var_29_0, "got"), false)

			local var_29_1 = arg_21_0.activity
			local var_29_2 = var_0.GetTimesLeft(var_29_1, var_22_0)

			setText = var_3_10001

			local var_29_3 = arg_22_0
			local var_29_4 = var_3.Find(var_29_3, "times_left/Text")

			if 0 < var_29_2 then
				i18n = var_29_5

				local var_29_5

				if not var_29_5("island_draw_last") then
					i18n = var_29_5
					var_29_5 = var_29_5("island_draw_null")
				end

				var_3_10001(var_29_4, var_29_5)

				setText = var_3_10001

				local var_29_6 = arg_22_0

				var_3_10001(var_3.Find(var_29_6, "times_left/times"), var_29_2 > 0 and var_29_2 or "")

				local var_29_7 = arg_21_0.activity

				if var_1.GetShowRankList(var_29_7, var_22_0)[1] then
					pg = var_29_1

					local var_29_8 = var_29_1.island_draw_reward[var_1]

					GetImageSpriteFromAtlasAsync = var_29_7

					local var_29_9 = "island/IslandDrawAwardIcon/" .. var_29_8.show
					local var_29_10 = ""
					local var_29_11 = arg_22_0

					var_29_7(var_29_9, var_29_10, var_7.Find(var_29_11, "mask/Image"), true)

					setActive = var_29_7

					local var_29_12 = arg_22_0

					var_29_7(var_5.Find(var_29_12, "got"), false)
				end

				return
			end
		end)

		return
	end)

	pg = var_1_10003

	local var_21_2 = var_1_10003.TimeMgr.GetInstance()

	underscore = var_21_0

	local var_21_3 = var_21_0.map
	local var_21_4 = {}
	local var_21_5 = arg_21_0.activity

	var_21_4[1] = var_7.getStartTime(var_21_5)
	var_21_4[2] = arg_21_0.activity.stopTime

	local var_21_6 = var_21_3(var_21_4, function(arg_30_0)
		i18n = var_2_10001

		local var_30_0 = "trade_card_tips4"

		unpack = var_2_10004
		string = var_2_10006

		local var_30_1 = var_2_10006.split
		local var_30_2 = var_21_2

		return var_2_10001(var_30_0, var_2_10004(var_30_1(var_8.STimeDescS(var_30_2, arg_30_0, "%Y/%m/%d"), "/")))
	end)

	setText = var_5

	local var_21_7 = arg_21_0.rtTitle
	local var_21_8 = var_7.Find(var_21_7, "Text_1")

	string = var_1_10008

	local var_21_9 = var_1_10008.format
	local var_21_10 = "%s\n-%s"

	unpack = var_1_10011

	local var_21_11 = var_21_9(var_21_10, var_1_10011(var_21_6))

	i18n = var_21_7

	var_5(var_21_8, var_21_11 .. var_21_7("island_draw_time_1"))

	local var_21_12 = arg_21_0.activity
	local var_21_13 = var_5.GetTimesLeft(var_21_12)

	setActive = var_21_4

	local var_21_14 = arg_21_0.btnDraw

	var_21_4(var_8.Find(var_21_14, "bg/on"), var_21_13 >= 1)

	setActive = var_21_4

	local var_21_15 = arg_21_0.btnDraw

	var_21_4(var_8.Find(var_21_15, "bg/off"), var_21_13 < 1)

	setActive = var_21_4

	local var_21_16 = arg_21_0.btnDrawTen

	var_21_4(var_8.Find(var_21_16, "bg/on"), var_21_13 >= 10)

	setActive = var_21_4

	local var_21_17 = arg_21_0.btnDrawTen

	var_21_4(var_8.Find(var_21_17, "bg/off"), var_21_13 < 10)

	Drop = var_21_4

	local var_21_18 = var_21_4.New
	local var_21_19 = {}

	DROP_TYPE_VITEM = var_9
	var_21_19.type = var_9

	local var_21_20 = arg_21_0.activity

	var_21_19.id = var_9.GetDrawConfig(var_21_20, "cost_free")

	local var_21_21 = var_21_18(var_21_19)
	local var_21_22 = {}

	GetSpriteFromAtlas = var_21_19
	var_21_22.ticket = var_21_19(var_21_21:getIcon(), "")
	arg_21_0.rawIconDic = var_21_22
	GetImageSpriteFromAtlasAsync = var_21_22

	local var_21_23 = var_21_21:getIcon()
	local var_21_24 = ""
	local var_21_25 = arg_21_0.btnDraw

	var_21_22(var_21_23, var_21_24, var_11.Find(var_21_25, "cost/icon"))

	GetImageSpriteFromAtlasAsync = var_21_22

	local var_21_26 = var_21_21:getIcon()
	local var_21_27 = ""
	local var_21_28 = arg_21_0.btnDrawTen

	var_21_22(var_21_26, var_21_27, var_11.Find(var_21_28, "cost/icon"))

	return
end

function var_0_1.OpenChangeListWindow(arg_31_0)
	local var_31_0 = arg_31_0.viewComponent
	local var_31_1 = var_1.ShowMsgBox
	local var_31_2 = {}

	IslandMsgBox = var_1_10005
	var_31_2.type = var_1_10005.TYPE_DRAW_AWARD_LIST
	var_31_2.activity = arg_31_0.activity

	var_31_1(var_31_0, var_31_2)

	return
end

function var_0_1.OpenAllAwardWindow(arg_32_0)
	local var_32_0 = arg_32_0.viewComponent
	local var_32_1 = var_1.ShowMsgBox
	local var_32_2 = {}

	IslandMsgBox = var_1_10005
	var_32_2.type = var_1_10005.TYPE_DRAW_AWARD_ALL
	var_32_2.activity = arg_32_0.activity

	var_32_1(var_32_0, var_32_2)

	return
end

function var_0_1.OpenSelectAwardWindow(arg_33_0)
	local var_33_0 = arg_33_0.viewComponent
	local var_33_1 = var_1.ShowMsgBox
	local var_33_2 = {}

	IslandMsgBox = var_1_10005
	var_33_2.type = var_1_10005.TYPE_DRAW_AWARD_COUNT
	var_33_2.activity = arg_33_0.activity

	var_33_1(var_33_0, var_33_2)

	return
end

function var_0_1.DrawOperation(arg_34_0, arg_34_1)
	switch = var_1_10002

	var_1_10002(arg_34_1.op, {
		set_list = function()
			pg = var_2_10000

			local var_35_0 = var_2_10000.TipsMgr.GetInstance()
			local var_35_1 = var_0.ShowTips

			i18n = var_2_10003

			var_35_1(var_35_0, var_2_10003("island_draw_sort"))

			return
		end
	}, function()
		if #arg_34_1.awards > 0 then
			local var_36_0 = arg_34_0

			var_0.ShowDrawAwardWindow(var_36_0, arg_34_1.awards)
		end

		return
	end)

	return
end

function var_0_1.ShowDrawAwardWindow(arg_37_0, arg_37_1)
	local var_37_0 = #arg_37_1 > 1 and "ten" or "one"
	local var_37_1

	eachChild = var_1_10004

	local var_37_2 = arg_37_0.rtDisplayPanel

	var_1_10004(var_6.Find(var_37_2, "window"), function(arg_38_0, arg_38_1)
		setActive = var_2_10002

		var_2_10002(arg_38_0, arg_38_0.name == var_37_0)

		if arg_38_0.name == var_37_0 then
			var_37_1 = arg_38_0
		end

		eachChild = var_2

		var_2(arg_38_0:Find("container"), function(arg_39_0, arg_39_1)
			local var_39_0 = arg_39_0:Find("card")

			setActive = var_3_10003

			var_3_10003(var_39_0:Find("front/S/IslandDrawAwardPage_bomb01"), false)

			setActive = var_3_10003

			var_3_10003(var_39_0:Find("bg/S/SCardLoopVX"), false)

			setActive = var_3_10003

			var_3_10003(var_39_0:Find("front/A/IslandDrawAwardPage_bomb02"), false)

			setActive = var_3_10003

			var_3_10003(var_39_0:Find("bg/A/ACardLoopVX"), false)

			return
		end)

		return
	end)

	local var_37_3 = {}

	UIItemList = var_1_10005

	var_1_10005.StaticAlign(var_37_1:Find("container"), var_37_1:Find("container/tpl"), #arg_37_1, function(arg_40_0, arg_40_1, arg_40_2)
		local var_40_0

		if var_37_0 == "ten" then
			var_40_0 = arg_40_1 % 2 * 5 + 5
			math = var_2_10004
			arg_40_1 = var_40_0 - var_2_10004.floor(arg_40_1 / 2)
		else
			arg_40_1 = arg_40_1 + 1
		end

		UIItemList = var_40_0

		if arg_40_0 == var_40_0.EventUpdate then
			local var_40_1 = arg_40_2
			local var_40_2 = arg_40_2.Find(var_40_1, "card")
			local var_40_3 = arg_37_1[arg_40_1]

			pg = var_40_1

			local var_40_4 = var_40_1.island_draw_reward[var_40_3]

			Drop = var_6

			local var_40_5, var_40_6 = var_6.New({
				type = var_40_4.drop_type,
				id = var_40_4.drop_id
			}), var_0_1.ShowDropInfo
			local var_40_7 = var_40_2

			var_40_6(var_40_5, var_40_2.Find(var_40_7, "mask/Image"))

			switch = var_40_6

			local var_40_8 = var_40_6(var_40_4.rarity, {
				function()
					return "C"
				end,
				function()
					return "B"
				end,
				function()
					return "A"
				end,
				function()
					return "S"
				end
			})
			local var_40_9 = var_40_2:Find("mask/Image")

			if var_40_8 == "S" then
				setLocalScale = var_9

				local var_40_10 = var_40_2:Find("mask/Image")

				Vector3 = var_40_7

				var_9(var_40_10, var_40_7(1.2, 1.2, 1))

				setLocalPosition = var_9

				var_9(var_40_2:Find("mask/Image"), {
					x = -17.5,
					y = -20
				})
			else
				setLocalScale = var_9

				local var_40_11 = var_40_2:Find("mask/Image")

				Vector3 = var_40_7

				var_9(var_40_11, var_40_7(1.7, 1.7, 1))

				setLocalPosition = var_9

				local var_40_12 = var_40_2:Find("mask/Image")

				Vector3 = var_12

				var_9(var_40_12, var_12.zero)
			end

			eachChild = var_9

			var_9(var_40_2:Find("bg"), function(arg_45_0, arg_45_1)
				setActive = var_3_10002

				var_3_10002(arg_45_0, arg_45_0.name == var_40_8)

				return
			end)

			eachChild = var_9

			var_9(var_40_2:Find("word"), function(arg_46_0, arg_46_1)
				setActive = var_3_10002

				var_3_10002(arg_46_0, arg_46_0.name == var_40_8)

				return
			end)

			eachChild = var_9

			var_9(var_40_2:Find("front"), function(arg_47_0, arg_47_1)
				setActive = var_3_10002

				var_3_10002(arg_47_0, arg_47_0.name == var_40_8)

				return
			end)

			local var_40_13 = var_40_2:Find("Book")
			local var_40_14 = var_9.GetComponent

			typeof = var_12
			Book = var_14

			local var_40_15 = var_40_14(var_40_13, var_12(var_14))

			var_9.SetCurrentPage(var_40_15, 2)

			setCanvasGroupAlpha = var_10

			var_10(var_40_2, 0)

			setCanvasGroupAlpha = var_10

			var_10(var_40_2:Find("Book"), 1)

			var_37_3[arg_40_1] = arg_40_2
		end

		return
	end)

	setCanvasGroupAlpha = var_5

	local var_37_4 = arg_37_0.rtDisplayPanel

	var_5(var_7.Find(var_37_4, "page"), 0)

	local var_37_5 = {}

	table = var_6

	var_6.insert(var_37_5, function(arg_48_0)
		local var_48_0 = arg_37_0

		var_48_0.inAnim = true
		pg = var_48_0

		local var_48_1 = var_48_0.UIMgr.GetInstance()

		var_1.BlurPanel(var_48_1, arg_37_0.rtDisplayPanel, {
			staticBlur = true
		})

		setActive = var_1

		var_1(arg_37_0.rtDisplayPanel, true)

		local var_48_2 = arg_37_0.rtDisplayPanel
		local var_48_3 = var_1.GetComponent

		typeof = var_4
		DftAniEvent = var_2_10006

		local var_48_4 = var_48_3(var_48_2, var_4(var_2_10006))

		var_1.SetTriggerEvent(var_48_4, arg_48_0)

		return
	end)

	table = var_6

	var_6.insert(var_37_5, function(arg_49_0)
		local var_49_0 = {}

		ipairs = var_2_10002

		for iter_49_0, iter_49_1 in var_2_10002(var_37_3) do
			local var_49_1 = iter_49_1:Find("card")

			table = var_2_10008

			var_2_10008.insert(var_49_0, function(arg_50_0)
				local var_50_0 = {}
				local var_50_1 = (iter_49_0 - 1) % 5 * 2 + (iter_49_0 > 5 and 1 or 0)

				if var_37_0 == "ten" and 0 < var_50_1 then
					table = var_3

					var_3.insert(var_50_0, function(arg_51_0)
						LeanTween = var_4_10001

						local var_51_0 = var_4_10001.delayedCall
						local var_51_1 = iter_49_1.gameObject
						local var_51_2 = 0.03 * var_50_1

						System = var_4_10005

						var_51_0(var_51_1, var_51_2, var_4_10005.Action(arg_51_0))

						return
					end)
				end

				table = var_3

				var_3.insert(var_50_0, function(arg_52_0)
					local var_52_0 = var_49_1
					local var_52_1 = var_1.GetComponent

					typeof = var_4_10004
					DftAniEvent = var_4_10006

					local var_52_2 = var_52_1(var_52_0, var_4_10004(var_4_10006))

					var_1.SetEndEvent(var_52_2, function(arg_53_0)
						arg_52_0()

						return
					end)

					switch = var_1

					var_1(var_37_0, {
						one = function()
							quickPlayAnimation = var_5_10000

							var_5_10000(var_49_1, "anim_IslandDrawAwardPage_onetpl_In")

							return
						end,
						ten = function()
							quickPlayAnimation = var_5_10000

							var_5_10000(var_49_1, var_50_1 % 2 == 0 and "anim_IslandDrawAwardPage_ten" or "anim_IslandDrawAwardPage_ten02")

							return
						end
					})

					return
				end)

				seriesAsync = var_3

				var_3(var_50_0, arg_50_0)

				return
			end)
		end

		parallelAsync = var_2

		var_2(var_49_0, function()
			LeanTween = var_3_10000

			local var_56_0 = var_3_10000.delayedCall
			local var_56_1 = 0.6

			System = var_3_10003

			var_56_0(var_56_1, var_3_10003.Action(function()
				arg_49_0()

				return
			end))

			return
		end)

		return
	end)

	table = var_6

	var_6.insert(var_37_5, function(arg_58_0)
		local var_58_0 = {}

		ipairs = var_2_10002

		for iter_58_0, iter_58_1 in var_2_10002(var_37_3) do
			local var_58_1 = iter_58_1:Find("card")

			table = var_2_10008

			var_2_10008.insert(var_58_0, function(arg_59_0)
				local var_59_0 = {}
				local var_59_1 = iter_58_0 - 1

				if 0 < var_59_1 then
					table = var_3

					var_3.insert(var_59_0, function(arg_60_0)
						LeanTween = var_4_10001

						local var_60_0 = var_4_10001.delayedCall
						local var_60_1 = iter_58_1.gameObject
						local var_60_2 = 0.1 * var_59_1

						System = var_4_10005

						var_60_0(var_60_1, var_60_2, var_4_10005.Action(arg_60_0))

						return
					end)
				end

				table = var_3

				var_3.insert(var_59_0, function(arg_61_0)
					local var_61_0 = var_58_1
					local var_61_1 = var_1.Find(var_61_0, "Book")
					local var_61_2 = var_1.GetComponent

					typeof = var_4
					AutoFlip = var_4_10006

					local var_61_3 = var_61_2(var_61_1, var_4(var_4_10006))

					var_1.StartControl(var_61_3)

					local var_61_4 = var_58_1
					local var_61_5 = var_2.GetComponent

					typeof = var_4_10005
					DftAniEvent = var_4_10007

					local var_61_6 = var_61_5(var_61_4, var_4_10005(var_4_10007))

					var_2.SetEndEvent(var_61_6, function()
						local var_62_0 = var_0

						var_0.StopControl(var_62_0)
						arg_61_0()

						return
					end)

					quickPlayAnimation = var_2

					var_2(var_58_1, "anim_IslandDrawAwardPage_uncover")

					return
				end)

				seriesAsync = var_3

				var_3(var_59_0, arg_59_0)

				return
			end)
		end

		quickPlayAnimation = var_2

		local var_58_2 = arg_37_0.rtDisplayPanel

		var_2(var_4.Find(var_58_2, "page"), "anim_IslandDrawAwardPage_page_in")

		parallelAsync = var_2

		var_2(var_58_0, arg_58_0)

		return
	end)

	table = var_6

	var_6.insert(var_37_5, function(arg_63_0)
		LeanTween = var_2_10001

		local var_63_0 = var_2_10001.delayedCall
		local var_63_1 = 0.5

		System = var_2_10004

		var_63_0(var_63_1, var_2_10004.Action(function()
			arg_63_0()

			return
		end))

		return
	end)

	seriesAsync = var_6

	var_6(var_37_5, function()
		if arg_37_0._state == var_0_1.STATES.DESTROY then
			return
		end

		quickPlayAnimation = var_0

		local var_65_0 = arg_37_0.rtDisplayPanel

		var_0(var_2.Find(var_65_0, "page"), "anim_IslandDrawAwardPage_page_out")

		arg_37_0.inAnim = false

		return
	end)

	return
end

function var_0_1.HideDrawAwardWindow(arg_66_0)
	pg = var_1_10001

	local var_66_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_66_0, arg_66_0.rtDisplayPanel, arg_66_0._tf)

	setActive = var_1

	var_1(arg_66_0.rtDisplayPanel, false)

	eachChild = var_1

	local var_66_1 = arg_66_0.rtDisplayPanel

	var_1(var_3.Find(var_66_1, "window"), function(arg_67_0, arg_67_1)
		eachChild = var_2_10002

		var_2_10002(arg_67_0:Find("container"), function(arg_68_0, arg_68_1)
			LeanTween = var_3_10002

			var_3_10002.cancel(arg_68_0.gameObject)

			return
		end)

		return
	end)

	return
end

function var_0_1.Hide(arg_69_0)
	isActive = var_1_10001

	if var_1_10001(arg_69_0.rtDisplayPanel) then
		arg_69_0:HideDrawAwardWindow()
	end

	var_0_1.super.Hide(arg_69_0)

	return
end

function var_0_1.OnDestroy(arg_70_0)
	arg_70_0:Hide()

	pairs = var_1

	for iter_70_0, iter_70_1 in var_1(arg_70_0.bannerRectDic) do
		iter_70_1:Dispose()
	end

	arg_70_0.bannerRectDic = nil

	return
end

function var_0_1.ShowDropInfo(arg_71_0, arg_71_1)
	switch = var_1_10002

	local var_71_0 = arg_71_0.type
	local var_71_1 = {}

	DROP_TYPE_ISLAND_INVITATION = var_1_10006
	var_71_1[var_1_10006] = function()
		GetImageSpriteFromAtlasAsync = var_2_10000

		local var_72_0 = "island/IslandCharIcon/"
		local var_72_1 = arg_71_0

		var_2_10000(var_72_0 .. var_3.getConfig(var_72_1, "chara_pic"), "", arg_71_1, true)

		return
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10006
	var_71_1[var_1_10006] = function()
		GetImageSpriteFromAtlasAsync = var_2_10000

		local var_73_0 = "Island/IslandFurnitureIcon/"
		local var_73_1 = arg_71_0

		var_2_10000(var_73_0 .. var_3.getConfig(var_73_1, "icon"), "", arg_71_1, true)

		return
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10006
	var_71_1[var_1_10006] = function()
		GetImageSpriteFromAtlasAsync = var_2_10000

		local var_74_0 = "island/IslandDressIcon/"
		local var_74_1 = arg_71_0

		var_2_10000(var_74_0 .. var_3.getConfig(var_74_1, "icon"), "", arg_71_1, true)

		return
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10006
	var_71_1[var_1_10006] = function()
		GetImageSpriteFromAtlasAsync = var_2_10000

		local var_75_0 = "island/IslandDressIcon/"
		local var_75_1 = arg_71_0

		var_2_10000(var_75_0 .. var_3.getConfig(var_75_1, "icon"), "", arg_71_1, true)

		return
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10006
	var_71_1[var_1_10006] = function()
		GetImageSpriteFromAtlasAsync = var_2_10000

		local var_76_0 = "Island/IslandActionIcon/"
		local var_76_1 = arg_71_0

		var_2_10000(var_76_0 .. var_3.getConfig(var_76_1, "resource"), "", arg_71_1, true)

		return
	end

	var_1_10002(var_71_0, var_71_1)

	return
end

return var_0_1
