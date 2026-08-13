class = var_0_10000

local var_0_0 = var_0_10000("Nation")

var_0_0.CM = 0
var_0_0.US = 1
var_0_0.EN = 2
var_0_0.JP = 3
var_0_0.DE = 4
var_0_0.CN = 5
var_0_0.ITA = 6
var_0_0.SN = 7
var_0_0.FF = 8
var_0_0.MNF = 9
var_0_0.FR = 10
var_0_0.NL = 11
var_0_0.LDP = 12
var_0_0.MOT = 96
var_0_0.META = 97
var_0_0.BURIN = 98
var_0_0.SIRE = 99
var_0_0.LINK = 100
var_0_0.IDOL_LINK = 107
var_0_0.YUMIA = 113

function var_0_0.IsLinkType(arg_1_0)
	return arg_1_0 > var_0_0.LINK
end

function var_0_0.IsMeta(arg_2_0)
	return arg_2_0 == var_0_0.META
end

function var_0_0.Nation2Print(arg_3_0)
	if not var_0_0.prints then
		var_0_0.prints = {
			[0] = "um",
			115,
			"um",
			98,
			"cm",
			106,
			"um",
			114,
			"um",
			99,
			"sr",
			105,
			"um",
			cm = "us",
			en = "jp",
			de = "cn",
			ita = "sn",
			ff = "mnf",
			ff = "nl",
			ldp = 96,
			mot = 113,
			um = 104,
			um = 112,
			um = 97,
			meta = 111,
			um = 102,
			bili = 110,
			um = 103,
			um = 109,
			um = 117,
			um = 108,
			um = 101,
			np = 107
		}
	end

	return var_0_0.prints[arg_3_0]
end

function var_0_0.Nation2Side(arg_4_0)
	if not var_0_0.side then
		var_0_0.side = {
			[0] = "Jp",
			107,
			"Imas",
			115,
			"West",
			98,
			"West",
			106,
			"West",
			114,
			"West",
			105,
			"Jp",
			West = "West",
			West = "Jp",
			West = "Cn",
			West = "West",
			West = "West",
			West = "West",
			West = 113,
			West = 96,
			West = 104,
			West = 112,
			Jp = 97,
			Meta = 111,
			Jp = 102,
			Cn = 110,
			Jp = 103,
			Jp = 109,
			West = 117,
			West = 108,
			Jp = 101
		}
	end

	return var_0_0.side[arg_4_0]
end

function var_0_0.Nation2BG(arg_5_0)
	if not var_0_0.bg then
		var_0_0.bg = {
			[0] = "bg/bg_church",
			107,
			"bg/bg_church_imas",
			115,
			"bg/bg_church",
			98,
			"bg/bg_church",
			106,
			"bg/bg_church",
			114,
			"bg/bg_church",
			105,
			"bg/bg_church",
			["bg/bg_church"] = "bg/bg_church",
			["bg/bg_church"] = "bg/bg_church_jp",
			["bg/bg_church"] = "bg/bg_church_cn",
			["bg/bg_church"] = "bg/bg_church",
			["bg/bg_church"] = "bg/bg_church",
			["bg/bg_church"] = "bg/bg_church",
			["bg/bg_church"] = 113,
			["bg/bg_church"] = 96,
			["bg/bg_church"] = 104,
			["bg/bg_church"] = 112,
			["bg/bg_church"] = 97,
			["bg/bg_church_meta"] = 111,
			["bg/bg_church"] = 102,
			["bg/bg_church"] = 110,
			["bg/bg_church"] = 103,
			["bg/bg_church"] = 109,
			["bg/bg_church"] = 117,
			["bg/bg_church"] = 108,
			["bg/bg_church"] = 101
		}
	end

	return var_0_0.bg[arg_5_0]
end

