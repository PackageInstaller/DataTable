-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/propertycompare/BattlePropertyCompareView.lua

module("logic.extensions.battle.viewmain.propertycompare.BattlePropertyCompareView", package.seeall)

local BattlePropertyCompareView = class("BattlePropertyCompareView", ViewComponent)
local kDefaultKey = "BattlePropertyCompareView"
local kEmptyCompareString = "-"
local kDamageCompareString = "tip_hurt"
local kBattleDamageScrollTime = 0.2
local kCloseAnimDuaration = 0.1

function BattlePropertyCompareView:buildUI()
	self._rootGo = self.mainGO
	self._compareRootGo = self:getGoByPath("compareRoot")
	self.mainGO = self:getGoByPath("compareRoot/panel")
	self._enableState = GameObjectVisibleState.New()
	self._rectTran = goutil.addComponentOnce(self.mainGO, UIComponentType.RectTransform)
	self._leftUnitView = BattlePropertyCompareUnitInfo.New(goutil.findChild(self.mainGO, "leftContent/info1"), true)
	self._rightUnitView = BattlePropertyCompareUnitInfo.New(goutil.findChild(self.mainGO, "rightContent/info1"), false)

	self._leftUnitView:setDeadSign(goutil.findChild(self.mainGO, "leftContent/deadSign_L"), goutil.findChild(self.mainGO, "leftContent/expendedSign_L"))
	self._rightUnitView:setDeadSign(goutil.findChild(self.mainGO, "rightContent/deadSign_R"), goutil.findChild(self.mainGO, "rightContent/expendedSign_R"))

	self._normalDamageGo = goutil.findChild(self.mainGO, "hurtInfo/hint1")
	self._counteredDamageGo = goutil.findChild(self.mainGO, "hurtInfo/hint2")
	self._txtLeftDamage = UIEffectUtil.getChildTextRollingEffect(self._normalDamageGo, "hurt1/txtHint/txtHurtNum")
	self._goLeftDamageCritical = goutil.findChild(self._normalDamageGo, "hurt1/txtHint/imgCritical1")
	self._goLeftDamageSanityCritical = goutil.findChild(self._normalDamageGo, "hurt1/txtHint/imgCritical2")
	self._txtRightDamage = UIEffectUtil.getChildTextRollingEffect(self._normalDamageGo, "hurt2/txtHint/txtHurtNum")
	self._goRightDamageCritical = goutil.findChild(self._normalDamageGo, "hurt2/txtHint/imgCritical1")
	self._goRightDamageSanityCritical = goutil.findChild(self._normalDamageGo, "hurt2/txtHint/imgCritical2")
	self._leftNumberHintGo = goutil.findChild(self._normalDamageGo, "hurt1")
	self._rightNumberHintGo = goutil.findChild(self._normalDamageGo, "hurt2")
	self._goLeftCritical = goutil.findChild(self._normalDamageGo, "hurt1/critical1")
	self._goRightCritical = goutil.findChild(self._normalDamageGo, "hurt2/critical1")
	self._goLeftSanityCritical = goutil.findChild(self._normalDamageGo, "hurt1/critical2")
	self._goRightSanityCritical = goutil.findChild(self._normalDamageGo, "hurt2/critical2")
	self._txtCounteredLeftDamage = UIEffectUtil.getChildTextRollingEffect(self._counteredDamageGo, "hurt1/txtHint/txtHurtNum")
	self._txtCounteredRightDamage = UIEffectUtil.getChildTextRollingEffect(self._counteredDamageGo, "hurt2/txtHint/txtHurtNum")
	self._goCounteredLeftDamageCritical = goutil.findChild(self._counteredDamageGo, "hurt1/txtHint/imgCritical1")
	self._goCounteredLeftDamageSanityCritical = goutil.findChild(self._counteredDamageGo, "hurt1/txtHint/imgCritical2")
	self._goCounteredRightDamageCritical = goutil.findChild(self._counteredDamageGo, "hurt2/txtHint/imgCritical1")
	self._goCounteredRightDamageSanityCritical = goutil.findChild(self._counteredDamageGo, "hurt2/txtHint/imgCritical2")
	self._counteredLeftNumberHintGo = goutil.findChild(self._counteredDamageGo, "hurt1")
	self._counteredRightNumberHintGo = goutil.findChild(self._counteredDamageGo, "hurt2")
	self._goCounteredLeftCritical = goutil.findChild(self._counteredDamageGo, "hurt1/critical1")
	self._goCounteredRightCritical = goutil.findChild(self._counteredDamageGo, "hurt2/critical1")
	self._goCounteredLeftSanityCritical = goutil.findChild(self._counteredDamageGo, "hurt1/critical2")
	self._goCounteredRightSanityCritical = goutil.findChild(self._counteredDamageGo, "hurt2/critical2")
	self._goLeftCuredPanel = goutil.findChild(self.mainGO, "hurtInfo/cure")
	self._txtLeftCured = UIEffectUtil.getChildTextRollingEffect(self.mainGO, "hurtInfo/cure/txtHint/txtHurtNum")
	self._goCuredSign = goutil.findChild(self.mainGO, "hurtInfo/cure/imgHurt")
	self._goLeftHint1 = goutil.findChild(self.mainGO, "leftContent/infoHint1")
	self._goLeftHint2 = goutil.findChild(self.mainGO, "leftContent/infoHint2")
	self._goRightHint1 = goutil.findChild(self.mainGO, "rightContent/infoHint1")
	self._goRightHint2 = goutil.findChild(self.mainGO, "rightContent/infoHint2")
	self._goLeftRestrainPanelGo = goutil.findChild(self.mainGO, "leftContent/infoHint1/signHint")
	self._goRightRestrainPanelGo = goutil.findChild(self.mainGO, "rightContent/infoHint1/signHint")
	self._goLeftRestrainSign = goutil.findChild(self.mainGO, "leftContent/infoHint1/signHint/imgArrowsUp")
	self._goLeftBeRestrainSign = goutil.findChild(self.mainGO, "leftContent/infoHint1/signHint/imgArrowsDown")
	self._goRightRestrainSign = goutil.findChild(self.mainGO, "rightContent/infoHint1/signHint/imgArrowsUp")
	self._goRightBeRestrainSign = goutil.findChild(self.mainGO, "rightContent/infoHint1/signHint/imgArrowsDown")
	self._leftTagTxt = goutil.findChildComponent(self.mainGO, "leftContent/infoHint1/txtDec", UIComponentType.TMPText)
	self._leftTagBtn = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "leftContent/infoHint1/txtDec").gameObject)
	self._rightTagTxt = goutil.findChildComponent(self.mainGO, "rightContent/infoHint1/txtDec", UIComponentType.TMPText)
	self._goLeftTipsHolder = goutil.findChild(self.mainGO, "leftContent/infoHint1/txtDec/tagTipsholder")
	self._goRightTipsHolder = goutil.findChild(self.mainGO, "rightContent/infoHint1/txtDec/tagTipsholder")
	self._rightTagBtn = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "rightContent/infoHint1/txtDec").gameObject)
	self._goPunishmentLeft = goutil.findChild(self.mainGO, "leftContent/infoHint2/txtPunishment")
	self._goPunishmentRight = goutil.findChild(self.mainGO, "rightContent/infoHint2/txtPunishment")
	self._weakPoint = UIBattleWeakPoint.New(goutil.findChild(self.mainGO, "rightContent/weak/weakSlider/Handle Slide Area/Handle/weak_fill"), goutil.findChild(self.mainGO, "rightContent/weak/weak_fill2"))

	self._weakPoint:setVisibleCallBack(self._onWeakpointVisibleUpdate, self)

	self._weakPointPanelGo = goutil.findChild(self.mainGO, "rightContent/weak")
	self._leftWeakGo = goutil.findChild(self.mainGO, "leftContent/weak")
	self._weakPointSlider = UIComponentType.SliderAdapter(goutil.findChild(self.mainGO, "rightContent/weak/weakSlider"))
	self._doubleHarmSignGo = goutil.findChild(self.mainGO, "leftContent/infoHint2/txtMoreHarm")

	self._weakPoint:setVisible(false)

	self._isNeedShowCompareView = false
	self._leftCrticalTimelineTask = TimelineTask.New()
	self._rightCrticalTimelineTask = TimelineTask.New()
	self._compareAnim = self._compareRootGo:GetComponent(ComponentType.Animation)
	self._animEventListener = Astral.AnimationEventListener.Get(self._compareRootGo)
	self._timeWaiter = TimeWaiter.New()
end

function BattlePropertyCompareView:destroyUI()
	self._weakPoint:destroy()
	self._leftUnitView:destroy()
	self._rightUnitView:destroy()

	self._weakPoint = nil
	self._leftUnitView = nil
	self._rightUnitView = nil
	self._txtLeftDamage = nil
	self._txtRightDamage = nil
	self._imgLeftSign = nil
	self._imgRightSign = nil
	self._goLeftCritical = nil
	self._goRightCritical = nil
	self._goPunishmentLeft = nil
	self._rootGo = nil
	self._rectTran = nil

	self._leftCrticalTimelineTask:clear()
	self._rightCrticalTimelineTask:clear()
end

function BattlePropertyCompareView:bindEvents()
	self._leftTagBtn:AddClickListener(self._onClickLeftTag, self)
	self._rightTagBtn:AddClickListener(self._onClickRightTag, self)
	self._animEventListener:AddListener(self._dealAnimEvent, self)
end

function BattlePropertyCompareView:unbindEvents()
	self._leftTagBtn:RemoveClickListener()
	self._rightTagBtn:RemoveClickListener()
	self._animEventListener:RemoveListener()
end

function BattlePropertyCompareView:onEnter()
	self._leftTagList = {}
	self._rightTagList = {}
	self._isFirstForecast = true

	self:_setEvent(true)
	self:_onBattleSpeedUpdate()
