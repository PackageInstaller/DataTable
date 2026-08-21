local var_0_0 = class("ShipEvaluationLayer", import("..base.BaseUI"))

var_0_0.EVENT_LIKE = "event like"
var_0_0.EVENT_EVA = "event eva"
var_0_0.EVENT_ZAN = "event zan"
var_0_0.EVENT_IMPEACH = "event impeach"

function var_0_0.getUIName(arg_1_0)
	return "EvaluationUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.mainPanel = arg_2_0._tf:Find("mainPanel")
	arg_2_0.head = arg_2_0.mainPanel:Find("bg/left_panel/ship_tpl")
	arg_2_0.labelHeart = arg_2_0.mainPanel:Find("bg/left_panel/evaluation_count/heart")
	arg_2_0.labelEva = arg_2_0.mainPanel:Find("bg/left_panel/evaluation_count/count")
	arg_2_0.btnLike = arg_2_0.mainPanel:Find("bg/left_panel/btnLike")
	arg_2_0.btnEva = arg_2_0.mainPanel:Find("bg/bottom_panel/send_btn")
	arg_2_0.input = arg_2_0.mainPanel:Find("bg/bottom_panel/Input")
	arg_2_0.inputText = arg_2_0.input:Find("Text")
	arg_2_0.list = arg_2_0.mainPanel:Find("bg/right_panel/list")
	arg_2_0.hotContent = arg_2_0.list:Find("content/hots")
	arg_2_0.commonContent = arg_2_0.list:Find("content/commons")
	arg_2_0.hotTpl = arg_2_0.list:Find("content/hot_tpl")
	arg_2_0.commonTpl = arg_2_0.list:Find("content/commom_tpl")
	arg_2_0.iconType = findTF(arg_2_0.head, "content/main_bg/type_mask/type_icon"):GetComponent(typeof(Image))
	arg_2_0.imageBg = findTF(arg_2_0.head, "content/icon_bg"):GetComponent(typeof(Image))
	arg_2_0.imageFrame = findTF(arg_2_0.head, "content/main_bg/frame")
	arg_2_0.iconShip = findTF(arg_2_0.head, "content/icon"):GetComponent(typeof(Image))
	arg_2_0.labelName = findTF(arg_2_0.head, "content/main_bg/name_mask/name"):GetComponent(typeof(Text))
	arg_2_0.scrollText = findTF(arg_2_0.head, "content/main_bg/name_mask/name"):GetComponent(typeof(ScrollText))
	arg_2_0.stars = findTF(arg_2_0.head, "content/main_bg/stars")
	arg_2_0.star = findTF(arg_2_0.stars, "tpl")
	arg_2_0.bg = arg_2_0._tf:Find("BG")
	arg_2_0.btnHelp = arg_2_0._tf:Find("mainPanel/bg/top_panel/title/help")

	setActive(arg_2_0.btnHelp, getProxy(PlayerProxy):getRawData():IsOpenShipEvaluationImpeach())
	arg_2_0:initImpeachPanel()
	setActive(arg_2_0.mainPanel, true)
	setActive(arg_2_0.impackPanel, false)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.onBackPressed(arg_3_0)
	if isActive(arg_3_0.impackPanel) then
		setActive(arg_3_0.mainPanel, true)
		setActive(arg_3_0.impackPanel, false)
	else
		arg_3_0:closeView()
	end

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.bg, function()
		arg_4_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("mainPanel/bg/top_panel/btnBack"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("report_sent_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnLike, function()
		arg_4_0:emit(var_0_0.EVENT_LIKE)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnEva, function()
		local var_9_0 = getInputText(arg_4_0.input)

		if string.len(var_9_0) > 0 then
			setInputText(arg_4_0.input, "")
			arg_4_0:emit(var_0_0.EVENT_EVA, var_9_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("eva_comment_send_null"))
		end

		return
	end, SFX_PANEL)
	onInputChanged(arg_4_0, arg_4_0.input, function()
		local var_10_0 = getInputText(arg_4_0.input)
		local var_10_1
		local var_10_2

		if string.len(var_10_0) > 0 then
			if arg_4_0.shipGroup.evaluation.ievaCount >= CollectionProxy.MAX_DAILY_EVA_COUNT then
				var_10_1 = true
				var_10_2 = i18n("eva_count_limit")
			elseif wordVer(var_10_0) > 0 then
				var_10_1 = true
				var_10_2 = i18n("invalidate_evaluation")
			end
		end

		if var_10_1 then
			setTextColor(arg_4_0.inputText, Color.red)
			setButtonEnabled(arg_4_0.btnEva, false)
			pg.TipsMgr.GetInstance():ShowTips(var_10_2)
		else
			setTextColor(arg_4_0.inputText, Color.white)
			setButtonEnabled(arg_4_0.btnEva, true)
		end

		return
	end)

	return
end

function var_0_0.setShipGroup(arg_11_0, arg_11_1)
	arg_11_0.shipGroup = arg_11_1

	return
end

function var_0_0.setShowTrans(arg_12_0, arg_12_1)
	arg_12_0.showTrans = arg_12_1

	return
end

function var_0_0.flushAll(arg_13_0)
	arg_13_0:flushShip()
	arg_13_0:flushHeart()
	arg_13_0:flushEva()

	return
end

function var_0_0.flushShip(arg_14_0)
	local var_14_0 = arg_14_0.shipGroup:rarity2bgPrint(arg_14_0.showTrans)

	setShipCardFrame(arg_14_0.imageFrame, var_14_0, nil)
	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_14_0, "", arg_14_0.imageBg)

	arg_14_0.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

	LoadImageSpriteAsync("shipYardIcon/" .. arg_14_0.shipGroup:getPainting(arg_14_0.showTrans), arg_14_0.iconShip)

	arg_14_0.labelName.text = arg_14_0.shipGroup:getName(arg_14_0.showTrans)

	if arg_14_0.scrollText then
		arg_14_0.scrollText:SetText(arg_14_0.shipGroup:getName(arg_14_0.showTrans))
	end

	local var_14_1 = GetSpriteFromAtlas("shiptype", shipType2print(arg_14_0.shipGroup:getShipType(arg_14_0.showTrans)))

	if not var_14_1 then
		warning("找不到船形, shipConfigId: " .. arg_14_0.shipGroup.shipConfig.id)
	end

	arg_14_0.iconType.sprite = var_14_1

	for iter_14_0 = arg_14_0.stars.childCount, pg.ship_data_template[arg_14_0.shipGroup.shipConfig.id].star_max - 1 do
		local var_14_2 = cloneTplTo(arg_14_0.star, arg_14_0.stars)
	end

	return
