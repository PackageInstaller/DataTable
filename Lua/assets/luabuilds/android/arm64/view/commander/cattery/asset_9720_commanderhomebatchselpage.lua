local CommanderHomeBatchSelPage = class("CommanderHomeBatchSelPage", import(".CommanderHomeBaseSelPage"))

function CommanderHomeBatchSelPage:getUIName()
	return "CatteryBatchSelPage"
end

function CommanderHomeBatchSelPage:OnLoaded()
	self.scrollrect = self._tf:Find("page/frame/scrollrect"):GetComponent("LScrollRect")
	self.okBtn = self._tf:Find("page/frame/ok_button")
	self.uiList = UIItemList.New(self._tf:Find("page/frame/list/content"), self._tf:Find("page/frame/comanderTF"))
	self.closeBtn = self._tf:Find("page/close_btn")

	return
end

function CommanderHomeBatchSelPage:OnInit()
	CommanderHomeBatchSelPage.super.OnInit(self)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.okBtn, function()
		self:Filter()

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeBatchSelPage:Filter()
	local var_7_0 = self.home:GetCatteries()
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(self.displayCatteries) do
		local var_7_2 = var_7_0[iter_7_0]:ExistCommander()
		local var_7_3 = var_7_0[iter_7_0]:GetCommanderId()
		local var_7_4 = var_7_0[iter_7_0]:IsLocked()

		if not var_7_4 and var_7_2 and iter_7_1.commanderId == var_7_3 then
			-- block empty
		elseif not var_7_4 and not var_7_2 and iter_7_1.commanderId == 0 then
			-- block empty
		else
			table.insert(var_7_1, {
				pos = iter_7_0,
				id = iter_7_1.commanderId
			})
		end
	end

	local var_7_5 = {}

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		table.insert(var_7_5, function(arg_8_0)
			self:emit(CommanderHomeMediator.ON_SEL_COMMANDER, iter_7_3.pos, iter_7_3.id, false, arg_8_0)

			return
		end)
	end

	seriesAsync(var_7_5)

	return
end

function CommanderHomeBatchSelPage:Update(arg_9_1)
	self:Show()

	self.home = arg_9_1

	self:InitList()
	CommanderHomeBatchSelPage.super.Update(self)
	self:UpdateSelectedList()

	return
end

function CommanderHomeBatchSelPage:Show()
	CommanderHomeBatchSelPage.super.Show(self)
	self:emit(CommanderHomeLayer.DESC_PAGE_OPEN)

	return
end

function CommanderHomeBatchSelPage:InitList()
	self.maxCnt = 0
	self.displayCatteries = {}

	for iter_11_0, iter_11_1 in pairs((self.home:GetCatteries())) do
		local var_11_0 = iter_11_1:GetState() == Cattery.STATE_LOCK
		local var_11_1 = self.displayCatteries
		local var_11_2 = {
			isLock = var_11_0
		}

		var_11_2.commanderId = iter_11_1:ExistCommander() and iter_11_1:GetCommanderId() or 0

		table.insert(var_11_1, var_11_2)

		if not var_11_0 then
			self.maxCnt = self.maxCnt + 1
		end
	end

	self.uiList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateSelectedCard(arg_12_1 + 1, arg_12_2)
		end

		return
	end)

	return
end

function CommanderHomeBatchSelPage:UpdateSelectedList()
	self.uiList:align(#self.displayCatteries)

	return
end

function CommanderHomeBatchSelPage:UpdateSelectedCard(arg_14_1, arg_14_2)
	local var_14_0 = self.displayCatteries[arg_14_1]
	local var_14_1 = getProxy(CommanderProxy):RawGetCommanderById(self.displayCatteries[arg_14_1].commanderId)

	if var_14_1 then
		CommanderCard.New(arg_14_2):update(var_14_1)
		setActive(arg_14_2:Find("info/home"), not self:CheckIncludeSelf(var_14_1.id))
	end

	if not var_14_0.isLock then
		onButton(self, arg_14_2, function()
			if var_14_1 then
				var_14_0.commanderId = 0

				self:UpdateSelectedCard(arg_14_1, arg_14_2)
				self:UpdateCardSelected()
			end

			return
		end, SFX_PANEL)
	end

	setActive(arg_14_2:Find("info"), var_14_1 ~= nil)
	setActive(arg_14_2:Find("lock_b"), var_14_0.isLock)
	setActive(arg_14_2:Find("empty_b"), var_14_1 == nil)
	setActive(arg_14_2:Find("tip"), false)
	setActive(arg_14_2:Find("up"), false)

	return
end

function CommanderHomeBatchSelPage:CheckIncludeSelf(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs((self.home:GetCatteries())) do
		if iter_16_1:GetCommanderId() == arg_16_1 then
			return false
		end
	end

	return true
end

function CommanderHomeBatchSelPage:GetSelectedCommanderList()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self.displayCatteries) do
		if not iter_17_1.isLock and iter_17_1.commanderId ~= 0 then
			table.insert(var_17_0, iter_17_1.commanderId)
		end
	end

	return var_17_0
end

function CommanderHomeBatchSelPage:GetEmptyPosIndex()
	for iter_18_0, iter_18_1 in pairs(self.displayCatteries) do
		if not iter_18_1.isLock and iter_18_1.commanderId == 0 then
			return iter_18_0
		end
	end

	return -1
end

function CommanderHomeBatchSelPage:OnUpdateItem(arg_19_1, arg_19_2)
	CommanderHomeBatchSelPage.super.OnUpdateItem(self, arg_19_1, arg_19_2)

	local var_19_1 = self.cards[arg_19_2]
	local var_19_2

	if self.cards[arg_19_2].commanderVO then
		var_19_2 = var_19_1.commanderVO.id or 0
	end

	setActive(var_19_1._tf:Find("sel_b"), table.contains(self:GetSelectedCommanderList(), var_19_2))

	if var_19_2 > 0 then
		setActive(var_19_1._tf:Find("info/home"), not self:CheckIncludeSelf(var_19_2))
	end

	return
end

function CommanderHomeBatchSelPage:OnSelected(arg_20_1)
	local var_20_0 = self:GetEmptyPosIndex()

	if var_20_0 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_selected_max", self.maxCnt))

		return
	end

	local var_20_1 = arg_20_1.commanderVO

	if not arg_20_1.commanderVO then
		return
	end

	if not table.contains(self:GetSelectedCommanderList(), var_20_1.id) then
		self.displayCatteries[var_20_0].commanderId = var_20_1.id
	else
		for iter_20_0, iter_20_1 in ipairs(self.displayCatteries) do
			if iter_20_1.commanderId == var_20_1.id then
				self.displayCatteries[iter_20_0].commanderId = 0

				break
			end
		end
	end

	self:UpdateCardSelected()
	self:UpdateSelectedList()

	return
end

function CommanderHomeBatchSelPage:UpdateCardSelected()
	local var_21_0 = self:GetSelectedCommanderList()

	for iter_21_0, iter_21_1 in pairs(self.cards) do
		setActive(iter_21_1._tf:Find("sel_b"), table.contains(var_21_0, (iter_21_1.commanderVO or nil) and (iter_21_1.commanderVO.id or 0)))
	end

	return
end

function CommanderHomeBatchSelPage:Hide()
	self:emit(CommanderHomeLayer.DESC_PAGE_CLOSE)
	CommanderHomeBatchSelPage.super.Hide(self)

	return
end

return CommanderHomeBatchSelPage
