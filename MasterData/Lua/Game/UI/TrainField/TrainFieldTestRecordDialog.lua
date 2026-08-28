---
--- Created by Eric.
--- DateTime: 2022/2/21 10:24
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------
local LoopViewMaxCellCount = 6--循环列表最多显示cell数量

------------ define ------------


---@class TrainFieldTestRecordDialog
---@field EmptyNode                     	UnityEngine.RectTransform
---@field ListView                      	SuperScrollView.LoopGridView
local TrainFieldTestRecordDialog = Class("TrainFieldTestRecordDialog")
function TrainFieldTestRecordDialog:__init()
    self.data = {}
    self:ResetAnimData()

end

function TrainFieldTestRecordDialog:__delete()
    self.data = nil
    self.controller = nil
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = nil
    end
end

function TrainFieldTestRecordDialog:ResetAnimData()
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = false
    end
end

function TrainFieldTestRecordDialog:Awake()
    GameUtils.Request(
            Interfaces.WoodenDummyRecord,
            {},
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    self.data = response.data.record
                    self:FreshBaseUI()
                end
            end
    )
end

function TrainFieldTestRecordDialog:FreshBaseUI()
    local isEmpty = table.count(self.data) == 0
    KTool.SetActive(self.EmptyNode, isEmpty)
    if not isEmpty then
        if not self.ListView.IsListViewInit then
            self.ListView:InitGridView(#self.data, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.ListView, #self.data)
        end
    end
end

function TrainFieldTestRecordDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.TrainField.TrainFieldTestRecordCell")
    if nodeEnv then
        local luaIndex = index + 1
        --@region 刚进入列表时播放延时出现动画
        if not isNull(self["isAnimated"..luaIndex]) then
            if not self["isAnimated"..luaIndex] then
                self["isAnimated"..luaIndex] = true
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), luaIndex)
            else
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), 0)
            end
        else
            CfUtils.PlayDelayShowAnimate(cell.transform:Find("AnimRoot"), 0)
        end
        --@endregion
        local data = self.data[luaIndex]
        nodeEnv:FreshBaseUI(data)
    end
    return cell
end

function TrainFieldTestRecordDialog:OnFocus(focus)
end

function TrainFieldTestRecordDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function TrainFieldTestRecordDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return TrainFieldTestRecordDialog