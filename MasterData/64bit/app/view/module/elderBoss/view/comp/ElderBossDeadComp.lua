local var_0_0 = g.core.model.User.elderBossData
local ElderBossDeadComp = class("ElderBossDeadComp", require("app.fairyGUI.elderBoss.UI_ElderBossDeadComp"))

function ElderBossDeadComp:ctor()
	self._cdSchedule = nil
	self._luckyUserId = 0
end

function ElderBossDeadComp:updateBossKilledInfo()
	self.m_killedEff:removeAllEffect()
	self.m_killedEff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_elderBoss_killedglow",
		anim = "play"
	})

	self._bossData = var_0_0:getBossSvrData()

	if self._bossData.rebornTime > 0 then
		self:updateTimeCD()

		self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self.updateTimeCD), 1)
	end

	if self._bossData.luckyUserId and self._bossData.luckyUserId > 0 then
		self._luckyUserId = self._bossData.luckyUserId

		self.m_isHaveLuckyController:setSelectedIndex(1)
		self:updateBossLuckyUser()
	else
		self._luckyUserId = 0

		self.m_isHaveLuckyController:setSelectedIndex(0)
	end
end

function ElderBossDeadComp:updateBossLuckyUser()
	if self._luckyUserId > 0 then
		local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._bossData.luckyUserId)

		if var_3_0 then
			self.m_playerNameTxt:setText(var_3_0.name)
		end
	end
end

function ElderBossDeadComp:updateTimeCD()
	local var_4_0 = self._bossData.rebornTime - g.core.common.ServerTime:getTime()

	if var_4_0 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(430805, {
			sec = var_4_0
		}))
	else
		self:cancelCDSchedule()
		var_0_0:resetBossRebornTime()
		self:dispatchCompEvent("COUNT_DOWN_BOSS_REBORN_TIME")
	end
end

function ElderBossDeadComp:onUnload()
	self:cancelCDSchedule()
end

function ElderBossDeadComp:cancelCDSchedule()
	if self._cdSchedule then
		self:cancelSchedule(self._cdSchedule)

		self._cdSchedule = nil
	end
end

return ElderBossDeadComp
