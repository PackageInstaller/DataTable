-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUpgradeSuccessView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUpgradeSuccessView", package.seeall)

local M = class("ThinkingUpgradeSuccessView", ViewComponent)

function M:buildUI()
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "common_full_tips_bg/clickExit"))
	self._txtName = goutil.findChildTextComponent(self.mainGO, "allContent/txtName")

	local skillItemGo = goutil.findChild(self.mainGO, "allContent/thought_skill_item")

	self._txtContent = goutil.findChildComponent(self.mainGO, "allContent/scrollView/viewPort/content/txtContent", UIComponentType.TextMeshProUGUI)
	self._cellTipsSkill = Astral.SimpleLuaComponentContainer.Add(skillItemGo, ThinkingSkillItemView)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getFirstParam()

	self._thinkingId = param.thinkingId
	self._skillId = param.skillId

	self:_refreshView()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_refreshView()
	local thinkingMO = ThinkingModel.instance:getMoById(self._thinkingId)
	local skillId = self._skillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local skillName, skillDesc, skillIcon = thinkingMO:getSkillData(skillId, skillLevel)

	self._cellTipsSkill:refreshView(skillId, skillLevel, false)

	self._txtName.text = skillName
	self._txtContent.text = skillDesc
end

function M:_onClickClose()
	self:close()
end

return M
