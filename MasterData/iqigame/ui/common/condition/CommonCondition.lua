-- chunkname: @IQIGame\\UI\\Common\\Condition\\CommonCondition.lua

local commonConditionItemCell = require("IQIGame.UI.Common.Condition.CommonConditionItemCell")
local m = {
	AllConditionsIsUnlock = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ConditionItemList = {}

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(conditionList, unControlColor)
	self.unControlColor = unControlColor

	if #conditionList == 0 then
		self:Hide()
	end

	local conditionLength = #conditionList

	for i = 1, #self.ConditionItemList do
		if conditionLength < i then
			self.ConditionItemList[i]:Hide()
		else
			self.ConditionItemList[i]:Show()
		end
	end

	for i = 1, #self.ConditionItemList do
		self.ConditionItemList[i]:Dispose()
	end

	self.ConditionItemList = {}

	for i = 1, #conditionList do
		local conditionItemCell = self:CreateConditionPrefab(i)

		conditionItemCell:SetData(conditionList[i], self.unControlColor)
	end

	self:GetIsAllUnlock()

	if self.AllConditionsIsUnlock then
		self:Hide()
	else
		self:Show()
	end
end

function m:CreateConditionPrefab(index)
	local conditionItemCell = self.ConditionItemList[index]

	if conditionItemCell == nil then
		local obj = UnityEngine.Object.Instantiate(self.conditionPrefab)

		obj.transform:SetParent(self.conditionGrid.transform, false)

		conditionItemCell = commonConditionItemCell.New(obj)
		self.ConditionItemList[index] = conditionItemCell
	end

	return conditionItemCell
end

function m:GetIsAllUnlock()
	self.AllConditionsIsUnlock = true

	for k, v in pairs(self.ConditionItemList) do
		if v:GetIsUnlock() == false then
			self.AllConditionsIsUnlock = false

			return self.AllConditionsIsUnlock
		end
	end

	return self.AllConditionsIsUnlock
end

function m:GetAllConditionsIsUnlock()
	return self.AllConditionsIsUnlock
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.ConditionItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
