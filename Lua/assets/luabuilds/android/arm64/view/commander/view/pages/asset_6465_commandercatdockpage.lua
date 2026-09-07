local CommanderCatDockPage = class("CommanderCatDockPage", import("view.base.BaseSubView"))

CommanderCatDockPage.ON_SORT = "CommanderCatDockPage:ON_SORT"

function CommanderCatDockPage:getUIName()
	return "CommanderCatDockui"
end

function CommanderCatDockPage:OnLoaded()
	self.scrollRect = self._tf:Find("frame"):GetComponent("LScrollRect")
	self.reserveBtn = self._tf:Find("box/reserve_btn")
	self.reserveTxt = self.reserveBtn:Find("Text"):GetComponent(typeof(Text))
	self.reserveTip = self.reserveBtn:Find("free")
	self.homeBtn = self._tf:Find("box/home")
	self.homeTxt = self.homeBtn:Find("Text"):GetComponent(typeof(Text))
	self.homeTip = self.homeBtn:Find("tip")
	self.boxesBtn = self._tf:Find("box/boxes_btn")
	self.boxesTxt = self.boxesBtn:Find("Text"):GetComponent(typeof(Text))
	self.boxesTip = self.boxesBtn:Find("tip")
	self.capacityTxt = self._tf:Find("box/capcity/Text"):GetComponent(typeof(Text))
	self.sortBtn = self._tf:Find("top/sort_btn")
	self.sortIdTxt = self.sortBtn:Find("id")
	self.sortLvTxt = self.sortBtn:Find("Level")
	self.sortRarityTxt = self.sortBtn:Find("Rarity")
	self.ascBtn = self._tf:Find("top/asc_btn")
	self.ascTr = self.ascBtn:Find("asc")
	self.descTr = self.ascBtn:Find("desc")
	self.selectedTr = self._tf:Find("bottom")
	self.btnsTr = self._tf:Find("box")
	self.selectedNumTxt = self._tf:Find("bottom/value/Text"):GetComponent(typeof(Text))
	self.selectedBtn = self._tf:Find("bottom/select_btn")
	self.cancelBtn = self._tf:Find("bottom/cancel_btn")
	self.reservePanel = CommanderReservePage.New(self._tf.parent, self.event, self.contextData)
	self.boxesPanel = CommanderBoxesPage.New(self._tf.parent, self.event, self.contextData)
	self.indexPanel = CommanderIndexPage.New(self._tf, self.event)
	self.catterySettlementPage = CatterySettlementPage.New(self._tf, self.event)

	return
end

function CommanderCatDockPage:RegisterEvent()
	self:bind(CommanderCatDockPage.ON_SORT, function(arg_4_0)
		self:OnSort()

		return
	end)
	self:bind(CommanderCatScene.EVENT_NEXT_ONE, function(arg_5_0, arg_5_1)
		self:OnNextOn(arg_5_1, 1)

		return
	end)
	self:bind(CommanderCatScene.EVENT_PREV_ONE, function(arg_6_0, arg_6_1)
		self:OnNextOn(arg_6_1, -1)

		return
	end)
	self:bind(CommanderCatScene.MSG_UPDATE, function(arg_7_0)
		self:UpdateCommanders(true)
		self:UpdateCapacity()

		return
	end)
	self:bind(CommanderCatScene.MSG_HOME_TIP, function(arg_8_0)
		self:UpdateHome()

		return
	end)
	self:bind(CommanderCatScene.MSG_BUILD, function()
		self:UpdateBoxes()

		return
	end)
	self:bind(CommanderCatScene.MSG_RESERVE_BOX, function()
		self:UpdateReserve()

		return
	end)
	self:bind(CommanderCatScene.EVENT_FOLD, function(arg_11_0, arg_11_1)
		if arg_11_1 then
			LeanTween.moveX(rtf(self._tf), 1000, 0.5)
		else
			LeanTween.moveX(rtf(self._tf), -423, 0.5)
		end

		return
	end)

	return
end

function CommanderCatDockPage:OnNextOn(arg_12_1, arg_12_2)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(self.displays) do
		if iter_12_1.id == arg_12_1 then
			var_12_0 = iter_12_0

			break
		end
	end

	local var_12_1 = var_12_0 + arg_12_2

	if var_12_0 + arg_12_2 <= 0 or var_12_1 > #self.displays then
		return
	end

	local var_12_2 = false

	for iter_12_2, iter_12_3 in pairs(self.cards) do
		if iter_12_3.commanderVO and iter_12_3.commanderVO.id == self.displays[var_12_1].id then
			var_12_2 = true

			triggerButton(iter_12_3.infoTF)

			break
		end
	end

	if not var_12_2 then
		self:emit(CommanderCatScene.EVENT_SELECTED, self.displays[var_12_1])
	end

	return
