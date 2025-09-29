-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleTagSideHintItem.lua

module("logic.extensions.battle.viewsidehint.BattleTagSideHintItem", package.seeall)

local M = class("BattleTagSideHintItem")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
end

function M:destroy()
	self:destroyUI()
end

function M:buildUI()
	local goLabel = goutil.findChild(self.mainGO, "imgLabel")

	if goLabel then
		self._imgIcon = goutil.addComponentOnce(goLabel, ComponentType.ImageLocalization)
	end

	self._txtNum1 = goutil.findChildTextComponent(self.mainGO, "txtNum1")
	self._txtNum2 = goutil.findChildTextComponent(self.mainGO, "txtNum2")
end

function M:destroyUI()
	self._imgIcon = nil
	self._txtNum1 = nil
	self._txtNum2 = nil
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function M:setTagIdAndCount(tagId, continuousIndex)
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

	if not tagCO then
		if BattleLog.enableError then
			BattleLog.error("Cannot find tagCO for", tagId)
		end

		return
	end

	if self._imgIcon then
		local iconName = BattleIconName.getTagLableIcon(tagCO.typeName, continuousIndex)

		self._imgIcon:SetSprite(iconName)
	end

	self:setContinuousIndex(continuousIndex)
end

function M:setContinuousIndex(continuousIndex)
	if continuousIndex < 3 then
		return
	end

	if continuousIndex < 10 then
		self._txtNum1.text = continuousIndex
		self._txtNum2.text = continuousIndex
	else
		local count = math.min(continuousIndex, 99)

		self._txtNum1.text = count
		self._txtNum2.text = count
	end
end

return M
