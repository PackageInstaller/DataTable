local var_0_0 = class("BillboardScene", import("..base.BaseUI"))

var_0_0.SINGLE_SHOW = {
	PowerRank.TYPE_EXTRA_CHAPTER,
	PowerRank.TYPE_ACT_BOSS_BATTLE,
	PowerRank.TYPE_BOSSRUSH
}

function var_0_0.getUIName(arg_1_0)
	return "BillboardUI"
end

function var_0_0.updateRankList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.rankVOs = arg_2_0.rankVOs or {}
	arg_2_0.playerRankVOs = arg_2_0.playerRankVOs or {}
	arg_2_0.rankVOs[arg_2_1] = arg_2_2
	arg_2_0.ptRanks = arg_2_0.ptRanks or {}

	if arg_2_1 == PowerRank.TYPE_PT then
		assert(arg_2_4)

		arg_2_0.ptRanks[arg_2_4] = arg_2_2
		arg_2_0.playerPTRankVOMap = arg_2_0.playerPTRankVOMap or {}
		arg_2_0.playerPTRankVOMap[arg_2_4] = arg_2_3
	end

	arg_2_0.playerRankVOs[arg_2_1] = arg_2_3

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.blurPanel = arg_3_0._tf:Find("blur_panel")
	arg_3_0.rankRect = arg_3_0._tf:Find("main/frame/ranks"):GetComponent("LScrollRect")
	arg_3_0.playerRankTF = arg_3_0._tf:Find("main/frame/player_rank")

	setActive(arg_3_0.playerRankTF, false)

	arg_3_0.topPanel = arg_3_0.blurPanel:Find("adapt/top")
	arg_3_0.leftPanel = arg_3_0.blurPanel:Find("adapt/left_length")
	arg_3_0.mainPanel = arg_3_0._tf:Find("main")
	arg_3_0.extraChapterBg = arg_3_0._tf:Find("extra_chapter_bg")
	arg_3_0.toggleScrollRect = arg_3_0.leftPanel:Find("frame/scroll_rect")
	arg_3_0.toggleContainer = arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot")
	arg_3_0.listEmptyTF = arg_3_0._tf:Find("main/frame/empty")

	setActive(arg_3_0.listEmptyTF, false)

	arg_3_0.listEmptyTxt = arg_3_0.listEmptyTF:Find("Text")

	setText(arg_3_0.listEmptyTxt, i18n("list_empty_tip_billboardui"))

	arg_3_0.toggles = {
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/power"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/collection"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/pt"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/pledge"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/chanllenge"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/extra_chapter"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/boss_battle"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/guild"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/military"),
		arg_3_0.leftPanel:Find("frame/scroll_rect/tagRoot/bossrush")
	}
	arg_3_0.ptToggles = {}

	local var_3_0 = _.filter(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return not arg_4_0:isEnd() and tonumber(arg_4_0:getConfig("config_data")) > 0
	end)

	if #var_3_0 > 1 then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			arg_3_0.ptToggles[iter_3_1.id] = cloneTplTo(arg_3_0.toggles[3], arg_3_0.toggles[3].parent)
		end

		arg_3_0.toggles[3] = nil
	end

	arg_3_0:updateToggles()

	arg_3_0.rankRect.decelerationRate = 0.07

	local var_3_1 = arg_3_0.contextData.page or PowerRank.TYPE_POWER

	if table.contains(var_0_0.SINGLE_SHOW, var_3_1) then
		setActive(arg_3_0.leftPanel, false)
		setAnchoredPosition(arg_3_0.mainPanel, Vector2(0, -35.5))
		setImageSprite(arg_3_0.extraChapterBg, (GetSpriteFromAtlas("commonbg/bg_fengshan", "")))
	end

	setActive(arg_3_0.extraChapterBg, var_3_1 == PowerRank.TYPE_EXTRA_CHAPTER)

	return
end

