local JoinGuildLayer = class("JoinGuildLayer", import("..base.BaseUI"))
local var_0_1 = i18n("guild_search_list_max_count", 30)

function JoinGuildLayer:getUIName()
	return "JoinGuildUI"
end

function JoinGuildLayer:setGuildVOs(arg_2_1)
	self.guildVOs = arg_2_1

	return
end

function JoinGuildLayer:setPlayerVO(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function JoinGuildLayer:init()
	self.guildViewRect = self._tf:Find("add_panel/view")
	self.refreshBtn = self._tf:Find("add_panel/center/refresh")
	self.searchBtn = self._tf:Find("add_panel/center/search")
	self.searchBar = self._tf:Find("add_panel/center/search_bar"):GetComponent(typeof(InputField))
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.sortBtn = self._tf:Find("add_panel/center/sort_button")
	self.sortBtnContainer = self._tf:Find("add_panel/sort_panel/mask/content")
	self.sortBtnTpl = self:getTpl("add_panel/sort_panel/mask/content/tpl")
	self.sortPanel = self._tf:Find("add_panel/sort_panel")
	self.applyRedPage = GuildApplyRedPage.New(self._tf, self.event)
	self.applyBluePage = GuildApplyBluePage.New(self._tf, self.event)
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_joinguildui"))
	setText(self._tf:Find("tip"), var_0_1)

	self.viewRect = self.guildViewRect:GetComponent("LScrollRect")

	function self.viewRect.onInitItem(arg_5_0)
		self:onInitItem(arg_5_0)

		return
	end

	function self.viewRect.onUpdateItem(arg_6_0, arg_6_1)
		self:onUpdateItem(arg_6_0, arg_6_1)

		return
	end

	self.items = {}

	return
end

function JoinGuildLayer:didEnter()
	onButton(self, self.refreshBtn, function()
		self:emit(JoinGuildMediator.REFRESH)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:emit(JoinGuildLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self.searchBtn, function()
		self:emit(JoinGuildMediator.SEARCH, self.searchBar.text)

		return
	end, SFX_PANEL)
	onButton(self, self.sortBtn, function()
		if go(self.sortPanel).activeSelf then
			self:closeSortPanel()
		else
			self:openSortPanel()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sortPanel, function()
		self:closeSortPanel()

		return
	end, SFX_PANEL)

	return
end

function JoinGuildLayer:openSortPanel()
	self.isOpenSortPanel = true

	setActive(self.sortPanel, true)

	if not self.isInitSort then
		self.isInitSort = true

		self:initSort()
	end

	return
end

local var_0_2 = {
	{
		"index_all"
	},
	{
		"index_blhx",
		{
			"faction",
			GuildConst.FACTION_TYPE_BLHX
		}
	},
	{
		"index_cszz",
		{
			"faction",
			GuildConst.FACTION_TYPE_CSZZ
		}
	},
	{
		"index_power",
		{
			"policy",
			GuildConst.POLICY_TYPE_POWER
		}
	},
	{
		"index_relax",
		{
			"policy",
			GuildConst.POLICY_TYPE_RELAXATION
		}
	}
}
local var_0_3 = {}

function JoinGuildLayer:initSort()
	for iter_14_0, iter_14_1 in ipairs(var_0_2) do
		local var_14_0 = cloneTplTo(self.sortBtnTpl, self.sortBtnContainer)

		setImageSprite(var_14_0:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", iter_14_1[1]), true)
		onToggle(self, var_14_0, function(arg_15_0)
			if arg_15_0 then
				self:filter(iter_14_1)
				setActive(self.sortPanel, false)
			end

			return
		end)
	end

	for iter_14_2, iter_14_3 in ipairs(var_0_3) do
		local var_14_1 = cloneTplTo(self.sortBtnTpl, self.sortBtnContainer)

		setText(var_14_1:Find("Text"), iter_14_3[2])
		onToggle(self, var_14_1, function(arg_16_0)
			if arg_16_0 then
				self:sortGuilds(iter_14_3[1])
			end

			return
		end)
	end

	return
end

function JoinGuildLayer:closeSortPanel()
	self.isOpenSortPanel = nil

	setActive(self.sortPanel, false)

	return
end

function JoinGuildLayer:onInitItem(arg_18_1)
	self.items[arg_18_1] = GuildApplyCard.New(arg_18_1)

	onButton(self, self.items[arg_18_1].applyBtn, function()
		if self.playerVO:inGuildCDTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_leave_cd_time"))

			return
		end

		self:showApply(self.items[arg_18_1].guildVO)

		return
	end, SFX_PANEL)

	return
end

function JoinGuildLayer:onUpdateItem(arg_20_1, arg_20_2)
	if not self.items[arg_20_2] then
		self:onInitItem(arg_20_2)
	end

	self.items[arg_20_2]:Update(self.sortVOs[arg_20_1 + 1])

	return
end

function JoinGuildLayer:sortGuilds(arg_21_1)
	self.sortVOs = self.guildVOs or {}

	table.sort(self.sortVOs, function(arg_22_0, arg_22_1)
		if not arg_21_1 then
			return arg_22_0.id < arg_22_1.id
		elseif arg_22_0[arg_21_1] == arg_22_1[arg_21_1] then
			return arg_22_0.id < arg_22_1.id
		else
			return arg_22_0[arg_21_1] > arg_22_1[arg_21_1]
		end

		return
	end)
	self.viewRect:SetTotalCount(#self.sortVOs, 0)
	setActive(self.listEmptyTF, #self.sortVOs <= 0)

	return
end

function JoinGuildLayer:filter(arg_23_1)
	local var_23_0 = arg_23_1 or self.contextData.filterData

	self.sortVOs = {}

	if not var_23_0 or #var_23_0 < 2 then
		self.sortVOs = self.guildVOs or {}

		setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", "index_all"), true)
	else
		for iter_23_0, iter_23_1 in ipairs(self.guildVOs) do
			if iter_23_1[var_23_0[2][1]] == var_23_0[2][2] then
				table.insert(self.sortVOs, iter_23_1)
			end
		end

		setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/joinguildui_atlas", var_23_0[1]), true)
	end

	local var_23_1 = _.all(self.sortVOs, function(arg_24_0)
		return arg_24_0:getFaction() == GuildConst.FACTION_TYPE_CSZZ
	end)
	local var_23_2 = _.all(self.sortVOs, function(arg_25_0)
		return arg_25_0:getFaction() == GuildConst.FACTION_TYPE_BLHX
	end)

	self.contextData.filterData = var_23_0

	self.viewRect:SetTotalCount(#self.sortVOs, 0)
	setActive(self.listEmptyTF, #self.sortVOs <= 0)

	return
end

function JoinGuildLayer:showApply(arg_26_1)
	local var_26_0 = arg_26_1:getFaction()

	if var_26_0 == GuildConst.FACTION_TYPE_BLHX then
		self.page = self.applyBluePage
	elseif var_26_0 == GuildConst.FACTION_TYPE_CSZZ then
		self.page = self.applyRedPage
	end

	self.page:ExecuteAction("Show", arg_26_1)

	return
end

function JoinGuildLayer:CloseApply()
	if self.page and self.page:GetLoaded() and self.page:isShowing() then
		self.page:Hide()
	end

	return
end

function JoinGuildLayer:onBackPressed()
	if self.isOpenSortPanel then
		self:closeSortPanel()
	elseif self.page and self.page:GetLoaded() and self.page:isShowing() then
		self.page:Hide()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		self:emit(JoinGuildLayer.ON_CLOSE)
	end

	return
end

function JoinGuildLayer:willExit()
	self.applyBluePage:Destroy()
	self.applyRedPage:Destroy()
	PoolMgr.GetInstance():DestroySprite("ui/JoinGuildUI_atlas")

	return
end

return JoinGuildLayer
