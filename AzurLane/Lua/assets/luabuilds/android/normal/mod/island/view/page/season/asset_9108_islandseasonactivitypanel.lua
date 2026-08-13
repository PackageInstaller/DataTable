class = var_0_10000

local var_0_0 = "IslandSeasonActivityPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonActivityPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	UIItemList = var_1_10001
	arg_3_0.tabsList = var_1_10001.New(arg_3_0.rtTabsContent, arg_3_0.rtTabsTpl)

	local var_3_0 = arg_3_0.tabsList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0

			if not arg_3_0.activities[arg_4_1] or not var_3.id then
				var_4_0 = 0
			end

			arg_4_2.name = var_4_0

			local function var_4_1(arg_5_0)
				setActive = var_3_10001

				local var_5_0 = arg_4_2
				local var_5_1 = var_2.Find(var_5_0, "red")

				IslandSeasonRedDotHelper = var_5_0

				var_3_10001(var_5_1, var_5_0.TipActivity(arg_5_0))

				return
			end

			if var_3 then
				var_2_10007 = var_3
				var_2_10006 = var_3.getIslandConfig(var_2_10007, "title_res_tag")
				setText = var_2_10007

				var_2_10007(arg_4_2:Find("on/Text"), var_2_10006)

				setText = var_2_10007

				var_2_10007(arg_4_2:Find("off/Text"), var_2_10006)
				var_4_1(var_3)
			else
				setText = var_2_10006

				local var_4_2 = arg_4_2

				var_2_10007 = arg_4_2.Find(var_4_2, "on/Text")
				i18n = var_4_2

				var_2_10006(var_2_10007, var_4_2("island_no_activity"))

				setText = var_2_10006

				local var_4_3 = arg_4_2

				var_2_10007 = arg_4_2.Find(var_4_3, "on/Text/en")
				i18n = var_4_3

				var_2_10006(var_2_10007, var_4_3("island_activity_decorative_word"))

				setText = var_2_10006

				local var_4_4 = arg_4_2

				var_2_10007 = arg_4_2.Find(var_4_4, "off/Text")
				i18n = var_4_4

				var_2_10006(var_2_10007, var_4_4("island_no_activity"))
			end

			local var_4_5 = arg_3_0.pageDic[var_4_0]

			onToggle = var_2_10007

			local var_4_6 = arg_3_0
			local var_4_7 = arg_4_2

			local function var_4_8(arg_6_0)
				if var_4_5 and arg_6_0 then
					local var_6_0 = arg_3_0

					var_1.selectActivity(var_6_0, var_0)
					var_4_1(var_0)
				end

				return
			end

			SFX_PANEL = var_2_10011

			var_2_10007(var_4_6, var_4_7, var_4_8, var_2_10011)
		end

		return
	end)

	arg_3_0.switchCount = 0

	return
end

function var_0_1.Show(arg_7_0)
	var_0_1.super.Show(arg_7_0)
	arg_7_0:Flush()

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_14")

	return
end

function var_0_1.Flush(arg_8_0)
	if not arg_8_0:isShowing() then
		return
	end

	if not arg_8_0.activities then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.setActivities

		getProxy = var_1_10003
		ActivityProxy = var_1_10004

		local var_8_2 = var_1_10003(var_1_10004)

		var_8_1(var_8_0, var_3.getIslandPanelActivities(var_8_2))
	end

	if arg_8_0.activity then
		local var_8_3 = arg_8_0.pageDic[arg_8_0.activity.id]

		var_1.ExecuteAction(var_8_3, "ShowOrHide", true)
	else
		arg_8_0:verifyTabs()
	end

	return
end

function var_0_1.verifyTabs(arg_9_0, arg_9_1)
	if #arg_9_0.activities > 0 then
		local var_9_0

		if not arg_9_0:getActivityIndex(arg_9_1) then
			var_9_0 = 1
		end

		local var_9_1 = arg_9_0.rtTabsContent
		local var_9_2 = var_3.GetChild(var_9_1, var_9_0 - 1)

		triggerToggle = var_9_1

		var_9_1(var_9_2, true)
	end

	return
end

function var_0_1.getActivityIndex(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.activities) do
		if iter_10_1.id == arg_10_1 then
			return iter_10_0
		end
	end

	return nil
end

