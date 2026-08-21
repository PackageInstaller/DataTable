local var_0_0 = class("CompensateScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CompensateUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return false
end

var_0_0.optionsPath = {
	"adapt/top/option"
}

function var_0_0.quickExitFunc(arg_3_0)
	arg_3_0:emit(var_0_0.ON_HOME)

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.proxy = getProxy(CompensateProxy)
	arg_4_0.rtAdapt = arg_4_0._tf:Find("adapt")

	setText(arg_4_0.rtAdapt:Find("top/title"), i18n("compensate_ui_title1"))
	setText(arg_4_0.rtAdapt:Find("top/title/Text"), i18n("compensate_ui_title2"))
	onButton(arg_4_0, arg_4_0.rtAdapt:Find("top/back_btn"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	arg_4_0.rtLabels = arg_4_0.rtAdapt:Find("left_length/frame/tagRoot")

	eachChild(arg_4_0.rtLabels, function(arg_6_0)
		if arg_6_0.name == "mail" then
			toggleName = i18n("compensate_ui_title1")
		end

		setText(arg_6_0:Find("unSelect/Text"), toggleName)
		setText(arg_6_0:Find("selected/Text"), toggleName)
		onToggle(arg_4_0, arg_6_0, function(arg_7_0)
			if arg_7_0 then
				arg_4_0:SetPage()
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_4_0 = arg_4_0.rtAdapt:Find("main/content")

	arg_4_0.rtMailLeft = var_4_0:Find("left/left_content")
	arg_4_0.lsrMailList = arg_4_0.rtMailLeft:Find("middle/container"):GetComponent("LScrollRect")

	function arg_4_0.lsrMailList.onUpdateItem(arg_8_0, arg_8_1)
		arg_8_0 = arg_8_0 + 1

		local var_8_0 = tf(arg_8_1)
		local var_8_1 = arg_4_0.filterMails[arg_8_0]

		onToggle(arg_4_0, var_8_0, function(arg_9_0)
			if arg_9_0 then
				if arg_4_0.selectMailId ~= var_8_1.id then
					arg_4_0:UpdateMailContent(var_8_1)
				end
			elseif var_8_1.id == arg_4_0.selectMailId then
				arg_4_0:UpdateMailContent(nil)
			end

			return
		end, SFX_PANEL)
		arg_4_0:UpdateMailTpl(var_8_0, arg_4_0.filterMails[arg_8_0])

		return
	end

	arg_4_0.rtMailRight = var_4_0:Find("right")
	arg_4_0.rtBtnRightGet = arg_4_0.rtMailRight:Find("bottom/btn_get")

	onButton(arg_4_0, arg_4_0.rtBtnRightGet, function()
		assert(arg_4_0.selectMailId)
		arg_4_0:emit(CompensateMediator.ON_GET_REWARD, {
			reward_id = arg_4_0.selectMailId
		})

		return
	end, SFX_PANEL)

	arg_4_0.rtMailEmpty = var_4_0:Find("empty")

	setText(arg_4_0.rtBtnRightGet:Find("Text"), i18n("mail_getone_button"))
	arg_4_0:InitResBar()

	return
end

function var_0_0.SetPage(arg_11_0)
	arg_11_0:UpdateMailList()

	return
end

function var_0_0.didEnter(arg_12_0)
	onNextTick(function()
		arg_12_0.lsrMailList.enabled = true

		triggerToggle(arg_12_0.rtLabels:Find("mail"), true)

		return
	end)

	return
end

function var_0_0.UpdateMailList(arg_14_0)
	arg_14_0.filterMails = arg_14_0.proxy:GetAllRewardList()

	table.sort(arg_14_0.filterMails, CompareFuncs({
		function(arg_15_0)
			return -arg_15_0.date
		end,
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))

	if #arg_14_0.filterMails == 0 then
		setActive(arg_14_0.rtMailLeft, false)
		setActive(arg_14_0.rtMailRight, false)
		setActive(arg_14_0.rtMailEmpty, true)
		setText(arg_14_0.rtMailEmpty:Find("Text"), i18n("compensate_ui_nothing1"))
		setText(arg_14_0.rtMailEmpty:Find("Text_en"), i18n("compensate_ui_nothing2"))
	else
		setActive(arg_14_0.rtMailLeft, true)
		setActive(arg_14_0.rtMailRight, true)
		setActive(arg_14_0.rtMailEmpty, false)

		if not arg_14_0.selectMailId then
			arg_14_0:UpdateMailContent(arg_14_0.filterMails[1])
		end

		local var_14_1 = delta or -1

		var_14_0(arg_14_0.lsrMailList, #arg_14_0.filterMails, var_14_1)
	end

	return
end

function var_0_0.UpdateMailTpl(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("content")

	setActive(var_17_0:Find("icon/no_attachment"), #arg_17_2.attachments == 0)
	setActive(var_17_0:Find("icon/IconTpl"), #arg_17_2.attachments > 0)

	if #arg_17_2.attachments > 0 then
		updateDrop(var_17_0:Find("icon/IconTpl"), arg_17_2.attachments[1])
	end

	setText(var_17_0:Find("info/title/Text"), shortenString(arg_17_2.title, 10))
	setText(var_17_0:Find("info/time/Text"), os.date("%Y-%m-%d", arg_17_2.date))

	local var_17_1 = arg_17_2.timestamp - pg.TimeMgr.GetInstance():GetServerTime()

	if math.floor(var_17_1 / 0) >= 1 then
		setText(var_17_0:Find("info/time/out_time/Text"), i18n("compensate_ui_expiration_day", math.floor(var_17_1 / 0)))
	else
		setText(var_17_0:Find("info/time/out_time/Text"), i18n("compensate_ui_expiration_hour", math.floor(var_17_1 / 16)))
	end

	setActive(arg_17_1:Find("got_mark"), arg_17_2.attachFlag)
	setText(arg_17_1:Find("got_mark/got_text"), i18n("mail_reward_got"))
	setActive(arg_17_1:Find("hasread_bg"), true)
	setActive(arg_17_1:Find("noread_bg"), false)

	local var_17_2 = SummerFeastScene.TransformColor("FFFFFF")

	setTextColor(var_17_0:Find("info/title/Text"), var_17_2)
	setTextColor(var_17_0:Find("info/time/Text"), var_17_2)
	triggerToggle(arg_17_1, arg_17_0.selectMailId == arg_17_2.id)

	return
end

function var_0_0.UpdateMailContent(arg_18_0, arg_18_1)
	eachChild(arg_18_0.rtMailRight, function(arg_19_0)
		setActive(arg_19_0, tobool(arg_18_1))

		return
	end)

	if not arg_18_1 then
		arg_18_0.selectMailId = nil

		return
	end

	arg_18_0.selectMailId = arg_18_1.id

	changeToScrollText(arg_18_0.rtMailRight:Find("main/title/info/Text"), i18n2(arg_18_1.title))
	setText(arg_18_0.rtMailRight:Find("main/from/Text"), arg_18_1.sender)
	setText(arg_18_0.rtMailRight:Find("main/time/Text"), os.date("%Y-%m-%d", arg_18_1.date))
	setText(arg_18_0.rtMailRight:Find("main/view/content/text/Text"), arg_18_1.text)

	local var_18_0 = arg_18_0.rtMailRight:Find("main/view/content/attachment")

	setText(var_18_0:Find("got/Text"), i18n("main_mailLayer_attachTaken"))
	setActive(arg_18_0.rtBtnRightGet, not arg_18_1.attachFlag)
	setActive(var_18_0, #arg_18_1.attachments > 0)

	if #arg_18_1.attachments > 0 then
		local var_18_1 = var_18_0:Find("content")

		UIItemList.StaticAlign(var_18_1, var_18_1:Find("IconTpl"), #arg_18_1.attachments, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1

			if arg_20_0 == UIItemList.EventUpdate then
				updateDrop(arg_20_2, arg_18_1.attachments[arg_20_1])
				onButton(arg_18_0, arg_20_2, function()
					arg_18_0:emit(var_0_0.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end

			return
		end)

		local var_18_2 = arg_18_1.attachFlag

		setCanvasGroupAlpha(var_18_1, arg_18_1.attachFlag and 0.5 or 1)
		setActive(var_18_0:Find("got"), var_18_2)
	end

	return
end

function var_0_0.onBackPressed(arg_22_0)
	triggerButton(arg_22_0.rtAdapt:Find("top/back_btn"))

	return
end

function var_0_0.willExit(arg_23_0)
	return
end

function var_0_0.UpdateOperationDeal(arg_24_0)
	arg_24_0:UpdateMailList()

	if arg_24_0.selectMailId then
		arg_24_0:UpdateMailContent(underscore.detect(arg_24_0.filterMails, function(arg_25_0)
			return arg_25_0.id == arg_24_0.selectMailId
		end))
	end

	return
end

function var_0_0.InitResBar(arg_26_0)
	arg_26_0.resBar = arg_26_0._tf:Find("adapt/top/res")
	arg_26_0.goldMax = arg_26_0.resBar:Find("gold/max"):GetComponent(typeof(Text))
	arg_26_0.goldValue = arg_26_0.resBar:Find("gold/Text"):GetComponent(typeof(Text))
	arg_26_0.oilMax = arg_26_0.resBar:Find("oil/max"):GetComponent(typeof(Text))
	arg_26_0.oilValue = arg_26_0.resBar:Find("oil/Text"):GetComponent(typeof(Text))
	arg_26_0.gemValue = arg_26_0.resBar:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(arg_26_0, arg_26_0.resBar:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_26_0, arg_26_0.resBar:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_26_0, arg_26_0.resBar:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	arg_26_0:UpdateRes()

	return
end

function var_0_0.UpdateRes(arg_30_0)
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_30_0.goldMax, arg_30_0.goldValue, arg_30_0.oilMax, arg_30_0.oilValue, arg_30_0.gemValue)

	return
end

return var_0_0
