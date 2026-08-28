-------------------------------------------------------------------------------
-- 和风战牌 - 牌组等级界面 - 等级列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 10:34:44
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerLvRuleNode.prefab > name: ActivityJapanesePokerLvRuleNode
---@class BattleCardGameDeckLevelCell
---@field Env                           	BattleCardGameDeckLevelCell             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field CellBgNode                    	UnityEngine.RectTransform               	@ 1    背景节点
---@field LevelTitleTxt                 	UnityEngine.RectTransform               	@ 2    等级标题文本
---@field ConditionTxt                  	UnityEngine.RectTransform               	@ 3    解锁条件文本
---@field LevelDescrTxt                 	UnityEngine.RectTransform               	@ 4    等级描述文本
---@field LevelEnableNode               	UnityEngine.RectTransform               	@ 5    等级开启节点
---@field CollectNumTxt                 	UnityEngine.RectTransform               	@ 6    收集数量文本
local BattleCardGameDeckLevelCell = Class('BattleCardGameDeckLevelCell')


function BattleCardGameDeckLevelCell:__init()
end


function BattleCardGameDeckLevelCell:__delete()
end


function BattleCardGameDeckLevelCell:Awake()
end


function BattleCardGameDeckLevelCell:Start()
end


function BattleCardGameDeckLevelCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameDeckLevelCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameDeckLevelCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameDeckLevelDialog.LevelCellData
function BattleCardGameDeckLevelCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameDeckLevelDialog.LevelCellData
function BattleCardGameDeckLevelCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


-------------------------------------------------
-- private

function BattleCardGameDeckLevelCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type BattleCardGameDeckInfoVo
    local deckInfoVo  = checkTable(cellData.deckInfoVo)
    local isActivated = checkBool(cellData.isActivated)
    local hasCardsNum = checkInt(cellData.hasCardsNum)

    -- update info
    local freeLimit  = BattleCardGameUtils.DeckFreeLimit
    local levelLimit = checkInt(deckInfoVo.levelLimit)
    local collectNum = checkInt(deckInfoVo.collectNum)
    CfUtils.FillText(self.LevelTitleTxt, localize('牌组等级：_num_', {_num_ = tostring(deckInfoVo.levelText)}))
    CfUtils.FillText(self.ConditionTxt, localize('收集_num_张战牌后解锁：', {_num_ = collectNum}))
    CfUtils.FillText(self.LevelDescrTxt, localize('能带_num1_张任意星级的战牌，其他战牌星级不可超过_num2_级。', {_num1_ = freeLimit, _num2_ = levelLimit}))
    CfUtils.FillText(self.CollectNumTxt, string.fmt('%1/%2', hasCardsNum, collectNum))

    -- update state
    CfUtils.SetActive(self.LevelEnableNode, isActivated)
    CfUtils.SetActive(self.CollectNumTxt, not isActivated)
    CfUtils.SetUISwitchImage(self.CellBgNode, isActivated and 1 or 2)
    CfUtils.SetUISwitchText(self.LevelDescrTxt, isActivated and 2 or 1)
end


return BattleCardGameDeckLevelCell
