-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/CareerComponent.lua

module("logic.extensions.backpack.cellcomponent.CareerComponent", package.seeall)

local M = class("CareerComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._goCareer = registry:findUIElement("3&career_475494592")
	self._imgCareer = registry:findUIElement("3&career_1390243743", UIComponentType.Image)
	self._imgCareerDi = registry:findUIElement("3&career_-1600786498", UIComponentType.Image)
end

function M:updateData(data)
	if not data or not self._goCareer then
		return
	end

	local isHeroData = data:getType() == GameEnum.ItemTypeEnum.HeroType

	goutil.setActive(self._goCareer, isHeroData)

	if not isHeroData then
		return
	end

	local characterCO = CharacterConfig.instance:getCfgInfoByID(data:getItemId())

	if characterCO then
		self._modelID = characterCO.modelId

		IconLoader.setSprite(self._imgCareer, IconType.Skinlib, CommEnum.Career2Icon[characterCO.career])
		IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CommEnum.ColorType2Icon[characterCO.colorType])
	else
		goutil.setActive(self._goCareer, false)
	end
end

return M
