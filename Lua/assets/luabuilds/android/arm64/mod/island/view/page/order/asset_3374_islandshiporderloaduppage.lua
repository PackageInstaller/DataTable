local IslandShipOrderLoadUpPage = class("IslandShipOrderLoadUpPage", import("view.base.BaseSubView"))

function IslandShipOrderLoadUpPage:getUIName()
	return "IslandShipOrderLoadUpUI"
end

function IslandShipOrderLoadUpPage:OnLoaded()
	self.mainTr = self._tf:Find("main")
	self.cntTxt = self._tf:Find("main/name/count"):GetComponent(typeof(Text))
	self.submitBtn = self._tf:Find("main/btn/btn_1")
	self.noResBtn = self._tf:Find("main/btn/btn_2")
	self.disableBtn = self._tf:Find("main/btn/btn_3")
	self.awardCntTxt = self._tf:Find("main/price/Text"):GetComponent(typeof(Text))
	self.nameTxt = self._tf:Find("main/name"):GetComponent(typeof(Text))

	setText(self._tf:Find("main/title/Text"), i18n("island_order_ship_loadup_award"))
	setText(self._tf:Find("main/btn/btn_2/Text"), i18n("island_order_ship_loadup_nores"))
	setText(self._tf:Find("main/btn/btn_1/Text"), i18n("island_order_ship_loadup"))
	setText(self._tf:Find("main/btn/btn_3/Text"), i18n("island_order_ship_finish_cnt_not_enough"))

	return
end

function IslandShipOrderLoadUpPage:OnInit()
	onButton(self, self._tf, function()
		self:emit(IslandShipOrderPage.EVENT_CLOSE_LOAD_UP)

		return
	end, SFX_PANEL)
	onButton(self, self.submitBtn, function()
		if not self.slot or not self.index then
			return
		end

		if not self.slot:CanTransport() then
			return
		end

		self:emit(IslandMediator.SUBMIT_SHIP_ORDER_ITME, self.slot.id, self.index)

		return
	end, SFX_PANEL)

	return
end

function IslandShipOrderLoadUpPage:Show(arg_6_1, arg_6_2, arg_6_3)
	IslandShipOrderLoadUpPage.super.Show(self)

	self.slot = arg_6_2
	self.index = arg_6_3
	self.mainTr.localPosition = arg_6_1

	local var_6_0 = arg_6_2:GetOrder()
	local var_6_1 = Drop.New((var_6_0:GetComsume(arg_6_3)))
	local var_6_2 = var_6_1.count <= var_6_0

	self.cntTxt.text = setColorStr(var_6_1:getOwnedCount() .. "/" .. var_6_1.count, var_6_1.count <= var_6_0 and "#39beff" or "#f36c6e")
	self.nameTxt.text = var_6_1:getName()
	self.awardCntTxt.text = "X" .. arg_6_2:GetOrder():GetConsumeAwards(arg_6_3)[1].count

	local var_6_3 = self.slot:CanTransport()

	setActive(self.submitBtn, var_6_2 and var_6_3)
	setActive(self.noResBtn, not var_6_2 and var_6_3)
	setActive(self.disableBtn, not var_6_3)

	return
end

function IslandShipOrderLoadUpPage:OnDestroy()
	return
end

return IslandShipOrderLoadUpPage
