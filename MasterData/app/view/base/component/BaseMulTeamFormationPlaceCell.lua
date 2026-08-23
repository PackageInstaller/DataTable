local var_0_0 = "movingAniNode"
local BaseMulTeamFormationPlaceCell = class("BaseMulTeamFormationPlaceCell", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationPlaceCell"))

function BaseMulTeamFormationPlaceCell:ctor()
	self._stationPos = 0
	self._stationPos = checknumber((string.match(self:getName(), ".+_(%d+)$")))

	self.m_knightComp:setStationPos(self._stationPos)
	self.m_artifactComp:setStationPos(self._stationPos)
end

function BaseMulTeamFormationPlaceCell:becomeTo(arg_2_1)
	self._stationPos = arg_2_1:getStationPos()

	self.m_knightComp:becomeTo(arg_2_1.m_knightComp)
	self.m_artifactComp:becomeTo(arg_2_1.m_artifactComp)
end

function BaseMulTeamFormationPlaceCell:updateCell(arg_3_1)
	self.m_knightComp:updateComp(arg_3_1)
	self.m_artifactComp:updateComp(arg_3_1)
end

function BaseMulTeamFormationPlaceCell:onDragStart()
	self.m_knightComp:onDragStart()
	self.m_artifactComp:onDragStart()
end

function BaseMulTeamFormationPlaceCell:onDragEnd()
	self.m_knightComp:onDragEnd()
	self.m_artifactComp:onDragEnd()
end

function BaseMulTeamFormationPlaceCell:isEmpty()
	return self.m_knightComp:isEmpty()
end

function BaseMulTeamFormationPlaceCell:getStationPos()
	return self._stationPos
end

function BaseMulTeamFormationPlaceCell:playHoveringAni(arg_8_1)
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

function BaseMulTeamFormationPlaceCell:playDropAni()
	local var_9_0 = self.m_effDadComp:displayObject():getChildByName(var_0_0)

	if var_9_0 then
		var_9_0:setAnimation(0, "downPlay", false)
		var_9_0:restart()
		var_9_0:setVisible(true)
	else
		self:_addMoveAniNode("downPlay", false)
	end
end

function BaseMulTeamFormationPlaceCell:_addMoveAniNode(arg_10_1, arg_10_2)
	local var_10_0 = self.m_effDadComp:addEffectSpine({
		name = "eff_ui_fogNightmare_guild",
		anim = arg_10_1,
		isLoop = arg_10_2
	})

	var_10_0:setName(var_0_0)

	return var_10_0
end

function BaseMulTeamFormationPlaceCell:setGroupType(arg_11_1)
	self.m_knightComp:setGroupType(arg_11_1)
end

function BaseMulTeamFormationPlaceCell:setLockUrl(arg_12_1)
	self.m_knightComp:setLockUrl(arg_12_1)
end

function BaseMulTeamFormationPlaceCell:setLock(arg_13_1)
	self.m_knightComp:setLock(arg_13_1)
end

return BaseMulTeamFormationPlaceCell