function var_0_0.updateToggles(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.toggles) do
		local var_5_0 = PowerRank.typeInfo[iter_5_0].act_type and PowerRank:getActivityByRankType(iter_5_0) or (iter_5_0 ~= PowerRank.TYPE_PLEDGE or false) and (iter_5_0 == PowerRank.TYPE_GUILD_BATTLE and true or true)

		setActive(iter_5_1, var_5_0)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.ptToggles) do
		local var_5_1 = getProxy(ActivityProxy):getActivityById(iter_5_2)

		setActive(iter_5_3, var_5_1 and not var_5_1:isEnd())
	end

	setActive(arg_5_0.toggleContainer, true)
	Canvas.ForceUpdateCanvases()

	arg_5_0.toggleContainer:GetComponent(typeof(ScrollRect)).enabled = arg_5_0.toggleScrollRect.rect.height < arg_5_0.toggleContainer.rect.height

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.topPanel:Find("back_btn"), function()
		arg_6_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.toggles) do
		onToggle(arg_6_0, iter_6_1, function(arg_8_0)
			if iter_6_0 == PowerRank.TYPE_GUILD_BATTLE then
				setActive(arg_6_0.mainPanel, not arg_8_0)
				arg_6_0:emit(BillboardMediator.ON_GUILD_RANK, arg_8_0)

				return
			end

			if arg_8_0 then
				arg_6_0:switchPage(iter_6_0, (checkExist(PowerRank:getActivityByRankType(iter_6_0), {
					"id"
				})))
			end

			return
		end, SFX_PANEL)
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0.ptToggles) do
		onToggle(arg_6_0, iter_6_3, function(arg_9_0)
			if arg_9_0 then
				arg_6_0:switchPage(PowerRank.TYPE_PT, iter_6_2)
			end

			return
		end, SFX_PANEL)
	end

	arg_6_0.cards = {}

	function arg_6_0.rankRect.onInitItem(arg_10_0)
		arg_6_0:onInintItem(arg_10_0)

		return
	end

	function arg_6_0.rankRect.onUpdateItem(arg_11_0, arg_11_1)
		arg_6_0:onUpdateItem(arg_11_0, arg_11_1, arg_6_0.curPagePTActID)

		return
	end

	function arg_6_0.rankRect.onReturnItem(arg_12_0, arg_12_1)
		arg_6_0:onReturnItem(arg_12_0, arg_12_1)

		return
	end

	arg_6_0.playerCard = RankCard.New(arg_6_0.playerRankTF, RankCard.TYPE_SELF)

	local var_6_0 = arg_6_0.contextData.page or PowerRank.TYPE_POWER

	triggerToggle(arg_6_0.toggles[var_6_0], true)

	return
end

function var_0_0.onInintItem(arg_13_0, arg_13_1)
	local var_13_0 = RankCard.New(arg_13_1, RankCard.TYPE_OTHER)

	onButton(arg_13_0, var_13_0._tf, function()
		if var_13_0.rankVO.type == PowerRank.TYPE_MILITARY_RANK then
			arg_13_0:emit(BillboardMediator.OPEN_RIVAL_INFO, var_13_0.rankVO.id)
		end

		return
	end)

	arg_13_0.cards[arg_13_1] = var_13_0

	return
end

function var_0_0.onUpdateItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:onInintItem(arg_15_2)
	end

	arg_15_0.cards[arg_15_2]:update(arg_15_0.displayRankVOs[arg_15_1 + 1], arg_15_3)

	return
end

function var_0_0.onReturnItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.exited then
		return
	end

	if arg_16_0.cards[arg_16_2] then
		var_16_0:clear()
	end

	return
end

function var_0_0.filter(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= arg_17_0.page then
		return
	end

	local var_17_0 = arg_17_0.page
	local var_17_1

	if PowerRank.TYPE_PT == arg_17_1 then
		assert(arg_17_2)

		var_17_1 = arg_17_0.ptRanks[arg_17_2]
	else
		var_17_1 = arg_17_0.rankVOs[var_17_0]
	end

	arg_17_0.displayRankVOs = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		table.insert(arg_17_0.displayRankVOs, iter_17_1)
	end

	arg_17_0.rankRect:SetTotalCount(#arg_17_0.displayRankVOs)
	setActive(arg_17_0.listEmptyTF, #arg_17_0.displayRankVOs <= 0)

	if PowerRank.TYPE_PT == arg_17_1 then
		arg_17_0.playerCard:update(arg_17_0.playerPTRankVOMap[arg_17_2], arg_17_2)
	else
		arg_17_0.playerCard:update(arg_17_0.playerRankVOs[arg_17_0.page], arg_17_2)
	end

	return
end

function var_0_0.switchPage(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.page == arg_18_1 and arg_18_1 ~= PowerRank.TYPE_PT then
		return
	end

	arg_18_0.curPagePTActID = arg_18_1 == PowerRank.TYPE_PT and arg_18_2 or nil
	arg_18_0.page = arg_18_1

	local var_18_0

	if arg_18_0.page == PowerRank.TYPE_PT then
		assert(arg_18_2)

		var_18_0 = arg_18_0.ptRanks[arg_18_2]
	else
		var_18_0 = arg_18_0.rankVOs[arg_18_1]
	end

	if not var_18_0 then
		arg_18_0.rankRect:SetTotalCount(0)
		arg_18_0.playerCard:clear()
		arg_18_0:emit(BillboardMediator.FETCH_RANKS, arg_18_0.page, arg_18_2)
	else
		arg_18_0:filter(arg_18_0.page, arg_18_2)
	end

	setActive(arg_18_0.topPanel:Find("tip"), not table.contains(BillboardProxy.NONTIMER, arg_18_0.page))
	arg_18_0:updateScoreTitle(arg_18_0.page, arg_18_2)

	return
end

function var_0_0.updateScoreTitle(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._tf:Find("main/frame/title")
	local var_19_1 = PowerRank:getTitleWord(arg_19_1, arg_19_2)

	for iter_19_0 = 1, 4 do
		setText(var_19_0:GetChild(iter_19_0 - 1), var_19_1[iter_19_0])
	end

	return
end

function var_0_0.willExit(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.cards) do
		iter_20_1:dispose()
	end

	arg_20_0.playerCard:dispose()

	if arg_20_0.name then
		retPaintingPrefab(arg_20_0.paintingTF, arg_20_0.name)
	end

	return
end

return var_0_0