end

function BattlePropertyCompareView:onExit()
	BattleTableUtil.clearTable(self._leftTagList)
	BattleTableUtil.clearTable(self._rightTagList)

	if self._tweener then
		self._tweener:Kill(false)

		self._tweener = nil
	end

	self:_setEvent(false)
	self._enableState:clear()
	self._timeWaiter:clear()

	self._fromWeakPoint = false
	self._toWeakPoint = false
	self._curWeakPoint = false
	self._dWeakPoint = false
end

function BattlePropertyCompareView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
	end
end

function BattlePropertyCompareView:_onForecastResultUpdate(evt, forecastResult)
	if not self._isNeedShowCompareView then
		return
	end

	self:showCompareView(forecastResult)
end

function BattlePropertyCompareView:showCompareView(forecastResult)
	self._isNeedShowCompareView = true

	self:_updateCompareView(forecastResult)
end

function BattlePropertyCompareView:_updateCompareView(forecastResult)
	if not forecastResult.isValid then
		return
	end

	if self._forecastKey == forecastResult.forecastKey then
		return
	end

	DG.Tweening.DOTween.Kill(self.mainGO, true)
	self:_clearDownVisible()

	self._forecastKey = forecastResult.forecastKey

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(forecastResult.attackerEntityInfo.entityId)
	local victim = unitMgr:getUnit(forecastResult.victimEntityInfo.entityId)

	self._victim = victim

	if not victim then
		self:setVisible(false)

		return
	end

	local isSelfTarget = BattleSkillAssist.isSelfTargetSkill(forecastResult.skillId, attacker.skill:getSkillStatus())

	if isSelfTarget then
		self:setVisible(false)

		return
	end

	BattleMainViewFacade.instance:showRole(attacker.property:getModelCode(), attacker, "CompareView", true)
	self:setVisible(true)

	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(victim.property:getCampId())
	local isDamage = forecastResult.isDamage

	self._leftUnitView:updateView(forecastResult.attackerEntityInfo, isDamage, self._isFirstForecast)
	self._rightUnitView:updateView(forecastResult.victimEntityInfo, isDamage, self._isFirstForecast)
	self:_updateWeakPoint(victim, forecastResult, self._isFirstForecast)
	goutil.setActive(self._goPunishmentLeft, forecastResult.isNear)
	goutil.setActive(self._goPunishmentRight, forecastResult.counteredNear)

	if forecastResult.isNear then
		self._leftLayer2Status = true
	end

	if forecastResult.counteredNear then
		self._rightLayer2Status = true
	end

	local counterBeforeAttack = forecastResult.counterBeforeAttack
	local isCountered = forecastResult.isCountered
	local isCritical = forecastResult.isCritical
	local counteredCritically = forecastResult.counteredCritically
	local attackSanity = forecastResult.attackerEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)
	local attackCurSanity = attacker.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	if not attackSanity and attackCurSanity then
		attackSanity = -2
	end

	local victimSanity = forecastResult.victimEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	self:_updateExchangeVisible(forecastResult, attacker)
	self:_updateCompareViewCritic(counterBeforeAttack, isDamage, attackSanity, victimSanity, isCritical, counteredCritically, isCountered)
	self:_updateCompareViewRestrain(attacker, victim, isDamage)
	self:_updateCompareTxt(forecastResult, isDamage, isCountered)
	self:_updateTagTxt(forecastResult)
	self:_setDownVisible()
	self:_doSanityPreview(attackSanity)

	self._isFirstForecast = false
