-------------------------------------------------------------------------------
-- 和风战牌 - 规则界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 14:56:28
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local RuleListCellPath = 'Game.UI.BattleCardGame.BattleCardGameRuleCell'
local RuleListCellName = 'ActivityJapanesePokerCradRuleNode'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerCradRulePopup.prefab > name: ActivityJapanesePokerCradRulePopup
---@class BattleCardGameRuleDialog
---@field Env                           	BattleCardGameRuleDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BackBoard                     	UnityEngine.RectTransform               	@ 1    背板节点
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field RuleLoopView                  	SuperScrollView.LoopListView2           	@ 3    规则列表
local BattleCardGameRuleDialog = Class('BattleCardGameRuleDialog')


function BattleCardGameRuleDialog:__init()
    ---@type BattleCardGameRuleInfoVo
    self.ruleVoList_ = {}
end


function BattleCardGameRuleDialog:__delete()
    self.ruleVoList_ = nil
end


function BattleCardGameRuleDialog:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BackBoard, Bind(self, self.OnClickCloseButtonHandler_))
    SetListViewAction(self.RuleLoopView, Bind(self, self.OnUpdateRuleListCellHandler_), RuleListCellName)
end


function BattleCardGameRuleDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        local npcQuestId = checkInt(initParams.questId)
        local ruleIdList = {}
        if npcQuestId > 0 then
            local questVo = BattleCardGameUtils.GetNpcQuestVo(npcQuestId)
            ruleIdList = questVo.questRules
        else
            ruleIdList = checkTable(initParams.ruleIdList)
        end
        self:UpdateRuleInfo_(ruleIdList)
    end)
end


function BattleCardGameRuleDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return BattleCardGameRuleInfoVo[]
function BattleCardGameRuleDialog:GetRuleVoList()
    return checkTable(self.ruleVoList_)
end


-------------------------------------------------
-- private

---@param ruleIdList integer[]
function BattleCardGameRuleDialog:UpdateRuleInfo_(ruleIdList)
    self.ruleVoList_ = {}

    for ruleIndex, ruleId in ipairs(checkTable(ruleIdList)) do
        self.ruleVoList_[ruleIndex] = BattleCardGameUtils.GetRuleInfoVo(ruleId)
    end

    self:UpdateRuleList_()
end


function BattleCardGameRuleDialog:UpdateRuleList_()
    local listDataLength = #self:GetRuleVoList()
    GameUtils.ReloadData(self.RuleLoopView, listDataLength)
end


-------------------------------------------------
-- handler

function BattleCardGameRuleDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function BattleCardGameRuleDialog:OnUpdateRuleListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(RuleListCellName)
    local cellData = self:GetRuleVoList()[luaIndex]
    ---@type BattleCardGameRuleCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, RuleListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
    end
    return cellNode
end


return BattleCardGameRuleDialog
