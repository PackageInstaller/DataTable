local var_0_0 = class("IdolMedalCollectionView2", import("view.base.BaseUI"))

function var_0_0.GetContainerPositions(arg_1_0)
	return {
		32.4,
		132.7
	}
end

function var_0_0.GetActivityID(arg_2_0)
	return ActivityConst.MUSIC_FESTIVAL_MEDALCOLLECTION_2020
end

function var_0_0.getUIName(arg_3_0)
	return "IdolMedalCollectionUI2"
end

function var_0_0.init(arg_4_0)
	arg_4_0:initData()
	arg_4_0:findUI()
	arg_4_0:addListener()

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:checkAward()
	arg_5_0:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(arg_5_0._tf)

	return
end

function var_0_0.willExit(arg_6_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf)

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.activityProxy = getProxy(ActivityProxy)
	arg_7_0.activityData = arg_7_0.activityProxy:getActivityById(arg_7_0:GetActivityID())
	arg_7_0.allIDList = arg_7_0.activityData:GetPicturePuzzleIds()
	arg_7_0.activatableIDList = arg_7_0.activityData.data1_list
	arg_7_0.activeIDList = arg_7_0.activityData.data2_list

	return
end

local var_0_1 = {}

function var_0_0.findUI(arg_8_0)
	arg_8_0.bg = arg_8_0._tf:Find("BG")

	local var_8_0 = arg_8_0._tf:Find("NotchAdapt")

	arg_8_0.backBtn = var_8_0:Find("BackBtn")
	arg_8_0.progressText = var_8_0:Find("ProgressText")
	arg_8_0.helpBtn = var_8_0:Find("HelpBtn")
	arg_8_0.top = var_8_0

	local var_8_1 = arg_8_0._tf:Find("MedalContainer")

	arg_8_0.medalContainer = var_8_1
	arg_8_0.buttonNext = var_8_1:Find("ButtonNext")
	arg_8_0.buttonNextLocked = var_8_1:Find("ButtonNextLocked")
	arg_8_0.buttonPrev = var_8_1:Find("ButtonPrev")
	arg_8_0.buttonShare = var_8_1:Find("ButtonShare")
	arg_8_0.buttonReset = var_8_1:Find("ButtonReset")
	arg_8_0.pageCollection = var_8_1:Find("PageCollection")
	arg_8_0.pageModified = var_8_1:Find("PageModified")
	arg_8_0.OverlayPanel = var_8_1:Find("Overlay")
	arg_8_0.pages = {
		arg_8_0.pageCollection,
		arg_8_0.pageModified
	}
	arg_8_0.pageIndex = 1
	arg_8_0.medalItemList = {}

	for iter_8_0 = 1, #arg_8_0.allIDList do
		table.insert(arg_8_0.medalItemList, arg_8_0.pageCollection:Find("Images/Medal" .. iter_8_0))
	end

	arg_8_0.medalTextList = {}

	for iter_8_1 = 1, #arg_8_0.allIDList do
		table.insert(arg_8_0.medalTextList, arg_8_0.pageCollection:Find("Texts/Medal" .. iter_8_1))
	end

	arg_8_0.selectPanel = var_8_1:Find("SelectPanel")
	arg_8_0.selectPanelContainer = arg_8_0.selectPanel:Find("Scroll/Container")
	arg_8_0.allItems = {}
	arg_8_0.selectedPositionsInPanels = {}
	arg_8_0.listStayInPanel = {}
	arg_8_0.listShowOnPanel = {}
	arg_8_0.overlayingImage = nil

	for iter_8_2 = 0, arg_8_0.selectPanelContainer.childCount - 1 do
		local var_8_2 = arg_8_0.selectPanelContainer:GetChild(iter_8_2)

		arg_8_0.selectedPositionsInPanels[var_8_2] = var_8_2.anchoredPosition

		table.insert(arg_8_0.listStayInPanel, var_8_2)
		table.insert(arg_8_0.allItems, var_8_2)
	end

	for iter_8_3, iter_8_4 in pairs(var_0_1) do
		setParent(arg_8_0.allItems[iter_8_3], arg_8_0.pageModified)
		table.removebyvalue(arg_8_0.listStayInPanel, arg_8_0.allItems[iter_8_3])
		table.insert(arg_8_0.listShowOnPanel, arg_8_0.allItems[iter_8_3])
		setAnchoredPosition(arg_8_0.allItems[iter_8_3], iter_8_4)
	end

	setText(arg_8_0.pageModified:Find("TextTip"), i18n("collect_idol_tip"))
	arg_8_0:AddLeanTween(function()
		return LeanTween.alphaText(rtf(arg_8_0.pageModified:Find("TextTip")), 1, 2):setFrom(0):setLoopPingPong()
	end)

	return
end

