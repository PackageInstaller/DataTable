-------------------------------------------------------------------------------
-- 活动内页 - 夜间巡逻
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-20 12:03:45
-------------------------------------------------------------------------------

local ActivityUtils   = import('Game.Activity.ActivityUtils')
local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')

--- from: Assets/BundleResources/Prefabs/Activity/PatrolEntryDialog130201.prefab > name: PatrolEntryDialog130201
---@class ActivityPatrolMazeNode
---@field Env                           	ActivityPatrolMazeNode                  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnEntry                      	UnityEngine.RectTransform               @ 进入按钮
---@field SkeletonRole                  	UnityEngine.RectTransform               @ 角色spine
---@field TimeText                      	UnityEngine.RectTransform               @ 时间文本
---@field DescrText                     	UnityEngine.UI.Text                     @ 描述文本
local ActivityPatrolMazeNode = Class('ActivityPatrolMazeNode')


function ActivityPatrolMazeNode:__init()
end


function ActivityPatrolMazeNode:__delete()
end


function ActivityPatrolMazeNode:Awake()
    SetButtonAction(self.BtnEntry, Bind(self, self.OnClickEntryButtonHandler_))
end


function ActivityPatrolMazeNode:Start()
end


function ActivityPatrolMazeNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return ActivityDojo
function ActivityPatrolMazeNode:GetActivityDojo()
    return self.activityDojo_
end
function ActivityPatrolMazeNode:SetActivityDojo(activityDojo)
    self.activityDojo_ = checkTable(activityDojo)
    self:UpdateActivityNode_()
end


-------------------------------------------------
-- public

---@param activityDojo ActivityDojo
function ActivityPatrolMazeNode:Refresh(activityDojo)
    self:SetActivityDojo(activityDojo)
end


-------------------------------------------------
-- private

function ActivityPatrolMazeNode:UpdateActivityNode_()
    local activityDojo = self:GetActivityDojo()
    CfUtils.FillText(self.TimeText, ActivityUtils.ConventActivityDojoDurationTime(activityDojo))
    CfUtils.FillText(self.DescrText, activityDojo.detail)
end


-------------------------------------------------
-- handler

function ActivityPatrolMazeNode:OnClickEntryButtonHandler_()
    -- check unlock
    local unlockData = checkTable(self:GetActivityDojo().unlock)[1]
    local isUnlock, errMsg = GameUtils.CheckUnlockedSingle(unlockData)
    if not isUnlock then
        GameUtils.Toast(errMsg)
        return
    end
    
    -- goto main dialog
    PatrolMazeUtils.GotoMainDialog({activityDojo = self:GetActivityDojo()})
end


return ActivityPatrolMazeNode
