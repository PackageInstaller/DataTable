local var_0_0 = class("NewEducateRankLayer", import("view.newEducate.base.NewEducateBaseUI"))

var_0_0.TYPE = {
	ATTR = PowerRank.TYPE_TB_ATTR_SUM,
	ENDLESS = PowerRank.TYPE_TB_ENDLESS_WAVE
}

function var_0_0.getUIName(arg_1_0)
	return "NewEducateRankUI"
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("window")

	setText(var_2_0:Find("tip"), i18n("child2_rank_refresh_tip"))

	local var_2_1 = var_2_0:Find("header")

	setText(var_2_1:Find("rank"), i18n("child2_rank_header_rank"))
	setText(var_2_1:Find("info"), i18n("child2_rank_header_info"))

	arg_2_0.headerValueTF = var_2_1:Find("value")
	arg_2_0.toggleTFs = {}
	arg_2_0.toggleTFs[var_0_0.TYPE.ATTR] = var_2_0:Find("toggles/attr")

	setText(var_2_0:Find("toggles/attr/Text"), i18n("child2_rank_toggle_attr"))

	arg_2_0.toggleTFs[var_0_0.TYPE.ENDLESS] = var_2_0:Find("toggles/endless")

	setText(var_2_0:Find("toggles/endless/Text"), i18n("child2_rank_toggle_endless"))

	arg_2_0.playerRankTF = var_2_0:Find("player")
	arg_2_0.rankRect = var_2_0:Find("view/content"):GetComponent("LScrollRect")

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		groupDelta = 1
	})
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:closeView()

		return
	end, SFX_PANEL)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.toggleTFs) do
		onToggle(arg_3_0, iter_3_1, function(arg_5_0)
			local var_5_0

			if arg_5_0 and (not arg_3_0.curType or arg_3_0.curType ~= iter_3_0) then
				arg_3_0.curType = iter_3_0

				arg_3_0:UpdateView()

				var_5_0 = quickPlayAnimation
			end

			var_5_0(iter_3_1, arg_5_0 and "Anim_NewEducateRankUI_sel" or "Anim_NewEducateRankUI_sel2")

			return
		end, SFX_PANEL)
	end

	function arg_3_0.rankRect.onInitItem(arg_6_0)
		arg_3_0:OnInitItem(arg_6_0)

		return
	end

	function arg_3_0.rankRect.onUpdateItem(arg_7_0, arg_7_1)
		arg_3_0:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	arg_3_0.playerCard = NewEducateRankCard.New(arg_3_0.playerRankTF, NewEducateRankCard.TYPE_SELF, arg_3_0)

	arg_3_0:InitData()
	triggerToggle(arg_3_0.toggleTFs[var_0_0.TYPE.ATTR], true)
	NewEducateGuideSequence.CheckGuide(arg_3_0.__cname)

	return
end

function var_0_0.InitData(arg_8_0)
	arg_8_0.cards = {}
	arg_8_0.rankVOs = {}
	arg_8_0.playerRankVOs = {}
	arg_8_0.charId = arg_8_0.contextData.char.id

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	arg_9_0.cards[arg_9_1] = NewEducateRankCard.New(arg_9_1, NewEducateRankCard.TYPE_OTHER, arg_9_0)

	return
end

function var_0_0.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)
	end

	arg_10_0.cards[arg_10_2]:Update(arg_10_0.displayRankVOs[arg_10_1 + 1], arg_10_0.curType)

	return
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = arg_11_0.curType == var_0_0.TYPE.ATTR and i18n("child2_rank_header_attr") or i18n("child2_rank_header_wave")

	setText(arg_11_0.headerValueTF, var_11_0)

	if arg_11_0.rankVOs[arg_11_0.curType] then
		if getProxy(BillboardProxy):canFetch(arg_11_0.curType, arg_11_0.charId) then
			arg_11_0:emit(NewEducateRankMediator.ON_GET_RANK, arg_11_0.curType, arg_11_0.charId)
		else
			arg_11_0:UpdataRankList()
		end

		return
	end
end

function var_0_0.UpdataRankList(arg_12_0)
	arg_12_0.displayRankVOs = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rankVOs[arg_12_0.curType]) do
		table.insert(arg_12_0.displayRankVOs, iter_12_1)
	end

	arg_12_0.rankRect:SetTotalCount(#arg_12_0.displayRankVOs)
	setActive(arg_12_0.playerRankTF, arg_12_0.playerRankVOs[arg_12_0.curType])

	if arg_12_0.playerRankVOs[arg_12_0.curType] then
		arg_12_0.playerCard:Update(arg_12_0.playerRankVOs[arg_12_0.curType], arg_12_0.curType)
	end

	return
end

function var_0_0.OnGetRankDone(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.rankVOs[arg_13_1] = arg_13_3
	arg_13_0.playerRankVOs[arg_13_1] = arg_13_4

	arg_13_0:UpdataRankList()

	return
end

function var_0_0.willExit(arg_14_0)
	ClearLScrollrect(arg_14_0.rankRect)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.cards) do
		iter_14_1:Dispose()
	end

	arg_14_0.cards = nil

	arg_14_0.playerCard:Dispose()
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
