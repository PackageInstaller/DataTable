local var_0_0 = class("NewEducateChooseLayer", import("view.newEducate.base.NewEducateBaseUI"))

var_0_0.TYPE = {
	ENTYR = 2,
	TAROT = 1
}

function var_0_0.getUIName(arg_1_0)
	return "NewEducateChooseUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	seriesAsync({
		function(arg_3_0)
			local var_3_0 = getProxy(NewEducateProxy):GetCurChar()

			if #var_3_0:GetFSM():GetPriorityState():GetChoices() > 0 then
				arg_3_0()
			else
				pg.m02:sendNotification(GAME.NEW_EDUCATE_REQUEST_CHOICES, {
					id = var_3_0.id,
					callback = arg_3_0
				})
			end

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.blockTF = arg_4_0._tf:Find("block")

	setActive(arg_4_0.blockTF, true)

	arg_4_0.showPanel = arg_4_0._tf:Find("show_panel")

	setText(arg_4_0.showPanel:Find("title"), i18n("child2_choose_title"))

	arg_4_0.tipBtn = arg_4_0.showPanel:Find("tip")

	setText(arg_4_0.showPanel:Find("refresh/Text"), i18n("child2_refresh_title"))

	arg_4_0.refreshCntText = arg_4_0.showPanel:Find("refresh/value"):GetComponent(typeof(Text))
	arg_4_0.toggleTF = arg_4_0.showPanel:Find("toggle")

	setText(arg_4_0.toggleTF:Find("Text"), i18n("child2_show_detail_desc"))

	arg_4_0.tarotTF = arg_4_0.showPanel:Find("current/tarot")
	arg_4_0.tarotCard = NewEducateTarotCard.New(arg_4_0.tarotTF)
	arg_4_0.emptyTarotTF = arg_4_0.showPanel:Find("current/empty")

	setText(arg_4_0.emptyTarotTF:Find("Text"), i18n("child2_tarot_empty"))

	arg_4_0.tarotUIList = UIItemList.New(arg_4_0.showPanel:Find("tarot_list"), arg_4_0.showPanel:Find("tarot_list/tpl"))

	arg_4_0.tarotUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_5_2.name = arg_5_1 + 1
			arg_4_0.cards[arg_5_1 + 1] = NewEducateTarotCard.New(arg_5_2)
		elseif arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateTarotChoice(arg_5_1, arg_5_2)
		end

		return
	end)

	arg_4_0.entryUIList = UIItemList.New(arg_4_0.showPanel:Find("entry_list"), arg_4_0.showPanel:Find("entry_list/tpl"))

	arg_4_0.entryUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			arg_6_2.name = arg_6_1 + 1
			arg_4_0.cards[arg_6_1 + 1] = NewEducateEntryCard.New(arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateEntryChoice(arg_6_1, arg_6_2)
		end

		return
	end)

	arg_4_0.giveupBtn = arg_4_0.showPanel:Find("btns/giveup")

	setText(arg_4_0.giveupBtn:Find("Text"), i18n("child2_choose_giveup"))

	arg_4_0.hideBtn = arg_4_0.showPanel:Find("btns/hide")

	setText(arg_4_0.hideBtn:Find("Text"), i18n("child2_choose_hide"))

	arg_4_0.hidePanel = arg_4_0._tf:Find("hide_panel")
	arg_4_0.showBtn = arg_4_0.hidePanel:Find("show")

	setActive(arg_4_0.showPanel, true)
	setActive(arg_4_0.hidePanel, false)

	arg_4_0.emptyIds = pg.gameset.child2_pool_exhausted_token.description

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.tipBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_choose_help.tip
		})

		return
	end, SFX_PANEL)
	onToggle(arg_7_0, arg_7_0.toggleTF, function(arg_9_0)
		NewEducateHelper.SetTarotDeatilDescData(arg_9_0)
		arg_7_0:SwitchDescMode(arg_9_0)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.giveupBtn, function()
		arg_7_0:emit(NewEducateChooseMediator.ON_GIVE_UP_CHOICE)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.hideBtn, function()
		arg_7_0:UnOverlayPanel(arg_7_0._tf)
		setActive(arg_7_0.showPanel, false)
		setActive(arg_7_0.hidePanel, true)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.showBtn, function()
		setActive(arg_7_0.showPanel, true)
		setActive(arg_7_0.hidePanel, false)
		arg_7_0:BlurPanel(arg_7_0._tf, {
			groupDelta = 3
		})

		return
	end, SFX_PANEL)

	arg_7_0.config = pg.child2_benefit_list
	arg_7_0.tarotRefreshCnt = pg.gameset.child2_tarot_refresh_limit.key_value
	arg_7_0.entryRefreshCnt = pg.gameset.child2_effect_refresh_limit.key_value
	arg_7_0.cards = {}

	arg_7_0:UpdateView()
	triggerButton(arg_7_0.showBtn)
	triggerToggle(arg_7_0.toggleTF, NewEducateHelper.IsShowTarotDeatilDesc())
	NewEducateGuideSequence.CheckGuide(arg_7_0.__cname)

	arg_7_0.isMaked = false

	onDelayTick(function()
		setActive(arg_7_0.blockTF, false)

		return
	end, tonumber(pg.gameset.child2_select_sleep_time.description))

	return
