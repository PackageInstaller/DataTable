--[[ 
-----------------------------------------------------
@filename       : ActivityLimitShopVo
@Description    : 限时礼包配置解析
@date           : 2024-07-29
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.vo.ActivityLimitShopVo', Class.impl())

function parseData(self, id, data)
    self.id = id
    self.buyType = data.buy_type
    self.type = data.gift_type
    self.tid = data.item_tid
    self.num = data.item_num
    self.payType = data.pay_type
    self.price = data.price
    self.limitNum = data.limit_num
    self.value = data.value
    self.name = data.name
    -- 礼包列表
    self.giftList = data.gift_list
    -- 描述
    self.desc = data.desc
    self.icon = data.icon
end

function getAwardList(self)
    return AwardPackManager:getAwardListById(self.tid)
end

function getPrice(self)
    return self.price/100
end

function getPayType(self)
    return self.payType
end

function getResidue(self)
    local msgVo=activity.ActitvityExtraManager:getLimitShopMsgVoById(self.id)
    local num=msgVo~=nil and msgVo.buy_times  or self.limitNum
    return _TT(29511).._TT(45013,self.limitNum-num,self.limitNum)
end

function getIsCanBuy(self)
    local msgVo=activity.ActitvityExtraManager:getLimitShopMsgVoById(self.id)
    local num=msgVo~=nil and msgVo.buy_times  or self.limitNum
    return self.limitNum-num>0
end

function getValue(self)
    return self.value..HtmlUtil:size("%",12)
end

function getId(self)
    return self.id
end

function getBuyType(self)
    return self.buyType
end

function getEndTime(self)
    local msgVo=activity.ActitvityExtraManager:getLimitShopMsgVoById(self.id)
    return msgVo and msgVo.end_time or 0
end

function getDesc(self)
    return _TT(self.desc)
end

function getName(self)
    return _TT(self.name)
end

function getIcon(self)
    return UrlManager:getIconPath("item/"..self.icon)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]