ys = ys or {}

local var_0_0 = singletonClass("BattlePopNumManager")

ys.Battle.BattlePopNumManager = var_0_0
var_0_0.__name = "BattlePopNumManager"
var_0_0.CONTAINER_CHARACTER_HP = "HPTextCharacterContainer"
var_0_0.POP_SCORE = "score"
var_0_0.POP_MISS = "miss"
var_0_0.POP_HEAL = "heal"
var_0_0.POP_COMMON = "common"
var_0_0.POP_UNBREAK = "unbreak"
var_0_0.POP_NORMAL = "normal"
var_0_0.POP_EXPLO = "explo"
var_0_0.POP_PIERCE = "pierce"
var_0_0.POP_CT_NORMAL = "critical_normal"
var_0_0.POP_CT_EXPLO = "critical_explo"
var_0_0.POP_CT_PIERCE = "critical_pierce"
var_0_0.FontIndex = {
	var_0_0.POP_NORMAL,
	var_0_0.POP_PIERCE,
	var_0_0.POP_EXPLO,
	var_0_0.POP_UNBREAK
}
var_0_0.CTFontIndex = {
	var_0_0.POP_CT_NORMAL,
	var_0_0.POP_CT_PIERCE,
	var_0_0.POP_CT_EXPLO,
	var_0_0.POP_UNBREAK
}
var_0_0.AIR_UNIT_TYPE = {
	ys.Battle.BattleConst.UnitType.AIRCRAFT_UNIT,
	ys.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT,
	ys.Battle.BattleConst.UnitType.FUNNEL_UNIT,
	ys.Battle.BattleConst.UnitType.UAV_UNIT
}

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0._allBundlePool = {}
	arg_2_0._activeList = {}
	arg_2_0._popSkin = arg_2_1

	return
end

function var_0_0.GetPopSkin(arg_3_0)
	return arg_3_0._popSkin
end

function var_0_0.InitialBundlePool(arg_4_0, arg_4_1)
	arg_4_0._allBundlePool[var_0.Battle.BattlePopNumBundle.PRO] = pg.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0.Battle.BattlePopNumBundle.PRO
	}, 6)
	arg_4_0._allBundlePool[var_0.Battle.BattlePopNumBundle.SLIM] = pg.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0.Battle.BattlePopNumBundle.SLIM
	}, 4)

	return
end

function var_0_0.InitialScorePool(arg_5_0, arg_5_1)
	arg_5_0._allBundlePool[var_0.Battle.BattlePopNumBundle.PRO] = pg.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0.Battle.BattlePopNumBundle.PRO
	}, 1)
	arg_5_0._allBundlePool[var_0.Battle.BattlePopNumBundle.SLIM] = pg.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0.Battle.BattlePopNumBundle.SLIM
	}, 2)

	return
end

function var_0_0.Clear(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._allBundlePool) do
		iter_6_1:Dispose()
	end

	arg_6_0._popSkin = nil
	arg_6_0._activeList = {}

	return
end

function var_0_0.GetBundle(arg_7_0, arg_7_1)
	return (arg_7_0._allBundlePool[var_0_0.getBundleType(arg_7_1)]:GetObject())
end

function var_0_0.getType(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 1
	local var_8_1

	if arg_8_0 and not arg_8_2 then
		var_8_1 = var_0_0.POP_HEAL
	elseif arg_8_2 then
		var_8_1 = var_0_0.POP_MISS
	elseif arg_8_3 then
		var_8_1 = arg_8_1 and var_0_0.CTFontIndex[arg_8_3[1]] or var_0_0.FontIndex[arg_8_3[1]]
		var_8_0 = arg_8_3[2]
	else
		var_8_1 = arg_8_1 and var_0_0.POP_CT_EXPLO or var_0_0.POP_COMMON
	end

	return var_8_1, var_8_0
end

function var_0_0.getBundleType(arg_9_0)
	return table.contains(var_0_0.AIR_UNIT_TYPE, arg_9_0) and var_0.Battle.BattlePopNumBundle.SLIM or var_0.Battle.BattlePopNumBundle.PRO
end

function var_0_0.generateTempPool(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	return pg.LuaObPool.New(var_0.Battle.BattlePopNum, {
		template = arg_10_3.transform:Find(arg_10_1).gameObject,
		parentTF = arg_10_2,
		mgr = arg_10_0
	}, arg_10_4)
end

function var_0_0.resetPopParent(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:UpdateInfo("parentTF", arg_11_2)

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.list) do
		iter_11_1:SetParent(arg_11_2)
	end

	return
end

return
