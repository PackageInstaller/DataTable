local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {
	spr = "sort_login"
}

i18n = var_0_10003
var_0_2.tag = var_0_10003("word_default")

function var_0_2.func(arg_1_0, arg_1_1)
	table = var_1_10002

	var_1_10002.sort(arg_1_0, function(arg_2_0, arg_2_1)
		if arg_2_0.unreadCount == arg_2_1.unreadCount then
			if arg_2_0.online == arg_2_1.online then
				if arg_2_0.preOnLineTime == arg_2_1.preOnLineTime then
					return arg_2_0.id < arg_2_1.id
				elseif arg_1_1 then
					return arg_2_0.preOnLineTime < arg_2_1.preOnLineTime
				else
					return arg_2_0.preOnLineTime > arg_2_1.preOnLineTime
				end
			elseif arg_1_1 then
				return arg_2_0.online < arg_2_1.online
			else
				return arg_2_0.online > arg_2_1.online
			end
		else
			return arg_2_0.unreadCount > arg_2_1.unreadCount
		end

		return
	end)

	return
end

var_0_1[1] = var_0_2

local var_0_3 = {
	spr = "sort_star"
}

i18n = var_3
var_0_3.tag = var_3("word_star")

function var_0_3.func(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.ship_data_statistics

	table = var_1_10003

	var_1_10003.sort(arg_3_0, function(arg_4_0, arg_4_1)
		if var_3_0[arg_4_0.icon].star == var_3_0[arg_4_1.icon].star then
			if arg_4_0.level == arg_4_1.level then
				return arg_4_0.id < arg_4_1.id
			elseif arg_3_1 then
				return arg_4_0.level < arg_4_1.level
			else
				return arg_4_0.level > arg_4_1.level
			end
		elseif arg_3_1 then
			return var_3_0[arg_4_0.icon].star < var_3_0[arg_4_1.icon].star
		else
			return var_3_0[arg_4_0.icon].star > var_3_0[arg_4_1.icon].star
		end

		return
	end)

	return
end

var_0_1[2] = var_0_3

local var_0_4 = {
	spr = "sort_lv"
}

i18n = var_3
var_0_4.tag = var_3("word_level")

function var_0_4.func(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.sort(arg_5_0, function(arg_6_0, arg_6_1)
		if arg_6_0.level == arg_6_1.level then
			return arg_6_0.id < arg_6_1.id
		elseif arg_5_1 then
			return arg_6_0.level < arg_6_1.level
		else
			return arg_6_0.level > arg_6_1.level
		end

		return
	end)

	return
end

var_0_1[3] = var_0_4
var_0_0.SORT_TAG = var_0_1

return var_0_0
