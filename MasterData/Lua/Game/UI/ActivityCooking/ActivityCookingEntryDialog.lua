---
--- 烹饪玩法入口界面
--- Author: dawanfan
--- Date: 2024-3-18 10:37:56
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')


--- from: Assets/BundleResources/Prefabs/ActivityMountain/11300302/ActivityMountainFightDialog.prefab > name: ActivityMountainFightDialog
---@class ActivityCookingEntryDialog
---@field Env                           	ActivityCookingEntryDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnRank                       	UnityEngine.RectTransform               	@ 0    
---@field BtnUpgrade                    	UnityEngine.RectTransform               	@ 1    
---@field UpgradeRedPoint               	UnityEngine.RectTransform               	@ 2    
---@field EntryButtonNode               	UnityEngine.RectTransform               	@ 3    
---@field EntryButton                   	UnityEngine.RectTransform               	@ 4    
---@field EntryConsume                  	UnityEngine.RectTransform               	@ 5    
---@field TextTime                      	UnityEngine.RectTransform               	@ 6    
---@field LevelTarget1                  	UnityEngine.RectTransform               	@ 7    
---@field LevelTarget2                  	UnityEngine.RectTransform               	@ 8    
---@field LevelTarget3                  	UnityEngine.RectTransform               	@ 9    
---@field EndlessLevelTarget            	UnityEngine.RectTransform               	@ 10   
---@field LoopList                      	SuperScrollView.LoopListView2           	@ 11   
---@field EndlessLevel                  	UnityEngine.RectTransform               	@ 12   
---@field NormalStatus                  	UnityEngine.RectTransform               	@ 13   
---@field EndlessStatus                 	UnityEngine.RectTransform               	@ 14   
local ActivityCookingEntryDialog = Class("ActivityCookingEntryDialog")

function ActivityCookingEntryDialog:__init()
    ---@type ActivityCookingLevelVo[]
    self._levelVos = nil
end

function ActivityCookingEntryDialog:__delete()
    self._levelVos = nil
end

function ActivityCookingEntryDialog:Awake()
    SetButtonAction(self.BtnRank, Bind(self, self.OnBtnRankClick))
    SetButtonAction(self.BtnUpgrade, Bind(self, self.OnBtnUpgradeClick))
    SetButtonAction(self.EntryButton, Bind(self, self.OnBtnEntryClick))

    self.__OnItemChange = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.OnItemChange))
end

function ActivityCookingEntryDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RefreshLoopList()
        
        self.LoopList:MovePanelToItemIndex(self._currentSelectedIndex)
        self:RefreshLevelInfo()

        CriWareUtils.PlayMusicById(ActivityCookingConstants.BGMConfig[ActivityCookingComponent.dojo.config.id])
    end))
    return coWait
end

function ActivityCookingEntryDialog:OnFocus()
    CfUtils.SetActive(self.UpgradeRedPoint, ActivityCookingUtils.HasAnyFoodOrKitchenwareCanUpgrade())
end

function ActivityCookingEntryDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                local initParams = self.controller.Argument.parameters or {}
                local level = initParams.level
                self._levelVos = ActivityCookingUtils.GetCookingLevelVosByActivityId(ActivityCookingComponent.dojo.config.id)
                self._currentSelectedIndex = 0
                if level ~= nil then
                    for i, levelVo in pairs(self._levelVos) do
                        if level == levelVo.id then
                            self._currentSelectedIndex = i - 1
                        end
                    end
                else
                    for index, levelVo in pairs(self._levelVos) do
                        local levelInfo = ActivityCookingComponent.dojo.levelInfo[levelVo.id]
                        if levelInfo.star == 0 then
                            self._currentSelectedIndex = index - 1
                            break
                        end
                    end
                end

                self._endlessLevelIndex = #self._levelVos - 1
            end
        )
    )

    return coWait
end

function ActivityCookingEntryDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self.__OnItemChange)

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingEntryDialog:RefreshLoopList()
    if not self._isInit then
        self.LoopList:InitListView(#self._levelVos - 1, Bind(self, self.OnRefreshListIndex))
        self._isInit = true
    else
        GameUtils.ReloadData(self.LoopList, #self._levelVos - 1)
    end

    local endlessLevelScr = CfUtils.GetLuaScr(self.EndlessLevel, "Game.UI.ActivityCooking.ActivityCookingEntryEndlessLevelNode")
    if endlessLevelScr ~= nil then
        endlessLevelScr:Refresh({index=self._endlessLevelIndex, input=self._levelVos[self._endlessLevelIndex + 1]}, self._currentSelectedIndex, function (index)
            self:OnSelectLevel(index)
        end)
    end
end

---@param listView SuperScrollView.LoopListView2
---@param index number
---@param row number
---@param column number
function ActivityCookingEntryDialog:OnRefreshListIndex(listView, index, row, column)
    if index < 0 then
        return nil
    end

    local cell = listView:NewListViewItem("Cell")
    local data = {
        index = index,
        input = self._levelVos[index + 1]
    }
    local scr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCooking.ActivityCookingEntryNormalLevelNode")
    if scr then
        scr:SetDelegate(self)
        scr:Refresh(data, self._currentSelectedIndex, function (index)
            self:OnSelectLevel(index)
        end)
    else
        printError("[UI][ActivityCookingEntryDialog][OnRefreshListIndex] lua script Game.UI.ActivityCooking.ActivityCookingEntryNormalLevelNode not found")
    end

    return cell
end

function ActivityCookingEntryDialog:OnSelectLevel(index)
    if index < 0 then
        return
    end

    if self._currentSelectedIndex >=0 then
        local endlessLevelScr = CfUtils.GetLuaScr(self.EndlessLevel, "Game.UI.ActivityCooking.ActivityCookingEntryEndlessLevelNode")
        if endlessLevelScr ~= nil then
            endlessLevelScr:Select(false)
        end
        
        local go = self.LoopList:GetShownItemByItemIndex(self._currentSelectedIndex)
        if go then
            local scr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingEntryNormalLevelNode")
            if scr then
                scr:Select(false)
            end
        end
    end

    if index == self._endlessLevelIndex then
        local endlessLevelScr = CfUtils.GetLuaScr(self.EndlessLevel, "Game.UI.ActivityCooking.ActivityCookingEntryEndlessLevelNode")
        self._currentSelectedIndex = index
        if endlessLevelScr ~= nil then
            endlessLevelScr:Select(true)
        end
    else
        local go = self.LoopList:GetShownItemByItemIndex(index)
        if go then
            self._currentSelectedIndex = index
            local scr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingEntryNormalLevelNode")
            if scr then
                scr:Select(true)
            end
        end
    end

    
    self:RefreshLevelInfo()
end

function ActivityCookingEntryDialog:RefreshLevelInfo()

    local levelVo = self._levelVos[self._currentSelectedIndex + 1]
    local levelInfo = ActivityCookingComponent.dojo.levelInfo[levelVo.id]

    if self._currentSelectedIndex == self._endlessLevelIndex then

        local configVo = ActivityCookingUtils.GetCookingConfigVo()
        CfUtils.SetActive(self.NormalStatus, false)
        CfUtils.SetActive(self.EndlessStatus, true)
        CfUtils.FillText(self.TextTime, "∞")
        CfUtils.FillText(self.EndlessTextDesc, configVo.infiniteDes)
        
        local levelTargetDetailScr = CfUtils.GetLuaScr(self.EndlessLevelTarget, "Game.UI.ActivityCooking.ActivityCookingEntryLevelTargetDetail")
        local rewards = {}
        local items = levelVo["rewardItem" .. tostring(1)]
        local nums = levelVo["num" .. tostring(1)]
        for i = 1, #items do
            table.insert(rewards, {goodsId=items[i], num=nums[i]})
        end
        levelTargetDetailScr:Refresh(levelInfo.star >= 1, string.fmt(levelVo.des, {["_num_"]=levelVo.ratingParam[1]}), rewards)
    else
        CfUtils.SetActive(self.EndlessStatus, false)
        CfUtils.SetActive(self.NormalStatus, true)
        CfUtils.FillText(self.TextTime, levelVo.levelDuration)


        for i = 1, 3 do
            local levelTargetDetailScr = CfUtils.GetLuaScr(self["LevelTarget" .. tostring(i)], "Game.UI.ActivityCooking.ActivityCookingEntryLevelTargetDetail")
            local rewards = {}
            local items = levelVo["rewardItem" .. tostring(i)]
            local nums = levelVo["num" .. tostring(i)]
            for i = 1, #items do
                table.insert(rewards, {goodsId=items[i], num=nums[i]})
            end
            levelTargetDetailScr:Refresh(levelInfo.star >= i, string.fmt(levelVo.des, {["_num_"]=levelVo.ratingParam[i]}), rewards)
        end
    end

    local unlock = ActivityCookingComponent.dojo:IsLevelUnlock(levelVo.id)
    local buttonStyle = unlock and "B3" or "B4"
    CfUtils.SetButtonStyle(self.EntryButton, buttonStyle, localize("进入"))
    CfUtils.SetActive(self.CommonBtnConsumePop, unlock)
    CfUtils.SetActive(self.EntryConsume, unlock)
    if unlock then
        CfUtils.FillCommonBtnConsumePopNode(self.EntryConsume, levelVo.costItem, levelVo.costNum)
    end
    
end

function ActivityCookingEntryDialog:OnBtnRankClick()
    ActivityCookingComponent:OpenRankDialog()
end

function ActivityCookingEntryDialog:OnBtnUpgradeClick()
    local dialog = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id].UpgradeDialog
    UIModule.OpenDialog({id=dialog})
end

function ActivityCookingEntryDialog:OnBtnEntryClick()
    local levelVo = self._levelVos[self._currentSelectedIndex + 1]
    local unlock = ActivityCookingComponent.dojo:IsLevelUnlock(levelVo.id)

    if not unlock then
        return
    end

    local levelVo = self._levelVos[self._currentSelectedIndex + 1]
    ActivityCookingComponent:EnterGame(levelVo.id)

end

function ActivityCookingEntryDialog:OnItemChange()
    self:RefreshLevelInfo()
end

return ActivityCookingEntryDialog
