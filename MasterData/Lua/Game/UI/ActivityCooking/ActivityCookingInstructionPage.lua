---
--- 烹饪活动，操作指南页面
--- Author: dawanfan
--- Date: 2024-4-22 10:55:05
---


--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopInstructionDialog.prefab > name: Page1
---@class ActivityCookingInstructionPage
---@field Env                           	ActivityCookingInstructionPage          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SelectToggleOn                	UnityEngine.RectTransform               	@ 0    
---@field SelectToggleOff               	UnityEngine.RectTransform               	@ 1    
local ActivityCookingInstructionPage = Class("ActivityCookingInstructionPage")

function ActivityCookingInstructionPage:__init()
    self.index = 0
    self.selected = false
end

function ActivityCookingInstructionPage:__delete()
end

function ActivityCookingInstructionPage:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingInstructionPage:Init(index, currentSelectIndex)
    self.index = index
    self.selected = index == currentSelectIndex

    self:FillSelf()
end

function ActivityCookingInstructionPage:Select(value)
    if value == self.selected then
        return
    end

    self.selected = value
    self:FillSelf()
end

function ActivityCookingInstructionPage:FillSelf()
    CfUtils.SetActive(self.SelectToggleOn, self.selected)
    CfUtils.SetActive(self.SelectToggleOff, self.selected == false)
    CfUtils.SetActive(self.controller.gameObject, self.selected)
end

return ActivityCookingInstructionPage
