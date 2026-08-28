-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 排名奖励列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-24 14:35:48
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRewardPreviewPopup122501.prefab
---@class ActivityRotaryTableRankRewardCell
---@field Env                           	ActivityRotaryTableRankRewardCell    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonGoodsList               	UnityEngine.RectTransform               @ 道具节点
---@field TextDecorate                  	UnityEngine.RectTransform               
---@field ImgDecorate                   	UnityEngine.RectTransform               
---@field ImgBg3                        	UnityEngine.RectTransform               
---@field ImgBg2                        	UnityEngine.RectTransform               
---@field AnimRoot                      	UnityEngine.RectTransform               
---@field ImgBg                         	UnityEngine.RectTransform               
---@field TxtRanking                    	UnityEngine.RectTransform               @ 名次文本框
---@field Item                          	UnityEngine.RectTransform               
local ActivityRotaryTableRankRewardCell = Class('ActivityRotaryTableRankRewardCell')


function ActivityRotaryTableRankRewardCell:__init()
    ---@type CommonGoodsList
    self.goodsListEnv_ = nil
end


function ActivityRotaryTableRankRewardCell:__delete()
    self.goodsListEnv_ = nil
end


function ActivityRotaryTableRankRewardCell:Awake()
    self.goodsListEnv_ = CfUtils.GetLuaScr(self.CommonGoodsList, 'Game.Behaviours.CommonGoodsList')
end


function ActivityRotaryTableRankRewardCell:Start()
end


function ActivityRotaryTableRankRewardCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function ActivityRotaryTableRankRewardCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function ActivityRotaryTableRankRewardCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ActivityRotaryTableRankingRewardVo
function ActivityRotaryTableRankRewardCell:GetCellData()
    return checkTable(self.cellData_)
end
function ActivityRotaryTableRankRewardCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


-------------------------------------------------
-- private

function ActivityRotaryTableRankRewardCell:RefreshData_()
    local cellData = self:GetCellData()
    ---@type ActivityRotaryTableRankingRewardVo
    local rewardVo  = cellData

    -- update score
    -- local upperLimit = checkInt(rewardVo.upperLimit)
    -- local lowerLimit = checkInt(rewardVo.lowerLimit)
    -- CfUtils.FillText(self.TxtRanking, string.format('%d - %d', upperLimit, lowerLimit))
    CfUtils.FillText(self.TxtRanking, tostring(rewardVo.name))
    
    -- update rewards
    local rewardList = checkTable(rewardVo.rewards)
    if not isNull(self.goodsListEnv_) and #rewardList > 0 then
        self.goodsListEnv_:FreshBaseUI(rewardList)
    end
end


return ActivityRotaryTableRankRewardCell
