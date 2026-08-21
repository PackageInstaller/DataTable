HeroTrustRelationNet = class("HeroTrustRelationNet")

function HeroTrustRelationNet.Ctor(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1
	arg_1_0.tier_Dir = {}
end

function HeroTrustRelationNet.InitData(arg_2_0, arg_2_1)
	arg_2_0.tier_Dir = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.tier_list) do
		local var_2_0 = iter_2_1.tier
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.upgrade_complete_list) do
			table.insert(var_2_1, iter_2_3)
		end

		arg_2_0.tier_Dir[var_2_0] = var_2_1
	end
end

function HeroTrustRelationNet.GetRelationNetAttr(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = HeroRelationNetCfg.get_id_list_by_hero_id[arg_3_0.heroId] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = HeroRelationNetCfg[iter_3_1]
		local var_3_3 = var_3_2.index
		local var_3_4 = arg_3_0.tier_Dir[var_3_3] or {}

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			local var_3_5 = var_3_2.relation_upgrade_group[iter_3_3]
			local var_3_6 = HeroRelationUpgradeCfg[var_3_5]

			for iter_3_4, iter_3_5 in pairs(var_3_6.attr) do
				local var_3_7 = iter_3_5[1]
				local var_3_8 = iter_3_5[2]

				var_3_0[var_3_7] = HeroTools.AttributeAdd(var_3_7, var_3_0[var_3_7], var_3_8)
			end
		end
	end

	local var_3_9 = {}

	for iter_3_6, iter_3_7 in pairs(var_3_0) do
		table.insert(var_3_9, {
			iter_3_6,
			iter_3_7
		})
	end

	return var_3_0, var_3_9
end

function HeroTrustRelationNet.GetIsUnlock(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.tier_Dir[arg_4_1] then
		return false
	end

	return table.indexof(arg_4_0.tier_Dir[arg_4_1], arg_4_2)
end

function HeroTrustRelationNet.UnlockRelationNet(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.tier_Dir[arg_5_1] then
		arg_5_0.tier_Dir[arg_5_1] = {
			arg_5_2
		}

		return
	end

	if not table.indexof(arg_5_0.tier_Dir[arg_5_1], arg_5_2) then
		table.insert(arg_5_0.tier_Dir[arg_5_1], arg_5_2)
	end
end
