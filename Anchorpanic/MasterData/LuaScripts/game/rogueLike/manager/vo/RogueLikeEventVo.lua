module("rogueLike.RogueLikeEventVo", Class.impl())

function parseData(self, cusId, cusData)
    self.cusId = cusId
    -- 事件类型
    self.eventType = cusData.event_type
    -- 输出结果
    self.result = cusData.result
 -- 输出结果标题
    self.resultTitle = cusData.result_title
    -- 标签
    self.eventTitle = cusData.event_title
    -- 描述
    self.eventDes = cusData.event_des
    -- 图标
    self.icon = cusData.icon
    -- 事件参数配置
    self.eventArgs = cusData.event_args
    -- 子事件类型
    self.preconditionType = cusData.precondition_type
    -- 子事件条件
    self.preconditionArgs = cusData.precondition_args
    -- 子事件结果
    self.triggerType = cusData.trigger_type
    -- 子事件结果参数
    self.triggerResult = cusData.trigger_result
    -- 可选提示
    self.eventTips = cusData.event_tips
    -- 不可选提示
    self.eventTipN = cusData.event_tipN

    --事件底色
    self.eventColor = cusData.event_color
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