end

function BattlePropertyCompareView:_clearDownVisible()
	self._leftLayer1Status = false
	self._leftLayer2Status = false
	self._rightLayer1Status = false
	self._rightLayer2Status = false
end

function BattlePropertyCompareView:_setDownVisible()
	goutil.setActive(self._goLeftHint1, self._leftLayer1Status)
	goutil.setActive(self._goLeftHint2, self._leftLayer2Status)
	goutil.setActive(self._goRightHint1, self._rightLayer1Status)
	goutil.setActive(self._goRightHint2, self._rightLayer2Status)
end

function BattlePropertyCompareView:_updateCompareTxt(forecastResult, isDamage, isCountered)
	local counterBeforeAttack = forecastResult.counterBeforeAttack
	local txtLeftDamage = counterBeforeAttack and self._txtCounteredLeftDamage or self._txtLeftDamage
	local txtRightDamage = counterBeforeAttack and self._txtCounteredRightDamage or self._txtRightDamage
	local leftDamageHp = forecastResult.attackerOutputValue
	local rightDamageHp = forecastResult.victimOutputValue

	if isCountered then
		self:_updateDamageTxt(false, leftDamageHp, not self._isFirstForecast, txtLeftDamage)
		self:_updateDamageTxt(false, rightDamageHp, false, txtRightDamage)
	elseif isDamage then
		self:_updateDamageTxt(false, leftDamageHp, not self._isFirstForecast, txtLeftDamage)
		self:_updateDamageTxt(true, false, false, txtRightDamage)
	else
		self:_updateDamageTxt(false, leftDamageHp, false, self._txtLeftCured)
	end
end

function BattlePropertyCompareView:_updateDamageTxt(isEmpty, damageValue, needRoll, rollEffect)
	if isEmpty then
		goutil.setActive(rollEffect.mainGO, false)
	else
		goutil.setActive(rollEffect.mainGO, true)

		if needRoll then
			rollEffect:rollToValue(damageValue, kBattleDamageScrollTime, true)
		else
			rollEffect:setValue(damageValue)
		end
	end
end

function BattlePropertyCompareView:_updateTagTxt(forecastResult)
	BattleTableUtil.clearTable(self._leftTagList)
	BattleTableUtil.clearTable(self._rightTagList)

	local attackerStr = ""
	local victimStr = ""
	local attackerId = forecastResult.attackerEntityInfo.entityId
	local victimId = forecastResult.victimEntityInfo.entityId
	local maxCount = self._hasRestrain and 2 or 3
	local attakerCount = 0
	local victimCount = 0

	for i, tagNO in ipairs(forecastResult.tags) do
		if tagNO.entity == attackerId then
			local tagStr = self:_getTagStr(tagNO.tag)

			if tagStr then
				local constCO = BattleConfig.instance:getBattleConstCO(tagNO.tag)

				table.insert(self._leftTagList, constCO.numValue)

				if attakerCount < maxCount then
					attakerCount = attakerCount + 1

					local connectStr = self:_getTagConnect(true)

					attackerStr = string.format("%s%s%sx%d", attackerStr, connectStr, tagStr, tagNO.count)
				end
			end
		elseif tagNO.entity == victimId then
			local tagStr = self:_getTagStr(tagNO.tag)

			if tagStr then
				local constCO = BattleConfig.instance:getBattleConstCO(tagNO.tag)

				table.insert(self._rightTagList, constCO.numValue)

				if victimCount < maxCount then
					victimCount = victimCount + 1

					local connectStr = self:_getTagConnect(false)

					victimStr = string.format("%s%s%sx%d", victimStr, connectStr, tagStr, tagNO.count)
				end
			end
		end
	end

	self._leftTagTxt.text = attackerStr
	self._rightTagTxt.text = victimStr

	if attakerCount > 0 then
		self._leftLayer1Status = true
	end

	if victimCount > 0 then
		self._rightLayer1Status = true
	end
