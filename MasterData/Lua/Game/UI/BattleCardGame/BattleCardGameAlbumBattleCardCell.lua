-------------------------------------------------------------------------------
-- 和风战牌 - 收集册界面 - 收集卡牌节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-23 15:50:37
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerCollectNode.prefab > name: ActivityJapanesePokerCollectNode
---@class BattleCardGameAlbumBattleCardCell
---@field Env                           	BattleCardGameAlbumBattleCardCell       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field PokerCardNode                 	UnityEngine.RectTransform               	@ 1    卡牌节点
local BattleCardGameAlbumBattleCardCell = Class('BattleCardGameAlbumBattleCardCell')


function BattleCardGameAlbumBattleCardCell:__init()
end


function BattleCardGameAlbumBattleCardCell:__delete()
end


function BattleCardGameAlbumBattleCardCell:Awake()
    SetButtonAction(self.PokerCardNode, Bind(self, self.OnClickBattleCardNodeHandler_))
end


function BattleCardGameAlbumBattleCardCell:Start()
end


function BattleCardGameAlbumBattleCardCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameAlbumBattleCardCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameAlbumBattleCardCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameAlbumDialog.CollectCellData
function BattleCardGameAlbumBattleCardCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameAlbumDialog.CollectCellData
function BattleCardGameAlbumBattleCardCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(sender:BattleCardGameAlbumBattleCardCell):void
function BattleCardGameAlbumBattleCardCell:GetClickBattleCardCB()
    return self.clickBattleCardCallback_
end
---@param callback fun(sender:BattleCardGameAlbumBattleCardCell):void
function BattleCardGameAlbumBattleCardCell:SetClickBattleCardCB(callback)
    self.clickBattleCardCallback_ = callback
end


-------------------------------------------------
-- private

function BattleCardGameAlbumBattleCardCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type BattleCardGameCollectionVo
    local collectVo = checkTable(cellData.collectVo)

    -- update info
    local battleCardId = checkInt(checkTable(collectVo.cardList)[self:GetLuaIndex()])
    local isCollected  = checkBool(cellData.collectCardMap[battleCardId])
    BattleCardGameUtils.UpcateBattleCardNode(self.PokerCardNode, battleCardId)

    -- update status
    CfUtils.MarkGray(self.PokerCardNode, not isCollected)
end


function BattleCardGameAlbumBattleCardCell:OnClickBattleCardNodeHandler_()
    if self:GetClickBattleCardCB() then
        self:GetClickBattleCardCB()(self)
    end
end


return BattleCardGameAlbumBattleCardCell
