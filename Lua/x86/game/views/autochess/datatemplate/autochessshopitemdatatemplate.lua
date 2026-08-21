local var_0_0 = class("AutoChessShopItemDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.shopType = AutoChessConst.SHOP_TYPE.NORMAL
	arg_1_0.uniqueId = 0
	arg_1_0.chessId = 0
	arg_1_0.index = 0
	arg_1_0.attributeData = nil
	arg_1_0.isLock = 0
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.shopType = arg_2_1.shop_type
	arg_2_0.uniqueId = arg_2_1.shop_unique_id
	arg_2_0.chessId = arg_2_1.id
	arg_2_0.isLock = arg_2_1.is_lock
	arg_2_0.index = arg_2_1.index

	arg_2_0:UpdateAttribute(arg_2_1.chess_attr_list)
end

function var_0_0.UpdateAttribute(arg_3_0, arg_3_1)
	arg_3_0.attributeData = AutoChessItemAttributeDataTemplate.New()

	arg_3_0.attributeData:Init(arg_3_1, arg_3_0.chessId)
end

function var_0_0.GetBuffList(arg_4_0)
	if arg_4_0.shopType == AutoChessConst.SHOP_TYPE.PROP then
		return {}
	end

	local var_4_0 = {}
	local var_4_1 = AutoChessCfg[arg_4_0.chessId]

	for iter_4_0, iter_4_1 in ipairs(var_4_1.level_buffs[1]) do
		local var_4_2 = AutoChessBuffDataTemplate.New()

		var_4_2:Init({
			buff_id = iter_4_1
		})
		table.insert(var_4_0, var_4_2)
	end

	return var_4_0
end

function var_0_0.GetBuffOtherParams(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(arg_5_0:GetBuffList()) do
		if iter_5_1.buffId == arg_5_1 then
			if var_5_0 == nil then
				var_5_0 = iter_5_1.otherParamFields
			else
				for iter_5_2, iter_5_3 in pairs(iter_5_1.otherParamFields) do
					var_5_0[iter_5_2] = var_5_0[iter_5_2] + iter_5_3
				end
			end
		end
	end

	return var_5_0
end

return var_0_0
