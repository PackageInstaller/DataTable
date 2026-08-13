ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

singletonClass = var_0_10002

local var_0_2 = var_0_10002("BattlePopNumManager")

var_0.Battle.BattlePopNumManager = var_0_2
var_0_2.__name = "BattlePopNumManager"
var_0_2.CONTAINER_CHARACTER_HP = "HPTextCharacterContainer"
var_0_2.POP_SCORE = "score"
var_0_2.POP_MISS = "miss"
var_0_2.POP_HEAL = "heal"
var_0_2.POP_COMMON = "common"
var_0_2.POP_UNBREAK = "unbreak"
var_0_2.POP_NORMAL = "normal"
var_0_2.POP_EXPLO = "explo"
var_0_2.POP_PIERCE = "pierce"
var_0_2.POP_CT_NORMAL = "critical_normal"
var_0_2.POP_CT_EXPLO = "critical_explo"
var_0_2.POP_CT_PIERCE = "critical_pierce"
var_0_2.FontIndex = {
	var_0_2.POP_NORMAL,
	var_0_2.POP_PIERCE,
	var_0_2.POP_EXPLO,
	var_0_2.POP_UNBREAK
}
var_0_2.CTFontIndex = {
	var_0_2.POP_CT_NORMAL,
	var_0_2.POP_CT_PIERCE,
	var_0_2.POP_CT_EXPLO,
	var_0_2.POP_UNBREAK
}
var_0_2.AIR_UNIT_TYPE = {
	var_0_1.UnitType.AIRCRAFT_UNIT,
	var_0_1.UnitType.AIRFIGHTER_UNIT,
	var_0_1.UnitType.FUNNEL_UNIT,
	var_0_1.UnitType.UAV_UNIT
}

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2.Init(arg_2_0, arg_2_1)
	arg_2_0._allBundlePool = {}
	arg_2_0._activeList = {}
	arg_2_0._popSkin = arg_2_1

	return
end

function var_0_2.GetPopSkin(arg_3_0)
	return arg_3_0._popSkin
end

function var_0_2.InitialBundlePool(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._allBundlePool
	local var_4_1 = var_0.Battle.BattlePopNumBundle.PRO

	pg = var_1_10004
	var_4_0[var_4_1] = var_1_10004.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0.Battle.BattlePopNumBundle.PRO
	}, 6)

	local var_4_2 = arg_4_0._allBundlePool
	local var_4_3 = var_0.Battle.BattlePopNumBundle.SLIM

	pg = var_4
	var_4_2[var_4_3] = var_4.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		containerTpl = arg_4_1,
		type = var_0.Battle.BattlePopNumBundle.SLIM
	}, 4)

	return
end

function var_0_2.InitialScorePool(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._allBundlePool
	local var_5_1 = var_0.Battle.BattlePopNumBundle.PRO

	pg = var_1_10004
	var_5_0[var_5_1] = var_1_10004.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0.Battle.BattlePopNumBundle.PRO
	}, 1)

	local var_5_2 = arg_5_0._allBundlePool
	local var_5_3 = var_0.Battle.BattlePopNumBundle.SLIM

	pg = var_4
	var_5_2[var_5_3] = var_4.LuaObPool.New(var_0.Battle.BattlePopNumBundle, {
		score = true,
		containerTpl = arg_5_1,
		type = var_0.Battle.BattlePopNumBundle.SLIM
	}, 2)

	return
end

function var_0_2.Clear(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0._allBundlePool) do
		iter_6_1:Dispose()
	end

	arg_6_0._popSkin = nil
	arg_6_0._activeList = {}

	return
end

function var_0_2.GetBundle(arg_7_0, arg_7_1)
	local var_7_0 = var_0_2.getBundleType(arg_7_1)
	local var_7_1 = arg_7_0._allBundlePool[var_7_0]

	return (var_3.GetObject(var_7_1))
end

function var_0_2.getType(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 1
	local var_8_1

	if arg_8_0 and not arg_8_2 then
		var_8_1 = var_0_2.POP_HEAL
	elseif arg_8_2 then
		var_8_1 = var_0_2.POP_MISS
	elseif arg_8_3 then
		local var_8_2 = arg_8_3[1]
		local var_8_3 = arg_8_3[2]

		if arg_8_1 then
			var_8_1 = var_0_2.CTFontIndex[var_8_2]
		else
			var_8_1 = var_0_2.FontIndex[var_8_2]
		end

		var_8_0 = arg_8_3[2]
	elseif arg_8_1 then
		var_8_1 = var_0_2.POP_CT_EXPLO
	else
		var_8_1 = var_0_2.POP_COMMON
	end

	return var_8_1, var_8_0
end

function var_0_2.getBundleType(arg_9_0)
	local var_9_0

	table = var_1_10002

	if var_1_10002.contains(var_0_2.AIR_UNIT_TYPE, arg_9_0) then
		var_9_0 = var_0.Battle.BattlePopNumBundle.SLIM
	else
		var_9_0 = var_0.Battle.BattlePopNumBundle.PRO
	end

	return var_9_0
end

function var_0_2.generateTempPool(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	pg = var_1_10005

	local var_10_0 = var_1_10005.LuaObPool.New
	local var_10_1 = var_0.Battle.BattlePopNum
	local var_10_2 = {}
	local var_10_3 = arg_10_3.transform

	var_10_2.template = var_9.Find(var_10_3, arg_10_1).gameObject
	var_10_2.parentTF = arg_10_2
	var_10_2.mgr = arg_10_0

	return var_10_0(var_10_1, var_10_2, arg_10_4)
end

function var_0_2.resetPopParent(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:UpdateInfo("parentTF", arg_11_2)

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_1.list) do
		iter_11_1:SetParent(arg_11_2)
	end

	return
end

return
