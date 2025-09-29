-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/UnitCompInfoBar.lua

module("logic.scene.unit.component.UnitCompInfoBar", package.seeall)

local M = class("UnitCompInfoBar", UnitComponentBase)
local URL_INFOBAR = ResName.Team_hero_name_item

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = nil
end

function M:onInit()
	self._followUIComp = self._unit.uiFollow
end

function M:onReset()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = false
	end

	if self._resLoader then
		self._resLoader:clear()
	end

	self._isVisible = false
end

function M:onDestroy()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = false
end

function M:showByData(visible)
	self:setVisible(visible)
end

function M:setVisible(visible, exit)
	self._isVisible = visible

	if self._goInst then
		self:_setVisible()
	else
		if exit then
			return
		end

		if self._resLoader then
			self._resLoader:load(URL_INFOBAR, self._onResLoaded, self)
		end
	end
end

function M:_setVisible()
	goutil.setActive(self._goInst, self._isVisible)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addFollowGameObject(UIFollowType.Top, self._goInst)
	self._followUIComp:setPivot(UIFollowType.Top, 0, 1)

	local heroData = HeroDepotModel.instance:re(self._unit.heroId)
	local modelCO = heroData:getModelCo()

	self._followUIComp:setPerspectiveEnable(true)
	self:_setVisible()
end

function M:_buildUI(mainGO)
	self._viewElementsRegistry = ViewElementsRegistry.New()

	self._viewElementsRegistry:setMainGO(mainGO)

	self._txtName = self._viewElementsRegistry:findUIElement("team_hero_name_item_361616848", UIComponentType.Text)
	self._txtLevel = self._viewElementsRegistry:findUIElement("team_hero_name_item_963333899", UIComponentType.Text)
	self._careerDiIcon = self._viewElementsRegistry:findUIElement("0&career_-1600786498", UIComponentType.Image)
	self._careerSignIcon = self._viewElementsRegistry:findUIElement("0&career_1390243743", UIComponentType.Image)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(self._unit.heroId)
	local characterCO = heroData:getCharacterCo()

	self._txtName.text = heroData:getName()
	self._txtLevel.text = "Lv." .. tostring(heroData:getLevel())

	IconLoader.setSprite(self._careerDiIcon, IconType.Skinlib, CommEnum.ColorType2Icon[characterCO.colorType])
	IconLoader.setSprite(self._careerSignIcon, IconType.Skinlib, CommEnum.Career2Icon[characterCO.career])
end

function M:_onChangeVisible(visible)
	self:showByData(visible)
end

function M:clear()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end
end

return M
