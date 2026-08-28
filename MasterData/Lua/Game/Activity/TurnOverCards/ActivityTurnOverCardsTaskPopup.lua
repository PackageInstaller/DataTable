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


--- from: Assets/BundleResources/Prefabs/Activity/ActivityTurnOverCardsTaskPopup.prefab
---@class ActivityTurnOverCardsTaskPopup
---@field Env                           	ActivityTurnOverCardsTaskPopup
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnClose                      	UnityEngine.RectTransform
---@field RewardLoopView                	SuperScrollView.LoopListView2
local ActivityTurnOverCardsTaskPopup = Class("ActivityTurnOverCardsTaskPopup")
function ActivityTurnOverCardsTaskPopup:__init()
    self.taskList = {}

end

function ActivityTurnOverCardsTaskPopup:__delete()
    self.taskList = nil


    self.controller = nil
end

function ActivityTurnOverCardsTaskPopup:Awake()
    SetButtonAction(self.BtnClose.gameObject, function()
        UIModule.BackDialog()
    end)
end

function ActivityTurnOverCardsTaskPopup:OnFocus(focus)
end

function ActivityTurnOverCardsTaskPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.parameters = self.controller.Argument.parameters
        GameUtils.Request(
                Interfaces.ActivityFlipCardTasks,
                {activityUuid = self.parameters.activityUuid},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        print("---->>"..table.dump(response.data, nil, 3))
                        self.taskList = response.data.tasks

                        self:FreshList()
                    end
                end
        )
    end))
    return coWait
end

function ActivityTurnOverCardsTaskPopup:FreshList()
    self:SortTaskData()
    if not self.RewardLoopView.IsListViewInit then
        self.RewardLoopView:InitListView(#self.taskList, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.RewardLoopView, #self.taskList)
    end
end

function ActivityTurnOverCardsTaskPopup:SortTaskData()
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

function ActivityTurnOverCardsTaskPopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.Activity.TurnOverCards.ActivityTurnOverCardsTaskPopupCell")
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
                    Interfaces.ActivityFlipCardDraw,
                    {activityUuid = self.parameters.activityUuid, taskId = data.id},
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            print("---->>"..table.dump(response.data, nil, 3))
                            self.taskList[luaIndex].status = Constants.GetStatus.Has
                            GoodsUtils.DrawRewards(response.data.rewards)
                            UIModule.OpenDialog(
                                    {
                                        id = Constants.UITypeIds.UICommonRewardPop,
                                        parameters = { rewards = response.data.rewards, cb = function()

                                        end }
                                    }
                            )
                            self:FreshList()

                        end
                    end
            )
        end)
    end
    return cell
end



function ActivityTurnOverCardsTaskPopup:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.parameters.cb then
            local hasUnclaimed = false
            for i, v in pairs(self.taskList) do
                if checkNumber(v.status) == Constants.GetStatus.Can then
                    hasUnclaimed = true
                    break
                end
            end
            self.parameters.cb(hasUnclaimed)
        end
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return ActivityTurnOverCardsTaskPopup