local var_0_0 = class("ItemTipPanel", import(".MsgboxSubPanel"))

var_0_0.DetailConfig = {}

function var_0_0.ShowItemTip(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.GetDropLackConfig(Drop.New({
		type = arg_1_0,
		id = arg_1_1
	}))

	if not var_1_0 then
		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_ITEMTIP,
		drop = Drop.New({
			type = arg_1_0,
			id = arg_1_1
		}),
		descriptions = var_1_0.description,
		msgTitle = arg_1_2,
		goSceneCallack = arg_1_3
	})

	return true
end

function var_0_0.GetDropLackConfig(arg_2_0)
	if arg_2_0.type == DROP_TYPE_RESOURCE then
		arg_2_0 = Drop.New({
			type = DROP_TYPE_ITEM,
			id = id2ItemId(arg_2_0.id)
		})
	end

	if not var_0_0.DetailConfig[arg_2_0.type] then
		var_0_0.DetailConfig[arg_2_0.type] = {}

		local var_2_0 = pg.item_lack.get_id_list_by_drop_type[arg_2_0.type] or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			for iter_2_2, iter_2_3 in ipairs(pg.item_lack[iter_2_1].itemids) do
				var_0_0.DetailConfig[arg_2_0.type][iter_2_3] = pg.item_lack[iter_2_1]
			end
		end
	end

	return var_0_0.DetailConfig[arg_2_0.type][arg_2_0.id]
end

function var_0_0.ShowItemTipbyID(...)
	return var_0_0.ShowItemTip(DROP_TYPE_ITEM, ...)
end

function var_0_0.CanShowTip(arg_4_0)
	return tobool(var_0_0.GetDropLackConfig(Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_4_0
	})))
end

function var_0_0.ShowRingBuyTip()
	GoShoppingMsgBox(i18n("switch_to_shop_tip_2", string.format("<color=#92FC63FF>%s</color>", Item.getConfigData(ITEM_ID_FOR_PROPOSE).name)), ChargeScene.TYPE_ITEM)

	return
end

function var_0_0.ShowGoldBuyTip(arg_6_0)
	GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
		{
			59001,
			arg_6_0 - getProxy(PlayerProxy):getRawData()[id2res(1)],
			arg_6_0
		}
	})

	return
end

function var_0_0.ShowOilBuyTip(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(PlayerProxy):getRawData()
	local var_7_1 = ShoppingStreet.getRiseShopId(ShopArgs.BuyOil, var_7_0.buyOilCount)

	if not var_7_1 then
		return
	end

	local var_7_2 = pg.shop_template[var_7_1]
	local var_7_3 = pg.shop_template[var_7_1].num

	if pg.shop_template[var_7_1].num == -1 and var_7_2.genre == ShopArgs.BuyOil then
		var_7_3 = ShopArgs.getOilByLevel(var_7_0.level)
	end

	if pg.gameset.buy_oil_limit.key_value <= var_7_0.buyOilCount then
		return
	end

	arg_7_1 = arg_7_1 or "oil_buy_tip_2"

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		yseBtnLetf = true,
		type = MSGBOX_TYPE_SINGLE_ITEM,
		windowSize = {
			y = 570
		},
		content = i18n(arg_7_1, var_7_2.resource_num, var_7_3, var_7_0.buyOilCount, arg_7_0 - var_7_0[id2res(2)]),
		drop = {
			id = 2,
			type = DROP_TYPE_RESOURCE,
			count = var_7_3
		},
		onYes = function()
			pg.m02:sendNotification(GAME.SHOPPING, {
				isQuickShopping = true,
				count = 1,
				id = var_7_1
			})
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_PAY_OIL)

			return
		end
	})

	return true
end

function var_0_0.getUIName(arg_9_0)
	return "Msgbox4ItemGo"
end

function var_0_0.OnInit(arg_10_0)
	arg_10_0.list = arg_10_0._tf:Find("skipable_list")
	arg_10_0.tpl = arg_10_0.list:Find("tpl")
	arg_10_0.title = arg_10_0._tf:Find("name")

	return
end

