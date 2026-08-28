-------------------------------------------------------------------------------
-- 和风战牌 - 收集册界面 - 收集列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-23 10:55:12
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local RewardsGridCellPath = 'Game.UI.BattleCardGame.BattleCardGameAlbumBattleCardCell'
local RewardsGridCellName = 'ActivityJapanesePokerCollectNode'

--- from: Assets/BundleResources/Prefabs/FightTeam/ItemPrefab1.prefab > name: ItemPrefab1
---@class BattleCardGameAlbumCollectCell
---@field Env                           	BattleCardGameAlbumCollectCell          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field CollectNumTxt                 	UnityEngine.RectTransform               	@ 1    收集数文本
---@field CollectTitleTxt               	UnityEngine.RectTransform               	@ 2    收集标题文本
---@field RewardNode                    	UnityEngine.RectTransform               	@ 3    奖励节点
---@field RewardIconImg                 	UnityEngine.RectTransform               	@ 4    奖励图标
---@field RewardDrawNode                	UnityEngine.RectTransform               	@ 5    奖励领取节点
---@field RewardDrewNode                	UnityEngine.RectTransform               	@ 6    奖励已领取节点
---@field RewardCollectTxt              	UnityEngine.RectTransform               	@ 7    奖励收集文本
---@field RewardTipsNode                	UnityEngine.RectTransform               	@ 8    奖励提示节点
---@field CardsGridView                 	UnityEngine.RectTransform               	@ 9    卡牌列表容器
---@field CardsGridNode                 	UnityEngine.RectTransform               	@ 10   卡牌列表节点
local BattleCardGameAlbumCollectCell = Class('BattleCardGameAlbumCollectCell')


function BattleCardGameAlbumCollectCell:__init()
    self.isInitialized_ = false
end


function BattleCardGameAlbumCollectCell:__delete()
    self.isInitialized_ = nil
end


function BattleCardGameAlbumCollectCell:Awake()
    SetButtonAction(self.RewardNode, Bind(self, self.OnClickRewardNodeHandler_))
end


function BattleCardGameAlbumCollectCell:Start()
    if next(self:GetCellData()) ~= nil then
        self:UpdateCellInfo_()
    end
    self.isInitialized_ = true
end


function BattleCardGameAlbumCollectCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameAlbumCollectCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameAlbumCollectCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameAlbumDialog.CollectCellData
function BattleCardGameAlbumCollectCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameAlbumDialog.CollectCellData
function BattleCardGameAlbumCollectCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    if self.isInitialized_ then
        self:UpdateCellInfo_()
    end
end


---@return fun(luaIndex:integer, tipsNode:UnityEngine.RectTransform):void
function BattleCardGameAlbumCollectCell:GetClickRewardNodeCB()
    return self.clickRewardNodeCallback_
end
---@param callback fun(luaIndex:integer, tipsNode:UnityEngine.RectTransform):void
function BattleCardGameAlbumCollectCell:SetClickRewardNodeCB(callback)
    self.clickRewardNodeCallback_ = callback
end


---@return fun(luaIndex:integer, cardIndex:integer):void
function BattleCardGameAlbumCollectCell:GetClickBattleCardCB()
    return self.clickBattleCardCallback_
end
---@param callback fun(luaIndex:integer, cardIndex:integer):void
function BattleCardGameAlbumCollectCell:SetClickBattleCardCB(callback)
    self.clickBattleCardCallback_ = callback
end


-------------------------------------------------
-- private

function BattleCardGameAlbumCollectCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type BattleCardGameCollectionVo
    local collectVo = checkTable(cellData.collectVo)

    -- update info
    local collectMax = #checkTable(collectVo.cardList)
    local collectNum = table.count(cellData.collectCardMap)
    CfUtils.FillText(self.CollectNumTxt, string.fmt('%1/%2', collectNum, collectMax))
    CfUtils.FillText(self.CollectTitleTxt, tostring(collectVo.albumName))
    CfUtils.FillImage(self.RewardIconImg, collectVo.iconPath, true)

    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.CardsGridView.transform, self.CardsGridNode, collectMax, function(luaIndex, childNode)
        childNode.name = 'JapanesePokerCollectNode'..luaIndex
        ---@type BattleCardGameAlbumBattleCardCell
        local cellEnv = CfUtils.GetLuaScr(childNode, RewardsGridCellPath)
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(self:GetCellData())
        cellEnv:SetClickBattleCardCB(Bind(self, self.OnClickBattleCardHandler_))
    end)

    -- update status
    local isCollectAll = checkBool(cellData.isCollectAll)
    local isDrewReward = checkBool(cellData.isDrewReward)
    CfUtils.SetActive(self.RewardDrewNode, isDrewReward)
    CfUtils.SetUISwitchImage(self.RewardIconImg, isDrewReward and 2 or 1)

    if isDrewReward then
        CfUtils.SetActive(self.RewardDrawNode, false)
        CfUtils.SetActive(self.RewardCollectTxt, false)
        CfUtils.SetActive(self.RewardDrawRedPoint, false)
    else
        CfUtils.SetActive(self.RewardDrawNode, isCollectAll)
        CfUtils.SetActive(self.RewardCollectTxt, not isCollectAll)
        CfUtils.SetActive(self.RewardDrawRedPoint, isCollectAll)
    end
end


function BattleCardGameAlbumCollectCell:OnClickRewardNodeHandler_()
    if self:GetClickRewardNodeCB() then
        self:GetClickRewardNodeCB()(self:GetLuaIndex(), self.RewardTipsNode)
    end
end


---@param cardSender BattleCardGameAlbumBattleCardCell
function BattleCardGameAlbumCollectCell:OnClickBattleCardHandler_(cardSender)
    if self:GetClickBattleCardCB() then
        self:GetClickBattleCardCB()(self:GetLuaIndex(), cardSender:GetLuaIndex(), cardSender)
    end
end


return BattleCardGameAlbumCollectCell
