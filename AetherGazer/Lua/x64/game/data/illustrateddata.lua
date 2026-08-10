local var_0_0 = singletonClass("IllustratedData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = 0
local var_0_11 = {}

local function var_0_12(arg_1_0)
	if arg_1_0 == CollectConst.INFORMATION then
		return var_0_2
	end

	if arg_1_0 == CollectConst.ENEMY then
		return var_0_3
	end

	if arg_1_0 == CollectConst.SERVANT then
		return var_0_4
	end

	if arg_1_0 == CollectConst.EQUIP then
		return var_0_6
	end

	if arg_1_0 == CollectConst.PLOT then
		return var_0_7
	end

	if arg_1_0 == CollectConst.ILLUSTRATION then
		return var_0_8
	end

	if arg_1_0 == CollectConst.WORLDVIEW then
		return var_0_9
	end
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_6 = {}
	var_0_7 = {}
	var_0_8 = {}
	var_0_9 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.intelligence_reward) do
		var_0_2[iter_2_1.id] = {
			id = iter_2_1.id,
			progress = iter_2_1.progress,
			complete_flag = iter_2_1.complete_flag
		}
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.enemy_info) do
		var_0_3[iter_2_3.id] = {
			id = iter_2_3.id,
			times = iter_2_3.times,
			is_view = iter_2_3.is_view
		}
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.servant_info) do
		var_0_4[iter_2_5.id] = {
			id = iter_2_5.id,
			is_view = iter_2_5.is_view
		}
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.equip_info) do
		var_0_6[iter_2_7.suit] = {
			suit = iter_2_7.suit,
			pos_list = {},
			is_view = iter_2_7.is_view
		}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.pos_list) do
			var_0_6[iter_2_7.suit].pos_list[iter_2_9] = 1
		end
	end

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.plot_info) do
		var_0_7[iter_2_11.id] = {
			id = iter_2_11.id,
			is_view = iter_2_11.is_view
		}
	end

	for iter_2_12, iter_2_13 in ipairs(arg_2_1.inbetweening_info) do
		var_0_8[iter_2_13.id] = {
			id = iter_2_13.id,
			is_receive = iter_2_13.is_receive,
			is_view = iter_2_13.is_view
		}
	end

	for iter_2_14, iter_2_15 in ipairs(arg_2_1.affix_info) do
		var_0_9[iter_2_15.id] = {
			id = iter_2_15.id,
			is_view = iter_2_15.is_view
		}
	end
end

function var_0_0.GetIntelligenceReward(arg_3_0)
	return var_0_2
end

function var_0_0.GetEnemyInfo(arg_4_0)
	return var_0_3
end

function var_0_0.GetServantInfo(arg_5_0)
	return var_0_4
end

function var_0_0.GetEquipInfo(arg_6_0)
	return var_0_6
end

function var_0_0.GetPlotInfo(arg_7_0)
	return var_0_7
end

function var_0_0.GetIllustrationInfo(arg_8_0)
	return var_0_8
end

function var_0_0.GetAffixInfo(arg_9_0)
	return var_0_9
end

function var_0_0.GetInfoIsView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_12(arg_10_1)

	if not var_10_0[arg_10_2] then
		return 0
	end

	return var_10_0[arg_10_2].is_view
end

