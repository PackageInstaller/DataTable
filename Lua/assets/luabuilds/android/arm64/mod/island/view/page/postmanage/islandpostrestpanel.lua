local var_0_0 = class("IslandPostRestPanel", import("view.base.BaseSubView"))

var_0_0.MAX_ASSISTANT_CNT = 2
var_0_0.MAX_SHELF_CNT = 5
var_0_0.ScrollValue = 0

function var_0_0.getUIName(arg_1_0)
	return "IslandPostRestPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.scrollTF = arg_2_0._tf:Find("view")

	local var_2_0 = arg_2_0._tf:Find("view/content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("btns/opening/Text"), i18n("island_manage_view"))
	setText(var_2_1:Find("btns/close/Text"), i18n("island_manage_result"))
	setText(var_2_1:Find("btns/lock/Text"), i18n("word_lock"))
	setText(var_2_1:Find("name/event/Text"), i18n("island_post_event_label"))

	arg_2_0.uiList = UIItemList.New(var_2_0, var_2_1)

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.restIds = pg.island_set.post_manage_operate.key_value_varchar

	arg_3_0.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			arg_3_0:InitItem(arg_4_1, arg_4_2)
		elseif arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)
	onScroll(arg_3_0, arg_3_0.scrollTF, function(arg_5_0)
		var_0_0.ScrollValue = arg_5_0.x

		return
	end)

	return
end

function var_0_0.TriggerEvent(arg_6_0, arg_6_1)
	local var_6_0 = -1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.restIds) do
		if iter_6_1 == arg_6_1 then
			var_6_0 = iter_6_0

			break
		end
	end

	if var_6_0 < 0 then
		return
	end

	arg_6_0.uiList:eachActive(function(arg_7_0, arg_7_1)
		if arg_7_0 + 1 == var_6_0 then
			triggerButton(arg_7_1:Find("btns/opening"))
		end

		return
	end)

	return
end

