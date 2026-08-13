class = var_0_10000

local var_0_0 = "ActivityMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.LOCK_ACT_MAIN = "ActivityMainScene:LOCK_ACT_MAIN"
var_0_1.UPDATE_ACTIVITY = "ActivityMainScene:UPDATE_ACTIVITY"
var_0_1.GET_PAGE_BGM = "ActivityMainScene.GET_PAGE_BGM"
var_0_1.FLUSH_TABS = "ActivityMainScene.FLUSH_TABS"

function var_0_1.preload(arg_1_0, arg_1_1)
	arg_1_1()

	return
end

function var_0_1.getUIName(arg_2_0)
	return "ActivityMainUI"
end

function var_0_1.PlayBGM(arg_3_0)
	return
end

function var_0_1.onBackPressed(arg_4_0)
	if arg_4_0.locked then
		return
	end

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.windowList) do
		isActive = var_1_10006

		if var_1_10006(iter_4_1._tf) then
			arg_4_0:HideWindow(iter_4_1.class)

			return
		end
	end

	if arg_4_0.awardWindow then
		local var_4_0 = arg_4_0.awardWindow

		if var_1.GetLoaded(var_4_0) then
			local var_4_1 = arg_4_0.awardWindow

			if var_1.isShowing(var_4_1) then
				local var_4_2 = arg_4_0.awardWindow

				var_1.Hide(var_4_2)

				return
			end
		end
	end

	pairs = var_1

	for iter_4_2, iter_4_3 in var_1(arg_4_0.pageDic) do
		if iter_4_3.onBackPressed and iter_4_3:onBackPressed() then
			return
		end
	end

	arg_4_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

local var_0_2

