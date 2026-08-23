local var_0_0 = g.core.config.pubg_monster_info
local PubgMapItemMonster = class("PubgMapItemMonster", (require("app.view.module.pubg.model.struct.PubgMapItemBase")))

function PubgMapItemMonster:ctor(arg_1_1)
	PubgMapItemMonster.super.ctor(self, arg_1_1)

	self._type = g.core.const.ConstMgr.PubgConst.map.itemType.monster
	self._monsterId = arg_1_1.monsterId or 0
end

function PubgMapItemMonster:setData(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._monsterId = arg_2_1.base_id or self._monsterId

	self:setPosXY(arg_2_1.x, arg_2_1.y)
end

function PubgMapItemMonster:getMonsterId()
	return self._monsterId
end

function PubgMapItemMonster:getMonsterCfg()
	return var_0_0.get(self._monsterId)
end

function PubgMapItemMonster:getName()
	return self:getMonsterCfg().name
end

function PubgMapItemMonster:isInvincible()
	return false
end

return PubgMapItemMonster
