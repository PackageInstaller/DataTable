local var_0_0 = class("NewEducateInfoPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateInfoPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.foldPanelTF = arg_2_0._tf:Find("fold_panel")
	arg_2_0.showBtn = arg_2_0.foldPanelTF:Find("show_btn")
	arg_2_0.showPanelTF = arg_2_0._tf:Find("show_panel")
	arg_2_0.showAnim = arg_2_0.showPanelTF:GetComponent(typeof(Animation))
	arg_2_0.showAnimEvent = arg_2_0.showPanelTF:GetComponent(typeof(DftAniEvent))

	arg_2_0.showAnimEvent:SetEndEvent(function()
		setActive(arg_2_0.showPanelTF, false)

		return
	end)

	arg_2_0.blurBg = arg_2_0.showPanelTF:Find("content")
	arg_2_0.foldBtn = arg_2_0.showPanelTF:Find("fold_btn")
	arg_2_0.contnetTF = arg_2_0.showPanelTF:Find("content")

	setText(arg_2_0.contnetTF:Find("personality/personality_title/Text"), i18n("child2_personality_title"))

	arg_2_0.personalityTF = arg_2_0.contnetTF:Find("personality/personality")
	arg_2_0.personalityValueTF = arg_2_0.personalityTF:Find("slider/handle/Image/bubble/Text")

	setText(arg_2_0.contnetTF:Find("attrs/attr_title/Text"), i18n("child2_attr_title"))

	local var_2_0 = arg_2_0.contnetTF:Find("attrs/attrs/content")

	arg_2_0.gradientBgTF = arg_2_0.contnetTF:Find("attrs/attrs/bg_gradient")
	arg_2_0.attrUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	setText(arg_2_0.contnetTF:Find("talent/talent_title/Text"), i18n("child2_talent_title"))

	local var_2_1 = arg_2_0.contnetTF:Find("talent/talents/content")

	arg_2_0.talentUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))
	arg_2_0.statusTF = arg_2_0.contnetTF:Find("status")

	setText(arg_2_0.statusTF:Find("status_title/Text"), i18n("child2_status_title"))

	local var_2_2 = arg_2_0.statusTF:Find("status/content/content")

	arg_2_0.statusUIList = UIItemList.New(var_2_2, var_2_2:Find("tpl"))
	arg_2_0.tarotTF = arg_2_0.contnetTF:Find("tarot")

	setText(arg_2_0.tarotTF:Find("title/Text"), i18n("child2_tarot_title"))

	arg_2_0.tarotIconTF = arg_2_0.tarotTF:Find("bg/icon")
	arg_2_0.tarotNameTF = arg_2_0.tarotTF:Find("bg/name")
	arg_2_0.tarotEntryTF = arg_2_0.tarotTF:Find("bg/entry")
	arg_2_0.attrIds = arg_2_0.contextData.char:GetAttrIds()
	arg_2_0.talentRoundIds = arg_2_0.contextData.char:GetRoundData():GetTalentRoundIds()

	return
end

function var_0_0.OnInit(arg_4_0)
	LoadImageSpriteAsync("neweducateicon/" .. arg_4_0.contextData.char:getConfig("child2_data_personality_icon")[1], arg_4_0.personalityTF:Find("slider/handle/Image"), true)
	LoadImageSpriteAsync("neweducateicon/" .. arg_4_0.contextData.char:getConfig("personality_bar_icon"), arg_4_0.personalityTF, true)
	onButton(arg_4_0, arg_4_0.showBtn, function()
		arg_4_0:ShowPanel()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.foldBtn, function()
		arg_4_0:HidePanel()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.tarotTF:Find("bg"), function()
		arg_4_0:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateTarotEntryMediator,
			viewComponent = NewEducateTarotEntryLayer,
			data = {
				inShop = arg_4_0.inShop
			}
		}))

		return
	end, SFX_PANEL)
	arg_4_0.attrUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[arg_4_0.attrIds[arg_8_1 + 1]].icon, arg_8_2:Find("icon_bg/icon"))
			setScrollText(arg_8_2:Find("name_mask/name"), pg.child2_attr[arg_4_0.attrIds[arg_8_1 + 1]].name)
		elseif arg_8_0 == UIItemList.EventUpdate then
			arg_4_0:OnUpdateAttrItem(arg_8_1, arg_8_2)
		end

		return
	end)
	arg_4_0.talentUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			arg_4_0:OnUpdateTalentItem(arg_9_1, arg_9_2)
		end

		return
	end)
	arg_4_0.statusUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_4_0:OnUpdateStatusItem(arg_10_1, arg_10_2)
		end

		return
	end)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = -1,
		pbList = {
			arg_4_0.blurBg
		}
	})
	setActive(arg_4_0.foldPanelTF, true)
	setActive(arg_4_0.showPanelTF, false)

	if arg_4_0.contextData.hide then
		arg_4_0:HidePanel()
	elseif arg_4_0.contextData.isMainEnter then
		onDelayTick(function()
			arg_4_0:ShowPanel()

			return
		end, 0.396)
	else
		arg_4_0:ShowPanel()
	end

	arg_4_0.isTarotChar = arg_4_0.contextData.char:GetPermanentData():IsTarotType()

	setActive(arg_4_0.tarotTF, arg_4_0.isTarotChar)
	setActive(arg_4_0.statusTF, not arg_4_0.isTarotChar)
	arg_4_0:Flush()

	return
