local var_0_0 = class("ActivityMainScene", import("..base.BaseUI"))

var_0_0.LOCK_ACT_MAIN = "ActivityMainScene:LOCK_ACT_MAIN"
var_0_0.UPDATE_ACTIVITY = "ActivityMainScene:UPDATE_ACTIVITY"
var_0_0.GET_PAGE_BGM = "ActivityMainScene.GET_PAGE_BGM"
var_0_0.FLUSH_TABS = "ActivityMainScene.FLUSH_TABS"

function var_0_0.preload(arg_1_0, arg_1_1)
	arg_1_1()

	return
end

function var_0_0.getUIName(arg_2_0)
	return "ActivityMainUI"
end

function var_0_0.PlayBGM(arg_3_0)
	return
end

function var_0_0.onBackPressed(arg_4_0)
	if arg_4_0.locked then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.windowList) do
		if isActive(iter_4_1._tf) then
			arg_4_0:HideWindow(iter_4_1.class)

			return
		end
	end

	if arg_4_0.awardWindow and arg_4_0.awardWindow:GetLoaded() and arg_4_0.awardWindow:isShowing() then
		arg_4_0.awardWindow:Hide()

		return
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.pageDic) do
		if iter_4_3.onBackPressed and iter_4_3:onBackPressed() then
			return
		end
	end

	arg_4_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

local var_0_1

