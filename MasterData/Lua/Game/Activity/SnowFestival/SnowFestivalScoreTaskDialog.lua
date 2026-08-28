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


--- from: Assets/BundleResources/Prefabs/SnowFestival/SnowFestivalScoreTaskDialog121501.prefab
---@class SnowFestivalScoreTaskDialog
---@field Env                           	SnowFestivalScoreTaskDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field CanReceive                    	UnityEngine.RectTransform
---@field Complete                      	UnityEngine.RectTransform
---@field TextScore                     	UnityEngine.RectTransform
---@field Normal                        	UnityEngine.RectTransform
---@field UIFX_SnowFestivalScoreTaskDialog_CD	UnityEngine.RectTransform
---@field ImgCD                         	UnityEngine.RectTransform
---@field BtnMusicPlayer                	UnityEngine.RectTransform
---@field BtnChapterList                	FancyScrollView.FancyScrollView
---@field RewardLoopView                	SuperScrollView.LoopListView2
---@field TextNumber                    	UnityEngine.RectTransform
local SnowFestivalScoreTaskDialog = Class("SnowFestivalScoreTaskDialog")
function SnowFestivalScoreTaskDialog:__init()
    self.selectedPlotIndex = 0  --这里索引从0开始
    
end

function SnowFestivalScoreTaskDialog:__delete()

    self.selectedPlotIndex = nil


    self.controller = nil
end

function SnowFestivalScoreTaskDialog:Awake()
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))
    self.EventPopDialogClose = Events.AddListener(Constants.EventNames.SnowFestivalPlotPopDialogClose, Bind(self, self.PopDialogClose))

end

function SnowFestivalScoreTaskDialog:PlotPlaying(isPlotPlaying)
    self.controller.gameObject.transform.localPosition = isPlotPlaying and Vector3(9999, 9999, 9999) or Vector3(0, 0, 0)
end

function SnowFestivalScoreTaskDialog:PopDialogClose()
    self:FreshMusicPlayer()
    if self.BtnChapterList then
        self.BtnChapterList:Refresh()
    end
end

function SnowFestivalScoreTaskDialog:OnFocus(focus)
end

function SnowFestivalScoreTaskDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        self.activityDojo = comp:GetActivityDojo()
        GameUtils.Request(
                Interfaces.ActivityIceSnowFestivalTasks,
                {activityUuid = self.activityDojo.id},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        self.taskList = response.data.tasks
                        self.data = comp:GetPlotConfigData()
                        for i, v in pairs(self.data) do
                            self.data[i]["index"] = i - 1
                        end
                        self.selectedPlotIndex = comp:GetNextPlotIndex()
                        print("taskList11---->>"..table.dump(self.taskList, nil, 3))
                        self:FreshBaseUI()
                    end
                end
        )
    end))
    return coWait
end

