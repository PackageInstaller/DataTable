local var_0_0 = class("MailRewardWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MailRewardMsgboxUI"
end

function var_0_0.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.closeBtn = arg_2_0._tf:Find("adapt/window/top/btnBack")

	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.cancelButton = arg_2_0._tf:Find("adapt/window/button_container/btn_not")
	arg_2_0.confirmButton = arg_2_0._tf:Find("adapt/window/button_container/btn_ok")
	arg_2_0._window = arg_2_0._tf:Find("adapt/window")
	arg_2_0.item_panel = arg_2_0._window:Find("item_panel")
	arg_2_0.reward_gold = arg_2_0.item_panel:Find("parentAdpter/textAdpter/reward_gold")
	arg_2_0.reward_goldText = arg_2_0.reward_gold:Find("gold_text")
	arg_2_0.reward_oil = arg_2_0.item_panel:Find("parentAdpter/textAdpter/reward_oil")
	arg_2_0.reward_oilText = arg_2_0.reward_oil:Find("oil_text")
	arg_2_0._itemListItemContainer = arg_2_0.item_panel:Find("parentAdpter/rewardAdpter/list")
	arg_2_0._itemListItemTpl = arg_2_0.item_panel:Find("parentAdpter/rewardAdpter/item")
	arg_2_0.titleTips = arg_2_0._window:Find("top/bg/infomation/title")

	setText(arg_2_0.reward_goldText, i18n("mail_storeroom_max_4"))
	setText(arg_2_0.reward_oilText, i18n("mail_storeroom_max_3"))
	setText(arg_2_0.titleTips, i18n("mail_boxtitle_information"))
	setText(arg_2_0.item_panel:Find("parentAdpter/rewardAdpter/Text"), i18n("mail_storeroom_collect"))
	setText(arg_2_0.cancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(arg_2_0.confirmButton:Find("Text"), i18n("mail_box_confirm"))

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	var_0_0.super.Show(arg_5_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)
	onButton(arg_5_0, arg_5_0.cancelButton, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.confirmButton, function()
		arg_5_0:Hide()

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
		table.insert({}, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResOil,
			count = arg_5_1.content.oil
		}))

		var_5_2 = var_5_0:getResource(PlayerConst.ResOil) + arg_5_1.content.oil >= var_5_0:getLevelMaxOil()
	end

	if arg_5_1.content.gold > 0 then
		table.insert({}, Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = arg_5_1.content.gold
		}))

		var_5_1 = var_5_0:getResource(PlayerConst.ResGold) + arg_5_1.content.gold >= var_5_0:getLevelMaxGold()
	end

	setActive(arg_5_0.reward_oil, var_5_2)
	setActive(arg_5_0.reward_gold, var_5_1)

	local var_5_4 = var_5_1 or var_5_2

	setActive(arg_5_0.item_panel:Find("parentAdpter/textAdpter"), var_5_1 or var_5_2)
	UIItemList.StaticAlign(arg_5_0._itemListItemContainer, arg_5_0._itemListItemTpl, #{}, function(arg_8_0, arg_8_1, arg_8_2)
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
	arg_5_0.item_panel:Find("parentAdpter"):GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup)).padding = var_5_6

	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)
	var_0_0.super.Hide(arg_9_0)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
