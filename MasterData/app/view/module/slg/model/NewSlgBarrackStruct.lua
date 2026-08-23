local var_0_0 = g.core.config.new_slg_barrack_info
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local NewSlgBarrackStruct = class("NewSlgBarrackStruct")

function NewSlgBarrackStruct:ctor(arg_1_1)
	self._cfg = nil
	self._nextCfg = nil
	self._armyCfg = nil
	self._pos = 0
end

function NewSlgBarrackStruct:setCfg(arg_2_1)
	self._cfg = arg_2_1
	self._nextCfg = not self:isMaxLevel() and var_0_0.get(g.core.model.User.newSlgData:getBarrackGroupId(), arg_2_1.type, arg_2_1.next_level) or self._cfg
	self._armyCfg = g.core.model.User.newSlgDevelopData:getArmyInfoByType(arg_2_1.type)
end

function NewSlgBarrackStruct:getCfg()
	return self._cfg
end

function NewSlgBarrackStruct:getNextCfg()
	return self._nextCfg
end

function NewSlgBarrackStruct:getArmyCfg()
	return self._armyCfg
end

function NewSlgBarrackStruct:getType()
	return self._cfg.type
end

function NewSlgBarrackStruct:getLevel()
	return self._cfg.level
end

function NewSlgBarrackStruct:getNextLevel()
	return self._nextCfg.level
end

function NewSlgBarrackStruct:getTroopsMax()
	return self._cfg.troops_max
end

function NewSlgBarrackStruct:getPicResId()
	return self._cfg.res_id
end

function NewSlgBarrackStruct:getMainCityLimit()
	return self._cfg.main_city_limit
end

function NewSlgBarrackStruct:getAuthority()
	return self._cfg.authority_pct
end

function NewSlgBarrackStruct:getName()
	return g.core.lang:get("NEW_SLG_BARRACK_NAME_" .. self:getType())
end

function NewSlgBarrackStruct:getArmyName()
	return self._armyCfg.name
end

function NewSlgBarrackStruct:getUpgradeMaterials()
	local var_15_0 = {}

	for iter_15_0, iter_15_1, iter_15_2 in self._cfg.gmatch({
		"upgrade_type_%d+",
		"upgrade_value_%d+",
		"upgrade_size_%d+"
	}) do
		if iter_15_2[1] and iter_15_2[1] ~= 0 then
			table.insert(var_15_0, {
				colorIndex = 1,
				showGreen = true,
				title = "",
				type = iter_15_2[1],
				value = iter_15_2[2],
				size = iter_15_2[3]
			})
		end
	end

	return var_15_0
end

function NewSlgBarrackStruct:getUpgradeShowData()
	local var_16_0 = self:getCfg()
	local var_16_1 = self:getNextCfg()

	return {
		{
			name = g.core.lang:get(429525, {
				name = self:getArmyName()
			}),
			curNum = var_16_0.troops_max,
			nextNum = var_16_1.troops_max
		},
		{
			isPercent = true,
			name = g.core.lang:get(429582, {
				name = self:getArmyName()
			}),
			curNum = var_16_0.authority_pct,
			nextNum = var_16_1.authority_pct
		}
	}
end

function NewSlgBarrackStruct:isMaxLevel()
	return self._cfg and self._cfg.next_level == 0
end

function NewSlgBarrackStruct:checkUpgradeNeedLv()
	local var_18_0 = self:getMainCityLimit()

	return var_18_0 <= g.core.model.User.newSlgDevelopData:getMainCityLv(), var_18_0
end

function NewSlgBarrackStruct:checkUpgradeNeedMaterials()
	for iter_19_0, iter_19_1 in ipairs(self:getUpgradeMaterials() or {}) do
		if g.core.model.User.bagData:getOwnNum(iter_19_1.type, iter_19_1.value) < iter_19_1.size then
			return false, iter_19_1
		end
	end

	return true
end

function NewSlgBarrackStruct:checkCanUpgrade()
	if self:isMaxLevel() then
		return false
	end

	return self:checkUpgradeNeedLv() and self:checkUpgradeNeedMaterials()
end

function NewSlgBarrackStruct:getBarrackUpgradeState()
	if self:isMaxLevel() then
		return var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.MAX_LEVEL, 0
	end

	local var_21_0, var_21_1 = self:checkUpgradeNeedLv()

	if not var_21_0 then
		return var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.COMMAND, var_21_1
	end

	if not self:checkUpgradeNeedMaterials() then
		return var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.COST, 0
	end

	return var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.CAN_UPGRADE, 0
end

return NewSlgBarrackStruct
