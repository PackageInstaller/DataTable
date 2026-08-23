local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareExploreFormationKnightComp = class("FogNightmareExploreFormationKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreFormationKnightComp"))

function FogNightmareExploreFormationKnightComp:ctor()
	self._knightStruct = nil
	self._curAnim = ""
	self._movingSpine = nil
end

function FogNightmareExploreFormationKnightComp:updateComp(arg_2_1, arg_2_2)
	self._knightStruct = arg_2_1

	self.m_knightComp:updateComp(arg_2_1, arg_2_2, true)

	if arg_2_1 then
		local var_2_1 = arg_2_1:getDevelopStructs()
	end

	self.m_rightDevelopComp:updateComp(arg_2_1, arg_2_2)
end

function FogNightmareExploreFormationKnightComp:showMoveBg(arg_3_1)
	self.m_knightComp:showMoveBg(arg_3_1)
end

function FogNightmareExploreFormationKnightComp:setCompTouch(arg_4_1)
	self.m_knightComp:setTouch(arg_4_1)
	self.m_rightDevelopComp:setCompTouch(arg_4_1)
end

function FogNightmareExploreFormationKnightComp:checkCompPos(arg_5_1)
	if self.m_rightDevelopComp:isCanMove() and self.m_rightDevelopComp:containPoint(arg_5_1) then
		return var_0_2.MOVE_COMP.ARTIFACT, self.m_rightDevelopComp
	end

	return (self._knightStruct ~= nil or nil) and (var_0_2.MOVE_COMP.ALL or ""), self
end

function FogNightmareExploreFormationKnightComp:setPlusUIEnable(arg_6_1)
	if arg_6_1 then
		self.m_hidePlusController:setSelectedIndex(0)
	else
		self.m_hidePlusController:setSelectedIndex(1)
	end
end

function FogNightmareExploreFormationKnightComp:playCompMovingEffect()
	if not self._movingSpine or tolua.isnull(self._movingSpine) then
		self._movingSpine = self.m_effectCompPlay:addEffectSpine({
			anim = "setPlay",
			name = "eff_ui_fogNightmare_guild",
			isLoop = true
		})
	elseif self._curAnim ~= "setPlay" then
		self._movingSpine:setAnimation(0, "setPlay", true)
	end

	self._curAnim = "setPlay"

	self.m_effectCompPlay:setVisible(true)
end

function FogNightmareExploreFormationKnightComp:touchEndEffect()
	self.m_effectCompPlay:setVisible(true)

	if self._movingSpine and not tolua.isnull(self._movingSpine) then
		self._curAnim = "downPlay"

		self._movingSpine:setAnimation(0, "downPlay", false)
	end
end

function FogNightmareExploreFormationKnightComp:closeCompMovingEffect()
	self.m_effectCompPlay:setVisible(false)
end

return FogNightmareExploreFormationKnightComp
