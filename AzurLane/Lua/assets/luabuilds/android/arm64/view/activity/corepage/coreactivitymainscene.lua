class = var_0_10000

local var_0_0 = "CoreActivityMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.ActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return nil
end

var_0_1.optionsPath = {
	"adapt/top/btn_home"
}

function var_0_1.PlayBGM(arg_2_0)
	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.btnBack = var_1.Find(var_3_0, "adapt/top/btn_back")

	local var_3_1 = arg_3_0._tf

	arg_3_0.btnSkin = var_1.Find(var_3_1, "adapt/btn_skin")

	local var_3_2 = arg_3_0._tf

	arg_3_0.pageContainer = var_1.Find(var_3_2, "page_list")

	local var_3_3 = arg_3_0._tf

	arg_3_0.tabs = var_1.Find(var_3_3, "adapt/tabs")
	arg_3_0.windowList = {}
	AwardWindow = var_1
	arg_3_0.awardWindow = var_1.New(arg_3_0._tf, arg_3_0.event)
	ChargeTipWindow = var_1
	arg_3_0.chargeTipWindow = var_1.New(arg_3_0._tf, arg_3_0.event)
	UIItemList = var_1

	local var_3_4 = var_1.New
	local var_3_5 = arg_3_0.tabs
	local var_3_6 = arg_3_0.tabs

	arg_3_0.tabsList = var_3_4(var_3_5, var_4.GetChild(var_3_6, 0))

	local var_3_7 = arg_3_0.tabsList

	var_1.make(var_3_7, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if var_3.detect(arg_3_0.activities, function(arg_5_0)
				tostring = var_3_10001

				return var_3_10001(arg_5_0:getConfig("is_show")) == arg_4_2.name
			end) then
				local var_4_0 = var_3

				if var_3.isEnd(var_4_0) then
					setActive = var_2_10004

					var_2_10004(arg_4_2, false)
				elseif not arg_3_0.pageDic[var_3.id] then
					warning = var_4
					string = var_4_0

					var_4(var_4_0.format("without page in act:", var_3.id))
				else
					local var_4_1 = arg_3_0.pageDic[var_3.id]
					local var_4_2 = arg_4_2
					local var_4_3 = arg_4_2.Find(var_4_2, "tip")

					if var_4_1:IsShowReminder() == nil then
						setActive = var_4_2

						local var_4_4 = var_4_3

						var_2_10012 = var_3

						var_4_2(var_4_4, var_3.readyToAchieve(var_2_10012))
					else
						setActive = var_4_2

						var_4_2(var_4_3, var_6)
					end

					onToggle = var_4_2

					local var_4_5 = arg_3_0
					local var_4_6 = arg_4_2

					local function var_4_7(arg_6_0)
						if arg_6_0 then
							local var_6_0 = arg_3_0

							var_1.selectActivity(var_6_0, var_0)
						end

						return
					end

					SFX_PANEL = var_2_10012

					var_4_2(var_4_5, var_4_6, var_4_7, var_2_10012)
				end

				return
			end
		end
	end)

	arg_3_0.switchCount = 0

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:bind(var_0_1.UPDATE_ACTIVITY, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_0

		var_2.updateActivity(var_8_0, arg_8_1)

		return
	end)
	arg_7_0:bind(var_0_1.GET_PAGE_BGM, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_7_0
		local var_9_2

		if not var_3.getBGM(var_9_0, arg_9_1) then
			local var_9_1 = arg_7_0

			var_9_2 = var_3.getBGM(var_9_1)
		end

		arg_9_2.bgm = var_9_2

		return
	end)
	arg_7_0:bind(var_0_1.FLUSH_TABS, function()
		local var_10_0 = arg_7_0

		var_0.flushTabs(var_10_0)

		return
	end)

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.btnBack

	local function var_7_2()
		local var_11_0 = arg_7_0

		var_0.emit(var_11_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_7_0, var_7_1, var_7_2, var_1_10006)

	if arg_7_0.btnSkin then
		onButton = var_1

		local var_7_3 = arg_7_0

		var_7_1 = arg_7_0.btnSkin

		local function var_7_4()
			local var_12_0 = arg_7_0
			local var_12_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_12_1(var_12_0, var_2_10003.GO_CHANGE_SHOP)

			return
		end

		SFX_PANEL = var_1_10006

		var_1(var_7_3, var_7_1, var_7_4, var_1_10006)
	end

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.emit

	ActivityMediator = var_7_1

	var_7_6(var_7_5, var_7_1.SHOW_NEXT_ACTIVITY, arg_7_0.contextData.coreName)

	return
end