function var_0_0.InitItem(arg_8_0, arg_8_1, arg_8_2)
	onButton(arg_8_0, arg_8_2:Find("btns/prepare"), function()
		arg_8_0:OpenRestaurant(arg_8_0.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_2:Find("btns/opening"), function()
		arg_8_0:OpenRestaurant(arg_8_0.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_2:Find("btns/close"), function()
		arg_8_0:OpenRestaurant(arg_8_0.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OpenRestaurant(arg_12_0, arg_12_1)
	arg_12_0:emit(IslandMediator.OPEN_PAGE, "IslandRestaurantPage", {
		arg_12_1,
		true
	})

	return
end

function var_0_0.UpdateItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2.name = arg_13_0.restIds[arg_13_1 + 1]

	setText(arg_13_2:Find("name"), pg.island_manage_restaurant[arg_13_0.restIds[arg_13_1 + 1]].name)

	local var_13_0 = arg_13_0.rests[arg_13_0.restIds[arg_13_1 + 1]]

	setActive(arg_13_2:Find("lock"), not arg_13_0.rests[arg_13_0.restIds[arg_13_1 + 1]])
	setActive(arg_13_2:Find("btns/lock"), not var_13_0)
	setActive(arg_13_2:Find("rank"), var_13_0)
	setActive(arg_13_2:Find("opening"), var_13_0 and var_13_0:GetStatus() == IslandRestaurant.STATUS.OPENING)

	if var_13_0 then
		local var_13_1 = var_13_0:GetEventInfo()

		setActive(arg_13_2:Find("name/event"), var_13_0:GetEventInfo() ~= 0)
	else
		setActive(arg_13_2:Find("name/event"), false)
	end

	onButton(arg_13_0, arg_13_2:Find("name/event"), function()
		arg_13_0:emit(IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP, var_13_0, false)

		return
	end, SFX_PANEL)

	local var_13_2 = var_13_0 and var_13_0:GetAssistants() or {}

	UIItemList.StaticAlign(arg_13_2:Find("ships"), arg_13_2:Find("ships/tpl"), var_0_0.MAX_ASSISTANT_CNT, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setActive(arg_15_2:Find("lock"), not var_13_2[arg_15_1 + 1])

			local var_15_0 = var_13_2[arg_15_1 + 1] and var_13_2[arg_15_1 + 1].shipId

			setActive(arg_15_2:Find("icon"), var_13_2[arg_15_1 + 1] and var_13_2[arg_15_1 + 1].shipId and var_15_0 ~= 0)

			if var_15_0 and var_15_0 ~= 0 then
				LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_15_0), arg_15_2:Find("icon"))
			end
		end

		return
	end)

	local var_13_3 = var_13_0 and var_13_0:GetCommondities() or {}
	local var_13_4 = var_13_0 and var_13_0:GetShelfCnt() or 0

	UIItemList.StaticAlign(arg_13_2:Find("shelfs"), arg_13_2:Find("shelfs/tpl"), var_0_0.MAX_SHELF_CNT, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = var_13_3[arg_16_1 + 1]

			setActive(arg_16_2:Find("lock"), var_13_4 < arg_16_1 + 1)
			setActive(arg_16_2:Find("drop"), var_16_0)

			if var_16_0 then
				updateCustomDrop(arg_16_2:Find("drop"), (Drop.New({
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_16_0.id,
					count = var_16_0.num
				})))
			end
		end

		return
	end)

	if var_13_0 then
		local var_13_5 = var_13_0:getConfig("opening_number")
		local var_13_6 = var_13_0:GetRemainCnt()

		setText(arg_13_2:Find("btns/prepare/Text"), string.format("%s(%d/%d)", i18n("island_manage_prepare"), var_13_6, var_13_5))
		setText(arg_13_2:Find("btns/end/Text"), string.format("%s(%d/%d)", i18n("island_manage_daily_cnt_tip"), var_13_6, var_13_5))
		LoadImageSpriteAsync("island/islandrestaurant/" .. var_13_0:GetRankIcon(), arg_13_2:Find("rank"), true)
		arg_13_0:UpdataStatusInfo(arg_13_2, var_13_0)
	end

	return
end

function var_0_0.UpdataStatusInfo(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2:GetStatus() == IslandRestaurant.STATUS.OPENING then
		local var_17_0 = pg.TimeMgr.GetInstance()

		setText(arg_17_1:Find("opening/Text"), var_17_0:DescCDTime(arg_17_2:GetEndTime() - var_17_0:GetServerTime()))
	end

	eachChild(arg_17_1:Find("btns"), function(arg_18_0)
		setActive(arg_18_0, arg_18_0.name == var_0)

		return
	end)

	return
end

function var_0_0.Show(arg_19_0)
	arg_19_0.super.Show(arg_19_0)
	arg_19_0:Flush()
	arg_19_0:CheckEventTip()
	scrollTo(arg_19_0.scrollTF, var_0_0.ScrollValue)

	return
end

function var_0_0.CheckEventTip(arg_20_0)
	if not getProxy(SettingsProxy):ShouldTipIslandRestEvet() then
		return
	end

	local var_20_0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.rests) do
		local var_20_1 = iter_20_1:GetEventInfo()

		if iter_20_1:GetEventInfo() ~= 0 then
			var_20_0 = iter_20_1

			break
		end
	end

	if var_20_0 then
		arg_20_0:emit(IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP, var_20_0, true)
	end

	return
end

function var_0_0.Flush(arg_21_0)
	arg_21_0:StopTimer()

	arg_21_0.rests = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurants()

	table.sort(arg_21_0.restIds, CompareFuncs({
		function(arg_22_0)
			return arg_21_0.rests[arg_22_0] and 0 or 1
		end,
		function(arg_23_0)
			return arg_21_0.rests[arg_23_0] and arg_21_0:GetStatusSortWeight(arg_21_0.rests[arg_23_0]:GetStatus()) or 999
		end,
		function(arg_24_0)
			return arg_24_0
		end
	}))
	arg_21_0.uiList:align(#arg_21_0.restIds)
	arg_21_0:StartTimer()
	arg_21_0:UpdateTime()

	return
end

function var_0_0.GetStatusSortWeight(arg_25_0, arg_25_1)
	return switch(arg_25_1, {
		[IslandRestaurant.STATUS.CLOSE] = function()
			return 1
		end,
		[IslandRestaurant.STATUS.PREPARE] = function()
			return 2
		end,
		[IslandRestaurant.STATUS.OPENING] = function()
			return 3
		end,
		[IslandRestaurant.STATUS.END] = function()
			return 4
		end
	}, function()
		return 999
	end)
end

function var_0_0.UpdateTime(arg_31_0)
	arg_31_0.uiList:eachActive(function(arg_32_0, arg_32_1)
		if arg_31_0.rests[arg_31_0.restIds[arg_32_0 + 1]] then
			arg_31_0:UpdataStatusInfo(arg_32_1, arg_31_0.rests[arg_31_0.restIds[arg_32_0 + 1]])
		end

		return
	end)

	return
end

function var_0_0.StartTimer(arg_33_0)
	arg_33_0.timer = Timer.New(function()
		arg_33_0:UpdateTime()

		return
	end, 1, -1)

	arg_33_0.timer:Start()

	return
end

function var_0_0.StopTimer(arg_35_0)
	if arg_35_0.timer ~= nil then
		arg_35_0.timer:Stop()

		arg_35_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_36_0)
	arg_36_0:StopTimer()

	return
end

function var_0_0.OnDestroy(arg_37_0)
	arg_37_0:OnHide()

	return
end

return var_0_0
