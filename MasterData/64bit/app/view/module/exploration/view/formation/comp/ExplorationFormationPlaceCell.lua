local var_0_0 = "movingAniNode"
local ExplorationFormationPlaceCell = class("ExplorationFormationPlaceCell", require("app.fairyGUI.exploration.UI_ExplorationFormationPlaceCell"))

function ExplorationFormationPlaceCell:ctor()
	self._stationPos = 0
end

function ExplorationFormationPlaceCell:becomeTo(arg_2_1)
	self._stationPos = arg_2_1:getStationPos()

	self.m_knightComp:becomeTo(arg_2_1.m_knightComp)
	self.m_artifactComp:becomeTo(arg_2_1.m_artifactComp)
end

function ExplorationFormationPlaceCell:updateCell(arg_3_1)
	self.m_knightComp:updateComp(arg_3_1)
	self.m_artifactComp:updateComp(arg_3_1)
end

function ExplorationFormationPlaceCell:onDragStart()
	self.m_knightComp:onDragStart()
	self.m_artifactComp:onDragStart()
end

function ExplorationFormationPlaceCell:onDragEnd()
	self.m_knightComp:onDragEnd()
	self.m_artifactComp:onDragEnd()
end

function ExplorationFormationPlaceCell:isEmpty()
	return self.m_knightComp:isEmpty()
end

function ExplorationFormationPlaceCell:getStationPos()
	return self._stationPos
end

function ExplorationFormationPlaceCell:playHoveringAni(arg_8_1)
	local var_8_0 = self.m_effDadComp:displayObject():getChildByName(var_0_0)

	if arg_8_1 then
		var_8_0 = var_8_0 or self:_addMoveAniNode("setPlay", true)

		var_8_0:setAnimation(0, "setPlay", true)
		var_8_0:resume()
		var_8_0:setVisible(true)
	elseif var_8_0 then
		var_8_0:stop()
		var_8_0:setVisible(false)
	end
end

function ExplorationFormationPlaceCell:playDropAni()
	local var_9_0 = self.m_effDadComp:displayObject():getChildByName(var_0_0)

	if var_9_0 then
		var_9_0:setAnimation(0, "downPlay", false)
		var_9_0:restart()
		var_9_0:setVisible(true)
	else
		self:_addMoveAniNode("downPlay", false)
	end
end

function ExplorationFormationPlaceCell:_addMoveAniNode(arg_10_1, arg_10_2)
	local var_10_0 = self.m_effDadComp:addEffectSpine({
		name = "eff_ui_fogNightmare_guild",
		anim = arg_10_1,
		isLoop = arg_10_2
	})

	var_10_0:setName(var_0_0)

	return var_10_0
end

function ExplorationFormationPlaceCell:setStationPos(arg_11_1)
	self._stationPos = arg_11_1

	self.m_knightComp:setStationPos(self._stationPos)
	self.m_artifactComp:setStationPos(self._stationPos)
end

return ExplorationFormationPlaceCell
