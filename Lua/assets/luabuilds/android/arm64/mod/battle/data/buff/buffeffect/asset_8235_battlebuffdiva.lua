ys = ys or {}

local var_0_0 = ys
local BattleBuffDiva = class("BattleBuffDiva", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffDiva = BattleBuffDiva
BattleBuffDiva.__name = "BattleBuffDiva"

function BattleBuffDiva:Ctor(arg_1_1)
	BattleBuffDiva.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffDiva:onInitGame(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetBGMList()

	pg.BgmMgr.GetInstance():Push(BattleScene.__cname, var_2_0[math.random(#var_2_0)])

	return
end

function BattleBuffDiva:onTrigger()
	local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetBGMList(true)

	pg.BgmMgr.GetInstance():Push(BattleScene.__cname, var_3_0[math.random(#var_3_0)])

	return
end

return
