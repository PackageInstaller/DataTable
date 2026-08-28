---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/SnowFestival/SnowFestivalChapterPopDialog121501.prefab
---@class SnowFestivalPlotPopDialog
---@field Env                           	SnowFestivalPlotPopDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field StatusComplete                	UnityEngine.RectTransform
---@field ImgCD                         	UnityEngine.RectTransform
---@field TextNumber                    	UnityEngine.RectTransform
---@field UIFX_SnowFestivalScoreTaskDialog_CD	UnityEngine.RectTransform
---@field UIFX_FontStyleButton_effect   	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field TextNumberScore               	UnityEngine.RectTransform
---@field BtnEnter                      	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field TextDesc                      	UnityEngine.RectTransform
---@field TextTitle                     	UnityEngine.RectTransform
---@field UnLock                        	UnityEngine.RectTransform
---@field Lock                          	UnityEngine.RectTransform
local SnowFestivalPlotPopDialog = Class("SnowFestivalPlotPopDialog")
function SnowFestivalPlotPopDialog:__init()
    self.data = {}

end

function SnowFestivalPlotPopDialog:__delete()
    self.data = nil


    self.controller = nil
end

function SnowFestivalPlotPopDialog:Awake()
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))

end

function SnowFestivalPlotPopDialog:PlotPlaying(isPlotPlaying)
    
    self.controller.gameObject.transform.localPosition = isPlotPlaying and Vector3(9999, 9999, 9999) or Vector3(0, 0, 0)
end

function SnowFestivalPlotPopDialog:OnFocus(focus)
end

function SnowFestivalPlotPopDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.parameters = self.controller.Argument.parameters
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        self.selectedPlotLuaIndex = comp:GetSelectedPlotLuaIndex()
        local plotConfigData = comp:GetPlotConfigData()
        
        self.data = plotConfigData[self.selectedPlotLuaIndex]
        self.activityDojo = comp:GetActivityDojo()
        self:FreshBaseUI()
        

    end))
    return coWait
end

function SnowFestivalPlotPopDialog:FreshBaseUI()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    local isUnlock = comp:IsUnlockPlot(self.data.id) 
    local canGet = comp:CanGetPlot(self.data.id)
    local isGet = comp:IsGetPlot(self.data.id)
    local homeData = comp:GetHomeData()
    local canUnlock = checkNumber(homeData.point) >= self.data.unlockPoint
    KTool.SetActive(self.Lock,not (isUnlock or canUnlock)  )
    KTool.SetActive(self.UnLock, isUnlock or canUnlock)
    if isUnlock or canUnlock then
        CfUtils.FillText(self.TextTitle, self.data.name)
        CfUtils.FillText(self.TextDesc, self.data.plotDesc)
    end
    local scr = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsList")
    local rewards = parse_rewards(self.data.showItem, self.data.showItemNum)
    if scr then
        scr:FreshBaseUI(rewards, canGet, isGet)
    end
    KTool.SetActive(self.BtnEnter, not isUnlock)
    local homeData = comp:GetHomeData()
    local canUnlock = checkNumber(homeData.point) >= self.data.unlockPoint
    CfUtils.SetUISwitchImage(self.BtnEnter.transform:Find("ImgEnter"), canUnlock and 2 or 1)
    local index = comp:GetNextPlotIndex()
    KTool.SetActive(self.UIFX_SnowFestivalScoreTaskDialog_CD, canUnlock and (not isUnlock) and (index + 1 == self.selectedPlotLuaIndex))
    SetButtonAction(self.BtnEnter, function()
        if isUnlock then
            return
        end
        local homeData = comp:GetHomeData()
        local canUnlock = checkNumber(homeData.point) >= self.data.unlockPoint
        if canUnlock then
            if comp:IsUnlockPlot(self.data.unlockPlot) or checkNumber(self.data.unlockPlot) == 0 then
                comp:EnterPlot(self.data,
                        function()
                            self:FreshBaseUI()
                        end,
                        function()

                        end)
            else
                GameUtils.Toast(localize("上一章节未完成"))
            end
        else
            GameUtils.Toast(localize("当前积分不足"))
        end
    end)
    CfUtils.FillText(self.TextNumberScore.gameObject, self.data.unlockPoint)
    CfUtils.FillText(self.TextNumber, format_tens_place(self.selectedPlotLuaIndex - 1))
    KTool.SetActive(self.FontStyleButton, canGet)
    SetButtonAction(self.FontStyleButton, function()
        if canGet then
            comp:GetPlotRewards(self.data, function()
                self:FreshBaseUI()
            end)
        end
    end)
    CfUtils.FillImage(self.ImgCD, self.data.plotImage)
    KTool.SetActive(self.StatusComplete, isGet)
end

function SnowFestivalPlotPopDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        --if self.parameters.cb then
        --    self.parameters.cb()
        --end
        Events.Broadcast(Constants.EventNames.SnowFestivalPlotPopDialogClose)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SnowFestivalPlotPopDialog