end

function var_0_0.IsPoolEmpty(arg_14_0)
	return underscore.any(arg_14_0.emptyIds, function(arg_15_0)
		return table.contains(arg_14_0.choices, arg_15_0)
	end)
end

function var_0_0.UpdateView(arg_16_0)
	arg_16_0.tarotId = arg_16_0.contextData.char:GetTarotId()
	arg_16_0.state = arg_16_0.contextData.char:GetFSM():GetPriorityState()
	arg_16_0.choices = arg_16_0.state:GetChoices()
	arg_16_0.usedCnts = arg_16_0.state:GetUsedCnts()

	arg_16_0:UpdateRefreshCnt()

	if arg_16_0.config[arg_16_0.choices[1]].type == NewEducateBuff.TYPE.TAROT then
		arg_16_0.type = var_0_0.TYPE.TAROT or var_0_0.TYPE.ENTYR

		arg_16_0:UpdateTarotPanel()
		arg_16_0:UpdateGiveUpBtn()
		arg_16_0:UpdateChoices()
		setActive(arg_16_0.hideBtn, arg_16_0.tarotId)

		return
	end
end

function var_0_0.UpdateRefreshCnt(arg_17_0)
	arg_17_0.refreshCnt = arg_17_0.contextData.char:GetResByType(NewEducateChar.RES_TYPE.REFRESH_CHOICE)
	arg_17_0.refreshCntText.text = arg_17_0.refreshCnt

	return
end

function var_0_0.UpdateTarotPanel(arg_18_0)
	setActive(arg_18_0.emptyTarotTF, not arg_18_0.tarotId)
	setActive(arg_18_0.tarotTF, arg_18_0.tarotId)

	if arg_18_0.tarotId then
		arg_18_0.tarotCard:Update(arg_18_0.tarotId, NewEducateTarotCard.TYPE.CURRENT)
	end

	return
end

function var_0_0.UpdateGiveUpBtn(arg_19_0)
	setActive(arg_19_0.giveupBtn, arg_19_0.tarotId)

	if arg_19_0.tarotId then
		local var_19_0 = arg_19_0.contextData.char:getConfig(arg_19_0.state:IsFromShop() and "shop_disclaim_refund" or "event_disclaim_refund")

		if arg_19_0.type == var_0_0.TYPE.TAROT then
			local var_19_1 = var_19_0[2] or var_19_0[2]

			setText(arg_19_0.giveupBtn:Find("res/Text"), "+" .. var_19_1[3])

			return
		end
	end
end

