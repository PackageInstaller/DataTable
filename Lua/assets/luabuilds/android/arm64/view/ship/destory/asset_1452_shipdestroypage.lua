local ShipDestroyPage = class("ShipDestroyPage", import("...base.BaseSubView"))

function ShipDestroyPage:getUIName()
	return "DestoryInfoUI"
end

function ShipDestroyPage:OnLoaded()
	self.cardScrollRect = self._tf:Find("frame/sliders/content"):GetComponent("LScrollRect")

	function self.cardScrollRect.onInitItem(arg_3_0)
		return
	end

	function self.cardScrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = DockyardShipItem.New(arg_4_1, ShipStatus.TAG_HIDE_DESTROY)

		var_4_0:update(self.shipVOs[self.shipIds[arg_4_0 + 1]])
		onButton(self, var_4_0.tr, function()
			existCall(self.OnCardClick, var_4_0)
			self:DisplayShipList()

			return
		end, SFX_PANEL)

		return
	end

	function self.cardScrollRect.onReturnItem(arg_6_0, arg_6_1)
		removeOnButton(arg_6_1)

		return
	end

	self.cancelBtn = self._tf:Find("frame/cancel_button")
	self.backBtn = self._tf:Find("frame/top/btnBack")
	self.confirmBtn = self._tf:Find("frame/confirm_button")

	setText(self._tf:Find("frame/bg_award/label"), i18n("disassemble_available") .. ":")

	local var_2_0 = self._tf:Find("frame/bg_award/res_list")

	self.resList = UIItemList.New(var_2_0, var_2_0:Find("res"))

	self.resList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync(self.showList[arg_7_1]:getIcon(), "", arg_7_2:Find("icon"))
			setText(arg_7_2:Find("Text"), "X" .. self.showList[arg_7_1].count)
		end

		return
	end)

	return
end

function ShipDestroyPage:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		if self.OnConfirm then
			self.OnConfirm()
		end

		return
	end, SFX_PANEL)

	return
end

function ShipDestroyPage:SetConfirmCallBack(arg_12_1)
	self.OnConfirm = arg_12_1

	return
end

function ShipDestroyPage:SetCardClickCallBack(arg_13_1)
	self.OnCardClick = arg_13_1

	return
end

function ShipDestroyPage:Refresh(arg_14_1, arg_14_2)
	self.shipIds = arg_14_1
	self.shipVOs = arg_14_2

	self:DisplayShipList()
	self:RefreshRes()
	self:Show()

	return
end

function ShipDestroyPage:DisplayShipList()
	self.cardScrollRect:SetTotalCount(#self.shipIds)

	if #self.shipIds == 0 then
		self:Hide()
	end

	return
end

function ShipDestroyPage:CalcShipsReturnRes(arg_16_1)
	return ShipCalcHelper.CalcDestoryRes((_.map(self, function(arg_17_0)
		return arg_16_1[arg_17_0]
	end)))
end

function ShipDestroyPage:RefreshRes()
	local var_18_0, var_18_1, var_18_2 = ShipDestroyPage.CalcShipsReturnRes(self.shipIds, self.shipVOs)

	table.insert(var_18_2, 1, Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = PlayerConst.ResOil,
		count = var_18_1
	}))
	table.insert(var_18_2, 1, Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = PlayerConst.ResGold,
		count = var_18_0
	}))

	self.showList = underscore.filter(var_18_2, function(arg_19_0)
		return arg_19_0.count > 0
	end)

	self.resList:align(#self.showList)

	return
end

function ShipDestroyPage:Show()
	ShipDestroyPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ShipDestroyPage:Hide()
	ShipDestroyPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ShipDestroyPage:OnDestroy()
	self.OnCardClick = nil

	ClearLScrollrect(self.cardScrollRect)
	self:Hide()

	return
end

return ShipDestroyPage