end

function CommanderCatDockPage:OnSort()
	self.sortData = self.indexPanel.data
	self.sortData.asc = self.sortData.asc

	self:UpdateSortTxt()
	self:UpdateCommanders(false)
	setActive(self.ascTr, self.sortData.asc)
	setActive(self.descTr, not self.sortData.asc)

	return
end

function CommanderCatDockPage:UpdateSortTxt()
	setActive(self.sortIdTxt, self.sortData.sortData == "id")
	setActive(self.sortLvTxt, self.sortData.sortData == "Level")
	setActive(self.sortRarityTxt, self.sortData.sortData == "Rarity")

	return
end

function CommanderCatDockPage:OnInit()
	self.onCommander = self.contextData.onCommander or function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		return true
	end
	self.onSelected = self.contextData.onSelected or function(arg_17_0, arg_17_1)
		arg_17_1()

		return
	end
	self.onQuit = self.contextData.onQuit or function(arg_18_0)
		return
	end

	self:RegisterEvent()

	self.sortData = self.contextData.sortData or {
		asc = false,
		sortData = "Level",
		nationData = {},
		rarityData = {}
	}

	function self.scrollRect.onInitItem(arg_19_0)
		self:OnInitItem(arg_19_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_20_0, arg_20_1)
		self:OnUpdateItem(arg_20_0, arg_20_1)

		return
	end

	onButton(self, self.reserveBtn, function()
		self.reservePanel:ExecuteAction("Update")

		return
	end, SFX_PANEL)
	onButton(self, self.boxesBtn, function()
		self.boxesPanel:ExecuteAction("Update")

		return
	end, SFX_PANEL)
	onButton(self, self.ascBtn, function()
		self.sortData.asc = not self.sortData.asc

		setActive(self.ascTr, self.sortData.asc)
		setActive(self.descTr, not self.sortData.asc)
		self:UpdateCommanders(false)

		return
	end, SFX_PANEL)
	setActive(self.ascTr, self.sortData.asc)
	setActive(self.descTr, not self.sortData.asc)
	onButton(self, self.sortBtn, function()
		self.indexPanel:ExecuteAction("Show", self.sortData)

		return
	end, SFX_PANEL)
	onButton(self, self.selectedBtn, function()
		local var_25_0 = self.contextData.minCount or 1

		if var_25_0 > #self.selectedList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_select_min_cnt", var_25_0))

			return
		end

		self.onSelected(self.selectedList, function()
			self:emit(CommanderCatScene.EVENT_BACK)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:emit(CommanderCatScene.EVENT_BACK)

		return
	end, SFX_PANEL)

	if not LOCK_CATTERY then
		onButton(self, self.homeBtn, function()
			self:emit(CommanderCatMediator.OPEN_HOME)

			return
		end, SFX_PANEL)
	else
		setActive(self.homeBtn, false)
	end

	self:Flush()

	return
end

function CommanderCatDockPage:Flush()
	self.cards = {}
	self.selectedList = self.contextData.selectedIds or {}
	self.previewCommander = self.contextData.activeCommander
	self.previewCommanderId = self.previewCommander and self.previewCommander.id
	self.selectedId = self.previewCommanderId or self.contextData.selectedId

	self:UpdateCommanders(true)
	self:UpdateBoxes()
	self:UpdateReserve()
	self:UpdateCapacity()
	self:UpdateHome()
	self:TryPlayStory()
	self:DisplayCatterySettlement()
	self:UpdateStyle()
	self:UpdateSortTxt()

	return
end

function CommanderCatDockPage:Show()
	setActive(self._tf, true)
	CommanderCatUtil.SetActive(self._tf, true)

	return
end

function CommanderCatDockPage:Hide()
	CommanderCatUtil.SetActive(self._tf, false)

	return
end

function CommanderCatDockPage:UpdateStyle()
	setActive(self.selectedTr, self.contextData.mode == CommanderCatScene.MODE_SELECT)
	setActive(self.btnsTr, self.contextData.mode == CommanderCatScene.MODE_VIEW)

	if self.contextData.mode == CommanderCatScene.MODE_SELECT then
		self:UpdateSelectedTxt()
	end

	return
end

function CommanderCatDockPage:TryPlayStory()
	if self.contextData.fromMain then
		pg.SystemGuideMgr.GetInstance():PlayCommander()
	end

	return
end

function CommanderCatDockPage:DisplayCatterySettlement()
	local var_34_0 = getProxy(CommanderProxy)
	local var_34_1 = var_34_0:GetCommanderHome()
	local var_34_2 = self.contextData.fromMediatorName == NewMainMediator.__cname
	local var_34_3 = pg.NewStoryMgr.GetInstance().IsRunning(var_34_0)

	var_34_3 = var_34_3 or pg.NewGuideMgr.GetInstance():IsBusy()

	if var_34_1 and var_34_1:ShouldSettleCattery() and var_34_2 and not var_34_3 then
		self.catterySettlementPage:ExecuteAction("Show", (Clone(var_34_1)))
	end

	pg.m02:sendNotification(GAME.OPEN_OR_CLOSE_CATTERY, {
		open = true
	})

	return
end

function CommanderCatDockPage:UpdateHome()
	local var_35_0 = getProxy(CommanderProxy)

	setActive(self.homeTip, var_35_0:AnyCatteryExistOP() or var_35_0:AnyCatteryCanUse())

	local var_35_1 = var_35_0:GetCommanderHome()

	if var_35_1 then
		self.homeTxt.text = var_35_1:GetExistCommanderCattertCnt() .. "/" .. var_35_1:GetMaxCatteryCnt()
	end

	return
end

function CommanderCatDockPage:UpdateCapacity()
	self.capacityTxt.text = table.getCount(getProxy(CommanderProxy):getRawData()) .. "/" .. getProxy(PlayerProxy):getRawData().commanderBagMax

	return
end

function CommanderCatDockPage:UpdateReserve()
	local var_37_0 = getProxy(CommanderProxy):getBoxUseCnt()

	self.reserveTxt.text = CommanderConst.MAX_GETBOX_CNT - var_37_0 .. "/" .. CommanderConst.MAX_GETBOX_CNT

	setActive(self.reserveTip, var_37_0 == 0)

	return
end

function CommanderCatDockPage:UpdateBoxes()
	local var_38_0 = getProxy(CommanderProxy):getBoxes()

	self.boxesTxt.text = #_.select(var_38_0, function(arg_39_0)
		return arg_39_0:getState() == CommanderBox.STATE_FINISHED
	end) .. "/" .. #var_38_0

	setActive(self.boxesTip, getProxy(CommanderProxy):ShouldTipBox())

	return
