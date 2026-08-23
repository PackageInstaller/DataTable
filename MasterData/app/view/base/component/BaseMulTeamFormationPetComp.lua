local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.model.User.petsData
local BaseMulTeamFormationPetComp = class("BaseMulTeamFormationPetComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationPetComp"))

function BaseMulTeamFormationPetComp:ctor()
	self._stationPos = 0
	self._dragEndStationPos = 0
	self._sid = 0
	self._emptyCtrlIdx = 0
	self._dragging = false

	self.m_starComp:initStar({
		gap = -3,
		style = 2,
		index = 3,
		num = 0,
		max = var_0_1.PetConst.STAR_MAX
	})
end

function BaseMulTeamFormationPetComp:setFormationType(arg_2_1)
	self._formationType = arg_2_1
end

function BaseMulTeamFormationPetComp:getFormationType()
	return self._formationType
end

function BaseMulTeamFormationPetComp:updateComp(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 and (not self._mulIndex or arg_4_3 ~= self._mulIndex) then
		self.m_redPointComp:setCustomData({
			formationType = self._formationType,
			formationIndex = arg_4_3,
			pos = arg_4_1
		})
	end

	self._stationPos = arg_4_1
	self._sid = arg_4_2
	self._dragging = false
	self._mulIndex = arg_4_3

	local var_4_0 = var_0_2:isModuleUnlock(var_0_3["PET_LINE_UP_" .. self._stationPos])

	if not var_4_0 then
		local var_4_1, var_4_2 = var_0_2:getModuleUnlockLevelAndComment(var_0_3["PET_LINE_UP_" .. self._stationPos])

		self.m_openText:setText(g.core.lang:get(202514, {
			level = var_4_1
		}))
	end

	self.m_isLockController:setSelectedIndex(var_4_0 and 0 or 1)

	local var_4_3, var_4_4 = g.core.model.User.mulFormationData:getPetBySid(self._formationType, arg_4_2)

	if var_4_3 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_qualityBarLoader:setURL((var_0_4:getMulTeamLeftVerticalQualityBarURL(var_4_3:getQuality())))
		self.m_petLoader:setURL((var_0_4:getPetIcon(var_4_3:getCfg().resource)))

		if var_4_4 then
			local var_4_5 = var_0_5:getPetByPos(arg_4_1)

			if var_4_5 then
				self.m_bigStageTxt:setText(var_4_5:getBigSmallStage())
			else
				self.m_bigStageTxt:setText("0")
			end
		else
			self.m_bigStageTxt:setText(var_4_3:getBigSmallStage())
		end

		self.m_starComp:setStarNum((var_4_3:getStarNum()))
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_qualityBarLoader:setURL((var_0_4:getMulTeamLeftVerticalQualityBarURL(var_0_1.QUALITY_TYPE.NONE)))
	end
end

function BaseMulTeamFormationPetComp:becomeTo(arg_5_1)
	self:setFormationType(arg_5_1:getFormationType())
	self:updateComp(arg_5_1:getStationPos(), arg_5_1:getSid(), self._mulIndex)
end

function BaseMulTeamFormationPetComp:isEmpty()
	return self._sid == 0
end

function BaseMulTeamFormationPetComp:getStationPos()
	return self._stationPos
end

function BaseMulTeamFormationPetComp:getSid()
	return self._sid
end

function BaseMulTeamFormationPetComp:onDragStart()
	self._dragging = true
	self._emptyCtrlIdx = self.m_emptyController:getSelectedIndex()

	self.m_emptyController:setSelectedIndex(1)
end

function BaseMulTeamFormationPetComp:onDragEnd()
	if self._dragging then
		self._dragging = false

		self.m_emptyController:setSelectedIndex(self._emptyCtrlIdx)
	end
end

return BaseMulTeamFormationPetComp
