-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/SkillSmallTipsView.lua

module("logic.extensions.common.view.SkillSmallTipsView", package.seeall)

local M = class("SkillSmallTipsView", ViewComponent)

function M:buildUI()
	self._upGo = goutil.findChild(self.mainGO, "btn_skill_bonus/btnUp")
	self._downGo = goutil.findChild(self.mainGO, "btn_skill_bonus/btnDown")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtSkillName")
	self._txtInfo = goutil.findChildTextComponent(self.mainGO, "txtSkillDesc")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onBtnClose, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	local param = self:getFirstParam()
	local skillType = param.skillType
	local isShowDown = skillType == CommEnum.CharacterSkillType.Type6 or skillType == CommEnum.CharacterSkillType.Type7
	local mo = AchievementModel.instance:getCurrSkillLevelMo(skillType)
	local name = mo:getName()
	local level = mo:getLevel()
	local desc1 = mo:getDescOne()
	local desc2 = mo:getDescTwo()

	if string.find(desc1, "%s", 1, true) and level ~= 0 then
		desc1 = string.format(desc1, tonumber(mo:getEffectValue()))
	end

	self._txtTitle.text = name
	self._txtInfo.text = level == 0 and desc2 or desc1

	goutil.setActive(self._upGo, not isShowDown)
	goutil.setActive(self._downGo, isShowDown)
end

function M:onExit()
	return
end

function M:_onBtnClose()
	self:close()
end

return M
