class = var_0_10000

local var_0_0 = "LevelRemasterView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelRemasterView"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.content = var_1.Find(var_2_0, "list/content")

	local var_2_1 = arg_2_0.content

	arg_2_0.item = var_1.Find(var_2_1, "item")

	local var_2_2 = arg_2_0._tf

	arg_2_0.numsTxt = var_1.Find(var_2_2, "nums/text")

	local var_2_3 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_3, "help")
	setActive = var_1

	var_1(arg_2_0.item, false)

	local var_2_4 = arg_2_0._tf

	arg_2_0.getRemasterTF = var_1.Find(var_2_4, "getBtn/state_before")

	local var_2_5 = arg_2_0._tf

	arg_2_0.gotRemasterTF = var_1.Find(var_2_5, "getBtn/state_after")

	local var_2_6 = arg_2_0._tf

	arg_2_0.exToggle = var_1.Find(var_2_6, "toggles/EX")

	local var_2_7 = arg_2_0._tf

	arg_2_0.spToggle = var_1.Find(var_2_7, "toggles/SP")

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.bind

	LevelUIConst = var_3

	var_2_9(var_2_8, var_3.FLUSH_REMASTER_INFO, function(arg_3_0)
		local var_3_0 = arg_2_0

		if not var_1.isShowing(var_3_0) then
			return
		end

		local var_3_1 = arg_2_0

		var_1.flushOnly(var_3_1)

		return
	end)

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.bind

	LevelUIConst = var_3

	var_2_11(var_2_10, var_3.FLUSH_REMASTER_TICKET, function(arg_4_0)
		local var_4_0 = arg_2_0

		if not var_1.isShowing(var_4_0) then
			return
		end

		local var_4_1 = arg_2_0

		var_1.updateTicketDisplay(var_4_1)

		return
	end)

	getProxy = var_2_11
	ChapterProxy = var_2_10

	local var_2_12 = var_2_11(var_2_10)

	pg = var_2_10

	local var_2_13 = var_2_10.TimeMgr.GetInstance()

	UIItemList = var_3
	arg_2_0.itemList = var_3.New(arg_2_0.content, arg_2_0.item)

	local var_2_14 = arg_2_0.itemList

	var_3.make(var_2_14, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_2_0.temp[arg_5_1]

			setActive = var_2_10004

			var_2_10004(arg_5_2:Find("right"), arg_5_1 % 2 > 0)

			local var_5_1 = arg_5_2:Find("bg/icon")
			local var_5_2 = arg_5_2:Find("bg/lock")
			local var_5_3 = arg_5_2:Find("bg/wait")
			local var_5_4 = arg_5_2
			local var_5_5 = arg_5_2.Find(var_5_4, "bg/tip")

			setActive = var_5_4

			var_5_4(var_5_1, false)

			setActive = var_5_4

			var_5_4(var_5_2, false)

			setActive = var_5_4

			var_5_4(var_5_3, false)

			setActive = var_5_4

			var_5_4(var_5_5, false)

			if not var_5_0 then
				setActive = var_5_4

				var_5_4(var_5_3, true)

				onButton = var_5_4

				local var_5_6 = arg_2_0
				local var_5_7 = var_5_3

				local function var_5_8()
					pg = var_3_10000

					local var_6_0 = var_3_10000.TipsMgr.GetInstance()
					local var_6_1 = var_0.ShowTips

					i18n = var_3_10002

					var_6_1(var_6_0, var_3_10002("levelScene_remaster_do_not_open"))

					return
				end

				SFX_PANEL = var_2_10012

				var_5_4(var_5_6, var_5_7, var_5_8, var_2_10012)
			else
				local var_5_9 = var_2_13

				if not var_8.inTime(var_5_9, var_5_0.time) then
					setActive = var_8

					var_8(var_5_2, true)

					onButton = var_8

					local var_5_10 = arg_2_0
					local var_5_11 = var_5_2

					local function var_5_12()
						pg = var_3_10000

						local var_7_0 = var_3_10000.TipsMgr.GetInstance()
						local var_7_1 = var_0.ShowTips

						i18n = var_3_10002

						var_7_1(var_7_0, var_3_10002("levelScene_remaster_do_not_open"))

						return
					end

					SFX_PANEL = var_2_10012

					var_8(var_5_10, var_5_11, var_5_12, var_2_10012)
				else
					setActive = var_8

					var_8(var_5_1, true)

					GetImageSpriteFromAtlasAsync = var_8

					var_8("activitybanner/" .. var_5_0.bg, "", var_5_1)

					local var_5_13 = var_5_1
					local var_5_14 = var_5_1.Find(var_5_13, "info")

					setText = var_5_13

					local var_5_15 = var_5_14:Find("dec1/index")
					local var_5_16

					if not (arg_5_1 < 10) or not ("0" .. arg_5_1) then
						var_5_16 = arg_5_1
					end

					var_5_13(var_5_15, var_5_16)

					BossRushChapterRemasterHelper = var_5_13

					local var_5_17 = var_5_13.GetProgress(var_5_0.id)

					setText = var_10

					var_10(var_5_14:Find("progress/Text"), var_5_17 .. "%")

					onButton = var_10

					local var_5_18 = arg_2_0
					local var_5_19 = var_5_1

					local function var_5_20()
						BossRushChapterRemasterHelper = var_3_10000

						if var_3_10000.IsRemasterByActivity(var_5_0.id) then
							local var_8_0 = arg_2_0

							var_0.HandleActTypeRemaster(var_8_0, var_5_0)

							return
						end

						if (function()
							pg = var_4_10000

							local var_9_0 = var_4_10000.chapter_template[var_5_0.config_data[1]].map

							ipairs = var_1

							local var_9_1 = {}

							PlayerPrefs = var_4_10003
							var_9_1[1] = var_4_10003.GetInt("remaster_lastmap_" .. var_5_0.id, var_9_0)
							var_9_1[2] = var_9_0

							for iter_9_0, iter_9_1 in var_1(var_9_1) do
								local var_9_2 = var_2_12
								local var_9_3 = var_6.getMapById(var_9_2, iter_9_1)

								if var_6.isUnlock(var_9_3) then
									return iter_9_1
								end
							end

							return
						end)() then
							arg_2_0.onSelectMap(var_0)

							local var_8_1 = arg_2_0

							var_1.Hide(var_8_1)
						end

						return
					end

					SFX_PANEL = var_2_10014

					var_10(var_5_18, var_5_19, var_5_20, var_2_10014)

					BossRushChapterRemasterHelper = var_10

					local var_5_21 = var_10.ChapterAwardInfo(var_5_0.id)

					underscore = var_11

					local var_5_22 = var_11.rest(var_5_0.drop_display, 1)

					if var_5_21 then
						table = var_12

						var_12.insert(var_5_22, 1, var_5_21)
					elseif #var_5_0.drop_display_sp > 0 then
						table = var_12
						var_5_22 = var_12.mergeArray(var_5_0.drop_display_sp, var_5_22)
					end

					local var_5_23 = var_5_14
					local var_5_24 = var_5_14.Find(var_5_23, "content")

					eachChild = var_5_23

					var_5_23(var_5_24, function(arg_10_0)
						setActive = var_3_10001

						var_3_10001(arg_10_0, false)

						return
					end)

					ipairs = var_5_23

					for iter_5_0, iter_5_1 in var_5_23(var_5_22) do
						if var_5_24.childCount < iter_5_0 then
							cloneTplTo = var_18

							local var_5_25

							if not var_18(var_5_24:GetChild(0), var_5_24) then
								var_2_10019 = var_5_24
								var_5_25 = var_5_24.GetChild(var_2_10019, iter_5_0 - 1)
							end

							setActive = var_2_10019

							var_2_10019(var_5_25, true)

							if var_5_21 and iter_5_0 == 1 then
								var_2_10019 = var_5_21[1]
								unpack = var_20

								local var_5_26, var_5_27, var_5_28, var_5_29, var_5_30 = var_20(var_5_21[2])
								local var_5_31 = var_5_21[3]
								local var_5_32 = var_2_12
								local var_5_33 = var_25.getRemasterInfo(var_5_32, var_5_31, var_5_26, var_2_10019)

								setActive = var_5_32

								var_5_32(var_5_5, var_5_29 <= var_5_33.count)

								setActive = var_5_32

								var_5_32(var_5_25:Find("mark"), var_5_29 > var_5_33.count)

								setActive = var_5_32

								var_5_32(var_5_25:Find("Slider"), var_5_29 > var_5_33.count)

								setActive = var_5_32

								var_5_32(var_5_25:Find("achieve"), var_5_29 <= var_5_33.count)

								setSlider = var_5_32

								var_5_32(var_5_25:Find("Slider"), 0, var_5_29, var_5_33.count)

								local var_5_34 = {
									type = var_5_27,
									id = var_5_28
								}

								updateDrop = var_27

								var_27(var_5_25:Find("IconTpl"), var_5_34)

								onButton = var_27

								local var_5_35 = arg_2_0
								local var_5_36 = var_5_25:Find("IconTpl")

								local function var_5_37()
									BossRushChapterRemasterHelper = var_3_10000

									local var_11_0 = var_3_10000.GetAwardName(var_5_31, var_5_26)

									pg = var_1

									local var_11_1 = var_1.MsgboxMgr.GetInstance()
									local var_11_2 = var_1.ShowMsgBox
									local var_11_3 = {
										hideYes = true,
										hideNo = true
									}

									MSGBOX_TYPE_SINGLE_ITEM = var_3_10004
									var_11_3.type = var_3_10004
									var_11_3.drop = var_5_34

									local var_11_4 = {}

									i18n = var_3_10005
									var_11_4.word = var_3_10005("level_remaster_tip4", var_11_0)
									var_11_4.number = var_5_33.count .. "/" .. var_5_29
									i18n = var_5
									var_11_4.btn_text = var_5(var_5_33.count < var_5_29 and "level_remaster_tip2" or "level_remaster_tip3")

									function var_11_4.btn_call()
										if var_5_33.count < var_5_29 then
											local var_12_1

											if var_5_31 and var_5_31 > 0 then
												local var_12_0 = arg_2_0

												var_12_1 = var_12_1.emit
												LevelMediator2 = var_4_10002

												var_12_1(var_12_0, var_4_10002.ON_BOSSRUSH_REMASTER_ACTIVITY, var_5_31)

												local var_12_2 = arg_2_0

												var_12_1.Hide(var_12_2)

												return
											end

											pg = var_12_1

											local var_12_3 = var_12_1.chapter_template[var_5_26].map

											var_4_10002 = var_2_12
											var_4_10002 = var_1.getMapById(var_4_10002, var_12_3)

											local var_12_4

											var_12_4, var_4_10002 = var_1.isUnlock(var_4_10002)

											if not var_12_4 then
												pg = var_3

												local var_12_5 = var_3.TipsMgr.GetInstance()

												var_3.ShowTips(var_12_5, var_4_10002)
											else
												arg_2_0.onSelectMap(var_12_3)

												local var_12_6 = arg_2_0

												var_3.Hide(var_12_6)
											end
										else
											local var_12_7 = arg_2_0
											local var_12_8 = var_0.emit

											LevelMediator2 = var_4_10002

											var_12_8(var_12_7, var_4_10002.ON_CHAPTER_REMASTER_AWARD, var_5_26, var_2_10019, var_5_31)
										end

										return
									end

									var_11_3.remaster = var_11_4

									var_11_2(var_11_1, var_11_3)

									return
								end

								SFX_PANEL = var_31

								var_27(var_5_35, var_5_36, var_5_37, var_31)
							else
								var_2_10019 = {
									type = iter_5_1[1][1],
									id = iter_5_1[1][2]
								}
								updateDrop = var_20

								var_20(var_5_25:Find("IconTpl"), var_2_10019)

								onButton = var_20

								local var_5_38 = arg_2_0
								local var_5_39 = var_5_25:Find("IconTpl")

								local function var_5_40()
									pg = var_3_10000

									local var_13_0 = var_3_10000.MsgboxMgr.GetInstance()
									local var_13_1 = var_0.ShowMsgBox
									local var_13_2 = {
										hideYes = true,
										hideNo = true
									}

									MSGBOX_TYPE_SINGLE_ITEM = var_3_10003
									var_13_2.type = var_3_10003
									var_13_2.drop = var_2_10019

									local var_13_3 = {}

									i18n = var_3_10004
									var_13_3.word = var_3_10004("level_remaster_tip1") .. iter_5_1[2]
									i18n = var_4
									var_13_3.btn_text = var_4("text_confirm")
									var_13_2.remaster = var_13_3

									var_13_1(var_13_0, var_13_2)

									return
								end

								SFX_PANEL = var_24

								var_20(var_5_38, var_5_39, var_5_40, var_24)

								setActive = var_20

								var_20(var_5_25:Find("mark"), false)

								setActive = var_20

								var_20(var_5_25:Find("Slider"), false)

								setActive = var_20

								var_20(var_5_25:Find("achieve"), false)
							end
						end
					end
				end
			end
		end

		return
	end)

	onButton = var_3

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.getRemasterTF

	local function var_2_17()
		local var_14_0 = var_2_12.remasterTickets

		pg = var_2_10001

		local var_14_1 = var_14_0 + var_2_10001.gameset.reactivity_ticket_daily.key_value

		pg = var_1

		if var_1.gameset.reactivity_ticket_max.key_value < var_14_1 then
			local var_14_2 = {}

			i18n = var_1
			var_2_10002 = "tack_tickets_max_warning"
			math = var_2_10003

			local var_14_3 = var_2_10003.max

			pg = var_2_10004
			var_14_2.content = var_1(var_2_10002, var_14_3(var_2_10004.gameset.reactivity_ticket_max.key_value - var_2_12.remasterTickets, 0))

			function var_14_2.onYes()
				local var_15_0 = arg_2_0
				local var_15_1 = var_0.emit

				LevelMediator2 = var_3_10002

				var_15_1(var_15_0, var_3_10002.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

				return
			end

			pg = var_1
			var_2_10002 = var_1.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_2_10002, var_14_2)

			return
		end

		local var_14_4 = arg_2_0
		local var_14_5 = var_0.emit

		LevelMediator2 = var_2_10002

		var_14_5(var_14_4, var_2_10002.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_15, var_2_16, var_2_17, var_1_10007)

	return
