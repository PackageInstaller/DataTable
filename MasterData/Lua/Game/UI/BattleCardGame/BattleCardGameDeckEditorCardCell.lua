-------------------------------------------------------------------------------
-- 和风战牌 - 编辑牌组界面 - 卡牌单元
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-31 15:49:30
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerEditDialog.prefab > name: card
---@class BattleCardGameDeckEditorCardCell
---@field Env                           	BattleCardGameDeckEditorCardCell        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field PokerCardNode                 	UnityEngine.RectTransform               	@ 1    战牌节点
---@field SelectMaskNode                	UnityEngine.RectTransform               	@ 2    选择遮罩节点
local BattleCardGameDeckEditorCardCell = Class('BattleCardGameDeckEditorCardCell')


function BattleCardGameDeckEditorCardCell:__init()
end


function BattleCardGameDeckEditorCardCell:__delete()
end


function BattleCardGameDeckEditorCardCell:Awake()
    SetButtonAction(self.PokerCardNode, Bind(self, self.OnClickBattleCardNodeHandler_))
end


function BattleCardGameDeckEditorCardCell:Start()
end


function BattleCardGameDeckEditorCardCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameDeckEditorCardCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameDeckEditorCardCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameDeckEditorDialog.CardCellData
function BattleCardGameDeckEditorCardCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameDeckEditorDialog.CardCellData
function BattleCardGameDeckEditorCardCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function BattleCardGameDeckEditorCardCell:GetClickCardCb()
    return self.clickCardCallback_
end
---@param callback fun(luaIndex:integer):void
function BattleCardGameDeckEditorCardCell:SetClickCardCb(callback)
    self.clickCardCallback_ = callback
end


---@return boolean
function BattleCardGameDeckEditorCardCell:IsSelectState()
    return checkBool(self.isSelectState_)
end
---@param isSelect boolean
function BattleCardGameDeckEditorCardCell:SetSelectState(isSelect)
    self.isSelectState_ = checkBool(isSelect)
    self:UpdateSelectState_()
end


-------------------------------------------------
-- private

function BattleCardGameDeckEditorCardCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    local cardId = checkInt(cellData.cardId)
    BattleCardGameUtils.UpcateBattleCardNode(self.PokerCardNode, cardId)
end


function BattleCardGameDeckEditorCardCell:UpdateSelectState_()
    CfUtils.SetActive(self.SelectMaskNode, self:IsSelectState())
end


-------------------------------------------------
-- handler

function BattleCardGameDeckEditorCardCell:OnClickBattleCardNodeHandler_()
    if self:GetClickCardCb() then
        self:GetClickCardCb()(self:GetLuaIndex())
    end
end


return BattleCardGameDeckEditorCardCell
