-------------------------------------------------------------------------------
-- 任务界面
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-08-31 10:30:11
-------------------------------------------------------------------------------

 
---@class UITaskUtils         
local UITaskUtils = {}
-- 外部调用:
-- ---@type UITaskUtils
-- local UITaskUtils = import('Game.UI.Tasks.UITaskUtils')


-- 当从 任务界面 跳转到别的界面, 需要记录下 离开时的 任务页签, 以便重回 任务界面 时可以再次指向它
UITaskUtils.TaskTypeIndexFromOutside = 
{
    None = 0,           -- 外部不想指向任何 任务页签

    -- !!! 旧版 idx:
    -- Daily = 1,
    -- GrowUp = 2,
    -- Investigation = 3,
    -- Achievement = 4,

    Daily = 1,
    --GrowUp = 2,           -- !!! 成长任务暂时不上, 后面的 idx 都要前移
    Investigation = 2,
    Achievement = 3,
}




-- 遍历得到每个区域 的红点信息 
function UITaskUtils.RefreshRedPointsInRegions()

    local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')

    
    do -- debug:
        ---@type RedPointMgrComponent
        local redPointCom = GameUtils.GetEntityCompByType(ECSComponentType.Constants.RedPointMgrComponent)
        local oldRedPoint = redPointCom:GetNodeNum(Constants.RedPointConst.InvestigationTask)
        --print("koko - 调查任务 - 旧小红点 - " .. (checkInt(oldRedPoint) > 0 and "true" or "false") )
    end

    ---

    local isNeedRedPoint = false 
    local redPoints = {}
    local regionPrimaryMapsVo = ActionUtils.GetAllRegionPrimaryMapVo()
    for k,v in pairs(regionPrimaryMapsVo) do 
        if isNotNull(v) then 

            local isHasTaskCanDraw = ActionUtils.IsHasTaskCanDraw(v.id)
            local isShowMapRedpoint = ActionUtils.IsShowMapRedpoint(v.id)
            --print("koko - id:" .. tostring(v.id) .. ", IsHasTaskCanDraw: " .. tostring(isHasTaskCanDraw) .. ", IsShowMapRedpoint: " .. tostring(isShowMapRedpoint)  )

            local isShowRedPoint = isHasTaskCanDraw -- 暂时无视 isShowMapRedpoint 数据
            table.insert( redPoints, isShowRedPoint )
            if isShowRedPoint == true then 
                isNeedRedPoint = true
            end
        else 
            printError("koko - 配表中存在 空的 行数据, 异常")
        end 
    end

    --print("koko - 调查任务 - 新红点: " .. tostring(isNeedRedPoint) )
    -- 立刻更新成就红点值
    GameUtils.SetRedPointNum(Constants.RedPointConst.InvestigationTask,  isNeedRedPoint and 1 or 0 )
    return redPoints
end



return UITaskUtils
