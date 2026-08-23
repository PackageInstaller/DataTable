local var_0_0 = g.core.model.User.treasureData
local TreasurePurifyLockBtn = class("TreasurePurifyLockBtn", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyLockBtn"))

function TreasurePurifyLockBtn:ctor()
	self._isLock = false
	self._sid = 0
	self._index = 0

	self:addClickListener(handler(self, self.onClickLock))
end

function TreasurePurifyLockBtn:setTreasureId(arg_2_1, arg_2_2)
	self._sid = arg_2_1
	self._index = arg_2_2
end

function TreasurePurifyLockBtn:setLock(arg_3_1)
	self._isLock = arg_3_1

	self.m_lockStateController:setSelectedIndex(arg_3_1 and 1 or 0)
end

function TreasurePurifyLockBtn:onClickLock()
	if self._sid > 0 then
		local var_4_0 = 0

		for iter_4_0, iter_4_1 in ipairs(var_0_0:getTreasureDataByOnlyId(self._sid).holes or {}) do
			if iter_4_1.lock then
				var_4_0 = var_4_0 + 1
			end
		end

		if var_0_0:getCurPurifyOpenNum(self._sid)[1].curNum <= var_4_0 + 1 and not self._isLock then
			g.core.module.ModuleManager:tip(g.core.lang:get(202066))

			return
		end

		g.core.network.GameNetProxy:send_C2S_Treasure_Purify_Lock({
			id = self._sid,
			pos = self._index - 1,
			lock = not self._isLock
		})
	end
end

return TreasurePurifyLockBtn
