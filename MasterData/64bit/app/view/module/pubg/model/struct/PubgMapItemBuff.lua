local var_0_0 = g.core.config.pubg_buff_info
local PubgMapItemBuff = class("PubgMapItemBuff", (require("app.view.module.pubg.model.struct.PubgMapItemBase")))

function PubgMapItemBuff:ctor(arg_1_1)
	PubgMapItemBuff.super.ctor(self, arg_1_1)

	self._type = g.core.const.ConstMgr.PubgConst.map.itemType.buff
	self._buffCfg = 0
	self._tp = 0
end

function PubgMapItemBuff:setData(arg_2_1)
	self._tp = arg_2_1.tp or self._tp

	self:setPosXY(arg_2_1.x, arg_2_1.y)

	for iter_2_0, iter_2_1 in var_0_0:ipairs() do
		if iter_2_1.effect_type == self._tp and iter_2_1.level == 1 then
			self._buffCfg = iter_2_1

			break
		end
	end
end

function PubgMapItemBuff:getBuffId()
	return self._buffCfg.id
end

function PubgMapItemBuff:getBuffCfg()
	return self._buffCfg
end

function PubgMapItemBuff:getName()
	return self._buffCfg.name
end

return PubgMapItemBuff
