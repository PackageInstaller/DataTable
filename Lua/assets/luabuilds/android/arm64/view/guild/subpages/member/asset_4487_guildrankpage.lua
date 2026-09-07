local GuildRankPage = class("GuildRankPage", import("...base.GuildBasePage"))

function GuildRankPage:getTargetUI()
	return "GuildRankBluePage", "GuildRankRedPage"
end

local var_0_1 = {
	"commit",
	"task",
	"battle"
}
local var_0_2 = {
	i18n("guild_member_rank_title_donate"),
	i18n("guild_member_rank_title_finish_cnt"),
	i18n("guild_member_rank_title_join_cnt")
}

function GuildRankPage:PageId2RankLabel()
	return var_0_2[self]
end

function GuildRankPage:GetRank(arg_3_1)
	return self.ranks[arg_3_1]
end

function GuildRankPage:OnUpdateRankList(arg_4_1, arg_4_2)
	if arg_4_2 and table.getCount(arg_4_2) > 0 then
		self.ranks[arg_4_1] = arg_4_2

		if self.pageId == arg_4_1 then
			self:SwitchPage(arg_4_1)
		end
	end

	return
end

function GuildRankPage:OnLoaded()
	self.tabContainer = self._tf:Find("frame/bg/tab")
	self.ranTypeTF = self._tf:Find("frame/bg/week")
	self.closeBtn = self._tf:Find("frame/close")
	self.rankLabel = self._tf:Find("frame/bg/title/Text"):GetComponent(typeof(Text))
	self.scrollrect = self._tf:Find("frame/bg/scrollrect"):GetComponent("LScrollRect")

	function self.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	setActive(self.ranTypeTF:Find("month"), true)
	setActive(self.ranTypeTF:Find("total"), true)

	return
end

function GuildRankPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	local function var_7_0()
		if self.pageId then
			self:SwitchPage(self.pageId)
		end

		self.ranTypeTF:Find("month"):GetComponent(typeof(Image)).enabled = self.ranType == 0
		self.ranTypeTF:Find("total"):GetComponent(typeof(Image)).enabled = self.ranType == 2
		self.ranTypeTF:GetComponent(typeof(Image)).enabled = self.ranType == 1

		return
	end

	self.ranType = 0

	onButton(self, self.ranTypeTF, function()
		self.ranType = (self.ranType + 1) % 3

		var_7_0()

		return
	end, SFX_PANEL)
	self:InitTags()
	var_7_0()

	return
end

function GuildRankPage:InitTags()
	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		onToggle(self, self.tabContainer:Find(iter_12_1), function(arg_13_0)
			if arg_13_0 then
				self:SwitchPage(iter_12_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function GuildRankPage:Flush(arg_14_1)
	self.ranks = arg_14_1

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:Show()
	self._tf:SetAsLastSibling()
	triggerToggle(self.tabContainer:Find("commit"), true)

	return
end

function GuildRankPage:SwitchPage(arg_15_1)
	self.pageId = arg_15_1

	self.scrollrect:SetTotalCount(0)

	local var_15_0 = self:GetRank(arg_15_1)

	if var_15_0 then
		if getProxy(GuildProxy):ShouldRefreshRank(arg_15_1) then
			self:emit(GuildMemberMediator.GET_RANK, arg_15_1)

			goto label_15_0
		end
	end

	assert(var_15_0)
	self:InitRank(var_15_0)

	::label_15_0::

	self.rankLabel.text = GuildRankPage.PageId2RankLabel(arg_15_1)

	return
end

function GuildRankPage:InitRank(arg_16_1)
	self.displays = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		table.insert(self.displays, iter_16_1)
	end

	table.sort(self.displays, function(arg_17_0, arg_17_1)
		return arg_17_0:GetScore(self.ranType) > arg_17_1:GetScore(self.ranType)
	end)
	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function GuildRankPage:OnUpdateItem(arg_18_1, arg_18_2)
	setText(tf(arg_18_2):Find("number"), arg_18_1 + 1)
	setText(tf(arg_18_2):Find("name"), self.displays[arg_18_1 + 1]:GetName())
	setText(tf(arg_18_2):Find("score"), self.displays[arg_18_1 + 1]:GetScore(self.ranType))

	return
end

function GuildRankPage:Hide()
	if self:isShowing() then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	GuildRankPage.super.Hide(self)

	return
end

function GuildRankPage:OnDestroy()
	self:Hide()

	return
end

return GuildRankPage
