local var_0_1 = g.core.model.User.artifactData
local ArtifactBaseInfoComp = class("ArtifactBaseInfoComp", require("app.fairyGUI.artifact.UI_ArtifactBaseInfoComp"))

function ArtifactBaseInfoComp:ctor()
	self.m_maskKnight:addClickListener(handler(self, self._onKnightIconClick))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRenderer))

	self._skillInfo = nil
end

function ArtifactBaseInfoComp:updateShow(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.m_enterEffect:removeAllEffect()
	self.m_idleEffectDown:removeAllEffect()
	self.m_idleEffectUp:removeAllEffect()

	if arg_2_1 then
		self._knightPos = arg_2_2
		self._artifactStruct = arg_2_1
		self._isLineUpModel = arg_2_3
		self._artifactInfo = self._artifactStruct:getCfg()
		self._baseAttrsData = self._artifactStruct:getBaseAttrsData()
		self._baseId = self._artifactStruct:getArtifactBaseId()

		self.m_levelText:setText((self._artifactStruct:getLevel()))

		self._belongToKnightId = self._artifactStruct:getBelongToKnightAvdIdIncludingMainRole()

		if self._belongToKnightId then
			self.m_maskKnight:getChild("maskKnightIcon"):updateBelongToIcon(self._belongToKnightId)
		end

		self.m_attrList:setNumItems(#self._baseAttrsData)
		self:_updateSkill()
		self.m_skill2:setVisible((arg_2_1:isHasWeaponSpirit()))
	end

	self.m_isLinkController:setSelectedIndex(0)

	if self.m_enterTransition and not arg_2_4 then
		self.m_enterTransition:play()
	end

	local var_2_0 = g.core.model.User.knightsData:getKnightByFormationIndex(arg_2_2)

	if var_2_0 and var_2_0:getAdvanceId() == self._belongToKnightId then
		self.m_isLinkController:setSelectedIndex(1)
		self:_playLinkEnterAnim()
	end
end

function ArtifactBaseInfoComp:_updateSkill()
	self.m_skillIcon:updateIcon({
		artifact = self._artifactStruct,
		knightPos = self._knightPos,
		isLineUpModel = self._isLineUpModel
	})
	self.m_skillDesc1:updateSkillDesc({
		enableRich = true,
		name = self._artifactStruct:getSkillInfo().name,
		desc = var_0_1:getSkillEnhanceInfoByBaseId(self._baseId).description
	})

	if self._artifactStruct:isHasWeaponSpirit() then
		local var_3_0 = self._artifactStruct:getWearKnight()

		if self._artifactStruct:isAdjointSkillActive() and var_3_0 and var_3_0:getAdvanceId() == self._belongToKnightId then
			self.m_skillIcon2:updateSpiritSkillIcon({
				artifact = self._artifactStruct,
				knightPos = self._knightPos,
				isLineUpModel = self._isLineUpModel
			})

			local var_3_1 = self._artifactStruct:getSpiritAdjointSkill()

			if var_3_1 > 0 then
				local var_3_2 = g.core.config.passive_skill_info.get(var_3_1)
				local var_3_3, var_3_4 = g.core.utils.String.formatSkillEnchantInfoDesc(var_3_2.passive_skill_value, var_3_2.passive_skill_type)

				self.m_skillDesc2:updateSkillDesc({
					enableRich = true,
					name = var_3_2.name,
					desc = var_3_3
				})
			end

			self.m_skill2:setVisible(true)
			self.m_skillIcon2:setRelatedController(1)
		else
			self.m_skillIcon2:updateSpiritSkillIcon({
				artifact = self._artifactStruct,
				knightPos = self._knightPos,
				isLineUpModel = self._isLineUpModel
			})
			self.m_skillIcon2:setRelatedController(0)

			local var_3_5 = self._artifactStruct:getFirstActiveAdjointSkill()

			if var_3_5 > 0 then
				local var_3_6 = g.core.config.passive_skill_info.get(var_3_5)
				local var_3_7, var_3_8 = g.core.utils.String.formatSkillEnchantInfoDesc(var_3_6.passive_skill_value, var_3_6.passive_skill_type)

				self.m_skillDesc2:updateSkillDesc({
					enableRich = true,
					name = var_3_6.name,
					desc = var_3_7
				})
			end

			self.m_skill2:setVisible(true)
		end
	else
		self.m_skill2:setVisible(false)
	end
end

function ArtifactBaseInfoComp:playEnterAnim(arg_4_1)
	if self.m_enterTransition then
		if arg_4_1 then
			self.m_enterTransition:play(arg_4_1)
		else
			self.m_enterTransition:play()
		end
	end
end

function ArtifactBaseInfoComp:playExitAnim(arg_5_1)
	if self.m_backTransition then
		if arg_5_1 then
			self.m_backTransition:play(arg_5_1)
		else
			self.m_backTransition:play()
		end
	end
end

function ArtifactBaseInfoComp:_onAttrListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateAttr(self._baseAttrsData[arg_6_1 + 1])
end

function ArtifactBaseInfoComp:_onKnightIconClick()
	if self._belongToKnightId then
		local var_7_1 = g.core.model.User.artifactData:getManRoleRelatedAdvId(self._belongToKnightId)

		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = (var_7_1 or nil) and var_7_1
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

function ArtifactBaseInfoComp:_playLinkEnterAnim()
	self.m_enterEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_lineUp_linkEnter",
		anim = "enter"
	})

	local var_8_0 = self.m_idleEffectDown:addEffectSpine({
		isLoop = true,
		name = "eff_ui_lineUp_linkEnter",
		anim = "idleDown"
	})
	local var_8_1 = self.m_idleEffectUp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_lineUp_linkEnter",
		anim = "idleUp"
	})

	var_8_0:setOpacity(0)
	var_8_0:runAction(cc.Sequence:create({
		cc.FadeIn:create(0.5)
	}))
	var_8_1:setOpacity(0)
	var_8_1:runAction(cc.Sequence:create({
		cc.FadeIn:create(0.5)
	}))
end

return ArtifactBaseInfoComp
