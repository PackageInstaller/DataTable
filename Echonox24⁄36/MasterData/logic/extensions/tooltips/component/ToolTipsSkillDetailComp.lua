-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsSkillDetailComp.lua

module("logic.extensions.tooltips.component.ToolTipsSkillDetailComp", package.seeall)

local M = class("ToolTipsSkillDetailComp", ViewComponent)

function M:buildUI()
	self._txtSkillDesc = self:getUIComponent("skill_detail_tips_663328259", UIComponentType.TextMeshProUGUI)
	self._btnSkillDesc = self:getBtn("skill_detail_tips_1194469911")
	self._strengthenSkillPanelGo = self:getGo("skill_detail_tips_-1377852899")
	self._strenthenSkill1Go = self:getGo("skill_detail_tips_-516282821")
	self._strenthenSkill2Go = self:getGo("skill_detail_tips_-1338484903")
	self._strengthenSkillDesc1Txt = self:getText("skill_detail_tips_-624981668")
	self._strengthenSkillDesc2Txt = self:getText("skill_detail_tips_-414082995")
	self._goJurisdictionRoot = self:getGo("skill_detail_tips_652629714")
	self._goJurisdictionContent = self:getGo("skill_detail_tips_-109636666")
	self._goBuffRoot = self:getGo("skill_detail_tips_673836289")
	self._goBuffContent = self:getGo("skill_detail_tips_1791274334")
	self._goBuffContentLoop = self:getGo("skill_detail_tips_300828620")
	self._goBuffScroll = self:getGo("skill_detail_tips_-830243020")
	self._goBuffScrollLoop = self:getGo("skill_detail_tips_-1665556758")
	self._goAdditionalRoot = self:getGo("skill_detail_tips_36918501")
	self._additionalItem = Astral.LuaComponentContainer.Add(self._goAdditionalRoot, AuthorityTextItem)
	self._buffItemCollection = ViewlibCollection.New(ViewlibResPath.BuffDetailItem1, 10)
	self._authorityItemCollection = ViewlibCollection.New(ViewlibResPath.AuthorityTextItem, 10)
	self._contractOrEchoItemCollection = ViewlibCollection.New(ViewlibResPath.ContractOrEchoTextItem, 10)
	self._breakLevelItemCollection = ViewlibCollection.New(ViewlibResPath.BreakLevelItem, 10)

	local _passEventGo = self:getGo("empty_mask_tips_29887572")

	self._passEvent = _passEventGo.gameObject:GetComponent(ComponentType.PassEvent)
end

function M:destroyUI()
	self._buffItemCollection:clear()
	self._authorityItemCollection:clear()
	self._contractOrEchoItemCollection:clear()
	self._breakLevelItemCollection:clear()
	self._additionalItem:destroy()

	self._additionalItem = nil
	self._txtSkillDesc = nil
	self._goJurisdictionRoot = nil
	self._goJurisdictionContent = nil
	self._goBuffRoot = nil
	self._goBuffContent = nil
	self._goBuffScroll = nil
	self._goBuffScrollLoop = nil
	self._buffItemCollection = nil
	self._authorityItemCollection = nil
	self._contractOrEchoItemCollection = nil
	self._breakLevelItemCollection = nil
end

function M:onEnter()
	local info = self:getFirstParam()

	self._hasDispatch = info.hasDispatch

	if self._hasDispatch then
		GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, true, self._viewPresentor:getViewName())
	end

	self:_setEvent(true)
	self:_onEnhanceInfoUpdate()
end

function M:onExit()
	local info = self:getFirstParam()

	SkillEnhanceMO.releaseSharedMO(info.skillEnhanceMO)
	self:_setEvent(false)
end

function M:onExitFinished()
	self._buffItemCollection:clearAllInstance()
	self._authorityItemCollection:clearAllInstance()
	self._contractOrEchoItemCollection:clearAllInstance()
	self._breakLevelItemCollection:clearAllInstance()
	GlobalDispatcher:dispatchEvent(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, false, self._viewPresentor:getViewName())
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self._onEnhanceInfoUpdate, self)
		self._btnSkillDesc:AddClickListener(self._onClickSkillDesc, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self._onEnhanceInfoUpdate, self)
		self._btnSkillDesc:RemoveClickListener()
	end
end

function M:_onEnhanceInfoUpdate()
	local info = self:getFirstParam()

	self._hideEnhanceDetail = info.hideEnhanceDetail
	self._skillStatus = info.skillStatus

	self:_updateView(info)

	self._passEvent.isPassEvent = info.isPassEvent
end

