HeroTrustRelationNet = class("HeroTrustRelationNet")

function HeroTrustRelationNet.Ctor(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1
	arg_1_0.tier_Dir = {}
end

function HeroTrustRelationNet:InitData(arg_2_1)
	self.tier_Dir = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.tier_list) do
		local var_2_0 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.upgrade_complete_list) do
			table.insert(var_2_0, iter_2_3)
		end

		self.tier_Dir[iter_2_1.tier] = var_2_0
	end
end

function HeroTrustRelationNet:GetRelationNetAttr()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[self.heroId] or {}) do
		for iter_3_2, iter_3_3 in ipairs(self.tier_Dir[HeroRelationNetCfg[iter_3_1].index] or {}) do
			for iter_3_4, iter_3_5 in pairs(HeroRelationUpgradeCfg[HeroRelationNetCfg[iter_3_1].relation_upgrade_group[iter_3_3]].attr) do
				var_3_0[iter_3_5[1]] = HeroTools.AttributeAdd(iter_3_5[1], var_3_0[iter_3_5[1]], iter_3_5[2])
			end
		end
	end

	local var_3_2 = {}

	for iter_3_6, iter_3_7 in pairs(var_3_0) do
		table.insert(var_3_2, {
			iter_3_6,
			iter_3_7
		})
	end

	return var_3_0, var_3_2
end

function HeroTrustRelationNet:GetIsUnlock(arg_4_1, arg_4_2)
	if not self.tier_Dir[arg_4_1] then
		return false
	end

	return table.indexof(self.tier_Dir[arg_4_1], arg_4_2)
end

function HeroTrustRelationNet:UnlockRelationNet(arg_5_1, arg_5_2)
	if not self.tier_Dir[arg_5_1] then
		self.tier_Dir[arg_5_1] = {
			arg_5_2
		}

		return
	end

	if not table.indexof(self.tier_Dir[arg_5_1], arg_5_2) then
		table.insert(self.tier_Dir[arg_5_1], arg_5_2)
	end
end
