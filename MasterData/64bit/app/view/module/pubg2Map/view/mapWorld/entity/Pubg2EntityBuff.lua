local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityBuff = class("Pubg2EntityBuff", require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBase"))

function Pubg2EntityBuff:ctor(arg_1_1)
	Pubg2EntityBuff.super.ctor(self, arg_1_1)

	self._type = var_0_0.entity.buff
end

return Pubg2EntityBuff