function var_0_0.Nation2Name(arg_6_0)
	if not var_0_0.nationName then
		local var_6_0 = var_0_0
		local var_6_1 = {}

		i18n = var_1_10003
		var_6_1[0] = var_1_10003("word_shipNation_other")
		i18n = var_3
		var_6_1[1] = var_3("word_shipNation_baiYing")
		i18n = var_3
		var_6_1[2] = var_3("word_shipNation_huangJia")
		i18n = var_3
		var_6_1[3] = var_3("word_shipNation_chongYing")
		i18n = var_3
		var_6_1[4] = var_3("word_shipNation_tieXue")
		i18n = var_3
		var_6_1[5] = var_3("word_shipNation_dongHuang")
		i18n = var_3
		var_6_1[6] = var_3("word_shipNation_saDing")
		i18n = var_3
		var_6_1[7] = var_3("word_shipNation_beiLian")
		i18n = var_3
		var_6_1[8] = var_3("word_shipNation_ziyou")
		i18n = var_3
		var_6_1[9] = var_3("word_shipNation_weixi")
		i18n = var_3
		var_6_1[10] = var_3("word_shipNation_yuanwei")
		i18n = var_3
		var_6_1[11] = var_3("word_shipNation_yujinwangguo")
		i18n = var_3
		var_6_1[12] = var_3("word_shipNation_jinghuanlianmeng")
		i18n = var_3
		var_6_1[96] = var_3("word_shipNation_mot")
		i18n = var_3
		var_6_1[97] = var_3("word_shipNation_meta")
		i18n = var_3
		var_6_1[98] = var_3("word_shipNation_other")
		i18n = var_3
		var_6_1[101] = var_3("word_shipNation_np")
		i18n = var_3
		var_6_1[102] = var_3("word_shipNation_bili")
		i18n = var_3
		var_6_1[103] = var_3("word_shipNation_um")
		i18n = var_3
		var_6_1[104] = var_3("word_shipNation_ai")
		i18n = var_3
		var_6_1[105] = var_3("word_shipNation_holo")
		i18n = var_3
		var_6_1[106] = var_3("word_shipNation_doa")
		i18n = var_3
		var_6_1[107] = var_3("word_shipNation_imas")
		i18n = var_3
		var_6_1[108] = var_3("word_shipNation_ssss")
		i18n = var_3
		var_6_1[109] = var_3("word_shipNation_ryza")
		i18n = var_3
		var_6_1[110] = var_3("word_shipNation_senran")
		i18n = var_3
		var_6_1[111] = var_3("word_shipNation_tolove")
		i18n = var_3
		var_6_1[112] = var_3("word_shipNation_brs")
		i18n = var_3
		var_6_1[113] = var_3("word_shipNation_yumia")
		i18n = var_3
		var_6_1[114] = var_3("word_shipNation_danmachi")
		i18n = var_3
		var_6_1[115] = var_3("word_shipNation_dal")
		i18n = var_3
		var_6_1[117] = var_3("word_shipNation_nierautomata")
		var_6_0.nationName = var_6_1
	end

	return var_0_0.nationName[arg_6_0]
end

function var_0_0.Nation2facionName(arg_7_0)
	if not var_0_0.facionName then
		local var_7_0 = var_0_0
		local var_7_1 = {}

		i18n = var_1_10003
		var_7_1[0] = var_1_10003("guild_faction_unknown")
		i18n = var_3
		var_7_1[1] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[2] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[3] = var_3("guild_faction_cszz")
		i18n = var_3
		var_7_1[4] = var_3("guild_faction_cszz")
		i18n = var_3
		var_7_1[5] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[6] = var_3("guild_faction_cszz")
		i18n = var_3
		var_7_1[7] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[8] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[9] = var_3("guild_faction_cszz")
		i18n = var_3
		var_7_1[10] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[11] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[12] = var_3("guild_faction_blhx")
		i18n = var_3
		var_7_1[96] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[97] = var_3("guild_faction_meta")
		i18n = var_3
		var_7_1[98] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[101] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[102] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[103] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[104] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[105] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[106] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[107] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[108] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[109] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[110] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[111] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[112] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[113] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[114] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[115] = var_3("guild_faction_unknown")
		i18n = var_3
		var_7_1[117] = var_3("guild_faction_unknown")
		var_7_0.facionName = var_7_1
	end

	return var_0_0.facionName[arg_7_0]
end

return var_0_0
