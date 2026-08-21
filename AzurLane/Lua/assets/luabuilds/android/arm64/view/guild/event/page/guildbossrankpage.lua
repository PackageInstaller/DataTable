local var_0_0 = class("GuildBossRankPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildBossRankPage"
end

local function var_0_1(arg_2_0)
	({}).numer = arg_2_0.transform:Find("numer"):GetComponent(typeof(Text))
	;({}).name = arg_2_0.transform:Find("name"):GetComponent(typeof(Text))
	;({}).damage = arg_2_0.transform:Find("damage"):GetComponent(typeof(Text))
	;({}).Update = function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_0.numer.text = arg_3_1
		arg_3_0.name.text = arg_3_2.name
		arg_3_0.damage.text = arg_3_2.damage

		return
	end

	return {}
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0.scrollrect = arg_4_0._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")
	arg_4_0.closeBtn = arg_4_0._tf:Find("frame/close")

	setText(arg_4_0._tf:Find("frame/titles/num"), i18n("guild_damage_ranking"))
	setText(arg_4_0._tf:Find("frame/titles/member"), i18n("guild_word_member"))
	setText(arg_4_0._tf:Find("frame/titles/damage"), i18n("guild_total_damage"))

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)

	function arg_5_0.scrollrect.onInitItem(arg_8_0)
		arg_5_0:OnInitItem(arg_8_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_9_0, arg_9_1)
		arg_5_0:OnUpdateItem(arg_9_0, arg_9_1)

		return
	end

	arg_5_0.cards = {}

	return
end

function var_0_0.OnInitItem(arg_10_0, arg_10_1)
	arg_10_0.cards[arg_10_1] = var_0_1(arg_10_1)

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.cards[arg_11_2]:Update(arg_11_1 + 1, arg_11_0.ranks[arg_11_1 + 1])

	return
end

function var_0_0.Show(arg_12_0, arg_12_1)
	var_0_0.super.Show(arg_12_0)

	arg_12_0.ranks = arg_12_1

	arg_12_0.scrollrect:SetTotalCount(#arg_12_1)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	return
end

return var_0_0
