local MailRewardWindow = class("MailRewardWindow", import("view.base.BaseSubView"))

function MailRewardWindow:getUIName()
	return "MailRewardMsgboxUI"
end

function MailRewardWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("adapt/window/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.cancelButton = self._tf:Find("adapt/window/button_container/btn_not")
	self.confirmButton = self._tf:Find("adapt/window/button_container/btn_ok")
	self._window = self._tf:Find("adapt/window")
	self.item_panel = self._window:Find("item_panel")
	self.reward_gold = self.item_panel:Find("parentAdpter/textAdpter/reward_gold")
	self.reward_goldText = self.reward_gold:Find("gold_text")
	self.reward_oil = self.item_panel:Find("parentAdpter/textAdpter/reward_oil")
	self.reward_oilText = self.reward_oil:Find("oil_text")
	self._itemListItemContainer = self.item_panel:Find("parentAdpter/rewardAdpter/list")
	self._itemListItemTpl = self.item_panel:Find("parentAdpter/rewardAdpter/item")
	self.titleTips = self._window:Find("top/bg/infomation/title")

	setText(self.reward_goldText, i18n("mail_storeroom_max_4"))
	setText(self.reward_oilText, i18n("mail_storeroom_max_3"))
	setText(self.titleTips, i18n("mail_boxtitle_information"))
	setText(self.item_panel:Find("parentAdpter/rewardAdpter/Text"), i18n("mail_storeroom_collect"))
	setText(self.cancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(self.confirmButton:Find("Text"), i18n("mail_box_confirm"))

	return
end

function MailRewardWindow:Show(arg_5_1)
	MailRewardWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.cancelButton, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmButton, function()
		self:Hide()

		if arg_5_1.onYes then
			arg_5_1.onYes()
		end

		return
	end, SFX_PANEL)

	local var_5_0 = getProxy(PlayerProxy):getData()
	local var_5_1 = false
	local var_5_2 = false
	local var_5_3 = {}

	if arg_5_1.content.oil > 0 then
		table.insert(var_5_3, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResOil,
			count = arg_5_1.content.oil
		}))

		var_5_2 = var_5_0:getResource(PlayerConst.ResOil) + arg_5_1.content.oil >= var_5_0:getLevelMaxOil()
	end

	if arg_5_1.content.gold > 0 then
		table.insert(var_5_3, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = arg_5_1.content.gold
		}))

		var_5_1 = var_5_0:getResource(PlayerConst.ResGold) + arg_5_1.content.gold >= var_5_0:getLevelMaxGold()
	end

	setActive(self.reward_oil, var_5_2)
	setActive(self.reward_gold, var_5_1)

	local var_5_4 = var_5_1 or var_5_2

	setActive(self.item_panel:Find("parentAdpter/textAdpter"), var_5_1 or var_5_2)
	UIItemList.StaticAlign(self._itemListItemContainer, self._itemListItemTpl, #var_5_3, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1

		if arg_8_0 == UIItemList.EventUpdate then
			updateDrop(arg_8_2:Find("IconTpl"), var_5_3[arg_8_1])
		end

		return
	end)

	local var_5_5 = var_5_4 and 17 or 32
	local var_5_6 = UnityEngine.RectOffset.New()

	var_5_6.bottom = 0
	var_5_6.left = 0
	var_5_6.right = 0
	var_5_6.top = var_5_5
	self.item_panel:Find("parentAdpter"):GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup)).padding = var_5_6

	Canvas.ForceUpdateCanvases()

	return
end

function MailRewardWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MailRewardWindow.super.Hide(self)

	return
end

function MailRewardWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MailRewardWindow
