local var_0_0 = class("BuildShipScene", import("...base.BaseUI"))

var_0_0.PAGE_BUILD = 1
var_0_0.PAGE_QUEUE = 2
var_0_0.PAGE_SUPPORT = 3
var_0_0.PAGE_UNSEAM = 4
var_0_0.PAGE_PRAY = 5
var_0_0.PAGE_NEWSERVER = 6
var_0_0.PROJECTS = {
	SPECIAL = "special",
	ACTIVITY = "new",
	HEAVY = "heavy",
	LIGHT = "light"
}

function var_0_0.getUIName(arg_1_0)
	return "BuildShipUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.setPools(arg_3_0, arg_3_1)
	arg_3_0.pools = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0.pools, iter_3_1)
	end

	return
end

function var_0_0.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.contextData.player = arg_4_1

	return
end

function var_0_0.setUseItem(arg_5_0, arg_5_1)
	arg_5_0.contextData.itemVO = arg_5_1 or Item.New({
		count = 0,
		id = pg.ship_data_create_material[1].use_item
	})

	if arg_5_0.poolsPage and arg_5_0.poolsPage:GetLoaded() then
		arg_5_0.poolsPage:UpdateItem(arg_5_0.contextData.itemVO.count)
	end

	return
end

function var_0_0.setStartCount(arg_6_0, arg_6_1)
	arg_6_0.contextData.startCount = arg_6_1

	return
end

function var_0_0.setFlagShip(arg_7_0, arg_7_1)
	arg_7_0.contextData.falgShip = arg_7_1

	return
end

function var_0_0.RefreshActivityBuildPool(arg_8_0, arg_8_1)
	arg_8_0.poolsPage:RefreshActivityBuildPool(arg_8_1)

	return
end

function var_0_0.RefreshFreeBuildActivity(arg_9_0)
	arg_9_0.poolsPage:RefreshFreeBuildActivity()
	arg_9_0.poolsPage:UpdateTicket()

	return
end

function var_0_0.RefreshRegularExchangeCount(arg_10_0)
	arg_10_0.poolsPage:RefreshRegularExchangeCount()

	return
end

function var_0_0.init(arg_11_0)
	Input.multiTouchEnabled = false
	arg_11_0.blurPanel = arg_11_0._tf:Find("blur_panel")
	arg_11_0.topPanel = arg_11_0.blurPanel:Find("adapt/top")
	arg_11_0.backBtn = arg_11_0.topPanel:Find("back_btn")
	arg_11_0.toggles = {
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/build_btn"),
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/queue_btn"),
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/support_btn"),
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/unseam_btn"),
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/pray_btn"),
		arg_11_0.blurPanel:Find("adapt/left_length/frame/tagRoot/other_build_btn")
	}
	arg_11_0.tip = arg_11_0.toggles[2]:Find("tip")
	arg_11_0.contextData.msgbox = BuildShipMsgBox.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.contextData.helpWindow = BuildShipHelpWindow.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.poolsPage = BuildShipPoolsPage.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)
	arg_11_0.supportShipPoolPage = SupportShipPoolPage.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)

	return
end

function var_0_0.didEnter(arg_12_0)
	arg_12_0:OverlayPanel(arg_12_0.blurPanel)
	onButton(arg_12_0, arg_12_0.backBtn, function()
		arg_12_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)

	local var_12_0 = arg_12_0.blurPanel:Find("adapt/left_length/stamp")

	setActive(var_12_0, getProxy(TaskProxy):mingshiTouchFlagEnabled())
	onButton(arg_12_0, var_12_0, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(11)

		return
	end, SFX_CONFIRM)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.toggles) do
		onToggle(arg_12_0, iter_12_1, function(arg_15_0)
			arg_12_0:switchPage(iter_12_0, arg_15_0)

			return
		end, SFX_PANEL)
	end

	local var_12_1 = getProxy(ActivityProxy)
	local var_12_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_PRAY_POOL)

	if var_12_2 and not var_12_2:isEnd() then
		setActive(arg_12_0.toggles[var_0_0.PAGE_PRAY], true)
	else
		setActive(arg_12_0.toggles[var_0_0.PAGE_PRAY], false)
	end

	if underscore.any(arg_12_0.pools, function(arg_16_0)
		return checkExist(var_12_1:getBuildPoolActivity(arg_16_0), {
			"getConfig",
			{
				"type"
			}
		}) == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
	end) then
		setActive(arg_12_0.toggles[var_0_0.PAGE_NEWSERVER], true)
	else
		setActive(arg_12_0.toggles[var_0_0.PAGE_NEWSERVER], false)
	end

	local var_12_3 = arg_12_0.contextData.page

	if not arg_12_0.contextData.page then
		if pg.SeriesGuideMgr.GetInstance():isRunning() then
			var_12_3 = var_0_0.PAGE_BUILD or var_0_0.PAGE_NEWSERVER

			if not isActive(arg_12_0.toggles[var_12_3]) then
				var_12_3 = var_0_0.PAGE_BUILD
			end

			triggerToggle(arg_12_0.toggles[var_12_3], true)
			PoolMgr.GetInstance():GetUI("al_bg01", true, function(arg_17_0)
				arg_17_0:SetActive(true)
				setParent(arg_17_0, arg_12_0._tf)
				arg_17_0.transform:SetAsFirstSibling()

				return
			end)
			TagTipHelper.SetFreeBuildMark()

			arg_12_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_12_0, arg_12_0.blurPanel)

			return
		end
	end
