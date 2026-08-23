local var_0_0 = g.core.const.ConstMgr.PubgConst.map
local var_0_1 = g.core.config.pubg_effect_info
local var_0_2 = g.core.common.Path
local PubgMapInfoBuffAirDropIcon = class("PubgMapInfoBuffAirDropIcon", require("app.fairyGUI.pubg.UI_PubgMapInfoBuffAirDropIcon"))

function PubgMapInfoBuffAirDropIcon:ctor()
	self._buffTp = 0
	self._buffData = nil
end

function PubgMapInfoBuffAirDropIcon:getBuffAirData()
	return self._buffData
end

function PubgMapInfoBuffAirDropIcon:updateAirBuffData(arg_3_1)
	self._buffData = arg_3_1

	local var_3_0 = var_0_1.get(arg_3_1.base_id)

	if var_3_0.limit_type == var_0_0.BUFF_LIMIT_TYPE.TIME then
		local var_3_1 = arg_3_1.limit_value - g.core.common.ServerTime:getTime()

		if var_3_1 <= 0 then
			var_3_1 = 0
		end

		self.m_leftTimesTxt:setText(var_3_1)
	elseif var_3_0.limit_type == var_0_0.BUFF_LIMIT_TYPE.USE_NUM then
		self.m_leftTimesTxt:setText(arg_3_1.limit_value)
	end

	self.m_buffLoader:setURL(var_0_2:getPubgBuff(var_3_0.icon))
end

return PubgMapInfoBuffAirDropIcon
