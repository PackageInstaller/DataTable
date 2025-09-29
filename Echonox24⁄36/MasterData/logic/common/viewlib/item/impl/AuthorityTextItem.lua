-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/AuthorityTextItem.lua

module("logic.common.viewlib.item.impl.AuthorityTextItem", package.seeall)

local M = class("AuthorityTextItem", UIReusableLuaBehavior)
local kColorLight = "#E2E2E2"
local kColorGray = "#737373"

function M:buildUI()
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
end

function M:destroyUI()
	self._txtTitle = nil
	self._txtContent = nil
end

function M:setEnhanceCode(index, skillType, enhanceCode, isGained)
	local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

	self._txtTitle.text = skillEnhanceCOWrapper:getName()
	self._txtContent.text = skillEnhanceCOWrapper:getDescription(isGained)

	local colorString = isGained and kColorLight or kColorGray

	TextUtils.SetColor(self._txtTitle, colorString)
	TextUtils.SetColor(self._txtContent, colorString)
end

return M