end

function var_0_0.flushHeart(arg_15_0)
	setButtonEnabled(arg_15_0.btnLike, not arg_15_0.shipGroup.iheart)
	setText(arg_15_0.labelHeart, arg_15_0.shipGroup.evaluation.hearts)

	return
end

function var_0_0.flushEva(arg_16_0)
	setText(arg_16_0.labelEva, arg_16_0.shipGroup.evaluation.evaCount)

	for iter_16_0 = 1, arg_16_0.hotContent.childCount do
		local var_16_0 = go(arg_16_0.hotContent:GetChild(iter_16_0 - 1))

		if var_16_0.name ~= "tag" then
			Destroy(var_16_0)
		end
	end

	for iter_16_1 = 1, arg_16_0.commonContent.childCount do
		local var_16_1 = go(arg_16_0.commonContent:GetChild(iter_16_1 - 1))

		if var_16_1.name ~= "tag" then
			Destroy(var_16_1)
		end
	end

	local var_16_2 = getProxy(PlayerProxy):getRawData():IsOpenShipEvaluationImpeach()

	for iter_16_2 = 1, #arg_16_0.shipGroup.evaluation.evas do
		local var_16_3
		local var_16_4 = arg_16_0.shipGroup.evaluation.evas[iter_16_2]

		var_16_3 = arg_16_0.shipGroup.evaluation.evas[iter_16_2].hot and cloneTplTo(arg_16_0.hotTpl, arg_16_0.hotContent) or cloneTplTo(arg_16_0.commonTpl, arg_16_0.commonContent)

		local var_16_5 = var_16_3:Find("bg/evaluation"):GetComponent(typeof(Text))
		local var_16_6 = var_16_3:Find("bg/zan_bg/Text")

		setText(var_16_3:Find("bg/name"), var_16_4.nick_name .. ":")
		setText(var_16_6, var_16_4.good_count - var_16_4.bad_count)

		var_16_5.supportRichText = false
		var_16_5.text = var_16_4.context

		local function var_16_7(arg_17_0)
			if not var_16_4.izan then
				arg_16_0:emit(var_0_0.EVENT_ZAN, var_16_4.id, arg_17_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("zan_ship_eva_error_7"))
			end

			return
		end

		onButton(arg_16_0, var_16_3:Find("bg/zan_bg/up"), function()
			var_16_7(0)

			return
		end, SFX_PANEL)
		onButton(arg_16_0, var_16_3:Find("bg/zan_bg/down"), function()
			var_16_7(1)

			return
		end, SFX_PANEL)
		onButton(arg_16_0, var_16_3:Find("bg/zan_bg/impeach"), function()
			arg_16_0:openImpeachPanel(var_16_4.id)

			return
		end, SFX_PANEL)
		SetActive(var_16_3:Find("bg/zan_bg/down"), not defaultValue(LOCK_DOWNVOTE, true))
		setActive(var_16_3:Find("bg/zan_bg/impeach"), var_16_2)
	end

	local var_16_8 = 1

	for iter_16_3 = 1, arg_16_0.hotContent.childCount do
		local var_16_9 = arg_16_0.hotContent:GetChild(iter_16_3 - 1)

		if go(var_16_9).name ~= "tag" then
			setActive(var_16_9:Find("print1"), var_16_8 % 2 ~= 0)
			setActive(var_16_9:Find("print2"), var_16_8 % 2 == 0)

			var_16_8 = var_16_8 + 1
		end
	end

	setActive(arg_16_0.hotContent:Find("tag"), arg_16_0.hotContent.childCount > 1)
	setActive(arg_16_0.commonContent:Find("tag"), arg_16_0.commonContent.childCount > 1)
	arg_16_0.hotContent:Find("tag"):SetAsLastSibling()
	arg_16_0.commonContent:Find("tag"):SetAsLastSibling()

	return
