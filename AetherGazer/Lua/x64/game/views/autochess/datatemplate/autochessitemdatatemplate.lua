local var_0_0 = class("AutoChessItemDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.uniqueId = 0
	arg_1_0.chessId = 0
	arg_1_0.index = 0
	arg_1_0.attributeData = nil
	arg_1_0.buffDataList = {}
	arg_1_0.buffDataDic = {}
	arg_1_0.buffList = {}
	arg_1_0.usedPropsCount = 0
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.uniqueId = arg_2_1.unique_id
	arg_2_0.chessId = arg_2_1.chess_id
	arg_2_0.index = arg_2_1.index

	arg_2_0:UpdateAttribute(arg_2_1.chess_attr_list)
	arg_2_0:UpdateBuffDataList(arg_2_1.buff_list)
end

function var_0_0.UpdateAttribute(arg_3_0, arg_3_1)
	arg_3_0.attributeData = AutoChessItemAttributeDataTemplate.New()

	arg_3_0.attributeData:Init(arg_3_1, arg_3_0.chessId)
end

function var_0_0.UpdateBuffDataList(arg_4_0, arg_4_1)
	arg_4_0.buffDataList = {}
	arg_4_0.buffDataDic = {}
	arg_4_0.usedPropsCount = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = AutoChessBuffDataTemplate.New()

		var_4_0:Init(iter_4_1)

		arg_4_0.usedPropsCount = var_4_0.usedPropsCount or 0

		table.insert(arg_4_0.buffDataList, var_4_0)

		arg_4_0.buffDataDic[var_4_0.uniqueId] = var_4_0

		table.insert(arg_4_0.buffList, var_4_0.buffId)
	end
end

function var_0_0.RemoveBuff(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.buffDataDic[arg_5_1]
	local var_5_1 = table.indexof(arg_5_0.buffDataList, var_5_0)

	if var_5_1 then
		table.remove(arg_5_0.buffDataList, var_5_1)
		table.remove(arg_5_0.buffList, var_5_1)
	end

	arg_5_0.buffDataDic[arg_5_1] = nil
end

function var_0_0.AddBuff(arg_6_0, arg_6_1)
	table.insert(arg_6_0.buffDataList, arg_6_1)

	arg_6_0.buffDataDic[arg_6_1.uniqueId] = arg_6_1

	table.insert(arg_6_0.buffList, arg_6_1.buffId)
end

function var_0_0.RefreshBuff(arg_7_0, arg_7_1)
	if arg_7_0.buffDataDic[arg_7_1.uniqueId] then
		arg_7_0.buffDataDic[arg_7_1.uniqueId] = arg_7_1
	end
end

function var_0_0.GetBuffList(arg_8_0)
	return arg_8_0.buffDataList
end

function var_0_0.GetBuffOtherParams(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.buffDataDic) do
		if iter_9_1.buffId == arg_9_1 then
			if var_9_0 == nil then
				var_9_0 = iter_9_1.otherParamFields
			else
				for iter_9_2, iter_9_3 in pairs(iter_9_1.otherParamFields) do
					var_9_0[iter_9_2] = var_9_0[iter_9_2] + iter_9_3
				end
			end
		end
	end

	return var_9_0
end

function var_0_0.ContainBuff(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.buffList) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end

	return false
end

return var_0_0
