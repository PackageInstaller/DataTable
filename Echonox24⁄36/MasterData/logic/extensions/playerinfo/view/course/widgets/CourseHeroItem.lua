-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseHeroItem.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseHeroItem", package.seeall)

local M = class("CourseHeroItem", CourseEditItem)

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()

	self._clickHeroHandler = nil
	self._clickEditHandler = nil
end

function M:buildUI()
	local registry = self._registry

	self._emptyGo = registry:findUIElement("player_course_edit_item_-1910515523")
	self._heroGo = registry:findUIElement("player_course_edit_item_-621164988")
	self._editGo = registry:findUIElement("player_course_edit_item_-753098675")
	self._signGo = registry:findUIElement("player_course_edit_item_-1813970186")
	self._heroBtn = registry:findUIElement("player_course_edit_item_1750954076", UIComponentType.ButtonAdapter)
	self._editBtn = registry:findUIElement("player_course_edit_item_-753098675", UIComponentType.ButtonAdapter)
	self._lvTxt = registry:findUIElement("player_course_edit_item_-364485619", UIComponentType.Text)
	self._careerBgImg = registry:findUIElement("0&career_-1600786498", UIComponentType.Image)
	self._careerSignImg = registry:findUIElement("0&career_1390243743", UIComponentType.Image)
	self._campImg = registry:findUIElement("player_course_hero_item_554271026", UIComponentType.Image)
	self._heroHeadImg = registry:findUIElement("player_course_edit_item_1990097001", UIComponentType.Image)
	self._heroQaImg = goutil.findChildComponent(self._heroGo, "imgDi", UIComponentType.Image)
	self._imgQualityLine = goutil.findChildComponent(self._heroGo, "imgDi/imgLine", UIComponentType.Image)

	goutil.setActive(self.mainGO, true)
	goutil.setActive(self._signGo, false)
	goutil.setActive(self._editGo, false)

	self._clickHeroHandler = Handler.New()
	self._clickEditHandler = Handler.New()
end

function M:bindEvents()
	self._editBtn:AddClickListener(self.onClickEdit, self)
	self._heroBtn:AddClickListener(self.onClickHero, self)
end

function M:unbindEvents()
	self._editBtn:RemoveClickListener()
	self._heroBtn:RemoveClickListener()
	self._clickHeroHandler:clear()
	self._clickEditHandler:clear()
end

function M:_onLoadCmapFinish()
	self._campImg:SetNativeSize()
end

function M:AddEditClickListener(callback, handler, ...)
	self._clickEditHandler:setListener(callback, handler)
end

function M:AddClickListener(callback, handler, ...)
	self._clickHeroHandler:setListener(callback, handler)
end

function M:setHero(hero)
	self:showHero(true)

	self._heroId = hero:getId()
	self._lvTxt.text = string.format("%s", hero:getLv())

	local characterCO = hero:getCharacterCo()

	IconLoader.setSprite(self._heroQaImg, IconType.Skinlib, CharacterCOUtil.quality2IconName(characterCO.quality))
	IconLoader.setSprite(self._imgQualityLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(characterCO.quality))
	IconLoader.setSprite(self._careerBgImg, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCO.colorType))
	IconLoader.setSprite(self._careerSignImg, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCO.career))
	IconLoader.setSprite(self._campImg, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[characterCO.camp])

	local skinCo = hero:getSkinCo()

	if skinCo then
		IconLoader.setSprite(self._heroHeadImg, IconType.HeadIcon, skinCo.headIconName)
	else
		local mo = ModelConfig.instance:getModelConfig(characterCO.modelId)

		IconLoader.setSprite(self._heroHeadImg, IconType.HeadIcon, mo.headIconName)
	end
end

function M:showHero(active)
	goutil.setActive(self._heroGo, active)
	goutil.setActive(self._emptyGo, not active)
end

function M:showEdit(active)
	goutil.setActive(self._editGo, active)
end

function M:showSign(active)
	goutil.setActive(self._signGo, active)
end

function M:showEntity(entity)
	if entity then
		self:setHero(entity)
	else
		self:showHero(false)
		self:showSign(false)
	end
end

function M:setIndex(index)
	self._showIndex = index
end

function M:onClickHero()
	self._clickHeroHandler:call(self._heroId, self._showIndex)
end

function M:onClickEdit()
	self._clickEditHandler:call()
end

return M
