local var_0_0 = g.core.const.ConstMgr
local var_0_1 = "movingAniNode"
local var_0_2 = {
	EMPTY = cc.p(13, 88),
	NO_EMPTY = cc.p(65, 81)
}
local var_0_3 = {
	EMPTY = cc.p(13, 72),
	NO_EMPTY = cc.p(13, 83)
}
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.common.Path
local var_0_6 = g.core.model.User.knightsData
local BaseMulTeamFormationKnightComp = class("BaseMulTeamFormationKnightComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationKnightComp"))

function BaseMulTeamFormationKnightComp:ctor()
	self._stationPos = 0
	self._emptyCtrlIdx = 0
	self._addEnableCtrlIdx = 0
	self._mulFormationStruct = nil

	self.m_addBtn:addClickListener(handler(self, self._onClickKnight))
	self.m_knightClickAreaComp:addClickListener(handler(self, self._onClickKnight))
	self.m_bindKnightLoader:addClickListener(handler(self, self._onClickBindKnightLoader))
	self.m_starComp:initStar({
		gap = -10,
		index = 3,
		num = 0,
		style = 2
	})
end

function BaseMulTeamFormationKnightComp:becomeTo(arg_2_1)
	self:setStationPos((arg_2_1:getStationPos()))
	self:updateComp((arg_2_1:getMulFormationStruct()))
	self.m_draggingBgImg:setVisible(true)
end

function BaseMulTeamFormationKnightComp:setGroupType(arg_3_1)
	self._group = arg_3_1

	if self._mulFormationStruct then
		local var_3_0 = {}

		var_3_0.group = self._group or 0
		var_3_0.formationType = self._mulFormationStruct:getFormationType()
		var_3_0.formationIndex = self._mulFormationStruct:getMulIndex()
		var_3_0.pos = self._stationPos

		self.m_redPointComp:setCustomData(var_3_0)
	end
end

function BaseMulTeamFormationKnightComp:updateComp(arg_4_1)
	if self._mulIndex then
		if arg_4_1:getMulIndex() ~= self._mulIndex then
			local var_4_0 = {}

			var_4_0.group = self._group or 0
			var_4_0.formationType = arg_4_1:getFormationType()
			var_4_0.formationIndex = arg_4_1:getMulIndex()
			var_4_0.pos = self._stationPos

			self.m_redPointComp:setCustomData(var_4_0)
		end
	end

	self._mulIndex = arg_4_1:getMulIndex()
	self._mulFormationStruct = arg_4_1

	self:stopKnightLineupChangeAni()

	local var_4_1 = arg_4_1:getBindKnight(self._stationPos)

	if var_4_1 then
		self.m_bindEmptyController:setSelectedIndex(0)
		self.m_linkLvTxt:setText((var_4_1:getLevel()))
		self.m_bindKnightLoader:setURL((var_0_5:getKnightIconById(var_4_1:getResInfo().painted_id)))

		local var_4_2 = var_4_1:getBaseInfo()
	else
		self.m_bindEmptyController:setSelectedIndex(1)
		self.m_linkLvTxt:setText("")
		self.m_bindKnightLoader:setURL("")
	end

	local var_4_3 = arg_4_1:getKnightSid(self._stationPos)

	if var_4_3 == 0 then
		self.m_emptyController:setSelectedIndex(1)
		self.m_addEnableController:setSelectedIndex(1)
		self.m_leftQualityLoader:setURL((var_0_5:getMulTeamLeftVerticalQualityBarURL(var_0_0.QUALITY_TYPE.NONE)))
		self.m_leaderLoader:setVisible(false)
	else
		self.m_emptyController:setSelectedIndex(0)

		local var_4_4 = var_0_6:getKnightById(var_4_3)

		self.m_knightIconLbl:setIcon((var_0_5:getKnightPicRes(var_4_4:getResInfo().painted_id)))
		self.m_leftQualityLoader:setURL((var_0_5:getMulTeamLeftVerticalQualityBarURL((var_4_4:getQuality()))))
		self.m_starComp:setStarNum(var_4_4:getStarLv())
		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_4_4:getBaseInfo().classical))
		self.m_leaderLoader:setVisible(var_4_4:isElementLeader())
	end
