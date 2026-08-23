local RemindTipMysteryBossData = class("RemindTipMysteryBossData", (require("app.view.module.home.model.remindTip.RemindTipBaseData")))

function RemindTipMysteryBossData:ctor(arg_1_1)
	RemindTipMysteryBossData.super.ctor(self, arg_1_1)

	if not self._uid then
		self:_initTempUid()
	end

	if #self._params > 1 then
		if #(g.core.common.GlobalFunc.rankUnit_param(self._params, "MysteryBossTips", true) or {}) > 0 then
			self._params = "alive"
		end
	end
end

function RemindTipMysteryBossData:updateData(arg_2_1)
	RemindTipMysteryBossData.super.updateData(self, arg_2_1)

	if #self._params > 1 then
		if #(g.core.common.GlobalFunc.rankUnit_param(self._params, "MysteryBossTips", true) or {}) > 0 then
			self._params = "alive"
		end
	end
end

function RemindTipMysteryBossData:isHide()
	return RemindTipMysteryBossData.super.isHide(self) or #self._params < 1 or g.core.model.User.mysteryBossData:getLimitBossChallengeTime() < 1
end

function RemindTipMysteryBossData:getJumpFunc()
	return function()
		g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERY_MAIN_LAYER)
	end
end

return RemindTipMysteryBossData
