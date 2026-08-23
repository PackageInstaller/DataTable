local var_0_0 = g.core.const.ConstMgr
local var_0_1 = "movingAniNode"
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.explorationData
local ExplorationFormationKnightComp = class("ExplorationFormationKnightComp", require("app.fairyGUI.exploration.UI_ExplorationFormationKnightComp"))

function ExplorationFormationKnightComp:ctor()
	self._stationPos = 0
	self._emptyCtrlIdx = 0
	self._addEnableCtrlIdx = 0
	self._mulFormationStruct = nil

	self.m_addBtn:addClickListener(handler(self, self._onClickKnight))
	self.m_knightClickAreaComp:addClickListener(handler(self, self._onClickKnight))
	self.m_starComp:initStar({
		index = 3,
		num = 0,
		gap = -10,
		style = 2
	})
end

function ExplorationFormationKnightComp:becomeTo(arg_2_1)
	self:setStationPos((arg_2_1:getStationPos()))
	self:updateComp((arg_2_1:getMulFormationStruct()))
	self.m_draggingBgImg:setVisible(true)
end

function ExplorationFormationKnightComp:updateComp(arg_3_1)
	if not self._mulIndex or arg_3_1:getMulIndex() ~= self._mulIndex then
		self.m_redPointComp:setCustomData({
			formationIndex = arg_3_1:getMulIndex(),
			pos = self._stationPos
		})
	end

	self._mulIndex = arg_3_1:getMulIndex()
	self._mulFormationStruct = arg_3_1

	self:stopKnightLineupChangeAni()

	local var_3_0 = var_0_3:getFormationData():getKnightByServerId((arg_3_1:getKnightSid(self._stationPos)))

	if not var_3_0 then
		self.m_emptyController:setSelectedIndex(1)
		self.m_addEnableController:setSelectedIndex(1)
		self.m_leftQualityLoader:setURL((var_0_2:getMulTeamLeftVerticalQualityBarURL(var_0_0.QUALITY_TYPE.NONE)))
		self.m_leaderLoader:setVisible(false)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_knightIconLbl:setIcon((var_0_2:getKnightPicRes(var_3_0:getResInfo().painted_id)))
		self.m_leftQualityLoader:setURL((var_0_2:getMulTeamLeftVerticalQualityBarURL((var_3_0:getQuality()))))
		self.m_starComp:setStarNum(var_3_0:getStarLv())
		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_3_0:getBaseInfo().classical))
		self.m_leaderLoader:setVisible(var_3_0:isElementLeader())
	end
end

function ExplorationFormationKnightComp:getStationPos()
	return self._stationPos
end

function ExplorationFormationKnightComp:setStationPos(arg_5_1)
	self._stationPos = arg_5_1
end

function ExplorationFormationKnightComp:getMulFormationStruct()
	return self._mulFormationStruct
end

function ExplorationFormationKnightComp:onDragStart()
	self.m_emptyController:setSelectedIndex(1)
	self.m_addEnableController:setSelectedIndex(1)
	self.m_leftQualityLoader:setURL((var_0_2:getMulTeamLeftVerticalQualityBarURL(var_0_0.QUALITY_TYPE.NONE)))
end

function ExplorationFormationKnightComp:onDragEnd()
	self:updateComp(self._mulFormationStruct)
end

function ExplorationFormationKnightComp:isEmpty()
	if self._mulFormationStruct then
		return not self._mulFormationStruct:isStationPosLineupKnight(self._stationPos)
	else
		return true
	end
end

function ExplorationFormationKnightComp:_onClickKnight(arg_10_1)
	arg_10_1:stopPropagation()
	self:dispatchCompEvent("CompEventClickKnight", self._stationPos)
end

function ExplorationFormationKnightComp:playKnightLineupAni()
	if self:isEmpty() then
		return
	end
end

function ExplorationFormationKnightComp:stopKnightLineupChangeAni()
	local var_12_0 = self.m_effDadComp:displayObject():getChildByName(var_0_1)

	if var_12_0 then
		var_12_0:stop()
		var_12_0:setVisible(false)
	end
end

return ExplorationFormationKnightComp
