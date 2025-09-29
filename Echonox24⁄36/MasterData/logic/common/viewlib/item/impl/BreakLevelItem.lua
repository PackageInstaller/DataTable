-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/BreakLevelItem.lua

module("logic.common.viewlib.item.impl.BreakLevelItem", package.seeall)

local M = class("BreakLevelItem", UIReusableLuaBehavior)
local kColorLight = "#CD8B50"
local kColorGray = "#6F6F6F"

function M:buildUI()
	self._breakPointView = Astral.SimpleLuaComponentContainer.Add(self.mainGO, BreakPointItemView)
	self._goLight = goutil.findChild(self.mainGO, "break_point/point")
	self._goDark = goutil.findChild(self.mainGO, "break_point/Di")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
end

function M:destroyUI()
	self._breakPointView = nil
	self._goLight = nil
	self._goDark = nil
	self._txtContent = nil
end

function M:setEnhanceCode(index, skillType, enhanceCode, isGained)
	local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

	goutil.setActive(self._goLight, isGained)

	self._txtContent.text = skillEnhanceCOWrapper:getDescription(isGained)

	self._breakPointView:setRankView(index)

	local colorString = isGained and kColorLight or kColorGray

	TextUtils.SetColor(self._txtContent, colorString)
end

return M
