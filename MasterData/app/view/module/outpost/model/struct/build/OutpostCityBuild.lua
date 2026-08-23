local OutpostBuildBaseStruct = require("app.view.module.outpost.model.struct.build.OutpostBuildBaseStruct")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostCityBuild = class("OutpostCityBuild", OutpostBuildBaseStruct)

function OutpostCityBuild:ctor(arg_1_1, arg_1_2)
	self._knightPosLv = {}

	OutpostCityBuild.super.ctor(self, arg_1_1, arg_1_2)

	self._maxRoleNum = 0
	self._buildLimits = {}
	self._limitLevel = 99999
end

function OutpostCityBuild:_initBuild()
	self._tab = g.core.config.outpost_main_city_info

	for iter_2_0 = 1, self._tab.getLength() do
		local var_2_0 = self._tab.indexOf(iter_2_0)

		self._knightPosLv[iter_2_0] = {
			level = var_2_0.level,
			num = var_2_0.role_value
		}
	end

	OutpostCityBuild.super._initBuild(self)
end

function OutpostCityBuild:canChangePos()
	return true
end

function OutpostCityBuild:getBuildInfo()
	return
end

function OutpostCityBuild:_checkNeedDoEffect(arg_5_1)
	if OutpostBuildBaseStruct.CHECK_FROM.MINE_LEVEL_CHANGED == arg_5_1.from then
		return true
	end

	return false
end

function OutpostCityBuild:onEffect(arg_6_1)
	OutpostCityBuild.super.onEffect(self, arg_6_1)

	self._buildLimits = self:getBuildLimitsByCfg(self._cfg)
	self._maxRoleNum = self._cfg.role_value
end

function OutpostCityBuild:getBuildLimitsByCfg(arg_7_1)
	local var_7_0

	if not arg_7_1 then
		do return end

		var_7_0 = {}
	end

	self:_inputInfoToInfoDic(arg_7_1, var_7_0, {
		{
			key = "building_type_"
		}
	}, g.core.config.outpost_main_city_info)

	return var_7_0
end

function OutpostCityBuild:getMaxRoleNum()
	return self._maxRoleNum
end

function OutpostCityBuild:getSubBuildLimitLevel(arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_2 then
		arg_9_2 = self._buildLimits
		var_9_0 = {
			[g.core.const.ConstMgr.outpostConst.BuildType.Exchange] = 1,
			[g.core.const.ConstMgr.outpostConst.BuildType.Hospital] = 2,
			[g.core.const.ConstMgr.outpostConst.BuildType.Restaurant] = 2,
			[g.core.const.ConstMgr.outpostConst.BuildType.Hotel] = 2,
			[g.core.const.ConstMgr.outpostConst.BuildType.Tavern] = 2,
			[g.core.const.ConstMgr.outpostConst.BuildType.Boss] = 3,
			[g.core.const.ConstMgr.outpostConst.BuildType.WeaponShop] = 4
		}
	end

	var_9_0[g.core.const.ConstMgr.outpostConst.BuildType.ArmorShop] = 5

	return arg_9_2[var_9_0[arg_9_1]]
end

function OutpostCityBuild:getKnightLevelLimit()
	return self._cfg.knight_level
end

function OutpostCityBuild:getKnightPosLevel(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self._knightPosLv) do
		if arg_11_1 <= iter_11_1.num then
			return iter_11_1.level
		end
	end

	return 0
end

function OutpostCityBuild:getNextCfg()
	if not self:isMaxBuildLevel() then
		return g.core.config.outpost_main_city_info.get(self._levelToIdDic[self._level + 1])
	end

	return nil
end

function OutpostCityBuild:getCfg()
	return g.core.config.outpost_main_city_info.get(self._levelToIdDic[self._level])
end

function OutpostCityBuild:getLimitLevelInfo()
	for iter_14_0, iter_14_1 in pairs(var_0_1.BuildType) do
		-- block empty
	end
end

return OutpostCityBuild