function SnowFestivalScoreTaskDialog:FreshTaskList()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    local homeData = comp:GetHomeData()
    CfUtils.FillText(self.TextNumber, homeData.point)
    self:SortTaskData()
    print("taskList22---->>"..table.dump(self.taskList, nil, 3))

    if not self.RewardLoopView.IsListViewInit then
        self.RewardLoopView:InitListView(#self.taskList, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.RewardLoopView, #self.taskList)
    end
end

function SnowFestivalScoreTaskDialog:SortTaskData()
    local canList = {}
    local notList = {}
    local getList = {}
    for k, v in pairs(self.taskList) do
        if v.status == Constants.GetStatus.Can then
            table.insert(canList, v)
        elseif v.status == Constants.GetStatus.Not then
            table.insert(notList, v)
        elseif v.status == Constants.GetStatus.Has then
            table.insert(getList, v)
        end
    end
    self.taskList = {}
    for k, v in pairs(canList) do
        table.insert(self.taskList, v)
    end
    for k, v in pairs(notList) do
        table.insert(self.taskList, v)
    end
    for k, v in pairs(getList) do
        table.insert(self.taskList, v)
    end
end

function SnowFestivalScoreTaskDialog:FreshMusicPlayer()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    if isNull(self.selectedPlotIndex) then
        return
    end
    local luaIndex =  self.selectedPlotIndex + 1 
    local data = self.data[luaIndex]
    CfUtils.FillImage(self.ImgCD, data.plotImage)
    CfUtils.FillText(self.TextScore, data.unlockPoint)
    --local isUnlock = comp:IsUnlockPlot(data.id)
    local canGet = comp:CanGetPlot(data.id)
    local isGet = comp:IsGetPlot(data.id)
    local homeData = comp:GetHomeData()
    local canUnlock = checkNumber(homeData.point) >= data.unlockPoint
    KTool.SetActive(self.UIFX_SnowFestivalScoreTaskDialog_CD, canUnlock)
    KTool.SetActive(self.Normal, not canGet)
    KTool.SetActive(self.Complete, isGet)
    KTool.SetActive(self.CanReceive, canGet)
end

function SnowFestivalScoreTaskDialog:FreshBaseUI()
    --region 剧情
    self.BtnChapterList:InitListView(table.count(self.data), self.data)
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    self.BtnChapterList:MovePanelToIndex(self.selectedPlotIndex)--加上插入的是21组数据
    self:FreshMusicPlayer()
    self.BtnChapterList.OnIndexChanged = function(index)
        print(self.selectedPlotIndex.."<<=======>>"..index)
        if index+1 >= 1 and index+1 <= #self.data then
            self.selectedPlotIndex = math.round(index)
            self:FreshMusicPlayer()
        end
    end
    ---@type Engine.UI.Guide.EventPasser
    local passer = KTool.GetOrAddComponent(self.BtnChapterList.gameObject, typeof(CS.Engine.UI.Guide.EventPasser))
    if passer then
        passer:AddSpecifyGameObject(self.BtnMusicPlayer.gameObject)
        local rectTransform = KTool.GetComponent(self.BtnMusicPlayer.gameObject, typeof(CS.UnityEngine.RectTransform))
        local list = CfUtils.GetCornersPosList(rectTransform, UIModule.RootCanvas.canvas.transform, CS.Game.Native.URP.URPCameraController.Instance.uiCamera)
        --for i = 1, 4 do
        --    if list[i] then
        --        print(i..string.format("===11==>>xPos:%s-yPos:%s",list[i].x, list[i].y))
        --    end
        --end
        passer:AddCorners(
                --Vector2.New(-900, list[1].y),
                --Vector2.New(-900, list[2].y),
                Vector2.New(list[1].x + rectTransform.rect.width/2, list[1].y), 
                Vector2.New(list[2].x + rectTransform.rect.width/2, list[2].y), 
                Vector2.New(list[3].x + rectTransform.rect.width/2, list[3].y), 
                Vector2.New(list[4].x + rectTransform.rect.width/2, list[4].y)
        )
        --passer:AddCorners(list[1], list[2], list[3], list[4])
    end
    SetButtonAction(self.BtnMusicPlayer, function()
        self.BtnChapterList:MovePanelToIndex(self.selectedPlotIndex)--加上插入的是21组数据
        comp:SetSelectedPlotLuaIndex(self.selectedPlotIndex + 1)

            UIModule.OpenDialog({ id = Constants.UITypeIds.SnowFestivalChapterPopDialog, parameters = {
            --cb = function ()
            --
            --end,
        }},

                {
                    --{id = Constants.UITypeIds.SnowFestivalMainDialog}
                })
    end)
    --endregion
    --region 任务

    self:FreshTaskList()
    --endregion
    
end

function SnowFestivalScoreTaskDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.Activity.SnowFestival.SnowFestivalTaskNode")
    if nodeEnv then
        --[[
        		"id": 1,
                "status": 0,
                "progress": 0
        ]]
        local data = self.taskList[luaIndex]
        nodeEnv:FreshBaseUI(data)
        nodeEnv:SetBtnCallBack(function()
            GameUtils.Request(
                    Interfaces.ActivityIceSnowFestivalTaskDraw,
                    {activityUuid = self.activityDojo.id, taskId = data.id},
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            self.taskList[luaIndex].status = Constants.GetStatus.Has
                            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
                            local homeData = comp:GetHomeData()
                            local vo = CfUtils.GetCfVo(AutoIds.IdSetting2842, "SnowFestivalTaskVo", data.id)
                            local point = homeData.point + vo.point
                            comp:SetTaskPoint(point)
                            GoodsUtils.DrawRewards(response.data.rewards)
                            UIModule.OpenDialog(
                                    {
                                        id = Constants.UITypeIds.UICommonRewardPop,
                                        parameters = { rewards = response.data.rewards, cb = function()

                                        end }
                                    }
                            )
                            self:FreshTaskList()
                            self:UpdateFancyNode()
                        end
                    end
            )
        end)
    end
    return cell
end

function SnowFestivalScoreTaskDialog:UpdateFancyNode()
    ---@type SnowFestivalComponent
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    ---@type SnowFestivalPlotVo[]
    local plotConfigDatas = comp:GetPlotConfigData()
    local homeData = comp:GetHomeData()
    local unlockedPlotIds = homeData.unlockedPlotIds or {}
    for k, v in pairs(plotConfigDatas) do
        local id = checkInt(v.id)
        local isHave = false
        for kk , vv in pairs(unlockedPlotIds) do
            if checkInt(vv) == id then
                isHave = true
                break
            end
        end
        if not isHave then
            if checkInt(homeData.point) >= checkInt(v.unlockPoint) then
                local cell =  self.BtnChapterList:GetShownItemByItemIndex(k-1)
                if isNotNull(cell) then
                    cell:UpdateCellContent(self.data[k])
                end
            end 
            break
        end
    end
end


function SnowFestivalScoreTaskDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        Events.RemoveListener(Constants.EventNames.SnowFestivalPlotPopDialogClose, self.EventPopDialogClose)

        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SnowFestivalScoreTaskDialog