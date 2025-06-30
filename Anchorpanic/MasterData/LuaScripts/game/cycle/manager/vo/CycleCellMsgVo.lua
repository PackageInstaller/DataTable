module("cycle.CycleCellMsgVo", Class.impl())

function parseCellMsgVo(self,data)
    --格子id
    self.id = data.id 
    --事件id
    self.eventId = data.event_id
    --原始事件id
    self.originalId = data.original_event_id
    --普通格子参数
    self.normalArgs =  data.normal_args
    --其他参数(特殊情况使用)
    self.optionArgs = data.option_args
    --事件次数参数
    self.timesArgs = data.times_args
    --战斗后格子参数
    self.postwarArgs = data.postwar_args
end


function getOptionArgs(self,baseId)
    for i=1,#self.optionArgs do
        if self.optionArgs[i].event_id == baseId then
            return self.optionArgs[i].args
        end
    end    
end

function getOptionArgsTimes(self,baseId)
    for i=1,#self.optionArgs do
        if self.optionArgs[i].event_id == baseId then
            return self.optionArgs[i].times
        end
    end    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
