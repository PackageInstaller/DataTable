-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/CarrySkillItem.lua

module("logic.common.viewlib.item.impl.CarrySkillItem", package.seeall)

local M = class("CarrySkillItem", UIReusableLuaBehavior)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:buildUI()
	self._noneGoList = {
		[BattleEnum.SkillCategory.ECHO] = goutil.findChild(self.mainGO, "none2"),
		[BattleEnum.SkillCategory.DEPUTY] = goutil.findChild(self.mainGO, "none3"),
		[BattleEnum.SkillCategory.EQUIPMENT] = goutil.findChild(self.mainGO, "none1")
	}
	self._goNone = goutil.findChild(self.mainGO, "none1")
	self._goBg = goutil.findChild(self.mainGO, "Image")
	self._goIcon = goutil.findChild(self.mainGO, "imgIcon")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")
	self._btnClick = Astral.UIClickTrigger.Get(self.mainGO)
	self._clickHandler = Handler.New()
	self._skillId = false
end

function M:destroyUI()
	self._clickHandler:clear()

	self._goNone = nil
	self._goBg = nil
	self._goIcon = nil
	self._imgIcon = nil
	self._btnClick = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setSkillInfo(heroId, skillId, skillStatus, skillEnhanceCodes)
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

function M:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function M:_onClick()
	self._clickHandler:call(self._heroId, self._skillId, self._skillEnhanceCodes, self._skillStatus)
end

return M
