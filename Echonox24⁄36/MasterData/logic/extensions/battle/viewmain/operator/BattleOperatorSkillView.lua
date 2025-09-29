-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleOperatorSkillView.lua

module("logic.extensions.battle.viewmain.operator.BattleOperatorSkillView", package.seeall)

local BattleOperatorSkillView = class("BattleOperatorSkillView", ViewComponent)
local kCloseAnimDuaration = 0.2

function BattleOperatorSkillView:buildUI()
	self.mainGO = self:getGoByPath("operateRoot")
	self._enableState = GameObjectVisibleState.New()
	self._goSkillPositions = {}
	self._goLines = {}

	for i = 1, 3 do
		self._goSkillPositions[i] = goutil.findChild(self.mainGO, string.format("skillList/skillPos%s", i))
		self._goLines[i] = goutil.findChild(self.mainGO, string.format("line%s", i))
	end

	local goStrenthening = goutil.findChild(self.mainGO, "strengthSanity")

	self._toggleStrenthening = goutil.addComponentOnce(goStrenthening, UIComponentType.SpaceXToggle)
	self._sanity = UIBattleSkillSanity.New(goStrenthening)
	self._skillBindGo = goutil.findChild(self.mainGO, "skillList/skillTipsBindGo")
	self._btnStandby = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnStandby")
	self._btnAttack = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnAttack")
	self._btnOverdraft = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnOverdraft")
	self._btnRest = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnRest")
	self._goStandby = goutil.findChild(self.mainGO, "btnStandby")
	self._goAttack = goutil.findChild(self.mainGO, "btnAttack")
	self._goOverdraft = goutil.findChild(self.mainGO, "btnOverdraft")
	self._goRest = goutil.findChild(self.mainGO, "btnRest")
	self._goNoneTargetHint = goutil.findChild(self.mainGO, "none_target_hint")
	self._txtOverdraft01 = goutil.findChildTextComponent(self.mainGO, "btnOverdraft/mask_1/Text1")
	self._txtOverdraft02 = goutil.findChildTextComponent(self.mainGO, "btnOverdraft/mask_2/Text1")
	self._animationNegativeChange = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._skillItemCollection = ViewlibCollection:create(ViewlibResPath.BattleUseSkillItem, 5)
	self._skillIconTable = {}
	self._handler = false
	self._unit = false
	self._activeSkillId = false
	self._isSelectTarget = false

	self:setSelectTarget(false)

	self._animControl = BattleAnimationSwitchController.New(self.mainGO)

	self._animControl:setAnimName("battle_main_operate_open", "battle_main_operate_close")

	self._timeWaiter = TimeWaiter.New()
end

function BattleOperatorSkillView:destroyUI()
	self._animControl:destroy()
	self._sanity:destroy()
	self._skillItemCollection:clear()

	self._skillItemCollection = nil
	self._goSkillPositions = nil
	self._goLines = nil
	self._btnStandby = nil
	self._btnAttack = nil
	self._btnOverdraft = nil
	self._toggleStrenthening = nil
	self._goStandby = nil
	self._goAttack = nil
	self._goOverdraft = nil
	self._goNoneTargetHint = nil
	self._txtOverdraft01 = nil
	self._txtOverdraft02 = nil
	self._animationNegativeChange = nil
	self._skillIconTable = nil
	self._skillBindGo = nil
end

function BattleOperatorSkillView:bindEvents()
	self._btnStandby:AddClickListener(self._onClickStandby, self)
	self._btnAttack:AddClickListener(self._onClickNormalAttack, self)
	self._btnOverdraft:AddClickListener(self._onClickOverDraftAttack, self)
	self._toggleStrenthening:AddListener(self._onClickStrenthening, self)
	self._btnRest:AddClickListener(self._onClickStandby, self)
end

function BattleOperatorSkillView:unbindEvents()
	self._btnStandby:RemoveClickListener()
	self._btnAttack:RemoveClickListener()
	self._btnOverdraft:RemoveClickListener()
	self._toggleStrenthening:RemoveListener()
	self._btnRest:RemoveClickListener()
end

function BattleOperatorSkillView:onEnter()
	self:_setEvent(true)
	self:_updateView()
end

function BattleOperatorSkillView:onExit()
	self:_setEvent(false)
	self._enableState:clear()
	self:_clearSkillIcon()
	self:clearOperateUnit()
	self._timeWaiter:clear()
