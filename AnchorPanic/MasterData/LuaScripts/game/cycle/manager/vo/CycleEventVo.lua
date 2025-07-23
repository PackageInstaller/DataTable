module("cycle.CycleEventVo", Class.impl())

function parseCycleEvent(self, id, data)
    self.id = id

    --事件类型
    self.eventType = data.event_type
    --事件参数
    self.eventArgs = data.event_args

    -- 事件标题
    self.eventTitle = data.event_title
    -- 事件描述
    self.eventDes = data.event_des
    -- 按钮的描述
    self.eventBtn = data.event_btn
    --事件图标
    self.eventIcon = data.event_icon
    self.eventColor = data.btn_colour

    -- 触发后事件标题
    self.optionTitle = data.option_title
    -- 触发后事件描述
    self.optionDes = data.option_des

    -- 触发后选项按钮标题
    self.optionBtn = data.option_btn
    -- 触发后事件插图
    self.optionBtnDes = data.option_btn_des

    --背景图
    self.backGroundImg = data.background_img

    --消耗货币
    self.costCoin = data.cost_coin
end

--当前事件是否持有BUFF 需要额外处理buff内容填充
function getEventIsBuff(self)
    return self.eventType >=100 and self.eventType <=200 
end

--是否是随机buff
function getEventIsRandomBuff(self)
    return self.eventType == EVENT_TYPE.CON_COIN_GET_COLLAGE or self.eventType== EVENT_TYPE.RANDOM_TYPE_COLLAGE
end

--是否是赌场事件 需要额外判断次数
function getEventIsCasino(self)
    return self.eventType == EVENT_TYPE.CASINO
end

--是否是赌徒事件 需要额外处理子事件
function getEventIsCambler(self)
    return self.eventType == EVENT_TYPE.GAMBLER
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
