local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.artifactData
local var_0_2 = g.core.model.User.knightsData
local BaseMulTeamFormationArtifactComp = class("BaseMulTeamFormationArtifactComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationArtifactComp"))

function BaseMulTeamFormationArtifactComp:ctor()
	self._stationPos = 0
	self._preDragEmptyCtrlIdx = 0
	self._mulFormationStruct = nil
	self._relatedEffNode = nil

	self.m_addBtn:addClickListener(handler(self, self._onClickArtifact))
	self.m_iconLoader:addClickListener(handler(self, self._onClickArtifact))
	self.m_qualityLoader:addClickListener(handler(self, self._onClickArtifact))
	self.m_emptyBgLoader:addClickListener(handler(self, self._onClickArtifact))
end

function BaseMulTeamFormationArtifactComp:becomeTo(arg_2_1)
	self:setStationPos((arg_2_1:getStationPos()))
	self:updateComp((arg_2_1:getMulFormationStruct()))
end

function BaseMulTeamFormationArtifactComp:updateComp(arg_3_1)
	if not self._mulIndex or arg_3_1:getMulIndex() ~= self._mulIndex then
		self.m_redPointComp1:setCustomData({
			formationType = arg_3_1:getFormationType(),
			formationIndex = arg_3_1:getMulIndex(),
			pos = self._stationPos
		})
	end

	self._mulIndex = arg_3_1:getMulIndex()
	self._mulFormationStruct = arg_3_1

	local var_3_0 = var_0_1:getArtifactBySid((arg_3_1:getArtifactSid(self._stationPos)))

	if var_3_0 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_starNumTxt:setText(var_3_0:getStar() or 0)
		self.m_iconLoader:setURL((var_0_0:getArtifactFormationImg(var_3_0:getCfg().res_id)))
		self.m_qualityLoader:setURL((var_0_0:getMulTeamArtifactQualityBgURL(var_3_0:getQuality())))

		if var_3_0:isHasWeaponSpirit() and var_3_0:getSpiritStage() > 0 then
			self.m_spiritComp:updateCurWeapon(var_3_0)
			self.m_urStageAddController:setSelectedIndex(1)
		else
			self.m_urStageAddController:setSelectedIndex(0)
		end
	else
		self.m_emptyController:setSelectedIndex(1)
	end

	self:_updateRelatedEffect()
end

function BaseMulTeamFormationArtifactComp:getStationPos()
	return self._stationPos
end

function BaseMulTeamFormationArtifactComp:setStationPos(arg_5_1)
	self._stationPos = arg_5_1
end

function BaseMulTeamFormationArtifactComp:getMulFormationStruct()
	return self._mulFormationStruct
end

function BaseMulTeamFormationArtifactComp:isEmpty()
	if self._mulFormationStruct then
		return not self._mulFormationStruct:isStationPosLineupArtifact(self._stationPos)
	else
		return true
	end
end

function BaseMulTeamFormationArtifactComp:onDragStart()
	self.m_emptyController:setSelectedIndex(1)
end

function BaseMulTeamFormationArtifactComp:onDragEnd()
	self:updateComp(self._mulFormationStruct)
end

function BaseMulTeamFormationArtifactComp:_onClickArtifact()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT) then
		return
	end

	self:dispatchCompEvent("CompEventClickArtifact", self._stationPos)
end

function BaseMulTeamFormationArtifactComp:_updateRelatedEffect()
	local var_11_0 = var_0_1:getArtifactBySid((self._mulFormationStruct:getArtifactSid(self._stationPos)))
	local var_11_1 = false

	if var_11_0 then
		local var_11_2 = var_0_2:getKnightById((self._mulFormationStruct:getKnightSid(self._stationPos)))

		if var_11_2 then
			var_11_1 = var_11_0:getBelongToKnightAvdIdIncludingMainRole() == var_11_2:getAdvanceId()
		end
	end

	if var_11_1 then
		self._relatedEffNode = self._relatedEffNode or self.m_effDadComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_artifactElect",
			isLoop = true
		})
	elseif self._relatedEffNode then
		self.m_effDadComp:removeAllEffect()

		self._relatedEffNode = nil
	end
end

return BaseMulTeamFormationArtifactComp
