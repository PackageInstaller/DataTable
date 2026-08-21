local var_0_0 = class("IslandBookItemPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandBookItemUI"
end

function var_0_0.GetIllustrationType(arg_2_0)
	return IslandIllustration.TYPES.ITEM
end

function var_0_0.GetHelpTip(arg_3_0)
	return i18n("island_guide_help_item")
end

function var_0_0.OnLoaded(arg_4_0)
	setText(arg_4_0._tf:Find("top/title/Text"), i18n("island_guide"))
	setText(arg_4_0._tf:Find("top/title/Text/en"), i18n("island_guide_en"))

	arg_4_0.viewTF = arg_4_0._tf:Find("view")

	setActive(arg_4_0._tf:Find("tpl"), false)

	arg_4_0.scrollRect = arg_4_0.viewTF:GetComponent("LScrollRect")

	function arg_4_0.scrollRect.onInitItem(arg_5_0)
		arg_4_0:OnInitItem(arg_5_0)

		return
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	arg_4_0.rightTF = arg_4_0._tf:Find("right")
	arg_4_0.rightNameTF = arg_4_0.rightTF:Find("name")
	arg_4_0.rightEnNameTF = arg_4_0.rightTF:Find("zs/Text")
	arg_4_0.rightDescTF = arg_4_0.rightTF:Find("desc")
	arg_4_0.rightProgressTF = arg_4_0.rightTF:Find("progress")
	arg_4_0.unlockBtn = arg_4_0.rightTF:Find("unlock_btn")

	setText(arg_4_0.unlockBtn:Find("Text"), i18n("island_guide_do_active"))

	arg_4_0.getPointBtn = arg_4_0.rightTF:Find("get_btn")

	setText(arg_4_0.getPointBtn:Find("Text"), i18n("island_guide_collectionpoint"))

	arg_4_0.pointPanel = arg_4_0._tf:Find("point_panel")
	arg_4_0.pointLevelTF = arg_4_0.pointPanel:Find("Text")
	arg_4_0.pointAwardTF = arg_4_0.pointPanel:Find("award")
	arg_4_0.pointAwardIcon = arg_4_0.pointPanel:Find("award/icon")
	arg_4_0.getPointAwardBtn = arg_4_0.pointPanel:Find("award/get")
	arg_4_0.gotAllPointAwardTF = arg_4_0.pointPanel:Find("award/got")
	arg_4_0.openAwardWinBtn = arg_4_0.pointPanel:Find("award_btn")
	arg_4_0.pointSliderTF = arg_4_0.pointPanel:Find("slider")
	arg_4_0.pointProgressTF = arg_4_0.pointPanel:Find("slider/progress")
	arg_4_0.awardListBox = IslandBookAwardListBox.New(arg_4_0._tf, arg_4_0.event, setmetatable({
		ShowMsgBox = function(arg_7_0, arg_7_1)
			arg_4_0:ShowMsgBox(arg_7_1)

			return
		end,
		type = arg_4_0:GetIllustrationType()
	}, {
		__index = arg_4_0.contextData
	}))

	return
end

function var_0_0.OnInit(arg_8_0)
	onButton(arg_8_0, arg_8_0._tf:Find("top/back"), function()
		arg_8_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.unlockBtn, function()
		local var_10_0 = arg_8_0:GetCanUnlockIds()

		if #var_10_0 > 0 then
			arg_8_0:emit(IslandMediator.UNLOCK_ILLUSTRATION, var_10_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.getPointBtn, function()
		arg_8_0.getPointBtn:GetComponent(typeof(Animation)):Play()
		arg_8_0:emit(IslandMediator.GET_COLLECT_POINT, arg_8_0.canGetPointIds)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.openAwardWinBtn, function()
		arg_8_0.openAwardWinBtn:GetComponent(typeof(Animation)):Play()
		arg_8_0.awardListBox:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.getPointAwardBtn, function()
		arg_8_0.pointAwardTF:GetComponent(typeof(Animation)):Play()
		arg_8_0:emit(IslandMediator.GET_POINT_AWARD, arg_8_0.curLevelId)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("top/help"), function()
		arg_8_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = arg_8_0:GetHelpTip(),
			title = i18n("island_guide_character_help")
		})

		return
	end, SFX_PANEL)

	arg_8_0.cards = {}

	return