function var_0_1.init(arg_5_0)
	UIItemList = var_1_10001
	arg_5_0.entranceList = var_1_10001.New(arg_5_0.entranceContent, arg_5_0.entranceTpl)
	arg_5_0.windowList = {}
	AwardWindow = var_1
	arg_5_0.awardWindow = var_1.New(arg_5_0._tf, arg_5_0.event)
	ChargeTipWindow = var_1
	arg_5_0.chargeTipWindow = var_1.New(arg_5_0._tf, arg_5_0.event)
	setActive = var_1

	var_1(arg_5_0.tab, false)

	setActive = var_1

	var_1(arg_5_0.lockAll, false)

	setActive = var_1

	var_1(arg_5_0.permanentFinshMask, false)

	setText = var_1

	local var_5_0 = arg_5_0.permanentFinshMask
	local var_5_1 = var_2.Find(var_5_0, "piece/Text")

	i18n = var_5_0

	var_1(var_5_1, var_5_0("activity_permanent_tips2"))

	onButton = var_1

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.permanentFinshMask
	local var_5_4 = var_3.Find(var_5_3, "piece/arrow/Image")

	local function var_5_5()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.FINISH_ACTIVITY_PERMANENT)

		return
	end

	SFX_PANEL = var_5

	var_1(var_5_2, var_5_4, var_5_5, var_5)

	UIItemList = var_1
	arg_5_0.tabsList = var_1.New(arg_5_0.tabs, arg_5_0.tab)

	local var_5_6 = arg_5_0.tabsList

	var_1.make(var_5_6, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_2.name = arg_5_0.activities[arg_7_1 + 1].id

			if var_3:getConfig("title_res_tag") then
				local var_7_0 = arg_7_2
				local var_7_1 = arg_7_2.Find(var_7_0, "red")

				GetSpriteFromAtlas = var_7_0

				local var_7_2

				if not var_7_0("activityuitable/" .. var_4 .. "_text", "") then
					GetSpriteFromAtlas = var_7_2
					var_7_2 = var_7_2("activityuitable/activity_text", "")
				end

				GetSpriteFromAtlas = var_7

				local var_7_3

				if not var_7("activityuitable/" .. var_4 .. "_text_selected", "") then
					GetSpriteFromAtlas = var_7_3
					var_7_3 = var_7_3("activityuitable/activity_text_selected", "")
				end

				setImageSprite = var_8
				var_2_10010 = arg_7_2

				var_8(arg_7_2.Find(var_2_10010, "off/text"), var_7_2, true)

				setImageSprite = var_8
				var_2_10010 = arg_7_2

				var_8(arg_7_2.Find(var_2_10010, "on/text"), var_7_3, true)

				setActive = var_8

				var_8(var_7_1, var_3:readyToAchieve())

				onToggle = var_8

				local var_7_4 = arg_5_0

				var_2_10010 = arg_7_2

				local function var_7_5(arg_8_0)
					if arg_8_0 then
						local var_8_0 = arg_5_0

						var_1.selectActivity(var_8_0, var_0)
					end

					return
				end

				SFX_PANEL = var_2_10012

				var_8(var_7_4, var_2_10010, var_7_5, var_2_10012)
			end

			local var_7_6 = arg_5_0.pageDic[var_3.id]

			onToggle = var_6

			local var_7_7 = arg_5_0
			local var_7_8 = arg_7_2

			local function var_7_9(arg_9_0)
				if var_7_6 then
					if arg_9_0 then
						local var_9_0 = arg_5_0

						var_1.selectActivity(var_9_0, var_0)
					end
				else
					local var_9_1 = arg_5_0

					var_1.loadActivityPanel(var_9_1, arg_9_0, var_0)
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_7_7, var_7_8, var_7_9, var_2_10010)
		end

		return
	end)

	arg_5_0.switchCount = 0

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:bind(var_0_1.LOCK_ACT_MAIN, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_10_0

		var_11_0.locked = arg_11_1
		setActive = var_11_0

		var_11_0(arg_10_0.lockAll, arg_11_1)

		return
	end)
	arg_10_0:bind(var_0_1.UPDATE_ACTIVITY, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		var_2.updateActivity(var_12_0, arg_12_1)

		return
	end)
	arg_10_0:bind(var_0_1.GET_PAGE_BGM, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_10_0
		local var_13_2

		if not var_3.getBGM(var_13_0, arg_13_1) then
			local var_13_1 = arg_10_0

			var_13_2 = var_3.getBGM(var_13_1)
		end

		arg_13_2.bgm = var_13_2

		return
	end)

	local var_10_0 = arg_10_0

	arg_10_0.bind(var_10_0, var_0_1.FLUSH_TABS, function()
		local var_14_0 = arg_10_0

		var_0.flushTabs(var_14_0)

		return
	end)

	getProxy = var_1
	CommanderManualProxy = var_10_0

	local var_10_1 = var_1(var_10_0)

	var_1.TaskProgressAdd(var_10_1, 2020, 1)

	onButton = var_1

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.btnBack

	local function var_10_4()
		local var_15_0 = arg_10_0

		var_0.emit(var_15_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_10_2, var_10_3, var_10_4, var_1_10005)
	arg_10_0:updateEntrances()

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.emit

	ActivityMediator = var_10_3

	var_10_6(var_10_5, var_10_3.SHOW_NEXT_ACTIVITY)

	local var_10_7

	if arg_10_0.contextData.event then
		arg_10_0:emit(arg_10_0.contextData.event, arg_10_0.contextData.data)

		var_10_7 = arg_10_0.contextData
		var_10_7.event = nil
		var_10_7 = arg_10_0.contextData
		var_10_7.data = nil
	end

	pg = var_10_7

	local var_10_8 = var_10_7.CameraFixMgr.GetInstance()

	var_1.Adapt(var_10_8)

	return
end

