--
-- Author:pikaqiu
-- Date: 2023-03-29 15:55:21
--

local cs_coroutine = import('XLua.cs_coroutine')
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local Yielders = CS.Engine.Lib.Yielders

local QuickBattleViewMgr = Class("QuickBattleViewMgr")

function QuickBattleViewMgr:CleanProperties()
end

function QuickBattleViewMgr:Init()
end

function QuickBattleViewMgr:Clear()
    
end

function QuickBattleViewMgr:ShowRecordData(recordData)
    -- 深度优先遍历
    local copy = recordData
    local queue = {}
    for i = #copy, 1, -1 do
        table.insert(queue, copy[i])
    end
    while #queue > 0 do
        local record = table.remove(queue)

        if record.r == Constants.RecordType.Skill then
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
        elseif record.r == Constants.RecordType.RoleRemove then
            Events.Broadcast(Constants.EventNames.UIQuickBattleRoleDead, record.id)
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
        end

        if not isNull(record.subs) then
            for i = #record.subs, 1, -1 do
                table.insert(queue, record.subs[i])
            end
        end
    end
end

return QuickBattleViewMgr