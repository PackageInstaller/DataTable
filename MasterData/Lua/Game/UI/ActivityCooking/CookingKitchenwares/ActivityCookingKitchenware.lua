---
--- 烹饪玩法，厨具类
--- Author: dawanfan
--- Date: 2024-3-13 11:38:08
---

local KTool = CS.Engine.Lib.KTool

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()


---@class ActivityCookingKitchenwareParam
---@field EntryAnimationName string
---@field CookingAnimationName string
---@field FinishAnimationName string
---@field BurntAnimationName string
---@field ResetAnimationName string
---@field WorkingAudioSheetName string
---@field WorkingAudioName string


local SoundRecord = {}

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateMainFryer.prefab > name: ActivityOperateMainDialogFryer1
---@class ActivityCookingKitchenware
---@field Env                           	ActivityCookingKitchenware              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Food1                         	UnityEngine.RectTransform               	@ 0    
---@field Food2                         	UnityEngine.RectTransform               	@ 1    
---@field Food3                         	UnityEngine.RectTransform               	@ 2    
---@field CookingNode                   	UnityEngine.RectTransform               	@ 3    
---@field CountdownNode                 	UnityEngine.RectTransform               	@ 4    
---@field kitchenwareImage              	UnityEngine.RectTransform               	@ 5    
local ActivityCookingKitchenware = Class("ActivityCookingKitchenware")

function ActivityCookingKitchenware:__init()
    self.node = nil
    ---@type ActivityCookingFood[]
    self.foodScrs = nil
    self.isCookNodeHide = false
end

function ActivityCookingKitchenware:__delete()
    self.node = nil
    self.foodScrs = nil
    self.isCookNodeHide = false
end

function ActivityCookingKitchenware:OnDestroy()
    if self.params ~= nil then
        CriWareUtils.Stop(self.params.WorkingAudioSheetName, self.params.WorkingAudioName)
    end
end

function ActivityCookingKitchenware:OnCookingEnd()
    if self.params ~= nil then
        CriWareUtils.Stop(self.params.WorkingAudioSheetName, self.params.WorkingAudioName)
    end
end

function ActivityCookingKitchenware:Awake()
    
end

---@param node ActivityCookingNode
function ActivityCookingKitchenware:Init(index, node)
    self.node = node
    self.nodeId = node.nodeId
    self.index = index
    self.data = ActivityCookingUtils.CreateKitchenwareData(index, node.nodeId)
    self.kitchenwardId = self.data.id
    
    self.params = ActivityCookingUtils.ParserKitchenwareParameters(KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters)))
    self.soundIndex = self.params.WorkingAudioSheetName .. "/" .. self.params.WorkingAudioName

    if self.params == nil then
        printError("[ActivityCookingKitchenware][Init] params is nil, please check " .. self.Env.gameObject.name)
        return
    end

    if self.CountdownNode ~= nil then
        self.countdownScr = CfUtils.GetLuaScr(self.CountdownNode, "Game.UI.ActivityCooking.ActivityCookingCountdownNode")
    end

    SetButtonAction(self.controller.gameObject, Bind(self, self.OnKitchenwareClick))
    
    self.foodScrs = {}
    for i = 1, 3 do
        self.foodScrs[i] = CfUtils.GetLuaScr(self["Food" .. tostring(i)], "Game.UI.ActivityCooking.CookingFoods.ActivityCookingFood")
    end

    self.isCookNodeHide = (self.CookingNode.gameObject.activeInHierarchy == false)
    CfUtils.SetActive(self.kitchenwareImage, true)
    CfUtils.SetUISwitchImage(self.kitchenwareImage, self.data.level)
end

function ActivityCookingKitchenware:Update()
    if self.data.state ==  ActivityCookingConstants.KitchenwareState.Burnt then
        return
    end

    if self.data.state == ActivityCookingConstants.KitchenwareState.Idle then
        if self.data.autoCooking and self:CanCook() then
            self:StartCook()
        end
        return
    end

    if self.data.nextStateTime <= ActivityCookingGame.data.currentTime then
        if self.data.state == ActivityCookingConstants.KitchenwareState.Working then
            self:FinishingCooking()
        elseif self.data.canBurnt and self.data.state == ActivityCookingConstants.KitchenwareState.Finish then
            self:CookingBurnt()
        end
    end
    
    if self.countdownScr ~= nil then
        self.countdownScr:Update()
    end

end

