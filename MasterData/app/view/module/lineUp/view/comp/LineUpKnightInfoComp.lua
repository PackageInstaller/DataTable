local var_0_0 = g.core.event.enum
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = g.core.model.User.knightTissueData
local var_0_8 = g.core.module.ModuleManager
local var_0_9 = g.core.common.ModuleUnlock
local var_0_10 = g.core.event.EventManager
local var_0_11 = g.core.model.User.formationData
local var_0_12 = g.core.const.ConstMgr.QUALITY_TYPE
local LineUpKnightInfoComp = class("LineUpKnightInfoComp", require("app.fairyGUI.lineUp.UI_LineUpKnightInfoComp"))

function LineUpKnightInfoComp:ctor()
	self._pos = 1
	self._knightSid = 0
	self._showTipIndex = 0
	self._changeAssctTip = false

	self.m_groupBtn:addClickListener(handler(self, self._onClickGroupBtn))
	self.m_developBtn:addClickListener(handler(self, self._onClickDevelopBtn))
	self.m_changeKnightBtn:addClickListener(handler(self, self._onClickChangeKnightBtn))
	self.m_assctComp:addClickListener(handler(self, self._onAssctClick))
	self.m_urGuide:addClickListener(handler(self, self._onUrGuideClick))
	self.m_knightTissueBtn:addClickListener(handler(self, self._onKnightTissueClick))
	self.m_artifactBtn:addClickListener(handler(self, self._onArtifactBtnClick))
	self.m_haloComp:addClickListener(handler(self, self._onClickHaloPopBtn))
	self.m_level:enableRich()
end

function LineUpKnightInfoComp:updateComp(arg_2_1, arg_2_2)
	self._pos = arg_2_1
	self._knightSid = arg_2_2

	local var_2_0 = var_0_6:getKnight({
		id = arg_2_2
	})
	local var_2_1 = var_2_0:getBaseInfo()

	self.m_urGuide:setVisible(g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.UR_PROPERTY, nil, true) and var_2_0:getQuality() >= g.core.const.ConstMgr.QUALITY_TYPE.MR)

	local var_2_2 = var_2_0:getLevel()

	if var_2_2 < 10 then
		var_2_2 = g.core.lang:get(201026, {
			level = var_2_2
		})
	elseif var_2_2 < 100 then
		var_2_2 = g.core.lang:get(201027, {
			level = var_2_2
		})
	end

	self.m_level:setText(var_2_2)
	self.m_maxLevel:setText((var_2_0:getMaxLevel() > var_2_0:getLevel() or nil) and (g.core.lang:get(201028, {
		num = g.core.model.User:getLevel()
	}) or g.core.lang:get(112201)))
	self.m_groupLoader:setURL((var_0_4:getCampURL(var_2_1.group, 1)))
	self.m_isMainController:setSelectedIndex(0)

	self._wearArtifact = g.core.model.User.artifactData:getArtifactByPos(self._pos)

	local var_2_3 = false

	if self._wearArtifact then
		var_2_3 = g.core.model.User.artifactData:isRelatedByAdvanceId(self._wearArtifact, self._pos)
	end

	local var_2_4

	if var_2_3 then
		var_2_4 = {
			extraType = 1,
			data = self._wearArtifact
		}
	end

	local var_2_5 = var_2_0:getQuality()
	local var_2_6 = {}

	if var_2_5 <= var_0_12.SSR then
		var_2_6[1] = {
			isPassive = false,
			isActive = true,
			skillId = var_2_1.common_id,
			star = var_2_1.star,
			knightAdvId = var_2_1.advance_id
		}
		var_2_6[2] = {
			isPassive = false,
			isActive = true,
			skillId = var_2_1.active_skill_id,
			star = var_2_1.star,
			knightAdvId = var_2_1.advance_id,
			skillExtraData = var_2_4
		}

		local var_2_7 = var_2_0:getPassiveList()

		if var_2_7.id > 0 then
			var_2_6[3] = {
				isPassive = true,
				skillId = var_2_7.id,
				isActive = var_2_7.isActive,
				star = var_2_1.star,
				knightAdvId = var_2_1.advance_id
			}
		end
	elseif var_2_5 >= var_0_12.UR then
		var_2_6[1] = {
			isPassive = false,
			isActive = true,
			skillId = var_2_1.common_id,
			star = var_2_1.star,
			knightAdvId = var_2_1.advance_id
		}
		var_2_6[2] = {
			isPassive = false,
			isActive = true,
			skillId = var_2_1.active_skill_id,
			star = var_2_1.star,
			knightAdvId = var_2_1.advance_id,
			skillExtraData = var_2_4
		}

		if var_2_1.energy_skill_id then
			table.insert(var_2_6, {
				isPassive = false,
				isActive = true,
				skillId = var_2_1.energy_skill_id,
				star = var_2_1.star,
				knightAdvId = var_2_1.advance_id
			})
		end

		local var_2_8 = var_2_0:getAdvancedPassiveList()

		if var_2_8.id > 0 then
			table.insert(var_2_6, {
				isPassive = true,
				skillId = var_2_8.id,
				isActive = var_2_8.isActive,
				star = var_2_1.star,
				knightAdvId = var_2_1.advance_id
			})
		end
	end

	self.m_skillsComp:updateView(var_2_6)

	local var_2_9, var_2_10 = var_0_11:generateAssDataAndActiveAssCountByKnight(var_2_0)

	self._assList = var_2_9

	self.m_assctComp:initStar({
		index = 1,
		style = 2,
		num = var_2_10,
		max = math.min(#var_2_9, var_0_2.KNIGHT_CONST.ASSCT_ACTIVE_MAX)
	})
	self.m_assctComp:addStarEffect(var_2_10, {
		name = "eff_ui_lineup_bind",
		scale = 1,
		isLoop = true
	})

	if var_0_9:isModuleShow(var_0_3.EQUIP_LINEUP) then
		self.m_showEquipCompController:setSelectedIndex(1)
		self.m_equipComp:updateComp(arg_2_1, arg_2_2)
		self:_checkTickWeakGuide()
	else
		self.m_showEquipCompController:setSelectedIndex(0)
	end

	self._changeAssctTip = true

	var_0_10:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_developBtn,
		customData = {
			advId = var_2_0:getAdvanceId()
		}
	})

	local var_2_11 = var_0_7:getMatchTissueIdByKnight(var_2_1.advance_id)

	if var_2_11 > 0 and var_0_9:isModuleShow(var_0_3.HOME_LAND_KNIGHT_TISSUE) then
		self.m_showKnightTissueController:setSelectedIndex(1)
		var_0_10:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_knightTissueBtn,
			customData = {
				id = var_2_11
			}
		})
	else
		self.m_showKnightTissueController:setSelectedIndex(0)
	end

	self:_checkArtifactComp()
	self:_checkTickWeakGuide()
	self:updateLineUpHaloCount()
