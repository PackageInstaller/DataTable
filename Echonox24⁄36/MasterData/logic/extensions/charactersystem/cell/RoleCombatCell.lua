-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/cell/RoleCombatCell.lua

module("logic.extensions.charactersystem.cell.RoleCombatCell", package.seeall)

local M = class("RoleCombatCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._txtName = registry:findUIElement("role_combat_-2105291515", UIComponentType.Text)
	self._txtNum = registry:findUIElement("role_combat_2049200865", UIComponentType.Text)
	self._rectTrSignGroup = registry:findUIElement("role_combat_-553190514", UIComponentType.RectTransform)
	self._imgCareerSign = registry:findUIElement("0&career_-612455418", UIComponentType.Image)
	self._goNum = registry:getGo("role_combat_1181385077")
	self._goNotOwn = registry:getGo("role_combat_1450080383")
end

function M:destroyUI()
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end
end

function M:bindEvents()
	self:setEvent(true)
end

function M:unbindEvents()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
	end
end

function M:_handleRefreshHeroDepotData()
	self:updateFightingCapacity()
end

function M:updateHero(heroId)
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self:updateHeroData(heroData)
end

function M:updateHeroData(heroData)
	if heroData then
		if self._heroId and self._heroId == heroData:getId() then
			-- block empty
		else
			self._heroId = heroData:getId()

			local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroId)

			self._txtName.text = heroInfoCO and heroInfoCO.name or ""

			local characterCo = heroData:getCharacterCo()

			if characterCo then
				IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2IconNoDi[characterCo.career])
			end

			self:updateSign(self._heroId)
		end
	else
		self._heroId = nil
	end

	self._txtNum.text = heroData and heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY) or ""
end

function M:updateFightingCapacity()
	if self._heroId then
		local heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

		if heroData and self._txtNum and not goutil.isNil(self._txtNum) then
			self._txtNum.text = heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY)
		end
	end
end

function M:updateSign(heroId)
	local tags = CharacterConfig.instance:getCharacterTags(heroId)
	local root = self._rectTrSignGroup

	while root.childCount < #tags do
		goutil.cloneAndSetParent(root:GetChild(0).gameObject, root)
	end

	for i = 0, root.childCount - 1 do
		local go = root:GetChild(i).gameObject
		local tagId = tags[i + 1]

		if tagId then
			local txtName = goutil.findChildTextComponent(go, "txtSign")
			local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

			txtName.text = tagCO and tagCO.name or ""
		end

		goutil.setActive(go, tagId)
	end
end

function M:setOwned(own)
	goutil.setActive(self._goNum, own)
	goutil.setActive(self._goNotOwn, not own)
end

function M:setSignRootShow(show)
	goutil.setActive(self._rectTrSignGroup.gameObject, show)
end

return M
