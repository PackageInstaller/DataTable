local IslandOrderDescPage = class("IslandOrderDescPage", import("...base.IslandBasePage"))

function IslandOrderDescPage:getUIName()
	return "IslandOrderDescUI"
end

function IslandOrderDescPage:OnLoaded()
	self.infoPanel = self._tf:Find("info")
	self.nameTxt = self._tf:Find("info/name/Text"):GetComponent(typeof(Text))
	self.consumeUIList = UIItemList.New(self._tf:Find("info/subtitle_item/list"), self._tf:Find("info/subtitle_item/list/tpl"))
	self.awardUIList = UIItemList.New(self._tf:Find("info/subtitle_reward/list"), self._tf:Find("info/subtitle_reward/list/tpl"))
	self.submitBtn = self._tf:Find("info/btns/submit")
	self.submitBtnMark = self._tf:Find("info/btns/submit/mask")
	self.replaceBtn = self._tf:Find("info/btns/cancel")
	self.speedUpBtn = self._tf:Find("loading/submit")
	self.loadingPanel = self._tf:Find("loading")
	self.loadingTimeTxt = self.loadingPanel:Find("Text/time"):GetComponent(typeof(Text))

	setText(self._tf:Find("info/btns/cancel/Text"), i18n("island_word_turndown"))
	setText(self._tf:Find("info/btns/submit/Text"), i18n("island_word_sbumit"))
	setText(self._tf:Find("loading/Text"), i18n("island_order_cd_tip"))
	setText(self._tf:Find("loading/submit/Text"), i18n("island_word_speedup"))

	return
end

function IslandOrderDescPage:OnInit()
	onButton(self, self.replaceBtn, function()
		self:emit(IslandMediator.ON_REPLACE_ORDER, self.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, self.submitBtn, function()
		local var_5_0, var_5_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency():CanSubmitOrder()

		if not var_5_0 then
			local var_5_2 = pg.TimeMgr.GetInstance()

			pg.TipsMgr.GetInstance().ShowTips(var_5_2, i18n("island_submit_order_cd_tip", (pg.TimeMgr.GetInstance():DescCDTime(var_5_1 - var_5_2:GetServerTime()))))

			return
		end

		self:emit(IslandMediator.ON_SUBMIT_ORDER, self.slot.id)

		return
	end, SFX_PANEL)
	onButton(self, self.speedUpBtn, function()
		self:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.ORDER_CD, self.slot.id)

		return
	end, SFX_PANEL)

	return
end

function IslandOrderDescPage:AddListeners()
	self:AddListener(GAME.ISLAND_SUBMIT_ORDER_DONE, self.OnSubmitOrder)
	self:AddListener(GAME.ISLAND_REPLACE_ORDER_DONE, self.OnReplaceOrder)
	self:AddListener(IslandOrderAgency.GEN_NEW_ORDER, self.OnGenNewOrder)
	self:AddListener(IslandOrderAgency.UDPATE_ORDER, self.OnFlushOrder)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

function IslandOrderDescPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SUBMIT_ORDER_DONE, self.OnSubmitOrder)
	self:RemoveListener(GAME.ISLAND_REPLACE_ORDER_DONE, self.OnReplaceOrder)
	self:RemoveListener(IslandOrderAgency.GEN_NEW_ORDER, self.OnGenNewOrder)
	self:RemoveListener(IslandOrderAgency.UDPATE_ORDER, self.OnFlushOrder)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

function IslandOrderDescPage:OnSubmitOrder(arg_9_1)
	self:Flush((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_9_1.slotId)))

	return
end

function IslandOrderDescPage:OnReplaceOrder(arg_10_1)
	self:Flush((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_10_1.slotId)))

	return
end

function IslandOrderDescPage:OnFlushOrder(arg_11_1)
	self:TryFlushOrderInfo(arg_11_1.slotId)

	return
end

function IslandOrderDescPage:OnUseTicketDone(arg_12_1)
	if arg_12_1.type == IslandUseTicketCommand.TYPES.ORDER_CD then
		self:TryFlushOrderInfo(arg_12_1.id)
	end

	return
end

function IslandOrderDescPage:OnGenNewOrder(arg_13_1)
	self:TryFlushOrderInfo(arg_13_1.slotId)

	return
end

function IslandOrderDescPage:TryFlushOrderInfo(arg_14_1)
	local var_14_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_14_1)

	if not self.slot then
		return
	end

	if self.slot.id ~= var_14_0.id then
		return
	end

	self:Flush(var_14_0)

	return
end

function IslandOrderDescPage:Show(arg_15_1)
	IslandOrderDescPage.super.Show(self)
	self:Flush(arg_15_1)

	return
end

function IslandOrderDescPage:Flush(arg_16_1)
	self.slot = arg_16_1

	if not arg_16_1 or arg_16_1:IsEmpty() then
		self:Hide()

		return
	end

	local var_16_0 = arg_16_1:IsLoading()

	setActive(self.infoPanel, not var_16_0)
	setActive(self.loadingPanel, var_16_0)
	self:RemoveSubmitCdTimer()
	self:RemoveLoadingTimer()
	self:RemoveDisappearTimer()

	if var_16_0 then
		self:FlushLoadingPanel(arg_16_1)
	else
		self:FlusInfoPanel(arg_16_1)
	end

	if arg_16_1:GetOrder():IsUrgency() then
		self:AddDisappearTimer(arg_16_1)
	end

	return