end

function BaseMulTeamFormationKnightComp:getStationPos()
	return self._stationPos
end

function BaseMulTeamFormationKnightComp:setStationPos(arg_6_1)
	self._stationPos = arg_6_1
end

function BaseMulTeamFormationKnightComp:getMulFormationStruct()
	return self._mulFormationStruct
end

function BaseMulTeamFormationKnightComp:onDragStart()
	self.m_emptyController:setSelectedIndex(1)
	self.m_addEnableController:setSelectedIndex(1)
	self.m_bindEmptyController:setSelectedIndex(1)
	self.m_leftQualityLoader:setURL((var_0_5:getMulTeamLeftVerticalQualityBarURL(var_0_0.QUALITY_TYPE.NONE)))
end

function BaseMulTeamFormationKnightComp:onDragEnd()
	self:updateComp(self._mulFormationStruct)
end

function BaseMulTeamFormationKnightComp:isEmpty()
	if self._mulFormationStruct then
		return not self._mulFormationStruct:isStationPosLineupKnight(self._stationPos)
	else
		return true
	end
end

function BaseMulTeamFormationKnightComp:_onClickKnight(arg_11_1)
	arg_11_1:stopPropagation()
	self:dispatchCompEvent("CompEventClickKnight", self._stationPos)
end

function BaseMulTeamFormationKnightComp:_onClickBindKnightLoader()
	if not self._mulFormationStruct then
		return
	end

	local var_12_0 = self._mulFormationStruct:getBindKnight(self._stationPos)

	if var_12_0 then
		var_0_4:pushModule(g.view.entrance.KNIGHT_DEVELOP, {
			knightSid = var_12_0:getServerId()
		})
	else
		var_0_4:pushModule(g.view.entrance.LINE_UP)
	end
end

function BaseMulTeamFormationKnightComp:playKnightLineupAni()
	if self:isEmpty() then
		return
	end

	local var_13_0 = self.m_effDadComp:displayObject():getChildByName(var_0_1)

	if not var_13_0 then
		var_13_0 = self.m_effDadComp:addEffectSpine({
			isLoop = false,
			remove = false,
			name = "eff_ui_towerHard_lineUp"
		})

		var_13_0:setName(var_0_1)
	end

	var_13_0:setAnimation(0, "play", false)
	var_13_0:restart()
	var_13_0:setVisible(true)
	self.m_lvGroup:setPosition(var_0_2.EMPTY)
	self.m_lvWordGroup:setPosition(var_0_3.EMPTY)
	self.m_levelTransition:play()
end

function BaseMulTeamFormationKnightComp:stopKnightLineupChangeAni()
	local var_14_0 = self.m_effDadComp:displayObject():getChildByName(var_0_1)

	if var_14_0 then
		var_14_0:stop()
		var_14_0:setVisible(false)
	end

	self.m_levelTransition:stop()

	if self:isEmpty() then
		self.m_lvGroup:setPosition(var_0_2.EMPTY)
		self.m_lvWordGroup:setPosition(var_0_3.EMPTY)
	else
		self.m_lvGroup:setPosition(var_0_2.NO_EMPTY)
		self.m_lvWordGroup:setPosition(var_0_3.NO_EMPTY)
	end
end

function BaseMulTeamFormationKnightComp:setLockUrl(arg_15_1)
	self.m_lockIcon:setURL(arg_15_1)
end

function BaseMulTeamFormationKnightComp:setLock(arg_16_1)
	self.m_isLockController:setSelectedIndex(arg_16_1 and 1 or 0)
end

return BaseMulTeamFormationKnightComp
