local var_0_0 = class("IslandSeasonActivityPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonActivityPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.tabsList = UIItemList.New(arg_3_0.rtTabsContent, arg_3_0.rtTabsTpl)

	arg_3_0.tabsList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_0.activities[arg_4_1]

			if arg_3_0.activities[arg_4_1] then
				local var_4_1 = var_4_0.id or 0

				arg_4_2.name = var_4_1

				local function var_4_2(arg_5_0)
					setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipActivity(arg_5_0))

					return
				end

				if var_4_0 then
					local var_4_3 = var_4_0:getIslandConfig("title_res_tag")

					setText(arg_4_2:Find("on/Text"), var_4_3)
					setText(arg_4_2:Find("off/Text"), var_4_3)
					;(function(arg_5_0)
						setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipActivity(arg_5_0))

						return
					end)(var_4_0)
				else
					setText(arg_4_2:Find("on/Text"), i18n("island_no_activity"))
					setText(arg_4_2:Find("on/Text/en"), i18n("island_activity_decorative_word"))
					setText(arg_4_2:Find("off/Text"), i18n("island_no_activity"))
				end

				local var_4_4 = arg_3_0.pageDic[var_4_1]

				onToggle(arg_3_0, arg_4_2, function(arg_6_0)
					if var_4_4 and arg_6_0 then
						arg_3_0:selectActivity(var_4_0)
						var_4_2(var_4_0)
					end

					return
				end, SFX_PANEL)

				return
			end
		end
	end)

	arg_3_0.switchCount = 0

	return
end

function var_0_0.Show(arg_7_0)
	var_0_0.super.Show(arg_7_0)
	arg_7_0:Flush()
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_14")

	return
end

function var_0_0.Flush(arg_8_0)
	if not arg_8_0:isShowing() then
		return
	end

	if not arg_8_0.activities then
		arg_8_0:setActivities(getProxy(ActivityProxy):getIslandPanelActivities())
	end

	if arg_8_0.activity then
		arg_8_0.pageDic[arg_8_0.activity.id]:ExecuteAction("ShowOrHide", true)
	else
		arg_8_0:verifyTabs()
	end

	return
end

function var_0_0.verifyTabs(arg_9_0, arg_9_1)
	if #arg_9_0.activities > 0 then
		local var_9_0 = arg_9_0:getActivityIndex(arg_9_1) or 1

		triggerToggle(arg_9_0.rtTabsContent:GetChild(var_9_0 - 1), true)
	end

	return
end

function var_0_0.getActivityIndex(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.activities) do
		if iter_10_1.id == arg_10_1 then
			return iter_10_0
		end
	end

	return nil
end

