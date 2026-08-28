---
--- Created by Eric.
--- DateTime: 2021/10/19 16:47
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MazeMgr = import('Game.Maze.MazeMgr'):GetInstance()

------------ import ------------

------------ define ------------
local LoopViewMaxCellCount = 4--循环列表最多显示cell数量

------------ define ------------


---@class PatrolHelpSelectDialog
---@field CardListView                  	SuperScrollView.LoopGridView
local PatrolHelpSelectDialog = Class("PatrolHelpSelectDialog")
function PatrolHelpSelectDialog:__init()
    self.data = {}
    self.assistsData = {}
    self.selectIndex = nil
    self:ResetAnimData()

end

function PatrolHelpSelectDialog:__delete()
    self.data = nil
    self.assistsData = nil
    self.selectIndex = nil
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = nil
    end
    self.controller = nil
end

function PatrolHelpSelectDialog:ResetAnimData()
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = false
    end
end

function PatrolHelpSelectDialog:Awake()

end

function PatrolHelpSelectDialog:OnFocus(focus)
end

function PatrolHelpSelectDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            self.data = argument.parameters.data
            self.assistsData = argument.parameters.data.assists
            if not self.CardListView.IsListViewInit then
                self.CardListView:InitGridView(#self.assistsData, Bind(self, self.OnGetItemByIndex))
            else
                GameUtils.ReloadData(self.CardListView, #self.assistsData)
            end
        end
    end))
    return coWait
end

function PatrolHelpSelectDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("CardCell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.Patrol.PatrolHelpSelectCell")
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
        local data = self.assistsData[luaIndex]
        local isSelected = luaIndex == self.selectIndex
        nodeEnv:FreshBaseUI(data)
        nodeEnv:FreshSelectStatus(isSelected)
        nodeEnv:SetBtnCallBack(function ()
            if not isNull(self.selectIndex) then
                local preNode = listView:GetShownItemByItemIndex(self.selectIndex - 1)
                if preNode then
                    local preNodeEnv = CfUtils.GetLuaScr(preNode.gameObject, "Game.UI.Patrol.PatrolHelpSelectCell")
                    if preNodeEnv then
                        preNodeEnv:FreshSelectStatus(false)
                        preNodeEnv:PlaySelectAnim(false)
                    end
                end
            end
            nodeEnv:FreshSelectStatus(true)
            self.selectIndex = luaIndex
        end)
        nodeEnv:SetBtnCallBackGet(function()
            MazeMgr:MazeMoveToAssist(data, function ()
                UIModule.CloseDialog(self.controller)
            end)
        end)
    end
    return cell
end

function PatrolHelpSelectDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolHelpSelectDialog