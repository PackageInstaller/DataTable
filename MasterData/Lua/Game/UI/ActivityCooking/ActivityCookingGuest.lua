---
--- 烹饪玩法，客人
--- Author: dawanfan
--- Date: 2024-3-14 16:40:50
---

local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateGuestNode.prefab > name: ActivityOperateGuestNode
---@class ActivityCookingGuest
---@field Env                           	ActivityCookingGuest                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MenuAnimation                 	UnityEngine.RectTransform               	@ 0    
---@field GuestImage                    	UnityEngine.RectTransform               	@ 1    
---@field Guest                         	UnityEngine.RectTransform               	@ 2    
---@field Slider                        	UnityEngine.RectTransform               	@ 3    
---@field ImgMad                        	UnityEngine.RectTransform               	@ 4    
---@field FoodNodeParent                	UnityEngine.RectTransform               	@ 5    
---@field GuestImgs                     	nil                                     	@ 6    
local ActivityCookingGuest = Class("ActivityCookingGuest")

function ActivityCookingGuest:__init()
    ---@type ActivityCooking.ViewGuest
    self.data = nil
    self.node = nil
    self.inProcessing = false
    self.timeEnough = true

    ---@type table<number, ActivityCookingGuestMenuFoodNode>
    self.foodNodeScrs = {}
end

function ActivityCookingGuest:__delete()
    self.data = nil
    self.node = nil
end

function ActivityCookingGuest:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingGuest:Awake()
    self.Guest.transform:SetParent(self.GuestImgs)
end

function ActivityCookingGuest:Update()
    if self.data == nil then
        return
    end

    local elapsedTime = ActivityCookingGame.data.currentTime - self.data.enterTime 
    if self.data.survivalTime <= elapsedTime then
        self:GuestLeave(false)
        return
    end

    local allFoodGet = true
    for _, food in pairs(self.data.needFoods) do
        if not food.hasGet then
            allFoodGet = false
            break
        end
    end

    if allFoodGet then
        self:GuestLeave(true)
        return
    end

    local percent = elapsedTime / self.data.survivalTime
    if self.timeEnough and percent >= 0.8 then
        self.timeEnough = false
        if self.ImgMad ~= nil then
            CfUtils.PlayAnimation(self.ImgMad.transform.parent, "ActivityOperateMenuNode_Cat_NoEnoughTimes")
        end
        -- CfUtils.SetActive(self.ImgMad, true)
    end

    CfUtils.SetSliderPercent(self.Slider, 1 - percent)
end

function ActivityCookingGuest:GuestEnter(guestData)
    self.data = clone(guestData)
    self:FillSelf()
    self:DoEnter()

    self.timeEnough = true
    if self.ImgMad ~= nil then
        CfUtils.StopAnimation(self.ImgMad.transform.parent)
        CfUtils.SetColor(self.ImgMad.transform.parent, CS.UnityEngine.Color.white)
        CfUtils.SetActive(self.ImgMad, false)
    end
end

function ActivityCookingGuest:Init()
    CfUtils.SetActive(self.GuestImage, false)
    CfUtils.SetActive(self.MenuAnimation, false)

    for i = 1, ActivityCookingConstants.GuestMenuFoodNum do
        local go = self.FoodNodeParent.transform:Find("Food" .. tostring(i))
        if go ~= nil then
            self.foodNodeScrs[i] = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingGuestMenuFoodNode")
            if self.foodNodeScrs[i] == nil then
                printError("[ActivityCookingGuest][Init] foodNodeScrs is nil, Food%s", i)
            end
        end
    end
end

function ActivityCookingGuest:FillSelf()
    if self.data == nil then
        printError("[ActivityCookingGuest][FillSelf] data is nil")
        return
    end

    local guestVo = ActivityCookingUtils.GetCookingGuestVo(self.data.id)


    CfUtils.FillImage(self.GuestImage, guestVo.image)

    local i = 1
    for _, foodInfo in pairs(self.data.needFoods) do
        local foodVo = ActivityCookingUtils.GetCookingFoodVo(foodInfo.id)
        local iconCount = #foodVo.icon
        if iconCount == 1 then
            self.foodNodeScrs[i]:Fill(foodVo.icon[1])
        else
            local ingredientsLevel = ActivityCookingComponent.dojo:GetIngredientsLevel(foodVo.ingredientsId[1])
            self.foodNodeScrs[i]:Fill(foodVo.icon[ingredientsLevel])
        end
        
        i = i + 1
    end

    for index = i, ActivityCookingConstants.GuestMenuFoodNum do
        self.foodNodeScrs[index]:Fill()
    end
end

function ActivityCookingGuest:DoEnter()
    if self.data == nil then
        return
    end

    CfUtils.SetActive(self.GuestImage, true)
    CfUtils.SetActive(self.MenuAnimation, true)
    CfUtils.PlayAnimation(self.MenuAnimation, "ActivityOperateMenuNode_Entry")
end

function ActivityCookingGuest:CanEnterGuest()
    return self.data == nil and self.inProcessing == false
end

function ActivityCookingGuest:GuestLeave(addTime)

    if addTime then
        ActivityCookingGame:AddTime(self.data.addTime)
        ActivityCookingGame.data.successGuestNum = ActivityCookingGame.data.successGuestNum + 1
    end

    self.data = nil
    self.inProcessing = true

    ActivityCookingGame.data.finishGuestNum = ActivityCookingGame.data.finishGuestNum + 1
    CfUtils.WaitPlayAnimationTo(self.MenuAnimation, "ActivityOperateMenuNode_Out", function ()
        CfUtils.SetActive(self.GuestImage, false)
        self.inProcessing = false
    end)
end

---@return boolean
function ActivityCookingGuest:GetFood(foodId)
    if not self:NeedFood(foodId) then
        return false
    end

    for i, foodInfo in ipairs(self.data.needFoods) do
        if foodInfo.id == foodId and not foodInfo.hasGet then
            foodInfo.hasGet = true
            ActivityCookingGame:SellFood(foodId)
            self.foodNodeScrs[i]:GetFood()
            return true
        end
    end

    return true
end

---@return boolean
function ActivityCookingGuest:NeedFood(foodId)
    if self.data == nil then
        return false
    end

    for _, foodInfo in pairs(self.data.needFoods) do
        if foodInfo.id == foodId and not foodInfo.hasGet then
            return true
        end
    end

    return false
end

return ActivityCookingGuest