-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterSkillPreviewView.lua

module("logic.extensions.charactersystem.view.preview.CharacterSkillPreviewView", package.seeall)

local M = class("CharacterSkillPreviewView", ViewComponent)

function M:ctor()
	self._heroId = nil
	self._heroData = nil
	self._talentId = nil
	self._wakeUpTalentId = nil
	self._authoritySkill1 = nil
	self._authoritySkill2 = nil
	self._activeSkillCells = {}
	self._authoritySkillCells = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("role_preview_view_-1004126632")
	self._goFullLevelPanel = self:getGo("role_preview_view_-1953597862")
	self._goDetailPanel = self:getGo("role_preview_view_-1974066106")
	self._goSkillPanel = self:getGo("role_preview_view_-1341573419")
	self._goHeroImg = self:getGo("role_preview_view_-853247651")
	self._goHeroInfo = self:getGo("role_preview_view_-227809224")
	self._tranBg = self:getRectTransform("role_preview_view_2081018199")
	self._goHeadIcon = self:getGo("role_preview_view_1318559495")
	self._imgOriginTalent = self:getImage("role_preview_view_1450502595")
	self._imgAwakeTalent = self:getImage("role_preview_view_-923699095")
	self._textOriginTalent = self:getText("role_preview_view_-1786969951")
	self._textAwakeTalent = self:getText("role_preview_view_-1937791730")
	self._btnOriginTalent = self:getBtn("role_preview_view_1450502595")
	self._btnAwakeTalent = self:getBtn("role_preview_view_-923699095")
	self._goTalentPos1 = self:getGo("role_preview_view_-984498344")
	self._goTalentPos2 = self:getGo("role_preview_view_1084702984")
	self._goLocked = self:getGo("role_preview_view_-655295126")
	self._textTalentTitle = self:getText("role_preview_view_-1657112167")
	self._textTalentUnlock = self:getText("role_preview_view_-66684138")
	self._goAuthoritySkill1 = self:getGo("role_preview_view_-1480459301")
	self._goAuthoritySkill2 = self:getGo("role_preview_view_-819998387")
	self._sliderAuthority = self:getSlider("role_preview_view_-2052009559")
	self._textAuthorityTitle = self:getText("role_preview_view_1781633540")
	self._goSkill1 = self:getGo("18&skill_item_1_-706685850")
	self._goSkill2 = self:getGo("19&skill_item_1_-706685850")
	self._goSkill3 = self:getGo("20&skill_item_1_-706685850")
	self._textSkillTitle = self:getText("role_preview_view_-474335965")

	RectTransformUtils.SetAnchoredPosition(self._tranBg, -233, 0)
	goutil.setActive(self._goHeroImg, false)
	goutil.setActive(self._goHeroInfo, false)
	goutil.setActive(self._goFullLevelPanel, false)
	goutil.setActive(self._goDetailPanel, false)
	goutil.setActive(self._goSkillPanel, true)
	goutil.setActive(self._goHeadIcon, false)
end

function M:bindEvents()
	self._btnOriginTalent:AddClickListener(self._onClickOriginTalent, self)
	self._btnAwakeTalent:AddClickListener(self._onClickAwakeTalent, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnOriginTalent:RemoveClickListener()
	self._btnAwakeTalent:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._heroId = self:getFirstParam()
	self._heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	self:_refreshTalent()
	self:_refreshSkills()
	self:_refreshAuthority()
end

function M:onExit()
	return
end

function M:destroyUI()
	for _, cell in ipairs(self._activeSkillCells) do
		cell:destroyUI()
	end

	for _, cell in ipairs(self._authoritySkillCells) do
		cell:destroyUI()
	end

	self._heroData = nil
	self._activeSkillCells = nil
	self._authoritySkillCells = nil
end

function M:_refreshSkills()
	self._textSkillTitle.text = lang("tip_skill")

	table.clear(self._activeSkillCells)

	local skills = self._heroData:getActiveNormalSkill()
	local skillsMO = {}

	for _, skill in ipairs(skills) do
		local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skill.key)
		local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil

		table.insert(skillsMO, skillCOWrapper)
	end

	for i = 1, 3 do
		local skillMO = skillsMO[i]
		local cell = Astral.SimpleLuaComponentContainer.Add(self["_goSkill" .. i], CharacterSkillCell)

		cell:setData(skillMO, self._heroId)
		table.insert(self._activeSkillCells, cell)
	end
end

