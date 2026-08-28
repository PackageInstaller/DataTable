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


--- from: Assets/BundleResources/Prefabs/SnowFestival/SnowFestivalPlotReviewDialog121501.prefab
---@class SnowFestivalPlotReviewDialog
---@field Env                           	SnowFestivalPlotReviewDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ListView                      	SuperScrollView.LoopListView2
local SnowFestivalPlotReviewDialog = Class("SnowFestivalPlotReviewDialog")
function SnowFestivalPlotReviewDialog:__init()
    self.data = {}

end

function SnowFestivalPlotReviewDialog:__delete()
    self.data = nil

    self.controller = nil
end

function SnowFestivalPlotReviewDialog:Awake()
    --SetButtonAction(self.BtnClose.gameObject, function()
    --    UIModule.BackDialog()
    --end)
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))

end

function SnowFestivalPlotReviewDialog:PlotPlaying(isPlotPlaying)
    self.controller.gameObject.transform.localPosition = isPlotPlaying and Vector3(9999, 9999, 9999) or Vector3(0, 0, 0)
end

function SnowFestivalPlotReviewDialog:OnFocus(focus)
end

function SnowFestivalPlotReviewDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        comp.isUnlockNewPlot = false
        self.data = comp:GetPlotConfigData()
        self:FreshList()
    end))
    return coWait
end

function SnowFestivalPlotReviewDialog:FreshList()
    if not self.ListView.IsListViewInit then
        self.ListView:InitListView(#self.data, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ListView, #self.data)
    end
end


function SnowFestivalPlotReviewDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.Activity.SnowFestival.SnowFestivalPlotReviewNode")
    if nodeEnv then
        local data = self.data[luaIndex]
        nodeEnv:FreshBaseUI(data, index)
        --nodeEnv:SetBtnCallBack(function()--播剧情
        --    
        --end)
    end
    return cell
end



function SnowFestivalPlotReviewDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SnowFestivalPlotReviewDialog