end

function LineUpKnightInfoComp:_onClickGroupBtn()
	var_0_8:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new(), {
		touchDisappear = true
	})
end

function LineUpKnightInfoComp:_onClickDevelopBtn()
	self:dispatchCompEvent("COMP_EVENT_ENTER_DEVELOP_LAYER")
	var_0_8:pushModule(g.view.entrance.KNIGHT_DEVELOP, {
		showLiveUpPop = true,
		knightSid = self._knightSid
	})
end

function LineUpKnightInfoComp:_onClickChangeKnightBtn()
	var_0_8:pushModule(g.view.entrance.LINE_UP_CHOOSE, {
		index = self._pos,
		knightSid = self._knightSid
	})
end

function LineUpKnightInfoComp:_onAssctClick()
	var_0_8:pushPopup(require("app.view.module.tip.view.KnightAssctTip").new({
		knightSid = self._knightSid
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function LineUpKnightInfoComp:_onKnightTissueClick()
	local var_7_0 = var_0_7:getMatchTissueIdByKnight((var_0_6:getKnight({
		id = self._knightSid
	}):getAdvanceId()))

	if var_7_0 > 0 then
		self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissueDetailsPop").new({
			info = g.core.config.knight_tissue_info.get(var_7_0)
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	else
		var_0_8:tip(g.core.lang:get(111917))
	end
end

function LineUpKnightInfoComp:_onUrGuideClick()
	var_0_8:pushPopup(require("app.view.module.guide.view.GuideCommonPopup").new({
		group = 1
	}), {
		touchDisappear = true
	})
end

function LineUpKnightInfoComp:_checkTickWeakGuide()
	var_0_10:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)

	local var_9_0, var_9_1 = g.core.model.User.equipmentData:isKnightHasEquip(self._pos)

	if var_9_0 then
		var_0_10:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "EQUIP_STEP_1",
			targetBtn = self.m_equipComp
		})
	end
end

function LineUpKnightInfoComp:showEnterCutTransition()
	self.m_enter_cutTransition:play()
end

function LineUpKnightInfoComp:showEnterTransition()
	self.m_enterTransition:play()
end

function LineUpKnightInfoComp:onUnload()
	var_0_10:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function LineUpKnightInfoComp:_onArtifactBtnClick()
	g.core.sound.SoundManager:playSound("UI_Click_Middle")
	var_0_8:pushModule(g.view.entrance.ARTIFACT_LINE_UP, {
		knightId = self._knightSid,
		knightIndex = self._pos
	})
end

function LineUpKnightInfoComp:_checkArtifactComp()
	local var_14_0 = var_0_9:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT)

	self.m_artifactBtn:setVisible(var_14_0 and true or false)

	if var_14_0 then
		self.m_artifactBtn:updateArtifactEntranceBtn(self._wearArtifact, g.core.model.User.artifactData:isRelatedByAdvanceId(self._wearArtifact, self._pos), self._pos)
	end
end

function LineUpKnightInfoComp:updateLineUpHaloCount()
	local var_15_0, var_15_1 = var_0_11:getCurrentGroupAndCnt()

	self:_updateHaloView(var_15_0, var_15_1)
end

function LineUpKnightInfoComp:_updateHaloView(arg_16_1, arg_16_2)
	arg_16_2 = math.clamp(arg_16_2, 0, 6)

	self.m_haloComp:getChild("lineUpHaloBar"):setFillAmount(arg_16_2 / 6)

	arg_16_1 = arg_16_1 > 0 and arg_16_1 or var_0_5.GROUP_TYPE.LIN_DONG

	local var_16_0 = self.m_haloComp:getChild("haloImg")
	local var_16_1 = var_0_4:getCampURL(arg_16_1, 4)
	local var_16_2 = self.m_haloComp:getChild("effectHolder")

	var_16_2:removeAllEffect()

	if arg_16_2 >= 6 then
		var_16_2:addEffectSpine({
			anim = "play2",
			name = "eff_ui_formation_gain",
			scale = 1,
			isLoop = true
		})

		var_16_1 = var_0_4:getCampActiveURL(arg_16_1)
	elseif arg_16_2 >= 2 then
		var_16_2:addEffectSpine({
			anim = "play1",
			name = "eff_ui_formation_gain",
			scale = 1,
			isLoop = true
		})
	end

	var_16_0:setURL(var_16_1)
end

function LineUpKnightInfoComp:_onClickHaloPopBtn()
	var_0_8:pushPopup(require("app.view.module.lineUp.view.haloPop.LineUpHaloPop").new(), {
		touchDisappear = true
	})
end

return LineUpKnightInfoComp
