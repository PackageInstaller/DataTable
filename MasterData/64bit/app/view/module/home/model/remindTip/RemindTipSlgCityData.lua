local RemindTipSlgCityData = class("RemindTipSlgCityData", (require("app.view.module.home.model.remindTip.RemindTipBaseData")))

function RemindTipSlgCityData:ctor(arg_1_1)
	RemindTipSlgCityData.super.ctor(self, arg_1_1)
end

function RemindTipSlgCityData:getTipStr()
	local var_2_1 = g.core.config.new_slg_city_info.get((tonumber(string.split(self._params, ":")[1])))

	return g.core.lang:getByString(self._cfg.text, {
		param1 = var_2_1.level,
		param2 = var_2_1.name
	})
end

function RemindTipSlgCityData:getJumpFunc()
	return function()
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN)
	end
end

return RemindTipSlgCityData
