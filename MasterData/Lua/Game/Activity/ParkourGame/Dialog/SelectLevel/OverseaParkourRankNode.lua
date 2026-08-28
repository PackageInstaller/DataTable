---
--- Author: zou hanjie
--- Date: 2024-8-06 10:39:27
---

-- 跑酷 选关排行榜 单元节点

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineRankingDialog12001801.prefab > name: Cell
---@class OverseaParkourRankNode
---@field Env                           	OverseaParkourRankNode                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AniRoot                       	UnityEngine.RectTransform               	@ 0    
---@field TextNoReward                  	UnityEngine.RectTransform               	@ 1    
---@field ImgMyself                     	UnityEngine.RectTransform               	@ 2    
---@field CommonGoodsList               	UnityEngine.RectTransform               	@ 3    
---@field TextLevel                     	UnityEngine.RectTransform               	@ 4    
---@field ImgRank2                      	UnityEngine.RectTransform               	@ 5    
---@field ImgRank                       	UnityEngine.RectTransform               	@ 6    
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 7    
---@field Imgbg                         	UnityEngine.RectTransform               	@ 8    
---@field TxtName                       	UnityEngine.RectTransform               	@ 9    
---@field Txtranking                    	UnityEngine.RectTransform               	@ 10   排名数字
---@field TextNumber                    	UnityEngine.RectTransform               	@ 11   
local OverseaParkourRankNode = Class("OverseaParkourRankNode")

function OverseaParkourRankNode:__init()
    
end

function OverseaParkourRankNode:__delete()
    
end

function OverseaParkourRankNode:Awake()

end

function OverseaParkourRankNode:Refresh(params_)

    self.index = params_.index
    ---@type ActivityCooking.RankData
    self.rankData = params_.rankData
    self.totalNum = params_.totalNum

    self:FillSelf()

end


function OverseaParkourRankNode:FillSelf()
    local avatarScr = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, "Game.Behaviours.CommonPlayerHeadNode")
    if avatarScr then
        avatarScr:FreshAvatarFrame(self.rankData.avatar, self.rankData.avatarFrame)
    end

    CfUtils.FillText(self.TxtName, self.rankData.name)
    CfUtils.FillText(self.TextLevel, "LV." .. tostring(self.rankData.level))
    CfUtils.FillText(self.TextNumber, self.rankData.score)
    local status = self.rankData.ranking > 4 and 4 or self.rankData.ranking
    CfUtils.SetUISwitchImage(self.ImgRank, status)
    CfUtils.SetUISwitchImage(self.ImgRank2, status)

    CfUtils.SetActive(self.ImgRank, self.rankData.ranking > 0)
    CfUtils.SetActive(self.Txtranking, self.rankData.ranking > 0)
    CfUtils.SetActive(self.TxtNo, self.rankData.ranking == 0)

    local totalNum = checkInt(self.totalNum)
    print("排行榜总人数: " ..tostring(totalNum))

    local currentRankPercent = math.ceil(self.rankData.ranking / totalNum * 100)
    if self.rankData.ranking == 0 then
        currentRankPercent = math.maxinteger
    end

    if self.rankData.ranking <= 100 then
        CfUtils.FillText(self.Txtranking, self.rankData.ranking)
    else
        CfUtils.FillText(self.Txtranking, tostring(currentRankPercent) .. "%" )
    end

    local rankRewaordVoss = CfUtils.GetCf(AutoIds.IdSetting6461, "MiniWorldFreeExploreRankRewaordVo", true)
    --printError("currentRankPercent = " ..tostring(currentRankPercent))

    for i=1, #rankRewaordVoss do
        local vo = rankRewaordVoss[i]
        
        if isNotNull(vo) then 
            if  (vo.type == 1 and self.rankData.ranking <= vo.lowerLimit) or    -- 按排名
                (vo.type == 2 and currentRankPercent <= vo.lowerLimit)          -- 按百分比
            then
                --printError( "vo type = "..tostring(vo.type) .. ", lowerLimit="..tostring(vo.lowerLimit) )

                local reward = {}

                for i, id in ipairs(vo.reward) do
                    table.insert(reward, {goodsId = id,num = vo.rewardNum[i]})
                end 

                CfUtils.RefreshCommonGoodsListLight(
                    self.CommonGoodsList, reward, false, false, true, false, 
                    false -- 程菲: 不要显示跳转连接, 否则会导致 ui 跳转效果的小问题
                )

                break
            end
        end
    end 


end


function OverseaParkourRankNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end


return OverseaParkourRankNode