function ActivityCookingKitchenware:OnKitchenwareClick()

    if self.node:DropFood() then
        self:ResetKitchenWare()
        return
    end

    if self.data.state == ActivityCookingConstants.KitchenwareState.Idle then
        if not self.node.nodeVo.isCookedByIngredients and self:CanCook() then
            self:StartCook()
        end
    elseif self.data.state == ActivityCookingConstants.KitchenwareState.Finish then
        if self.data.autoCompelete then
            printError("[ActivityCookingKitchenware][OnKitchenwareClick] kitchenware is autoCompelete but current state is finish")
            return
        end

        if self.node:AddFood() then
            self:ResetKitchenWare()
        end
    else
        CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_keystroke_false)
    end

end

function ActivityCookingKitchenware:CanCook()
    
    for _, foodScr in pairs(self.foodScrs) do
        if foodScr.data == nil or foodScr.data.foodId == 0 then
            return true
        end
    end

    return false
end

function ActivityCookingKitchenware:StartCook()
    if self.data.state ~= ActivityCookingConstants.KitchenwareState.Idle then
        return
    end

    if not string.isEmpty(self.params.WorkingAudioName) and not string.isEmpty(self.params.WorkingAudioSheetName) then
        SoundRecord[self.soundIndex] = checkNumber(SoundRecord[self.soundIndex]) + 1
        CriWareUtils.PlaySe(self.params.WorkingAudioSheetName, self.params.WorkingAudioName)
    end

    if self.isCookNodeHide then
        CfUtils.SetActive(self.CookingNode, true)
    end

    self.data.nextStateTime = ActivityCookingGame.data.currentTime + self.data.workTime
    self.data.state = ActivityCookingConstants.KitchenwareState.Working

    if self.countdownScr ~= nil then
        self.countdownScr:Init(self.data.nextStateTime)
        -- CfUtils.SetActive(self.CountdownNode, true)
    end

    if not string.isEmpty(self.params.EntryAnimationName) then
        CfUtils.PlayDelayShowAnimation(self.CookingNode, 1, self.params.CookingAnimationName, self.params.EntryAnimationName)
    else
        CfUtils.PlayAnimation(self.CookingNode, self.params.CookingAnimationName)
    end

end


function ActivityCookingKitchenware:FinishingCooking()

    if self.data.state ~= ActivityCookingConstants.KitchenwareState.Working then
        printError("[ActivityCookingKitchenware][FinishingCooking] kitchenware enter finish but current state is not working")
        return
    end

    CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_finish)

    if self.data.autoCompelete then
        self.node:AddFood()
        self:ResetKitchenWare()
    else
        self.data.state = ActivityCookingConstants.KitchenwareState.Finish
        if not string.isEmpty(self.params.FinishAnimationName) then
            CfUtils.PlayAnimation(self.CookingNode, self.params.FinishAnimationName)
        else
            CfUtils.StopAnimation(self.CookingNode)
        end

        if self.data.canBurnt then
            self.data.nextStateTime = self.data.nextStateTime + self.data.burntTime
            if self.countdownScr ~= nil then
                self.countdownScr:Init(self.data.nextStateTime, 2)
            end
        end
    end
end

function ActivityCookingKitchenware:CookingBurnt()
    if self.data.state ~= ActivityCookingConstants.KitchenwareState.Finish then
        printError("[ActivityCookingKitchenware][CookingBurnt] kitchenware enter burnt but current state is not finish")
        return
    end

    ActivityCookingGame:SetConditionData(ActivityCookingConstants.CookingFailType.Burnt)
    CfUtils.SetActive(self.CountdownNode, false)

    self.data.state = ActivityCookingConstants.KitchenwareState.Burnt
    if not string.isEmpty(self.params.BurntAnimationName) then
        CfUtils.PlayAnimation(self.CookingNode, self.params.BurntAnimationName)
    end
end

function ActivityCookingKitchenware:ResetKitchenWare()
    self.data.state = ActivityCookingConstants.KitchenwareState.Idle
    CfUtils.SetActive(self.CountdownNode, false)

    if self.isCookNodeHide then
        CfUtils.SetActive(self.CookingNode, false)
    end

    if not string.isEmpty(self.params.ResetAnimationName) then
        CfUtils.PlayAnimation(self.CookingNode, self.params.ResetAnimationName)
    else
        CfUtils.StopAnimation(self.CookingNode)
    end

    SoundRecord[self.soundIndex] = SoundRecord[self.soundIndex] - 1
    if SoundRecord[self.soundIndex] <= 0 then
        CriWareUtils.Stop(self.params.WorkingAudioSheetName, self.params.WorkingAudioName)
    end
end

function ActivityCookingKitchenware:Refresh()

    if self.data.state == ActivityCookingConstants.KitchenwareState.Idle or self.data.state == ActivityCookingConstants.KitchenwareState.Burnt then
        CfUtils.SetActive(self.CountdownNode, false)
    end


    if self.countdownScr ~= nil then
        self.countdownScr:Refresh()
    end

end

return ActivityCookingKitchenware
