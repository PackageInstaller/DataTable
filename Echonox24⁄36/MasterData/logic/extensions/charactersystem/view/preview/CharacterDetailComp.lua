-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterDetailComp.lua

module("logic.extensions.charactersystem.view.preview.CharacterDetailComp", package.seeall)

local M = class("CharacterDetailComp", SimpleCellComponent)
local index2Attribure = {
	BattleExtension_pb.Attribute.MAX_HP,
	BattleExtension_pb.Attribute.ATK_PHY,
	BattleExtension_pb.Attribute.DEF_PHY,
	BattleExtension_pb.Attribute.INSPIRATION,
	BattleExtension_pb.Attribute.ATK_MAG,
	BattleExtension_pb.Attribute.DEF_MAG
}
local index2AttrGrade = {
	1,
	3,
	4,
	2,
	5,
	6
}
local ElementType = CharacterPreviewModel.ElementType
local ElementType2SystemKey = {
	[ElementType.Dimension6] = GameEnum.SystemEnum.RunGroupActivity
}

function M:ctor(container)
	self.super.ctor(self, container)

	self._talentId = nil
	self._tabItems = {}
	self._skillCells = {}
	self._anthorityCell = {}
	self._anchorBreakCells = {}
	self._element2Go = {}
	self._element2TabGo = {}
end

function M:buildUI()
	local reg = self._registry

	self._textTalentTitle = reg:getText("role_model_preview_detail_1967451445")
	self._textSkillTitle = reg:getText("role_model_preview_detail_733574859")
	self._textAuthorityTitle = reg:getText("role_model_preview_detail_505008952")
	self._textBreakTitle = reg:getText("role_model_preview_detail_470845361")
	self._textDimensionTitle = reg:getText("role_model_preview_detail_-438807877")
	self._rectTabParent = reg:getRectTransform("role_model_preview_detail_-838021039")
	self._scrollRect = reg:getUIComponent("role_model_preview_detail_-730318639", UIComponentType.ScrollRect)
	self._scrollAdapter = reg:getScrollRect("role_model_preview_detail_-730318639")
	self._scrollContent = reg:getRectTransform("role_model_preview_detail_-304634655")
	self._textLevel = reg:getText("role_model_preview_detail_-683689096")
	self._textMove = reg:getText("role_model_preview_detail_-447058680")
	self._textRange = reg:getText("role_model_preview_detail_74981123")
	self._transfArrt = reg:getRectTransform("role_model_preview_detail_1949663253")
	self._imgUnawakeTalent = reg:getImage("role_model_preview_detail_-645060513")
	self._imgAwakeTalent = reg:getImage("role_model_preview_detail_1191754229")
	self._textTalent = reg:getText("role_model_preview_detail_444907837")
	self._textTalenAwakeName = reg:getText("role_model_preview_detail_-1597021764")
	self._textTalentDesc = reg:getUIComponent("role_model_preview_detail_-116592679", UIComponentType.TextMeshProUGUI)
	self._textTalentAwakeDesc = reg:getUIComponent("role_model_preview_detail_1977413354", UIComponentType.TextMeshProUGUI)
	self._textTalentAwakeLockDesc = reg:getUIComponent("role_model_preview_detail_-1227340732", UIComponentType.TextMeshProUGUI)
	self._goTalentPos1 = reg:getGo("role_model_preview_detail_1252556484")
	self._goTalentPos2 = reg:getGo("role_model_preview_detail_-815890284")
	self._btnUnawakeTalent = reg:getBtn("role_model_preview_detail_-271314653")
	self._btnAwakeTalent = reg:getBtn("role_model_preview_detail_1070329130")
	self._goUnawakeTalentTips = reg:getGo("role_model_preview_detail_1561525803")
	self._goAwakeTalentTips = reg:getGo("role_model_preview_detail_384594362")
	self._goTalentLock = reg:getGo("role_model_preview_detail_-46974434")
	self._goAwakeTalent = reg:getGo("role_model_preview_detail_-1240358438")
	self._goAwakeTalentLock = reg:getGo("role_model_preview_detail_1808389308")
	self._btnAwakeTalentLock = reg:getBtn("role_model_preview_detail_750699064")
	self._goAwakeLockTips = reg:getGo("role_model_preview_detail_-1293435057")
	self._canvasAwakeTalent = reg:getCanvasGroup("role_model_preview_detail_-1580798875")
	self._goSkill1 = reg:getGo("0&role_model_preview_skill_1857426671")
	self._goSkill2 = reg:getGo("1&role_model_preview_skill_1857426671")
	self._goSkill3 = reg:getGo("2&role_model_preview_skill_1857426671")
	self._goAuthority = reg:getGo("role_model_preview_detail_1513629726")
	self._goBreak = reg:getGo("role_model_preview_detail_-1127989778")
	self._btn6DExplain = reg:getBtn("role_model_preview_detail_1064326008")
	self._polygon = UIPolygon.Get(reg:getGo("5&sixdimensioninfo_-492787873"))
	self._textDimension1 = reg:getText("5&sixdimensioninfo_-2033388935")
	self._textDimension2 = reg:getText("5&sixdimensioninfo_-1335132831")
	self._textDimension3 = reg:getText("5&sixdimensioninfo_-410819544")
	self._textDimension4 = reg:getText("5&sixdimensioninfo_-61014096")
	self._textDimension5 = reg:getText("5&sixdimensioninfo_1337588298")
	self._textDimension6 = reg:getText("5&sixdimensioninfo_-605687856")
	self._goFullLevelTips = goutil.findChild(self._go, "txtTips")

	goutil.setActive(self._goAuthority, false)
	goutil.setActive(self._goBreak, false)

	self._scrollHeight = RectTransformUtils.GetHeight(self._scrollRect.gameObject.transform)

	self:_initView()
