-------------------------------------------------------------------------------
-- 和风战牌 - 收集册界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 19:51:14
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local CollectListCellPath = 'Game.UI.BattleCardGame.BattleCardGameAlbumCollectCell'
local CollectListCellName = 'ItemPrefab1'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerCollectDialog.prefab > name: ActivityJapanesePokerCollectDialog
---@class BattleCardGameAlbumDialog
---@field Env                           	BattleCardGameAlbumDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BgNode                        	UnityEngine.RectTransform               	@ 1    背景节点
---@field CollectNumTxt                 	UnityEngine.RectTransform               	@ 2    收集数量文本
---@field CollectLoopView               	SuperScrollView.LoopListView2           	@ 3    收集列表
local BattleCardGameAlbumDialog = Class('BattleCardGameAlbumDialog')


function BattleCardGameAlbumDialog:__init()
    ---@type BattleCardGameAlbumDialog.CollectCellData[]
    self.collectDataList_ = {}
end


function BattleCardGameAlbumDialog:__delete()
    self.collectDataList_ = nil
end


function BattleCardGameAlbumDialog:Awake()
    SetListViewAction(self.CollectLoopView, Bind(self, self.OnUpdateCollectListCellHandler_), CollectListCellName)
end


function BattleCardGameAlbumDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        self:InitCollectListData_()
        self:UpdateCollectNum_()
        self:UpdateCollectList_()
    end)
end


function BattleCardGameAlbumDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return BattleCardGameAlbumDialog.CollectCellData[]
function BattleCardGameAlbumDialog:GetCollectDataList()
    return checkTable(self.collectDataList_)
end


-------------------------------------------------
-- private

function BattleCardGameAlbumDialog:InitCollectListData_()
    self.collectDataList_ = {}

    local homeDojo = battleCardGameComp:GetHomeDojo()
    for collectIndex, collectVo in ipairs(BattleCardGameUtils.GetAllCollectionVo()) do
        ---@class BattleCardGameAlbumDialog.CollectCellData
        ---@field collectIndex integer
        ---@field collectId integer
        ---@field collectVo BattleCardGameCollectionVo
        ---@field collectCardMap table<integer, boolean> @ 每张卡的收集状态map
        ---@field isCollectAll boolean @ 是否收集全部
        ---@field isDrewReward boolean @ 是否已领取
        local collectData = {
            collectIndex   = collectIndex,
            collectId      = collectVo.collectId,
            collectVo      = collectVo,
            collectCardMap = {},
            isCollectAll   = true,
            isDrewReward   = homeDojo:HasDrawCollect(collectVo.collectId),
        }
        for cardIndex, battleCardId in ipairs(checkTable(collectVo.cardList)) do
            if homeDojo:HasCardId(battleCardId) then
                collectData.collectCardMap[battleCardId] = true
            else
                collectData.isCollectAll = false
            end
        end
        self.collectDataList_[collectIndex] = collectData
    end
end


function BattleCardGameAlbumDialog:UpdateCollectNum_()
    local collectNow = 0
    local collectMax = #self:GetCollectDataList()
    for _, collectData in ipairs(self:GetCollectDataList()) do
        if collectData.isDrewReward then
            collectNow = collectNow + 1
        end
    end
    CfUtils.FillText(self.CollectNumTxt, localize('总收集进度：_num1_/_num2_', {_num1_ = collectNow, _num2_ = collectMax}))
end


function BattleCardGameAlbumDialog:UpdateCollectList_()
    ---@param aCollectData BattleCardGameAlbumDialog.CollectCellData
    ---@param bCollectData BattleCardGameAlbumDialog.CollectCellData
    table.sort(self:GetCollectDataList(), function(aCollectData, bCollectData)
        local aPriority = 0
        local bPriority = 0
        aPriority = aPriority + (not aCollectData.isDrewReward and 100 or 0)
        bPriority = bPriority + (not bCollectData.isDrewReward and 100 or 0)
        aPriority = aPriority + (aCollectData.isCollectAll and 10 or 0)
        bPriority = bPriority + (bCollectData.isCollectAll and 10 or 0)
        aPriority = aPriority + (aCollectData.collectId < bCollectData.collectId and 1 or 0)
        bPriority = bPriority + (bCollectData.collectId < aCollectData.collectId and 1 or 0)
        return aPriority > bPriority
    end)

    local listDataLength = #self:GetCollectDataList()
    GameUtils.ReloadData(self.CollectLoopView, listDataLength)
end


-------------------------------------------------
-- handler

---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function BattleCardGameAlbumDialog:OnUpdateCollectListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(CollectListCellName)
    local cellData = self:GetCollectDataList()[luaIndex]
    ---@type BattleCardGameAlbumCollectCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, CollectListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickRewardNodeCB(Bind(self, self.OnClickCollectRewardNodeCallback_))
        cellEnv:SetClickBattleCardCB(Bind(self, self.OnClickBattleCardNodeCallback_))
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
---@param tipsNode UnityEngine.RectTransform
function BattleCardGameAlbumDialog:OnClickCollectRewardNodeCallback_(luaIndex, tipsNode)
    local cellData = self:GetCollectDataList()[luaIndex]

    ---@type BattleCardGameCollectionVo
    local collectVo = checkTable(cellData.collectVo)
    
    local isCollectAll = checkBool(cellData.isCollectAll)
    local isDrewReward = checkBool(cellData.isDrewReward)
    local drawStatus   = isCollectAll and Constants.GetStatus.Can or Constants.GetStatus.Not
    if isDrewReward then
        drawStatus = Constants.GetStatus.Has
    end

    if drawStatus == Constants.GetStatus.Has then
        GameUtils.Toast(localize('奖励已领取'))

    elseif drawStatus == Constants.GetStatus.Can then
        battleCardGameComp:DrawCollection(collectVo.collectId, function()
            -- update cell data
            cellData.isDrewReward = true

            -- update collect num
            self:UpdateCollectNum_()

            -- update cell view
            -- local cellNode = self.CollectLoopView:GetShownItemByItemIndex(luaIndex - 1)
            -- ---@type BattleCardGameAlbumCollectCell
            -- local cellEnv = CfUtils.GetLuaScr(cellNode, CollectListCellPath)
            -- if isNotNull(cellEnv) then
            --     cellEnv:SetCellData(cellData)
            -- end
            self:UpdateCollectList_()
        end)

    elseif drawStatus == Constants.GetStatus.Not then
        GameUtils.ShowCommonTipsBoardRewardPreview(tipsNode, collectVo.rewards, localize('奖励预览:'), false, true)
    end
end


---@param luaIndex integer
---@param cardIndex integer
---@param cardSender BattleCardGameAlbumBattleCardCell
function BattleCardGameAlbumDialog:OnClickBattleCardNodeCallback_(luaIndex, cardIndex, cardSender)
    local cellData = self:GetCollectDataList()[luaIndex]

    ---@type BattleCardGameCollectionVo
    local collectVo = checkTable(cellData.collectVo)

    local battleCardId = checkInt(checkTable(collectVo.cardList)[cardIndex])
    GameUtils.ShowResultTips(cardSender.controller.transform, battleCardId)
end


return BattleCardGameAlbumDialog
