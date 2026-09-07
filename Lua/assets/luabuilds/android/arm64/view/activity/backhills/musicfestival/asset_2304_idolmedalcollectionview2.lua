local IdolMedalCollectionView2 = class("IdolMedalCollectionView2", import("view.base.BaseUI"))

function IdolMedalCollectionView2:GetContainerPositions()
	return {
		32.4,
		132.7
	}
end

function IdolMedalCollectionView2:GetActivityID()
	return ActivityConst.MUSIC_FESTIVAL_MEDALCOLLECTION_2020
end

function IdolMedalCollectionView2:getUIName()
	return "IdolMedalCollectionUI2"
end

function IdolMedalCollectionView2:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function IdolMedalCollectionView2:didEnter()
	self:checkAward()
	self:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function IdolMedalCollectionView2:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function IdolMedalCollectionView2:initData()
	self.activityProxy = getProxy(ActivityProxy)
	self.activityData = self.activityProxy:getActivityById(self:GetActivityID())
	self.allIDList = self.activityData:GetPicturePuzzleIds()
	self.activatableIDList = self.activityData.data1_list
	self.activeIDList = self.activityData.data2_list

	return
end

local var_0_1 = {}

function IdolMedalCollectionView2:findUI()
	self.bg = self._tf:Find("BG")

	local var_8_0 = self._tf:Find("NotchAdapt")

	self.backBtn = var_8_0:Find("BackBtn")
	self.progressText = var_8_0:Find("ProgressText")
	self.helpBtn = var_8_0:Find("HelpBtn")
	self.top = var_8_0

	local var_8_1 = self._tf:Find("MedalContainer")

	self.medalContainer = var_8_1
	self.buttonNext = var_8_1:Find("ButtonNext")
	self.buttonNextLocked = var_8_1:Find("ButtonNextLocked")
	self.buttonPrev = var_8_1:Find("ButtonPrev")
	self.buttonShare = var_8_1:Find("ButtonShare")
	self.buttonReset = var_8_1:Find("ButtonReset")
	self.pageCollection = var_8_1:Find("PageCollection")
	self.pageModified = var_8_1:Find("PageModified")
	self.OverlayPanel = var_8_1:Find("Overlay")
	self.pages = {
		self.pageCollection,
		self.pageModified
	}
	self.pageIndex = 1
	self.medalItemList = {}

	for iter_8_0 = 1, #self.allIDList do
		table.insert(self.medalItemList, self.pageCollection:Find("Images/Medal" .. iter_8_0))
	end

	self.medalTextList = {}

	for iter_8_1 = 1, #self.allIDList do
		table.insert(self.medalTextList, self.pageCollection:Find("Texts/Medal" .. iter_8_1))
	end

	self.selectPanel = var_8_1:Find("SelectPanel")
	self.selectPanelContainer = self.selectPanel:Find("Scroll/Container")
	self.allItems = {}
	self.selectedPositionsInPanels = {}
	self.listStayInPanel = {}
	self.listShowOnPanel = {}
	self.overlayingImage = nil

	for iter_8_2 = 0, self.selectPanelContainer.childCount - 1 do
		local var_8_2 = self.selectPanelContainer:GetChild(iter_8_2)

		self.selectedPositionsInPanels[var_8_2] = var_8_2.anchoredPosition

		table.insert(self.listStayInPanel, var_8_2)
		table.insert(self.allItems, var_8_2)
	end

	for iter_8_3, iter_8_4 in pairs(var_0_1) do
		setParent(self.allItems[iter_8_3], self.pageModified)
		table.removebyvalue(self.listStayInPanel, self.allItems[iter_8_3])
		table.insert(self.listShowOnPanel, self.allItems[iter_8_3])
		setAnchoredPosition(self.allItems[iter_8_3], iter_8_4)
	end

	setText(self.pageModified:Find("TextTip"), i18n("collect_idol_tip"))
	self:AddLeanTween(function()
		return LeanTween.alphaText(rtf(self.pageModified:Find("TextTip")), 1, 2):setFrom(0):setLoopPingPong()
	end)

	return
end