function var_0_0.ModifyEnemyInfo(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_0_3[iter_11_1.id] = {
			id = iter_11_1.id,
			times = iter_11_1.times,
			is_view = iter_11_1.is_view
		}
	end
end

function var_0_0.ModifyIntelligenceReward(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		var_0_2[iter_12_1.id] = {
			id = iter_12_1.id,
			progress = iter_12_1.progress,
			complete_flag = iter_12_1.complete_flag
		}
	end
end

function var_0_0.ModifyIllustrationInfo(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_0_8[iter_13_1.id] = {
			id = iter_13_1.id,
			is_receive = iter_13_1.is_receive,
			is_view = iter_13_1.is_view
		}
	end
end

function var_0_0.ModifyAffixInfo(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		var_0_9[iter_14_1.id] = {
			id = iter_14_1.id,
			is_view = iter_14_1.is_view
		}
	end
end

function var_0_0.ModifyServantInfo(arg_15_0, arg_15_1)
	if not var_0_4[arg_15_1] then
		local var_15_0 = {
			is_view = 0,
			id = arg_15_1
		}

		var_0_5[arg_15_1] = var_15_0
		var_0_4[arg_15_1] = var_15_0
	end
end

function var_0_0.ModifyPlotInfo(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		var_0_7[iter_16_1.id] = {
			id = iter_16_1.id,
			is_view = iter_16_1.is_view
		}
	end
end

function var_0_0.GetNewObtainedServant(arg_17_0, arg_17_1)
	return var_0_5[arg_17_1]
end

function var_0_0.ConsumeNewObtainedServant(arg_18_0)
	local var_18_0
	local var_18_1 = var_0_5

	var_0_5 = {}

	return var_18_1
end

function var_0_0.ModifyEquipInfo(arg_19_0, arg_19_1, arg_19_2)
	if not var_0_6[arg_19_1] then
		var_0_6[arg_19_1] = {
			is_view = 0,
			suit = arg_19_1,
			pos_list = {}
		}
	end

	var_0_6[arg_19_1].pos_list[arg_19_2] = 1
end

function var_0_0.ModifyPlot(arg_20_0, arg_20_1)
	if not var_0_7[arg_20_1] then
		var_0_7[arg_20_1] = {
			is_view = 0,
			id = arg_20_1
		}
	end
end

function var_0_0.GetIsView(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	if arg_21_2 == CollectConst.ENEMY then
		var_21_0 = var_0_3[arg_21_1]
	elseif arg_21_2 == CollectConst.SERVANT then
		var_21_0 = var_0_4[arg_21_1]
	elseif arg_21_2 == CollectConst.EQUIP then
		var_21_0 = var_0_6[arg_21_1]
	elseif arg_21_2 == CollectConst.PLOT then
		var_21_0 = var_0_7[arg_21_1]
	elseif arg_21_2 == CollectConst.ILLUSTRATION then
		var_21_0 = var_0_8[arg_21_1]
	elseif arg_21_2 == CollectConst.WORLDVIEW then
		var_21_0 = var_0_9[arg_21_1]
	else
		error("未知类型")
	end

	if var_21_0 == nil then
		return 0
	end

	return var_21_0.is_view
end

function var_0_0.ModifyView(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 == CollectConst.ENEMY then
		var_0_3[arg_22_1].is_view = 1
	elseif arg_22_2 == CollectConst.SERVANT then
		var_0_4[arg_22_1].is_view = 1
	elseif arg_22_2 == CollectConst.EQUIP then
		var_0_6[arg_22_1].is_view = 1
	elseif arg_22_2 == CollectConst.PLOT then
		var_0_7[arg_22_1].is_view = 1
	elseif arg_22_2 == CollectConst.ILLUSTRATION then
		var_0_8[arg_22_1].is_view = 1
	elseif arg_22_2 == CollectConst.WORLDVIEW then
		var_0_9[arg_22_1].is_view = 1
	else
		error("未知类型")
	end
end

function var_0_0.GetExistServant(arg_23_0, arg_23_1)
	if not var_0_4[arg_23_1] then
		var_0_4[arg_23_1] = {
			is_view = 0,
			id = arg_23_1
		}

		return false
	end

	return true
end

function var_0_0.ModifyData(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_0 = arg_24_1.type
		local var_24_1 = arg_24_1.id

		if not var_0_1[var_24_0] then
			var_0_1[var_24_0] = {}
		end

		var_0_1[var_24_0][var_24_1] = {
			id = arg_24_1.id,
			progress = arg_24_1.progress,
			complete_flag = arg_24_1.complete_flag
		}
	end
end

function var_0_0.GetCollectionProgress(arg_25_0, arg_25_1, arg_25_2)
	return var_0_1[arg_25_1][arg_25_2].progress
end

function var_0_0.SetBgm(arg_26_0, arg_26_1)
	var_0_10 = arg_26_1
end

function var_0_0.GetBgm(arg_27_0)
	return var_0_10
end

function var_0_0.GetAllLoadingSet(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(var_0_11) do
		table.insertto(var_28_0, var_0_11[iter_28_0])
	end

	return var_28_0
end

function var_0_0.GetLoadingSetByType(arg_29_0, arg_29_1)
	return var_0_11[arg_29_1] or {}
end

function var_0_0.SaveLoadingSet(arg_30_0, arg_30_1)
	var_0_11 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		local var_30_0 = CollectPictureCfg[iter_30_1].type

		if not var_0_11[var_30_0] then
			var_0_11[var_30_0] = {}
		end

		table.insert(var_0_11[var_30_0], iter_30_1)
	end

	LoadingUI:ResetLoading()
end

function var_0_0.ChangeLoadingSet(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = CollectPictureCfg[arg_31_2].type

	if arg_31_1 then
		if not var_0_11[var_31_0] then
			var_0_11[var_31_0] = {}
		end

		table.insert(var_0_11[var_31_0], arg_31_2)
	else
		table.remove(var_0_11[var_31_0], table.indexof(var_0_11[var_31_0], arg_31_2))
	end

	LoadingUI:ResetLoading()
end

function var_0_0.IsInLoadingSet(arg_32_0, arg_32_1)
	local var_32_0 = CollectPictureCfg[arg_32_1].type

	return var_0_11[var_32_0] and table.indexof(var_0_11[var_32_0], arg_32_1) ~= false
end

return var_0_0
