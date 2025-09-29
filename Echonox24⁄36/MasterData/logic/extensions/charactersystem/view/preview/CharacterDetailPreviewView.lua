-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterDetailPreviewView.lua

module("logic.extensions.charactersystem.view.preview.CharacterDetailPreviewView", package.seeall)

local M = class("CharacterDetailPreviewView", ViewComponent)
local index2Attribure = {
	BattleExtension_pb.Attribute.MAX_HP,
	BattleExtension_pb.Attribute.INSPIRATION,
	BattleExtension_pb.Attribute.ATK_PHY,
	BattleExtension_pb.Attribute.ATK_MAG,
	BattleExtension_pb.Attribute.DEF_PHY,
	BattleExtension_pb.Attribute.DEF_MAG
}
local index2AttrGrade = {
	1,
	2,
	3,
	5,
	4,
	6
}

function M:ctor()
	self._characterData = nil
	self._heroCfgInfo = nil
	self._heroIntroduce = nil
	self._modelCO = nil
	self._echoDate = nil
	self._skillCells = {}
	self._talentId = nil
	self._thinkingId = nil
	self._thinkingSkillId = nil
	self._equipData1 = nil
	self._equipData2 = nil
	self._equipData3 = nil
end

function M:buildUI()
	self._btnClose = self:getBtn("role_preview_view_-1004126632")
	self._goFullLevelPanel = self:getGo("role_preview_view_-1953597862")
	self._goDetailPanel = self:getGo("role_preview_view_-1974066106")
	self._goSkillPanel = self:getGo("role_preview_view_-1341573419")
	self._goHeadIcon = self:getGo("role_preview_view_1318559495")
	self._imgHeadIcon = self:getImage("role_preview_view_205385622")
	self._textName = self:getText("role_preview_view_-436860780")
	self._textLevel = self:getText("role_preview_view_-305158113")
	self._imgQuality = self:getImage("role_preview_view_-1671789256")
	self._goCareer = self:getGo("0&career_475494592")
	self._textMove = self:getText("role_preview_view_-637490103")
	self._textRange = self:getText("role_preview_view_-854082166")
	self._transfArrt = self:getGo("role_preview_view_-70499959").transform
	self._textTalent = self:getText("role_preview_view_-1466900468")
	self._imgTalent = self:getImage("role_preview_view_-874484229")
	self._btnTalent = self:getBtn("role_preview_view_-874484229")
	self._goTalentTipsPos = self:getGo("role_preview_view_-619421452")
	self._textTalentTitle = self:getText("role_preview_view_-315751123")
	self._goSkill1 = self:getGo("10&skill_item_1_-706685850")
	self._goSkill2 = self:getGo("11&skill_item_1_-706685850")
	self._goSkill3 = self:getGo("12&skill_item_1_-706685850")
	self._textSkillTitle = self:getText("role_preview_view_-1778942951")
	self._goEquip = self:getGo("role_preview_view_-264288737")
	self._goEcho = self:getGo("13&rewards_detail_item_2141037416")
	self._goEquip1 = self:getGo("14&rewards_detail_item_2141037416")
	self._goEquip2 = self:getGo("15&rewards_detail_item_2141037416")
	self._goEquip3 = self:getGo("16&rewards_detail_item_2141037416")
	self._imgThinking = self:getImage("role_preview_view_-2131034308")
	self._goThinking = self:getGo("17&thought_skill_item_-1906135219")
	self._goThinkingTipsPos = self:getGo("role_preview_view_1537345941")
	self._textEchoTitle = self:getText("role_preview_view_-1785628117")
	self._textEquipTitle = self:getText("role_preview_view_1605972079")
	self._textThinking = self:getText("role_preview_view_1329398982")

	goutil.setActive(self._goFullLevelPanel, false)
	goutil.setActive(self._goDetailPanel, true)
	goutil.setActive(self._goSkillPanel, false)
end

function M:onEnter()
	local param = self:getFirstParam()

	self._heroId = param.heroId
	self._userId = param.userId
	self._characterDetailType = param.characterDetailType or CommEnum.CharacterDetailType.Oneself

	if self._characterDetailType == CommEnum.CharacterDetailType.OtherUser then
		self._characterData = HeroDetailInfoModel.instance:getHeroDetailInfo(self._userId, self._heroId)

		if self._characterData == nil then
			PlayerCourseAgent.instance:sendGetHeroDetailInfoRequest(self._userId, self._heroId)
		end
	elseif self._characterDetailType == CommEnum.CharacterDetailType.Rank then
		RankAgent.instance:sendGetDungeonTeamRequest(param.rankId, self._userId)
	else
		self._characterData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	end

	self._heroCfgInfo = CharacterConfig.instance:getCfgInfoByID(self._heroId)
	self._heroIntroduce = PastInfoConfig.instance:getCharacterInfo(self._heroId)
	self._modelCO = ModelConfig.instance:getModelConfig(self._heroCfgInfo.modelId)

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:_updateData()
	self:_refreshUI()
	self:_setEvent(true)