function M:_refreshTalent()
	self._textTalentTitle.text = lang("tip_talent")
	self._textTalentUnlock.text = lang("tip_talent_unlock")

	local characterCO = self._heroData:getCharacterCo()
	local talentSkills = characterCO.battleTalent
	local isWakeUp = self._heroData:getAwakeTalent()

	self._talentId = talentSkills[1] or 0

	local unAwakeTalentId = talentSkills[2] or talentSkills[1] or 0
	local awakeTalentId = talentSkills[3] or talentSkills[2] or talentSkills[1] or 0

	self:_setTalent(self._imgOriginTalent, self._textOriginTalent, unAwakeTalentId)
	self:_setTalent(self._imgAwakeTalent, self._textAwakeTalent, awakeTalentId)
	goutil.setActive(self._goLocked, not isWakeUp)
	Astral.ColorUtil.SetImageColor(self._imgAwakeTalent, isWakeUp and "#FFFFFFFF" or "#FFFFFF33")
end

function M:_refreshAuthority()
	self._textAuthorityTitle.text = lang("tip_Authority")

	table.clear(self._authoritySkillCells)

	local skillNodeList = HeroPowerConfig.instance:getSkillNodeCoList(self._heroId)

	self._authoritySkill1 = self:_authoritySkillUIData(self._goAuthoritySkill1)
	self._authoritySkill2 = self:_authoritySkillUIData(self._goAuthoritySkill2)

	self:_setAuthoritySkillInfo(self._authoritySkill1, skillNodeList[1])
	self:_setAuthoritySkillInfo(self._authoritySkill2, skillNodeList[2])

	local progressValue = 0

	if skillNodeList[2] and CharacterAuthorityModel.instance:checkNodeIsUnlock(self._heroId, skillNodeList[2].code) then
		progressValue = 1
	elseif skillNodeList[1] and CharacterAuthorityModel.instance:checkNodeIsUnlock(self._heroId, skillNodeList[1].code) then
		progressValue = 0.25
	end

	self._sliderAuthority:SetValue(progressValue)
end

function M:_authoritySkillUIData(goSkill)
	local result = {}

	result.goSkill = goSkill
	result.canvasGroup = goutil.addComponentOnce(goSkill, ComponentType.CanvasGroup)
	result.skillItem = goutil.findChild(goSkill, "skill_item_1")
	result.goUpImg = goutil.findChild(goSkill, "imgUp")
	result.textLvl = goutil.findChildTextComponent(goSkill, "txtLvl")
	result.goLock = goutil.findChild(goSkill, "txtLvl/Image1")
	result.goNode = goutil.findChild(goSkill, "nodeActive")

	return result
end

function M:_setAuthoritySkillInfo(skillUIData, skillNodeCo)
	goutil.setActive(skillUIData.goSkill, skillNodeCo)

	if not skillNodeCo then
		return
	end

	local isUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(self._heroId, skillNodeCo.code)

	skillUIData.canvasGroup.alpha = isUnlock and 1 or 0.4

	goutil.setActive(skillUIData.goUpImg, CharacterAuthorityModel.instance:isEnhanceSkill(self._heroId, skillNodeCo.skillId))

	skillUIData.textLvl.text = skillNodeCo.simpleName

	goutil.setActive(skillUIData.goLock, not isUnlock)
	goutil.setActive(skillUIData.goNode, isUnlock)

	local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skillNodeCo and skillNodeCo.skillId or 0)
	local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil
	local cell = Astral.SimpleLuaComponentContainer.Add(skillUIData.skillItem, CharacterSkillCell)

	cell:setData(skillCOWrapper, self._heroId)
	cell:setTipsPosType(CommEnum.TipsPopType.Left)
	table.insert(self._authoritySkillCells, cell)
end

function M:_setTalent(img, nameText, skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
	local skillCo = skillCOWrapper:getSkillCO()

	nameText.text = StringUtil.randomReplaceBlackBlock(skillCo.name)

	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCo)

	if not string.nilorempty(iconPath) then
		IconLoader.setSprite(img, IconType.SkillIcon, iconPath, function()
			img:SetNativeSize()
		end, self)
	end
end

function M:_onClickOriginTalent()
	self:_showTalentTips(self._goTalentPos1, CommEnum.TalentSkillAwakeStatus.Locked)
end

function M:_onClickAwakeTalent()
	self:_showTalentTips(self._goTalentPos2, CommEnum.TalentSkillAwakeStatus.Unlock)
end

function M:_showTalentTips(posGo, awakeStatus)
	if self._talentId and self._talentId > 0 then
		local skillInfo = ToolTipsMgr.getSkillTipsInfo()

		skillInfo.heroId = self._heroId
		skillInfo.skillId = self._talentId
		skillInfo.defaultShowAll = true
		skillInfo.hangGO = posGo
		skillInfo.awakeStatus = awakeStatus

		ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
	end
end

function M:_onClickClose()
	self:close()
end

return M