function var_0_1.setActivities(arg_11_0, arg_11_1)
	arg_11_0.activities = arg_11_1 or {}

	local var_11_0

	if not arg_11_0.shareData then
		ActivityShareData = var_11_0
		var_11_0 = var_11_0.New()
	end

	arg_11_0.shareData = var_11_0

	local var_11_1

	if not arg_11_0.pageDic then
		var_11_1 = {}
	end

	arg_11_0.pageDic = var_11_1
	ipairs = var_11_1

	for iter_11_0, iter_11_1 in var_11_1(arg_11_1) do
		arg_11_0:instanceActivityPage(iter_11_1)
	end

	arg_11_0.activity = nil
	table = var_2

	local var_11_2 = var_2.sort
	local var_11_3 = arg_11_0.activities

	CompareFuncs = var_4

	var_11_2(var_11_3, var_4({
		function(arg_12_0)
			return -arg_12_0:getIslandConfig("is_show")
		end,
		function(arg_13_0)
			return -arg_13_0.id
		end
	}))
	arg_11_0:flushTabs()

	return
end

function var_0_1.OnTaskUpdate(arg_14_0, arg_14_1)
	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.activities) do
		local var_14_0 = iter_14_1
		local var_14_1 = iter_14_1.getConfig(var_14_0, "type")

		ActivityConst = var_14_0

		if var_14_1 == var_14_0.ACTIVITY_TYPE_TASK_LIST then
			_ = var_14_1

			local var_14_2 = var_14_1.any

			_ = var_8

			if var_14_2(var_8.flatten(iter_14_1:getIslandConfig("config_data")), function(arg_15_0)
				return arg_15_0 == arg_14_1
			end) then
				arg_14_0:updateActivity(iter_14_1)
			end
		end
	end

	return
end

function var_0_1.updateActivity(arg_16_0, arg_16_1)
	ActivityConst = var_1_10002

	if var_1_10002.IslandPageIdLinks[arg_16_1.id] then
		ipairs = var_3

		for iter_16_0, iter_16_1 in var_3(var_2) do
			local var_16_0 = arg_16_0
			local var_16_1 = arg_16_0._updateActivity

			getProxy = var_1_10010
			ActivityProxy = var_1_10011
			var_1_10011 = var_1_10010(var_1_10011)

			var_16_1(var_16_0, var_1_10010.getActivityById(var_1_10011, iter_16_1))
		end
	else
		arg_16_0:_updateActivity(arg_16_1)
	end

	return
end