end

function BattlePropertyCompareView:_getTagConnect(isLeft)
	return "  "
end

function BattlePropertyCompareView:_getTagStr(tag)
	local constCO = BattleConfig.instance:getBattleConstCO(tag)

	if not constCO then
		printError("战斗杂项表没有tag对应的标准标签:", tag)

		return
	end

	local tagId = constCO.numValue
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

	if tagCO then
		local icon = ActiveSkillConfig.instance:getTagIconName(tagCO.typeName)

		return string.format("<sprite name=\"%s\">%s", icon, tagCO.name)
	end
end

function BattlePropertyCompareView:_onWeakpointVisibleUpdate(status)
	goutil.setActive(self._weakPointPanelGo, status)
	goutil.setActive(self._leftWeakGo, status)
end

function BattlePropertyCompareView:_onClickLeftTag()
	if #self._leftTagList == 0 then
		return
	end

	ToolTipsMgr.showSkillBuffTagSideTipsWithCodes({}, self._leftTagList, self._goLeftTipsHolder, false, UnityEngine.TextAnchor.LowerLeft, CommEnum.TipsAlignType.Up)
end

function BattlePropertyCompareView:_onClickRightTag()
	if #self._rightTagList == 0 then
		return
	end

	ToolTipsMgr.showSkillBuffTagSideTipsWithCodes({}, self._rightTagList, self._goRightTipsHolder, false, UnityEngine.TextAnchor.LowerLeft, CommEnum.TipsAlignType.Up)
end

function BattlePropertyCompareView:_updateCompareViewRestrain(attacker, victim, isDamage)
	local restrainRelationLeft, restrainRelationRight = BattleConfig.instance:getColorRestrainRelation(attacker.property:getColorType(), victim.property:getColorType())

	if not isDamage then
		restrainRelationLeft = BattleEnum.Restrain.NONE
		restrainRelationRight = BattleEnum.Restrain.NONE
	end

	goutil.setActive(self._goLeftRestrainSign, restrainRelationLeft == BattleEnum.Restrain.RESTRAIN)
	goutil.setActive(self._goLeftBeRestrainSign, restrainRelationLeft == BattleEnum.Restrain.BE_RESTRAIN)
	goutil.setActive(self._goRightRestrainSign, restrainRelationRight == BattleEnum.Restrain.RESTRAIN)
	goutil.setActive(self._goRightBeRestrainSign, restrainRelationRight == BattleEnum.Restrain.BE_RESTRAIN)
	goutil.setActive(self._goLeftRestrainPanelGo, restrainRelationLeft ~= BattleEnum.Restrain.NONE)
	goutil.setActive(self._goRightRestrainPanelGo, restrainRelationRight ~= BattleEnum.Restrain.NONE)

	self._hasRestrain = restrainRelationLeft == BattleEnum.Restrain.RESTRAIN or restrainRelationLeft == BattleEnum.Restrain.BE_RESTRAIN

	if self._hasRestrain then
		self._leftLayer1Status = true
		self._rightLayer1Status = true
	end
end

function BattlePropertyCompareView:_updateExchangeVisible(forecastResult, attacker)
	local isDamage = forecastResult.isDamage
	local counterBeforeAttack = forecastResult.counterBeforeAttack
	local leftHintGo = counterBeforeAttack and self._counteredLeftNumberHintGo or self._leftNumberHintGo
	local rightHintGo = counterBeforeAttack and self._counteredRightNumberHintGo or self._rightNumberHintGo
	local isMark = BattleSkillAssist.isMark(forecastResult.skillId, attacker.skill:getSkillStatus())
	local leftDamage = forecastResult.attackerOutputValue
	local isStatusUpdateMark = isMark and leftDamage == 0

	if isDamage or isStatusUpdateMark then
		goutil.setActive(self._normalDamageGo, not counterBeforeAttack)
		goutil.setActive(self._counteredDamageGo, counterBeforeAttack)
		goutil.setActive(self._goLeftCuredPanel, false)
	else
		goutil.setActive(self._normalDamageGo, false)
		goutil.setActive(self._counteredDamageGo, false)
		goutil.setActive(self._goLeftCuredPanel, true)
	end

	local isCountered = forecastResult.isCountered

	goutil.setActive(rightHintGo, isCountered)
	goutil.setActive(leftHintGo, not isStatusUpdateMark)
