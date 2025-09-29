-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/CharacterAuthorityCell.lua

module("logic.extensions.charactersystem.view.cell.CharacterAuthorityCell", package.seeall)

local M = class("CharacterAuthorityCell")

function M:ctor(container)
	self._go = container.gameObject
	self._tipsPosType = CommEnum.TipsPopType.Right

	self:_buildUI()
	self:_bindEvents()
	self:_setEvent(true)
end

function M:_buildUI()
	self._btnCell = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
	self._imgIcon = goutil.findChildImageComponent(self._go, "normalPoint/lock/imgIcon")
	self._goCurrent = goutil.findChild(self._go, "normalPoint/current")
	self._imgCurrent = goutil.findChildImageComponent(self._go, "normalPoint/current/imgIcon")
	self._goTipsPos = goutil.findChild(self._go, "tipsPos") or self._go
end

function M:_bindEvents()
	self._btnCell:AddClickListener(self._onClickCell, self)
end

function M:_unbindEvents()
	self._btnCell:RemoveClickListener()
end

function M:destroyUI()
	self:_unbindEvents()
	self:_setEvent(false)
end

function M:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
	end
end

function M:setData(skillNodeCo, heroId)
	self._heroId = heroId

	local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skillNodeCo and skillNodeCo.skillId or 0)
	local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil

	self._skillCOWrapper = skillCOWrapper

	self:_refreshUI()
end

function M:setTipsPosType(tipsPosType)
	self._tipsPosType = tipsPosType
end

function M:_refreshUI()
	if self._skillCOWrapper then
		local skillCO = self._skillCOWrapper:getSkillCO()

		IconLoader.setSprite(self._imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
		IconLoader.setSprite(self._imgCurrent, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
	end

	goutil.setActive(self._imgIcon.gameObject, self._skillCOWrapper)
	goutil.setActive(self._btnCell.gameObject, self._skillCOWrapper)
end

function M:_onClickCell()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillCOWrapper:getSkillCode()
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = self._goTipsPos

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onSkillTipsOpen(e, isOpen, viewName, skillCode)
	if self._skillCOWrapper then
		goutil.setActive(self._goCurrent, isOpen and self._skillCOWrapper:getSkillCode() == skillCode)
	end
end

return M