end

function var_0_1.HandleActTypeRemaster(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.activity_id

	getProxy = var_1_10003
	ActivityPermanentProxy = var_1_10004

	local var_16_1 = var_1_10003(var_1_10004)
	local var_16_2

	var_16_2 = var_3.GetActivityTypeById(var_16_1, var_16_0) and var_3:getDoingActivityId(var_4)

	local function var_16_3()
		local var_17_0 = arg_16_0
		local var_17_1 = var_0.emit

		LevelMediator2 = var_2_10002

		var_17_1(var_17_0, var_2_10002.ON_BOSSRUSH_REMASTER_ACTIVITY, var_16_0)

		return
	end

	if var_16_2 and var_16_2 ~= var_16_0 then
		pg = var_1_10007

		local var_16_4 = var_1_10007.MsgboxMgr.GetInstance()
		local var_16_5 = var_7.ShowMsgBox
		local var_16_6 = {}

		i18n = var_1_10010
		var_16_6.content = var_1_10010("bossrush_act_remaster_close_prev_one_tip")
		var_16_6.onYes = var_16_3

		var_16_5(var_16_4, var_16_6)

		return
	end

	var_16_3()

	return
end

function var_0_1.OnDestroy(arg_18_0)
	arg_18_0.onItem = nil

	if arg_18_0:isShowing() then
		arg_18_0:Hide()
	end

	return
end

function var_0_1.Show(arg_19_0)
	var_0_1.super.Show(arg_19_0)

	pg = var_1

	local var_19_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_19_0, arg_19_0._tf)

	return
