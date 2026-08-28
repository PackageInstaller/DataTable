-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 转盘节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 12:03:00
-------------------------------------------------------------------------------

local CELL_NAME_PREFIX  = 'SpringFestivalTurntableRewardCell'
local ROTATION_ONE_NAME = 'AnniversaryTurntableDialog122501_Reward_Rotation_One'
local ROTATION_TEN_NAME = 'AnniversaryTurntableDialog122501_Reward_Rotation_Ten'

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableDialog122501.prefab
---@class ActivityRotaryTableGroupNode
---@field Env                           	ActivityRotaryTableGroupNode         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Light_Rotation                	UnityEngine.RectTransform               
---@field SpringFestivalTurntableRewardCell8	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell7	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell6	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell5	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell4	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell3	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell2	UnityEngine.RectTransform
---@field SpringFestivalTurntableRewardCell1	UnityEngine.RectTransform
---@field LockNode                      	UnityEngine.RectTransform
---@field GetNode                       	UnityEngine.RectTransform
---@field ImgExpressionUse              	UnityEngine.RectTransform
---@field ImgExpressionNormal           	UnityEngine.RectTransform
---@field CenterGroup                   	UnityEngine.RectTransform
---@field RewardGroup                   	UnityEngine.RectTransform
local ActivityRotaryTableGroupNode = Class("ActivityRotaryTableGroupNode")


function ActivityRotaryTableGroupNode:__init()
    ---@type table<integer, ActivityRotaryTableRewardCell>
    self._rewardCellEnvMap = {}
end


function ActivityRotaryTableGroupNode:__delete()
    self._rewardCellEnvMap = nil
end


function ActivityRotaryTableGroupNode:Awake()
end


function ActivityRotaryTableGroupNode:Start()
end


function ActivityRotaryTableGroupNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

--- 是否显示 已获得的提示节点
---@param isActive boolean
function ActivityRotaryTableGroupNode:SetGetNodeActive(isActive)
    CfUtils.SetActive(self.GetNode, isActive)
end


--- 是否显示 待解锁的提示节点
---@param isActive boolean
function ActivityRotaryTableGroupNode:SetLockNodeActive(isActive)
    CfUtils.SetActive(self.LockNode, isActive)
end


--- 奖励组的节点
---@return UnityEngine.RectTransform
function ActivityRotaryTableGroupNode:GetCirCle()
    return self.RewardGroup
end


--- 转盘中心节点
---@return UnityEngine.RectTransform
function ActivityRotaryTableGroupNode:GetPointer()
    return self.CenterGroup
end


---@return table<integer, ActivityRotaryTableRewardCell>
function ActivityRotaryTableGroupNode:GetRewardCellMap()
    return self._rewardCellEnvMap
end


-------------------------------------------------
-- public

---@param turntableId integer
function ActivityRotaryTableGroupNode:UpdateTableGroup(turntableId)
    self._rewardCellEnvMap = {}
    ---@param tableRewardVo ActivityRotaryTableRewardVo
    for _, tableRewardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting3098, "ActivityRotaryTableRewardVo")) do
        if tableRewardVo.pools == turntableId then
            local rewardCellNode = self[CELL_NAME_PREFIX .. tableRewardVo.seat]
            ---@type ActivityRotaryTableRewardCell
            local rewardCellEnv = CfUtils.GetLuaScr(rewardCellNode, "Game.Activity.RotaryTable.ActivityRotaryTableRewardCell")
            rewardCellEnv:UpdateRewardInfo(tableRewardVo)
            self._rewardCellEnvMap[tableRewardVo.seat] = rewardCellEnv
        end
    end
end


---@return number
function ActivityRotaryTableGroupNode:PlayRotationOneAnim()
    CfUtils.PlayAnimation(self.Light_Rotation, ROTATION_ONE_NAME)
    return CfUtils.GetAnimationTime(self.Light_Rotation, ROTATION_ONE_NAME)
end


---@return number
function ActivityRotaryTableGroupNode:PlayRotationTenAnim()
    CfUtils.PlayAnimation(self.Light_Rotation, ROTATION_TEN_NAME)
    return CfUtils.GetAnimationTime(self.Light_Rotation, ROTATION_TEN_NAME)
end


return ActivityRotaryTableGroupNode
