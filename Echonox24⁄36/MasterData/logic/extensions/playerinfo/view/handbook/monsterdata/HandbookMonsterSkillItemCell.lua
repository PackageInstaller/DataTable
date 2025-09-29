-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterSkillItemCell.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterSkillItemCell", package.seeall)

local M = class("HandbookMonsterSkillItemCell", UIReusableLuaBehavior)

function M:buildUI()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtSkillName")
	self._txtEffect = goutil.findChildTextComponent(self.mainGO, "scroll/view/txtDesc")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "cell/skill_item_1/imgIcon")

	local goSanityRoot = goutil.findChildImageComponent(self.mainGO, "cell/skill_item_1/star")

	goutil.setActive(goSanityRoot, false)
end

function M:destroyUI()
	self._txtName = nil
	self._txtEffect = nil
	self._imgIcon = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	IconLoader.clearSprite(self._imgIcon)
end

function M:setData(skillEnhanceCO)
	self._txtName.text = skillEnhanceCO:getName()
	self._txtEffect.text = skillEnhanceCO:getDescription(false)

	local skillCO = skillEnhanceCO:getSkillCO()

	if skillCO then
		IconLoader.setSprite(self._imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
	end
end

return M