function var_0_0.init(arg_5_0)
	arg_5_0.entranceList = UIItemList.New(arg_5_0.entranceContent, arg_5_0.entranceTpl)
	arg_5_0.windowList = {}
	arg_5_0.awardWindow = AwardWindow.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.chargeTipWindow = ChargeTipWindow.New(arg_5_0._tf, arg_5_0.event)

	setActive(arg_5_0.tab, false)
	setActive(arg_5_0.lockAll, false)
	setActive(arg_5_0.permanentFinshMask, false)
	setText(arg_5_0.permanentFinshMask:Find("piece/Text"), i18n("activity_permanent_tips2"))
	onButton(arg_5_0, arg_5_0.permanentFinshMask:Find("piece/arrow/Image"), function()
		arg_5_0:emit(ActivityMediator.FINISH_ACTIVITY_PERMANENT)

		return
	end, SFX_PANEL)

	arg_5_0.tabsList = UIItemList.New(arg_5_0.tabs, arg_5_0.tab)

	arg_5_0.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_5_0.activities[arg_7_1 + 1]

			arg_7_2.name = arg_5_0.activities[arg_7_1 + 1].id

			local var_7_1 = arg_5_0.activities[arg_7_1 + 1]:getConfig("title_res_tag")

			if var_7_1 then
				local var_7_2 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text", "") or GetSpriteFromAtlas("activityuitable/activity_text", "")
				local var_7_3 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text_selected", "") or GetSpriteFromAtlas("activityuitable/activity_text_selected", "")

				setImageSprite(arg_7_2:Find("off/text"), var_7_2, true)
				setImageSprite(arg_7_2:Find("on/text"), var_7_3, true)
				setActive(arg_7_2:Find("red"), arg_5_0.activities[arg_7_1 + 1]:readyToAchieve())
				onToggle(arg_5_0, arg_7_2, function(arg_8_0)
					if arg_8_0 then
						arg_5_0:selectActivity(var_7_0)
					end

					return
				end, SFX_PANEL)
			end

			local var_7_4 = arg_5_0.pageDic[arg_5_0.activities[arg_7_1 + 1].id]

			onToggle(arg_5_0, arg_7_2, function(arg_9_0)
				if var_7_4 then
					if arg_9_0 then
						arg_5_0:selectActivity(var_7_0)
					end
				else
					arg_5_0:loadActivityPanel(arg_9_0, var_7_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	arg_5_0.switchCount = 0

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:bind(var_0_0.LOCK_ACT_MAIN, function(arg_11_0, arg_11_1)
		arg_10_0.locked = arg_11_1

		setActive(arg_10_0.lockAll, arg_11_1)

		return
	end)
	arg_10_0:bind(var_0_0.UPDATE_ACTIVITY, function(arg_12_0, arg_12_1)
		arg_10_0:updateActivity(arg_12_1)

		return
	end)
	arg_10_0:bind(var_0_0.GET_PAGE_BGM, function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_2.bgm = arg_10_0:getBGM(arg_13_1) or arg_10_0:getBGM()

		return
	end)
	arg_10_0:bind(var_0_0.FLUSH_TABS, function()
		arg_10_0:flushTabs()

		return
	end)
	getProxy(CommanderManualProxy):TaskProgressAdd(2020, 1)
	onButton(arg_10_0, arg_10_0.btnBack, function()
		arg_10_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	arg_10_0:updateEntrances()
	arg_10_0:emit(ActivityMediator.SHOW_NEXT_ACTIVITY)

	if arg_10_0.contextData.event then
		arg_10_0:emit(arg_10_0.contextData.event, arg_10_0.contextData.data)

		arg_10_0.contextData.event = nil
		arg_10_0.contextData.data = nil
	end

	pg.CameraFixMgr.GetInstance():Adapt()

	return
end

function var_0_0.setPlayer(arg_16_0, arg_16_1)
	arg_16_0.shareData:SetPlayer(arg_16_1)

	return
end

function var_0_0.setFlagShip(arg_17_0, arg_17_1)
	arg_17_0.shareData:SetFlagShip(arg_17_1)

	return
end

function var_0_0.updateTaskLayers(arg_18_0)
	if not arg_18_0.activity then
		return
	end

	arg_18_0:updateActivity(arg_18_0.activity)

	return
end

function var_0_0.getActClass(arg_19_0, arg_19_1)
	return import("view.activity.subPages." .. arg_19_1)
end

function var_0_0.instanceActivityPage(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:getConfig("page_info")

	if var_20_0.class_name and not arg_20_0.pageDic[arg_20_1.id] and not arg_20_1:isEnd() then
		local var_20_1 = arg_20_0:getActClass(var_20_0.class_name).New(arg_20_0.pageContainer, arg_20_0.event, arg_20_0.contextData)

		if var_20_1:UseSecondPage(arg_20_1) then
			var_20_1:SetUIName(var_20_0.ui_name2)
		else
			var_20_1:SetUIName(var_20_0.ui_name)
		end

		var_20_1:SetShareData(arg_20_0.shareData)

		arg_20_0.pageDic[arg_20_1.id] = var_20_1
	end

	return
end

function var_0_0.setActivities(arg_21_0, arg_21_1)
	arg_21_0.activities = arg_21_1 or {}
	arg_21_0.shareData = arg_21_0.shareData or ActivityShareData.New()
	arg_21_0.pageDic = arg_21_0.pageDic or {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		arg_21_0:instanceActivityPage(iter_21_1)
	end

	arg_21_0.activity = nil

	table.sort(arg_21_0.activities, CompareFuncs({
		function(arg_22_0)
			return -arg_22_0:getShowPriority()
		end,
		function(arg_23_0)
			return -arg_23_0.id
		end
	}))
	arg_21_0:flushTabs()

	return
end

function var_0_0.getActivityIndex(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.activities) do
		if iter_24_1.id == arg_24_1 then
			return iter_24_0
		end
	end

	return nil
end

function var_0_0.updateActivity(arg_25_0, arg_25_1)
	if ActivityConst.PageIdLink[arg_25_1.id] then
		arg_25_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_25_1.id])
	end

	if arg_25_1:isShow() then
		local var_25_0 = arg_25_0.contextData.coreName or ""

		if arg_25_1:isCorePage(var_25_0) and not arg_25_1:isEnd() then
			local var_25_1 = arg_25_0:getActivityIndex(arg_25_1.id) or #arg_25_0.activities + 1

			arg_25_0.activities[var_25_1] = arg_25_1

			table.sort(arg_25_0.activities, CompareFuncs({
				function(arg_26_0)
					return -arg_26_0:getShowPriority()
				end,
				function(arg_27_0)
					return -arg_27_0.id
				end
			}))

			if not arg_25_0.pageDic[arg_25_1.id] then
				arg_25_0:instanceActivityPage(arg_25_1)
			end

			arg_25_0:flushTabs()

			if arg_25_0.activity and arg_25_0.activity.id == arg_25_1.id then
				arg_25_0.activity = arg_25_1

				arg_25_0.pageDic[arg_25_1.id]:ActionInvoke("Flush", arg_25_1)

				local var_25_2 = pg.activity_task_permanent[arg_25_1.id] and arg_25_1:canPermanentFinish()

				setActive(arg_25_0.permanentFinshMask, var_25_2)
			end
		end
	end

	return
end

function var_0_0.removeActivity(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getActivityIndex(arg_28_1)

	if var_28_0 then
		table.remove(arg_28_0.activities, var_28_0)
		arg_28_0.pageDic[arg_28_1]:Destroy()

		arg_28_0.pageDic[arg_28_1] = nil

		arg_28_0:flushTabs()

		if arg_28_0.activity and arg_28_0.activity.id == arg_28_1 then
			arg_28_0.activity = nil

			arg_28_0:verifyTabs()
		end
	end

	return
end

function var_0_0.GetOnShowEntranceData()
	var_0_1 = var_0_1 or require("GameCfg.activity.EntranceData")

	assert(var_0_1, "Missing EntranceData.lua!")

	var_0_1 = var_0_1 or {}

	return (_.select(var_0_1, function(arg_30_0)
		return arg_30_0.isShow and arg_30_0.isShow()
	end))
end

function var_0_0.updateEntrances(arg_31_0)
	arg_31_0.entranceList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			local var_32_0 = var_0[arg_32_1 + 1]
			local var_32_1 = "empty"

			removeOnButton(arg_32_2)

			local var_32_2 = false

			if var_0[arg_32_1 + 1] and table.getCount(var_0[arg_32_1 + 1]) ~= 0 and var_0[arg_32_1 + 1].isShow() then
				onButton(arg_31_0, arg_32_2, function()
					arg_31_0:emit(var_32_0.event, var_32_0.data[1], var_32_0.data[2])

					return
				end, SFX_PANEL)

				var_32_1 = var_0[arg_32_1 + 1].banner

				if var_0[arg_32_1 + 1].isTip then
					var_32_2 = var_0[arg_32_1 + 1].isTip()
				end
			end

			setActive(arg_32_2:Find("tip"), var_32_2)
			LoadImageSpriteAsync("activitybanner/" .. var_32_1, arg_32_2)
		end

		return
	end)
	arg_31_0.entranceList:align((math.max(#var_0_0.GetOnShowEntranceData(), 5)))

	return
end

function var_0_0.flushTabs(arg_34_0)
	arg_34_0.tabsList:align(#arg_34_0.activities)

	return
end

function var_0_0.selectActivity(arg_35_0, arg_35_1)
	if arg_35_0.nextActivity == arg_35_1 or not arg_35_0.nextActivity and arg_35_0.activity and arg_35_1.id == arg_35_0.activity.id then
		return
	end

	local var_35_0 = {}

	if arg_35_0.activity and not arg_35_0.nextActivity then
		arg_35_0.switchCount = arg_35_0.switchCount + 1

		table.insert(var_35_0, function(arg_36_0)
			arg_35_0.pageDic[arg_35_0.activity.id]:ActionInvoke("SwitchOut", function()
				arg_35_0.switchCount = arg_35_0.switchCount - 1

				arg_36_0()

				return
			end)

			return
		end)
	end

	if arg_35_0.activity then
		if arg_35_0.activity.id ~= arg_35_1.id then
			assert(arg_35_0.pageDic[arg_35_1.id], "找不到id:" .. arg_35_1.id .. "的活动页，请检查")

			arg_35_0.switchCount = arg_35_0.switchCount + 1

			table.insert(var_35_0, function(arg_38_0)
				var_0:Load()
				var_0:ActionInvoke("ShowOrHide", false)
				var_0:CallbackInvoke(function()
					arg_35_0.switchCount = arg_35_0.switchCount - 1

					arg_38_0()

					return
				end)

				return
			end)
		end

		arg_35_0.nextActivity = arg_35_1

		parallelAsync(var_35_0, function()
			if arg_35_0.switchCount > 0 then
				return
			end

			if arg_35_0.activity then
				arg_35_0.pageDic[arg_35_0.activity.id]:ActionInvoke("ShowOrHide", false)
			end

			arg_35_0.activity = arg_35_0.nextActivity
			arg_35_0.contextData.id = arg_35_0.nextActivity.id
			arg_35_0.nextActivity = nil

			arg_35_0.pageDic[arg_35_0.activity.id]:ActionInvoke("ShowOrHide", true)
			arg_35_0.pageDic[arg_35_0.activity.id]:ActionInvoke("Flush", arg_35_0.activity)

			local var_40_0 = pg.activity_task_permanent[arg_35_1.id] and arg_35_1:canPermanentFinish()

			setActive(arg_35_0.permanentFinshMask, var_40_0)

			return
		end)

		return
	end
end

function var_0_0.checkAutoHideActivity(arg_41_0)
	if arg_41_0.activity and not arg_41_0.activity:isShow() then
		arg_41_0:removeActivity(arg_41_0.activity.id)
	end

	return
end

function var_0_0.verifyTabs(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getActivityIndex(arg_42_1) or 1

	triggerToggle(arg_42_0.tabs:GetChild(var_42_0 - 1), true)

	return
end

function var_0_0.loadActivityPanel(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2:getConfig("type")

	if nil and arg_43_1 then
		arg_43_0:emit(ActivityMediator.OPEN_LAYER, nil)
	elseif nil and not arg_43_1 then
		arg_43_0:emit(ActivityMediator.CLOSE_LAYER, (nil).mediator)
	else
		originalPrint("------活动id为" .. arg_43_2.id .. "类型为" .. arg_43_2:getConfig("type") .. "的页面不存在")
	end

	return
end

function var_0_0.getBonusWindow(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0._tf:Find(arg_44_1)

	if not var_44_0 then
		PoolMgr.GetInstance():GetUI("ActivitybonusWindow", true, function(arg_45_0)
			SetParent(arg_45_0, arg_44_0._tf, false)

			arg_45_0.name = arg_44_1

			arg_44_2(arg_45_0)

			return
		end)
	else
		arg_44_2(var_44_0)
	end

	return
end

function var_0_0.ShowWindow(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.__cname

	if not arg_46_0.windowList[arg_46_1.__cname] then
		arg_46_0:getBonusWindow(arg_46_1.__cname, function(arg_47_0)
			arg_46_0.windowList[var_46_0] = arg_46_1.New(tf(arg_47_0), arg_46_0)

			arg_46_0.windowList[var_46_0]:Show(arg_46_2)

			return
		end)
	else
		arg_46_0.windowList[arg_46_1.__cname]:Show(arg_46_2)
	end

	return
end

function var_0_0.HideWindow(arg_48_0, arg_48_1)
	if not arg_48_0.windowList[arg_48_1.__cname] then
		return
	end

	arg_48_0.windowList[arg_48_1.__cname]:Hide()

	return
end

function var_0_0.ShowAwardWindow(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	arg_49_0.awardWindow:ExecuteAction("Flush", arg_49_1, arg_49_2, arg_49_3, arg_49_4)

	return
end

function var_0_0.OnChargeSuccess(arg_50_0, arg_50_1)
	arg_50_0.chargeTipWindow:ExecuteAction("Show", arg_50_1)

	return
end

function var_0_0.willExit(arg_51_0)
	arg_51_0.switchCount = nil
	arg_51_0.shareData = nil

	for iter_51_0, iter_51_1 in pairs(arg_51_0.pageDic) do
		iter_51_1:Destroy()
	end

	for iter_51_2, iter_51_3 in pairs(arg_51_0.windowList) do
		iter_51_3:Dispose()
	end

	if arg_51_0.awardWindow then
		arg_51_0.awardWindow:Destroy()

		arg_51_0.awardWindow = nil
	end

	if arg_51_0.chargeTipWindow then
		arg_51_0.chargeTipWindow:Destroy()

		arg_51_0.chargeTipWindow = nil
	end

	return
end

return var_0_0