function IdolMedalCollectionView2:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_collection.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self:SwitchSelectedImage(nil)

		return
	end)
	onButton(self, self.selectPanelContainer, function()
		self:SwitchSelectedImage(nil)

		return
	end)
	onButton(self, self.buttonNext, function()
		self:SwitchPage(1)

		return
	end, SFX_PANEL)
	onButton(self, self.buttonNextLocked, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("hand_account_tip"))

		return
	end, SFX_PANEL)
	onButton(self, self.buttonPrev, function()
		self:SwitchPage(-1)

		return
	end, SFX_PANEL)
	onButton(self, self.buttonReset, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("hand_account_resetting_tip"),
			onYes = function()
				self:ResetPanel()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buttonShare, function()
		setAnchoredPosition(self.medalContainer, {
			x = self:GetContainerPositions()[1]
		})
		setActive(self.selectPanel, false)
		setActive(self.buttonNext, false)
		setActive(self.buttonNextLocked, false)
		setActive(self.buttonPrev, false)
		setActive(self.buttonShare, false)
		setActive(self.buttonReset, false)
		setActive(self.top, false)
		setActive(self.pageModified:Find("TextTip"), false)
		self:SwitchSelectedImage(nil)
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePoraisMedals)
		setActive(self.top, true)
		setActive(self.pageModified:Find("TextTip"), true)
		self:SwitchSelectedImage(self.lastSelectedImage)
		self:UpdateView()

		return
	end, SFX_PANEL)

	local var_10_0 = GameObject.Find("OverlayCamera"):GetComponent("Camera")

	for iter_10_0, iter_10_1 in ipairs(self.allItems) do
		local var_10_1 = self.selectedPositionsInPanels[iter_10_1]

		setActive(iter_10_1:Find("Selected"), false)

		local var_10_2 = GetOrAddComponent(iter_10_1, "EventTriggerListener")

		local function var_10_3()
			if not self.overlayingImage then
				return
			end

			local var_21_0 = self.overlayingImage

			self.overlayingImage = nil

			for iter_21_0, iter_21_1 in ipairs(self.listStayInPanel) do
				if iter_21_1 == var_21_0 then
					setParent(var_21_0, self.selectPanelContainer)
					setAnchoredPosition(var_21_0, self.selectedPositionsInPanels[var_21_0])

					return
				end
			end

			for iter_21_2, iter_21_3 in ipairs(self.listShowOnPanel) do
				if iter_21_3 == var_21_0 then
					setParent(var_21_0, self.pageModified)
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

			if self.lastSelectedImage == iter_10_1 then
				self:SwitchSelectedImage(nil)
			else
				self:SwitchSelectedImage(iter_10_1)
				iter_10_1:SetAsLastSibling()
			end

			return
		end)
		var_10_2:AddBeginDragFunc(function(arg_23_0, arg_23_1)
			var_10_4 = arg_23_1.position

			var_10_3()
			setParent(iter_10_1, self.OverlayPanel)

			self.overlayingImage = iter_10_1

			self:SwitchSelectedImage(iter_10_1)

			return
		end)
		var_10_2:AddDragFunc(function(arg_24_0, arg_24_1)
			setAnchoredPosition(iter_10_1, (LuaHelper.ScreenToLocal(rtf(self.OverlayPanel), arg_24_1.position, var_10_0)))

			return
		end)
		var_10_2:AddDragEndFunc(function(arg_25_0, arg_25_1)
			var_10_4 = nil

			if var_10_4 and var_10_4:Sub(arg_25_1.position):SqrMagnitude() < 1 then
				var_10_3()

				return
			end

			local var_25_1 = LuaHelper.ScreenToLocal(rtf(self.pageModified), arg_25_1.position, var_10_0)

			if not rtf(self.pageModified).rect:Contains(var_25_1) then
				setParent(iter_10_1, self.selectPanelContainer)
				table.removebyvalue(self.listStayInPanel, iter_10_1)
				table.removebyvalue(self.listShowOnPanel, iter_10_1)
				table.insert(self.listStayInPanel, iter_10_1)

				var_0_1[iter_10_0] = nil

				setAnchoredPosition(iter_10_1, var_10_1)
				iter_10_1:SetAsLastSibling()
			else
				setParent(iter_10_1, self.pageModified)
				table.removebyvalue(self.listStayInPanel, iter_10_1)
				table.removebyvalue(self.listShowOnPanel, iter_10_1)
				table.insert(self.listShowOnPanel, iter_10_1)

				var_0_1[iter_10_0] = var_25_1

				setAnchoredPosition(iter_10_1, var_25_1)
				iter_10_1:SetAsLastSibling()
			end

			self.overlayingImage = nil

			return
		end)
	end

	return