end

function BattleOperatorSkillView:setOperateUnit(unit, handler)
	self:_clearSkillIcon()

	self._unit = unit
	self._handler = handler
	self._toggleStrenthening.IsOn = false

	local skillComp = self._unit.skill

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightNormalSkill, false) then
		goutil.setActive(self._goSkillPositions[1], true)
	else
		goutil.setActive(self._goSkillPositions[1], false)
	end

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSpecialSkill, false) then
		goutil.setActive(self._goSkillPositions[2], true)
	else
		goutil.setActive(self._goSkillPositions[2], false)
	end

	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightTrumpSkill, false) then
		goutil.setActive(self._goSkillPositions[3], true)
	else
		goutil.setActive(self._goSkillPositions[3], false)
	end

	self:_buildSkill(skillComp:getNormalSkill(), 1)
	self:_buildSkill(skillComp:getSpecialSkill(), 2)
	self:_buildSkill(skillComp:getTrumpSkill(), 3)
	self:_playOpenAnim()
	self._sanity:setSanityAndStrengthen(self._unit.property:getSanity(), false)
	self._sanity:hideBoomEffect()
end

function BattleOperatorSkillView:clearOperateUnit()
	self._unit = false
	self._handler = false

	self:_updateNoneTargetState()
end

function BattleOperatorSkillView:setSelectTarget(targetUnionIndex)
	self._isSelectTarget = targetUnionIndex and true or false

	self:_updateConfirmButtonState()
end

function BattleOperatorSkillView:selectSkill(skillId, isStrenthening)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_effect_battle_scope, nil, nil, nil)
	self:_onClickSkillIcon(skillId)

	if self._toggleStrenthening.IsOn ~= isStrenthening then
		self._toggleStrenthening.IsOn = isStrenthening

		self:_onClickStrenthening(_, isStrenthening)
	end
end

function BattleOperatorSkillView:setVisible(visible, key)
	local isPreviewVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	local isCurVisible = self._enableState:isEnable()

	if isCurVisible ~= isPreviewVisible then
		self._timeWaiter:clear()

		if isCurVisible then
			goutil.setActive(self.mainGO, isCurVisible)
			self._animControl:playOpenAnim()
			self:_onVisibleUpdate()
		else
			self._animControl:playCloseAnim()
			self._timeWaiter:start(kCloseAnimDuaration, self._updateVisibleAfterAnim, self)
		end
	end
end

function BattleOperatorSkillView:_updateView()
	self._txtOverdraft01.text = lang("battle_main_overdraft")
	self._txtOverdraft02.text = lang("battle_main_overdraft")
end

function BattleOperatorSkillView:_playOpenAnim()
	self._animControl:playOpenAnim()
end

function BattleOperatorSkillView:_onVisibleUpdate()
	if self._enableState:isEnable() then
		self:_updateConfirmButtonState()
		self:_resetAnimationNegativeChange()

		if self._unit then
			self._sanity:setSanityAndStrengthen(self._unit.property:getSanity(), self._toggleStrenthening.IsOn)
		end
	else
		self._sanity:hideBoomEffect()
	end
end

function BattleOperatorSkillView:_updateVisibleAfterAnim()
	goutil.setActive(self.mainGO, self._enableState:isEnable())
	self:_onVisibleUpdate()
end

function BattleOperatorSkillView:getSelectedSkillId()
	return self._activeSkillId
end

function BattleOperatorSkillView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
		GlobalDispatcher:addEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
	end
end

function BattleOperatorSkillView:_onForecastResultUpdate(forecastResult)
	if not self._unit then
		return
	end

	self:_updateSkillState()
	self:_updateConfirmButtonState()
end

function BattleOperatorSkillView:_onSettingContentChanged(evt, key)
	if key == SettingConst.kNoneTarget then
		self:_updateNoneTargetState()
	end
end

function BattleOperatorSkillView:_updateNoneTargetState()
	local isNoneTargetOn = PlayerLocalStorageModel.instance:getNoneTarget()

	goutil.setActive(self._goNoneTargetHint, isNoneTargetOn and self._unit and not self._isSelectTarget)
end

function BattleOperatorSkillView:_onClickStandby()
	if self._handler then
		self._handler:onClickStandby()
	end
end

