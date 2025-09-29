-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleUseSkillItem.lua

module("logic.extensions.battle.viewmain.operator.BattleUseSkillItem", package.seeall)

local BattleUseSkillItem = class("BattleUseSkillItem", UIReusableLuaBehavior)

function BattleUseSkillItem:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")
	self._goStrenthening = goutil.findChild(self.mainGO, "strenthening")
	self._normalTagPanelGo = goutil.findChild(self.mainGO, "skillName")
	self._normalTagTxt = goutil.findChildTextComponent(self.mainGO, "skillName/txtName")
	self._strengthenTagTxt = goutil.findChildTextComponent(self.mainGO, "strenthening/TextLocalization")
	self._selectedStrengthenEffectGo = goutil.findChild(self.mainGO, "strenthening/strength1_liang")
	self._unselectedStrengthenEffectGo = goutil.findChild(self.mainGO, "strenthening/strength_an")
	self._goCommon = goutil.findChild(self.mainGO, "common")
	self._goSpecial = goutil.findChild(self.mainGO, "pas")
	self._goFinal = goutil.findChild(self.mainGO, "final")
	self._goNone = goutil.findChild(self.mainGO, "none")
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect")
	self._goLockCommon = goutil.findChild(self.mainGO, "common_lock")
	self._goLockSpecial = goutil.findChild(self.mainGO, "pas_lock")
	self._goLockFinal = goutil.findChild(self.mainGO, "final_lock")
	self._goCd = goutil.findChild(self.mainGO, "cd")
	self._txtCd = goutil.findChildTextComponent(self.mainGO, "cd/txtNum")
	self._goHasCd = goutil.findChild(self.mainGO, "cdSign")

	goutil.setActive(self._goHasCd, false)

	self._imgSign = goutil.addComponentOnce(goutil.findChild(self.mainGO, "passivitySign"), ComponentType.ImageLocalization)
	self._btnClick = OnceLongPressTrigger.Get(self.mainGO)

	self._btnClick:AddClickListener(self._onClickIcon, self)
	self._btnClick:AddLongPressListener(self._onLongPressIcon, self)

	self._handler = Handler.New()
	self._skillId = false
	self._positionIndex = false
	self._isEnable = false
	self._isSelected = false

	self:unselectIcon()
end

function BattleUseSkillItem:destroyUI()
	self._imgIcon = nil
	self._goStrenthening = nil
	self._goCd = nil

	self._btnClick:RemoveClickListener()
	self._btnClick:RemoveLongPressListener()

	self._btnClick = nil

	self._handler:clear()

	self._handler = nil
	self._skillId = nil
	self._heroId = nil
	self._entityId = nil
	self._bindGo = nil
end

function BattleUseSkillItem:onEnter()
	self._isSelected = false
	self._isStrengthen = false

	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function BattleUseSkillItem:onExit()
	self._handler:clear()
	self:unselectIcon()
end

function BattleUseSkillItem:setSkillMO(heroId, entityId, skillMO)
	self._heroId = heroId
	self._entityId = entityId

	local skillCO = skillMO:getSkillCO()
	local skillCOWrapper = skillMO:getSkillCOWrapper()
	local skillId = skillMO:getSkillId()
	local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper)

	self._isPassiveSkill = ActiveSkillCOUtil.isPassive(skillCOWrapper)
	self._isSpecialSkill = ActiveSkillCOUtil.isSpecial(skillCOWrapper)
	self._isTrumpSkill = ActiveSkillCOUtil.isTrump(skillCOWrapper)
	self._skillId = skillId
	self._skillType = skillCOWrapper:getSkillType(self._isStrengthen)

	local isAddEnhanced = skillMO:isAddEnhanced()
	local myEnhanceCodes = skillMO:getEnhanceCodes()

	if skillMO:hasCd() then
		self._txtCd.text = skillMO:getCd()

		goutil.setActive(self._goCd, true)
	else
		goutil.setActive(self._goCd, false)
	end

	goutil.setActive(self._goCommon, self._skillType == BattleEnum.SkillCategory.NORMAL)
	goutil.setActive(self._goSpecial, self._skillType == BattleEnum.SkillCategory.SPECIAL)
	goutil.setActive(self._goFinal, self._skillType == BattleEnum.SkillCategory.TRUMP)
	goutil.setActive(self._goStrenthening, false)

	self._hasNormalTag = skillCOWrapper:getTagString() and skillCOWrapper:getTagString() ~= ""
	self._normalTagTxt.text = skillCOWrapper:getTagString()
	self._strengthenTagTxt.text = skillCOWrapper:getStrenthenTag()

	goutil.setActive(self._normalTagPanelGo, self._hasNormalTag)
	self:_refreshSign(false)
	BattleIconName.setSkillIcon(self._imgIcon, self._skillId)

	local iconMat = self._isPassiveSkill and CommonResPath.SkillIconPassiveMat or CommonResPath.SkillIconMat

	self._imgIcon.material = CommonPreloader.instance:getMaterialsCommAsset(iconMat)
