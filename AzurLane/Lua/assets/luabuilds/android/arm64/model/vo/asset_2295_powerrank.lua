class = var_0_10000

local var_0_0 = "PowerRank"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerAttire"))

var_0_1.TYPE_POWER = 1
var_0_1.TYPE_COLLECTION = 2
var_0_1.TYPE_PT = 3
var_0_1.TYPE_PLEDGE = 4
var_0_1.TYPE_CHALLENGE = 5
var_0_1.TYPE_EXTRA_CHAPTER = 6
var_0_1.TYPE_ACT_BOSS_BATTLE = 7
var_0_1.TYPE_GUILD_BATTLE = 8
var_0_1.TYPE_MILITARY_RANK = 9
var_0_1.TYPE_BOSSRUSH = 10
var_0_1.TYPE_ISLAND_SEASON_PT = 11
var_0_1.TYPE_TB_ENDLESS_WAVE = 12
var_0_1.TYPE_TB_ATTR_SUM = 13

local var_0_2 = {
	{
		title_word = {
			5,
			8,
			7,
			1
		},
		score_icon = {
			"ui/billboardui_atlas",
			"power_icon"
		}
	},
	{
		title_word = {
			5,
			8,
			7,
			2
		}
	}
}
local var_0_3 = {
	title_word = {
		5,
		8,
		7,
		2
	},
	score_icon = {
		"ui/commonui_atlas",
		"pt_icon"
	}
}

ActivityConst = var_3
var_0_3.act_type = var_3.ACTIVITY_TYPE_PT_RANK
var_0_2[3] = var_0_3
var_0_2[4] = {
	title_word = {
		5,
		8,
		7,
		3
	}
}

local var_0_4 = {
	title_word = {
		5,
		8,
		7,
		4
	}
}

ActivityConst = var_3
var_0_4.act_type = var_3.ACTIVITY_TYPE_CHALLENGE_RANK
var_0_2[5] = var_0_4

local var_0_5 = {
	title_word = {
		5,
		8,
		7,
		4
	}
}

ActivityConst = var_3
var_0_5.act_type = var_3.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK
var_0_2[6] = var_0_5

local var_0_6 = {
	title_word = {
		5,
		8,
		7,
		10
	}
}

ActivityConst = var_3
var_0_6.act_type = var_3.ACTIVITY_TYPE_BOSS_RANK
var_0_2[7] = var_0_6
var_0_2[9] = {
	title_word = {
		5,
		8,
		6,
		9
	},
	score_icon = {
		"ui/billboardui_atlas",
		"rank_icon"
	}
}

local var_0_7 = {
	title_word = {
		5,
		8,
		7,
		4
	}
}

ActivityConst = var_3
var_0_7.act_type = var_3.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK
var_0_2[10] = var_0_7
var_0_1.typeInfo = var_0_2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.user_id then
		var_1_0 = arg_1_1.id
	end

	arg_1_0.id = var_1_0

	local var_1_1

	if not arg_1_1.lv then
		var_1_1 = arg_1_1.level
	end

	arg_1_0.lv = var_1_1
	arg_1_0.name = arg_1_1.name

	local var_1_2

	if not arg_1_1.point and not arg_1_1.score then
		var_1_2 = 0
	end

	arg_1_0.power = var_1_2

	local var_1_3

	if not arg_1_1.rank then
		var_1_3 = 0
	end

	arg_1_0.rank = var_1_3
	math = var_1_3

	local var_1_4 = var_1_3.min

	math = var_5

	local var_1_5 = var_5.max
	local var_1_6

	if not arg_1_1.arena_rank then
		var_1_6 = 0
	end

	arg_1_0.arenaRank = var_1_4(var_1_5(var_1_6, 1), 14)
	assert = var_3

	var_3(arg_1_2, "type can not be nil")

	arg_1_0.type = arg_1_2

	return
end

function var_0_1.getPainting(arg_2_0)
	pg = var_1_10001

	local var_2_0

	if not var_1_10001.ship_skin_template[arg_2_0.skinId] or not var_1.painting then
		var_2_0 = "unknown"
	end

	return var_2_0
end

function var_0_1.setRank(arg_3_0, arg_3_1)
	arg_3_0.rank = arg_3_1

	return
end

function var_0_1.setArenaRank(arg_4_0, arg_4_1)
	arg_4_0.arenaRank = arg_4_1

	return
end

function var_0_1.getPowerTxt(arg_5_0)
	if arg_5_0.type == var_0_1.TYPE_POWER then
		math = var_1

		return var_1.floor(arg_5_0.power^0.667)
	elseif arg_5_0.type == var_0_1.TYPE_COLLECTION then
		getProxy = var_1
		CollectionProxy = var_1_10003

		local var_5_0 = var_1(var_1_10003)
		local var_5_1 = var_1.getCollectionTotal(var_5_0)

		string = var_2

		return var_2.format("%0.01f", arg_5_0.power / var_5_1 * 100) .. "%"
	elseif arg_5_0.type == var_0_1.TYPE_MILITARY_RANK then
		local var_5_2 = arg_5_0.power

		SeasonInfo = var_2

		return var_5_2 + var_2.INIT_POINT
	else
		return arg_5_0.power
	end

	return
end

function var_0_1.getTitleWord(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0 = 1, 4 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_6_1 = var_6_0

		i18n = var_1_10011

		var_1_10008(var_6_1, var_1_10011("ranking_word_" .. var_0_1.typeInfo[arg_6_1].title_word[iter_6_0]))
	end

	if arg_6_1 == var_0_1.TYPE_PT then
		id2ItemId = var_4
		getProxy = var_6
		ActivityProxy = var_1_10008

		local var_6_2 = var_6(var_1_10008)
		local var_6_3 = var_6.getActivityById(var_6_2, arg_6_2)
		local var_6_4 = var_4(var_6.getConfig(var_6_3, "config_id"))

		Item = var_5
		var_6_0[4] = var_5.getConfigData(var_6_4).name
	end

	return var_6_0
end

function var_0_1.getScoreIcon(arg_7_0, arg_7_1)
	return var_0_1.typeInfo[arg_7_1].score_icon
end

function var_0_1.getActivityByRankType(arg_8_0, arg_8_1)
	if not var_0_1.typeInfo[arg_8_1].act_type then
		return nil
	end

	_ = var_2

	local var_8_0 = var_2.detect

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_8_1 = var_1_10004(var_1_10006)

	return var_8_0(var_4.getActivitiesByType(var_8_1, var_0_1.typeInfo[arg_8_1].act_type), function(arg_9_0)
		if not arg_9_0:isEnd() then
			local var_9_0

			if arg_8_1 == var_0_1.TYPE_PT then
				tonumber = var_1

				if not (var_1(arg_9_0:getConfig("config_data")) > 0) then
					var_9_0 = false

					goto label_9_0
				end
			end

			var_9_0 = true

			::label_9_0::

			return var_9_0
		end
	end)
end

return var_0_1
