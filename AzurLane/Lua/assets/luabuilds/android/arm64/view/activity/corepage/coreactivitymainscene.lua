local var_0_0 = class("CoreActivityMainScene", import("view.activity.ActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return nil
end

var_0_0.optionsPath = {
	"adapt/top/btn_home"
}

function var_0_0.PlayBGM(arg_2_0)
	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.btnBack = arg_3_0._tf:Find("adapt/top/btn_back")
	arg_3_0.btnSkin = arg_3_0._tf:Find("adapt/btn_skin")
	arg_3_0.pageContainer = arg_3_0._tf:Find("page_list")
	arg_3_0.tabs = arg_3_0._tf:Find("adapt/tabs")
	arg_3_0.windowList = {}
	arg_3_0.awardWindow = AwardWindow.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.chargeTipWindow = ChargeTipWindow.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.tabsList = UIItemList.New(arg_3_0.tabs, arg_3_0.tabs:GetChild(0))

	arg_3_0.tabsList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = underscore.detect(arg_3_0.activities, function(arg_5_0)
				return tostring(arg_5_0:getConfig("is_show")) == arg_4_2.name
			end)

			if not var_4_0 or var_4_0:isEnd() then
				setActive(arg_4_2, false)
			else
				local var_4_1

				if not arg_3_0.pageDic[var_4_0.id] then
					warning(string.format("without page in act:", var_4_0.id))

					goto label_4_0

					var_4_1 = arg_4_2:Find("tip")
				end

				local var_4_2 = arg_3_0.pageDic[var_4_0.id]:IsShowReminder()

				if var_4_2 == nil then
					setActive(var_4_1, var_4_0:readyToAchieve())
				else
					setActive(var_4_1, var_4_2)
				end

				onToggle(arg_3_0, arg_4_2, function(arg_6_0)
					if arg_6_0 then
						arg_3_0:selectActivity(var_4_0)
					end

					return
				end, SFX_PANEL)
			end

			::label_4_0::
		end

		return
	end)

	arg_3_0.switchCount = 0

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:bind(var_0_0.UPDATE_ACTIVITY, function(arg_8_0, arg_8_1)
		arg_7_0:updateActivity(arg_8_1)

		return
	end)
	arg_7_0:bind(var_0_0.GET_PAGE_BGM, function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_2.bgm = arg_7_0:getBGM(arg_9_1) or arg_7_0:getBGM()

		return
	end)
	arg_7_0:bind(var_0_0.FLUSH_TABS, function()
		arg_7_0:flushTabs()

		return
	end)
	onButton(arg_7_0, arg_7_0.btnBack, function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)

	if arg_7_0.btnSkin then
		onButton(arg_7_0, arg_7_0.btnSkin, function()
			arg_7_0:emit(ActivityMediator.GO_CHANGE_SHOP)

			return
		end, SFX_PANEL)
	end

	arg_7_0:emit(ActivityMediator.SHOW_NEXT_ACTIVITY, arg_7_0.contextData.coreName)

	return
end

function var_0_0.setActivities(arg_13_0, arg_13_1)
	arg_13_0.activities = underscore.filter(arg_13_1 or {}, function(arg_14_0)
		return not arg_14_0:isEnd()
	end)
	arg_13_0.shareData = arg_13_0.shareData or ActivityShareData.New()
	arg_13_0.pageDic = arg_13_0.pageDic or {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activities) do
		arg_13_0:instanceActivityPage(iter_13_1)
	end

	table.sort(arg_13_0.activities, CompareFuncs({
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

function var_0_0.updateActivity(arg_17_0, arg_17_1)
	if ActivityConst.PageIdLink[arg_17_1.id] then
		arg_17_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_17_1.id])
	end

	if arg_17_1:isShow() and arg_17_1:isCorePage(arg_17_0.contextData.coreName) and not arg_17_1:isEnd() then
		local var_17_0 = arg_17_0:getActivityIndex(arg_17_1.id) or #arg_17_0.activities + 1

		arg_17_0.activities[var_17_0] = arg_17_1

		table.sort(arg_17_0.activities, CompareFuncs({
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

			arg_17_0.pageDic[arg_17_1.id]:ActionInvoke("Flush", arg_17_1)
			arg_17_0:verifyTabs(arg_17_0.activity.id)
		end
	end

	return
end

function var_0_0.instanceActivityPage(arg_20_0, arg_20_1)
	var_0_0.super.instanceActivityPage(arg_20_0, arg_20_1)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.pageDic) do
		iter_20_1:SetCoreActivityUI(arg_20_0)
	end

	return
end

function var_0_0.updateEntrances(arg_21_0)
	return
end

function var_0_0.flushTabs(arg_22_0)
	arg_22_0.tabsList:align(arg_22_0.tabs.childCount)

	return
end

function var_0_0.IsImageTgName(arg_23_0)
	return false
end

function var_0_0.OnToggleName(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2:getConfig("title_res_tag")

	setText(arg_24_1:Find("on/name"), i18n(var_24_0))
	setText(arg_24_1:Find("off/name"), i18n(var_24_0))

	if arg_24_0:IsImageTgName() then
		local var_24_1 = string.lower(var_24_0)

		if checkABExist("coreactivityuitable/" .. var_24_1 .. "_text") then
			setImageSprite(arg_24_1:Find("off/imgName"), GetSpriteFromAtlas("coreactivityuitable/" .. var_24_1 .. "_text", ""), true)
		end

		if checkABExist("coreactivityuitable/" .. var_24_1 .. "_text_selected") then
			setImageSprite(arg_24_1:Find("on/imgName"), GetSpriteFromAtlas("coreactivityuitable/" .. var_24_1 .. "_text_selected", ""), true)
		end
	end

	return
end

function var_0_0.selectActivity(arg_25_0, arg_25_1)
	if arg_25_0.nextActivity == arg_25_1 or not arg_25_0.nextActivity and arg_25_0.activity and arg_25_1.id == arg_25_0.activity.id then
		return
	end

	local var_25_0 = {}

	if arg_25_0.activity and not arg_25_0.nextActivity then
		arg_25_0.switchCount = arg_25_0.switchCount + 1

		table.insert(var_25_0, function(arg_26_0)
			arg_25_0.pageDic[arg_25_0.activity.id]:ActionInvoke("SwitchOut", function()
				arg_25_0.switchCount = arg_25_0.switchCount - 1

				arg_26_0()

				return
			end)

			return
		end)
	end

	if arg_25_0.activity then
		if arg_25_0.activity.id ~= arg_25_1.id then
			assert(arg_25_0.pageDic[arg_25_1.id], "找不到id:" .. arg_25_1.id .. "的活动页，请检查")

			arg_25_0.switchCount = arg_25_0.switchCount + 1

			table.insert(var_25_0, function(arg_28_0)
				var_0:Load()
				var_0:ActionInvoke("ShowOrHide", false)
				var_0:CallbackInvoke(function()
					arg_25_0.switchCount = arg_25_0.switchCount - 1

					arg_28_0()

					return
				end)

				return
			end)
		end

		arg_25_0.nextActivity = arg_25_1

		parallelAsync(var_25_0, function()
			if arg_25_0.switchCount > 0 then
				return
			end

			if arg_25_0.activity then
				arg_25_0.pageDic[arg_25_0.activity.id]:ActionInvoke("ShowOrHide", false)
			end

			arg_25_0.activity = arg_25_0.nextActivity
			arg_25_0.contextData.id = arg_25_0.nextActivity.id
			arg_25_0.nextActivity = nil

			arg_25_0.pageDic[arg_25_0.activity.id]:ActionInvoke("ShowOrHide", true)
			arg_25_0.pageDic[arg_25_0.activity.id]:ActionInvoke("Flush", arg_25_0.activity)

			return
		end)

		return
	end
end

function var_0_0.verifyTabs(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getActivityIndex(arg_31_1) or arg_31_0:getActivityIndex(arg_31_0:GetActiveActivity()) or 1

	if arg_31_0.activities[var_31_0] == nil then
		return
	end

	local var_31_1 = arg_31_0.tabs:Find(tostring((arg_31_0.activities[var_31_0]:getConfig("is_show"))))

	if var_31_1 then
		triggerToggle(var_31_1, true)
	end

	return
end

function var_0_0.GetActiveActivity(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.activities) do
		if not iter_32_1:isEnd() then
			return iter_32_1.id
		end
	end

	return
end

function var_0_0.GetActivityIdByPageClass(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.activities or {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_1 = iter_33_1:getConfig("page_info")

		if var_33_1 and var_33_1.class_name == arg_33_1 then
			return iter_33_1.id
		end
	end

	return nil
end

function var_0_0.onBackPressed(arg_34_0)
	if arg_34_0.pageDic[arg_34_0.activity.id]:IsShowingPopWindow() then
		arg_34_0.pageDic[arg_34_0.activity.id]:ClosePopWindow()

		return
	end

	var_0_0.super.onBackPressed(arg_34_0)

	return
end

function var_0_0.getActClass(arg_35_0, arg_35_1)
	return _G[arg_35_1]
end

return var_0_0
