local GuildBossRankPage = class("GuildBossRankPage", import("....base.BaseSubView"))

function GuildBossRankPage:getUIName()
	return "GuildBossRankPage"
end

local function var_0_1(arg_2_0)
	local var_2_0 = {}

	var_2_0.numer = arg_2_0.transform:Find("numer"):GetComponent(typeof(Text))
	var_2_0.name = arg_2_0.transform:Find("name"):GetComponent(typeof(Text))
	var_2_0.damage = arg_2_0.transform:Find("damage"):GetComponent(typeof(Text))

	function var_2_0:Update(arg_3_1, arg_3_2)
		self.numer.text = arg_3_1
		self.name.text = arg_3_2.name
		self.damage.text = arg_3_2.damage

		return
	end

	return var_2_0
end

function GuildBossRankPage:OnLoaded()
	self.scrollrect = self._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")
	self.closeBtn = self._tf:Find("frame/close")

	setText(self._tf:Find("frame/titles/num"), i18n("guild_damage_ranking"))
	setText(self._tf:Find("frame/titles/member"), i18n("guild_word_member"))
	setText(self._tf:Find("frame/titles/damage"), i18n("guild_total_damage"))

	return
end

function GuildBossRankPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	function self.scrollrect.onInitItem(arg_8_0)
		self:OnInitItem(arg_8_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_9_0, arg_9_1)
		self:OnUpdateItem(arg_9_0, arg_9_1)

		return
	end

	self.cards = {}

	return
end

function GuildBossRankPage:OnInitItem(arg_10_1)
	self.cards[arg_10_1] = var_0_1(arg_10_1)

	return
end

function GuildBossRankPage:OnUpdateItem(arg_11_1, arg_11_2)
	self.cards[arg_11_2]:Update(arg_11_1 + 1, self.ranks[arg_11_1 + 1])

	return
end

function GuildBossRankPage:Show(arg_12_1)
	GuildBossRankPage.super.Show(self)

	self.ranks = arg_12_1

	self.scrollrect:SetTotalCount(#arg_12_1)

	return
end

function GuildBossRankPage:OnDestroy()
	return
end

return GuildBossRankPage
