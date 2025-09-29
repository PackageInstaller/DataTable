-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uipool/BattleCarrySkillIcon.lua

module("logic.battle.uipool.BattleCarrySkillIcon", package.seeall)

local BattleCarrySkillIcon = class("BattleCarrySkillIcon", IBattleReusable)
local kPoolRoot = PoolRootUtil.createUIPoolRoot("BattleSkillIconPool")

function BattleCarrySkillIcon:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(BattleResourceName.UICarrySkillIcon)

	goutil.addChildToParent(mainGO, kPoolRoot)

	self.mainGO = mainGO

	self:buildUI()
end

function BattleCarrySkillIcon:reuse()
	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function BattleCarrySkillIcon:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
end

function BattleCarrySkillIcon:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function BattleCarrySkillIcon:buildUI()
	self._noneGoList = {
		[BattleEnum.SkillCategory.ECHO] = goutil.findChild(self.mainGO, "none2"),
		[BattleEnum.SkillCategory.DEPUTY] = goutil.findChild(self.mainGO, "none3"),
		[BattleEnum.SkillCategory.EQUIPMENT] = goutil.findChild(self.mainGO, "none1")
	}
	self._goNone = goutil.findChild(self.mainGO, "none1")
	self._goBg = goutil.findChild(self.mainGO, "Image")
	self._goIcon = goutil.findChild(self.mainGO, "imgIcon")
	self._goSelected = goutil.findChild(self.mainGO, "imgSelect")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")
	self._btnClick = Astral.UIClickTrigger.Get(self.mainGO)
	self._clickHandler = Handler.New()

	self._btnClick:AddClickListener(self._onClick, self)

	self._skillId = false
end

function BattleCarrySkillIcon:resetUI()
	self._clickHandler:clear()
	IconLoader.clearSprite(self._imgIcon)
	self:setSelected(false)
end

function BattleCarrySkillIcon:destroyUI()
	self._btnClick:RemoveClickListener()
	self._clickHandler:clear()

	self._goNone = nil
	self._goBg = nil
	self._goIcon = nil
	self._imgIcon = nil
	self._btnClick = nil
end

function BattleCarrySkillIcon:setEmpty(skillType)
	for k, go in pairs(self._noneGoList) do
		goutil.setActive(go, skillType == k)
	end

	goutil.setActive(self._goBg, false)
	goutil.setActive(self._goIcon, false)

	self._heroId = false
	self._skillId = false
	self._skillStatus = false
	self._skillEnhanceCodes = false
	self.mainGO.name = "carry_skill"
end

function BattleCarrySkillIcon:setSkillInfo(heroId, skillId, skillStatus, skillEnhanceCodes)
	self._heroId = heroId
	self._skillId = skillId
	self._skillStatus = skillStatus
	self._skillEnhanceCodes = skillEnhanceCodes

	for k, go in pairs(self._noneGoList) do
		goutil.setActive(go, false)
	end

	goutil.setActive(self._goBg, true)
	goutil.setActive(self._goIcon, true)
	BattleIconName.setSkillIcon(self._imgIcon, skillId)
end

function BattleCarrySkillIcon:getHeroId()
	return self._heroId
end

function BattleCarrySkillIcon:getSkillId()
	return self._skillId
end

function BattleCarrySkillIcon:setSelected(selected)
	goutil.setActive(self._goSelected, selected)
end

function BattleCarrySkillIcon:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function BattleCarrySkillIcon:_onClick()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._heroId
	skillInfo.skillId = self._skillId
	skillInfo.enhanceCodes = self._skillEnhanceCodes
	skillInfo.skillStatus = self._skillStatus

	self._clickHandler:call(skillInfo, self.mainGO)
end

return BattleCarrySkillIcon