end

function BattlePropertyCompareView:_updateCompareViewCritic(counterBeforeAttack, isDamage, attackSanity, victimSanity, isCritical, counteredCritically, isCountered)
	if isDamage then
		local goLeftCritical = counterBeforeAttack and self._goCounteredLeftCritical or self._goLeftCritical
		local goRightCritical = counterBeforeAttack and self._goCounteredRightCritical or self._goRightCritical
		local goSanityLeftCritical = counterBeforeAttack and self._goCounteredLeftSanityCritical or self._goLeftSanityCritical
		local goSanityRightCritical = counterBeforeAttack and self._goCounteredRightSanityCritical or self._goRightSanityCritical
		local goLeftDamageCritical = counterBeforeAttack and self._goCounteredLeftDamageCritical or self._goLeftDamageCritical
		local goRightDamageCritical = counterBeforeAttack and self._goCounteredRightDamageCritical or self._goRightDamageCritical
		local goLeftDamageSanityCritical = counterBeforeAttack and self._goCounteredLeftDamageSanityCritical or self._goLeftDamageSanityCritical
		local goRightDamageSanityCritical = counterBeforeAttack and self._goCounteredRightDamageSanityCritical or self._goRightDamageSanityCritical

		goutil.setActive(goLeftCritical, isCritical)
		goutil.setActive(goLeftDamageCritical, isCritical)
		goutil.setActive(goRightCritical, counteredCritically)
		goutil.setActive(goRightDamageCritical, counteredCritically)

		local isSanityCritical = victimSanity and victimSanity < 0

		goutil.setActive(goSanityLeftCritical, isSanityCritical)
		goutil.setActive(goLeftDamageSanityCritical, isSanityCritical)

		if isSanityCritical then
			goutil.setActive(goLeftCritical, false)
			goutil.setActive(goLeftDamageCritical, false)
		end

		isSanityCritical = attackSanity and attackSanity < 0

		if isCountered and isSanityCritical then
			goutil.setActive(goSanityRightCritical, true)
			goutil.setActive(goRightCritical, false)
			goutil.setActive(goRightDamageSanityCritical, true)
			goutil.setActive(goRightDamageCritical, false)
		else
			goutil.setActive(goSanityRightCritical, false)
			goutil.setActive(goRightDamageSanityCritical, false)
		end
	end
end

function BattlePropertyCompareView:hideCompareView(setAtOnce)
	self._isFirstForecast = true
	self._isNeedShowCompareView = false

	self:_stopSanityPreview()
	self:setVisible(false, false, setAtOnce)

	self._forecastKey = false

	BattleMainViewFacade.instance:setRoleVisible(false, "CompareView")
end

function BattlePropertyCompareView:setVisible(visible, key, setAtOnce)
	local isPreviewVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	local isCurVisible = self._enableState:isEnable()

	if isCurVisible ~= isPreviewVisible then
		if not isCurVisible and setAtOnce then
			self:_updateVisibleAfterAnim()
		else
			self._timeWaiter:clear()

			if isCurVisible then
				goutil.setActive(self._compareRootGo, isCurVisible)
				self._compareAnim:Stop()
				self._compareAnim:Play("battle_main_compareroot_open")
				self:_updateVisibleAfterAnim()
			else
				self._compareAnim:Stop()
				self._compareAnim:Play("battle_main_compareroot_close")
				self._timeWaiter:start(kCloseAnimDuaration, self._updateVisibleAfterAnim, self)
			end
		end
	end

	if not self._enableState:isEnable() then
		self._leftUnitView:clearSanityView()
	end

	BattleBossPropertyFacade.instance:setVisible(not visible, kDefaultKey)
end

function BattlePropertyCompareView:_onVisibleUpdate()
	BattleMainViewFacade.instance:setForCompareOpen(self._enableState:isEnable(), "BattlePropertyCompareView")
	BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, self._enableState:isEnable(), "propertyCompare")

	if not self._enableState:isEnable() then
		self._leftUnitView:clearSanityView()
	end
