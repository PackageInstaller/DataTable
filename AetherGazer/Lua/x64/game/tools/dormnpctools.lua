local var_0_0 = {
	BackHomeNpcType = {
		cook = 1,
		waiter = 2,
		cashier = 3
	},
	GetNpcInfoListByConstJobType = function(arg_1_0, arg_1_1)
		local var_1_0 = {}
		local var_1_1 = BackHomeNpcData:GetBackHomeNpcInfoList()

		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			if iter_1_1.constJobType == arg_1_1 then
				table.insert(var_1_0, iter_1_0)
			end
		end

		return var_1_0
	end,
	CheckIDIsNpc = function(arg_2_0, arg_2_1)
		if BackHomeNpcCfg[arg_2_1] then
			return true
		end
	end,
	GetNpcFatigue = function(arg_3_0, arg_3_1)
		local var_3_0 = BackHomeNpcData:GetNpcInfoById(arg_3_1)

		if var_3_0 then
			return var_3_0.fatigue
		end

		CustomLog.Log("未找到npc数据，npcID为" .. arg_3_1)
	end,
	GetNpcHeadSprite = function(arg_4_0, arg_4_1)
		return getSpriteViaConfig("DormNpcHeadIcon", arg_4_1)
	end
}

function var_0_0.CheckHasNpcWorkOnJob(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0:GetNpcInfoListByConstJobType(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if DormData:GetCharacterInfo(iter_5_1).jobType == arg_5_1 then
			return true
		end
	end

	return false
end

return var_0_0
