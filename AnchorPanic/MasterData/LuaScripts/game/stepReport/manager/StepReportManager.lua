--[[
-----------------------------------------------------
@filename       : GuideReportManager
@Description    : 引导打点
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("stepReport.GuideReportManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mPlatformAchievementIdList = nil
    self.mGuideReportConfig = nil
end

-- 析构函数
function dtor(self)
end

--- *s2c* steam成就面板数据 24276
function parsePlatformAchievementIdList(self, achievementIdList)
    self.mPlatformAchievementIdList = achievementIdList or {}
    for i = 1, #self.mPlatformAchievementIdList do
        sdk.SdkManager:reachAchievement(self.mPlatformAchievementIdList[i])
    end
end

--- *s2c* steam成就更新 24277
function updatePlatformAchievementIdList(self, achievementId)
    self.mPlatformAchievementIdList = self.mPlatformAchievementIdList or {}
    if(not table.indexof(self.mPlatformAchievementIdList, achievementId))then
        table.insert(self.mPlatformAchievementIdList, achievementId)
        sdk.SdkManager:reachAchievement(achievementId)
    end
end

-- 初始化配置表
function parseGuideReportConfigData(self)
    self.mGuideReportConfig = {}
    local baseData = RefMgr:getData("guide_pool")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(stepReport.StepReportGuideConfigVo)
        vo:setData(data)
        if (not self.mGuideReportConfig[vo.guideId]) then
            self.mGuideReportConfig[vo.guideId] = {}
        end
        self.mGuideReportConfig[vo.guideId][vo.stepId] = vo
    end
end

function getGuideReportVo(self, cusGuideId, cusStepId)
    if (cusGuideId and cusStepId) then
        if (not self.mGuideReportConfig) then
            self:parseGuideReportConfigData()
        end
        local stepDic = self.mGuideReportConfig[cusGuideId]
        if (stepDic and stepDic[cusStepId]) then
            return stepDic[cusStepId]
        end
    end
    return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
