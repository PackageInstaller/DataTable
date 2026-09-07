local BillboardScene = class("BillboardScene", import("..base.BaseUI"))

BillboardScene.SINGLE_SHOW = {
	PowerRank.TYPE_EXTRA_CHAPTER,
	PowerRank.TYPE_ACT_BOSS_BATTLE,
	PowerRank.TYPE_BOSSRUSH
}

function BillboardScene:getUIName()
	return "BillboardUI"
end

function BillboardScene:updateRankList(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.rankVOs = self.rankVOs or {}
	self.playerRankVOs = self.playerRankVOs or {}
	self.rankVOs[arg_2_1] = arg_2_2
	self.ptRanks = self.ptRanks or {}

	if arg_2_1 == PowerRank.TYPE_PT then
		assert(arg_2_4)

		self.ptRanks[arg_2_4] = arg_2_2
		self.playerPTRankVOMap = self.playerPTRankVOMap or {}
		self.playerPTRankVOMap[arg_2_4] = arg_2_3
	end

	self.playerRankVOs[arg_2_1] = arg_2_3

	return
end

function BillboardScene:init()
	self.blurPanel = self._tf:Find("blur_panel")
	self.rankRect = self._tf:Find("main/frame/ranks"):GetComponent("LScrollRect")
	self.playerRankTF = self._tf:Find("main/frame/player_rank")

	setActive(self.playerRankTF, false)

	self.topPanel = self.blurPanel:Find("adapt/top")
	self.leftPanel = self.blurPanel:Find("adapt/left_length")
	self.mainPanel = self._tf:Find("main")
	self.extraChapterBg = self._tf:Find("extra_chapter_bg")
	self.toggleScrollRect = self.leftPanel:Find("frame/scroll_rect")
	self.toggleContainer = self.leftPanel:Find("frame/scroll_rect/tagRoot")
	self.listEmptyTF = self._tf:Find("main/frame/empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_billboardui"))

	self.toggles = {
		self.leftPanel:Find("frame/scroll_rect/tagRoot/power"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/collection"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/pt"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/pledge"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/chanllenge"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/extra_chapter"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/boss_battle"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/guild"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/military"),
		self.leftPanel:Find("frame/scroll_rect/tagRoot/bossrush")
	}
	self.ptToggles = {}

	local var_3_0 = _.filter(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_4_0)
		return not arg_4_0:isEnd() and tonumber(arg_4_0:getConfig("config_data")) > 0
	end)

	if #var_3_0 > 1 then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			self.ptToggles[iter_3_1.id] = cloneTplTo(self.toggles[3], self.toggles[3].parent)
		end

		self.toggles[3] = nil
	end

	self:updateToggles()

	self.rankRect.decelerationRate = 0.07

	local var_3_1 = self.contextData.page or PowerRank.TYPE_POWER

	if table.contains(BillboardScene.SINGLE_SHOW, var_3_1) then
		setActive(self.leftPanel, false)
		setAnchoredPosition(self.mainPanel, Vector2(0, -35.5))
		setImageSprite(self.extraChapterBg, (GetSpriteFromAtlas("commonbg/bg_fengshan", "")))
	end

	setActive(self.extraChapterBg, var_3_1 == PowerRank.TYPE_EXTRA_CHAPTER)

	return
end

function BillboardScene:updateToggles()
	for iter_5_0, iter_5_1 in pairs(self.toggles) do
		setActive(iter_5_1, PowerRank.typeInfo[iter_5_0].act_type and PowerRank:getActivityByRankType(iter_5_0) or (iter_5_0 ~= PowerRank.TYPE_PLEDGE or false) and (iter_5_0 == PowerRank.TYPE_GUILD_BATTLE and true or true))
	end

	for iter_5_2, iter_5_3 in pairs(self.ptToggles) do
		local var_5_1 = getProxy(ActivityProxy):getActivityById(iter_5_2)

		setActive(iter_5_3, var_5_1 and not var_5_1:isEnd())
	end

	setActive(self.toggleContainer, true)
	Canvas.ForceUpdateCanvases()

	self.toggleContainer:GetComponent(typeof(ScrollRect)).enabled = self.toggleScrollRect.rect.height < self.toggleContainer.rect.height

	return
end