function var_0_1.setActivities(arg_13_0, arg_13_1)
	underscore = var_1_10002
	arg_13_0.activities = var_1_10002.filter(arg_13_1 or {}, function(arg_14_0)
		return not arg_14_0:isEnd()
	end)

	local var_13_0

	if not arg_13_0.shareData then
		ActivityShareData = var_13_0
		var_13_0 = var_13_0.New()
	end

	arg_13_0.shareData = var_13_0

	local var_13_1

	if not arg_13_0.pageDic then
		var_13_1 = {}
	end

	arg_13_0.pageDic = var_13_1
	ipairs = var_13_1

	for iter_13_0, iter_13_1 in var_13_1(arg_13_0.activities) do
		arg_13_0:instanceActivityPage(iter_13_1)
	end

	table = var_2

	local var_13_2 = var_2.sort
	local var_13_3 = arg_13_0.activities

	CompareFuncs = iter_13_0

	var_13_2(var_13_3, iter_13_0({
		function(arg_15_0)
			return arg_15_0:getShowPriority()
		end,
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))
	arg_13_0:flushTabs()

	return
end

function var_0_1.updateActivity(arg_17_0, arg_17_1)
	ActivityConst = var_1_10002

	if var_1_10002.PageIdLink[arg_17_1.id] then
		getProxy = var_2
		ActivityProxy = var_1_10004

		local var_17_0 = var_2(var_1_10004)
		local var_17_1 = var_2.getActivityById

		ActivityConst = var_1_10005
		arg_17_1 = var_17_1(var_17_0, var_1_10005.PageIdLink[arg_17_1.id])
	end

	if arg_17_1:isShow() and arg_17_1:isCorePage(arg_17_0.contextData.coreName) and not arg_17_1:isEnd() then
		local var_17_2 = arg_17_0.activities
		local var_17_3 = arg_17_0
		local var_17_4

		if not arg_17_0.getActivityIndex(var_17_3, arg_17_1.id) then
			var_17_4 = #arg_17_0.activities + 1
		end

		var_17_2[var_17_4] = arg_17_1
		table = var_17_2

		local var_17_5 = var_17_2.sort
		local var_17_6 = arg_17_0.activities

		CompareFuncs = var_17_3

		var_17_5(var_17_6, var_17_3({
			function(arg_18_0)
				return -arg_18_0:getShowPriority()
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if not arg_17_0.pageDic[arg_17_1.id] then
			arg_17_0:instanceActivityPage(arg_17_1)
		end

		arg_17_0:flushTabs()

		if arg_17_0.activity and arg_17_0.activity.id == arg_17_1.id then
			arg_17_0.activity = arg_17_1

			local var_17_7 = arg_17_0.pageDic[arg_17_1.id]

			var_2.ActionInvoke(var_17_7, "Flush", arg_17_1)
			arg_17_0:verifyTabs(arg_17_0.activity.id)
		end
	end

	return
end

function var_0_1.instanceActivityPage(arg_20_0, arg_20_1)
	var_0_1.super.instanceActivityPage(arg_20_0, arg_20_1)

	pairs = var_2

	for iter_20_0, iter_20_1 in var_2(arg_20_0.pageDic) do
		iter_20_1:SetCoreActivityUI(arg_20_0)
	end

	return
end

function var_0_1.updateEntrances(arg_21_0)
	return
end

function var_0_1.flushTabs(arg_22_0)
	local var_22_0 = arg_22_0.tabsList

	var_1.align(var_22_0, arg_22_0.tabs.childCount)

	return
end

function var_0_1.IsImageTgName(arg_23_0)
	return false
end

function var_0_1.OnToggleName(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2:getConfig("title_res_tag")

	setText = var_1_10004

	local var_24_1 = arg_24_1:Find("on/name")

	i18n = var_1_10007

	var_1_10004(var_24_1, var_1_10007(var_24_0))

	setText = var_1_10004

	local var_24_2 = arg_24_1:Find("off/name")

	i18n = var_7

	var_1_10004(var_24_2, var_7(var_24_0))

	if arg_24_0:IsImageTgName() then
		string = var_4

		local var_24_3 = var_4.lower(var_24_0)

		checkABExist = var_4

		if var_4("coreactivityuitable/" .. var_24_3 .. "_text") then
			setImageSprite = var_4

			local var_24_4 = arg_24_1:Find("off/imgName")

			GetSpriteFromAtlas = var_7

			var_4(var_24_4, var_7("coreactivityuitable/" .. var_24_3 .. "_text", ""), true)
		end

		checkABExist = var_4

		if var_4("coreactivityuitable/" .. var_24_3 .. "_text_selected") then
			setImageSprite = var_4

			local var_24_5 = arg_24_1:Find("on/imgName")

			GetSpriteFromAtlas = var_7

			var_4(var_24_5, var_7("coreactivityuitable/" .. var_24_3 .. "_text_selected", ""), true)
		end
	end

	return
end

function var_0_1.selectActivity(arg_25_0, arg_25_1)
	if arg_25_0.nextActivity == arg_25_1 or not arg_25_0.nextActivity and arg_25_0.activity and arg_25_1.id == arg_25_0.activity.id then
		return
	end

	local var_25_0 = {}

	if arg_25_0.activity and not arg_25_0.nextActivity then
		arg_25_0.switchCount = arg_25_0.switchCount + 1
		table = var_3

		var_3.insert(var_25_0, function(arg_26_0)
			local var_26_0 = arg_25_0.pageDic[arg_25_0.activity.id]

			var_1.ActionInvoke(var_26_0, "SwitchOut", function()
				arg_25_0.switchCount = arg_25_0.switchCount - 1

				arg_26_0()

				return
			end)

			return
		end)
	end

	local var_25_1

	if not arg_25_0.activity or arg_25_0.activity.id ~= arg_25_1.id then
		var_25_1 = arg_25_0.pageDic[arg_25_1.id]
		assert = var_4

		var_4(var_25_1, "找不到id:" .. arg_25_1.id .. "的活动页，请检查")

		arg_25_0.switchCount = arg_25_0.switchCount + 1
		table = var_4

		var_4.insert(var_25_0, function(arg_28_0)
			local var_28_0 = var_25_1

			var_1.Load(var_28_0)

			local var_28_1 = var_25_1

			var_1.ActionInvoke(var_28_1, "ShowOrHide", false)

			local var_28_2 = var_25_1

			var_1.CallbackInvoke(var_28_2, function()
				arg_25_0.switchCount = arg_25_0.switchCount - 1

				arg_28_0()

				return
			end)

			return
		end)
	end

	arg_25_0.nextActivity = arg_25_1
	parallelAsync = var_25_1

	var_25_1(var_25_0, function()
		if arg_25_0.switchCount > 0 then
			return
		end

		if arg_25_0.activity then
			local var_30_0 = arg_25_0.pageDic[arg_25_0.activity.id]

			var_0.ActionInvoke(var_30_0, "ShowOrHide", false)
		end

		arg_25_0.activity = arg_25_0.nextActivity
		arg_25_0.contextData.id = arg_25_0.nextActivity.id
		arg_25_0.nextActivity = nil

		local var_30_1 = arg_25_0.pageDic[arg_25_0.activity.id]

		var_0.ActionInvoke(var_30_1, "ShowOrHide", true)
		var_0:ActionInvoke("Flush", arg_25_0.activity)

		return
	end)

	return
end

function var_0_1.verifyTabs(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.activities
	local var_31_1

	if not arg_31_0:getActivityIndex(arg_31_1) and not arg_31_0:getActivityIndex(arg_31_0:GetActiveActivity()) then
		var_31_1 = 1
	end

	if var_31_0[var_31_1] == nil then
		return
	end

	local var_31_2 = var_2
	local var_31_3 = var_2.getConfig(var_31_2, "is_show")
	local var_31_4 = arg_31_0.tabs
	local var_31_5 = var_4.Find

	tostring = var_1_10007

	if var_31_5(var_31_4, var_1_10007(var_31_3)) then
		triggerToggle = var_31_2

		var_31_2(var_4, true)
	end

	return
end

function var_0_1.GetActiveActivity(arg_32_0)
	ipairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.activities) do
		if not iter_32_1:isEnd() then
			return iter_32_1.id
		end
	end

	return
end

function var_0_1.GetActivityIdByPageClass(arg_33_0, arg_33_1)
	ipairs = var_1_10002

	local var_33_0

	if not arg_33_0.activities then
		var_33_0 = {}
	end

	for iter_33_0, iter_33_1 in var_1_10002(var_33_0) do
		if iter_33_1:getConfig("page_info") and var_7.class_name == arg_33_1 then
			return iter_33_1.id
		end
	end

	return nil
end

function var_0_1.onBackPressed(arg_34_0)
	local var_34_0 = arg_34_0.pageDic[arg_34_0.activity.id]

	if var_1.IsShowingPopWindow(var_34_0) then
		var_1:ClosePopWindow()

		return
	end

	var_0_1.super.onBackPressed(arg_34_0)

	return
end

function var_0_1.getActClass(arg_35_0, arg_35_1)
	_G = var_1_10002

	return var_1_10002[arg_35_1]
end

return var_0_1
