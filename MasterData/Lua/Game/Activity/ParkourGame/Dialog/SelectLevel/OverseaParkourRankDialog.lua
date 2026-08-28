

-- 跑酷选关 排行榜

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()



--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineRankingDialog12001801.prefab > name: OverseaParkourMainlineRankingDialog12001801
---@class OverseaParkourRankDialog
---@field Env                           	OverseaParkourRankDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LoopView                      	SuperScrollView.LoopListView2           	@ 0    排行榜列表
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 1    
---@field LayoutListAndMyselef          	UnityEngine.RectTransform               	@ 2    排行榜列表 + 我的排名
---@field MyRanking                     	UnityEngine.RectTransform               	@ 3    我的排名
---@field RewardPreviewButton           	UnityEngine.RectTransform               	@ 4    
local OverseaParkourRankDialog = Class("OverseaParkourRankDialog")

function OverseaParkourRankDialog:__init()
    self.data = {
        rank = {},
        playerRank = {
            score = 999,
            ranking = 99,
        },
        totalNum = 0,
    }
end


function OverseaParkourRankDialog:__delete()
end



function OverseaParkourRankDialog:Awake()
    SetButtonAction(self.RewardPreviewButton, Bind(self, self.ShowRewardPreviewWindow))
    ---
    self.Fuzzy = self.controller.gameObject.transform:Find("Fuzzy")
    SetButtonAction(self.Fuzzy, Bind(self, self._OnCloseHandler)) 
end




function OverseaParkourRankDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.data = {
            rank = Mgr.homeDojo.rank,
            playerRank = Mgr.homeDojo.playerRank,
            totalNum = Mgr.homeDojo.totalNum,
        }

        if next(self.data.rank) == nil then
            -- 没数据时:
            CfUtils.SetActive(self.LayoutListAndMyselef, false)
            CfUtils.SetActive(self.EmptyNode, true)
        else
            CfUtils.SetActive(self.LayoutListAndMyselef, true)
            CfUtils.SetActive(self.EmptyNode, false)

            self:RefreshLoopList()
            self:FillPlayerInfo() -- !! tmp
        end
    end))

    return coWait
end


function OverseaParkourRankDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end


function OverseaParkourRankDialog:OnFocus()   
end



-- ============================================================

function OverseaParkourRankDialog:RefreshLoopList()
    if not self.LoopView.IsListViewInit then
        self.LoopView:InitListView(#self.data.rank, Bind(self, self.OnRefreshListIndex))
    else
        GameUtils.ReloadData(self.LoopView, #self.data.rank)
    end
end



function OverseaParkourRankDialog:OnRefreshListIndex(listView, index0based_)
    if index0based_ < 0 then
        return nil
    end
    local index1based = index0based_ + 1

    local cell = listView:NewListViewItem("Cell")
    local scr = CfUtils.GetLuaScr(cell, "Game.Activity.ParkourGame.Dialog.SelectLevel.OverseaParkourRankNode" )
    if scr then
        scr:Refresh({
            index = index0based_, 
            rankData = self.data.rank[index1based],
            totalNum = self.data.totalNum
        })
    else
        printError("没找到 lua 脚本")
    end
    return cell
end


function OverseaParkourRankDialog:FillPlayerInfo()
    local scr = CfUtils.GetLuaScr(self.MyRanking, "Game.Activity.ParkourGame.Dialog.SelectLevel.OverseaParkourRankNode" )

    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    -- 手动拼数据:
    local data = {
        rankData = {
            playerId    = playerDojo.playerId,
            score       = checkInt(self.data.playerRank.score),
            name        = playerDojo.playerName,
            avatar      = playerDojo.playerAvatar,
            avatarFrame = playerDojo.playerAvatarFrame,
            level       = checkInt(playerDojo.level),
            ranking     = checkInt(self.data.playerRank.ranking),
        },
        totalNum = self.data.totalNum
    }

    if scr then
        scr:Refresh(data)
    end
end


function OverseaParkourRankDialog:ShowRewardPreviewWindow()
    UIModule.OpenDialog({
        id = Constants.UITypeIds.ParkourRankRewardDialog
    })
end
 


function OverseaParkourRankDialog:_OnCloseHandler()
    UIModule.CloseDialog(self.controller)
end


return OverseaParkourRankDialog
