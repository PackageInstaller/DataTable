local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityMonster = class("Pubg2EntityMonster", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityMonster:ctor(arg_1_1)
	Pubg2EntityMonster.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.monster
end

return Pubg2EntityMonster
