local BackyardFeedExtendPage = class("BackyardFeedExtendPage", import("....base.BaseSubView"))

function BackyardFeedExtendPage:getUIName()
	return "BackYardFeedExtendPanel"
end

function BackyardFeedExtendPage:OnLoaded()
	self.icon = self._tf:Find("frame/tip/icon"):GetComponent(typeof(Image))
	self.consume = self._tf:Find("frame/tip/Text"):GetComponent(typeof(Text))
	self.desc = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.addBtn = self._tf:Find("frame/confirm")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.closeBtn = self._tf:Find("frame/close")
	self._parentTF = self._tf.parent

	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(self.addBtn:Find("Text"), i18n("word_ok"))
	setText(self._tf:Find("frame/tip"), i18n("backyard_food_shop_tip"))
	setText(self._tf:Find("frame/title"), i18n("words_information"))

	return
end

function BackyardFeedExtendPage:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function BackyardFeedExtendPage:Show(arg_7_1, arg_7_2)
	BackyardFeedExtendPage.super.Show(self)

	local var_7_0 = pg.shop_template[arg_7_1].resource_type
	local var_7_1 = pg.shop_template[arg_7_1].resource_num

	LoadSpriteAtlasAsync("props/" .. id2res(pg.shop_template[arg_7_1].resource_type), "", function(arg_8_0)
		self.icon.sprite = arg_8_0
		tf(self.icon.gameObject).sizeDelta = Vector2(50, 50)

		return
	end)

	self.consume.text = pg.shop_template[arg_7_1].resource_num
	self.desc.text = i18n("backyard_backyardGranaryLayer_foodMaxIncreaseNotice", arg_7_2, arg_7_2 + pg.shop_template[arg_7_1].num)

	onButton(self, self.addBtn, function()
		self:Extend({
			resType = var_7_0,
			resCount = var_7_1,
			shopId = arg_7_1
		})

		return
	end, SFX_CONFIRM)

	return
end

function BackyardFeedExtendPage:Extend(arg_10_1)
	if getProxy(PlayerProxy):getRawData()[id2res(arg_10_1.resType)] < arg_10_1.resCount then
		if arg_10_1.resType == 4 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_error_entendFail"))
		end
	else
		self:emit(BackyardFeedMediator.EXTEND, arg_10_1.shopId, 1)
	end

	self:Hide()

	return
end

function BackyardFeedExtendPage:Hide()
	BackyardFeedExtendPage.super.Hide(self)

	return
end

function BackyardFeedExtendPage:OnDestroy()
	self:Hide()

	return
end

return BackyardFeedExtendPage
