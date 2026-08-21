local var_0_0 = singletonClass("ActivityHeroEnhanceData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = false

function var_0_0.Init(arg_1_0)
	var_0_5 = false
	var_0_2 = {}
	read_list = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_1[var_2_0] = arg_2_1.day

	if var_0_5 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.mission_list) do
			if not table.indexof(var_0_2[var_2_0] or {}, iter_2_1) and not table.indexof(var_0_4, iter_2_1) then
				table.insert(var_0_4, iter_2_1)
			end
		end
	end

	var_0_2[var_2_0] = arg_2_1.mission_list
	var_0_3[var_2_0] = arg_2_1.talent_list

	manager.notify:CallUpdateFunc("OnActivityHeroEnhanceDataInit")

	var_0_5 = true
end

function var_0_0.GetCacheStageTalent(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(var_0_4) do
		table.insert(var_3_0, iter_3_1)
	end

	var_0_4 = {}

	return var_3_0
end

local function var_0_6(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if ActivityHeroEnhanceTools.IsTalentLock(arg_4_0, iter_4_1) then
			table.removebyvalue(var_0_3[arg_4_0], iter_4_1)
		end
	end
end

function var_0_0.ActivateTalent(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_3[arg_5_1]

	if table.keyof(var_5_0, arg_5_2) then
		return
	end

	local var_5_1 = ActivityHeroEnhanceTools.GetCfgByTalentId(arg_5_1, arg_5_2)
	local var_5_2 = TalentTreeCfg[arg_5_2]
	local var_5_3 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(var_5_1, var_5_2.stage)

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		table.removebyvalue(var_5_0, iter_5_1)
	end

	table.insert(var_5_0, arg_5_2)
	var_0_6(arg_5_1, var_5_1.talent_list)
end

function var_0_0.DeactivateTalent(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_3[arg_6_1]

	if var_6_0 == nil then
		return
	end

	table.removebyvalue(var_6_0, arg_6_2)

	local var_6_1 = ActivityHeroEnhanceTools.GetCfgByTalentId(arg_6_1, arg_6_2)

	var_0_6(arg_6_1, var_6_1.talent_list)
end

function var_0_0.AddClearedStage(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_2[arg_7_1]

	if table.indexof(var_7_0, arg_7_2) then
		-- block empty
	else
		if not table.indexof(var_0_4, arg_7_2) then
			table.insert(var_0_4, arg_7_2)
		end

		table.insert(var_7_0, arg_7_2)
	end
end

function var_0_0.IsTalentActivated(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_3[arg_8_1]

	if var_8_0 == nil then
		return false
	end

	return table.indexof(var_8_0, arg_8_2) ~= false
end

function var_0_0.IsStageClear(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_2[arg_9_1]

	if var_9_0 == nil then
		return false
	end

	return table.indexof(var_9_0, arg_9_2) ~= false
end

function var_0_0.GetDay(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1] or -1
end

return var_0_0