function var_0_1._updateActivity(arg_17_0, arg_17_1)
	if arg_17_1:isIslandShow() and not arg_17_1:isEnd() then
		local var_17_0 = arg_17_0.activities
		local var_17_1 = arg_17_0
		local var_17_2

		if not arg_17_0.getActivityIndex(var_17_1, arg_17_1.id) then
			var_17_2 = #arg_17_0.activities + 1
		end

		var_17_0[var_17_2] = arg_17_1
		table = var_17_0

		local var_17_3 = var_17_0.sort
		local var_17_4 = arg_17_0.activities

		CompareFuncs = var_17_1

		var_17_3(var_17_4, var_17_1({
			function(arg_18_0)
				return -arg_18_0:getIslandConfig("is_show")
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if not arg_17_0.pageDic[arg_17_1.id] then
			arg_17_0:instanceActivityPage(arg_17_1)
		end

		arg_17_0:flushTabs()

		if arg_17_0:isShowing() and arg_17_0.activity and arg_17_0.activity.id == arg_17_1.id then
			arg_17_0.activity = arg_17_1

			local var_17_5 = arg_17_0.pageDic[arg_17_1.id]

			var_2.ActionInvoke(var_17_5, "Flush", arg_17_1)
		end
	end

	return
end

function var_0_1.removeActivity(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0

	if arg_20_0.getActivityIndex(var_20_0, arg_20_1) then
		table = var_20_0

		var_20_0.remove(arg_20_0.activities, var_2)

		local var_20_1 = arg_20_0.pageDic[arg_20_1]

		var_3.Destroy(var_20_1)

		arg_20_0.pageDic[arg_20_1] = nil

		arg_20_0:flushTabs()

		if arg_20_0.activity and arg_20_0.activity.id == arg_20_1 then
			arg_20_0.activity = nil

			arg_20_0:verifyTabs()
		end
	end

	return
end

function var_0_1.getActClass(arg_21_0, arg_21_1)
	import = var_1_10002

	return var_1_10002("Mod.Island.View.page.activity." .. arg_21_1)
end

function var_0_1.instanceActivityPage(arg_22_0, arg_22_1)
	if arg_22_1:getIslandConfig("page_info").class_name and not arg_22_0.pageDic[arg_22_1.id] and not arg_22_1:isEnd() then
		local var_22_0 = arg_22_0:getActClass(var_2.class_name).New(arg_22_0.rtPages, arg_22_0.event, arg_22_0.contextData)

		if var_4.UseSecondPage(var_22_0, arg_22_1) then
			var_4:SetUIName(var_2.ui_name2)
		else
			var_4:SetUIName(var_2.ui_name)
		end

		var_4:SetShareData(arg_22_0.shareData)

		arg_22_0.pageDic[arg_22_1.id] = var_4
	end

	return
end

function var_0_1.flushTabs(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.rtPagesEmpty, #arg_23_0.activities == 0)

	local var_23_0 = arg_23_0.tabsList
	local var_23_1 = var_1.align

	math = var_3

	var_23_1(var_23_0, var_3.max(#arg_23_0.activities, 1))

	return
end

function var_0_1.selectActivity(arg_24_0, arg_24_1)
	if arg_24_0.nextActivity == arg_24_1 or not arg_24_0.nextActivity and arg_24_0.activity and arg_24_1.id == arg_24_0.activity.id then
		return
	end

	IslandSeasonRedDotHelper = var_2

	var_2.UpdateActEnterTip(arg_24_1)

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.emit

	IslandSeasonPage = var_1_10004

	local var_24_2 = var_1_10004.UPDATE_REDDOT

	IslandSeasonPage = var_1_10005

	var_24_1(var_24_0, var_24_2, var_1_10005.PAGE_ACTIVITY)

	local var_24_3 = {}

	if arg_24_0.activity and not arg_24_0.nextActivity then
		arg_24_0.switchCount = arg_24_0.switchCount + 1
		table = var_3

		var_3.insert(var_24_3, function(arg_25_0)
			local var_25_0 = arg_24_0.pageDic[arg_24_0.activity.id]

			var_1.ActionInvoke(var_25_0, "SwitchOut", function()
				arg_24_0.switchCount = arg_24_0.switchCount - 1

				arg_25_0()

				return
			end)

			return
		end)
	end

	local var_24_4

	if not arg_24_0.activity or arg_24_0.activity.id ~= arg_24_1.id then
		var_24_4 = arg_24_0.pageDic[arg_24_1.id]
		assert = var_4

		var_4(var_24_4, "找不到id:" .. arg_24_1.id .. "的活动页，请检查")

		arg_24_0.switchCount = arg_24_0.switchCount + 1
		table = var_4

		var_4.insert(var_24_3, function(arg_27_0)
			local var_27_0 = var_24_4

			var_1.Load(var_27_0)

			local var_27_1 = var_24_4

			var_1.ActionInvoke(var_27_1, "ShowOrHide", false)

			local var_27_2 = var_24_4

			var_1.CallbackInvoke(var_27_2, function()
				arg_24_0.switchCount = arg_24_0.switchCount - 1

				arg_27_0()

				return
			end)

			return
		end)
	end

	arg_24_0.nextActivity = arg_24_1
	parallelAsync = var_24_4

	var_24_4(var_24_3, function()
		if arg_24_0.switchCount > 0 then
			return
		end

		if arg_24_0.activity then
			local var_29_0 = arg_24_0.pageDic[arg_24_0.activity.id]

			var_0.ActionInvoke(var_29_0, "ShowOrHide", false)
		end

		arg_24_0.activity = arg_24_0.nextActivity
		arg_24_0.contextData.id = arg_24_0.nextActivity.id
		arg_24_0.nextActivity = nil

		local var_29_1 = arg_24_0.pageDic[arg_24_0.activity.id]

		var_0.ActionInvoke(var_29_1, "ShowOrHide", true)
		var_0:ActionInvoke("Flush", arg_24_0.activity)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_30_0)
	arg_30_0.shareData = nil
	pairs = var_1

	for iter_30_0, iter_30_1 in var_1(arg_30_0.pageDic) do
		iter_30_1:Destroy()
	end

	arg_30_0.pageDic = nil
	arg_30_0.activities = nil
	arg_30_0.switchCount = nil

	return
end

function var_0_1.OnHide(arg_31_0)
	arg_31_0:UnOverlayPanel(arg_31_0._tf, arg_31_0._parentTf)

	pairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.pageDic) do
		if iter_31_1 and iter_31_1:isShowing() then
			iter_31_1:Hide()
		end
	end

	return
end

return var_0_1