function var_0_0.UpdateChoices(arg_20_0)
	setActive(arg_20_0.tarotUIList.container, arg_20_0.type == var_0_0.TYPE.TAROT)
	setActive(arg_20_0.entryUIList.container, arg_20_0.type == var_0_0.TYPE.ENTYR)

	if arg_20_0.type == var_0_0.TYPE.TAROT then
		var_20_0:align(#arg_20_0.choices)

		return
	end
end

function var_0_0.UpdateTarotChoice(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 + 1

	arg_21_0.cards[arg_21_1 + 1]:Update(arg_21_0.choices[arg_21_1 + 1])
	onButton(arg_21_0, arg_21_2, function()
		seriesAsync({
			function(arg_23_0)
				if arg_21_0.tarotId then
					arg_21_0:emit(var_0_0.ON_BOX, {
						content = i18n("child2_replace_sure_tip"),
						onYes = arg_23_0
					})
				else
					arg_23_0()
				end

				return
			end
		}, function()
			arg_21_0:emit(NewEducateChooseMediator.ON_MAKE_CHOICE, var_21_0)

			return
		end)

		return
	end, SFX_PANEL)
	arg_21_0:UpdateRefreshBtn(arg_21_1 + 1, arg_21_2:Find("refresh_blue"), arg_21_2:Find("refresh_grey"))

	return
end

function var_0_0.UpdateEntryChoice(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1 + 1

	arg_25_0.cards[arg_25_1 + 1]:Update(arg_25_0.choices[arg_25_1 + 1])
	onButton(arg_25_0, arg_25_2, function()
		if arg_25_0.isMaked then
			return
		end

		arg_25_0:emit(NewEducateChooseMediator.ON_MAKE_CHOICE, var_25_0)

		arg_25_0.isMaked = true

		return
	end, SFX_PANEL)
	arg_25_0:UpdateRefreshBtn(arg_25_1 + 1, arg_25_2:Find("refresh_blue"), arg_25_2:Find("refresh_grey"))

	return
end

function var_0_0.UpdateRefreshBtn(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0.usedCnts[arg_27_1]

	if arg_27_0.type == var_0_0.TYPE.TAROT then
		local var_27_1 = arg_27_0.tarotRefreshCnt or arg_27_0.entryRefreshCnt
		local var_27_2 = var_27_1 - var_27_0
		local var_27_3 = arg_27_0.refreshCnt > 0 and var_27_2 > 0
		local var_27_4 = arg_27_0:IsPoolEmpty()

		setText(arg_27_2:Find("Text"), math.min(var_27_1 - var_27_0, arg_27_0.refreshCnt))
		setText(arg_27_3:Find("Text"), math.min(var_27_2, arg_27_0.refreshCnt))
		setActive(arg_27_2, var_27_3 and not var_27_4)
		setActive(arg_27_3, not var_27_3 or var_27_4)
		onButton(arg_27_0, arg_27_2, function()
			if not var_27_3 then
				return
			end

			arg_27_0:emit(NewEducateChooseMediator.ON_REFRESH_CHOICE, arg_27_1)

			return
		end, SFX_PANEL)
		onButton(arg_27_0, arg_27_3, function()
			if not var_27_4 then
				return
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_pool_exhausted"))

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.GetUIList(arg_30_0)
	if arg_30_0.type == var_0_0.TYPE.TAROT then
		return arg_30_0.tarotUIList or arg_30_0.entryUIList
	end
end

function var_0_0.SwitchDescMode(arg_31_0, arg_31_1)
	if arg_31_0.tarotId then
		arg_31_0.tarotCard:UpdateDescMode(arg_31_1)
	end

	arg_31_0:GetUIList():eachActive(function(arg_32_0, arg_32_1)
		arg_31_0.cards[arg_32_0 + 1]:UpdateDescMode(arg_31_1)

		return
	end)

	return
end

function var_0_0.UpdateDataAfterRefresh(arg_33_0)
	arg_33_0.state = arg_33_0.contextData.char:GetFSM():GetPriorityState()
	arg_33_0.choices = arg_33_0.state:GetChoices()
	arg_33_0.usedCnts = arg_33_0.state:GetUsedCnts()

	arg_33_0:UpdateRefreshCnt()
	arg_33_0:GetUIList():eachActive(function(arg_34_0, arg_34_1)
		arg_33_0:UpdateRefreshBtn(arg_34_0 + 1, arg_34_1:Find("refresh_blue"), arg_34_1:Find("refresh_grey"))

		return
	end)

	return
end

function var_0_0.OnRefreshDone(arg_35_0, arg_35_1)
	arg_35_0:UpdateDataAfterRefresh()
	eachChild(arg_35_0:GetUIList().container, function(arg_36_0)
		if tonumber(arg_36_0.name) == arg_35_1.idx then
			local var_36_0 = arg_36_0:GetComponent(typeof(DftAniEvent))

			arg_36_0:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
				var_36_0:SetTriggerEvent(nil)
				arg_35_0.cards[arg_35_1.idx]:Update(arg_35_1.newId)
				arg_35_0.cards[arg_35_1.idx]:UpdateDescMode(arg_35_0.toggleTF:GetComponent(typeof(Toggle)).isOn)

				return
			end)
			arg_36_0:GetComponent(typeof(Animation)):Play(arg_35_0.type == var_0_0.TYPE.TAROT and "Anim_Neweducate_talent_tpl_change" or "Anim_Neweducate_tentry_tpl_change1")
		end

		return
	end)

	return
end

function var_0_0.OnMakeChoiceDone(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.type == var_0_0.TYPE.TAROT and "Anim_Neweducate_talent_tpl_out" or "Anim_Neweducate_entry_tpl_out1"

	eachChild(arg_38_0:GetUIList().container, function(arg_39_0)
		if tonumber(arg_39_0.name) ~= arg_38_1.idx then
			arg_39_0:GetComponent(typeof(Animation)):Play(var_38_0)
		end

		return
	end)
	seriesAsync({
		function(arg_40_0)
			onDelayTick(arg_40_0, 0.15)

			return
		end,
		function(arg_41_0)
			if #arg_38_1.drops > 0 then
				arg_38_0:emit(var_0_0.ON_DROP, {
					items = arg_38_1.drops,
					removeFunc = function()
						arg_41_0()

						return
					end
				})
			else
				arg_41_0()
			end

			return
		end
	}, function()
		arg_38_0:closeView()

		return
	end)

	return
end

function var_0_0.OnGiveUpDone(arg_44_0, arg_44_1)
	seriesAsync({
		function(arg_45_0)
			if #arg_44_1.drops > 0 then
				arg_44_0:emit(var_0_0.ON_DROP, {
					items = arg_44_1.drops,
					removeFunc = function()
						arg_45_0()

						return
					end
				})
			else
				arg_45_0()
			end

			return
		end
	}, function()
		arg_44_0:closeView()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_48_0)
	return
end

function var_0_0.willExit(arg_49_0)
	for iter_49_0, iter_49_1 in ipairs(arg_49_0.cards) do
		iter_49_1:Dispose()
	end

	arg_49_0.cards = {}

	arg_49_0.tarotCard:Dispose()
	arg_49_0:UnOverlayPanel(arg_49_0._tf)
	existCall(arg_49_0.contextData.onExit)

	return
end

return var_0_0