end

function var_0_0.checkPage(arg_18_0)
	if arg_18_0.contextData.msgbox and arg_18_0.contextData.msgbox:GetLoaded() and arg_18_0.contextData.msgbox:isShowing() then
		arg_18_0.contextData.msgbox:Hide()
	end

	if arg_18_0.contextData.helpWindow and arg_18_0.contextData.helpWindow:GetLoaded() and arg_18_0.contextData.helpWindow:isShowing() then
		arg_18_0.contextData.helpWindow:Hide()
	end

	local var_18_0 = getProxy(ActivityProxy)

	if underscore.any(arg_18_0.pools, function(arg_19_0)
		return checkExist(var_18_0:getBuildPoolActivity(arg_19_0), {
			"getConfig",
			{
				"type"
			}
		}) == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
	end) then
		setActive(arg_18_0.toggles[var_0_0.PAGE_NEWSERVER], true)
	else
		setActive(arg_18_0.toggles[var_0_0.PAGE_NEWSERVER], false)
	end

	if not isActive(arg_18_0.toggles[var_0_0.PAGE_NEWSERVER]) and arg_18_0.contextData.page == var_0_0.PAGE_NEWSERVER then
		triggerToggle(arg_18_0.toggles[var_0_0.PAGE_BUILD], true)
	else
		arg_18_0.poolsPage:Flush(arg_18_0.pools)
	end

	return
end

function var_0_0.switchPage(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		local var_20_0 = arg_20_0.contextData

		if arg_20_1 == var_0_0.PAGE_UNSEAM then
			var_20_0.page = var_0_0.PAGE_BUILD or arg_20_1

			if arg_20_1 == var_0_0.PAGE_UNSEAM then
				if arg_20_2 then
					arg_20_0:emit(BuildShipMediator.OPEN_DESTROY)
				end
			elseif arg_20_1 == var_0_0.PAGE_QUEUE then
				if arg_20_2 then
					arg_20_0:emit(BuildShipMediator.OPEN_PROJECT_LIST)
				else
					arg_20_0:emit(BuildShipMediator.REMOVE_PROJECT_LIST)
				end
			elseif arg_20_1 == var_0_0.PAGE_SUPPORT then
				arg_20_0.supportShipPoolPage:ExecuteAction("ShowOrHide", arg_20_2)

				if arg_20_2 then
					arg_20_0.supportShipPoolPage:ExecuteAction("Flush")
				end
			elseif arg_20_1 == var_0_0.PAGE_BUILD then
				arg_20_0.poolsPage:ExecuteAction("ShowOrHide", arg_20_2)

				if arg_20_2 then
					arg_20_0.poolsPage:ExecuteAction("Flush", arg_20_0.pools, false)
				end
			elseif arg_20_1 == var_0_0.PAGE_NEWSERVER then
				arg_20_0.poolsPage:ExecuteAction("ShowOrHide", arg_20_2)

				if arg_20_2 then
					arg_20_0.poolsPage:ExecuteAction("Flush", arg_20_0.pools, true)
				end
			elseif arg_20_1 == var_0_0.PAGE_PRAY then
				if arg_20_2 then
					arg_20_0:emit(BuildShipMediator.OPEN_PRAY_PAGE)
				else
					arg_20_0:emit(BuildShipMediator.CLOSE_PRAY_PAGE)
				end
			end

			return
		end
	end
end

function var_0_0.updateQueueTip(arg_21_0, arg_21_1)
	setActive(arg_21_0.tip, arg_21_1 > 0)

	return
end

function var_0_0.onBackPressed(arg_22_0)
	if arg_22_0.contextData.helpWindow:GetLoaded() and arg_22_0.contextData.helpWindow:isShowing() then
		arg_22_0.contextData.helpWindow:Hide()

		return
	end

	if arg_22_0.contextData.msgbox:GetLoaded() and arg_22_0.contextData.msgbox:isShowing() then
		arg_22_0.contextData.msgbox:Hide()

		return
	end

	arg_22_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

function var_0_0.willExit(arg_23_0)
	Input.multiTouchEnabled = true

	arg_23_0.contextData.msgbox:Destroy()
	arg_23_0.contextData.helpWindow:Destroy()
	arg_23_0.poolsPage:Destroy()
	arg_23_0.supportShipPoolPage:Destroy()
	arg_23_0:UnOverlayPanel(arg_23_0.blurPanel, arg_23_0._tf)

	return
end

return var_0_0
