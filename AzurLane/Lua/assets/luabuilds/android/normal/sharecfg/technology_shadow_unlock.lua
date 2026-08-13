pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "technology_shadow_unlock") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "technology_shadow_unlock"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.technology_shadow_unlock = var_0_2
pg = var_0

local var_0_3 = var_0.technology_shadow_unlock

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.technology_shadow_unlock = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.technology_shadow_unlock

	var_1_0[1] = {
		name = "相映同行",
		type = 1,
		id = 1,
		target_num = 120,
		desc = "<color=#a2a2a2>携手同行，彼此相映的足迹即是最珍贵的记忆</color>\n\n——角色等级达到120级"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.technology_shadow_unlock

	var_1_1[2] = {
		name = "知心共研",
		type = 2,
		id = 2,
		target_num = 30,
		desc = "<color=#a2a2a2>唯有彼此心照不宣，才能解锁未来的辉煌</color>\n\n——角色开发等级达到30级"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.technology_shadow_unlock

	var_1_2[3] = {
		name = "战火淬炼",
		type = 3,
		id = 3,
		target_num = 200,
		desc = "<color=#a2a2a2>战斗是磨砺、是淬炼，也是彼此默契的见证</color>\n\n——携带角色出击(关卡)胜利200次"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.technology_shadow_unlock

	var_1_3[4] = {
		name = "誓约任务",
		type = 4,
		id = 4,
		target_num = 1,
		desc = "<color=#a2a2a2>让誓约见证，那些关于美好与幸福的片段才会连接成属于永恒的篇章。</color>\n\n——与当前角色完成誓约。"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.technology_shadow_unlock

	var_1_4[5] = {
		name = "扩展栏位Ⅰ",
		type = 5,
		id = 5,
		target_num = 200,
		desc = "开启栏位需要消耗<color=#72bc42>$1钻石</color>,是否确认开启"
	}
	pg = var_1_4
	var_1_4.base.technology_shadow_unlock[6] = {
		name = "扩展栏位Ⅱ",
		type = 5,
		id = 6,
		target_num = 200,
		desc = "开启栏位需要消耗<color=#72bc42>$1钻石</color>,是否确认开启"
	}

	return
end)()

return