function var_0_0.setActivities(arg_11_0, arg_11_1)
	arg_11_0.activities = arg_11_1 or {}
	arg_11_0.shareData = arg_11_0.shareData or ActivityShareData.New()
	arg_11_0.pageDic = arg_11_0.pageDic or {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0:instanceActivityPage(iter_11_1)
	end

	arg_11_0.activity = nil

	table.sort(arg_11_0.activities, CompareFuncs({
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

function var_0_0.OnTaskUpdate(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.activities) do
		if iter_14_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TASK_LIST and _.any(_.flatten(iter_14_1:getIslandConfig("config_data")), function(arg_15_0)
			return arg_15_0 == arg_14_1
		end) then
			arg_14_0:updateActivity(iter_14_1)
		end
	end

	return
end

function var_0_0.updateActivity(arg_16_0, arg_16_1)
	if ActivityConst.IslandPageIdLinks[arg_16_1.id] then
		for iter_16_0, iter_16_1 in ipairs(ActivityConst.IslandPageIdLinks[arg_16_1.id]) do
			local var_16_0 = getProxy(ActivityProxy)

			arg_16_0:_updateActivity(var_16_0:getActivityById(iter_16_1))
		end
	else
		arg_16_0:_updateActivity(arg_16_1)
	end

	return
end

function var_0_0._updateActivity(arg_17_0, arg_17_1)
	if arg_17_1:isIslandShow() and not arg_17_1:isEnd() then
		local var_17_0 = arg_17_0:getActivityIndex(arg_17_1.id) or #arg_17_0.activities + 1

		arg_17_0.activities[var_17_0] = arg_17_1

		table.sort(arg_17_0.activities, CompareFuncs({
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

			arg_17_0.pageDic[arg_17_1.id]:ActionInvoke("Flush", arg_17_1)
		end
	end

	return
end

function var_0_0.removeActivity(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getActivityIndex(arg_20_1)

	if var_20_0 then
		table.remove(arg_20_0.activities, var_20_0)
		arg_20_0.pageDic[arg_20_1]:Destroy()

		arg_20_0.pageDic[arg_20_1] = nil

		arg_20_0:flushTabs()

		if arg_20_0.activity and arg_20_0.activity.id == arg_20_1 then
			arg_20_0.activity = nil

			arg_20_0:verifyTabs()
		end
	end

	return
end

function var_0_0.getActClass(arg_21_0, arg_21_1)
	return import("Mod.Island.View.page.activity." .. arg_21_1)
end

function var_0_0.instanceActivityPage(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getIslandConfig("page_info")

	if var_22_0.class_name and not arg_22_0.pageDic[arg_22_1.id] and not arg_22_1:isEnd() then
		local var_22_1 = arg_22_0:getActClass(var_22_0.class_name).New(arg_22_0.rtPages, arg_22_0.event, arg_22_0.contextData)

		if var_22_1:UseSecondPage(arg_22_1) then
			var_22_1:SetUIName(var_22_0.ui_name2)
		else
			var_22_1:SetUIName(var_22_0.ui_name)
		end

		var_22_1:SetShareData(arg_22_0.shareData)

		arg_22_0.pageDic[arg_22_1.id] = var_22_1
	end

	return
end

function var_0_0.flushTabs(arg_23_0)
	setActive(arg_23_0.rtPagesEmpty, #arg_23_0.activities == 0)
	arg_23_0.tabsList:align(math.max(#arg_23_0.activities, 1))

	return
end

function var_0_0.selectActivity(arg_24_0, arg_24_1)
	if arg_24_0.nextActivity == arg_24_1 or not arg_24_0.nextActivity and arg_24_0.activity and arg_24_1.id == arg_24_0.activity.id then
		return
	end

	IslandSeasonRedDotHelper.UpdateActEnterTip(arg_24_1)
	arg_24_0:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_ACTIVITY)

	local var_24_0 = {}

	if arg_24_0.activity and not arg_24_0.nextActivity then
		arg_24_0.switchCount = arg_24_0.switchCount + 1

		table.insert(var_24_0, function(arg_25_0)
			arg_24_0.pageDic[arg_24_0.activity.id]:ActionInvoke("SwitchOut", function()
				arg_24_0.switchCount = arg_24_0.switchCount - 1

				arg_25_0()

				return
			end)

			return
		end)
	end

	if arg_24_0.activity then
		if arg_24_0.activity.id ~= arg_24_1.id then
			assert(arg_24_0.pageDic[arg_24_1.id], "找不到id:" .. arg_24_1.id .. "的活动页，请检查")

			arg_24_0.switchCount = arg_24_0.switchCount + 1

			table.insert(var_24_0, function(arg_27_0)
				var_0:Load()
				var_0:ActionInvoke("ShowOrHide", false)
				var_0:CallbackInvoke(function()
					arg_24_0.switchCount = arg_24_0.switchCount - 1

					arg_27_0()

					return
				end)

				return
			end)
		end

		arg_24_0.nextActivity = arg_24_1

		parallelAsync(var_24_0, function()
			if arg_24_0.switchCount > 0 then
				return
			end

			if arg_24_0.activity then
				arg_24_0.pageDic[arg_24_0.activity.id]:ActionInvoke("ShowOrHide", false)
			end

			arg_24_0.activity = arg_24_0.nextActivity
			arg_24_0.contextData.id = arg_24_0.nextActivity.id
			arg_24_0.nextActivity = nil

			arg_24_0.pageDic[arg_24_0.activity.id]:ActionInvoke("ShowOrHide", true)
			arg_24_0.pageDic[arg_24_0.activity.id]:ActionInvoke("Flush", arg_24_0.activity)

			return
		end)

		return
	end
end

function var_0_0.OnDestroy(arg_30_0)
	arg_30_0.shareData = nil

	for iter_30_0, iter_30_1 in pairs(arg_30_0.pageDic) do
		iter_30_1:Destroy()
	end

	arg_30_0.pageDic = nil
	arg_30_0.activities = nil
	arg_30_0.switchCount = nil

	return
end

function var_0_0.OnHide(arg_31_0)
	arg_31_0:UnOverlayPanel(arg_31_0._tf, arg_31_0._parentTf)

	for iter_31_0, iter_31_1 in pairs(arg_31_0.pageDic) do
		if iter_31_1 and iter_31_1:isShowing() then
			iter_31_1:Hide()
		end
	end

	return
end

return var_0_0
