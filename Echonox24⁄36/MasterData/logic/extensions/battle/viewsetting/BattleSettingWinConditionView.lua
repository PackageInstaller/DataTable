-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingWinConditionView.lua

module("logic.extensions.battle.viewsetting.BattleSettingWinConditionView", package.seeall)

local M = class("BattleSettingWinConditionView", UIReusableLuaBehavior)
local kConditionDescriptionJoinAnd = "且\n"
local kConditionDescriptionJoinOr = "或\n"

function M:buildUI()
	self._cellGo = goutil.findChild(self.mainGO, "viewPort/content/desc_item")
	self._contentGo = goutil.findChild(self.mainGO, "viewPort/content")

	local cellComp = Astral.SimpleLuaComponentContainer.Add(self._cellGo, BattleSettingWinConditionItem)

	self._conditionCellList = {
		cellComp
	}
end

function M:setConditionStr(conditionStr)
	self._conditionList = {}

	local groupList = string.split(conditionStr, kConditionDescriptionJoinAnd)

	for i, groupStr in ipairs(groupList) do
		local conditionList = string.split(groupStr, kConditionDescriptionJoinOr)

		for j, condition in ipairs(conditionList) do
			local data = {
				contactKey = "或",
				str = condition
			}

			if j == #conditionList then
				data.contactKey = "且"
			end

			table.insert(self._conditionList, data)
		end

		if i == #groupList then
			self._conditionList[#self._conditionList].contactKey = false
		end
	end

	self:_updateCell()
end

function M:_updateCell()
	for i, v in ipairs(self._conditionCellList) do
		goutil.setActive(v.mainGO, false)
	end

	for i, cellData in ipairs(self._conditionList) do
		local cellComp

		if self._conditionCellList[i] then
			cellComp = self._conditionCellList[i]
		else
			local obj = goutil.cloneAndSetParent(self._cellGo, self._contentGo.transform, "desc_item" .. i)

			cellComp = Astral.SimpleLuaComponentContainer.Add(obj, BattleSettingWinConditionItem)

			table.insert(self._conditionCellList, cellComp)
		end

		goutil.setActive(cellComp.mainGO, true)
		cellComp:setData(cellData.str, cellData.contactKey)
	end
end

function M:clear()
	return
end

function M:destroyUI()
	return
end

return M