end

function M:bindEvents()
	self._btnTalent:AddClickListener(self._onClickTalent, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnTalent:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:_setEvent(false)
end

function M:destroyUI()
	for _, cell in ipairs(self._skillCells) do
		cell:destroyUI()
	end

	self._characterData = nil
	self._heroCfgInfo = nil
	self._heroIntroduce = nil
	self._modelCO = nil
	self._skillCells = nil
	self._talentId = nil
	self._echoDate = nil
	self._thinkingId = nil
	self._thinkingSkillId = nil
	self._equipData1 = nil
	self._equipData2 = nil
	self._equipData3 = nil
end

function M:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.HERO_DETAIL_Info, self._onHeroDetailInfo, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onItemModelChange, self)
		GlobalDispatcher:addEventListener(EventType.GET_RANK_CHARACTER_DETAIL, self._onRankHeroDetail, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_DETAIL_Info, self._onHeroDetailInfo, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onItemModelChange, self)
		GlobalDispatcher:removeEventListener(EventType.GET_RANK_CHARACTER_DETAIL, self._onRankHeroDetail, self)
	end
end

function M:_onHeroDetailInfo(_, msg)
	if msg.userId == self._userId and msg.info.hero.id == self._heroId then
		self._characterData = HeroDetailInfoModel.instance:getHeroDetailInfo(self._userId, self._heroId)

		self:_updateData()
		self:_refreshUI()
	end
end

function M:_onRankHeroDetail(_, team)
	if not team or not team.heros then
		return
	end

	for _, heroInfo in ipairs(team.heros) do
		local heroId = heroInfo.hero.id

		if heroId == self._heroId then
			self._characterData = CharacterDataOthers.New(heroInfo)

			self:_updateData()
			self:_refreshUI()

			return
		end
	end
end

function M:_updateData()
	if not self._characterData then
		return
	end

	local heroData = self._characterData

	self._echoDate = heroData and heroData:getHeroEchoItemData():getEchoItem()
	self._equipData1 = heroData:getHeroEquipData():getEquipByPart(1)
	self._equipData2 = heroData:getHeroEquipData():getEquipByPart(2)
	self._equipData3 = heroData:getHeroEquipData():getEquipByPart(3)
	self._thinkingId = heroData:getThinkingItemData():getThinkingMoId()
	self._thinkingSkillId = heroData:getThinkingItemData():getWearingSkillId()
end

function M:_refreshUI()
	self:_refreshHeroInfo()
	self:_refreshTalent()
	self:_refreshSkill()
	self:_refreshEquip()
end

function M:_refreshHeroInfo()
	local heroData = self._characterData

	self._textName.text = self._heroIntroduce.name
	self._textLevel.text = heroData and heroData:getLevel() or 1

	local careerCell = Astral.SimpleLuaComponentContainer.Add(self._goCareer, CareerCell)

	careerCell:setData(self._heroId)
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, GameUrl.getQualityUrl(self._heroCfgInfo.quality))

	self._textMove.text = self._heroCfgInfo.move
	self._textRange.text = heroData and heroData:getAtkRange() or 1

	for i = 0, self._transfArrt.childCount - 1 do
		local goItem = self._transfArrt:GetChild(i).gameObject
		local textValue = goutil.findChildTextComponent(goItem, "txtValue1")
		local textQuality = goutil.findChildTextComponent(goItem, "txtLevel")

		textValue.text = heroData and heroData:getAttribute(index2Attribure[i + 1]) or "0"

		local attributeGrade = self._heroCfgInfo and self._heroCfgInfo.attributeGrade or {}

		textQuality.text = attributeGrade[index2AttrGrade[i + 1]] or CommEnum.Quality2UpperChar[GameEnum.QualityEnum.A]
	end

	goutil.setActive(self._goHeadIcon, true)
	IconLoader.setSprite(self._imgHeadIcon, IconType.RoleCard, self._modelCO.halfIconName)
end

