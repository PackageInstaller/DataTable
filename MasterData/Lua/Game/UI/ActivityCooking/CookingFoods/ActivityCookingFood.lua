---
--- 烹饪玩法，食物类
--- Author: dawanfan
--- Date: 2024-3-13 14:25:00
---

local KTool = CS.Engine.Lib.KTool

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
---@type ActivityCookingComponent
local activityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')


---@class ActivityCookingFoodParam
---@field FoodEntryAnimationName string
---@field AddIngredientsAnimName1 string
---@field AddIngredientsAnimName2 string


--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateMainDoughnut.prefab > name: ActivityOperateMainDoughnut
---@class ActivityCookingFood
---@field Env                           	ActivityCookingFood                     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FoodClickNode                 	UnityEngine.RectTransform               	@ 0    
---@field Animation                     	UnityEngine.RectTransform               	@ 1    
---@field FoodIcon                      	UnityEngine.RectTransform               	@ 2    
---@field AddIngredients1               	UnityEngine.RectTransform               	@ 3    
---@field AddIngredients2               	UnityEngine.RectTransform               	@ 4    
local ActivityCookingFood = Class("ActivityCookingFood")

function ActivityCookingFood:__init()
    self.data = nil
    self.node = nil
    self.inProcessing = false
end

function ActivityCookingFood:__delete()
    self.data = nil
    self.node = nil
end

function ActivityCookingFood:OnDestroy()
    
end

function ActivityCookingFood:Awake()

end

---@param node ActivityCookingNode
function ActivityCookingFood:Init(index, node)
    self.node = node
    self.index = index
    ---@type ActivityCooking.ViewFood
    self.data = {index=index, foodId=0}
    self.params = ActivityCookingUtils.ParserFoodParameters(KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters)))

    SetButtonAction(self.FoodClickNode, Bind(self, self.OnFoodClick))
    self:Refresh()
end

function ActivityCookingFood:Refresh()
    if self.data.foodId == 0 then
        CfUtils.SetActive(self.FoodIcon, false)
    else
        CfUtils.SetActive(self.FoodIcon, true)
        --- 食物可加工，则 image index = 食物在食物组列表内 index，不可加工则等于基础食材等级
        local foodGroupVo = ActivityCookingUtils.GetCookingFoodGroupVo(self.node.nodeVo.foodGroupId)
        if self.node.nodeVo.foodProcessable then
            for index, foodId in ipairs(foodGroupVo.foodIds) do
                if foodId == self.data.foodId then
                    CfUtils.SetUISwitchImage(self.FoodIcon, index)
                    break
                end
            end
        else
            local level = activityCookingComponent.dojo.ingredientsInfo[foodGroupVo.ingredientsId[1]].level
            CfUtils.SetUISwitchImage(self.FoodIcon, level)
        end
    end

end

---@return boolean
function ActivityCookingFood:AddFood(foodId)
    
    if self.data.foodId ~= 0 then
        return false
    end

    self.data.foodId = foodId
    self:Refresh()
    CfUtils.PlayAnimation(self.Animation, self.params.FoodEntryAnimationName)
    return true
end

---@return boolean
function ActivityCookingFood:AddIngredients(index, ingredientsId)
    if self.inProcessing or self.data.foodId == 0 then
        return false
    end

    local targetFoodId = ActivityCookingGame:GetCookingProcessTargetFoodId(self.data.foodId, ingredientsId)
    if targetFoodId == nil then
        -- printInfo("[ActivityCookingFood][AddIngredients] processing data not found, foodId: %s, ingredientsId: %s", self.data.foodId, ingredientsId)
        return false
    end

    local go = self["AddIngredients" .. tostring(index)]
    local animName = self.params["AddIngredientsAnimName" .. tostring(index)]
    self.data.foodId = targetFoodId
    if go ~= nil then
        CfUtils.SetActive(go, true)
        if not string.isEmpty(animName) then
            self.inProcessing = true
            CfUtils.WaitPlayAnimationTo(go, animName, function ()
                self.inProcessing = false
                self:Refresh()
                CfUtils.SetActive(go, false)
            end)
        else
            self:Refresh()
            printError(string.format("[ActivityCookingFood][AddIngredients] config AddIngredients%s but not set AddIngredientsAnimName%s", index, index))
        end
    else
        self:Refresh()
    end

    return true
end

function ActivityCookingFood:OnFoodClick()
    if self.data.foodId == 0 then
        return
    end

    if self.node:DropFood() then
        self.data.foodId = 0
        CfUtils.SetActive(self.FoodIcon, false)
        return
    end

    if self.node:SellFood(self.data.foodId) then
    -- if ActivityCookingGame:SellFood(self.data.foodId) then
        self.data.foodId = 0
        CfUtils.StopAnimation(self.Animation)
        CfUtils.SetActive(self.FoodIcon, false)
    else
        CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_error)
    end
end

return ActivityCookingFood