end

function CommanderCatDockPage:OnInitItem(arg_40_1)
	local var_40_0 = self:NewCard(arg_40_1)

	onButton(self, var_40_0.infoTF, function()
		if not var_40_0.commanderVO then
			return
		end

		if self.contextData.mode == CommanderCatScene.MODE_SELECT then
			local var_41_0 = #self.selectedList

			self:OnCheckBefore(var_40_0.commanderVO)
			self:Check(var_40_0.commanderVO)
			self:OnCheckAfter(var_40_0.commanderVO, var_41_0 > #self.selectedList)
		else
			self.selectedList = {}

			for iter_41_0, iter_41_1 in pairs(self.cards) do
				iter_41_1:UpdateSelected(self.selectedList)
			end

			table.insert(self.selectedList, var_40_0.commanderVO.id)
			var_40_0:UpdateSelected(self.selectedList, not defaultValue(self.sortData.displayCustomName, true))

			self.selectedId = var_40_0.commanderVO.id

			self:emit(CommanderCatScene.EVENT_SELECTED, var_40_0.commanderVO, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_40_0.quitTF, function()
		if not var_40_0.commanderVO then
			return
		end

		if var_40_0.commanderVO.id == 0 then
			self.onQuit(function()
				self:emit(CommanderCatScene.EVENT_BACK)

				return
			end)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_40_1] = var_40_0

	return
end

function CommanderCatDockPage:OnCheckBefore(arg_44_1)
	if self.previewCommander and self.contextData.maxCount > 1 then
		self:emit(CommanderCatScene.EVENT_SELECTED, self.previewCommander, true)
	else
		self:emit(CommanderCatScene.EVENT_SELECTED, arg_44_1, true)

		if self.previewCommander then
			self:emit(CommanderCatScene.EVENT_PREVIEW_ADDITION, self.previewCommander, true)
		else
			self:emit(CommanderCatScene.EVENT_PREVIEW_ADDITION, arg_44_1, true)
		end
	end

	return
end

function CommanderCatDockPage:OnCheckAfter(arg_45_1, arg_45_2)
	if self.previewCommander and self.contextData.maxCount > 1 then
		self:emit(CommanderCatScene.EVENT_PREVIEW_PLAY, self.selectedList, arg_45_2)
	end

	return
end

function CommanderCatDockPage:Check(arg_46_1)
	local var_46_0 = self.contextData.maxCount or table.getCount(self.commanderList)

	if table.contains(self.selectedList, arg_46_1.id) and var_46_0 == 1 then
		self:UpdateSelected()

		return
	elseif table.contains(self.selectedList, arg_46_1.id) then
		table.remove(self.selectedList, (table.indexof(self.selectedList, arg_46_1.id)))
		self:UpdateSelected()

		return
	end

	local function var_46_1()
		for iter_47_0, iter_47_1 in ipairs(self.selectedList) do
			if iter_47_1 == arg_46_1.id then
				table.remove(self.selectedList, iter_47_0)

				break
			end
		end

		return
	end

	local var_46_2, var_46_3 = self.onCommander(arg_46_1, function()
		var_46_1()
		self:UpdateSelected()

		return
	end, function()
		var_46_1()
		self:UpdateCommanders(true)

		for iter_49_0, iter_49_1 in ipairs(self.commanderList or {}) do
			if iter_49_1.id == arg_46_1.id then
				self:Check(iter_49_1)
			end
		end

		self:UpdateSelected()

		return
	end, self)

	if not var_46_2 then
		if var_46_3 then
			pg.TipsMgr.GetInstance():ShowTips(var_46_3)
		end

		return
	end

	if var_46_0 == 1 then
		table.remove(self.selectedList, #self.selectedList)
	elseif var_46_0 <= #self.selectedList then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_select_max"))
		self:UpdateSelected()

		return
	end

	table.insert(self.selectedList, arg_46_1.id)
	self:UpdateSelected()

	return
end

function CommanderCatDockPage:UpdateSelected()
	for iter_50_0, iter_50_1 in pairs(self.cards) do
		iter_50_1:UpdateSelected(self.selectedList)
	end

	self:UpdateSelectedTxt()

	return
end

function CommanderCatDockPage:UpdateSelectedTxt()
	self.selectedNumTxt.text = #self.selectedList .. "/" .. (self.contextData.maxCount or table.getCount(self.commanderList))

	return
end

function CommanderCatDockPage:NewCard(arg_52_1)
	if self.contextData.mode == CommanderCatScene.MODE_VIEW or self.contextData.maxCount == 1 then
		return CommanderCatCard.New(arg_52_1, CommanderCatCard.MARK_TYPE_CIRCLE)
	else
		return CommanderCatCard.New(arg_52_1, CommanderCatCard.MARK_TYPE_TICK)
	end

	return
end

function CommanderCatDockPage:OnUpdateItem(arg_53_1, arg_53_2)
	local var_53_0 = self.cards[arg_53_2]

	if not self.cards[arg_53_2] then
		var_53_0 = self:NewCard(arg_53_2)
		self.cards[arg_53_2] = var_53_0
	end

	local var_53_1 = self.displays[arg_53_1 + 1]

	var_53_0:Update(self.displays[arg_53_1 + 1], self.selectedList, not defaultValue(self.sortData.displayCustomName, true))

	if var_53_1 and self.selectedId and self.selectedId == var_53_1.id and self.shouldTrigger then
		self.shouldTrigger = false

		triggerButton(var_53_0.infoTF)
	end

	return
end

local function var_0_1(arg_54_0, arg_54_1, arg_54_2)
	local var_54_2 = arg_54_0:getConfig("nationality")

	return (table.getCount(arg_54_1) == 0 or arg_54_1[var_54_2] or arg_54_1[CommanderIndexPage.NATION_OTHER] and CommanderIndexPage.IsOtherNation(var_54_2)) and true and (table.getCount(arg_54_2) == 0 or arg_54_2[arg_54_0:getRarity()]) and true
end

local function var_0_2(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local function var_55_0()
		if arg_55_3 == "id" then
			return (arg_55_2 and {
				arg_55_0.id < arg_55_1.id
			} or {
				arg_55_0.id > arg_55_1.id
			})[1]
		else
			local var_56_0 = arg_55_0["get" .. arg_55_3](arg_55_0)
			local var_56_1 = arg_55_1["get" .. arg_55_3](arg_55_1)

			if var_56_0 == var_56_1 then
				return (arg_55_2 and {
					arg_55_0.configId < arg_55_1.configId
				} or {
					arg_55_0.configId > arg_55_1.configId
				})[1]
			else
				return (arg_55_2 and {
					var_56_0 < var_56_1
				} or {
					var_56_1 < var_56_0
				})[1]
			end
		end

		return
	end

	local var_55_1 = arg_55_0.inFleet and 1 or 0
	local var_55_2 = arg_55_1.inFleet and 1 or 0

	if (arg_55_0.inFleet and 1 or 0) == (arg_55_1.inFleet and 1 or 0) then
		return (function()
			local var_57_0 = arg_55_4 == arg_55_0.id and 1 or 0
			local var_57_1 = arg_55_4 == arg_55_1.id and 1 or 0

			if (arg_55_4 == arg_55_0.id and 1 or 0) == (arg_55_4 == arg_55_1.id and 1 or 0) then
				return var_55_0()
			else
				return var_57_1 < var_57_0
			end

			return
		end)()
	else
		return var_55_2 < var_55_1
	end

	return
end

function CommanderCatDockPage:UpdateCommanders(arg_58_1)
	local var_58_0 = (arg_58_1 or not self.commanderList) and CommanderCatUtil.GetCommanderList(self.contextData) or self.commanderList

	self.shouldTrigger = true
	self.displays = {}

	local var_58_1 = {}
	local var_58_2 = {}

	for iter_58_0, iter_58_1 in pairs(self.sortData.nationData or {}) do
		var_58_1[iter_58_1] = true
	end

	for iter_58_2, iter_58_3 in ipairs(self.sortData.rarityData or {}) do
		var_58_2[iter_58_3] = true
	end

	for iter_58_4, iter_58_5 in pairs(var_58_0) do
		if var_0_1(iter_58_5, var_58_1, var_58_2) then
			table.insert(self.displays, iter_58_5)
		end
	end

	table.sort(self.displays, function(arg_59_0, arg_59_1)
		return var_0_2(arg_59_0, arg_59_1, self.sortData.asc, self.sortData.sortData, self.previewCommanderId)
	end)

	if not self.selectedId and #self.displays > 0 then
		self.selectedId = self.displays[1].id
	elseif #self.displays > 0 and _.all(self.displays, function(arg_60_0)
		return arg_60_0.id ~= self.selectedId
	end) and self.previewCommander then
		self:OnCheckBefore(self.previewCommander)
		self:OnCheckAfter(self.previewCommander)
	end

	if self.previewCommanderId and self.contextData.maxCount == 1 then
		table.insert(self.displays, 1, {
			id = 0
		})
	end

	local var_58_3, var_58_4 = self:FillList()

	self.scrollRect:SetTotalCount(var_58_3, var_58_4)

	self.commanderList = var_58_0

	return
end

function CommanderCatDockPage:FillList()
	if self.contextData.mode == CommanderCatScene.MODE_VIEW then
		local var_61_0 = #self.displays + ((#self.displays % 4 > 0 or nil) and (4 - #self.displays % 4 or 0))
		local var_61_1

		if self.selectedId then
			local var_61_2 = 0

			for iter_61_0, iter_61_1 in ipairs(self.displays) do
				if iter_61_1.id == self.selectedId then
					var_61_2 = iter_61_0

					break
				end
			end

			var_61_1 = math.floor(var_61_2 / 4) / (#self.displays / 4)
		end

		local var_61_3

		if not var_61_1 then
			::label_61_0::

			var_61_3 = self.contextData.scrollValue or 0
		end

		return math.max(12, var_61_0), var_61_3
	elseif self.contextData.mode == CommanderCatScene.MODE_SELECT then
		return #self.displays, self.contextData.scrollValue or 0
	end

	return
end

function CommanderCatDockPage:CanBack()
	if self.boxesPanel and self.boxesPanel:GetLoaded() and self.boxesPanel.CanBack and not self.boxesPanel:CanBack() then
		return false
	end

	if self.reservePanel and self.reservePanel:GetLoaded() and self.reservePanel:isShowing() then
		self.reservePanel:Hide()

		return false
	end

	if self.boxesPanel and self.boxesPanel:GetLoaded() and self.boxesPanel:isShowing() then
		self.boxesPanel:Hide()

		return false
	end

	if self.indexPanel and self.indexPanel:GetLoaded() and self.indexPanel:isShowing() then
		self.indexPanel:Hide()

		return false
	end

	return true
end

function CommanderCatDockPage:OnDestroy()
	for iter_63_0, iter_63_1 in pairs(self.cards) do
		iter_63_1:Dispose()
	end

	if self.reservePanel then
		self.reservePanel:Destroy()

		self.reservePanel = nil
	end

	if self.boxesPanel then
		self.boxesPanel:Destroy()

		self.boxesPanel = nil
	end

	if self.indexPanel then
		self.indexPanel:Destroy()

		self.indexPanel = nil
	end

	if self.catterySettlementPage then
		self.catterySettlementPage:Destroy()

		self.catterySettlementPage = nil
	end

	self.contextData.scrollValue = math.min(self.scrollRect.value, 1)

	return
end

return CommanderCatDockPage
