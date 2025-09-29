-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleCareer.lua

module("logic.battle.uilib.UIBattleCareer", package.seeall)

local UIBattleCareer = class("UIBattleCareer")

function UIBattleCareer:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function UIBattleCareer:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function UIBattleCareer:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "type1/imgCareerSign")
	self._imgIconBg = goutil.findChildImageComponent(self.mainGO, "type1/imgCareerDi")
	self._maskGo = goutil.findChild(self.mainGO, "type1/mask")
end

function UIBattleCareer:destroyUI()
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgIconBg)

	self._imgIcon = nil
	self._imgIconBg = nil
end

function UIBattleCareer:setCareerAndColorType(career, colorType)
	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Battle, BattleIconName.getCareerIcon(career))
	IconLoader.setSprite(self._imgIconBg, IconType.DynSpriteAtlas_Battle, BattleIconName.getColorTypeIcon(colorType))
end

function UIBattleCareer:setWeakColorAndColorTypeOfScene(color)
	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Battle, BattleIconName.getCareerIcon(color))
	goutil.setWidth(self._imgIconBg.gameObject.transform, 0)
end

function UIBattleCareer:setMask(isMask)
	goutil.setActive(self._maskGo, isMask)
end

function UIBattleCareer:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

return UIBattleCareer
