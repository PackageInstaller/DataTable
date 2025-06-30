module('mainActivity.ActiveDupStageStepVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.stepId = cusId
    self.stageType = cusData.stage_type
    self.starNum = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]