end

function IslandOrderDescPage:AddDisappearTimer(arg_17_1)
	self:RemoveDisappearTimer()

	local var_17_0 = arg_17_1:GetDisappearTime()

	if var_17_0 <= pg.TimeMgr.GetInstance():GetServerTime() then
		self:Hide()

		return
	end

	self.disappearTimer = Timer.New(function()
		if var_17_0 - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
			self:Hide()
		end

		return
	end, 1, -1)

	self.disappearTimer.func()
	self.disappearTimer:Start()

	return
end

function IslandOrderDescPage:RemoveDisappearTimer()
	if self.disappearTimer then
		self.disappearTimer:Stop()

		self.disappearTimer = nil
	end

	return
end

function IslandOrderDescPage:FlushLoadingPanel(arg_20_1)
	local function var_20_0()
		self.loadingTimeTxt.text = ""

		self:Flush(arg_20_1)

		return
	end

	local var_20_1 = arg_20_1:GetCanSubmitTime()

	if var_20_1 <= pg.TimeMgr.GetInstance():GetServerTime() then
		var_20_0()

		return
	end

	self.loadingTimer = Timer.New(function()
		local var_22_0 = var_20_1 - pg.TimeMgr.GetInstance():GetServerTime()

		self.loadingTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_22_0)

		if var_22_0 < 0 then
			self:RemoveLoadingTimer()
			var_20_0()
		end

		return
	end, 1, -1)

	self.loadingTimer:Start()
	self.loadingTimer.func()

	return
end

function IslandOrderDescPage:RemoveLoadingTimer()
	if self.loadingTimer then
		self.loadingTimer:Stop()

		self.loadingTimer = nil
	end

	return
end

function IslandOrderDescPage:FlusInfoPanel(arg_24_1)
	local var_24_0 = arg_24_1:GetOrder()

	self:FlushAwards(var_24_0)
	self:FlushConsume(var_24_0)
	setActive(self.replaceBtn, not var_24_0:IsUrgency())

	self.nameTxt.text = var_24_0:GetRoleName()

	local var_24_1, var_24_2 = getProxy(IslandProxy):GetIsland():GetOrderAgency():CanSubmitOrder()

	setActive(self.submitBtnMark, not var_24_0:CanFinish())

	if var_24_1 then
		self:SetMaskFillAmount(self.submitBtnMark, 1)

		return
	end

	local var_24_3 = pg.island_set.order_complete_refresh_time.key_value_int

	self.submitTimer = Timer.New(function()
		self:SetMaskFillAmount(self.submitBtnMark, 1 - (var_24_2 - pg.TimeMgr.GetInstance():GetServerTime()) / var_24_3)

		if (var_24_2 - pg.TimeMgr.GetInstance():GetServerTime()) / var_24_3 <= 0 then
			self:RemoveSubmitCdTimer()
		end

		return
	end, 1, -1)

	self.submitTimer:Start()
	self.submitTimer.func()

	return
end

function IslandOrderDescPage:SetMaskFillAmount(arg_26_1, arg_26_2)
	arg_26_1:GetComponent(typeof(RectMask2D)).padding = Vector4(arg_26_1.sizeDelta.x * arg_26_2, 0, 0, 0)

	return
end

function IslandOrderDescPage:FlushAwards(arg_27_1)
	local var_27_0 = arg_27_1:GetDisplayAwards()

	self.awardUIList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_27_0[arg_28_1 + 1]

			updateCustomDrop(arg_28_2, var_27_0[arg_28_1 + 1])
			onButton(self, arg_28_2, function()
				self:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_28_0
				})

				return
			end)
		end

		return
	end)
	self.awardUIList:align(#var_27_0)

	return
end

function IslandOrderDescPage:FlushConsume(arg_30_1)
	local var_30_0 = arg_30_1:GetConsume()

	self.consumeUIList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = var_30_0[arg_31_1 + 1]
			local var_31_1 = {
				count = 0,
				type = var_30_0[arg_31_1 + 1].type,
				id = var_30_0[arg_31_1 + 1].id
			}

			updateCustomDrop(arg_31_2:Find("tpl"), var_31_1)
			onButton(self, arg_31_2, function()
				self:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_31_1
				})

				return
			end)
			setText(arg_31_2:Find("Text"), var_31_1.cfg.name)

			local var_31_2 = Drop.New({
				type = var_31_1.type,
				id = var_31_1.id
			}):getOwnedCount()
			local var_31_3 = var_31_2 >= var_31_0.count

			if var_31_2 >= var_31_0.count then
				setText(arg_31_2:Find("count"), var_31_2 .. "/" .. var_31_0.count)
			else
				setText(arg_31_2:Find("count"), setColorStr(var_31_2, COLOR_RED) .. "/" .. var_31_0.count)
			end

			setActive(arg_31_2:Find("finish"), var_31_3)
			setActive(arg_31_2:Find("line"), arg_31_1 + 1 ~= #var_30_0)
		end

		return
	end)
	self.consumeUIList:align(#var_30_0)

	return
end

function IslandOrderDescPage:RemoveSubmitCdTimer()
	if self.submitTimer then
		self.submitTimer:Stop()

		self.submitTimer = nil
	end

	return
end

function IslandOrderDescPage:OnDestroy()
	self:RemoveSubmitCdTimer()
	self:RemoveLoadingTimer()
	self:RemoveDisappearTimer()

	return
end

return IslandOrderDescPage
