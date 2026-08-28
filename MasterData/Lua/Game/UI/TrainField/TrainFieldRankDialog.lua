---
--- Created by Eric.
--- DateTime: 2022/2/22 10:33
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


---@class TrainFieldRankDialog
---@field EmptyNode                     	UnityEngine.RectTransform
---@field MyRankingGroup                	Engine.Modules.LuaBehaviour
---@field ListView                      	SuperScrollView.LoopListView2
---@field RightPanel                    	UnityEngine.RectTransform
---@field CommonTabToggleUp             	Engine.Modules.LuaBehaviour
local TrainFieldRankDialog = Class("TrainFieldRankDialog")
function TrainFieldRankDialog:__init()
    self.data = {}
    self.dataVo = {}
    self.currentData = {}--当前榜单的数据
    self.chooseGroup = nil
    self.myItemIndex = nil
    self.currentQuestId = nil
    self.myData = {} --我的数据
    self:ResetAnimData()


end

function TrainFieldRankDialog:__delete()
    self.data = nil
    self.dataVo = nil
    self.chooseGroup = nil
    self.myItemIndex = nil
    self.currentQuestId = nil
    self.myData = nil
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = nil
    end
    self.controller = nil
end

function TrainFieldRankDialog:ResetAnimData()
    for i = 1, LoopViewMaxCellCount do
        self["isAnimated"..i] = false
    end
end

function TrainFieldRankDialog:Awake()
    self.CommonTabToggleUpEnv = CfUtils.GetLuaScr(self.CommonTabToggleUp.transform, "Game.Behaviours.CommonTabToggleUp")
    self.MyRankingGroupEnv = CfUtils.GetLuaScr(self.MyRankingGroup.transform, "Game.UI.TrainField.TrainFieldRankCell")


    GameUtils.Request(
            Interfaces.WoodenDummyRank,
            {},
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    self.data = response.data.rankInfo--key 关卡id value 排名信息
                    print("=====>>"..table.dump(self.data, nil, 5))
                    self:FreshBaseUI()
                end
            end
    )
    --self.data = {
    --    ["290101"] =
    --    {
    --        {
    --         ["posX"] = 20,
    --         ["name"] = "河合尚子",
    --         ["team"] = {},
    --         ["image"] = 8,
    --         ["avatar"] = 0,
    --         ["playerId"] = -143,
    --         ["level"] = 13,
    --         ["order"] = 1,
    --         ["avatarFrame"] = 0,
    --         ["score"] = 323351,
    --        },
    --
    --    },
    --    ["290201"] =
    --    {
    --        {
    --            ["posX"] = 167,
    --            ["name"] = "管沼留美奈",
    --            ["team"] = {},
    --            ["image"] = 11,
    --            ["avatar"] = 0,
    --            ["playerId"] = -263,
    --            ["level"] = 27,
    --            ["order"] = 2,
    --            ["avatarFrame"] = 0,
    --            ["score"] = 304396,
    --        },
    --
    --    },
    --    ["290301"] =
    --    {
    --        {
    --            ["posX"] = 167,
    --            ["name"] = "管沼留美奈",
    --            ["team"] = {},
    --            ["image"] = 11,
    --            ["avatar"] = 0,
    --            ["playerId"] = -263,
    --            ["level"] = 27,
    --            ["order"] = 2,
    --            ["avatarFrame"] = 0,
    --            ["score"] = 304396,
    --        } ,
    --
    --    },
    --}
    --self:FreshBaseUI()
end

function TrainFieldRankDialog:FreshBaseUI()
    local toggleData = {

    }
    local vo = CfUtils.GetWholeVo(AutoIds.IdSetting1200, "TrainFieldLevelVo")
    for i, v in pairs(vo) do
        if isNull(self.dataVo[checkString(v.group)]) then
            self.dataVo[checkString(v.group)] = {}
        end
        table.insert(self.dataVo[checkString(v.group)], v)
    end
    for k, v in pairs(self.data) do
        if checkNumber(k) == 1 then
            self.currentData = v
            self.currentQuestId = self.dataVo[k][1].id
            self:SetMyItemIndex()
        end
        toggleData[checkNumber(k)] = {
            text = self.dataVo[k][1].name,
            func = function()
                self.currentData = v
                self.currentQuestId = self.dataVo[k][1].id
                self:SetMyItemIndex()
                self:OnClickToggleAction()
            end
        }


        --local questVo = QuestConfMgr:GetInstance():GetQuestVoById(k)
        --if checkNumber(questVo.group) == 1 then
        --    self.currentData = v
        --    self.currentQuestId = k
        --    self:SetMyItemIndex()
        --end
        --toggleData[checkNumber(questVo.group)] = {
        --    text = questVo.name,
        --    func = function()
        --        self.currentData = v
        --        self.currentQuestId = k
        --        self:SetMyItemIndex()
        --        self:OnClickToggleAction()
        --    end
        --}
    end
    self.CommonTabToggleUpEnv:FillToggles(toggleData)
    --local hasMyData = table.count(self.myData) > 0
    --KTool.SetActive(self.MyRankingGroup.transform, hasMyData)
    --if hasMyData then
    --    self.MyRankingGroupEnv:FreshBaseUI(self.myData)
    --end
    self:OnClickToggleAction()
end

function TrainFieldRankDialog:OnClickToggleAction()
    local isEmpty = table.count(self.currentData) == 0
    KTool.SetActive(self.EmptyNode, isEmpty)
    KTool.SetActive(self.RightPanel, not isEmpty)
    local hasMyData = table.count(self.myData) > 0
    --KTool.SetActive(self.MyRankingGroup.transform, hasMyData)
    if hasMyData then
        self.MyRankingGroupEnv:FreshBaseUI(self.myData)
    end
    if not isEmpty then
        if not self.ListView.IsListViewInit then
            self.ListView:InitListView(#self.currentData, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.ListView, #self.currentData)
        end
        self.ListView.mOnSnapNearestChanged = Bind(self, self.OnListViewSnapTargetChanged)
    end

end

function TrainFieldRankDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("RankCellNode")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.TrainField.TrainFieldRankCell")
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
        local data = self.currentData[luaIndex]
        data["order"] = luaIndex
        data["questId"] = self.currentQuestId
        nodeEnv:FreshBaseUI(data)
        KTool.SetActive(cell, true)
    end
    return cell
end

function TrainFieldRankDialog:OnListViewSnapTargetChanged()
    local hasMyData = table.count(self.myData) > 0
    local myCell = self.ListView:GetShownItemByItemIndex(self.myItemIndex)
    KTool.SetActive(self.MyRankingGroup.transform, hasMyData and isNull(myCell))
end

function TrainFieldRankDialog:SetMyItemIndex()
    self.myItemIndex = nil
    self.myData = {}
    for i, v in pairs(self.currentData) do
        if checkString(v.playerId) == GameUtils.GetPlayerId() then
            v["order"] = i
            v["questId"] = self.currentQuestId
            self.myItemIndex = i - 1
            self.myData = v
            break
        end
    end
end

function TrainFieldRankDialog:OnFocus(focus)
end

function TrainFieldRankDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function TrainFieldRankDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return TrainFieldRankDialog