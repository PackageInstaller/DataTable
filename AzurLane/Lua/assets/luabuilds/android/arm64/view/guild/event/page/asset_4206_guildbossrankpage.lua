class = var_0_10000

local var_0_0 = "GuildBossRankPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildBossRankPage"
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = arg_2_0.transform
	local var_2_2 = var_2.Find(var_2_1, "numer")
	local var_2_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_0.numer = var_2_3(var_2_2, var_5(var_1_10007))

	local var_2_4 = arg_2_0.transform
	local var_2_5 = var_2.Find(var_2_4, "name")
	local var_2_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_0.name = var_2_6(var_2_5, var_5(var_1_10007))

	local var_2_7 = arg_2_0.transform
	local var_2_8 = var_2.Find(var_2_7, "damage")
	local var_2_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_0.damage = var_2_9(var_2_8, var_5(var_1_10007))

	function var_2_0.Update(arg_3_0, arg_3_1, arg_3_2)
		arg_3_0.numer.text = arg_3_1
		arg_3_0.name.text = arg_3_2.name
		arg_3_0.damage.text = arg_3_2.damage

		return
	end

	return var_2_0
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "frame/scrollrect")

	arg_4_0.scrollrect = var_1.GetComponent(var_4_1, "LScrollRect")

	local var_4_2 = arg_4_0._tf

	arg_4_0.closeBtn = var_1.Find(var_4_2, "frame/close")
	setText = var_1

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_3.Find(var_4_3, "frame/titles/num")

	i18n = var_4

	var_1(var_4_4, var_4("guild_damage_ranking"))

	setText = var_1

	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "frame/titles/member")

	i18n = var_4

	var_1(var_4_6, var_4("guild_word_member"))

	setText = var_1

	local var_4_7 = arg_4_0._tf
	local var_4_8 = var_3.Find(var_4_7, "frame/titles/damage")

	i18n = var_4

	var_1(var_4_8, var_4("guild_total_damage"))

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.closeBtn

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	function arg_5_0.scrollrect.onInitItem(arg_8_0)
		local var_8_0 = arg_5_0

		var_1.OnInitItem(var_8_0, arg_8_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_9_0, arg_9_1)
		local var_9_0 = arg_5_0

		var_2.OnUpdateItem(var_9_0, arg_9_0, arg_9_1)

		return
	end

	arg_5_0.cards = {}

	return
end

function var_0_1.OnInitItem(arg_10_0, arg_10_1)
	local var_10_0 = var_0_2(arg_10_1)

	arg_10_0.cards[arg_10_1] = var_10_0

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.cards[arg_11_2]
	local var_11_1 = arg_11_0.ranks[arg_11_1 + 1]

	var_11_0:Update(arg_11_1 + 1, var_11_1)

	return
end

function var_0_1.Show(arg_12_0, arg_12_1)
	var_0_1.super.Show(arg_12_0)

	arg_12_0.ranks = arg_12_1

	local var_12_0 = arg_12_0.scrollrect

	var_2.SetTotalCount(var_12_0, #arg_12_1)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
