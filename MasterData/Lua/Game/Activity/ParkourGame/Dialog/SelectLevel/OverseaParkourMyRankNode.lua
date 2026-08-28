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


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineRankingDialog12001801.prefab > name: MyRanking
---@class OverseaParkourMyRankNode
---@field Env                           	OverseaParkourMyRankNode                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextNoReward                  	UnityEngine.RectTransform               	@ 0    
---@field CommonGoodsList               	UnityEngine.RectTransform               	@ 1    
---@field TextLevel                     	UnityEngine.RectTransform               	@ 2    
---@field ImgRank                       	UnityEngine.RectTransform               	@ 3    
---@field Txtranking                    	UnityEngine.RectTransform               	@ 4    
---@field TextNumber                    	UnityEngine.RectTransform               	@ 5    
---@field TxtName                       	UnityEngine.RectTransform               	@ 6    
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 7    
---@field NotEnterNode                  	UnityEngine.RectTransform               	@ 8    
---@field TxtNo                         	UnityEngine.RectTransform               	@ 9    
---@field ItileRank                     	UnityEngine.RectTransform               	@ 10   
local OverseaParkourMyRankNode = Class("OverseaParkourMyRankNode")

function OverseaParkourMyRankNode:__init()
    
end

function OverseaParkourMyRankNode:__delete()
    
end

function OverseaParkourMyRankNode:Awake()

end

function OverseaParkourMyRankNode:Refresh(data)
    self.index = data.index
    ---@type ActivityCooking.RankData
    self.data = data.input

    self:FillSelf()
end

function OverseaParkourMyRankNode:FillSelf()
    local avatarScr = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, "Game.Behaviours.CommonPlayerHeadNode")
    if avatarScr then
        avatarScr:FreshAvatarFrame(self.data.avatar, self.data.avatarFrame)
    end

    CfUtils.FillText(self.TxtName, self.data.name)
    CfUtils.FillText(self.TextLevel, "LV." .. tostring(self.data.level))
    CfUtils.FillText(self.TextNumber, self.data.score)
    local status = self.data.ranking > 4 and 4 or self.data.ranking
    CfUtils.SetUISwitchImage(self.ImgRank, status)
    CfUtils.SetUISwitchImage(self.ImgRank2, status)

    CfUtils.SetActive(self.ImgRank, self.data.ranking > 0)
    CfUtils.SetActive(self.Txtranking, self.data.ranking > 0)
    CfUtils.SetActive(self.TxtNo, self.data.ranking == 0)

    local totalRankNum = math.max(100, checkInt(ActivityCookingComponent.dojo.totalRankNum))
    local currentRankPercent = math.ceil(self.data.ranking / totalRankNum * 100)
    if self.data.ranking == 0 then
        currentRankPercent = math.maxinteger
    end

    for _, vo in pairs(ActivityCookingUtils.GetCookingRankVos(ActivityCookingComponent.dojo.config.id)) do
        if (vo.type == 1 and self.data.ranking <= vo.lowerLimit) or (vo.type == 2 and currentRankPercent <= vo.lowerLimit) then
            local reward = {}

            for i, id in ipairs(vo.reward) do
                table.insert(reward, {goodsId = id,num = vo.rewardNum[i]})
            end 

            CfUtils.RefreshCommonGoodsListLight(
                self.CommonGoodsList, reward, false, false, true, false, true
            )

            if self.data.ranking <= 100 then
                CfUtils.FillText(self.Txtranking, self.data.ranking)
            else
                CfUtils.FillText(self.Txtranking, tostring(currentRankPercent) .. "%" )
            end
            break
        end
    end
end

function OverseaParkourMyRankNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

return OverseaParkourMyRankNode
