local var_0_0 = singletonClass("HeroClueData")

function var_0_0.Init(arg_1_0)
	arg_1_0.inited_ = {}
	arg_1_0.unlockClueDataDic_ = {}
	arg_1_0.newClueDic_ = {}
	arg_1_0.selectedClue_ = {}
end

function var_0_0.IsInited(arg_2_0, arg_2_1)
	return arg_2_0.inited_[arg_2_1] == true
end

function var_0_0.InitData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	arg_3_0.inited_[var_3_0] = true
	arg_3_0.unlockClueDataDic_ = {}
	arg_3_0.newClueDic_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.clue_list) do
		local var_3_1 = iter_3_1.id
		local var_3_2 = iter_3_1.num

		arg_3_0.unlockClueDataDic_[var_3_1] = {}
		arg_3_0.unlockClueDataDic_[var_3_1].id = var_3_1
		arg_3_0.unlockClueDataDic_[var_3_1].num = var_3_2

		arg_3_0:UpdateClueLevel(var_3_1)
	end

	arg_3_0.selectedClue_[var_3_0] = {}
end

function var_0_0.GetUnlockClueDataDic(arg_4_0)
	return arg_4_0.unlockClueDataDic_ or {}
end

function var_0_0.SetUnlockClue(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.unlockClueDataDic_[arg_5_1] then
		arg_5_0.unlockClueDataDic_[arg_5_1] = {
			id = arg_5_1,
			num = arg_5_2
		}
		arg_5_0.newClueDic_[arg_5_1] = true
	else
		arg_5_0.unlockClueDataDic_[arg_5_1].num = arg_5_0.unlockClueDataDic_[arg_5_1].num + arg_5_2
	end

	arg_5_0:UpdateClueLevel(arg_5_1)
end

function var_0_0.UpdateClueLevel(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.unlockClueDataDic_[arg_6_1].num
	local var_6_1 = 0
	local var_6_2 = HeroClueCfg[arg_6_1].level

	for iter_6_0 = #var_6_2, 1, -1 do
		if var_6_0 >= var_6_2[iter_6_0] then
			var_6_1 = iter_6_0

			break
		end
	end

	arg_6_0.unlockClueDataDic_[arg_6_1].level = var_6_1
end

function var_0_0.GetNewClueDic(arg_7_0)
	return arg_7_0.newClueDic_
end

function var_0_0.SetNewClueDic(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.newClueDic_[arg_8_1] = arg_8_2
end

function var_0_0.GetSelectedClue(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0.selectedClue_[arg_9_1][arg_9_2]
end

function var_0_0.SetSelectedClue(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, arg_10_1, arg_10_2)

	if manager.redPoint:getTipBoolean(var_10_0) == false then
		return
	end

	arg_10_0.selectedClue_[arg_10_1][arg_10_2] = true

	arg_10_0:SetNewClueDic(arg_10_2, false)
	HeroClueAction.UpdateNewClueRedPoint(arg_10_1)
end

return var_0_0