end

function var_0_0.IsShowPanel(arg_12_0)
	return isActive(arg_12_0.showPanelTF)
end

function var_0_0.ShowPanel(arg_13_0)
	setActive(arg_13_0.foldPanelTF, false)
	setActive(arg_13_0.showPanelTF, true)

	return
end

function var_0_0.HidePanel(arg_14_0, arg_14_1)
	setActive(arg_14_0.foldPanelTF, true)

	if not arg_14_1 then
		arg_14_0.showAnim:Play("anim_educate_archive_show_out")
	else
		setActive(arg_14_0.showPanelTF, false)
	end

	eachChild(arg_14_0.talentUIList.container, function(arg_15_0)
		triggerToggle(arg_15_0:Find("unlock"), false)

		return
	end)
	eachChild(arg_14_0.statusUIList.container, function(arg_16_0)
		triggerToggle(arg_16_0, false)

		return
	end)

	return
end

function var_0_0.OnUpdateAttrItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = var_0_0.GetArrtInfo(pg.child2_attr[arg_17_0.attrIds[arg_17_1 + 1]].rank, (arg_17_0.contextData.char:GetAttr(arg_17_0.attrIds[arg_17_1 + 1])))

	setText(arg_17_2:Find("rank/Text"), var_17_0)
	setText(arg_17_2:Find("value"), var_17_1)
	setImageColor(arg_17_0.gradientBgTF:GetChild(arg_17_1), Color.NewHex(EducateConst.GRADE_2_COLOR[var_17_0][1]))
	setImageColor(arg_17_2:Find("rank"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_17_0][2]))
	setToggleEnabled(arg_17_2, arg_17_0.isTarotChar)

	if arg_17_0.isTarotChar then
		setText(arg_17_2:Find("info/content/name"), pg.child2_attr[arg_17_0.attrIds[arg_17_1 + 1]].name)
		setText(arg_17_2:Find("info/content/value"), var_17_1)

		local var_17_2, var_17_3 = arg_17_0.contextData.char:GetBenefitData():GetDisplayPctByDrop({
			type = NewEducateConst.DROP_TYPE.ATTR,
			id = arg_17_0.attrIds[arg_17_1 + 1]
		})

		setText(arg_17_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_17_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_17_3 .. "%")
	end

	return
end