end

function M:bindEvents()
	self._btnAwakeTalent:AddClickListener(self._onClickAwakeTalent, self)
	self._btnAwakeTalentLock:AddClickListener(self._onClickAwakeTalent, self)
	self._btnUnawakeTalent:AddClickListener(self._onClickUnawakeTalent, self)
	self._btn6DExplain:AddClickListener(self._onClick6D, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValChanged, self)
end

function M:unbindEvents()
	self._btnAwakeTalent:RemoveClickListener()
	self._btnAwakeTalentLock:RemoveClickListener()
	self._btnUnawakeTalent:RemoveClickListener()
	self._btn6DExplain:RemoveClickListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function M:onEnter()
	self:_refreshTabBtns()
	self:_refreshTabStatus(0)
end

function M:onExit()
	return
end

function M:destroyUI()
	for _, item in ipairs(self._tabItems) do
		item.btn:RemoveClickListener()
	end

	self._tabItems = nil
	self._skillCells = nil
	self._anthorityCell = nil
	self._anchorBreakCells = nil
end

function M:_setData(heroId, heroCO, heroData)
	self._heroId = heroId
	self._heroCO = heroCO
	self._heroData = heroData
end

function M:_refreshUI()
	self:_refreshElementShow()
	self:_refreshBaseAttr()
	self:_refreshTalent()
	self:_refreshSkill()
	self:_refreshAuthority()
	self:_refreshBreakup()
	self:_refresh6D()
	self:_refreshTabBtns()
	self:_refreshTabStatus(0)
	goutil.setActive(self._goFullLevelTips, self:_isMaxLevelPreview())

	self._scrollRect.verticalNormalizedPosition = 1
end

function M:_initView()
	self._textTalentTitle.text = lang("tip_talent")
	self._textSkillTitle.text = lang("tip_skill")
	self._textAuthorityTitle.text = lang("tip_Authority")
	self._textBreakTitle.text = lang("tip_break")
	self._textDimensionTitle.text = lang("tip_six_dimension")

	for i = 0, self._scrollContent.childCount - 1 do
		local goElement = self._scrollContent:GetChild(i).gameObject
		local elementType = i + 1

		self._element2Go[elementType] = goElement
	end

	for i = 0, self._rectTabParent.childCount - 1 do
		local goTab = self._rectTabParent:GetChild(i).gameObject
		local elementType = i + 1

		self._element2TabGo[elementType] = goTab
	end
end

function M:_isMaxLevelPreview()
	return CharacterPreviewModel.instance:getShowType() == CharacterPreviewModel.PreviewType.MaxLevel
end

function M:_isSkillDetailPreview()
	return CharacterPreviewModel.instance:getShowType() == CharacterPreviewModel.PreviewType.SkillDetail
end

function M:_refreshTabBtns()
	table.clear(self._tabItems)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._scrollContent)

	self._contentHeight = RectTransformUtils.GetHeight(self._scrollContent)

	for i = 0, self._rectTabParent.childCount - 1 do
		local child = self._rectTabParent:GetChild(i).gameObject
		local goOn = goutil.findChild(child, "state2")
		local elementTransf = self._scrollContent:GetChild(i)
		local height = RectTransformUtils.GetHeight(elementTransf)
		local maxY = elementTransf.anchoredPosition.y
		local minY = elementTransf.anchoredPosition.y - height
		local elementType = i + 1
		local btn = UIComponentType.ButtonAdapter(child)

		btn:AddClickListener(function()
			self:_onClickTab(elementType)
		end, nil)

		self._tabItems[elementType] = {
			goOn = goOn,
			minY = minY,
			maxY = maxY,
			btn = btn
		}
	end
