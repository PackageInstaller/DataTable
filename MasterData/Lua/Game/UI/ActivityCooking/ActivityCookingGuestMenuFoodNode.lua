---
--- 烹饪玩法，菜单食物节点
--- Author: dawanfan
--- Date: 2024-3-15 17:39:08
---

local Color = CS.UnityEngine.Color
local XLuaUtils = CS.Engine.Lib.XLuaUtils



--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateMenuNode.prefab > name: Food1
---@class ActivityCookingGuestMenuFoodNode
---@field Env                           	ActivityCookingGuestMenuFoodNode        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FoodIcon                      	UnityEngine.RectTransform               	@ 0    
---@field FoodGetNode                   	UnityEngine.RectTransform               	@ 1    
local ActivityCookingGuestMenuFoodNode = Class("ActivityCookingGuestMenuFoodNode")

function ActivityCookingGuestMenuFoodNode:__init()
    ---@type ActivityCooking.ViewGuest
    self.data = nil
    self.node = nil
    self.inProcessing = false
end

function ActivityCookingGuestMenuFoodNode:__delete()
    self.data = nil
    self.node = nil
end

function ActivityCookingGuestMenuFoodNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingGuestMenuFoodNode:Awake()
    CfUtils.SetActive(self.FoodGetNode, false)
    CfUtils.SetColor(self.FoodIcon, Color.white)
end

function ActivityCookingGuestMenuFoodNode:GetFood()
    CfUtils.SetActive(self.FoodGetNode, true)
    CfUtils.SetColor(self.FoodIcon, XLuaUtils.HexToColor("9A9A9A"))    
    Events.Broadcast(Constants.EventNames.ActivityCookingSellFood, self.controller.transform.position)

end

function ActivityCookingGuestMenuFoodNode:Fill(foodImagePath)
    CfUtils.SetActive(self.FoodGetNode, false)
    CfUtils.SetColor(self.FoodIcon, Color.white)


    if string.isEmpty(foodImagePath) then
        CfUtils.SetActive(self.FoodIcon, false)
    else
        CfUtils.SetActive(self.FoodIcon, true)
        CfUtils.FillImage(self.FoodIcon, foodImagePath)
    end
end


return ActivityCookingGuestMenuFoodNode
