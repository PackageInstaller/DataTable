--[[    邮件vo
]]
module('mail.MailVo', Class.impl())

function ctor(self)
    -- id
    self.id = 0
    -- 类型
    self.type = 0
    -- 标题
    self.title = ''
    -- 内容
    self.content = ''
    -- 发件人
    self.sendName = ''
    -- 状态 0-未读，1-已读，2-已取附件
    self.state = 0
    -- 日期 s
    self.date = 0
    -- 过期时间戳
    self.expired_time = 0
    -- 奖励
    self.awardList = {}
    --add 展示用
    self.isSelect = false
    -- 称呼
    self.callName = ""
    -- 是否可收藏
    self.isCollection = false
end

function setData(self, cusMsg)
    self.id = cusMsg.id
    self.type = cusMsg.type
    self.title = cusMsg.title
    self.content = cusMsg.content
    self.sendName = cusMsg.send_name or _TT(14)
    self.state = cusMsg.state
    self.date = cusMsg.date
    self.expired_time = cusMsg.expired_time
    self.callName = cusMsg.call or _TT(421)  --"尊敬的链尉官" 
    self.isCollection = cusMsg.is_collection == 1
    self.awardList = {}

    for _, v in ipairs(cusMsg.award_list) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        local propsVo = nil
        if configVo.type == PropsType.EQUIP then
            propsVo = LuaPoolMgr:poolGet(props.EquipVo)
            propsVo:setEquipDetailMsgData(v)
        else
            propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
        end
        table.insert(self.awardList, propsVo)
    end
end

-- 是否有附件
function getHasAward(self)
    return #self.awardList > 0
end

-- 是否有附件未领
function getHasAwardTip(self)
    return #self.awardList > 0 and self.state ~= 2
end

-- 是否显示红点
function getIsFlag(self)

    if self.expired_time - GameManager:getClientTime() < 0 then
        return false
    end

    if self.state == 0 then
        return true
    end
    if self.state ~= 2 and self:getHasAward() then
        return true
    end
    return false
end

-- 是否已读
function isRead(self)
    return self.state ~= 0
end

-- 过期时间
function getExpiredTime(self)
    return self.expired_time
end

function getSendTimeStr(self)
    return TimeUtil.getFormatTimeBySeconds_4(self.date)
end

function getFormatTimeBySeconds(self)
    local days = self.expired_time - GameManager:getClientTime()
    if TimeUtil.getFormatTimeBySeconds_2(days) == "30天" then
        return "29天"
    end
    return TimeUtil.getFormatTimeBySeconds_2(days)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(14):	"系统"
]]