end

local var_0_1 = 3

function var_0_0.initImpeachPanel(arg_21_0)
	arg_21_0.impackPanel = arg_21_0._tf:Find("impeachPanel")

	setText(arg_21_0.impackPanel:Find("window/top/bg/impeach/title"), i18n("report_sent_title"))
	onButton(arg_21_0, arg_21_0.impackPanel:Find("window/top/btnBack"), function()
		arg_21_0:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_21_0 = arg_21_0.impackPanel:Find("window/msg_panel/content")

	setText(var_21_0:Find("title"), i18n("report_sent_desc"))

	local var_21_1 = UIItemList.New(var_21_0:Find("options"), var_21_0:Find("options/tpl"))

	var_21_1:make(function(arg_23_0, arg_23_1, arg_23_2)
		arg_23_1 = arg_23_1 + 1

		if arg_23_0 == UIItemList.EventUpdate then
			setText(arg_23_2:Find("Text"), i18n("report_type_" .. arg_23_1))
			setText(arg_23_2:Find("Text_2"), i18n("report_type_" .. arg_23_1 .. "_1"))
			onToggle(arg_21_0, arg_23_2, function(arg_24_0)
				arg_21_0.impeachOption = arg_23_1

				return
			end)
		end

		return
	end)
	var_21_1:align(var_0_1)
	setText(var_21_0:Find("other/field/Text"), i18n("report_type_other"))
	setText(var_21_0:Find("other/field/input/Placeholder"), i18n("report_type_other_1"))
	onToggle(arg_21_0, var_21_0:Find("other"), function(arg_25_0)
		arg_21_0.impeachOption = "other"

		setActive(var_21_0:Find("other/field/input"), arg_25_0)

		return
	end)
	onInputChanged(arg_21_0, var_21_0:Find("other/field/input"), function()
		Canvas.ForceUpdateCanvases()

		return
	end)
	onButton(arg_21_0, arg_21_0.impackPanel:Find("window/button_container/button"), function()
		if arg_21_0.impeachOption == "other" then
			local var_27_0 = getInputText(var_0)

			if string.len(var_27_0) > 0 then
				arg_21_0:emit(var_0_0.EVENT_IMPEACH, arg_21_0.targetEvaId, i18n("report_type_other") .. ":" .. var_27_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("report_type_other_2"))

				return
			end
		else
			arg_21_0:emit(var_0_0.EVENT_IMPEACH, arg_21_0.targetEvaId, i18n("report_type_" .. arg_21_0.impeachOption))
		end

		arg_21_0:onBackPressed()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.openImpeachPanel(arg_28_0, arg_28_1)
	arg_28_0.targetEvaId = arg_28_1

	setActive(arg_28_0.mainPanel, false)
	setActive(arg_28_0.impackPanel, true)
	triggerToggle(arg_28_0.impackPanel:Find("window/msg_panel/content/other"), true)
	triggerToggle(arg_28_0.impackPanel:Find("window/msg_panel/content/options/tpl"), true)

	return
end

function var_0_0.willExit(arg_29_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_29_0._tf)

	return
end

return var_0_0
