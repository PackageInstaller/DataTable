--[[ 
-----------------------------------------------------
@filename       : StepReportGuideConfigVo
@Description    : 引导上报配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("stepReport.StepReportGuideConfigVo", Class.impl())

function setData(self, cusData)
    self.guideId = cusData.guide_id
    self.stepId = cusData.step_id
    self.stepDes = cusData.step_des
    self.eventName = cusData.event_name
end

return _M