function var_0_0.OnRefresh(arg_11_0, arg_11_1)
	setActive(arg_11_0.viewParent._btnContainer, false)

	local var_11_0 = arg_11_1.drop:getName()
	local var_11_1 = arg_11_1.descriptions
	local var_11_2 = arg_11_1.msgTitle or i18n("item_lack_title", var_11_0, var_11_0)

	setText(arg_11_0.title, var_11_2)
	UIItemList.StaticAlign(arg_11_0.list, arg_11_0.tpl, #arg_11_1.descriptions, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0, var_12_1, var_12_2 = unpack(var_11_1[arg_12_1 + 1])
			local var_12_3, var_12_4 = unpack(var_12_1)
			local var_12_5 = #var_12_3 > 0

			if var_12_2 and var_12_2 ~= 0 then
				var_12_5 = var_12_5 and getProxy(ActivityProxy):IsActivityNotEnd(var_12_2)
			end

			local var_12_6 = arg_12_2:Find("skip_btn")

			setActive(var_12_6, var_12_5)
			onButton(arg_11_0, var_12_6, function()
				var_0_0.ConfigGoScene(var_12_3, var_12_4, function()
					if arg_11_1.goSceneCallack then
						arg_11_1.goSceneCallack()
					end

					arg_11_0.viewParent:hide()

					return
				end)

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
			changeToScrollText(arg_12_2:Find("title"), var_12_0)
		end

		return
	end)

	return
end

function var_0_0.ConfigGoScene(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or {}

	if arg_15_0 == SCENE.SHOP and arg_15_1.warp == "supplies" then
		if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "MilitaryExerciseMediator") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("military_shop_no_open_tip"))

			do return end

			goto label_15_0
		end
	end

	if arg_15_0 == SCENE.LEVEL then
		local var_15_0 = getProxy(ChapterProxy)
		local var_15_1 = getProxy(PlayerProxy):getRawData()

		if arg_15_1.leastChapterId then
			local var_15_2 = var_15_0:getChapterById(arg_15_1.leastChapterId)
			local var_15_3 = var_15_0:getMapById(var_15_2:getConfig("map"))

			if not var_15_3 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("target_chapter_is_lock"))

				return
			elseif not var_15_2:isUnlock() or var_15_3:getMapType() == Map.ELITE and not var_15_3:isEliteEnabled() or var_15_2:getConfig("unlocklevel") > var_15_1.level then
				pg.TipsMgr.GetInstance():ShowTips(i18n("target_chapter_is_lock"))

				return
			end
		end

		if arg_15_1.eliteDefault then
			if not getProxy(DailyLevelProxy):IsEliteEnabled() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_elite_no_quota"))

				return
			end
		end

		if arg_15_1.lastDigit then
			local var_15_4 = 0
			local var_15_5 = {}

			if arg_15_1.mapType then
				var_15_5 = var_15_0:getMapsByType(arg_15_1.mapType)
			else
				for iter_15_0, iter_15_1 in ipairs({
					Map.SCENARIO,
					Map.ELITE
				}) do
					for iter_15_2, iter_15_3 in ipairs(var_15_0:getMapsByType(iter_15_1)) do
						table.insert(var_15_5, iter_15_3)
					end
				end
			end

			for iter_15_4, iter_15_5 in ipairs(var_15_5) do
				if iter_15_5:isUnlock() and (arg_15_1.mapType ~= Map.ELITE or iter_15_5:isEliteEnabled()) and var_15_4 < iter_15_5.id then
					for iter_15_6, iter_15_7 in pairs(iter_15_5:getChapters()) do
						if math.fmod(iter_15_7.id, 10) == arg_15_1.lastDigit and iter_15_7:isUnlock() and iter_15_7:getConfig("unlocklevel") <= var_15_1.level then
							arg_15_1.chapterId = iter_15_7.id
							var_15_4 = iter_15_5.id
							arg_15_1.mapIdx = iter_15_5.id

							break
						end
					end
				end
			end
		end

		if arg_15_1.chapterId then
			local var_15_6 = var_15_0:getChapterById(arg_15_1.chapterId)
			local var_15_7 = var_15_0:getMapById(var_15_6:getConfig("map"))

			if var_15_7 and var_15_7:getMapType() == Map.ELITE then
				if not getProxy(DailyLevelProxy):IsEliteEnabled() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_elite_no_quota"))

					return
				end
			end

			if var_15_6:isUnlock() then
				if var_15_6.active then
					arg_15_1.mapIdx = var_15_6:getConfig("map")
				elseif var_15_0:getActiveChapter() then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("collect_chapter_is_activation"),
						onYes = function()
							pg.m02:sendNotification(GAME.CHAPTER_OP, {
								type = ChapterConst.OpRetreat
							})

							return
						end
					})

					return
				else
					arg_15_1.mapIdx = var_15_6:getConfig("map")
					arg_15_1.openChapterId = arg_15_1.chapterId
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("target_chapter_is_lock"))
			end
		end
	elseif arg_15_0 == SCENE.TASK and arg_15_1.awards then
		for iter_15_8, iter_15_9 in ipairs(arg_15_1.awards) do
			({})[iter_15_9] = true
		end

		local var_15_8

		if next({}) then
			for iter_15_10, iter_15_11 in pairs((getProxy(TaskProxy):getRawData())) do
				local var_15_9 = false

				for iter_15_12, iter_15_13 in ipairs(iter_15_11:getConfig("award_display")) do
					if ({})[iter_15_13[2]] then
						var_15_8 = iter_15_11.id
						var_15_9 = true

						break
					end
				end

				if var_15_9 then
					break
				end
			end
		end

		if not var_15_8 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("task_has_finished"))

			return
		end

		arg_15_1.targetId = var_15_8
	elseif arg_15_0 == SCENE.COLLECTSHIP then
		arg_15_1.toggle = 2
	elseif arg_15_0 == SCENE.DAILYLEVEL and arg_15_1.dailyLevelId then
		local var_15_10, var_15_11 = DailyLevelScene.CanOpenDailyLevel(arg_15_1.dailyLevelId)

		if not var_15_10 then
			pg.TipsMgr.GetInstance():ShowTips(var_15_11)

			return
		end
	elseif arg_15_0 == SCENE.MILITARYEXERCISE then
		if not getProxy(MilitaryExerciseProxy):getSeasonInfo():canExercise() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("exercise_count_insufficient"))

			return
		end
	elseif arg_15_0 == BaseUI.ON_ITEM then
		existCall(arg_15_2)
		pg.m02:retrieveMediator(getProxy(ContextProxy):getCurrentContext().mediator.__cname):addSubLayers(Context.New({
			mediator = ItemInfoMediator,
			viewComponent = ItemInfoLayer,
			data = {
				groupName = LayerWeightConst.GROUP_TOP,
				drop = Drop.New({
					type = DROP_TYPE_ITEM,
					id = arg_15_1.itemId
				}),
				confirmCall = function()
					return
				end
			}
		}))

		return
	end

	::label_15_0::

	existCall(arg_15_2)
	pg.m02:sendNotification(GAME.GO_SCENE, arg_15_0, arg_15_1)

	return
end

return var_0_0
