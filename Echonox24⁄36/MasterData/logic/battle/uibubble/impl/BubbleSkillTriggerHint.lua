-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleSkillTriggerHint.lua

module("logic.battle.uibubble.impl.BubbleSkillTriggerHint", package.seeall)

local BubbleSkillTriggerHint = class("BubbleSkillTriggerHint", BubbleBase)

function BubbleSkillTriggerHint:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleSkillTriggerHint
end

function BubbleSkillTriggerHint:buildUI()
	self._animation = goutil.findChildComponent(self.mainGO, "Skill", ComponentType.Animation)
	self._imgSkillIcon = goutil.findChildImageComponent(self.mainGO, "Skill/imgSkill")
	self._txtSkillName = goutil.findChildTextComponent(self.mainGO, "Skill/txtHeartAnchorName")
	self._imgEchoIcon = goutil.findChildImageComponent(self.mainGO, "Echo/imgDi/imgEcho")
	self._txtEquipName = goutil.findChildTextComponent(self.mainGO, "Equip/txtEquipName")
	self._imgEquipIcon = goutil.findChildImageComponent(self.mainGO, "Equip/imgEquip")
	self._imgEquipIconLight = goutil.findChildImageComponent(self.mainGO, "Equip/imgEquip_light")
	self._imgHeartAnchor = goutil.findChildImageComponent(self.mainGO, "HeartAnchor/imgHeartAnchor")
	self._txtHeartAnchorName = goutil.findChildTextComponent(self.mainGO, "HeartAnchor/txtHeartAnchorName")
	self._commonSkillPanelGo = goutil.findChild(self.mainGO, "Skill")
	self._echoSkillPanelGo = goutil.findChild(self.mainGO, "Echo")
	self._equipSkillPanelGo = goutil.findChild(self.mainGO, "Equip")
	self._heartAnchorGo = goutil.findChild(self.mainGO, "HeartAnchor")
end

function BubbleSkillTriggerHint:destroyUI()
	self._animation = nil
	self._imgSkillIcon = nil
	self._txtSkillName = nil
end

function BubbleSkillTriggerHint:resetUI()
	return
end

function BubbleSkillTriggerHint:getHeight()
	return 50
end

function BubbleSkillTriggerHint:getPriority()
	return 10
end

function BubbleSkillTriggerHint:setBubbleContent(skillId)
	if skillId == BattleConst.WeakPointBrokenSkillCode then
		self:_setWeakpointBroken()

		return
	elseif skillId == BattleConst.WeakPointResumedSkillCode then
		self:_setWeakpointResumed()

		return
	end

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
	local skillType = skillCOWrapper:getSkillType()
	local skillCO = skillCOWrapper:getSkillCO()

	self:_setPanelVisible(skillType)

	if skillType == BattleEnum.SkillCategory.ECHO then
		BattleIconName.setSkillIcon(self._imgEchoIcon, skillId)
	elseif skillType == BattleEnum.SkillCategory.EQUIPMENT then
		self._txtEquipName.text = skillCO.name

		BattleIconName.setSkillIcon(self._imgEquipIcon, skillId)
		BattleIconName.setSkillIcon(self._imgEquipIconLight, skillId)
	elseif skillType == BattleEnum.SkillCategory.TALENT then
		self._txtHeartAnchorName.text = skillCO.name

		BattleIconName.setSkillIcon(self._imgHeartAnchor, skillId, self._onTalentIconLoaded, self)
	else
		self._txtSkillName.text = skillCO.name

		BattleIconName.setSkillIcon(self._imgSkillIcon, skillId)
		AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
	end
end

function BubbleSkillTriggerHint:_onTalentIconLoaded(img)
	img:SetNativeSize()

	local transform = img.transform
	local width = goutil.getWidth(transform)

	if width > 200 then
		Astral.TransformUtil.SetLocalPosY(transform, 4.5)
	else
		goutil.setWidth(transform, 180)
		goutil.setHeight(transform, 180)
		Astral.TransformUtil.SetLocalPosY(transform, 0)
	end
end

function BubbleSkillTriggerHint:_setPanelVisible(skillType)
	if skillType == BattleEnum.SkillCategory.ECHO then
		goutil.setActive(self._commonSkillPanelGo, false)
		goutil.setActive(self._echoSkillPanelGo, true)
		goutil.setActive(self._equipSkillPanelGo, false)
		goutil.setActive(self._heartAnchorGo, false)
	elseif skillType == BattleEnum.SkillCategory.EQUIPMENT then
		goutil.setActive(self._commonSkillPanelGo, false)
		goutil.setActive(self._echoSkillPanelGo, false)
		goutil.setActive(self._equipSkillPanelGo, true)
		goutil.setActive(self._heartAnchorGo, false)
	elseif skillType == BattleEnum.SkillCategory.TALENT then
		goutil.setActive(self._commonSkillPanelGo, false)
		goutil.setActive(self._echoSkillPanelGo, false)
		goutil.setActive(self._equipSkillPanelGo, false)
		goutil.setActive(self._heartAnchorGo, true)
	else
		goutil.setActive(self._commonSkillPanelGo, true)
		goutil.setActive(self._echoSkillPanelGo, false)
		goutil.setActive(self._equipSkillPanelGo, false)
		goutil.setActive(self._heartAnchorGo, false)
	end
end

function BubbleSkillTriggerHint:_setWeakpointBroken()
	self:_setPanelVisible(BattleEnum.SkillCategory.NORMAL)

	self._txtSkillName.text = "弱点击破"

	BattleIconName.setSkillIcon(self._imgSkillIcon, 1103904)
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

function BubbleSkillTriggerHint:_setWeakpointResumed()
	self:_setPanelVisible(BattleEnum.SkillCategory.NORMAL)

	self._txtSkillName.text = "弱点恢复"

	BattleIconName.setSkillIcon(self._imgSkillIcon, 1103904)
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

return BubbleSkillTriggerHint
