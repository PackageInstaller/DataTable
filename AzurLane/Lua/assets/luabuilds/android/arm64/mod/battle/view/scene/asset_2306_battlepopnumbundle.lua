ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattlePopNumManager
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattlePopNumBundle = var_0_10005("BattlePopNumBundle")
var_0.Battle.BattlePopNumBundle.__name = "BattlePopNumBundle"

local var_0_5 = var_0.Battle.BattlePopNumBundle

var_0_5.PRO = 0
var_0_5.SLIM = 1

function var_0_5.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pool = arg_1_1
	cloneTplTo = var_1_10003
	arg_1_0._container = var_1_10003(arg_1_2.containerTpl, arg_1_2.containerTpl.parent)
	arg_1_0._bundleType = arg_1_2.type
	arg_1_0._score = arg_1_2.score

	arg_1_0:init()

	return
end

function var_0_5.InitPopScore(arg_2_0, arg_2_1)
	arg_2_0._allPool[var_0_3.POP_SCORE] = arg_2_0:generateTempPool(var_0_3.POP_SCORE, arg_2_0._container, arg_2_1, 1)

	return
end

function var_0_5.GetContainer(arg_3_0)
	return arg_3_0._container
end

function var_0_5.init(arg_4_0)
	arg_4_0._allPool = {}

	local var_4_0 = var_0_3.GetInstance()
	local var_4_1 = var_1.GetPopSkin(var_4_0)

	if arg_4_0._score then
		arg_4_0._allPool[var_0_3.POP_SCORE] = arg_4_0:generateTempPool(var_0_3.POP_SCORE, arg_4_0._container, var_4_1, 1)
	else
		arg_4_0._allPool[var_0_3.POP_COMMON] = arg_4_0:generateTempPool(var_0_3.POP_COMMON, arg_4_0._container, var_4_1, 1)
		arg_4_0._allPool[var_0_3.POP_CT_EXPLO] = arg_4_0:generateTempPool(var_0_3.POP_CT_EXPLO, arg_4_0._container, var_4_1, 0)
		arg_4_0._allPool[var_0_3.POP_MISS] = arg_4_0:generateTempPool(var_0_3.POP_MISS, arg_4_0._container, var_4_1, 0)
		arg_4_0._allPool[var_0_3.POP_NORMAL] = arg_4_0:generateTempPool(var_0_3.POP_NORMAL, arg_4_0._container, var_4_1, 0)
		arg_4_0._allPool[var_0_3.POP_CT_NORMAL] = arg_4_0:generateTempPool(var_0_3.POP_CT_NORMAL, arg_4_0._container, var_4_1, 0)

		if arg_4_0._bundleType == var_0_5.PRO then
			arg_4_0._allPool[var_0_3.POP_UNBREAK] = arg_4_0:generateTempPool(var_0_3.POP_UNBREAK, arg_4_0._container, var_4_1, 1)
			arg_4_0._allPool[var_0_3.POP_HEAL] = arg_4_0:generateTempPool(var_0_3.POP_HEAL, arg_4_0._container, var_4_1, 1)
			arg_4_0._allPool[var_0_3.POP_EXPLO] = arg_4_0:generateTempPool(var_0_3.POP_EXPLO, arg_4_0._container, var_4_1, 0)
			arg_4_0._allPool[var_0_3.POP_PIERCE] = arg_4_0:generateTempPool(var_0_3.POP_PIERCE, arg_4_0._container, var_4_1, 0)
			arg_4_0._allPool[var_0_3.POP_CT_PIERCE] = arg_4_0:generateTempPool(var_0_3.POP_CT_PIERCE, arg_4_0._container, var_4_1, 0)
		end
	end

	return
end

function var_0_5.Clear(arg_5_0)
	local var_5_0 = arg_5_0.pool

	var_1.Recycle(var_5_0, arg_5_0)

	return
end

function var_0_5.GetPop(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0, var_6_1 = var_0_3.getType(arg_6_1, arg_6_2, arg_6_3, arg_6_5)
	local var_6_2 = arg_6_0._allPool[var_6_0]
	local var_6_3 = var_8.GetObject(var_6_2)

	if var_6_0 ~= var_0_3.POP_MISS then
		var_6_3:SetText(arg_6_4)
	end

	var_6_3:SetScale(var_6_1)

	return var_6_3
end

function var_0_5.GetScorePop(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._allPool[var_0_3.POP_SCORE]
	local var_7_1 = var_2.GetObject(var_7_0)

	var_3.SetText(var_7_1, arg_7_1)

	return var_3
end

function var_0_5.generateTempPool(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	pg = var_1_10005

	local var_8_0 = var_1_10005.LuaObPool.New
	local var_8_1 = var_0.Battle.BattlePopNum
	local var_8_2 = {}
	local var_8_3 = arg_8_3.transform

	var_8_2.template = var_9.Find(var_8_3, arg_8_1).gameObject
	var_8_2.parentTF = arg_8_2
	var_8_2.mgr = arg_8_0

	return var_8_0(var_8_1, var_8_2, arg_8_4)
end

function var_0_5.Init(arg_9_0)
	return
end

function var_0_5.Recycle(arg_10_0)
	return
end

function var_0_5.IsScorePop(arg_11_0)
	return arg_11_0._score
end

function var_0_5.Dispose(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0._allPool) do
		iter_12_1:Dispose()
	end

	arg_12_0._allPool = nil
	Object = var_1

	var_1.Destroy(arg_12_0._container.gameObject)

	arg_12_0._container = nil

	return
end

return