function var_0_0.addListener(arg_10_0)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_collection.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.bg, function()
		arg_10_0:SwitchSelectedImage(nil)

		return
	end)
	onButton(arg_10_0, arg_10_0.selectPanelContainer, function()
		arg_10_0:SwitchSelectedImage(nil)

		return
	end)
	onButton(arg_10_0, arg_10_0.buttonNext, function()
		arg_10_0:SwitchPage(1)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.buttonNextLocked, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("hand_account_tip"))

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.buttonPrev, function()
		arg_10_0:SwitchPage(-1)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.buttonReset, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("hand_account_resetting_tip"),
			onYes = function()
				arg_10_0:ResetPanel()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.buttonShare, function()
		setAnchoredPosition(arg_10_0.medalContainer, {
			x = arg_10_0:GetContainerPositions()[1]
		})
		setActive(arg_10_0.selectPanel, false)
		setActive(arg_10_0.buttonNext, false)
		setActive(arg_10_0.buttonNextLocked, false)
		setActive(arg_10_0.buttonPrev, false)
		setActive(arg_10_0.buttonShare, false)
		setActive(arg_10_0.buttonReset, false)
		setActive(arg_10_0.top, false)
		setActive(arg_10_0.pageModified:Find("TextTip"), false)
		arg_10_0:SwitchSelectedImage(nil)
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePoraisMedals)
		setActive(arg_10_0.top, true)
		setActive(arg_10_0.pageModified:Find("TextTip"), true)
		arg_10_0:SwitchSelectedImage(arg_10_0.lastSelectedImage)
		arg_10_0:UpdateView()

		return
	end, SFX_PANEL)

	local var_10_0 = GameObject.Find("OverlayCamera"):GetComponent("Camera")

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.allItems) do
		local var_10_1 = arg_10_0.selectedPositionsInPanels[iter_10_1]

		setActive(iter_10_1:Find("Selected"), false)

		local var_10_2 = GetOrAddComponent(iter_10_1, "EventTriggerListener")

		local function var_10_3()
			if not arg_10_0.overlayingImage then
				return
			end

			local var_21_0 = arg_10_0.overlayingImage

			arg_10_0.overlayingImage = nil

			for iter_21_0, iter_21_1 in ipairs(arg_10_0.listStayInPanel) do
				if iter_21_1 == var_21_0 then
					setParent(var_21_0, arg_10_0.selectPanelContainer)
					setAnchoredPosition(var_21_0, arg_10_0.selectedPositionsInPanels[var_21_0])

					return
				end
			end

			for iter_21_2, iter_21_3 in ipairs(arg_10_0.listShowOnPanel) do
				if iter_21_3 == var_21_0 then
					setParent(var_21_0, arg_10_0.pageModified)
					var_21_0:SetAsLastSibling()

					return
				end
			end

			return
		end

		local var_10_4

		var_10_2:AddPointClickFunc(function(arg_22_0, arg_22_1)
			if var_10_4 then
				return
			end

			if arg_10_0.lastSelectedImage == iter_10_1 then
				arg_10_0:SwitchSelectedImage(nil)
			else
				arg_10_0:SwitchSelectedImage(iter_10_1)
				iter_10_1:SetAsLastSibling()
			end

			return
		end)
		var_10_2:AddBeginDragFunc(function(arg_23_0, arg_23_1)
			var_10_4 = arg_23_1.position

			var_10_3()
			setParent(iter_10_1, arg_10_0.OverlayPanel)

			arg_10_0.overlayingImage = iter_10_1

			arg_10_0:SwitchSelectedImage(iter_10_1)

			return
		end)
		var_10_2:AddDragFunc(function(arg_24_0, arg_24_1)
			setAnchoredPosition(iter_10_1, (LuaHelper.ScreenToLocal(rtf(arg_10_0.OverlayPanel), arg_24_1.position, var_10_0)))

			return
		end)
		var_10_2:AddDragEndFunc(function(arg_25_0, arg_25_1)
			local var_25_0 = var_10_4 and var_10_4:Sub(arg_25_1.position):SqrMagnitude() < 1

			var_10_4 = nil

			if var_25_0 then
				var_10_3()

				return
			end

			local var_25_1 = LuaHelper.ScreenToLocal(rtf(arg_10_0.pageModified), arg_25_1.position, var_10_0)

			if not rtf(arg_10_0.pageModified).rect:Contains(var_25_1) then
				setParent(iter_10_1, arg_10_0.selectPanelContainer)
				table.removebyvalue(arg_10_0.listStayInPanel, iter_10_1)
				table.removebyvalue(arg_10_0.listShowOnPanel, iter_10_1)
				table.insert(arg_10_0.listStayInPanel, iter_10_1)

				var_0_1[iter_10_0] = nil

				setAnchoredPosition(iter_10_1, var_10_1)
				iter_10_1:SetAsLastSibling()
			else
				setParent(iter_10_1, arg_10_0.pageModified)
				table.removebyvalue(arg_10_0.listStayInPanel, iter_10_1)
				table.removebyvalue(arg_10_0.listShowOnPanel, iter_10_1)
				table.insert(arg_10_0.listShowOnPanel, iter_10_1)

				var_0_1[iter_10_0] = var_25_1

				setAnchoredPosition(iter_10_1, var_25_1)
				iter_10_1:SetAsLastSibling()
			end

			arg_10_0.overlayingImage = nil

			return
		end)
	end

	return
