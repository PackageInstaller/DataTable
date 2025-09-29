-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillUpgrade.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillUpgrade", package.seeall)

local M = class("AchievementSkillUpgrade", ViewComponent)
local ShowType = {
	UnLock = "unlock",
	UpGrade = "upgrade"
}

function M:ctor()
	M.super.ctor(self)

	self._flagList = {}
end

function M:buildUI()
	self._btnClick = self:getBtn("0&common_full_tips_bg_1933710455")
	self._txtNum = self:getText("2&achievement_list_item_copy_816973484")
	self._txtTitle = self:getText("achievement_upgrade_show_panel_1882586058")
	self._txtDescUnLock = self:getText("achievement_upgrade_show_panel_-127182581")
	self._upgradeGo = self:getGo("achievement_upgrade_show_panel_-662347795")
	self._imgIconUpgrade = self:getImage("2&achievement_list_item_copy_1394270247")
	self._txtNameUpgrade = self:getText("2&achievement_list_item_copy_222320816")
	self._txtDescUpgrade1 = self:getText("achievement_upgrade_show_panel_-529448009")
	self._txtDescUpgrade2 = self:getText("achievement_upgrade_show_panel_-1613335257")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._btnClose, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Task)

	local params = self:getOpenParam()

	self._skillMoList = params[1]
	self._showType = params[2]
	self._moIndex = 1

	self:_refreshData()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	IconLoader.clearSprite(self._imgIconUpgrade)
end

function M:onExitFinished()
	local rewards = AchievementModel.instance:getRewards()

	if rewards then
		GainItemController.instance:openView(rewards)
		AchievementModel.instance:setRewards(false)
	end

	GlobalDispatcher:dispatchEvent(EventType.CHECK_MONUMENTS_POP_EVENT)
end

function M:_refreshData()
	local skillMo = self._skillMoList[self._moIndex]

	if not skillMo then
		return
	end

	IconLoader.setSprite(self._imgIconUpgrade, IconType.AchievementSkill, skillMo:getIcon())

	if self._showType == ShowType.UpGrade then
		self._txtTitle.text = lang("tips_achievementskill_upgrade")
	else
		self._txtTitle.text = lang("tips_achievementskill_unlock")
	end

	self._txtNameUpgrade.text = skillMo:getName()

	goutil.setActive(self._upgradeGo, self._showType == ShowType.UpGrade)
	goutil.setActive(self._txtDescUnLock.gameObject, self._showType ~= ShowType.UpGrade)

	local level = skillMo:getLevel()

	self._txtNum.text = string.format("Lv.%s", level)

	local moPre = AchievementModel.instance:getSkillLevelMo(skillMo:getId(), level, false)

	if moPre then
		local desc = self:_getColorDesc(moPre)

		if moPre:getLevel() ~= 0 then
			if string.find(desc, "%s", 1, true) then
				self._txtDescUpgrade1.text = string.format(desc, tonumber(moPre:getEffectValue()))
			else
				self._txtDescUpgrade1.text = desc
			end
		else
			self._txtDescUpgrade1.text = lang("tip_character_skill_noeffect")
		end
	end

	local desc = self:_getColorDesc(skillMo)

	if string.find(desc, "%s", 1, true) then
		self._txtDescUnLock.text = TextUtils.GetPunctuationFixedText(string.format(desc, tonumber(skillMo:getEffectValue())), self._txtDescUnLock, 0, 200)
		self._txtDescUpgrade2.text = string.format(desc, tonumber(skillMo:getEffectValue()))
	else
		self._txtDescUnLock.text = TextUtils.GetPunctuationFixedText(desc, self._txtDescUnLock, 0, 200)
		self._txtDescUpgrade2.text = desc
	end

	self._moIndex = self._moIndex + 1
end

function M:_btnClose()
	if self._moIndex <= #self._skillMoList then
		self:_refreshData()
	else
		ViewMgr.instance:close(ViewName.AchievementSkillUpgrade)
	end
end

function M:_getColorDesc(mo)
	local desc = mo:getDescOne()
	local color = string.format("<color=%s>", mo:getEffectColor())
	local descArr = string.split(desc, "%s%%")

	if #descArr > 1 then
		desc = string.format("%s%s%s", descArr[1] .. color, "%s%%", "</color>" .. descArr[2])
	else
		descArr = string.split(desc, "%s")

		if #descArr > 1 then
			desc = string.format("%s%s%s", descArr[1] .. color, "%s", "</color>" .. descArr[2])
		end
	end

	return desc
end

return M
