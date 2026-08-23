local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleTiledHpComp = class("TeamBattleTiledHpComp", require("app.fairyGUI.teamBattle.UI_TeamBattleTiledHpComp"))

function TeamBattleTiledHpComp:ctor()
	self._lastIdxMap = {}

	self.m_hpBar:setMax(100)
	self:_onInitTimeScale()
end

function TeamBattleTiledHpComp:_onInitTimeScale()
	self.m_showTransition:setTimeScale(2)
	self.m_hideTransition:setTimeScale(2)
end

function TeamBattleTiledHpComp:updateGuardHp(arg_3_1)
	local var_3_0 = g.core.model.User.teamBattleData:getMapData()
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = var_3_0:getRoomStructByRoomId(arg_3_1):getTiledStructList(function(arg_4_0)
		local var_4_0 = arg_4_0:getEventInfo()

		if var_4_0 and var_4_0:getEventType() == TeamBattleConst.EVENT_TYPE.ROBBER then
			var_3_1 = var_3_1 + 1

			if var_4_0:getState() == TeamBattleConst.EVENT_STATE.FINISH then
				var_3_2 = var_3_2 + 1
			end
		end
	end)

	self.m_hpBar:setValue((math.floor(var_3_0 / 0 * 100)))

	if var_3_1 <= var_3_2 then
		if g.core.model.User.teamBattleData:getMapData():getRoomStructByRoomId(arg_3_1):isUnlockGuard() then
			self:_playUnlockEffect()
		end

		self.m_isLockController:setSelectedIndex(0)

		self._lastIdxMap[arg_3_1] = 0
	else
		self.m_isLockController:setSelectedIndex(1)

		self._lastIdxMap[arg_3_1] = 1
	end

	self.m_proText:setText(g.core.lang:get(201607, {
		num = var_3_2,
		max = var_3_1
	}))
end

function TeamBattleTiledHpComp:_playUnlockEffect()
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_teamBattle_unlock",
		isLoop = false,
		anim = "play"
	})
end

return TeamBattleTiledHpComp