end

function M:_refreshTabStatus(normalizedY)
	local startHeight = -(normalizedY * (self._contentHeight - self._scrollHeight))
	local endHeight = startHeight - self._scrollHeight

	for _, item in ipairs(self._tabItems) do
		local isOnShow = endHeight <= item.minY and startHeight >= item.minY or endHeight <= item.maxY and startHeight >= item.maxY or startHeight <= item.maxY and endHeight >= item.minY or false

		goutil.setActive(item.goOn, isOnShow)
	end
end

function M:_onScrollValChanged(posVec2)
	local normalizedY = 1 - Mathf.Clamp(posVec2.y, 0, 1)

	self:_refreshTabStatus(normalizedY)
end

function M:_onClickTab(index)
	local tabItem = self._tabItems[index]
	local normalizedY = 1 - -tabItem.maxY / (self._contentHeight - self._scrollHeight)

	normalizedY = Mathf.Clamp(normalizedY, 0, 1)
	self._scrollRect.verticalNormalizedPosition = normalizedY
end

function M:_elementShow(elementType)
	local isShow = CharacterPreviewModel.instance:isElementShow(elementType)
	local tabKey = ElementType2SystemKey[elementType]
	local systemOpen = tabKey == nil and true or SystemOpenFacade.instance:isOpen(tabKey, false)
	local canShow = isShow and systemOpen

	return canShow
end

function M:_refreshElementShow()
	for _, elementType in pairs(ElementType) do
		local canShow = self:_elementShow(elementType)

		goutil.setActive(self._element2Go[elementType], canShow)
		goutil.setActive(self._element2TabGo[elementType], canShow)
	end
end

function M:_refreshBaseAttr()
	if not self:_elementShow(ElementType.Attribute) then
		return
	end

	local level = self._heroData:getLevel()

	self._textLevel.text = string.format("<size=24>%d</size>/%d", level, level)
	self._textMove.text = self._heroData:getMove()
	self._textRange.text = self._heroData:getAtkRange()

	for i = 0, self._transfArrt.childCount - 1 do
		local goItem = self._transfArrt:GetChild(i).gameObject
		local textValue = goutil.findChildTextComponent(goItem, "txtValue1")
		local textQuality = goutil.findChildTextComponent(goItem, "txtLevel")
		local goQualityS = goutil.findChild(goItem, "imgS")

		textValue.text = self._heroData:getAttribute(index2Attribure[i + 1]) or "0"

		local attributeGrade = self._heroCO and self._heroCO.attributeGrade or {}
		local quality = attributeGrade[index2AttrGrade[i + 1]] or CommEnum.Quality2UpperChar[GameEnum.QualityEnum.A]
		local isQualityS = quality == CommEnum.Quality2UpperChar[GameEnum.QualityEnum.S]

		textQuality.text = quality

		goutil.setActive(goQualityS, isQualityS)
		goutil.setActive(textQuality.gameObject, not isQualityS)
	end
end

function M:_refreshTalent()
	if not self:_elementShow(ElementType.Talent) then
		return
	end

	self._talentId = ActiveSkillCOUtil.getTalentBaseId(self._heroId)

	local unAwakeTalentId = ActiveSkillCOUtil.getTalentUnawakeId(self._heroId)

	self._awakeTalentId = ActiveSkillCOUtil.getTalentAwakeId(self._heroId)

	local talentBaseMO = SkillEnhanceMO.getSharedMO(self._talentId)
	local unawakeEnhanceMO = SkillEnhanceMO.getSharedMO(unAwakeTalentId)
	local awakeEnhanceMO = SkillEnhanceMO.getSharedMO(self._awakeTalentId)

	self._textTalent.text = StringUtil.randomReplaceBlackBlock(unawakeEnhanceMO:getSkillCO().name)
	self._textTalenAwakeName.text = StringUtil.randomReplaceBlackBlock(awakeEnhanceMO:getSkillCO().name)
	self._textTalentDesc.text = talentBaseMO:getDescription() or ""
	self._textTalentAwakeDesc.text = awakeEnhanceMO and awakeEnhanceMO:getDescription(true) or ""
	self._textTalentAwakeLockDesc.text = awakeEnhanceMO and awakeEnhanceMO:getDescription(true) or ""

	local isWakeUp = self._heroData:getAwakeTalent()

	self._canvasAwakeTalent.alpha = isWakeUp and 1 or 0.2

	goutil.setActive(self._goAwakeTalent, isWakeUp)
	goutil.setActive(self._goAwakeTalentLock, not isWakeUp)
	goutil.setActive(self._goTalentLock, not isWakeUp)
	self:_setTalent(self._imgUnawakeTalent, unawakeEnhanceMO)
	self:_setTalent(self._imgAwakeTalent, awakeEnhanceMO)
	SkillEnhanceMO.releaseSharedMO(talentBaseMO)
	SkillEnhanceMO.releaseSharedMO(unawakeEnhanceMO)
	SkillEnhanceMO.releaseSharedMO(awakeEnhanceMO)
