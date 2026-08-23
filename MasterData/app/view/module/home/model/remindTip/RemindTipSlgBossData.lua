local RemindTipSlgBossData = class("RemindTipSlgBossData", (require("app.view.module.home.model.remindTip.RemindTipBaseData")))

function RemindTipSlgBossData:ctor(arg_1_1)
	RemindTipSlgBossData.super.ctor(self, arg_1_1)
end

function RemindTipSlgBossData:getTipStr()
	local var_2_0 = g.core.config.new_slg_boss_info.get((tonumber(string.split(self._params, ":")[1])))
	local var_2_1 = {
		param2 = var_2_0.level,
		param3 = var_2_0.name
	}
	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._sourceId)

	if var_2_2 then
		var_2_1.param1 = var_2_2.name

		return g.core.lang:getByString(self._cfg.text, var_2_1)
	end

	return ""
end

function RemindTipSlgBossData:getJumpFunc()
	return (handler(self, function(arg_4_0)
		local var_4_0 = string.split(arg_4_0._params, ":")

		g.core.utils.Tools.newSlgFunc.clickBossInvite({
			teamId = tonumber(var_4_0[2]),
			bossId = tonumber(var_4_0[1]),
			createTime = tonumber(var_4_0[3])
		})
	end))
end

return RemindTipSlgBossData
