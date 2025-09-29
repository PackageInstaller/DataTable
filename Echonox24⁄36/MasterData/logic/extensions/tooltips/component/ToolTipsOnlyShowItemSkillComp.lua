-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsOnlyShowItemSkillComp.lua

module("logic.extensions.tooltips.component.ToolTipsOnlyShowItemSkillComp", package.seeall)

local M = class("ToolTipsOnlyShowItemSkillComp", ViewComponent)

function M:buildUI()
	self._txtSkillAttribute = self:getUIComponent("item_tips_67372985", UIComponentType.TextMeshProUGUI)
	self._getWayGo = self:getGo("item_detail_tips_827817151")
end

function M:onEnter()
	local info = self:getFirstParam()

	if info.baseData then
		local itemInfo = info.baseData:getItemInfo()

		if itemInfo and info.baseData:getType() == GameEnum.ItemTypeEnum.OnlyShowItem then
			local skillId = string.match(itemInfo.skillDesc, "%d+")

			self:setSkillId(skillId)
		end
	end
end

function M:onEnterFinished()
	goutil.setActive(self._getWayGo, false)
end

function M:setSkillId(skillId)
	if not skillId then
		return
	end

	local skill = ActiveSkillConfig.instance:getActiveSkillCOWrapper(tonumber(skillId))

	if not skill then
		return
	end

	goutil.setActive(self._txtSkillAttribute.gameObject, true)

	local txtSkill = lang("tip_equip_suit_change") .. "\n" .. skill:getDescription()

	self._txtSkillAttribute.text = "<color=#E8E7E7>" .. txtSkill .. "</color>"
end

return M
