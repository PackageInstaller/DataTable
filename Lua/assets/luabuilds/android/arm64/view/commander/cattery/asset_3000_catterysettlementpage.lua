local CatterySettlementPage = class("CatterySettlementPage", import("...base.BaseSubView"))

function CatterySettlementPage:getUIName()
	return "CatterySettlementPage"
end

function CatterySettlementPage:OnLoaded()
	self.painting = self._tf:Find("painting")
	self.uilist = UIItemList.New(self._tf:Find("frame/commanders"), self._tf:Find("frame/commanders/tpl"))

	setText(self._tf:Find("dialogue/label/Text1"), i18n("cattery_settlement_dialogue_1"))
	setText(self._tf:Find("dialogue/label/Text3"), i18n("cattery_settlement_dialogue_2"))
	setText(self._tf:Find("dialogue/label1/Text1"), i18n("cattery_settlement_dialogue_3"))
	setText(self._tf:Find("dialogue/label1/Text3"), i18n("cattery_settlement_dialogue_4"))

	self.timeTxt = self._tf:Find("dialogue/label/Text2"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("dialogue/label1/Text2"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("comfirm")

	return
end

function CatterySettlementPage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:Destroy()

		return
	end, SFX_PANEL)

	self.cards = {}

	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateCommander(arg_5_2, self.displays[arg_5_1 + 1])
		end

		return
	end)

	return
end

function CatterySettlementPage:Show(arg_6_1)
	CatterySettlementPage.super.Show(self)

	self.home = arg_6_1

	self:SetPainting()
	self:UpdateCommanders()
	self:UpdateDialogue()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CatterySettlementPage:Hide()
	CatterySettlementPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

function CatterySettlementPage:GetFlagShip()
	return Ship.New({
		id = 999,
		configId = 312011
	})
end

function CatterySettlementPage:SetPainting()
	self:ReturnPainting()

	local var_9_0 = self:GetFlagShip():getPainting()

	self.paintingName = var_9_0

	setPaintingPrefabAsync(self.painting, var_9_0, "jiesuan")

	return
end

function CatterySettlementPage:UpdateCommanders()
	self.displays = {}

	for iter_10_0, iter_10_1 in pairs((self.home:GetCatteries())) do
		table.insert(self.displays, iter_10_1)
	end

	table.sort(self.displays, function(arg_11_0, arg_11_1)
		return arg_11_0:GetCommanderId() > arg_11_1:GetCommanderId()
	end)
	self.uilist:align(#self.displays)

	return
end

function CatterySettlementPage:UpdateCommander(arg_12_1, arg_12_2)
	local var_12_0 = self.cards[arg_12_1]

	if not self.cards[arg_12_1] then
		var_12_0 = CatterySettlementCard.New(arg_12_1)
		self.cards[arg_12_1] = var_12_0
	end

	var_12_0:Update(arg_12_2, arg_12_2:GetCacheExp())
	var_12_0:Action(function()
		return
	end)

	return
end

function CatterySettlementPage:UpdateDialogue()
	local var_14_0 = 0
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in pairs((self.home:GetCatteries())) do
		var_14_0 = var_14_0 + iter_14_1:GetCacheExp()

		local var_14_2 = iter_14_1:GetCacheExpTime()

		if var_14_1 < var_14_2 then
			var_14_1 = var_14_2
		end
	end

	self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_1)
	self.expTxt.text = var_14_0

	return
end

function CatterySettlementPage:ReturnPainting()
	if self.paintingName then
		retPaintingPrefab(self.painting, self.paintingName)

		self.paintingName = nil
	end

	return
end

function CatterySettlementPage:OnDestroy()
	self:ReturnPainting()

	for iter_16_0, iter_16_1 in pairs(self.cards) do
		iter_16_1:Dispose()
	end

	self:Hide()

	self.cards = nil

	return
end

return CatterySettlementPage
