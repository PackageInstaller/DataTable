-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculateHeadItem.lua

module("logic.extensions.battle.viewcalculate.BattleCalculateHeadItem", package.seeall)

local M = class("BattleCalculateHeadItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buidUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()

	self.mainGO = false
end

function M:buidUI()
	self._rectTran = goutil.addComponentOnce(self.mainGO, goutil.Type_RectTransform)

	RectTransformUtils.SetAnchoredPosition(self.mainGO.transform, 50, 100)

	self._registry = ViewElementsRegistry.New(self.mainGO)

	local expProgressGo = self._registry:findUIElement("headitem1_6070318570944499649")

	self._imgExpProgress = self._registry:findUIElement("headitem1_6070318570944499649", UIComponentType.Image)
	self._expProgressView = Astral.SimpleLuaComponentContainer.Add(expProgressGo, BattleCalculateExpProgress)
	self._imgHeadIcon = self._registry:findUIElement("0&battle_hero_item_892867850", UIComponentType.Image)
	self._txtLevel = self._registry:findUIElement("0&battle_hero_item_1708325635", UIComponentType.Text)
	self._isUp = goutil.findChild(self.mainGO, "imgUp")
	self._imgQuailty = self._registry:findUIElement("0&hero_item_29007724", UIComponentType.Image)
	self._imgLine = goutil.findChildComponent(self._imgQuailty, "imgLine", UIComponentType.Image)
	self._imgCamp = self._registry:findUIElement("0&hero_item_1279221474", UIComponentType.Image)
	self._imgCareerDi = self._registry:findUIElement("0&0&career_-1600786498", UIComponentType.Image)
	self._imgCareerSign = self._registry:findUIElement("0&0&career_1390243743", UIComponentType.Image)
	self._txtExp = self._registry:findUIElement("headitem1_6070318572052780320", UIComponentType.Text)
	self._imgLevelUpFlag = self._registry:findUIElement("headitem1_1046695494")
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
end

function M:destroyUI()
	self._registry:cleanRegistry()

	self._registry = false
	self._imgExpProgress = false
	self._imgHeadIcon = false
	self._txtLevel = false
	self._imgCareerDi = false
	self._imgCareerSign = false
	self._txtExp = false
	self._imgLevelUpFlag = false
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHeroId(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroMO then
		if enableErrorLog then
			printError("cannot find hero model for", heroId)
		end

		return
	end

	self._heroMo = heroMO

	local characterParam = {}
	local characterCO = heroMO:getCharacterCo()
	local modelCO = heroMO:getModelCo()
	local level = heroMO:getLevel()
	local quality = heroMO:getQuality()
	local upgradeExp = CharacterExpConfig.instance:getUpgradeExpByLevelAndQuality(level, quality)

	self._imgExpProgress.fillAmount = heroMO:getLevelExp() / upgradeExp

	IconLoader.setSprite(self._imgHeadIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCO.colorType))
	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCO.career))
	IconLoader.setSprite(self._imgLine, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityLineIcon(heroMO:getQuality()))
	IconLoader.setSprite(self._imgQuailty, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityIcon(heroMO:getQuality()))
	IconLoader.setSprite(self._imgCamp, IconType.CampBattle, BattleIconName.getCampIcon(characterCO.camp))

	characterParam.newLevel = heroMO:getLevel()
	characterParam.newExp = heroMO:getLevelExp()
	characterParam.quality = heroMO:getQuality()

	local heroLevelInfo = BattleCalculateModel.instance:getHeroLevelInfoById(heroId)

	if heroLevelInfo then
		if level > heroLevelInfo.level then
			goutil.setActive(self._isUp, true)
		else
			goutil.setActive(self._isUp, false)
		end

		characterParam.oldLevel = heroLevelInfo.level
		characterParam.oldExp = heroLevelInfo.exp
	end

	local curExp = characterParam.newExp
	local increaseExp, isLevelUp, upgradeLevelExp = CharacterExpConfig.instance:getIncreaseExp(characterParam)

	self._txtLevel.text = string.format("%s", level)

	local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(self._heroMo:getPowerLv(), quality)

	self._showExpAnim = false

	if maxLevel <= level then
		self._txtExp.text = "Max"
		self._imgExpProgress.fillAmount = 1
	else
		self._showExpAnim = true
		self._txtExp.text = string.format("+%sXP", increaseExp)
	end

	self._characterParam = characterParam

	goutil.setActive(self._imgLevelUpFlag, isLevelUp)
end

function M:playExpAni()
	if self._showExpAnim then
		self._expProgressView:setCharacterParam(self._characterParam, self._addExpFinish, self)
	end
end

function M:_addExpFinish()
	self._animation:Play("headitem_leverup")
end

function M:getRectTran()
	return self._rectTran
end

return M
