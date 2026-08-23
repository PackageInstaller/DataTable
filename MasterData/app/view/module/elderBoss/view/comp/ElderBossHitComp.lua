local ElderBossHitComp = class("ElderBossHitComp", require("app.fairyGUI.elderBoss.UI_ElderBossHitComp"))

function ElderBossHitComp:updateHit(arg_1_1)
	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.userId)

	if var_1_0 then
		self.m_nameTxt:setText(var_1_0.name)
		self.m_hitValue:setText(g.core.lang:get(432517, {
			value = arg_1_1.damage
		}))
	end
end

return ElderBossHitComp