function var_0_1.setPlayer(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.shareData

	var_2.SetPlayer(var_16_0, arg_16_1)

	return
end

function var_0_1.setFlagShip(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shareData

	var_2.SetFlagShip(var_17_0, arg_17_1)

	return
end

function var_0_1.updateTaskLayers(arg_18_0)
	if not arg_18_0.activity then
		return
	end

	arg_18_0:updateActivity(arg_18_0.activity)

	return
end

function var_0_1.getActClass(arg_19_0, arg_19_1)
	import = var_1_10002

	return var_1_10002("view.activity.subPages." .. arg_19_1)
end

function var_0_1.instanceActivityPage(arg_20_0, arg_20_1)
	if arg_20_1:getConfig("page_info").class_name and not arg_20_0.pageDic[arg_20_1.id] and not arg_20_1:isEnd() then
		local var_20_0 = arg_20_0:getActClass(var_2.class_name).New(arg_20_0.pageContainer, arg_20_0.event, arg_20_0.contextData)

		if var_4.UseSecondPage(var_20_0, arg_20_1) then
			var_4:SetUIName(var_2.ui_name2)
		else
			var_4:SetUIName(var_2.ui_name)
		end

		var_4:SetShareData(arg_20_0.shareData)

		arg_20_0.pageDic[arg_20_1.id] = var_4
	end

	return
end

function var_0_1.setActivities(arg_21_0, arg_21_1)
	arg_21_0.activities = arg_21_1 or {}

	local var_21_0

	if not arg_21_0.shareData then
		ActivityShareData = var_21_0
		var_21_0 = var_21_0.New()
	end

	arg_21_0.shareData = var_21_0

	local var_21_1

	if not arg_21_0.pageDic then
		var_21_1 = {}
	end

	arg_21_0.pageDic = var_21_1
	ipairs = var_21_1

	for iter_21_0, iter_21_1 in var_21_1(arg_21_1) do
		arg_21_0:instanceActivityPage(iter_21_1)
	end

	arg_21_0.activity = nil
	table = var_2

	local var_21_2 = var_2.sort
	local var_21_3 = arg_21_0.activities

	CompareFuncs = var_4

	var_21_2(var_21_3, var_4({
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

function var_0_1.getActivityIndex(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.activities) do
		if iter_24_1.id == arg_24_1 then
			return iter_24_0
		end
	end

	return nil
end

function var_0_1.updateActivity(arg_25_0, arg_25_1)
	ActivityConst = var_1_10002

	if var_1_10002.PageIdLink[arg_25_1.id] then
		getProxy = var_2
		ActivityProxy = var_3

		local var_25_0 = var_2(var_3)
		local var_25_1 = var_2.getActivityById

		ActivityConst = var_1_10004
		arg_25_1 = var_25_1(var_25_0, var_1_10004.PageIdLink[arg_25_1.id])
	end

	if arg_25_1:isShow() then
		local var_25_2 = arg_25_1
		local var_25_3 = arg_25_1.isCorePage
		local var_25_4

		if not arg_25_0.contextData.coreName then
			var_25_4 = ""
		end

		if var_25_3(var_25_2, var_25_4) and not arg_25_1:isEnd() then
			local var_25_5 = arg_25_0.activities
			local var_25_6 = arg_25_0
			local var_25_7

			if not arg_25_0.getActivityIndex(var_25_6, arg_25_1.id) then
				var_25_7 = #arg_25_0.activities + 1
			end

			var_25_5[var_25_7] = arg_25_1
			table = var_25_5

			local var_25_8 = var_25_5.sort
			local var_25_9 = arg_25_0.activities

			CompareFuncs = var_25_6

			var_25_8(var_25_9, var_25_6({
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

				local var_25_10 = arg_25_0.pageDic[arg_25_1.id]

				var_2.ActionInvoke(var_25_10, "Flush", arg_25_1)

				setActive = var_3

				local var_25_11 = arg_25_0.permanentFinshMask

				pg = var_5

				local var_25_12

				if var_5.activity_task_permanent[arg_25_1.id] then
					var_25_12 = arg_25_1:canPermanentFinish()
				end

				var_3(var_25_11, var_25_12)
			end
		end
	end

	return
end

function var_0_1.removeActivity(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0

	if arg_28_0.getActivityIndex(var_28_0, arg_28_1) then
		table = var_28_0

		var_28_0.remove(arg_28_0.activities, var_2)

		local var_28_1 = arg_28_0.pageDic[arg_28_1]

		var_3.Destroy(var_28_1)

		arg_28_0.pageDic[arg_28_1] = nil

		arg_28_0:flushTabs()

		if arg_28_0.activity and arg_28_0.activity.id == arg_28_1 then
			arg_28_0.activity = nil

			arg_28_0:verifyTabs()
		end
	end

	return
end

function var_0_1.GetOnShowEntranceData()
	local var_29_0

	if not var_0_2 then
		require = var_29_0
		var_29_0 = var_29_0("GameCfg.activity.EntranceData")
	end

	var_0_2 = var_29_0
	assert = var_29_0

	var_29_0(var_0_2, "Missing EntranceData.lua!")

	local var_29_1

	if not var_0_2 then
		var_29_1 = {}
	end

	var_0_2 = var_29_1
	_ = var_29_1

	return (var_29_1.select(var_0_2, function(arg_30_0)
		local var_30_0

		if arg_30_0.isShow then
			var_30_0 = arg_30_0.isShow()
		end

		return var_30_0
	end))
end

function var_0_1.updateEntrances(arg_31_0)
	local var_31_0 = var_0_1.GetOnShowEntranceData()

	math = var_1_10002

	local var_31_1 = var_1_10002.max(#var_31_0, 5)
	local var_31_2 = arg_31_0.entranceList

	var_3.make(var_31_2, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = var_31_0[arg_32_1 + 1]
			local var_32_1 = "empty"

			removeOnButton = var_2_10005

			var_2_10005(arg_32_2)

			local var_32_2 = false

			if var_32_0 then
				table = var_6

				if var_6.getCount(var_32_0) ~= 0 and var_32_0.isShow() then
					onButton = var_6

					local var_32_3 = arg_31_0
					local var_32_4 = arg_32_2

					local function var_32_5()
						local var_33_0 = arg_31_0

						var_0.emit(var_33_0, var_32_0.event, var_32_0.data[1], var_32_0.data[2])

						return
					end

					SFX_PANEL = var_2_10010

					var_6(var_32_3, var_32_4, var_32_5, var_2_10010)

					var_32_1 = var_32_0.banner

					if var_32_0.isTip then
						var_32_2 = var_32_0.isTip()
					end
				end
			end

			setActive = var_6

			var_6(arg_32_2:Find("tip"), var_32_2)

			LoadImageSpriteAsync = var_6

			var_6("activitybanner/" .. var_32_1, arg_32_2)
		end

		return
	end)

	local var_31_3 = arg_31_0.entranceList

	var_3.align(var_31_3, var_31_1)

	return
end

function var_0_1.flushTabs(arg_34_0)
	local var_34_0 = arg_34_0.tabsList

	var_1.align(var_34_0, #arg_34_0.activities)

	return
end

function var_0_1.selectActivity(arg_35_0, arg_35_1)
	if arg_35_0.nextActivity == arg_35_1 or not arg_35_0.nextActivity and arg_35_0.activity and arg_35_1.id == arg_35_0.activity.id then
		return
	end

	local var_35_0 = {}

	if arg_35_0.activity and not arg_35_0.nextActivity then
		arg_35_0.switchCount = arg_35_0.switchCount + 1
		table = var_3

		var_3.insert(var_35_0, function(arg_36_0)
			local var_36_0 = arg_35_0.pageDic[arg_35_0.activity.id]

			var_1.ActionInvoke(var_36_0, "SwitchOut", function()
				arg_35_0.switchCount = arg_35_0.switchCount - 1

				arg_36_0()

				return
			end)

			return
		end)
	end

	local var_35_1

	if not arg_35_0.activity or arg_35_0.activity.id ~= arg_35_1.id then
		var_35_1 = arg_35_0.pageDic[arg_35_1.id]
		assert = var_4

		var_4(var_35_1, "找不到id:" .. arg_35_1.id .. "的活动页，请检查")

		arg_35_0.switchCount = arg_35_0.switchCount + 1
		table = var_4

		var_4.insert(var_35_0, function(arg_38_0)
			local var_38_0 = var_35_1

			var_1.Load(var_38_0)

			local var_38_1 = var_35_1

			var_1.ActionInvoke(var_38_1, "ShowOrHide", false)

			local var_38_2 = var_35_1

			var_1.CallbackInvoke(var_38_2, function()
				arg_35_0.switchCount = arg_35_0.switchCount - 1

				arg_38_0()

				return
			end)

			return
		end)
	end

	arg_35_0.nextActivity = arg_35_1
	parallelAsync = var_35_1

	var_35_1(var_35_0, function()
		if arg_35_0.switchCount > 0 then
			return
		end

		if arg_35_0.activity then
			local var_40_0 = arg_35_0.pageDic[arg_35_0.activity.id]

			var_0.ActionInvoke(var_40_0, "ShowOrHide", false)
		end

		arg_35_0.activity = arg_35_0.nextActivity
		arg_35_0.contextData.id = arg_35_0.nextActivity.id
		arg_35_0.nextActivity = nil

		local var_40_1 = arg_35_0.pageDic[arg_35_0.activity.id]

		var_0.ActionInvoke(var_40_1, "ShowOrHide", true)
		var_0:ActionInvoke("Flush", arg_35_0.activity)

		setActive = var_1

		local var_40_2 = arg_35_0.permanentFinshMask

		pg = var_3

		local var_40_4

		if var_3.activity_task_permanent[arg_35_1.id] then
			local var_40_3 = arg_35_1

			var_40_4 = var_3.canPermanentFinish(var_40_3)
		end

		var_1(var_40_2, var_40_4)

		return
	end)

	return
end

function var_0_1.checkAutoHideActivity(arg_41_0)
	if arg_41_0.activity then
		local var_41_0 = arg_41_0.activity

		if not var_1.isShow(var_41_0) then
			arg_41_0:removeActivity(arg_41_0.activity.id)
		end
	end

	return
end

function var_0_1.verifyTabs(arg_42_0, arg_42_1)
	local var_42_0

	if not arg_42_0:getActivityIndex(arg_42_1) then
		var_42_0 = 1
	end

	local var_42_1 = arg_42_0.tabs
	local var_42_2 = var_3.GetChild(var_42_1, var_42_0 - 1)

	triggerToggle = var_42_1

	var_42_1(var_42_2, true)

	return
end

function var_0_1.loadActivityPanel(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2:getConfig("type")
	local var_43_1
	local var_43_3

	if var_43_1 and arg_43_1 then
		local var_43_2 = arg_43_0

		var_43_3 = arg_43_0.emit
		ActivityMediator = var_1_10007

		var_43_3(var_43_2, var_1_10007.OPEN_LAYER, var_43_1)
	elseif var_43_1 and not arg_43_1 then
		local var_43_4 = arg_43_0

		var_43_3 = arg_43_0.emit
		ActivityMediator = var_1_10007

		var_43_3(var_43_4, var_1_10007.CLOSE_LAYER, var_43_1.mediator)
	else
		originalPrint = var_43_3

		var_43_3("------活动id为" .. arg_43_2.id .. "类型为" .. arg_43_2:getConfig("type") .. "的页面不存在")
	end

	return
end

function var_0_1.getBonusWindow(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0._tf

	if not var_3.Find(var_44_0, arg_44_1) then
		PoolMgr = var_44_0

		local var_44_1 = var_44_0.GetInstance()

		var_4.GetUI(var_44_1, "ActivitybonusWindow", true, function(arg_45_0)
			SetParent = var_2_10001

			var_2_10001(arg_45_0, arg_44_0._tf, false)

			arg_45_0.name = arg_44_1

			arg_44_2(arg_45_0)

			return
		end)
	else
		arg_44_2(var_3)
	end

	return
end

function var_0_1.ShowWindow(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.__cname

	if not arg_46_0.windowList[var_46_0] then
		arg_46_0:getBonusWindow(var_46_0, function(arg_47_0)
			local var_47_0 = arg_46_0.windowList
			local var_47_1 = var_46_0
			local var_47_2 = arg_46_1.New

			tf = var_2_10004
			var_47_0[var_47_1] = var_47_2(var_2_10004(arg_47_0), arg_46_0)

			local var_47_3 = arg_46_0.windowList[var_46_0]

			var_1.Show(var_47_3, arg_46_2)

			return
		end)
	else
		local var_46_1 = arg_46_0.windowList[var_46_0]

		var_4.Show(var_46_1, arg_46_2)
	end

	return
end

function var_0_1.HideWindow(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1.__cname

	if not arg_48_0.windowList[var_48_0] then
		return
	end

	local var_48_1 = arg_48_0.windowList[var_48_0]

	var_3.Hide(var_48_1)

	return
end

function var_0_1.ShowAwardWindow(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	local var_49_0 = arg_49_0.awardWindow

	var_5.ExecuteAction(var_49_0, "Flush", arg_49_1, arg_49_2, arg_49_3, arg_49_4)

	return
end

function var_0_1.OnChargeSuccess(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.chargeTipWindow

	var_2.ExecuteAction(var_50_0, "Show", arg_50_1)

	return
end

function var_0_1.willExit(arg_51_0)
	arg_51_0.switchCount = nil
	arg_51_0.shareData = nil
	pairs = var_1

	for iter_51_0, iter_51_1 in var_1(arg_51_0.pageDic) do
		iter_51_1:Destroy()
	end

	pairs = var_1

	for iter_51_2, iter_51_3 in var_1(arg_51_0.windowList) do
		iter_51_3:Dispose()
	end

	if arg_51_0.awardWindow then
		local var_51_0 = arg_51_0.awardWindow

		var_1.Destroy(var_51_0)

		arg_51_0.awardWindow = nil
	end

	if arg_51_0.chargeTipWindow then
		local var_51_1 = arg_51_0.chargeTipWindow

		var_1.Destroy(var_51_1)

		arg_51_0.chargeTipWindow = nil
	end

	return
end

return var_0_1