function BattleOperatorSkillView:_onClickOverDraftAttack()
	BattleAudioUtil.playSEByName("ui_battle_mishi")
	self:_onClickAttack()
end

function BattleOperatorSkillView:_onClickNormalAttack()
	BattleAudioUtil.playSEByName("ui_battle_querenshifang")
	self:_onClickAttack()
end

function BattleOperatorSkillView:_onClickAttack()
	if self._handler then
		self._handler:onClickAttack()
	end
end

function BattleOperatorSkillView:_onClickStrenthening(toggle, isOn)
	local settingModel = BattleMgr.instance:getSettingModel()

	if isOn and settingModel:isForbiddenSanityStrengthen() then
		FloatWordMgr.instance:show(lang("tip_battle_forbidden_skill_upgrade"))

		self._toggleStrenthening.IsOn = false

		return
	end

	if not self._unit then
		return
	end

	for _, skillItem in pairs(self._skillIconTable) do
		skillItem:setStrenthening(isOn)
	end

	self._sanity:setSanityAndStrengthen(self._unit.property:getSanity(), isOn)

	if isOn then
		self._sanity:_showBoomEffect(self._unit.property:getSanity())
	end

	self:_playSanityStrengthenVoice(isOn, self._unit.property:getSanity())

	if self._activeSkillId and self._handler then
		self._handler:onClickStrenthening(isOn)
	end

	BattleMainViewFacade.instance:closeUnitInfoExpandPanel()
end

function BattleOperatorSkillView:_playSanityStrengthenVoice(isStrengthening, sanity)
	if isStrengthening then
		if sanity == 1 then
			CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_san_1_burst, nil, nil, nil)
		elseif sanity == 0 then
			CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_san_0_burst, nil, nil, nil)
		elseif sanity == -1 then
			CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_san_minus1_burst, nil, nil, nil)
		end
	else
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_overdraftclick, nil, nil, nil)
	end
end

function BattleUnitUtil.isForbiddenSkill(skillMO)
	local settingModel = BattleMgr.instance:getSettingModel()

	if settingModel:isSkillForbiddenByType(skillMO:getCategory()) then
		return true, BattleEnum.ForbidAction.SkillByType
	end

	if settingModel:isSkillForbiddenByPurpose(skillMO:getPurpose()) then
		return true, BattleEnum.ForbidAction.SkillByPurpose
	end
end

function BattleOperatorSkillView:_onTruelyClickSkillIcon(skillId, skillItem)
	if self._activeSkillId == skillId then
		skillItem:showTips()
	end

	BattleAudioUtil.playSEByName("ui_battle_skillselect")
	self:_onClickSkillIcon(skillId)
end

