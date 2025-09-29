-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewvs/BattleVsUnitInfoView.lua

module("logic.extensions.battle.viewvs.BattleVsUnitInfoView", package.seeall)

local BattleVsUnitInfoView = class("BattleVsUnitInfoView")
local kVector2 = Vector2.New()

function BattleVsUnitInfoView:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function BattleVsUnitInfoView:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function BattleVsUnitInfoView:buildUI()
	self._imgHeadIcon = goutil.findChildImageComponent(self.mainGO, "headIcon1")
	self._bloodBar = UIBattleBloodBar.New(goutil.findChild(self.mainGO, "progress/battle_xuetiao"))
	self._txtBlood = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "career"))
	self._sanityGroup = UIBattleSanityGroup.New(goutil.findChild(self.mainGO, "sanity"))
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "sanity/sanity_copy"))
	self._weakPoint = UIBattleWeakPointFillComp.New(goutil.findChild(self.mainGO, "weak_fill1"))

	self._weakPoint:setVisible(false)
end

function BattleVsUnitInfoView:destroyUI()
	self._sanityGroup:destroy()
	self._sanity:destroy()
	self._weakPoint:destroy()
	self._career:destroy()

	self._sanityGroup = nil
	self._weakPoint = nil
	self._imgHeadIcon = nil
	self._txtBlood = nil
	self._txtLevel = nil
	self._career = nil
end

function BattleVsUnitInfoView:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function BattleVsUnitInfoView:setUnit(unit)
	local property = unit.property
	local modelCO = ModelConfig.instance:getModelConfig(property:getModelCode())

	IconLoader.setSprite(self._imgHeadIcon, IconType.RoleCard, modelCO.halfIconName)

	local rotation = modelCO.headIconReverse == 1 and 180 or 0

	Astral.TransformUtil.SetLocalRotation(self._imgHeadIcon.gameObject.transform, 0, rotation, 0)

	local bloodPercent = property:getHp() / property:getMaxHp()

	self._bloodBar:setActiveBloodBar(BattleUISettingUtil.getRelationType(unit.property:getCampId()))
	self._bloodBar:setBlood(bloodPercent)
	unit.property:setCurPerformanceHp(property:getHp())
	self._bloodBar:setPerformanceHp(bloodPercent)

	self._txtBlood.text = string.format("<color=#e1e1e1><size=18>%d</size></color>/%d", property:getHp(), property:getMaxHp())
	self._txtLevel.text = string.format("Lv.%s", property:getLevel())

	if property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		self._sanityGroup:setVisible(true)
		self._sanityGroup:setSanity(property:getSanity())
		self._sanity:setVisible(true)
		self._sanity:setSanity(property:getSanity(), false, true)
	else
		self._sanityGroup:setVisible(false)
		self._sanity:setVisible(false)
	end

	self._weakPoint:updateBaseInfo(unit)
	self._career:setCareerAndColorType(property:getCareer(), property:getColorType())
end

function BattleVsUnitInfoView:updateUnit(unit, attackInfo)
	local property = unit.property
	local bloodPercent = property:getHp() / property:getMaxHp()
	local perfomranceHpPercent = property:getCurPerformanceHp() / property:getMaxHp()

	self._bloodBar:setBlood(bloodPercent)
	self._bloodBar:playBloodGradualChange(perfomranceHpPercent)

	self._txtBlood.text = string.format("<color=#e1e1e1><size=18>%d</size></color>/%d", property:getHp(), property:getMaxHp())

	self._weakPoint:updatePerformance(unit)
end

return BattleVsUnitInfoView
