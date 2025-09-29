-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/HeroHeadItem.lua

module("logic.common.viewlib.item.impl.HeroHeadItem", package.seeall)

local M = class("HeroHeadItem", UIReusableLuaBehavior)

function M:buildUI()
	self._goNormal = goutil.findChild(self.mainGO, "pos/normal")
	self._goNone = goutil.findChild(self.mainGO, "pos/imgNone")
	self._goEffect = goutil.findChild(self.mainGO, "vx")
	self._normalCanvasGroup = goutil.addComponentOnce(self._goNormal, ComponentType.CanvasGroup)
	self._noneCanvasGrop = goutil.addComponentOnce(self._goNone, ComponentType.CanvasGroup)
	self._imgHeroIcon = goutil.findChildImageComponent(self.mainGO, "pos/normal/headScale/heroIcon")
	self._imgQuality = goutil.findChildImageComponent(self.mainGO, "pos/normal/imgQuality")
	self._imgQualityLine = goutil.findChildImageComponent(self.mainGO, "pos/normal/imgQuality/imgLine")
	self._imgCamp = goutil.findChildImageComponent(self.mainGO, "pos/normal/camp/imgCamp")
	self._imgCareerDi = goutil.findChildImageComponent(self.mainGO, "pos/normal/career/type1/imgCareerDi")
	self._imgCareerSign = goutil.findChildImageComponent(self.mainGO, "pos/normal/career/type1/imgCareerSign")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "pos/normal/txtLv")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "pos/click"))
	self._goSelected = goutil.findChild(self.mainGO, "pos/imgSelect")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "pos/normal/txtName")
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
end

function M:destroyUI()
	self._imgHeroIcon = false
	self._imgQuality = false
	self._imgQualityLine = false
	self._imgCamp = false
	self._imgCareerDi = false
	self._imgCareerSign = false
	self._txtLevel = false
	self._btnClick = false
	self._goSelected = false
	self._handler = false
	self._clickFunc = false
	self._heroMO = false
	self._animation = false
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	IconLoader.clearSprite(self._imgHeroIcon)
	IconLoader.clearSprite(self._imgCareerDi)
	IconLoader.clearSprite(self._imgCareerSign)
	self._animation:Stop()

	self._heroMO = false
	self._handler = false
	self._clickFunc = false

	self:setSelected(false)
	self:showName(false)
	self:showCamp(false)
	self:setNameTxtColor("#FFFFFF")
end

function M:playOpenAnimation(immediately)
	if immediately then
		self._normalCanvasGroup.alpha = 1

		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goNone, false)
		goutil.setActive(self._goEffect, false)
	else
		self._animation:Play("hero_item_open")
	end
end

function M:playCloseAnimation(immediately)
	if immediately then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goNone, false)
		goutil.setActive(self._goEffect, false)
	else
		self._animation:Play("hero_item_close")
	end
end

function M:setHeroMO(heroMO)
	self._heroMO = heroMO

	local characterCO = heroMO:getCharacterCo()
	local modelCO = heroMO:getModelCo()

	self._txtLevel.text = string.format("Lv.%s", heroMO:getLevel())

	IconLoader.setSprite(self._imgHeroIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CharacterCOUtil.quality2IconName(characterCO.quality))
	IconLoader.setSprite(self._imgQualityLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(characterCO.quality))
	IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCO.colorType))
	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCO.career))
	IconLoader.setSprite(self._imgCamp, IconType.CampBattle, BattleIconName.getCampIcon(characterCO.camp))
end

function M:getHeroMO()
	return self._heroMO
end

function M:showName(show)
	local nameStr = show and self._heroMO:getName() or ""

	self._txtName.text = nameStr
end

function M:setNameTxtColor(colorStr)
	self._txtName.color = parsecolor(colorStr)
end

function M:setSelected(selected)
	goutil.setActive(self._goSelected, selected)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setClickFunc(clickFunc, clickTable, ...)
	self._clickFunc = clickFunc
	self._clickTable = clickTable
	self._clickParam = ...
end

function M:setIsNone(isNone)
	goutil.setActive(self._goNormal.gameObject, not isNone)

	self._noneCanvasGrop.alpha = isNone and 1 or 0

	goutil.setActive(self._goNone.gameObject, isNone)
end

function M:setLevel(level)
	self._txtLevel.text = string.format("Lv.%s", level)
end

function M:showCareer(show)
	goutil.setActive(self._imgCareerDi.gameObject, show)
	goutil.setActive(self._imgCareerSign.gameObject, show)
end

function M:showLevel(show)
	goutil.setActive(self._txtLevel.gameObject, show)
end

function M:showCamp(show)
	goutil.setActive(self._imgCamp.gameObject, show)
end

function M:showQuality(show)
	goutil.setActive(self._imgQuality.gameObject, show)
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickTable, self, self._clickParam and unpack(self._clickParam) or nil)
	end

	if self._handler then
		self._handler:onClickHeroItem(self)
	end
end

return M
