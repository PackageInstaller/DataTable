local IslandDropDescribeInfo = class("IslandDropDescribeInfo", import("model.vo.BaseVO"))

function IslandDropDescribeInfo:Ctor(arg_1_1)
	self.drop = arg_1_1

	return
end

function IslandDropDescribeInfo:GetName()
	return self.drop:getName() or ""
end

function IslandDropDescribeInfo:GetDes()
	return self.drop.desc or ""
end

function IslandDropDescribeInfo:GetOwnCount()
	return self.drop:getOwnedCount()
end

function IslandDropDescribeInfo:GetDrop()
	return self.drop
end

function IslandDropDescribeInfo:GetAcquiringWay()
	local var_6_0 = {}
	local var_6_1 = self:GetDropConfig().jump_page or {}

	var_6_1 = var_6_1 == "" and {} or var_6_1

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function IslandDropDescribeInfo:IsTecUnlocked()
	local var_7_0 = self:GetDropConfig()

	if var_7_0.tech_id == 0 or var_7_0.tech_id == nil then
		return true
	end

	return getProxy(IslandProxy):GetIsland():GetTechnologyAgency():IsUnlockTech(var_7_0.tech_id)
end

function IslandDropDescribeInfo:GetTecDes()
	local var_8_0 = self:GetDropConfig().tech_id

	if var_8_0 == 0 then
		return ""
	end

	return i18n("island_information_tech", IslandTechBelong.Names[pg.island_technology_template[var_8_0].tech_belong], pg.island_technology_template[var_8_0].tech_name)
end

function IslandDropDescribeInfo:GetDropConfig()
	return self.drop:getConfigTable()
end

return IslandDropDescribeInfo
