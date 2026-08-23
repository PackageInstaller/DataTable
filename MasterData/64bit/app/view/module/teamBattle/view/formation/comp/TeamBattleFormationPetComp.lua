local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.model.User.teamBattleData
local TeamBattleFormationPetComp = class("TeamBattleFormationPetComp", require("app.fairyGUI.teamBattle.UI_TeamBattleFormationPetComp"))

function TeamBattleFormationPetComp:ctor()
	self._stationPos = 0
	self._dragEndStationPos = 0
	self._sid = 0
	self._emptyCtrlIdx = 0
	self._dragging = false

	self.m_starComp:initStar({
		gap = -3,
		index = 3,
		style = 2,
		num = 0,
		max = var_0_0.PetConst.STAR_MAX
	})
end

function TeamBattleFormationPetComp:setFormationType(arg_2_1)
	self._formationType = arg_2_1
end

function TeamBattleFormationPetComp:updateComp(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 and (not self._mulIndex or arg_3_3 ~= self._mulIndex) then
		self.m_redPointComp:setCustomData({
			formationIndex = arg_3_3,
			pos = arg_3_1
		})
	end

	self._stationPos = arg_3_1
	self._sid = arg_3_2
	self._dragging = false
	self._mulIndex = arg_3_3

	local var_3_0 = var_0_1:isModuleUnlock(var_0_2["PET_LINE_UP_" .. self._stationPos])

	if not var_3_0 then
		local var_3_1, var_3_2 = var_0_1:getModuleUnlockLevelAndComment(var_0_2["PET_LINE_UP_" .. self._stationPos])

		self.m_openText:setText(g.core.lang:get(202514, {
			level = var_3_1
		}))
	end

	self.m_isLockController:setSelectedIndex(var_3_0 and 0 or 1)

	local var_3_3 = var_0_4:getFormationData():getPetByServerId(arg_3_2)

	if var_3_3 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_qualityBarLoader:setURL((var_0_3:getMulTeamLeftVerticalQualityBarURL(var_3_3:getQuality())))
		self.m_petLoader:setURL((var_0_3:getPetIcon(var_3_3:getCfg().resource)))
		self.m_bigStageTxt:setText(var_3_3:getBigSmallStage())
		self.m_starComp:setStarNum((var_3_3:getStarNum()))
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_qualityBarLoader:setURL((var_0_3:getMulTeamLeftVerticalQualityBarURL(var_0_0.QUALITY_TYPE.NONE)))
	end
end

function TeamBattleFormationPetComp:becomeTo(arg_4_1)
	self:updateComp(arg_4_1:getStationPos(), arg_4_1:getSid(), self._mulIndex)
end

function TeamBattleFormationPetComp:isEmpty()
	return self._sid == 0
end

function TeamBattleFormationPetComp:getStationPos()
	return self._stationPos
end

function TeamBattleFormationPetComp:getSid()
	return self._sid
end

function TeamBattleFormationPetComp:onDragStart()
	self._dragging = true
	self._emptyCtrlIdx = self.m_emptyController:getSelectedIndex()

	self.m_emptyController:setSelectedIndex(1)
end

function TeamBattleFormationPetComp:onDragEnd()
	if self._dragging then
		self._dragging = false

		self.m_emptyController:setSelectedIndex(self._emptyCtrlIdx)
	end
end

return TeamBattleFormationPetComp