end

function BattlePropertyCompareView:_updateVisibleAfterAnim()
	goutil.setActive(self._compareRootGo, self._enableState:isEnable())
	self:_onVisibleUpdate()
end

function BattlePropertyCompareView:_doSanityPreview(toSanity)
	if not toSanity then
		return
	end

	self._leftUnitView:doSanityPreview(toSanity)
end

function BattlePropertyCompareView:_stopSanityPreview()
	self._leftUnitView:stopSanityPreview()
end

function BattlePropertyCompareView:_onBattleSpeedUpdate()
	self._leftUnitView:setPlaySpeed(BattleTime.timeScale)
	self._rightUnitView:setPlaySpeed(BattleTime.timeScale)
end

function BattlePropertyCompareView:_dealAnimEvent(animationEvent, name)
	local param = animationEvent.stringParameter

	if param == "startScrollBlood" then
		self:_playScroll()
	end
end

function BattlePropertyCompareView:_updateWeakPoint(victim, forecastResult, playAnimation)
	local isShowDoubleHarm = false
	local isShowWeakPoint = victim.property:isShowWeakPoint()

	self._hasWeakPointScroll = isShowWeakPoint and playAnimation

	if isShowWeakPoint then
		self._weakPoint:setVisible(true)
		self._weakPoint:updateBaseInfo(victim)

		local weakPointHp = forecastResult.victimEntityInfo:getAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP)
		local maxHp = victim.property:getWeakPointMaxHp()

		if playAnimation then
			local curWeakPointHp = victim.property:getWeakPointHp()

			self._fromWeakPoint = curWeakPointHp / maxHp
			self._toWeakPoint = weakPointHp / maxHp
			self._toWeakPointHp = weakPointHp
			self._dWeakPoint = self._toWeakPoint - self._fromWeakPoint
			self._curWeakPoint = self._fromWeakPoint

			self._weakPointSlider:SetValue(self._fromWeakPoint)
		else
			self._weakPoint:forecast(victim, weakPointHp)
			self._weakPointSlider:SetValue(math.max(0, weakPointHp / maxHp))
		end

		local maxHp = victim.property:getWeakPointMaxHp()

		if victim.property:isWeakPointBroken() then
			isShowDoubleHarm = true
			self._leftLayer2Status = true
		end
	else
		self._weakPoint:setVisible(false)
	end

	goutil.setActive(self._doubleHarmSignGo, isShowDoubleHarm)
end

function BattlePropertyCompareView:_playScroll()
	local tTime = 0.5
	local lastP = 0

	self:_startPlayScroll()

	self._tweener = DoTweenUtil.To(0, 1, tTime, function(p)
		local dp = p - lastP

		lastP = p

		self:_onPlayScroll(dp)
	end)

	self._tweener:OnComplete(function()
		self:_onScrollComplete()
	end)
	self._tweener:SetTarget(self.mainGO)
end

function BattlePropertyCompareView:_startPlayScroll()
	self._leftUnitView:startPlayScroll()
	self._rightUnitView:startPlayScroll()

	if self._hasWeakPointScroll then
		self._weakPoint:startWeakPointFillScroll(self._fromWeakPoint, self._toWeakPoint)
	end
end

function BattlePropertyCompareView:_onPlayScroll(dp)
	self:_onPlayWeakPointScroll(dp)
	self._leftUnitView:onPlayScroll(dp)
	self._rightUnitView:onPlayScroll(dp)
end

function BattlePropertyCompareView:_onPlayWeakPointScroll(dp)
	if not self._hasWeakPointScroll then
		return
	end

	self._curWeakPoint = self._curWeakPoint + dp * self._dWeakPoint

	self._weakPoint:setWeakPointFillAmount(self._curWeakPoint)
	self._weakPointSlider:SetValue(self._curWeakPoint)
end

function BattlePropertyCompareView:_onScrollComplete()
	self._leftUnitView:onScrollComplete()
	self._rightUnitView:onScrollComplete()

	if self._hasWeakPointScroll then
		self._weakPoint:forecast(false, self._toWeakPointHp, true)
		self._weakPointSlider:SetValue(self._toWeakPoint)
	end

	self._tweener = nil
end

return BattlePropertyCompareView
