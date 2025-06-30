stepReport = {}
require("game/stepReport/manager/StepReportConst")
stepReport.StepReportGuideConfigVo = require("game/stepReport/manager/vo/StepReportGuideConfigVo")
stepReport.StepReportManager = require("game/stepReport/manager/StepReportManager").new()
stepReport.StepReportController = require('game/stepReport/controller/StepReportController').new(stepReport.StepReportManager)

local module = {stepReport.StepReportController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
