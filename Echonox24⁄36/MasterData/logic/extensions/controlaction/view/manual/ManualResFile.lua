-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualResFile.lua

module("logic.extensions.controlaction.view.manual.ManualResFile", package.seeall)

local M = class("ManualResFile")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._skillRootGo = goutil.findChild(self._mainGo, "skillContent/skillList/viewPort/content")
	self._skillItemGo = goutil.findChild(self._skillRootGo, "skill_icon")

	goutil.addChildToParent(self._skillItemGo, goutil.findChild(self._mainGo, "skillContent/skillList/viewPort"))
	goutil.setActive(self._skillItemGo, false)

	self._descRootGo = goutil.findChild(self._mainGo, "mechanicesContent/scroll/viewPort/content")
	self._descItemGo = goutil.findChild(self._descRootGo, "progItem")

	goutil.addChildToParent(self._descItemGo, goutil.findChild(self._mainGo, "mechanicesContent/scroll/viewPort"))
	goutil.setActive(self._descItemGo, false)
	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	self:_removeListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:refresh(mo)
	self._mo = mo

	self:_setData()
end

function M:_removeListener()
	for i = 1, self._skillRootGo.transform.childCount do
		local child = self._skillRootGo.transform:GetChild(i - 1).gameObject
		local btnClick = Astral.ButtonAdapter.Get(child)

		btnClick:RemoveClickListener()
	end
end

function M:_setData()
	self:_setSkills()

	local desc = self._mo.co.describe

	self._descList = string.split(desc, "#")

	printWarn("====#self._descList====", #self._descList)
	goutil.clearChildren(self._descRootGo)

	for i, v in ipairs(self._descList) do
		local obj = goutil.clone(self._descItemGo, "descItem" .. i)

		goutil.setActive(obj, true)
		goutil.addChildToParent(obj, self._descRootGo)

		local txtNumber = goutil.findChildTextComponent(obj, "Image2/txtNum")
		local txtContent = goutil.findChildTextComponent(obj, "txtContent")

		if i < 10 then
			txtNumber.text = string.format("0%s", i)
		else
			txtNumber.text = i
		end

		txtContent.text = v
	end
end

function M:_setSkills()
	local heroId = self._mo.co.monstercode
	local skills = self._mo.co.skills

	self:_removeListener()
	goutil.clearChildren(self._skillRootGo)

	for i, cell in ipairs(skills) do
		local obj = goutil.clone(self._skillItemGo, "skillItem" .. i)

		goutil.setActive(obj, true)
		goutil.addChildToParent(obj, self._skillRootGo)

		local markPass = goutil.findChild(obj, "markPassive")
		local markCD = goutil.findChild(obj, "cdSign")
		local imgIcon = goutil.findChildImageComponent(obj, "imgIcon")
		local skillId = skills[i]
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
		local skillCO = skillCOWrapper:getSkillCO()
		local isPassiveSkill = ActiveSkillCOUtil.isPassive(skillCOWrapper)

		IconLoader.setSprite(imgIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
		goutil.setActive(markCD, skillCOWrapper:getCd() > 0)
		goutil.setActive(markPass, isPassiveSkill)

		local btnClick = Astral.ButtonAdapter.Get(obj)

		btnClick:AddClickListener(function()
			self:_onSkillCellClick(heroId, skillId, obj)
		end, self)
	end
end

function M:_onSkillCellClick(heroId, skillId, cellGo)
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = heroId
	skillInfo.skillId = skillId
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = cellGo
	skillInfo.awakeStatus = TacitModel.instance:isAwakeTalentSkill(heroId, true)

	ToolTipsMgr.showManualSkillTips(skillInfo)
end

return M