end

function BattleUseSkillItem:_refreshSign(showStrengthen)
	goutil.setActive(self._imgSign.gameObject, false)
end

function BattleUseSkillItem:setPositionIndex(index)
	self._positionIndex = index
end

function BattleUseSkillItem:getPositionIndex()
	return self._positionIndex
end

function BattleUseSkillItem:getSkillId()
	return self._skillId
end

function BattleUseSkillItem:setStrenthening(isStrenthening)
	self._isStrengthen = isStrenthening

	local showStrengthen = not self._isPassiveSkill and self._isEnable and isStrenthening

	goutil.setActive(self._goStrenthening, showStrengthen)
	goutil.setActive(self._normalTagPanelGo, not showStrengthen and self._hasNormalTag)
	self:_refreshSign(showStrengthen)
	self:_updateStrengthenEffect()
end

function BattleUseSkillItem:setEnable(isInCd, enable, isSkillUnlock)
	self._isEnable = enable

	if isSkillUnlock then
		goutil.setActive(self._goLockCommon, false)
		goutil.setActive(self._goLockSpecial, false)
		goutil.setActive(self._goLockFinal, false)
	else
		goutil.setActive(self._goLockCommon, self._skillType == BattleEnum.SkillCategory.NORMAL)
		goutil.setActive(self._goLockSpecial, self._skillType == BattleEnum.SkillCategory.SPECIAL)
		goutil.setActive(self._goLockFinal, self._skillType == BattleEnum.SkillCategory.TRUMP)
	end

	goutil.setActive(self._goCd, isInCd)
end

function BattleUseSkillItem:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function BattleUseSkillItem:selectIcon(isPositive)
	self._isSelected = true

	goutil.setActive(self._goSelect, true)
	self:_updateStrengthenEffect()
end

function BattleUseSkillItem:_updateStrengthenEffect()
	if self._isStrengthen then
		goutil.setActive(self._selectedStrengthenEffectGo, self._isSelected)
		goutil.setActive(self._unselectedStrengthenEffectGo, not self._isSelected)
	end
end

function BattleUseSkillItem:unselectIcon()
	self._isSelected = false

	goutil.setActive(self._goSelect, false)
	self:_updateStrengthenEffect()
end

function BattleUseSkillItem:_onClickIcon()
	self._handler:call(self._skillId, self)
end

function BattleUseSkillItem:setBindGo(bindGo)
	self._bindGo = bindGo
end

function BattleUseSkillItem:_onLongPressIcon()
	if GuideController.instance:isGuiding() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ToolTipsCharacterSkillDetailViewPresentor) then
		ViewMgr.instance:destroy(ViewName.ToolTipsCharacterSkillDetailViewPresentor, false, true)
	end

	self:showTips()
end

function BattleUseSkillItem:showTips()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillId
	skillInfo.hangGO = self._bindGo
	skillInfo.popType = nil
	skillInfo.entityId = self._entityId
	skillInfo.forceAlign = UnityEngine.TextAnchor.LowerRight

	BattleMainViewFacade.instance:showSkillTipsOfOperateUnit(skillInfo)
end

return BattleUseSkillItem