end

function M:_setTalent(img, skillEnhanceMO)
	local skillCo = skillEnhanceMO:getSkillCO()
	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCo)

	if not string.nilorempty(iconPath) then
		IconLoader.setSprite(img, IconType.SkillIcon, iconPath, function()
			img:SetNativeSize()
		end, self)
	end
end

function M:_onClickUnawakeTalent()
	local enhanceMO = SkillEnhanceMO.New(self._talentId)

	ToolTipsMgr.showSkillBuffTagSideTips(enhanceMO, self._goUnawakeTalentTips, true)
end

function M:_onClickAwakeTalent()
	local enhanceMO = SkillEnhanceMO.New(self._awakeTalentId)
	local bindGo = self._heroData:getAwakeTalent() and self._goAwakeTalentTips or self._goAwakeLockTips

	ToolTipsMgr.showSkillBuffTagSideTips(enhanceMO, bindGo, true)
end

function M:_onClick6D()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.GuideID.SixDimension
	})
end

function M:_getSkillCOWrapper(skillId)
	local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skillId)

	return skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil
end

function M:_refreshSkill()
	if not self:_elementShow(ElementType.Skill) then
		return
	end

	for _, cell in ipairs(self._skillCells) do
		cell:setActive(false)
	end

	local skills = self._heroData:getActiveNormalSkill()

	for i = 1, 3 do
		local skillId = skills[i] and skills[i].key or 0
		local skillCOWrapper = self:_getSkillCOWrapper(skillId)

		if skillCOWrapper then
			local enhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillId)
			local cell = self._skillCells[i]

			if cell == nil then
				cell = Astral.SimpleLuaComponentContainer.Add(self["_goSkill" .. i], Character3DSkillCell)

				table.insert(self._skillCells, cell)
			end

			local nodes = HeroPowerConfig.instance:getNodesBySkillId(self._heroId, skillId)

			cell:setEnhanceCodes(enhanceCodes)
			cell:setAuthorityEnhanceSkill(self._heroData, nodes, self:_isMaxLevelPreview())
			cell:setData(skillCOWrapper, self._heroId)
		end
	end
end

function M:_refreshAuthority()
	if not self:_elementShow(ElementType.Authority) then
		return
	end

	local skillNodeList = HeroPowerConfig.instance:getSkillNodeCoList(self._heroId)

	for _, cell in ipairs(self._anthorityCell) do
		cell:setActive(false)
	end

	local cellParent = self._goAuthority.transform.parent

	for index, nodeCO in ipairs(skillNodeList) do
		local cell = self._anthorityCell[index]

		if cell == nil then
			local newGo = goutil.cloneAndSetParent(self._goAuthority, cellParent)

			cell = Astral.SimpleLuaComponentContainer.Add(newGo, Character3DAuthorityCell)

			table.insert(self._anthorityCell, cell)
		end

		cell:setLineActive(index ~= #skillNodeList)

		local unlock = true

		if self:_isSkillDetailPreview() then
			unlock = CharacterAuthorityUtil.isNodeUnlock(self._heroData, nodeCO.code)
		end

		cell:setData(nodeCO, self._heroId, unlock)
	end
end

function M:_refreshBreakup()
	if not self:_elementShow(ElementType.Break) then
		return
	end

	local cellParent = self._goBreak.transform.parent

	for breakIndex = 1, HeroBreakConfig.instance:getMaxBreakLevel() do
		local cell = self._anchorBreakCells[breakIndex]

		if cell == nil then
			local newGo = goutil.cloneAndSetParent(self._goBreak, cellParent)

			goutil.setActive(newGo, true)

			cell = Astral.SimpleLuaComponentContainer.Add(newGo, Character3DBreakCell)

			table.insert(self._anchorBreakCells, cell)
		end

		cell:setData(self._heroId, breakIndex)
	end
end

function M:_refresh6D()
	if not self:_elementShow(ElementType.Dimension6) then
		return
	end

	for dimention, value in ipairs(self._heroData:getSixDim()) do
		self["_textDimension" .. dimention].text = value

		self._polygon:InitPolygon(CommEnum.D62PolygonIndex[dimention], CharacterCOUtil.qua2Ratio(value))
	end
end

return M
