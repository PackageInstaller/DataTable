---
--- 烹饪玩法厨具升级界面
--- Author: dawanfan
--- Date: 2024-3-18 11:25:54
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')



---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopFightBuffDialog.prefab > name: ActivityCakeShopFightBuffDialog
---@class ActivityCookingUpgradeDialog
---@field Env                           	ActivityCookingUpgradeDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ScrollView                    	Engine.UI.AutoFixSizeListView           	@ 0    
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 1    
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 2    
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 3    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 4    
---@field BottomButton                  	UnityEngine.RectTransform               	@ 5    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 6    
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 7    
---@field TextItemType                  	UnityEngine.RectTransform               	@ 8    
---@field ImgItemType                   	UnityEngine.RectTransform               	@ 9    
---@field TextItemName                  	UnityEngine.RectTransform               	@ 10   
---@field ImgItem                       	UnityEngine.RectTransform               	@ 11   
local ActivityCookingUpgradeDialog = Class("ActivityCookingUpgradeDialog")

function ActivityCookingUpgradeDialog:__init()
    
end

function ActivityCookingUpgradeDialog:__delete()
    
end

function ActivityCookingUpgradeDialog:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnBtnUpgradeClick))
    self.__OnUpgrade = Bind(self, self.RefreshRightPanel)
    Events.AddListener(Constants.EventNames.ActivityCookingUpgrade, self.__OnUpgrade)
end

function ActivityCookingUpgradeDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FillLoopList()
        self:RefreshRightPanel()
    end))
    return coWait
end

function ActivityCookingUpgradeDialog:OnFocus()
    
end

function ActivityCookingUpgradeDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                self:InitData()
            end
        )
    )

    return coWait
end

function ActivityCookingUpgradeDialog:InitData()
    ---@type {id:number, type:number}[]
    self.data = {}
    self.itemNum = 0
    self._currentSelectedIndex = 0
    for kitchenwareId, _ in pairs(ActivityCookingComponent.dojo.kitchenwareInfos) do
        local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(kitchenwareId)
        if ActivityCookingComponent.dojo:IsLevelUnlock(kitchenwareVo.unlockLevel) then
            self.itemNum = self.itemNum + 1
            table.insert(self.data, {id=kitchenwareId, type=ActivityCookingConstants.UpgradeItemType.Kitchenware})
        end
    end

    for ingredientsId, _ in pairs(ActivityCookingComponent.dojo.ingredientsInfo) do
        local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(ingredientsId)
        if ActivityCookingComponent.dojo:IsLevelUnlock(ingredientsVo.unlockLevel) then
            self.itemNum = self.itemNum + 1
            table.insert(self.data, {id=ingredientsId, type=ActivityCookingConstants.UpgradeItemType.Ingredients})
        end
    end
end

function ActivityCookingUpgradeDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        Events.RemoveListener(Constants.EventNames.ActivityCookingUpgrade, self.__OnUpgrade)

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingUpgradeDialog:FillLoopList()
    if not self.ScrollView.mLoopListView.IsListViewInit then
        self.ScrollView:InitListView(self.itemNum, Bind(self, self.OnRefreshListIndex))
    else
        GameUtils.ReloadData(self.ScrollView, self.itemNum)
    end
end

function ActivityCookingUpgradeDialog:OnRefreshListIndex(cell, index)
    if index < 0 then
        return nil
    end

    local data = {
        input = self.data[index + 1],
        index = index
    }

    local nodeScr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCooking.ActivityCookingUpgradeNode")
    if nodeScr then
        nodeScr:Refresh(data, self._currentSelectedIndex, function(index)
            self:OnSelectItem(index)
        end)
    end

    return cell
end

function ActivityCookingUpgradeDialog:OnSelectItem(index)
    if index < 0 then
        return
    end

    if self._currentSelectedIndex >= 0 then
        local go = self.ScrollView:GetShownItemByItemIndex(self._currentSelectedIndex)
        if go then
            local scr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingUpgradeNode")
            if scr then
                scr:Select(false)
            end
        end
    end

    local go = self.ScrollView:GetShownItemByItemIndex(index)
    if go then
        self._currentSelectedIndex = index
        local scr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingUpgradeNode")
        if scr then
            scr:Select(true)
        end
    end

    self:RefreshRightPanel()
end

function ActivityCookingUpgradeDialog:RefreshRightPanel()
    local data = self.data[self._currentSelectedIndex + 1]
    local level = 0
    if data.type == ActivityCookingConstants.UpgradeItemType.Ingredients then
        local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(data.id)
        local ingredientsInfo = ActivityCookingComponent.dojo.ingredientsInfo[data.id]

        level = ingredientsInfo.level
        CfUtils.FillText(self.TextItemName, ingredientsVo.name)
        local iconDict = parse_strings(ingredientsVo.icon[level], ":")
        CfUtils.FillImage(self.ImgItem, CS.GameUtils.GetCombineResourceDirPath(tonumber(iconDict[1]), iconDict[2]), true)
        CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop, ingredientsVo.levelupConsumeItem[level], ingredientsVo.levelupConsume[level])
    else
        local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(data.id)
        local kitchenwareInfo = ActivityCookingComponent.dojo.kitchenwareInfos[data.id]

        level = kitchenwareInfo.level
        CfUtils.FillText(self.TextItemName, kitchenwareVo.name)
        local iconDict = parse_strings(kitchenwareVo.icon[level], ":")
        CfUtils.FillImage(self.ImgItem, CS.GameUtils.GetCombineResourceDirPath(tonumber(iconDict[1]), iconDict[2]), true)
        CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop, kitchenwareVo.levelupConsumeItem[level], kitchenwareVo.levelupConsume[level])
    end
    
    CfUtils.SetUISwitchImage(self.ImgItemType, data.type)
    CfUtils.SetUISwitchText(self.TextItemType, data.type)

    CfUtils.FillText(self.TextDesc, ActivityCookingComponent.dojo:GetItemDes(data.id, data.type))
    for i = 1, ActivityCookingConstants.ItemMaxLevel do
        if i <= level then
            CfUtils.SetUISwitchImage(self["ImgStar" .. tostring(i)], 2)
        else
            CfUtils.SetUISwitchImage(self["ImgStar" .. tostring(i)], 1)
        end
    end

    CfUtils.SetActive(self.BottomButton, level < ActivityCookingConstants.ItemMaxLevel)
end

function ActivityCookingUpgradeDialog:OnBtnUpgradeClick()

    local data = self.data[self._currentSelectedIndex + 1]
    if data ~= nil then
        if data.type == ActivityCookingConstants.UpgradeItemType.Ingredients then
            ActivityCookingComponent:IngredientsUpgrade(data.id, true)
        else
            ActivityCookingComponent:KitchenwareUpgrade(data.id, true)
        end
    end
    
end

function ActivityCookingUpgradeDialog:OnUpgrade()
    self:RefreshRightPanel()
end

return ActivityCookingUpgradeDialog