end

function var_0_1.Hide(arg_20_0)
	var_0_1.super.Hide(arg_20_0)

	pg = var_1

	local var_20_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0._tf, arg_20_0._parentTf)

	return
end

function var_0_1.set(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.templates = {}
	ipairs = var_3
	pg = var_1_10004

	for iter_21_0, iter_21_1 in var_3(var_1_10004.re_map_template.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.re_map_template[iter_21_1]
		table = var_1_10009

		var_1_10009.insert(arg_21_0.templates, var_1_10008)
	end

	arg_21_0.onSelectMap = arg_21_1

	arg_21_0:flush(arg_21_2)

	return
end

function var_0_1.flush(arg_22_0, arg_22_1)
	onButton = var_1_10002

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0._tf
	local var_22_2 = var_4.Find(var_22_1, "bg")

	local function var_22_3()
		local var_23_0 = arg_22_0

		var_0.Hide(var_23_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10002(var_22_0, var_22_2, var_22_3, var_6)

	onButton = var_1_10002

	local var_22_4 = arg_22_0
	local var_22_5 = arg_22_0.helpBtn

	local function var_22_6()
		pg = var_2_10000

		local var_24_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_24_1 = var_0.ShowMsgBox
		local var_24_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_24_2.type = var_2_10003
		i18n = var_2_10003
		var_24_2.helps = var_2_10003("levelScene_remaster_help_tip")

		var_24_1(var_24_0, var_24_2)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_22_4, var_22_5, var_22_6, var_6)
	arg_22_0:updateTicketDisplay()

	local var_22_7 = {
		arg_22_0.exToggle,
		arg_22_0.spToggle
	}

	getProxy = var_3
	ChapterProxy = var_22_5

	local var_22_8 = var_3(var_22_5)

	ipairs = var_22_5

	for iter_22_0, iter_22_1 in var_22_5(var_22_7) do
		onToggle = var_1_10009

		local var_22_9 = arg_22_0
		local var_22_10 = iter_22_1

		local function var_22_11(arg_25_0)
			if arg_25_0 then
				local var_25_0 = arg_22_0

				underscore = var_2_10002
				var_25_0.temp = var_2_10002.filter(arg_22_0.templates, function(arg_26_0)
					BossRushChapterRemasterHelper = var_3_10001

					return var_3_10001.GetExOrSp4Filter(arg_26_0.activity_type) == iter_22_0
				end)

				local var_25_1 = {}

				ipairs = var_2

				for iter_25_0, iter_25_1 in var_2(arg_22_0.temp) do
					local var_25_2 = iter_25_1.id

					BossRushChapterRemasterHelper = var_2_10008
					var_2_10008 = var_2_10008.ExistCanGetAward(iter_25_1.id) and 0 or 1
					var_25_1[var_25_2] = var_2_10008
				end

				table = var_2

				local var_25_3 = var_2.sort
				local var_25_4 = arg_22_0.temp

				CompareFuncs = var_4

				var_25_3(var_25_4, var_4({
					function(arg_27_0)
						local var_27_0

						if not var_25_1[arg_27_0.id] then
							var_27_0 = 1
						end

						return var_27_0
					end,
					function(arg_28_0)
						return arg_28_0.order
					end
				}))

				local var_25_5 = arg_22_0.itemList
				local var_25_6 = var_2.align

				math = var_4

				local var_25_7 = var_4.max

				math = var_5

				var_25_6(var_25_5, var_25_7(var_5.ceil(#arg_22_0.temp / 2) * 2, 4))
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_1_10009(var_22_9, var_22_10, var_22_11, var_1_10013)
	end

	triggerToggle = var_4

	var_4(var_22_7[arg_22_1 and 2 or 1], true)

	return
end

function var_0_1.MatchType(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_1 == arg_29_2
end

function var_0_1.flushOnly(arg_30_0)
	local var_30_0 = arg_30_0.itemList
	local var_30_1 = var_1.align

	math = var_1_10003

	local var_30_2 = var_1_10003.max

	math = var_1_10004

	var_30_1(var_30_0, var_30_2(var_1_10004.ceil(#arg_30_0.temp / 2) * 2, 4))

	return
end

function var_0_1.updateTicketDisplay(arg_31_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_31_0 = var_1_10001(var_1_10002).remasterDailyCount
	local var_31_1 = 0 < var_31_0

	SetActive = var_3

	var_3(arg_31_0.getRemasterTF, not var_31_1)

	SetActive = var_3

	var_3(arg_31_0.gotRemasterTF, var_31_1)

	setText = var_3

	local var_31_2 = arg_31_0.numsTxt
	local var_31_3 = var_1.remasterTickets
	local var_31_4 = "/"

	pg = var_1_10007

	var_3(var_31_2, var_31_3 .. var_31_4 .. var_1_10007.gameset.reactivity_ticket_max.key_value)

	return
end

return var_0_1
