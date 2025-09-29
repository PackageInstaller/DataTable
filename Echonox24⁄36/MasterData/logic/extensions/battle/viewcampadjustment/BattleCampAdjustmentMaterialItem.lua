-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentMaterialItem.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentMaterialItem", package.seeall)

local M = class("BattleCampAdjustmentMaterialItem", UIReusableLuaBehavior)

function M:buildUI()
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtHint2")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtHint2/txtNum2")
end

function M:destroyUI()
	self._txtTitle = nil
	self._txtContent = nil
end

function M:setTitle(titleStr)
	self._txtTitle.text = titleStr
end

function M:setCount(countStr)
	self._txtContent.text = countStr
end

return M