function BillboardScene:didEnter()
	onButton(self, self.topPanel:Find("back_btn"), function()
		self:emit(BillboardScene.ON_BACK)

		return
	end, SFX_CANCEL)

	for iter_6_0, iter_6_1 in pairs(self.toggles) do
		onToggle(self, iter_6_1, function(arg_8_0)
			if iter_6_0 == PowerRank.TYPE_GUILD_BATTLE then
				setActive(self.mainPanel, not arg_8_0)
				self:emit(BillboardMediator.ON_GUILD_RANK, arg_8_0)

				return
			end

			if arg_8_0 then
				self:switchPage(iter_6_0, (checkExist(PowerRank:getActivityByRankType(iter_6_0), {
					"id"
				})))
			end

			return
		end, SFX_PANEL)
	end

	for iter_6_2, iter_6_3 in pairs(self.ptToggles) do
		onToggle(self, iter_6_3, function(arg_9_0)
			if arg_9_0 then
				self:switchPage(PowerRank.TYPE_PT, iter_6_2)
			end

			return
		end, SFX_PANEL)
	end

	self.cards = {}

	function self.rankRect.onInitItem(arg_10_0)
		self:onInintItem(arg_10_0)

		return
	end

	function self.rankRect.onUpdateItem(arg_11_0, arg_11_1)
		self:onUpdateItem(arg_11_0, arg_11_1, self.curPagePTActID)

		return
	end

	function self.rankRect.onReturnItem(arg_12_0, arg_12_1)
		self:onReturnItem(arg_12_0, arg_12_1)

		return
	end

	self.playerCard = RankCard.New(self.playerRankTF, RankCard.TYPE_SELF)

	triggerToggle(self.toggles[self.contextData.page or PowerRank.TYPE_POWER], true)

	return
end

function BillboardScene:onInintItem(arg_13_1)
	local var_13_0 = RankCard.New(arg_13_1, RankCard.TYPE_OTHER)

	onButton(self, var_13_0._tf, function()
		if var_13_0.rankVO.type == PowerRank.TYPE_MILITARY_RANK then
			self:emit(BillboardMediator.OPEN_RIVAL_INFO, var_13_0.rankVO.id)
		end

		return
	end)

	self.cards[arg_13_1] = var_13_0

	return
end

function BillboardScene:onUpdateItem(arg_15_1, arg_15_2, arg_15_3)
	if not self.cards[arg_15_2] then
		self:onInintItem(arg_15_2)
	end

	self.cards[arg_15_2]:update(self.displayRankVOs[arg_15_1 + 1], arg_15_3)

	return
end

function BillboardScene:onReturnItem(arg_16_1, arg_16_2)
	if self.exited then
		return
	end

	if self.cards[arg_16_2] then
		self.cards[arg_16_2]:clear()
	end

	return
end

function BillboardScene:filter(arg_17_1, arg_17_2)
	if arg_17_1 ~= self.page then
		return
	end

	local var_17_0 = self.page
	local var_17_1

	if PowerRank.TYPE_PT == arg_17_1 then
		assert(arg_17_2)

		var_17_1 = self.ptRanks[arg_17_2]
	else
		var_17_1 = self.rankVOs[var_17_0]
	end

	self.displayRankVOs = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		table.insert(self.displayRankVOs, iter_17_1)
	end

	self.rankRect:SetTotalCount(#self.displayRankVOs)
	setActive(self.listEmptyTF, #self.displayRankVOs <= 0)

	if PowerRank.TYPE_PT == arg_17_1 then
		self.playerCard:update(self.playerPTRankVOMap[arg_17_2], arg_17_2)
	else
		self.playerCard:update(self.playerRankVOs[self.page], arg_17_2)
	end

	return
end

function BillboardScene:switchPage(arg_18_1, arg_18_2)
	if self.page == arg_18_1 and arg_18_1 ~= PowerRank.TYPE_PT then
		return
	end

	self.curPagePTActID = arg_18_1 == PowerRank.TYPE_PT and arg_18_2 or nil
	self.page = arg_18_1

	local var_18_0

	if self.page == PowerRank.TYPE_PT then
		assert(arg_18_2)

		var_18_0 = self.ptRanks[arg_18_2]
	else
		var_18_0 = self.rankVOs[arg_18_1]
	end

	if not var_18_0 then
		self.rankRect:SetTotalCount(0)
		self.playerCard:clear()
		self:emit(BillboardMediator.FETCH_RANKS, self.page, arg_18_2)
	else
		self:filter(self.page, arg_18_2)
	end

	setActive(self.topPanel:Find("tip"), not table.contains(BillboardProxy.NONTIMER, self.page))
	self:updateScoreTitle(self.page, arg_18_2)

	return
end

function BillboardScene:updateScoreTitle(arg_19_1, arg_19_2)
	local var_19_0 = self._tf:Find("main/frame/title")
	local var_19_1 = PowerRank:getTitleWord(arg_19_1, arg_19_2)

	for iter_19_0 = 1, 4 do
		setText(var_19_0:GetChild(iter_19_0 - 1), var_19_1[iter_19_0])
	end

	return
end

function BillboardScene:willExit()
	for iter_20_0, iter_20_1 in ipairs(self.cards) do
		iter_20_1:dispose()
	end

	self.playerCard:dispose()

	if self.name then
		retPaintingPrefab(self.paintingTF, self.name)
	end

	return
end

return BillboardScene