function BattleOperatorSkillView:_onClickSkillIcon(skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if not self._unit then
		return
	end

	local isActiveSkill = ActiveSkillCOUtil.isActiveSkill(skillCOWrapper, self._unit.skill:getSkillStatus())

	if not isActiveSkill then
		if BattleLog.enableWarn then
			BattleLog.warn("skill[%s] is not a active skill", tostring(skillId))
		end

		return
	end

	local isSkillEnable = self._unit.skill:isSkillEnable(skillId)

	if not isSkillEnable then
		local skillMO = self._unit.skill:getActiveSkillById(skillId)

		if skillMO then
			local isForbidden, reason = BattleUnitUtil.isForbiddenSkill(skillMO)

			if isForbidden then
				if reason == BattleEnum.ForbidAction.SkillByType then
					FloatWordMgr.instance:show(string.format(lang("tip_battle_forbidden_skill_type"), lang(string.format("tip_battle_skill_type_%d", skillMO:getCategory()))))
				end

				if reason == BattleEnum.ForbidAction.SkillByPurpose then
					FloatWordMgr.instance:show(string.format(lang("tip_battle_forbidden_skill_purpose"), lang(string.format("tip_battle_skill_purpose_%d", skillMO:getPurpose()))))
				end
			end
		end

		if BattleLog.enableWarn then
			BattleLog.warn("skill[%s] is not enable", tostring(skillId))
		end

		return
	end

	self._sanity:onSkillChange(skillCOWrapper:getSkillType(false))

	if self._activeSkillId then
		local skillIcon = self._skillIconTable[self._activeSkillId]

		skillIcon:unselectIcon()
	end

	if self._activeSkillId ~= skillId then
		BattleMainViewFacade.instance:closeUnitInfoExpandPanel()
	end

	self._activeSkillId = skillId

	local isPositive = self:_getSanityState()
	local skillIcon = self._skillIconTable[self._activeSkillId]

	skillIcon:selectIcon(isPositive)
	self:_updateConfirmButtonState()

	if self._handler then
		self._handler:onSelectSkill(skillId, self._toggleStrenthening.IsOn)
	end
end

function BattleOperatorSkillView:_updateConfirmButtonState()
	self:_updateNoneTargetState()

	local skillIcon = self._skillIconTable[self._activeSkillId]

	if not self._isSelectTarget or not self._activeSkillId then
		if false then
			goutil.setActive(self._goRest, true)
			goutil.setActive(self._goStandby, false)
		else
			goutil.setActive(self._goStandby, true)
			goutil.setActive(self._goRest, false)
		end

		goutil.setActive(self._goAttack, false)
		goutil.setActive(self._goOverdraft, false)
		self:_resetAnimationNegativeChange()

		return
	end

	local skillMO = self._unit.skill:getActiveSkillById(self._activeSkillId)
	local sanityConsume = self._toggleStrenthening.IsOn and 1 or 0
	local willSanityDead = self:_willSanityDead(sanityConsume)

	if willSanityDead then
		goutil.setActive(self._goOverdraft, true)
		goutil.setActive(self._goAttack, false)
		goutil.setActive(self._goStandby, false)
		goutil.setActive(self._goRest, false)
		self:_playAnimationNegativeChange()
	else
		goutil.setActive(self._goAttack, true)
		goutil.setActive(self._goOverdraft, false)
		goutil.setActive(self._goStandby, false)
		goutil.setActive(self._goRest, false)
	end

	local goLine = self._goLines[skillIcon:getPositionIndex()]

	goutil.setActive(goLine, true)
end

function BattleOperatorSkillView:_playAnimationNegativeChange()
	return
end

function BattleOperatorSkillView:_resetAnimationNegativeChange()
	return
end

function BattleOperatorSkillView:_getSanityState()
	if self._unit.property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		return self._unit.property:getSanity() >= 0
	end

	return true
end

function BattleOperatorSkillView:_willSanityDead(costSanity)
	if self._unit.property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		local currentSanity = self._unit.property:getSanity()

		return currentSanity >= -1 and currentSanity - costSanity < -1
	end

	return false
end

function BattleOperatorSkillView:_inactiveAllLine()
	for _, goLine in pairs(self._goLines) do
		goutil.setActive(goLine, false)
	end
end

function BattleOperatorSkillView:_buildSkill(skillMO, posIndex)
	if skillMO and skillMO:isValid() then
		local isSkillEnable = self._unit.skill:isSkillEnable(skillMO:getSkillId())
		local isSkillUnlock = self._unit.skill:isSkillUnlock(skillMO:getSkillId())
		local isInCd = skillMO:hasCd()
		local goSkillPosition = self._goSkillPositions[posIndex]
		local skillItem = self._skillItemCollection:createInstance(goSkillPosition)

		skillItem:setListener(self._onTruelyClickSkillIcon, self)
		skillItem:setPositionIndex(posIndex)
		skillItem:setSkillMO(self._unit.property:getEntityCode(), self._unit.property:getEntityId(), skillMO)
		skillItem:setBindGo(self._skillBindGo)
		skillItem:setEnable(isInCd, isSkillEnable, isSkillUnlock)

		self._skillIconTable[skillMO:getSkillId()] = skillItem
	end
end

function BattleOperatorSkillView:_updateSkillState()
	if not self._unit then
		return
	end

	for _, skillItem in pairs(self._skillIconTable) do
		local skillId = skillItem:getSkillId()
		local skillMO = self._unit.skill:getActiveSkillById(skillId)
		local isSkillEnable = self._unit.skill:isSkillEnable(skillMO:getSkillId())
		local isSkillUnlock = self._unit.skill:isSkillUnlock(skillMO:getSkillId())
		local isInCd = skillMO:hasCd()

		skillItem:setEnable(isInCd, isSkillEnable, isSkillUnlock)
	end
end

function BattleOperatorSkillView:_clearSkillIcon()
	self._activeSkillId = false

	self._skillItemCollection:clearAllInstance()
	BattleTableUtil.clearTable(self._skillIconTable)
end

return BattleOperatorSkillView
