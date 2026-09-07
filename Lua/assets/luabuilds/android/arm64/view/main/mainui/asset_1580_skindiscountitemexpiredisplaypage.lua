local SkinDiscountItemExpireDisplayPage = class("SkinDiscountItemExpireDisplayPage", import("view.base.BaseSubView"))

function SkinDiscountItemExpireDisplayPage:getUIName()
	return "SkinDicountItemExpiredUI"
end

function SkinDiscountItemExpireDisplayPage:OnLoaded()
	self.confirmBtn = self._tf:Find("confirm_btn")
	self.tipTxt = self._tf:Find("title/label"):GetComponent(typeof(Text))
	self.leftList = UIItemList.New(self._tf:Find("left/scrollrect/list"), self._tf:Find("left/scrollrect/list/tpl"))
	self.rightList = UIItemList.New(self._tf:Find("right/scrollrect/list"), self._tf:Find("left/scrollrect/list/tpl"))

	setText(self.tipTxt, i18n("skin_discount_item_tran_tip"))

	return
end

function SkinDiscountItemExpireDisplayPage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SkinDiscountItemExpireDisplayPage:Show(arg_5_1)
	self:InitLeftList(arg_5_1)
	self:InitRightList(arg_5_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SkinDiscountItemExpireDisplayPage:InitLeftList(arg_6_1)
	local var_6_0 = getProxy(BagProxy)
	local var_6_1 = _.map(arg_6_1, function(arg_7_0)
		return {
			DROP_TYPE_ITEM,
			arg_7_0.id,
			(var_6_0:getItemCountById(arg_7_0.id))
		}
	end)

	self.leftList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateItem(var_6_1[arg_8_1 + 1], arg_8_2)
		end

		return
	end)
	self.leftList:align(#var_6_1)

	return
end

function SkinDiscountItemExpireDisplayPage:InitRightList(arg_9_1)
	local var_9_0 = getProxy(BagProxy):GetSellingPrice(arg_9_1)

	self.rightList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:UpdateItem(var_9_0[arg_10_1 + 1], arg_10_2)
		end

		return
	end)
	self.rightList:align(#var_9_0)

	return
end

function SkinDiscountItemExpireDisplayPage:UpdateItem(arg_11_1, arg_11_2)
	local var_11_0 = Drop.Create(arg_11_1)

	updateDrop(arg_11_2, var_11_0)
	setScrollText(arg_11_2:Find("name_bg/Text"), var_11_0:getName())
	onButton(self, arg_11_2, function()
		pg.m02:sendNotification(NewMainMediator.ON_DROP, var_11_0)

		return
	end, SFX_PANEL)

	return
end

function SkinDiscountItemExpireDisplayPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

return SkinDiscountItemExpireDisplayPage
