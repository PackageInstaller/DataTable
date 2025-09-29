-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/cell/SeasonJudgeRewardCell.lua

module("logic.extensions.season.cell.SeasonJudgeRewardCell", package.seeall)

local M = class("SeasonJudgeRewardCell", ListBinderCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("reward", ReceiveStatusComponent)
end

function M:setRedPoint(active)
	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.Strong)

	local redPoint = normalComp:getRedPoint()

	goutil.setActive(redPoint, active)
end

return M
