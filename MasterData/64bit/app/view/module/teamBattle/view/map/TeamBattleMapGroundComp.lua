local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapGroundComp = class("TeamBattleMapGroundComp", require("app.fairyGUI.teamBattle.UI_TeamBattleMapGroundComp"))

function TeamBattleMapGroundComp:ctor()
	self._groundNum = -1
	self._inUpAction = false

	self:doFairyBatching(true)
	self:_onInitTimeScale()
end

function TeamBattleMapGroundComp:_onInitTimeScale()
	self.m_showTransition:setTimeScale(2)
	self.m_hideTransition:setTimeScale(2)
end

function TeamBattleMapGroundComp:updateGround(arg_3_1)
	local var_3_0 = false
	local var_3_1 = arg_3_1.changeInfo

	if arg_3_1.type == "barrier" then
		if arg_3_1.valueEx == 1 then
			var_3_0 = true

			self:setVisible(true)
		elseif arg_3_1.valueEx == 2 then
			self:setVisible(true)
		else
			self:setVisible(false)
		end
	else
		local var_3_2 = arg_3_1.value:getState()

		if var_3_2 == TeamBattleConst.MAP.TILED_STATE_UNLOCK then
			var_3_0 = true

			self:setVisible(true)
		elseif var_3_2 == TeamBattleConst.MAP.TILED_STATE_IN_SIGHT then
			self:setVisible(true)
		else
			self:setVisible(false)
		end
	end

	if var_3_1 then
		if var_3_1.showStr == "show" then
			self.m_showTransition:play()
		elseif var_3_1.showStr == "hide" then
			self.m_hideTransition:play()
		elseif var_3_1.showStr == "up" then
			self._inUpAction = true

			self.m_icon:setOpacity(0)
			self:newScheduleOnce(handler(self, function(arg_4_0)
				arg_4_0:setVisible(true)
				arg_4_0.m_icon:setOpacity(0)
				arg_4_0.m_showEndTransition:play()
				arg_4_0.m_upTransition:play(handler(arg_4_0, arg_4_0.playUpActionEnd))
			end), var_3_1.timeLevel * TeamBattleConst.MAP.TILED_SHOW_EFFECT_DELTA)
		end
	elseif not self._inUpAction then
		if var_3_0 then
			self.m_hideEndTransition:play()
		else
			self.m_showEndTransition:play()
		end
	end

	local var_3_3 = arg_3_1.ground

	if arg_3_1.ground == self._groundNum then
		return
	end

	self.m_icon:setURL("ui://teamBattle/" .. var_3_3)

	self._groundNum = var_3_3
end

function TeamBattleMapGroundComp:playUpActionEnd()
	self._inUpAction = false
end

return TeamBattleMapGroundComp
