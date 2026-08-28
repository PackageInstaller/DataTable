---
--- 烹饪玩法，制作节点基类
--- Author: dawanfan
--- Date: 2024-3-12 11:29:09
---

local KTool = CS.Engine.Lib.KTool

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
---@type ActivityCookingComponent
local activityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')


---@class ActivityCookingNode
---@field Env                           	ActivityCookingNode               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Kitchenward1                  	UnityEngine.RectTransform               	@ 0    
---@field Kitchenward2                  	UnityEngine.RectTransform               	@ 1    
---@field Kitchenward3                  	UnityEngine.RectTransform               	@ 2    
---@field Food1                         	UnityEngine.RectTransform               	@ 3    
---@field Food2                         	UnityEngine.RectTransform               	@ 4    
---@field Food3                         	UnityEngine.RectTransform               	@ 5    
---@field Ingredients1                  	UnityEngine.RectTransform                   @ 6    
---@field Ingredients2                  	UnityEngine.RectTransform                   @ 7    
---@field Ingredients3                  	UnityEngine.RectTransform                   @ 8    
local ActivityCookingNode = Class("ActivityCookingNode")

function ActivityCookingNode:__init()
    ---@type table<number, ActivityCookingKitchenware>
    self.kitchenwardSrcs = {}
    ---@type table<number, ActivityCookingFood>
    self.foodScrs = {}
    self.nodeVo = nil
end

function ActivityCookingNode:__delete()
    self.nodeVo = nil
end

function ActivityCookingNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingNode:Awake()
    self.params = KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters))
    self.nodeId = LuaParametersReader.Read(self.params, "nodeId", LuaParametersType.Int)
end

function ActivityCookingNode:Init(cookingDialog)
    self.cookingDialog = cookingDialog
    self.nodeVo = ActivityCookingUtils.GetCookingNodeVo(self.nodeId)

    if self.nodeVo == nil then
        printError("[ActivityCookingNode][Init] nodeVo is nil, please check nodeId, gameObject: " .. self.Env.controller.gameObject.name)
        return
    end

    local num = activityCookingComponent.dojo:GetKitchenwareFoodShowNum(self.nodeVo.kitchenwareId, ActivityCookingGame.currentLevel)
    
    --- 初始化厨具
    if self.nodeVo.isOneMachineToOneFood then
        for i = 1, 3 do
            local visible = num >= i
            CfUtils.SetActive(self["Kitchenward" .. tostring(i)], visible)
            if visible then
                self.kitchenwardSrcs[i] = CfUtils.GetLuaScr(self["Kitchenward" .. tostring(i)], "Game.UI.ActivityCooking.CookingKitchenwares.ActivityCookingKitchenware")
                if self.kitchenwardSrcs[i] ~= nil then
                    self.kitchenwardSrcs[i]:Init(ActivityCookingGame:GenKitchenIndex(), self)
                end
            end
        end
    else
        if num > 0 then
            CfUtils.SetActive(self.Kitchenward1, true)
            self.kitchenwardSrcs[1] = CfUtils.GetLuaScr(self.Kitchenward1, "Game.UI.ActivityCooking.CookingKitchenwares.ActivityCookingKitchenware")
            if self.kitchenwardSrcs[1] ~= nil then
                self.kitchenwardSrcs[1]:Init(ActivityCookingGame:GenKitchenIndex(), self)
            end
        else
            CfUtils.SetActive(self.Kitchenward1, false)
        end
    end

    --- 食物
    for i = 1, 3 do
        local visible = num >= i
        CfUtils.SetActive(self["Food" .. tostring(i)], visible)
        if visible then
            self.foodScrs[i] = CfUtils.GetLuaScr(self["Food" .. tostring(i)], "Game.UI.ActivityCooking.CookingFoods.ActivityCookingFood")
            if self.foodScrs[i] ~= nil then
                self.foodScrs[i]:Init(ActivityCookingGame:GenFoodIndex(), self)
            end
        end
    end

    --- 初始化食材
    local ingredientsVisible = self.nodeVo.isCookedByIngredients and num > 0
    CfUtils.SetActive(self.Ingredients1, ingredientsVisible)
    if ingredientsVisible then
        SetButtonAction(self.Ingredients1, Bind(self, self.OnFoodIngredientsClick))
    end

    if self.nodeVo.foodProcessable then
        local groupVo = ActivityCookingUtils.GetCookingFoodGroupVo(self.nodeVo.foodGroupId)
        for i = 2, 3 do
            local ingredientsId = groupVo.ingredientsId[i]
            local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(ingredientsId)
            local button = self["Ingredients" .. tostring(i)]

            CfUtils.SetActive(button, ingredientsVo.unlockLevel <= ActivityCookingGame.currentLevel)
            SetButtonAction(button, Bind(self, self.OnProcessedIngredientsClick, i - 1, ingredientsId))
        end
    end
end

function ActivityCookingNode:Update()
    for _, kitchenwareScr in pairs(self.kitchenwardSrcs) do
        kitchenwareScr:Update()
    end
end

--- 原料点击，开始制作
function ActivityCookingNode:OnFoodIngredientsClick()
    for _, kitchenware in pairs(self.kitchenwardSrcs) do
        if kitchenware.data.state == ActivityCookingConstants.KitchenwareState.Idle then
            CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_food)
            kitchenware:StartCook()
            return
        end
    end

    CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_error)
end

--- 加工食材点击，开始加工
function ActivityCookingNode:OnProcessedIngredientsClick(index, ingredientId)

    for _, foodScr in pairs(self.foodScrs) do
        local addSuccess = foodScr:AddIngredients(index, ingredientId)
        if addSuccess then
            CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_food)
            return
        end
    end
    CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_error)
end

function ActivityCookingNode:AddFood()
    for _, foodScr in pairs(self.foodScrs) do
        local addSuccess = foodScr:AddFood(self.nodeVo.foodId)
        if self.nodeVo.isOneMachineToOneFood and addSuccess then
            CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_food)
            return true
        end
    end

    CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_error)
    return false
end

function ActivityCookingNode:SellFood(foodId)
    local index = 0
    local time = math.maxinteger

    for i, guestScr in pairs(self.cookingDialog.guestScrs) do
        if guestScr.data ~= nil then
            if guestScr:NeedFood(foodId) and guestScr.data.enterTime < time then
                time = guestScr.data.enterTime
                index = i
            end
        end
    end

    if index == 0 then
        return false
    end

    local guestScr = self.cookingDialog.guestScrs[index]
    -- if not guestScr:GetFood(foodId) then
    --     return false
    -- end

    -- ActivityCookingGame:SellFood(foodId)
    -- self.cookingDialog:OnSellFood()
    return guestScr:GetFood(foodId)
end

---@return boolean
function ActivityCookingNode:DropFood()
    if not self.nodeVo.droppable then
        return false
    end

    return self.cookingDialog:DropFood()
end

function ActivityCookingNode:OnCookingEnd()
    for _, kitchenwareScr in pairs(self.kitchenwardSrcs) do
        kitchenwareScr:OnCookingEnd()
    end

end

return ActivityCookingNode
