class = var_0_10000

local var_0_0 = "ItemTipPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

var_0_1.DetailConfig = {}

function var_0_1.ShowItemTip(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1.GetDropLackConfig

	Drop = var_1_10005

	if not var_1_0(var_1_10005.New({
		type = arg_1_0,
		id = arg_1_1
	})) then
		return
	end

	pg = var_5

	local var_1_1 = var_5.MsgboxMgr.GetInstance()
	local var_1_2 = var_5.ShowMsgBox
	local var_1_3 = {}

	MSGBOX_TYPE_ITEMTIP = var_1_10008
	var_1_3.type = var_1_10008
	Drop = var_1_10008
	var_1_3.drop = var_1_10008.New({
		type = arg_1_0,
		id = arg_1_1
	})
	var_1_3.descriptions = var_4.description
	var_1_3.msgTitle = arg_1_2
	var_1_3.goSceneCallack = arg_1_3

	var_1_2(var_1_1, var_1_3)

	return true
end

function var_0_1.GetDropLackConfig(arg_2_0)
	local var_2_0 = arg_2_0.type

	DROP_TYPE_RESOURCE = var_1_10002

	if var_2_0 == var_1_10002 then
		Drop = var_2_0

		local var_2_1 = var_2_0.New
		local var_2_2 = {}

		DROP_TYPE_ITEM = var_1_10003
		var_2_2.type = var_1_10003
		id2ItemId = var_1_10003
		var_2_2.id = var_1_10003(arg_2_0.id)
		arg_2_0 = var_2_1(var_2_2)
	end

	if not var_0_1.DetailConfig[arg_2_0.type] then
		local var_2_3 = var_0_1.DetailConfig

		var_2_3[arg_2_0.type] = {}
		ipairs = var_2_3
		pg = var_2

		local var_2_4

		if not var_2.item_lack.get_id_list_by_drop_type[arg_2_0.type] then
			var_2_4 = {}
		end

		for iter_2_0, iter_2_1 in var_2_3(var_2_4) do
			pg = var_1_10006
			var_1_10006 = var_1_10006.item_lack[iter_2_1]
			ipairs = var_1_10007

			for iter_2_2, iter_2_3 in var_1_10007(var_1_10006.itemids) do
				var_0_1.DetailConfig[arg_2_0.type][iter_2_3] = var_1_10006
			end
		end
	end

	return var_0_1.DetailConfig[arg_2_0.type][arg_2_0.id]
end

function var_0_1.ShowItemTipbyID(...)
	local var_3_0 = var_0_1.ShowItemTip

	DROP_TYPE_ITEM = var_1_10001

	return var_3_0(var_1_10001, ...)
end

function var_0_1.CanShowTip(arg_4_0)
	tobool = var_1_10001

	local var_4_0 = var_0_1.GetDropLackConfig

	Drop = var_1_10003

	local var_4_1 = var_1_10003.New
	local var_4_2 = {}

	DROP_TYPE_ITEM = var_1_10005
	var_4_2.type = var_1_10005
	var_4_2.id = arg_4_0

	return var_1_10001(var_4_0(var_4_1(var_4_2)))
end

function var_0_1.ShowRingBuyTip()
	GoShoppingMsgBox = var_1_10000
	i18n = var_1_10001

	local var_5_0 = "switch_to_shop_tip_2"

	string = var_1_10003

	local var_5_1 = var_1_10003.format
	local var_5_2 = "<color=#92FC63FF>%s</color>"

	Item = var_1_10005

	local var_5_3 = var_1_10005.getConfigData

	ITEM_ID_FOR_PROPOSE = var_1_10006

	local var_5_4 = var_1_10001(var_5_0, var_5_1(var_5_2, var_5_3(var_1_10006).name))

	ChargeScene = var_5_0

	var_1_10000(var_5_4, var_5_0.TYPE_ITEM)

	return
end

function var_0_1.ShowGoldBuyTip(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getRawData(var_6_0)

	GoShoppingMsgBox = var_6_0
	i18n = var_1_10003

	local var_6_2 = "switch_to_shop_tip_2"

	i18n = var_1_10005

	local var_6_3 = var_1_10003(var_6_2, var_1_10005("word_gold"))

	ChargeScene = var_6_2

	local var_6_4 = var_6_2.TYPE_ITEM
	local var_6_5 = {}
	local var_6_6 = {
		59001
	}

	id2res = var_1_10007
	var_6_6[2] = arg_6_0 - var_6_1[var_1_10007(1)]
	var_6_6[3] = arg_6_0
	var_6_5[1] = var_6_6

	var_6_0(var_6_3, var_6_4, var_6_5)

	return
end

function var_0_1.ShowOilBuyTip(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1 = var_2.getRawData(var_7_0)

	ShoppingStreet = var_7_0

	local var_7_2 = var_7_0.getRiseShopId

	ShopArgs = var_1_10004

	if not var_7_2(var_1_10004.BuyOil, var_7_1.buyOilCount) then
		return
	end

	pg = var_4

	local var_7_3 = var_4.shop_template[var_3].num
	local var_7_4

	if var_4.num == -1 then
		var_7_4 = var_4.genre
		ShopArgs = var_1_10007

		if var_7_4 == var_1_10007.BuyOil then
			ShopArgs = var_7_4
			var_7_3 = var_7_4.getOilByLevel(var_7_1.level)
		end
	end

	pg = var_7_4

	if var_7_4.gameset.buy_oil_limit.key_value <= var_7_1.buyOilCount then
		return
	end

	arg_7_1 = arg_7_1 or "oil_buy_tip_2"
	pg = var_7

	local var_7_5 = var_7.MsgboxMgr.GetInstance()
	local var_7_6 = var_7.ShowMsgBox
	local var_7_7 = {
		yseBtnLetf = true
	}

	MSGBOX_TYPE_SINGLE_ITEM = var_1_10010
	var_7_7.type = var_1_10010
	var_7_7.windowSize = {
		y = 570
	}
	i18n = var_10

	local var_7_8 = arg_7_1
	local var_7_9 = var_4.resource_num
	local var_7_10 = var_7_3
	local var_7_11 = var_7_1.buyOilCount

	id2res = var_1_10015
	var_7_7.content = var_10(var_7_8, var_7_9, var_7_10, var_7_11, arg_7_0 - var_7_1[var_1_10015(2)])

	local var_7_12 = {
		id = 2
	}

	DROP_TYPE_RESOURCE = var_7_8
	var_7_12.type = var_7_8
	var_7_12.count = var_7_3
	var_7_7.drop = var_7_12

	function var_7_7.onYes()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.SHOPPING, {
			isQuickShopping = true,
			count = 1,
			id = var_0
		})

		pg = var_8_1

		local var_8_2 = var_8_1.TrackerMgr.GetInstance()
		local var_8_3 = var_0.Tracking

		TRACKING_PAY_OIL = var_2

		var_8_3(var_8_2, var_2)

		return
	end

	var_7_6(var_7_5, var_7_7)

	return true
end

function var_0_1.getUIName(arg_9_0)
	return "Msgbox4ItemGo"
end

function var_0_1.OnInit(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.list = var_1.Find(var_10_0, "skipable_list")

	local var_10_1 = arg_10_0.list

	arg_10_0.tpl = var_1.Find(var_10_1, "tpl")

	local var_10_2 = arg_10_0._tf

	arg_10_0.title = var_1.Find(var_10_2, "name")

	return
end

function var_0_1.OnRefresh(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.viewParent._btnContainer, false)

	local var_11_0 = arg_11_1.drop
	local var_11_1 = var_2.getName(var_11_0)
	local var_11_2 = arg_11_1.descriptions

	setText = var_4

	local var_11_3 = arg_11_0.title
	local var_11_4

	if not arg_11_1.msgTitle then
		i18n = var_11_4
		var_11_4 = var_11_4("item_lack_title", var_11_1, var_11_1)
	end

	var_4(var_11_3, var_11_4)

	UIItemList = var_4

	var_4.StaticAlign(arg_11_0.list, arg_11_0.tpl, #var_11_2, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_2[arg_12_1 + 1]

			unpack = var_4

			local var_12_1, var_12_2, var_12_3 = var_4(var_12_0)

			unpack = var_2_10007

			local var_12_4, var_12_5 = var_2_10007(var_12_2)
			local var_12_6 = #var_12_4
			local var_12_7 = 0 < var_12_6

			if var_12_3 and var_12_3 ~= 0 and var_12_7 then
				getProxy = var_10
				ActivityProxy = var_2_10011

				local var_12_8 = var_10(var_2_10011)

				var_12_7 = var_10.IsActivityNotEnd(var_12_8, var_12_3)
			end

			local var_12_9 = arg_12_2
			local var_12_10 = arg_12_2.Find(var_12_9, "skip_btn")

			setActive = var_12_9

			var_12_9(var_12_10, var_12_7)

			onButton = var_12_9

			local var_12_11 = arg_11_0
			local var_12_12 = var_12_10

			local function var_12_13()
				var_0_1.ConfigGoScene(var_12_4, var_12_5, function()
					if arg_11_1.goSceneCallack then
						arg_11_1.goSceneCallack()
					end

					local var_14_0 = arg_11_0.viewParent

					var_0.hide(var_14_0)

					return
				end)

				return
			end

			SFX_PANEL = var_2_10015

			var_12_9(var_12_11, var_12_12, var_12_13, var_2_10015)

			Canvas = var_12_9

			var_12_9.ForceUpdateCanvases()

			changeToScrollText = var_11

			var_11(arg_12_2:Find("title"), var_12_1)
		end

		return
	end)

	return
end

function var_0_1.ConfigGoScene(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or {}
	SCENE = var_1_10003

	local var_15_0

	if arg_15_0 == var_1_10003.SHOP and arg_15_1.warp == "supplies" then
		pg = var_15_0
		var_1_10004 = var_15_0.SystemOpenMgr.GetInstance()
		var_15_0 = var_15_0.isOpenSystem
		getProxy = var_1_10005
		PlayerProxy = var_1_10006
		var_1_10006 = var_1_10005(var_1_10006)

		if not var_15_0(var_1_10004, var_1_10005.getRawData(var_1_10006).level, "MilitaryExerciseMediator") then
			pg = var_15_0
			var_1_10004 = var_15_0.TipsMgr.GetInstance()
			var_15_0 = var_15_0.ShowTips
			i18n = var_1_10005

			var_15_0(var_1_10004, var_1_10005("military_shop_no_open_tip"))

			do return end

			goto label_15_1
		end
	end

	SCENE = var_15_0

	if arg_15_0 == var_15_0.LEVEL then
		getProxy = var_15_0
		ChapterProxy = var_1_10004
		var_15_0 = var_15_0(var_1_10004)
		getProxy = var_1_10004
		PlayerProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)
		var_1_10004 = var_1_10004.getRawData(var_1_10005)

		if arg_15_1.leastChapterId then
			var_1_10005 = arg_15_1.leastChapterId
			var_1_10007 = var_15_0
			var_1_10006 = var_15_0.getChapterById(var_1_10007, var_1_10005)
			iter_15_9 = var_15_0
			var_1_10007 = var_15_0.getMapById
			iter_15_10 = var_1_10006

			if not var_1_10007(iter_15_9, var_1_10006.getConfig(iter_15_10, "map")) then
				pg = iter_15_9
				var_1_10009 = iter_15_9.TipsMgr.GetInstance()
				iter_15_9 = iter_15_9.ShowTips
				i18n = iter_15_10

				iter_15_9(var_1_10009, iter_15_10("target_chapter_is_lock"))

				do return end

				goto label_15_0
			end

			var_1_10009 = var_1_10006

			if var_1_10006.isUnlock(var_1_10009) then
				var_1_10009 = var_1_10007
				iter_15_9 = var_1_10007.getMapType(var_1_10009)
				Map = var_1_10009

				if iter_15_9 == var_1_10009.ELITE then
					var_1_10009 = var_1_10007

					if var_1_10007.isEliteEnabled(var_1_10009) then
						var_1_10009 = var_1_10006
						iter_15_9 = var_1_10006.getConfig(var_1_10009, "unlocklevel")

						if var_1_10004.level < iter_15_9 then
							pg = iter_15_9
							var_1_10009 = iter_15_9.TipsMgr.GetInstance()
							iter_15_9 = iter_15_9.ShowTips
							i18n = iter_15_10

							iter_15_9(var_1_10009, iter_15_10("target_chapter_is_lock"))

							return
						end

						::label_15_0::

						if arg_15_1.eliteDefault then
							getProxy = var_1_10005
							DailyLevelProxy = var_1_10006
							var_1_10006 = var_1_10005(var_1_10006)

							if not var_1_10005.IsEliteEnabled(var_1_10006) then
								pg = var_1_10005
								var_1_10006 = var_1_10005.TipsMgr.GetInstance()
								var_1_10005 = var_1_10005.ShowTips
								i18n = var_1_10007

								var_1_10005(var_1_10006, var_1_10007("common_elite_no_quota"))

								return
							end
						end

						if arg_15_1.lastDigit then
							var_1_10005 = 0
							var_1_10006 = {}

							if arg_15_1.mapType then
								iter_15_9 = var_15_0
								var_1_10006 = var_15_0.getMapsByType(iter_15_9, arg_15_1.mapType)
							else
								ipairs = var_7
								iter_15_9 = {}
								Map = var_1_10009
								iter_15_9[1] = var_1_10009.SCENARIO
								Map = var_9
								iter_15_9[2] = var_9.ELITE

								for iter_15_10, iter_15_11 in var_7(iter_15_9) do
									ipairs = var_1_10012

									for iter_15_2, iter_15_3 in var_1_10012(var_15_0:getMapsByType(iter_15_11)) do
										table = var_1_10017

										var_1_10017.insert(var_1_10006, iter_15_3)
									end
								end
							end

							ipairs = var_7

							for iter_15_10, iter_15_11 in var_7(var_1_10006) do
								var_1_10013 = iter_15_11

								if iter_15_11.isUnlock(var_1_10013) then
									local var_15_1 = arg_15_1.mapType

									Map = var_1_10013

									if var_15_1 == var_1_10013.ELITE then
										var_1_10013 = iter_15_11

										if iter_15_11.isEliteEnabled(var_1_10013) then
											if var_1_10005 < iter_15_11.id then
												pairs = var_12

												for iter_15_6, iter_15_7 in var_12(iter_15_11:getChapters()) do
													math = var_1_10017

													if var_1_10017.fmod(iter_15_7.id, 10) == arg_15_1.lastDigit and iter_15_7:isUnlock() and iter_15_7:getConfig("unlocklevel") <= var_1_10004.level then
														arg_15_1.chapterId = iter_15_7.id
														var_1_10005 = iter_15_11.id
														arg_15_1.mapIdx = iter_15_11.id

														break
													end
												end
											end
										end
									end
								end
							end
						end

						if arg_15_1.chapterId then
							var_1_10005 = arg_15_1.chapterId
							var_1_10006 = var_15_0:getChapterById(var_1_10005)
							iter_15_9 = var_15_0

							local var_15_2 = var_15_0.getMapById

							iter_15_10 = var_1_10006

							if var_15_2(iter_15_9, var_1_10006.getConfig(iter_15_10, "map")) then
								local var_15_3 = var_7

								iter_15_9 = var_7.getMapType(var_15_3)
								Map = var_15_3

								if iter_15_9 == var_15_3.ELITE then
									getProxy = iter_15_9
									DailyLevelProxy = var_9

									local var_15_4 = iter_15_9(var_9)

									if not iter_15_9.IsEliteEnabled(var_15_4) then
										pg = iter_15_9

										local var_15_5 = iter_15_9.TipsMgr.GetInstance()

										iter_15_9 = iter_15_9.ShowTips
										i18n = iter_15_10

										iter_15_9(var_15_5, iter_15_10("common_elite_no_quota"))

										return
									end
								end
							end

							if var_1_10006:isUnlock() then
								if var_1_10006.active then
									arg_15_1.mapIdx = var_1_10006:getConfig("map")
								elseif var_15_0:getActiveChapter() then
									pg = iter_15_9

									local var_15_6 = iter_15_9.MsgboxMgr.GetInstance()

									iter_15_9 = iter_15_9.ShowMsgBox
									iter_15_10 = {}
									i18n = iter_15_11
									iter_15_10.content = iter_15_11("collect_chapter_is_activation")

									function iter_15_10.onYes()
										pg = var_2_10000

										local var_16_0 = var_2_10000.m02
										local var_16_1 = var_0.sendNotification

										GAME = var_2_10002

										local var_16_2 = var_2_10002.CHAPTER_OP
										local var_16_3 = {}

										ChapterConst = var_2_10004
										var_16_3.type = var_2_10004.OpRetreat

										var_16_1(var_16_0, var_16_2, var_16_3)

										return
									end

									iter_15_9(var_15_6, iter_15_10)

									return
								else
									arg_15_1.mapIdx = var_1_10006:getConfig("map")
									arg_15_1.openChapterId = var_1_10005
								end
							else
								pg = iter_15_9

								local var_15_7 = iter_15_9.TipsMgr.GetInstance()

								iter_15_9 = iter_15_9.ShowTips
								i18n = iter_15_10

								iter_15_9(var_15_7, iter_15_10("target_chapter_is_lock"))
							end
						end

						goto label_15_1

						SCENE = var_15_0

						if arg_15_0 == var_15_0.TASK and arg_15_1.awards then
							var_15_0 = {}
							ipairs = var_1_10004

							for iter_15_8, iter_15_9 in var_1_10004(arg_15_1.awards) do
								var_15_0[iter_15_9] = true
							end

							var_1_10004 = nil
							next = var_1_10005

							if var_1_10005(var_15_0) then
								getProxy = var_1_10005
								TaskProxy = var_1_10006
								iter_15_8 = var_1_10005(var_1_10006)
								var_1_10006 = var_1_10005.getRawData(iter_15_8)
								pairs = iter_15_8

								for iter_15_10, iter_15_11 in iter_15_8(var_1_10006) do
									local var_15_8 = false

									ipairs = var_1_10013

									for iter_15_12, iter_15_13 in var_1_10013(iter_15_11:getConfig("award_display")) do
										if var_15_0[iter_15_13[2]] then
											var_1_10004 = iter_15_11.id
											var_15_8 = true

											break
										end
									end

									if var_15_8 then
										break
									end
								end
							end

							if not var_1_10004 then
								pg = var_1_10005
								var_1_10006 = var_1_10005.TipsMgr.GetInstance()
								var_1_10005 = var_1_10005.ShowTips
								i18n = iter_15_8

								var_1_10005(var_1_10006, iter_15_8("task_has_finished"))

								return
							end

							arg_15_1.targetId = var_1_10004
						else
							SCENE = var_15_0

							if arg_15_0 == var_15_0.COLLECTSHIP then
								arg_15_1.toggle = 2
							else
								SCENE = var_15_0

								if arg_15_0 == var_15_0.DAILYLEVEL and arg_15_1.dailyLevelId then
									DailyLevelScene = var_15_0
									var_15_0, var_1_10004 = var_15_0.CanOpenDailyLevel(arg_15_1.dailyLevelId)

									if not var_15_0 then
										pg = var_1_10005
										var_1_10006 = var_1_10005.TipsMgr.GetInstance()

										var_1_10005.ShowTips(var_1_10006, var_1_10004)

										return
									end
								else
									SCENE = var_15_0

									if arg_15_0 == var_15_0.MILITARYEXERCISE then
										getProxy = var_15_0
										MilitaryExerciseProxy = var_1_10004

										local var_15_9 = var_15_0(var_1_10004)

										var_1_10005 = var_15_0.getSeasonInfo(var_15_9)

										if not var_15_0.canExercise(var_1_10005) then
											pg = var_4
											var_1_10005 = var_4.TipsMgr.GetInstance()

											local var_15_10 = var_4.ShowTips

											i18n = var_1_10006

											var_15_10(var_1_10005, var_1_10006("exercise_count_insufficient"))

											return
										end
									else
										BaseUI = var_15_0

										if arg_15_0 == var_15_0.ON_ITEM then
											existCall = var_15_0

											var_15_0(arg_15_2)

											getProxy = var_15_0
											ContextProxy = var_4
											var_1_10005 = var_15_0(var_4)

											local var_15_11 = var_15_0.getCurrentContext(var_1_10005)

											pg = var_1_10005

											local var_15_12 = var_1_10005.m02
											local var_15_13 = var_1_10005.retrieveMediator(var_15_12, var_15_11.mediator.__cname)
											local var_15_14 = var_1_10005.addSubLayers

											Context = iter_15_9

											local var_15_15 = iter_15_9.New
											local var_15_16 = {}

											ItemInfoMediator = iter_15_10
											var_15_16.mediator = iter_15_10
											ItemInfoLayer = iter_15_10
											var_15_16.viewComponent = iter_15_10

											local var_15_17 = {}

											LayerWeightConst = iter_15_11
											var_15_17.groupName = iter_15_11.GROUP_TOP
											Drop = var_11

											local var_15_18 = var_11.New
											local var_15_19 = {}

											DROP_TYPE_ITEM = var_1_10013
											var_15_19.type = var_1_10013
											var_15_19.id = arg_15_1.itemId
											var_15_17.drop = var_15_18(var_15_19)

											function var_15_17.confirmCall()
												return
											end

											var_15_16.data = var_15_17

											var_15_14(var_15_13, var_15_15(var_15_16))

											return
										end
									end
								end
							end
						end

						::label_15_1::

						existCall = var_15_0

						var_15_0(arg_15_2)

						pg = var_15_0

						local var_15_20 = var_15_0.m02
						local var_15_21 = var_3.sendNotification

						GAME = var_1_10005

						var_15_21(var_15_20, var_1_10005.GO_SCENE, arg_15_0, arg_15_1)

						return
					end
				end
			end
		end
	end
end

return var_0_1