end

function var_0_0.SwitchSelectedImage(arg_26_0, arg_26_1)
	if arg_26_0.lastSelectedImage == arg_26_1 then
		return
	end

	if arg_26_0.lastSelectedImage then
		setActive(arg_26_0.lastSelectedImage:Find("Selected"), false)
	end

	arg_26_0.lastSelectedImage = arg_26_1

	if arg_26_1 then
		setActive(arg_26_1:Find("Selected"), true)
	end

	return
end

function var_0_0.ResetPanel(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.listShowOnPanel) do
		table.insert(arg_27_0.listStayInPanel, iter_27_1)
		setParent(iter_27_1, arg_27_0.selectPanelContainer)

		local var_27_0 = arg_27_0.selectedPositionsInPanels[iter_27_1] or Vector2.zero

		setAnchoredPosition(iter_27_1, var_27_0)
	end

	table.clean(arg_27_0.listShowOnPanel)
	table.clear(var_0_1)

	return
end

function var_0_0.UpdateView(arg_28_0)
	if arg_28_0.pageIndex == 1 then
		arg_28_0:updateMedalContainerView()
	end

	for iter_28_0 = 1, #arg_28_0.pages do
		setActive(arg_28_0.pages[iter_28_0], iter_28_0 == arg_28_0.pageIndex)
	end

	setAnchoredPosition(arg_28_0.medalContainer, {
		x = arg_28_0:GetContainerPositions()[arg_28_0.pageIndex]
	})
	setActive(arg_28_0.selectPanel, arg_28_0.pageIndex == 2)

	local var_28_0 = #arg_28_0.activeIDList == #arg_28_0.allIDList and arg_28_0.activityData.data1 == 1

	setActive(arg_28_0.buttonNext, #arg_28_0.activeIDList == #arg_28_0.allIDList and arg_28_0.activityData.data1 == 1 and arg_28_0.pageIndex == 1)
	setActive(arg_28_0.buttonNextLocked, not var_28_0 and arg_28_0.pageIndex == 1)
	setActive(arg_28_0.buttonPrev, arg_28_0.pageIndex == 2)
	setActive(arg_28_0.buttonShare, arg_28_0.pageIndex == 2)
	setActive(arg_28_0.buttonReset, arg_28_0.pageIndex == 2)
	setText(arg_28_0.progressText, setColorStr(tostring(#arg_28_0.activeIDList), COLOR_RED) .. "/" .. #arg_28_0.allIDList)

	return
end

function var_0_0.updateMedalContainerView(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.allIDList) do
		arg_29_0:updateMedalView(arg_29_0.allIDList, iter_29_1)
	end

	return
end

function var_0_0.updateMedalView(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = table.indexof(arg_30_1, arg_30_2, 1)
	local var_30_1 = table.contains(arg_30_0.activeIDList, arg_30_2)
	local var_30_2 = table.contains(arg_30_0.activatableIDList, arg_30_2) and not var_30_1
	local var_30_3 = not var_30_1 and not var_30_2
	local var_30_4 = arg_30_0.medalItemList[var_30_0]
	local var_30_5 = arg_30_0.medalTextList[var_30_0]:Find("Activable")
	local var_30_6 = arg_30_0.medalTextList[var_30_0]:Find("DisActive")

	setImageAlpha(arg_30_0.medalItemList[var_30_0], var_30_1 and 1 or 0)
	setActive(var_30_5, var_30_2)
	setActive(var_30_6, var_30_3)
	onButton(arg_30_0, var_30_4, function()
		if not var_30_2 then
			return
		end

		pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
			id = arg_30_2,
			actId = arg_30_0.activityData.id
		})

		return
	end, SFX_PANEL)
	setText(var_30_6, "")

	return
end

function var_0_0.updateAfterSubmit(arg_32_0)
	return
end

function var_0_0.UpdateActivity(arg_33_0)
	arg_33_0:initData()
	arg_33_0:checkAward()
	arg_33_0:UpdateView()

	return
end

function var_0_0.SwitchPage(arg_34_0, arg_34_1)
	arg_34_0.pageIndex = math.clamp(arg_34_0.pageIndex + arg_34_1, 1, #arg_34_0.pages)

	arg_34_0:UpdateView()

	return
end

function var_0_0.checkAward(arg_35_0)
	if #arg_35_0.activeIDList == #arg_35_0.allIDList and arg_35_0.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_35_0.activityData.id
		})
	end

	return
end

return var_0_0
