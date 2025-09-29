-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/CharacterSkillCell.lua

module("logic.extensions.charactersystem.view.cell.CharacterSkillCell", package.seeall)

local M = class("CharacterSkillCell")

function M:ctor(container)
	self._go = container.gameObject
	self._registry = ViewElementsRegistry.New(self._go)
	self._tipsPosType = CommEnum.TipsPopType.Right
	self._enhanceCodes = nil

	self:_buildUI()
	self:_bindEvents()
	self:_setEvent(true)
end

function M:_buildUI()
	self._btnItem = self._registry:getBtn("skill_item_1_1663929415")
	self._imgSign = goutil.findChildImageComponent(self._go, "passivitySign")
	self._imgIcon = self._registry:getImage("skill_item_1_-2055718383")
	self._goSelected = self._registry:getGo("skill_item_1_1454546744")

	if self._imgSign then
		self._imgSign:SetSprite("zd_label_0002")
	end

	self._goTipsPos = goutil.findChild(self._go, "tipsPos") or self._go
end

function M:_bindEvents()
	self._btnItem:AddClickListener(self._onClickSkill, self)
end

function M:_unbindEvents()
	self._btnItem:RemoveClickListener()
end

function M:destroyUI()
	self:_unbindEvents()
	self:_setEvent(false)

	self._enhanceCodes = nil
end

function M:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsOpen, self)
	end
end

function M:setData(skillCOWrapper, heroId)
	self._skillCOWrapper = skillCOWrapper or nil
	self._heroId = heroId

	self:_refreshUI()
end

function M:setTipsPosType(tipsPosType)
	self._tipsPosType = tipsPosType
end

function M:setEnhanceCodes(enhanceCodes)
	self._enhanceCodes = enhanceCodes
end

function M:addEnhanceCodes(enhanceCodes)
	self._enhanceCodes = self._enhanceCodes or {}

	table.insertto(self._enhanceCodes, enhanceCodes)
end

function M:_refreshUI()
	if not self._skillCOWrapper then
		goutil.setActive(self._go, false)

		return
	else
		local skillCO = self._skillCOWrapper:getSkillCO()

		IconLoader.setSprite(self._imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))

		local signInfo = ActiveSkillCOUtil.getSkillSignInfo(self._skillCOWrapper:getSkillCode(), nil)

		if self._imgSign then
			goutil.setActive(self._imgSign.gameObject, signInfo.isSign)
			self._imgSign:SetSprite(signInfo.spriteName)
		end
	end
end

function M:_onClickSkill()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillCOWrapper:getSkillCode()
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = self._goTipsPos
	skillInfo.enhanceCodes = self._enhanceCodes

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onSkillTipsOpen(e, isOpen, viewName, skillCode)
	goutil.setActive(self._goSelected, isOpen and self._skillCOWrapper:getSkillCode() == skillCode)
end

return M