end

function var_0_0.AddListeners(arg_15_0)
	arg_15_0:AddListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_15_0.OnUnlockDone)
	arg_15_0:AddListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, arg_15_0.Flush)
	arg_15_0:AddListener(GAME.ISLAND_GET_POINT_AWARD_DONE, arg_15_0.OnGetPointAwardDone)

	return
end

function var_0_0.RemoveListeners(arg_16_0)
	arg_16_0:RemoveListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_16_0.OnUnlockDone)
	arg_16_0:RemoveListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, arg_16_0.Flush)
	arg_16_0:RemoveListener(GAME.ISLAND_GET_POINT_AWARD_DONE, arg_16_0.OnGetPointAwardDone)

	return
end

function var_0_0.OnInitItem(arg_17_0, arg_17_1)
	local var_17_0 = IslandIllustrationCard.New(arg_17_1)

	arg_17_0.cards[arg_17_1] = var_17_0

	onButton(arg_17_0, var_17_0._go, function()
		for iter_18_0, iter_18_1 in pairs(arg_17_0.cards) do
			iter_18_1:UpdateSelected(nil)
		end

		arg_17_0.showIllustration = var_17_0.illustration

		var_17_0:UpdateSelected(arg_17_0.showIllustration.id)
		arg_17_0:FlushRightPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.cards[arg_19_2]

	if not arg_19_0.cards[arg_19_2] then
		arg_19_0:OnInitItem(arg_19_2)

		var_19_0 = arg_19_0.cards[arg_19_2]
	end

	local var_19_1 = arg_19_0.showList[arg_19_1 + 1]

	if arg_19_0.showList[arg_19_1 + 1] then
		local var_19_2 = arg_19_0.showIllustration and arg_19_0.showIllustration.id

		var_19_0:Update(var_19_1, var_19_2)
	end

	if arg_19_0.triggerFirstCard and arg_19_1 == 0 then
		arg_19_0.triggerFirstCard = nil

		triggerButton(var_19_0._go)
	end

	return
end

function var_0_0.OnShow(arg_20_0)
	arg_20_0.triggerFirstCard = true

	arg_20_0:Flush()

	return
end

function var_0_0.GetCanUnlockIds(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.showList) do
		if iter_21_1:GetStatus() == IslandIllustration.STATUS.CAN_UNLOCK then
			table.insert({}, iter_21_1.id)
		end
	end

	return {}
end

function var_0_0.OnUnlockDone(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.cards) do
		iter_22_1:PlayUnlockAnim(arg_22_1.ids)
	end

	arg_22_0:Flush()

	return
end

function var_0_0.OnGetPointAwardDone(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.dropData.abilitys or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		pg.TipsMgr.GetInstance():ShowTips(pg.island_ability_template[iter_23_1.id].unlock_text)
	end

	arg_23_0:Flush()

	return
end

function var_0_0.Flush(arg_24_0)
	arg_24_0.bookAgency = getProxy(IslandProxy):GetIsland():GetBookAgency()
	arg_24_0.showList = arg_24_0.bookAgency:GetListByType(arg_24_0:GetIllustrationType())

	table.sort(arg_24_0.showList, CompareFuncs({
		function(arg_25_0)
			return arg_25_0:GetStatus() == IslandIllustration.STATUS.CAN_UNLOCK and 0 or 1
		end,
		function(arg_26_0)
			return pg.island_illustrated_guide[arg_26_0.id].order
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))
	arg_24_0.scrollRect:SetTotalCount(#arg_24_0.showList, -1)
	arg_24_0:FlushRightPanel()
	arg_24_0:FlushPointAwardInfos()
	arg_24_0:FlushPointInfos()

	return
end

function var_0_0.FlushRightPanel(arg_28_0)
	if not arg_28_0.showIllustration then
		return
	end

	local var_28_0 = arg_28_0.showIllustration:GetStatus()

	setText(arg_28_0.rightNameTF, arg_28_0.showIllustration:GetName())
	setText(arg_28_0.rightEnNameTF, arg_28_0.showIllustration:GetEnName())

	local var_28_1 = var_28_0 == IslandIllustration.STATUS.UNLOCK and arg_28_0.showIllustration:GetDesc() or i18n("island_guide_lock_desc")

	setText(arg_28_0.rightDescTF, var_28_1)
	setActive(arg_28_0.unlockBtn, var_28_0 == IslandIllustration.STATUS.CAN_UNLOCK)
	arg_28_0:FlushOnlyItem()

	return
end

function var_0_0.FlushOnlyItem(arg_29_0)
	local var_29_0 = arg_29_0:GetIllustrationType() == IslandIllustration.TYPES.ITEM

	setActive(arg_29_0.rightProgressTF, var_29_0)

	if var_29_0 then
		local var_29_1 = arg_29_0.showIllustration:GetHistoryCnt()
		local var_29_2 = arg_29_0.showIllustration:GetCurTarget()
		local var_29_4 = arg_29_0.rightProgressTF

		if var_29_2 then
			local var_29_5 = var_29_1 .. "/" .. var_29_2 or var_29_1

			var_29_3(var_29_4, var_29_5)

			return
		end
	end
end

function var_0_0.FlushPointAwardInfos(arg_30_0)
	local var_30_0 = arg_30_0:GetIllustrationType()

	arg_30_0.pointAwardGotIds = arg_30_0.bookAgency:GetPointAwardGotIds(var_30_0)
	arg_30_0.curLevelId = arg_30_0.bookAgency:GetCurLevelPointAwardId(var_30_0)
	arg_30_0.awardConfig = pg.island_collection_reward[arg_30_0.curLevelId]

	setText(arg_30_0.pointLevelTF, i18n("island_book_collection_award_title", arg_30_0.awardConfig.level))

	arg_30_0.curPoint, arg_30_0.targetPoint = arg_30_0.bookAgency:GetCurPointInfos(var_30_0)

	setText(arg_30_0.pointProgressTF, arg_30_0.curPoint .. "/" .. arg_30_0.targetPoint)
	setSlider(arg_30_0.pointSliderTF, 0, 1, arg_30_0.curPoint / arg_30_0.targetPoint)

	local var_30_1 = arg_30_0.bookAgency:IsGotAllPointAward(var_30_0)

	setActive(arg_30_0.gotAllPointAwardTF, var_30_1)
	setActive(arg_30_0.getPointAwardBtn, not var_30_1 and arg_30_0.curPoint >= arg_30_0.targetPoint)
	GetImageSpriteFromAtlasAsync(Drop.Create(arg_30_0.awardConfig.award_display):getIcon(), "", arg_30_0.pointAwardIcon)

	return
end

function var_0_0.FlushPointInfos(arg_31_0)
	arg_31_0.canGetPointIds = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.showList) do
		if iter_31_1:GetStatus() == IslandIllustration.STATUS.UNLOCK and iter_31_1:IsTip() then
			table.insert(arg_31_0.canGetPointIds, iter_31_1.id)
		end
	end

	setActive(arg_31_0.getPointBtn, #arg_31_0.canGetPointIds > 0)

	return
end

function var_0_0.OnDestroy(arg_32_0)
	ClearLScrollrect(arg_32_0.scrollRect)

	for iter_32_0, iter_32_1 in pairs(arg_32_0.cards) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = {}

	if arg_32_0.awardListBox then
		arg_32_0.awardListBox:Destroy()

		arg_32_0.awardListBox = nil
	end

	return
end

return var_0_0
