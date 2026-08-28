---@class TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = {}
-- 外部访问时
-- ---@type TimeLimitedRecruitUtil
-- local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")


--- lua:
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local SphereCollider = CS.UnityEngine.SphereCollider
local CapsuleCollider = CS.UnityEngine.CapsuleCollider
local KTool = CS.Engine.Lib.KTool
local Physics = CS.UnityEngine.Physics
local LayerMask = CS.UnityEngine.LayerMask

local URPCameraController = CS.Game.Native.URP.URPCameraController
local CinemachineBrain = CS.Cinemachine.CinemachineBrain
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local Camera = CS.UnityEngine.Camera
local Random = CS.UnityEngine.Random

-- ===============================================


TimeLimitedRecruitUtil.DoorState = 
{
    Close = 0,
    Open = 1,
}


TimeLimitedRecruitUtil.CatState = 
{
    Prepare = 1,
    Walk = 2,
    ---
    StartRobotHit = 3,      -- 没得到: 机器人开始播放打飞动作, 但cat还在往前走
    KnockedFlying = 5,      -- 没得到: catNode 被机器人打飞, 正在天上飞
    Hiding = 4,             -- 得到:   catNode 到达门, 开始渐渐隐身
    ---
    Finish = 99,
}



-- =================================== vo =======================================


TimeLimitedRecruitUtil.VoParamsId = 
{
    OneRecruitMinRwardNum = 1,                            -- 单次招募最少可获得奖励品类数量
    OneRecruitTgtRwardNum = 2,                           -- 单次招募需要从奖池中随机出来的奖励数量
    RecruitMultiple = 3,                           -- 多倍招募倍数; 10 表示 意义为10倍消耗，获得本次招募的结果乘10
    FreeRecruitConditions = 4,       -- 免费招募触发条件;  6;6;7;8   在单次招募中获得指定数量的奖励品类，从左至右，每达成一次，下一次招募免费
    IsShowShop = 5,                 -- 是否显示商店; 0,1;
    BigRewardCatName = 6,   --抽取动画用：大奖猫:       cat3
    OthCatNames = 7,        --抽取动画用：其余随机猫:   cat1;cat2
}


-- 限时招募参数表
---@param paramId number @ TimeLimitedRecruitUtil.VoParamsId 
function TimeLimitedRecruitUtil.GetVoParamValue( paramId, type )
    local result
    if type == nil then
        type = Constants.DataType.Int
    end
    local row = CfUtils.GetCfLine(AutoIds.IdSetting6722, paramId) -- 微缩世界活动参数表
    if row then
        result = CfUtils.GetCfDataByLine(row, "num",type)
    else
        printError("限时招募参数表 中没有找到对应的参数id：%s", paramId)
    end
    return result
end



-- 限时招募活动排期表
function TimeLimitedRecruitUtil.GetTimeLimitedRecruitActivityScheduleVO( activityContentId_ )
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6721, "TimeLimitedRecruitActivityScheduleVO", activityContentId_)
    ---
    return vo
end



function TimeLimitedRecruitUtil.GetCardVo( cardId_ ) 
    local roleVo = CfUtils.GetCfVo(AutoIds.IdSetting28, "CardVo", cardId_)
    return roleVo
end 



-- 77同卡粉尘道具表
function TimeLimitedRecruitUtil.GetSameCardDustGoodsVO( cardId_ ) 
    cardId_ = tonumber(cardId_)

    local vos = CfUtils.GetCf(AutoIds.IdSetting6725, "SameCardDustGoodsVO", true)
    local rets = {}
    for k,vo in pairs(vos) do 
        if isNotNull(vo) and checkInt(vo.cardId) == cardId_ then 
            table.insert( rets, vo )
        end
    end
    ---
    local voNum = #rets
    if voNum == 0 then 
        printError("表中没找到, cardId_ = " .. tostring(cardId_))
        return nil
    elseif voNum > 1 then 
        printError("表中找到多行匹配的, cardId_ = " .. tostring(cardId_))
    end 
    return rets[1]
end 





return TimeLimitedRecruitUtil