function M:_refreshTalent()
	self._textTalentTitle.text = lang("tip_talent")
	self._talentId = self._characterData and self._characterData:talentBaseSkillId()

	local talentId = self._characterData and self._characterData:talentSkillId() or self._heroCfgInfo.battleTalent[2]
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(talentId)
	local skillCo = skillCOWrapper:getSkillCO()

	self._textTalent.text = StringUtil.randomReplaceBlackBlock(skillCo.name)

	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCo)

	if not string.nilorempty(iconPath) then
		IconLoader.setSprite(self._imgTalent, IconType.SkillIcon, iconPath, function()
			self._imgTalent:SetNativeSize()
		end, self)
	end
end

function M:_onClickTalent()
	local awakeStatus = self._characterData and self._characterData:isAwakeTalentSkill() or CommEnum.TalentSkillAwakeStatus.Locked
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._talentId
	skillInfo.defaultShowAll = true
	skillInfo.hangGO = self._goTalentTipsPos
	skillInfo.awakeStatus = awakeStatus

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_refreshSkill()
	self._textSkillTitle.text = lang("tip_skill")

	table.clear(self._skillCells)

	local skills = self._heroCfgInfo.normalSkills
	local skillsMO = {}

	for _, skillId in ipairs(skills) do
		local skillEnhanceMo = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._heroId, skillId)
		local skillCOWrapper = skillEnhanceMo and skillEnhanceMo:getSkillCOWrapper() or nil

		table.insert(skillsMO, skillCOWrapper)
	end

	for i = 1, 3 do
		local skillMO = skillsMO[i]
		local cell = Astral.SimpleLuaComponentContainer.Add(self["_goSkill" .. i], CharacterSkillCell)

		cell:setData(skillMO, self._heroId)
		table.insert(self._skillCells, cell)
	end
end

function M:_refreshEquip()
	goutil.setActive(self._goEquip, self._characterData)

	if self._characterData == nil then
		return
	end

	self._textEchoTitle.text = lang("t_echo")
	self._textEquipTitle.text = lang("tip_equip")
	self._textThinking.text = lang("tip_thinking")

	self:_refreshEcho()
	self:_refreshEquipPart()
	self:_refreshThinking()
end

function M:_refreshEcho()
	if self._echoDate then
		local echoItem = Astral.SimpleLuaComponentContainer.Add(self._goEcho, ItemCell)

		echoItem:setShowSelectedEffect(false)
		echoItem:setIsHideLock(self._characterDetailType ~= CommEnum.CharacterDetailType.Oneself)
		echoItem:updateData(self._echoDate)
	end

	goutil.setActive(self._goEcho, self._echoDate)
end

function M:_refreshEquipPart()
	for i = 1, 3 do
		local equipData = self["_equipData" .. i]
		local goEquip = self["_goEquip" .. i]

		if equipData then
			local equipCell = Astral.SimpleLuaComponentContainer.Add(goEquip, ItemCell)

			equipCell:setShowSelectedEffect(false)
			equipCell:setIsHideLock(self._characterDetailType ~= CommEnum.CharacterDetailType.Oneself)
			equipCell:updateData(equipData)
		end

		goutil.setActive(goEquip, equipData)
	end
end

function M:_refreshThinking()
	local thinkingSKillLv
	local hasUsingSkill = self._thinkingSkillId and self._thinkingSkillId > 0

	if hasUsingSkill then
		thinkingSKillLv = self._characterData:getThinkingItemData():getThinkingMo():getSkillLevel(self._thinkingSkillId)

		if thinkingSKillLv then
			local thinkingCell = Astral.SimpleLuaComponentContainer.Add(self._goThinking, ThinkingSkillItemView)

			thinkingCell:refreshView(self._thinkingSkillId, thinkingSKillLv, false)
			thinkingCell:setClickCallback(self._onClickThinking, self)
		end
	end

	local cfg = ThinkingConfig.instance:getThinkingCO(self._thinkingId)

	if cfg and cfg.icon then
		IconLoader.setSprite(self._imgThinking, IconType.Thought, cfg.icon)
	end

	goutil.setActive(self._imgThinking.gameObject, self._thinkingId)
	goutil.setActive(self._goThinking, hasUsingSkill and thinkingSKillLv)
end

function M:_onClickThinking()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._thinkingSkillId
	skillInfo.defaultShowAll = true
	skillInfo.hangGO = self._goThinkingTipsPos

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onClickClose()
	self:close()
end

function M:_onItemModelChange()
	self:_refreshEquipPart()
	self:_refreshEcho()
end

return M
