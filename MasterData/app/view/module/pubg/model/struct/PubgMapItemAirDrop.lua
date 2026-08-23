local var_0_0 = g.core.config.pubg_airdrop_info
local var_0_1 = g.core.config.pubg_effect_info
local PubgMapItemAirDrop = class("PubgMapItemAirDrop", (require("app.view.module.pubg.model.struct.PubgMapItemBase")))

function PubgMapItemAirDrop:ctor(arg_1_1)
	PubgMapItemAirDrop.super.ctor(self, arg_1_1)

	self._type = g.core.const.ConstMgr.PubgConst.map.itemType.airDrop
	self._cfg = nil
	self._buffEffectCfg = nil
	self._userDict = {}
	self._startTime = 0
end

function PubgMapItemAirDrop:setData(arg_2_1)
	self:setPosXY(arg_2_1.x, arg_2_1.y)

	self._userDict = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.users or {}) do
		self._userDict[iter_2_1.key] = iter_2_1.value
	end

	self._cfg = var_0_0.get(arg_2_1.base_id)
	self._buffEffectCfg = var_0_1.get(self._cfg.effect)
	self._startTime = g.core.common.ServerTime:getTime()
end

function PubgMapItemAirDrop:getUserDict()
	return self._userDict
end

function PubgMapItemAirDrop:getStartTime()
	return self._startTime
end

function PubgMapItemAirDrop:getAirCfg()
	return self._cfg
end

function PubgMapItemAirDrop:getAirBuffCfg()
	return self._buffEffectCfg
end

function PubgMapItemAirDrop:addGettingUser(arg_7_1, arg_7_2)
	self._userDict[arg_7_1] = arg_7_2
end

function PubgMapItemAirDrop:removeGettingUser(arg_8_1)
	self._userDict[arg_8_1] = nil
end

return PubgMapItemAirDrop
