ys = ys or {}

local var_0_0 = ys
local var_0_1 = singletonClass("BattlePopNumManager")

ys.Battle.BattlePopNumManager = var_0_1
var_0_1.__name = "BattlePopNumManager"
var_0_1.CONTAINER_CHARACTER_HP = "HPTextCharacterContainer"
var_0_1.POP_SCORE = "score"
var_0_1.POP_MISS = "miss"
var_0_1.POP_HEAL = "heal"
var_0_1.POP_COMMON = "common"
var_0_1.POP_UNBREAK = "unbreak"
var_0_1.POP_NORMAL = "normal"
var_0_1.POP_EXPLO = "explo"
var_0_1.POP_PIERCE = "pierce"
var_0_1.POP_CT_NORMAL = "critical_normal"
var_0_1.POP_CT_EXPLO = "critical_explo"
var_0_1.POP_CT_PIERCE = "critical_pierce"
var_0_1.FontIndex = {
	var_0_1.POP_NORMAL,
	var_0_1.POP_PIERCE,
	var_0_1.POP_EXPLO,
	var_0_1.POP_UNBREAK
}
var_0_1.CTFontIndex = {
	var_0_1.POP_CT_NORMAL,
	var_0_1.POP_CT_PIERCE,
	var_0_1.POP_CT_EXPLO,
	var_0_1.POP_UNBREAK
}
var_0_1.AIR_UNIT_TYPE = {
	ys.Battle.BattleConst.UnitType.AIRCRAFT_UNIT,
	ys.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT,
	ys.Battle.BattleConst.UnitType.FUNNEL_UNIT,
	ys.Battle.BattleConst.UnitType.UAV_UNIT
}

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	arg_2_0._allBundlePool = {}
	arg_2_0._activeList = {}
	arg_2_0._popSkin = arg_2_1

	return
end

function var_0_1:GetPopSkin()
	return self._popSkin
end

function var_0_1:InitialBundlePool(arg_4_1)
	self._allBundlePool[var_0_0.Battle.BattlePopNumBundle.PRO] = pg.LuaObPool.New(var_0_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0_0.Battle.BattlePopNumBundle.PRO
	}, 6)
	self._allBundlePool[var_0_0.Battle.BattlePopNumBundle.SLIM] = pg.LuaObPool.New(var_0_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0_0.Battle.BattlePopNumBundle.SLIM
	}, 4)

	return
end

function var_0_1:InitialScorePool(arg_5_1)
	self._allBundlePool[var_0_0.Battle.BattlePopNumBundle.PRO] = pg.LuaObPool.New(var_0_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0_0.Battle.BattlePopNumBundle.PRO
	}, 1)
	self._allBundlePool[var_0_0.Battle.BattlePopNumBundle.SLIM] = pg.LuaObPool.New(var_0_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0_0.Battle.BattlePopNumBundle.SLIM
	}, 2)

	return
end

function var_0_1:Clear()
	for iter_6_0, iter_6_1 in pairs(self._allBundlePool) do
		iter_6_1:Dispose()
	end

	self._popSkin = nil
	self._activeList = {}

	return
end

function var_0_1:GetBundle(arg_7_1)
	return (self._allBundlePool[var_0_1.getBundleType(arg_7_1)]:GetObject())
end

function var_0_1.getType(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 1
	local var_8_1

	if arg_8_0 and not arg_8_2 then
		var_8_1 = var_0_1.POP_HEAL
	elseif arg_8_2 then
		var_8_1 = var_0_1.POP_MISS
	elseif arg_8_3 then
		var_8_1 = arg_8_1 and var_0_1.CTFontIndex[arg_8_3[1]] or var_0_1.FontIndex[arg_8_3[1]]
		var_8_0 = arg_8_3[2]
	else
		var_8_1 = arg_8_1 and var_0_1.POP_CT_EXPLO or var_0_1.POP_COMMON
	end

	return var_8_1, var_8_0
end

function var_0_1.getBundleType(arg_9_0)
	return table.contains(var_0_1.AIR_UNIT_TYPE, arg_9_0) and var_0_0.Battle.BattlePopNumBundle.SLIM or var_0_0.Battle.BattlePopNumBundle.PRO
end

function var_0_1.generateTempPool(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	return pg.LuaObPool.New(var_0_0.Battle.BattlePopNum, {
		template = arg_10_3.transform:Find(arg_10_1).gameObject,
		parentTF = arg_10_2,
		mgr = arg_10_0
	}, arg_10_4)
end

function var_0_1.resetPopParent(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:UpdateInfo("parentTF", arg_11_2)

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.list) do
		iter_11_1:SetParent(arg_11_2)
	end

	return
end

return
