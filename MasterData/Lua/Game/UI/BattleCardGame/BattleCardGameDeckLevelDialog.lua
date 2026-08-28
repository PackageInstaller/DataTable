-------------------------------------------------------------------------------
-- 和风战牌 - 牌组等级界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 14:56:28
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local LevelListCellPath = 'Game.UI.BattleCardGame.BattleCardGameDeckLevelCell'
local LevelListCellName = 'ActivityJapanesePokerLvRuleNode'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerLvRulePopup.prefab > name: ActivityJapanesePokerLvRulePopup
---@class BattleCardGameDeckLevelDialog
---@field Env                           	BattleCardGameDeckLevelDialog           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BackBoard                     	UnityEngine.RectTransform               	@ 1    背板节点
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field LevelLoopView                 	SuperScrollView.LoopListView2           	@ 3    等级列表
local BattleCardGameDeckLevelDialog = Class('BattleCardGameDeckLevelDialog')


function BattleCardGameDeckLevelDialog:__init()
    ---@type integer @ 当前牌组等级
    self.deckLevel_ = 0

    ---@type integer @ 拥有的卡牌数量
    self.hasCardsNum_ = 0

    ---@type BattleCardGameDeckLevelDialog.LevelCellData[]
    self.levelDataList_ = {}
end


function BattleCardGameDeckLevelDialog:__delete()
    self.deckLevel_     = nil
    self.hasCardsNum_   = nil
    self.levelDataList_ = nil
end


function BattleCardGameDeckLevelDialog:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BackBoard, Bind(self, self.OnClickCloseButtonHandler_))
    SetListViewAction(self.LevelLoopView, Bind(self, self.OnUpdateLevelListCellHandler_), LevelListCellName)
end


function BattleCardGameDeckLevelDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams  = CfUtils.DialogSafeParameters(self.controller)
        self.deckLevel_   = battleCardGameComp:GetHomeDojo():GetDeckLevel()
        self.hasCardsNum_ = battleCardGameComp:GetHomeDojo():GetCardsCount()
        self:InitLevelDatas_()
        self:UpdateLevelList_()
    end)
end


function BattleCardGameDeckLevelDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameDeckLevelDialog:GetDeckLevel()
    return checkInt(self.deckLevel_)
end


---@return integer
function BattleCardGameDeckLevelDialog:GetHasCardsNum()
    return checkInt(self.hasCardsNum_)
end


---@return BattleCardGameDeckLevelDialog.LevelCellData[]
function BattleCardGameDeckLevelDialog:GetLevelDataList()
    return checkTable(self.levelDataList_)
end


-------------------------------------------------
-- private

function BattleCardGameDeckLevelDialog:InitLevelDatas_()
    self.levelDataList_ = {}
    for deckIndex, deckInfoVo in ipairs(BattleCardGameUtils.GetAllDeckInfoVo()) do
        ---@class BattleCardGameDeckLevelDialog.LevelCellData
        ---@field deckInfoVo BattleCardGameDeckInfoVo
        ---@field hasCardsNum integer
        ---@field isActivated boolean
        local levelCellData = {
            deckInfoVo  = deckInfoVo,
            hasCardsNum = self:GetHasCardsNum(),
            isActivated = self:GetDeckLevel() >= deckInfoVo.deckId,
        }
        self.levelDataList_[deckIndex] = levelCellData
    end
end


function BattleCardGameDeckLevelDialog:UpdateLevelList_()
    local listDataLength = #self:GetLevelDataList()
    GameUtils.ReloadData(self.LevelLoopView, listDataLength)
end


-------------------------------------------------
-- handler

function BattleCardGameDeckLevelDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function BattleCardGameDeckLevelDialog:OnUpdateLevelListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(LevelListCellName)
    local cellData = self:GetLevelDataList()[luaIndex]
    ---@type BattleCardGameDeckLevelCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, LevelListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
    end
    return cellNode
end


return BattleCardGameDeckLevelDialog
