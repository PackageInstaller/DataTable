local var_0_0 = class("MallMapScene", import("view.base.BaseUI"))

var_0_0.TYPE2INFOS = {
	[MallActivity.POINT_TYPE.SITE] = {
		"name_bg_blue",
		i18n("mall_point_name_type1"),
		"icon_site"
	},
	[MallActivity.POINT_TYPE.MAIN_STORY] = {
		"name_bg_green",
		i18n("mall_point_name_type2"),
		"icon_branch"
	},
	[MallActivity.POINT_TYPE.BRANCH_STORY] = {
		"name_bg_green",
		i18n("mall_point_name_type3"),
		"icon_branch"
	},
	[MallActivity.POINT_TYPE.INTERACT_STORY] = {
		"name_bg_orange",
		i18n("mall_point_name_type4"),
		""
	}
}

function var_0_0.getUIName(arg_1_0)
	return "MallMapUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBackBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHomeBtn, function()
		arg_2_0:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiMallBtn, function()
		arg_2_0:emit(MallMapMediator.CHANGE_SCENE, SCENE.MALL)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiBookBtn, function()
		arg_2_0:emit(MallMapMediator.GO_SUBLAYER, Context.New({
			mediator = MallStoryLineMediator,
			viewComponent = MallStoryLineLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiOrderBtn, function()
		arg_2_0:emit(MallMapMediator.GO_SUBLAYER, Context.New({
			mediator = MallOrderMediator,
			viewComponent = MallOrderLayer,
			data = {
				onExit = function()
					arg_2_0:UpdateOrderTip()

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiSummaryBtn, function()
		arg_2_0:ShowSummaryBox()

		return
	end, SFX_PANEL)

	arg_2_0.pointUIList = UIItemList.New(arg_2_0.uiContentTF, arg_2_0.uiContentTF:Find("tpl"))

	arg_2_0.pointUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_2_0:UpdatePointTpl(arg_11_1, arg_11_2)
		end

		return
	end)

	arg_2_0.siteBox = MallSiteBox.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.summaryBox = MallSummaryBox.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)

	setText(arg_2_0.uiTitleText, i18n("mall_title"))
	setText(arg_2_0.uiTitleEnText, i18n("mall_title_en"))

	return
end

function var_0_0.didEnter(arg_12_0)
	arg_12_0:UpdateData()
	arg_12_0:UpdateView()
	arg_12_0:UpdateBg()
	arg_12_0:CheckGuide()
	arg_12_0:CheckOrderStory()

	return
end

function var_0_0.CheckGuide(arg_13_0)
	if not pg.NewStoryMgr.GetInstance():IsPlayed("MALL_GUIDE") then
		pg.NewGuideMgr.GetInstance():Play("MALL_GUIDE")
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "MALL_GUIDE"
		})

		return
	end

	local var_13_0 = pg.NewStoryMgr.GetInstance()

	if not var_13_0:IsPlayed("MALL_GUIDE_2") then
		pg.NewGuideMgr.GetInstance():Play("MALL_GUIDE_2")
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "MALL_GUIDE_2"
		})

		return
	end

	return
end

function var_0_0.CheckOrderStory(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs((arg_14_0.activity:GetOrderData():GetFinishedList())) do
		if pg.activity_mall_custom_order[iter_14_1].story_unlock ~= "" then
			local var_14_0 = pg.NewStoryMgr.GetInstance()

			if not var_14_0:IsPlayed(pg.activity_mall_custom_order[iter_14_1].story_unlock) then
				table.insert({}, pg.activity_mall_custom_order[iter_14_1].story_unlock)
			end
		end
	end

	if #{} > 0 then
		for iter_14_2, iter_14_3 in ipairs({}) do
			table.insert({}, function(arg_15_0)
				pg.NewStoryMgr.GetInstance():Play(iter_14_3, arg_15_0)

				return
			end)
		end

		seriesAsync({}, function()
			return
		end)
	end

	return
end

function var_0_0.UpdateData(arg_17_0)
	arg_17_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	local var_17_0 = arg_17_0.activity and not arg_17_0.activity:isEnd()

	assert(var_17_0, "not exist mall act, type: " .. ActivityConst.ACTIVITY_TYPE_MALL)

	arg_17_0.triggeredIds = arg_17_0.activity:GetTriggeredPointIds()
	arg_17_0.showPointIds = {}

	for iter_17_0, iter_17_1 in pairs((arg_17_0.activity:GetLevelData():GetUnlockStoryIdsByType())) do
		local var_17_1 = iter_17_0 ~= MallActivity.POINT_TYPE.SITE
		local var_17_2 = underscore.detect(iter_17_1, function(arg_18_0)
			local var_18_0 = table.contains(arg_17_0.triggeredIds, arg_18_0) and var_17_1 and (pg.activity_mall_story[arg_18_0].lua ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_mall_story[arg_18_0].lua) or false) or true

			return var_18_0
		end)

		if var_17_2 then
			table.insert(arg_17_0.showPointIds, var_17_2)
		end
	end

	arg_17_0.bgConfig = arg_17_0.activity:getConfig("config_client").bg_switch

	return
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.pointUIList:align(#arg_19_0.showPointIds)
	arg_19_0:UpdateOrderBtn()
	arg_19_0:UpdateTips()

	return
end

function var_0_0.UpdateBg(arg_20_0)
	local var_20_0 = arg_20_0:GetCurBg()

	if var_20_0 then
		setImageSprite(arg_20_0.uiBgTF, LoadSprite("bg/" .. var_20_0), false)
	end

	return
end

function var_0_0.GetCurBg(arg_21_0)
	for iter_21_0 = #arg_21_0.bgConfig, 1, -1 do
		local var_21_0 = pg.NewStoryMgr.GetInstance()

		if var_21_0:IsPlayed(arg_21_0.bgConfig[iter_21_0][1]) then
			return arg_21_0.bgConfig[iter_21_0][2]
		end
	end

	return nil
end

function var_0_0.UpdateOrderBtn(arg_22_0)
	setActive(arg_22_0.uiOrderTimeTF, false)

	arg_22_0.orderData = arg_22_0.activity:GetOrderData()

	if arg_22_0.orderData.id ~= 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < arg_22_0.orderData:GetEndTime() then
			setActive(arg_22_0.uiOrderTimeTF, true)
			arg_22_0:StartTimer()
		end
	else
		arg_22_0:StopTimer()
	end

	return
end

function var_0_0.UpdateTips(arg_23_0)
	setActive(arg_23_0.uiMallTip, var_0_0.IsMallTip())
	arg_23_0:UpdateOrderTip()

	return
end

function var_0_0.UpdateOrderTip(arg_24_0)
	setActive(arg_24_0.uiOrderTip, MallScene.IsOrderTip())

	return
end

function var_0_0.UpdatePointTpl(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.showPointIds[arg_25_1 + 1]

	arg_25_2.name = arg_25_0.showPointIds[arg_25_1 + 1]

	local var_25_1 = pg.activity_mall_story[arg_25_0.showPointIds[arg_25_1 + 1]]

	setAnchoredPosition(arg_25_2, {
		x = pg.activity_mall_story[arg_25_0.showPointIds[arg_25_1 + 1]].posion[1],
		y = pg.activity_mall_story[arg_25_0.showPointIds[arg_25_1 + 1]].posion[2]
	})

	local var_25_2 = var_25_1.type
	local var_25_3 = var_0_0.TYPE2INFOS[var_25_1.type]

	GetImageSpriteFromAtlasAsync("ui/mallmapui_atlas", var_0_0.TYPE2INFOS[var_25_1.type][1], arg_25_2:Find("name"), true)
	setText(arg_25_2:Find("name/Text"), var_25_3[2])

	local var_25_4 = var_25_2 == MallActivity.POINT_TYPE.INTERACT_STORY

	setActive(arg_25_2:Find("ship"), var_25_2 == MallActivity.POINT_TYPE.INTERACT_STORY)
	setActive(arg_25_2:Find("icon"), not var_25_4)

	if var_25_4 then
		GetImageSpriteFromAtlasAsync(var_25_1.icon, "", arg_25_2:Find("ship"))
	else
		GetImageSpriteFromAtlasAsync("ui/mallmapui_atlas", var_25_3[3], arg_25_2:Find("icon"), true)
	end

	onButton(arg_25_0, arg_25_2, function()
		if not table.contains(arg_25_0.triggeredIds, var_25_0) then
			arg_25_0:emit(MallMapMediator.TRIGGER_POINT, arg_25_0.activity.id, var_25_0)
		end

		if var_25_2 == MallActivity.POINT_TYPE.SITE then
			arg_25_0.siteBox:ExecuteAction("Show", var_25_0)
		else
			pg.NewStoryMgr.GetInstance():Play(var_25_1.lua, function()
				arg_25_0:didEnter()

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.StartTimer(arg_28_0)
	arg_28_0:StopTimer()

	arg_28_0.orderEndTime = arg_28_0.orderData:GetEndTime()
	arg_28_0.timer = Timer.New(function()
		local var_29_0 = arg_28_0.orderEndTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_28_0.uiOrderTimeTF:Find("Text"), pg.TimeMgr.GetInstance():DescCDTime(var_29_0))

		if var_29_0 <= 0 then
			arg_28_0:UpdateOrderBtn()
			setActive(arg_28_0.uiOrderTip, true)
		end

		return
	end, 1, -1)

	arg_28_0.timer:Start()
	arg_28_0.timer.func()

	return
end

function var_0_0.StopTimer(arg_30_0)
	if arg_30_0.timer then
		arg_30_0.timer:Stop()

		arg_30_0.timer = nil
	end

	return
end

function var_0_0.ShowSummaryBox(arg_31_0)
	arg_31_0.summaryBox:ExecuteAction("Show")

	return
end

function var_0_0.onBackPressed(arg_32_0)
	if arg_32_0.siteBox and arg_32_0.siteBox:isShowing() then
		arg_32_0.siteBox:ExecuteAction("Hide")

		return
	end

	if arg_32_0.summaryBox and arg_32_0.summaryBox:isShowing() then
		arg_32_0.summaryBox:ExecuteAction("Hide")

		return
	end

	var_0_0.super.onBackPressed(arg_32_0)

	return
end

function var_0_0.willExit(arg_33_0)
	if arg_33_0.siteBox then
		arg_33_0.siteBox:Destroy()

		arg_33_0.siteBox = nil
	end

	if arg_33_0.summaryBox then
		arg_33_0.summaryBox:Destroy()

		arg_33_0.summaryBox = nil
	end

	arg_33_0:StopTimer()

	return
end

function var_0_0.IsMallTip()
	return MallScene.IsAwardTip() or MallScene.IsOrderTip()
end

function var_0_0.IsEntranceTip()
	local var_35_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_35_0 or var_35_0:isEnd() then
		return false
	end

	return MallScene.IsMapTip() or var_0_0.IsMallTip()
end

return var_0_0