function M:_onClickSkillDesc()
	local info = self:getFirstParam()
	local skillEnhanceMO = info.skillEnhanceMO
	local skillCO = skillEnhanceMO and skillEnhanceMO:getSkillCO() or nil
	local skillId = skillCO and skillCO.code or nil

	skillId = skillId or 0

	if skillId <= 0 then
		return
	end

	local bindGo = self._btnSkillDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:_updateView(info)
	local heroId = info.heroId
	local skillStatus = info.skillStatus or BattleEnum.SkillStatus.Normal
	local skillEnhanceMO = info.skillEnhanceMO
	local addSkillEnhanceMO = false
	local skillCOWrapper = skillEnhanceMO:getSkillCOWrapper()
	local isTalent = ActiveSkillCOUtil.isTalent(skillCOWrapper, skillStatus)
	local isCharacter = heroId and ItemUtil.isCharacterById(heroId) or false
	local showTalent = isTalent and isCharacter

	if showTalent then
		local awakeStatus = info.awakeStatus
		local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
		local addSkillId = characterCO.battleTalent[awakeStatus]

		if addSkillId then
			addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(addSkillId)

			addSkillEnhanceMO:rebuild()
		end
	end

	self:_updateDescView(skillEnhanceMO, addSkillEnhanceMO)
	self:_updateEnhanceView(skillEnhanceMO)
	self:_updateBuffView(skillEnhanceMO)
	SkillEnhanceMO.releaseSharedMO(addSkillEnhanceMO)
end

function M:_updateEnhanceView(skillEnhanceMO)
	if self._hideEnhanceDetail then
		goutil.setActive(self._goJurisdictionRoot, false)
		goutil.setActive(self._goAdditionalRoot, false)

		return
	end

	local skillCO = skillEnhanceMO:getSkillCO()
	local skillCOWrapper = skillEnhanceMO:getSkillCOWrapper()

	self._authorityItemCollection:clearAllInstance()
	self._contractOrEchoItemCollection:clearAllInstance()
	self._breakLevelItemCollection:clearAllInstance()

	local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCO.code)

	if #allEnhanceCodes <= 0 then
		goutil.setActive(self._goJurisdictionRoot, false)
		goutil.setActive(self._goAdditionalRoot, false)

		return
	end

	local hasEnhance = false
	local skillType = skillCOWrapper:getSkillType(BattleEnum.SkillStatus.Normal)
	local itemCollection = self._authorityItemCollection

	if skillType == BattleEnum.SkillCategory.EQUIPMENT then
		itemCollection = self._breakLevelItemCollection
	elseif skillType == BattleEnum.SkillCategory.ECHO then
		itemCollection = self._contractOrEchoItemCollection
	elseif skillType == BattleEnum.SkillCategory.TALENT then
		itemCollection = self._contractOrEchoItemCollection
	end

	local myEnhanceCodes = skillEnhanceMO:getAllSkillEnhanceCode()

	for index, enhanceCode in ipairs(allEnhanceCodes) do
		local isGained = table.indexof(myEnhanceCodes, enhanceCode)
		local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

		if not skillEnhanceCOWrapper:isAddEnhance() then
			local authorityItem = itemCollection:createInstance(self._goJurisdictionContent)

			authorityItem:setEnhanceCode(index, skillType, enhanceCode, isGained)

			hasEnhance = true
		end
	end

	goutil.setActive(self._goJurisdictionRoot, hasEnhance)
	goutil.setActive(self._goAdditionalRoot, false)
end

function M:_updateBuffView(skillEnhanceMO)
	local skillCO = skillEnhanceMO:getSkillCO()

	self._buffItemCollection:clearAllInstance()

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCO.code)
	local buffCodes = skillCOWrapper:getAddBuffCodes()

	if #buffCodes <= 0 then
		goutil.setActive(self._goBuffRoot, false)

		return
	end

	BuffCOUtil.sortBuffCodes(buffCodes)

	local useLoop = #buffCodes > 6

	for _, buffCode in ipairs(buffCodes) do
		local buffItem = self._buffItemCollection:createInstance(useLoop and self._goBuffContentLoop or self._goBuffContent)

		buffItem:setBuffId(buffCode)
	end

	goutil.setActive(self._goBuffScroll, not useLoop)
	goutil.setActive(self._goBuffScrollLoop, useLoop)
	goutil.setActive(self._goBuffRoot, true)
end

function M:_updateDescView(skillEnhanceMO, addSkillEnhanceMO)
	local descStr = skillEnhanceMO:getDescription()

	if addSkillEnhanceMO then
		descStr = string.format("%s\n%s", addSkillEnhanceMO:getDescription(), descStr)
	end

	self._txtSkillDesc.text = descStr

	local skillCO = skillEnhanceMO:getSkillCO()

	if not skillCO.hasGodlike then
		goutil.setActive(self._strengthenSkillPanelGo, false)

		return
	end

	goutil.setActive(self._strengthenSkillPanelGo, true)

	local strengthenStr = string.format("%s: %s", lang("skill_tip_strengthen_1"), skillEnhanceMO:getStrengthenDescription())

	strengthenStr = string.gsub(strengthenStr, " ", " ")

	if self._skillStatus == BattleEnum.SkillStatus.Strenthening then
		goutil.setActive(self._strenthenSkill1Go, false)
		goutil.setActive(self._strenthenSkill2Go, true)

		self._strengthenSkillDesc2Txt.text = TextUtils.GetPunctuationFixedText(strengthenStr, self._strengthenSkillDesc2Txt)
	else
		goutil.setActive(self._strenthenSkill1Go, true)
		goutil.setActive(self._strenthenSkill2Go, false)

		self._strengthenSkillDesc1Txt.text = TextUtils.GetPunctuationFixedText(strengthenStr, self._strengthenSkillDesc1Txt)
	end
end

return M
