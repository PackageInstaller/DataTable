module("seabed.SeabedEventVo", Class.impl())

function parseData(self,id,data)
    self.id = id 
    self.eventType = data.event_type
    self.eventArgs = data.event_args
    self.eventTitle = data.event_title
    self.eventDes = data.event_des 
    self.eventBtn = data.event_btn
    self.eventTitle = data.event_title
    self.eventIcon = data.event_icon

    self.btnTitle = data.btn_title
    self.btnDes = data.btn_des

    self.optionTitle = data.option_title
    self.optionDes = data.option_des
    self.backgroundImg = data.background_img
    self.costCoin = data.cost_coin
    self.needActionPoint = data.need_action_point
    self.iconName = data.icon_name
end


return _M