function var_0_0.OnUpdateTalentItem(arg_18_0, arg_18_1, arg_18_2)
	setActive(arg_18_2:Find("unlock"), arg_18_0.talents[arg_18_1 + 1])
	setActive(arg_18_2:Find("lock"), not arg_18_0.talents[arg_18_1 + 1])

	if arg_18_0.talents[arg_18_1 + 1] then
		LoadImageSpriteAsync("neweducateicon/" .. arg_18_0.talents[arg_18_1 + 1]:getConfig("item_icon_little"), arg_18_2:Find("unlock/icon"))
		setText(arg_18_2:Find("unlock/name"), shortenString(arg_18_0.talents[arg_18_1 + 1]:getConfig("name"), 5))
		setText(arg_18_2:Find("unlock/info/content/name"), arg_18_0.talents[arg_18_1 + 1]:getConfig("name"))
		setText(arg_18_2:Find("unlock/info/content/desc"), arg_18_0.talents[arg_18_1 + 1]:getConfig("desc"))
	end

	local var_18_0 = arg_18_0.talentRoundIds[arg_18_1 + 1]

	onButton(arg_18_0, arg_18_2:Find("lock"), function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_talent_unlock_tip", var_18_0))

		return
	end, SFX_PANEL)
	onScroll(arg_18_0, arg_18_0.statusTF:Find("status"), function(arg_20_0)
		eachChild(arg_18_0.statusUIList.container, function(arg_21_0)
			triggerToggle(arg_21_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_0.OnUpdateStatusItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.status[arg_22_1 + 1]

	if arg_22_2.name ~= tostring(arg_22_0.status[arg_22_1 + 1].id) then
		arg_22_2.name = var_22_0.id

		LoadImageSpriteAsync("neweducateicon/" .. var_22_0:getConfig("item_icon"), arg_22_2:Find("icon"))
	end

	local var_22_1 = var_22_0:getConfig("during_time") == -1 and i18n("child2_status_time2") or i18n("child2_status_time1", var_22_0:GetEndRound() - arg_22_0.contextData.char:GetRoundData().round)

	setText(arg_22_2:Find("time/Text"), var_22_1)
	setText(arg_22_2:Find("info/content/name"), var_22_0:getConfig("name"))
	setText(arg_22_2:Find("info/content/desc"), var_22_0:getConfig("desc"))

	return
end

function var_0_0.Flush(arg_23_0)
	arg_23_0:FlushAttrs()
	arg_23_0:FlushTalents()
	arg_23_0:FlushStatus()
	arg_23_0:FlushTarot()

	return
end

function var_0_0.FlushAttrs(arg_24_0)
	local var_24_0 = arg_24_0.contextData.char:GetPersonalityMiddle()
	local var_24_1 = arg_24_0.contextData.char:GetPersonalityTag()
	local var_24_2 = arg_24_0.contextData.char:GetPersonality()

	setSlider(arg_24_0.personalityTF:Find("slider"), -var_24_0, var_24_0, var_24_2 - var_24_0)
	setText(arg_24_0.personalityValueTF, math.abs(var_24_2 - var_24_0))
	setTextColor(arg_24_0.personalityValueTF, Color.NewHex(var_24_1 == "tag1" and "26b1f3" or "ff6767"))
	arg_24_0.attrUIList:align(#arg_24_0.attrIds)

	return
end

function var_0_0.FlushTalents(arg_25_0)
	arg_25_0.talents = arg_25_0.contextData.char:GetTalentList()

	arg_25_0.talentUIList:align(#arg_25_0.talentRoundIds)

	return
end

function var_0_0.FlushStatus(arg_26_0)
	arg_26_0.status = arg_26_0.contextData.char:GetStatusList()

	arg_26_0.statusUIList:align(#arg_26_0.status)

	return
end

function var_0_0.FlushTarot(arg_27_0)
	arg_27_0.tarotId = arg_27_0.contextData.char:GetTarotId()

	setActive(arg_27_0.tarotIconTF, arg_27_0.tarotId)

	if arg_27_0.tarotId then
		LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_27_0.tarotId].item_icon_little, arg_27_0.tarotIconTF)
	end

	local var_27_1 = arg_27_0.tarotNameTF

	if arg_27_0.tarotId then
		local var_27_2 = pg.child2_benefit_list[arg_27_0.tarotId].name or "EMPTY"

		var_27_0(var_27_1, var_27_2)

		arg_27_0.entries = arg_27_0.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

		setText(arg_27_0.tarotEntryTF, i18n("child2_entry_summary") .. #arg_27_0.entries)

		return
	end
end

function var_0_0.SetShopOpen(arg_28_0, arg_28_1)
	arg_28_0.inShop = arg_28_1

	return
end

function var_0_0.OnDestroy(arg_29_0)
	arg_29_0:UnOverlayPanel(arg_29_0._tf)

	return
end

function var_0_0.GetArrtInfo(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
		if arg_30_1 >= iter_30_1[1][1] and arg_30_1 < iter_30_1[1][2] then
			return iter_30_1[2], arg_30_1 .. "/" .. iter_30_1[1][2]
		end
	end

	return arg_30_0[#arg_30_0][2], arg_30_1 .. "/" .. arg_30_0[#arg_30_0][1][2]
end

return var_0_0
