--[[
-----------------------------------------------------
@filename       : StepReportController
@Description    : 步骤打点
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("stepReport.StepReportController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 请求引导步骤打点
    GameDispatcher:addEventListener(EventName.REQ_GUIDE_REPORT, self.onReqGuideReportHandler, self)
    -- 请求游戏步骤打点
    GameDispatcher:addEventListener(EventName.REQ_GAME_REPORT, self.onReqGameReportHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* steam成就面板数据 24276
        SC_PLATFORM_ACHIEVE_PANEL = self.onPlatformAchievementListHandler,
        --- *s2c* steam成就更新 24277
        SC_PLATFORM_ACHIEVE_UPDATE = self.onPlatformAchievementUpdateHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
--- *s2c* steam成就面板数据 24276
function onPlatformAchievementListHandler(self, msg)
    stepReport.StepReportManager:parsePlatformAchievementIdList(msg.achieve_list)
end

--- *s2c* steam成就更新 24277
function onPlatformAchievementUpdateHandler(self, msg)
    stepReport.StepReportManager:updatePlatformAchievementIdList(msg.achieve_id)
end

---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 请求引导打点记录 12065
function onReqGuideReportHandler(self, args)
    local guideReportVo = stepReport.StepReportManager:getGuideReportVo(args.guidId, args.stepId)
    if(guideReportVo)then
        local skipSign = args.isSkip == true and 1 or 0
        SOCKET_SEND(Protocol.CS_GUIDE_STEP_LOG, {guide_id = args.guidId, step_id = args.stepId})

        if(guideReportVo.eventName ~= "")then
            sdk.SdkManager:notifyGuideStpeSuc(guideReportVo.eventName)
        end
    end
end

--*c2s* 请求游戏打点记录 12068
function onReqGameReportHandler(self, args)
    SOCKET_SEND(Protocol.CS_NORMAL_LOG, {key = args.key, value = tostring(args.value or "")})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
