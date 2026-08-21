ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattlePopNumManager

ys.Battle.BattlePopNumBundle = class("BattlePopNumBundle")
ys.Battle.BattlePopNumBundle.__name = "BattlePopNumBundle"

local var_0_4 = ys.Battle.BattlePopNumBundle

ys.Battle.BattlePopNumBundle.PRO = 0
ys.Battle.BattlePopNumBundle.SLIM = 1

function ys.Battle.BattlePopNumBundle.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pool = arg_1_1
	arg_1_0._container = cloneTplTo(arg_1_2.containerTpl, arg_1_2.containerTpl.parent)
	arg_1_0._bundleType = arg_1_2.type
	arg_1_0._score = arg_1_2.score

	arg_1_0:init()

	return
end

function ys.Battle.BattlePopNumBundle.InitPopScore(arg_2_0, arg_2_1)
	arg_2_0._allPool[var_0_3.POP_SCORE] = arg_2_0:generateTempPool(var_0_3.POP_SCORE, arg_2_0._container, arg_2_1, 1)

	return
end

function ys.Battle.BattlePopNumBundle.GetContainer(arg_3_0)
	return arg_3_0._container
end

function ys.Battle.BattlePopNumBundle.init(arg_4_0)
	arg_4_0._allPool = {}

	local var_4_0 = var_0_3.GetInstance():GetPopSkin()

	if arg_4_0._score then
		arg_4_0._allPool[var_0_3.POP_SCORE] = arg_4_0:generateTempPool(var_0_3.POP_SCORE, arg_4_0._container, var_4_0, 1)
	else
		arg_4_0._allPool[var_0_3.POP_COMMON] = arg_4_0:generateTempPool(var_0_3.POP_COMMON, arg_4_0._container, var_4_0, 1)
		arg_4_0._allPool[var_0_3.POP_CT_EXPLO] = arg_4_0:generateTempPool(var_0_3.POP_CT_EXPLO, arg_4_0._container, var_4_0, 0)
		arg_4_0._allPool[var_0_3.POP_MISS] = arg_4_0:generateTempPool(var_0_3.POP_MISS, arg_4_0._container, var_4_0, 0)
		arg_4_0._allPool[var_0_3.POP_NORMAL] = arg_4_0:generateTempPool(var_0_3.POP_NORMAL, arg_4_0._container, var_4_0, 0)
		arg_4_0._allPool[var_0_3.POP_CT_NORMAL] = arg_4_0:generateTempPool(var_0_3.POP_CT_NORMAL, arg_4_0._container, var_4_0, 0)

		if arg_4_0._bundleType == var_0_4.PRO then
			arg_4_0._allPool[var_0_3.POP_UNBREAK] = arg_4_0:generateTempPool(var_0_3.POP_UNBREAK, arg_4_0._container, var_4_0, 1)
			arg_4_0._allPool[var_0_3.POP_HEAL] = arg_4_0:generateTempPool(var_0_3.POP_HEAL, arg_4_0._container, var_4_0, 1)
			arg_4_0._allPool[var_0_3.POP_EXPLO] = arg_4_0:generateTempPool(var_0_3.POP_EXPLO, arg_4_0._container, var_4_0, 0)
			arg_4_0._allPool[var_0_3.POP_PIERCE] = arg_4_0:generateTempPool(var_0_3.POP_PIERCE, arg_4_0._container, var_4_0, 0)
			arg_4_0._allPool[var_0_3.POP_CT_PIERCE] = arg_4_0:generateTempPool(var_0_3.POP_CT_PIERCE, arg_4_0._container, var_4_0, 0)
		end
	end

	return
end

function ys.Battle.BattlePopNumBundle.Clear(arg_5_0)
	arg_5_0.pool:Recycle(arg_5_0)

	return
end

function ys.Battle.BattlePopNumBundle.GetPop(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0, var_6_1 = var_0_3.getType(arg_6_1, arg_6_2, arg_6_3, arg_6_5)
	local var_6_2 = arg_6_0._allPool[var_6_0]:GetObject()

	if var_6_0 ~= var_0_3.POP_MISS then
		var_6_2:SetText(arg_6_4)
	end

	var_6_2:SetScale(var_6_1)

	return var_6_2
end

function ys.Battle.BattlePopNumBundle.GetScorePop(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._allPool[var_0_3.POP_SCORE]:GetObject()

	var_7_0:SetText(arg_7_1)

	return var_7_0
end

function ys.Battle.BattlePopNumBundle.generateTempPool(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	return pg.LuaObPool.New(var_0_0.Battle.BattlePopNum, {
		template = arg_8_3.transform:Find(arg_8_1).gameObject,
		parentTF = arg_8_2,
		mgr = arg_8_0
	}, arg_8_4)
end

function ys.Battle.BattlePopNumBundle.Init(arg_9_0)
	return
end

function ys.Battle.BattlePopNumBundle.Recycle(arg_10_0)
	return
end

function ys.Battle.BattlePopNumBundle.IsScorePop(arg_11_0)
	return arg_11_0._score
end

function ys.Battle.BattlePopNumBundle.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._allPool) do
		iter_12_1:Dispose()
	end

	arg_12_0._allPool = nil

	Object.Destroy(arg_12_0._container.gameObject)

	arg_12_0._container = nil

	return
end

return