end

function IdolMedalCollectionView2:SwitchSelectedImage(arg_26_1)
	if self.lastSelectedImage == arg_26_1 then
		return
	end

	if self.lastSelectedImage then
		setActive(self.lastSelectedImage:Find("Selected"), false)
	end

	self.lastSelectedImage = arg_26_1

	if arg_26_1 then
		setActive(arg_26_1:Find("Selected"), true)
	end

	return
end

function IdolMedalCollectionView2:ResetPanel()
	for iter_27_0, iter_27_1 in ipairs(self.listShowOnPanel) do
		table.insert(self.listStayInPanel, iter_27_1)
		setParent(iter_27_1, self.selectPanelContainer)
		setAnchoredPosition(iter_27_1, self.selectedPositionsInPanels[iter_27_1] or Vector2.zero)
	end

	table.clean(self.listShowOnPanel)
	table.clear(var_0_1)

	return
end

function IdolMedalCollectionView2:UpdateView()
	if self.pageIndex == 1 then
		self:updateMedalContainerView()
	end

	for iter_28_0 = 1, #self.pages do
		setActive(self.pages[iter_28_0], iter_28_0 == self.pageIndex)
	end

	setAnchoredPosition(self.medalContainer, {
		x = self:GetContainerPositions()[self.pageIndex]
	})
	setActive(self.selectPanel, self.pageIndex == 2)

	local var_28_0 = #self.activeIDList == #self.allIDList and self.activityData.data1 == 1

	setActive(self.buttonNext, #self.activeIDList == #self.allIDList and self.activityData.data1 == 1 and self.pageIndex == 1)
	setActive(self.buttonNextLocked, not var_28_0 and self.pageIndex == 1)
	setActive(self.buttonPrev, self.pageIndex == 2)
	setActive(self.buttonShare, self.pageIndex == 2)
	setActive(self.buttonReset, self.pageIndex == 2)
	setText(self.progressText, setColorStr(tostring(#self.activeIDList), COLOR_RED) .. "/" .. #self.allIDList)

	return
end

function IdolMedalCollectionView2:updateMedalContainerView()
	for iter_29_0, iter_29_1 in ipairs(self.allIDList) do
		self:updateMedalView(self.allIDList, iter_29_1)
	end

	return
end

function IdolMedalCollectionView2:updateMedalView(arg_30_1, arg_30_2)
	local var_30_0 = table.indexof(arg_30_1, arg_30_2, 1)
	local var_30_1 = table.contains(self.activeIDList, arg_30_2)
	local var_30_2 = table.contains(self.activatableIDList, arg_30_2) and not var_30_1
	local var_30_3 = not var_30_1 and not var_30_2
	local var_30_4 = self.medalItemList[var_30_0]
	local var_30_5 = self.medalTextList[var_30_0]:Find("Activable")
	local var_30_6 = self.medalTextList[var_30_0]:Find("DisActive")

	setImageAlpha(self.medalItemList[var_30_0], var_30_1 and 1 or 0)
	setActive(var_30_5, var_30_2)
	setActive(var_30_6, var_30_3)
	onButton(self, var_30_4, function()
		if not var_30_2 then
			return
		end

		pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
			id = arg_30_2,
			actId = self.activityData.id
		})

		return
	end, SFX_PANEL)
	setText(var_30_6, "")

	return
end

function IdolMedalCollectionView2:updateAfterSubmit()
	return
end

function IdolMedalCollectionView2:UpdateActivity()
	self:initData()
	self:checkAward()
	self:UpdateView()

	return
end

function IdolMedalCollectionView2:SwitchPage(arg_34_1)
	self.pageIndex = math.clamp(self.pageIndex + arg_34_1, 1, #self.pages)

	self:UpdateView()

	return
end

function IdolMedalCollectionView2:checkAward()
	if #self.activeIDList == #self.allIDList and self.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activityData.id
		})
	end

	return
end

return IdolMedalCollectionView2
