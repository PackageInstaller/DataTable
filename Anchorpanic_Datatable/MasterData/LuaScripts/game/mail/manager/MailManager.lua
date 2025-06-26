--[[   
     邮件数据管理
]]
module("mail.MailManager", Class.impl(Manager))

MAIL_UPDATE = 'MAIL_UPDATE'
MAIL_UPDATE_RED = 'MAIL_UPDATE_RED'
OVER_DAY = 7

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_mailDic = {}
    --是否排序
    self.mIsSort = false
    --邮箱列表
    self.mMailList = {}
end

-- 解析邮件msg
function parseMailDataMsg(self, msg)
    for _, v in ipairs(msg.mail_list) do
        local mailVo = LuaPoolMgr:poolGet(mail.MailVo)
        mailVo:setData(v)
        self.m_mailDic[mailVo.id] = mailVo
    end
    self:updateMailList(self.m_mailDic)
    self:checkFlag()
    self:dispatchEvent(MAIL_UPDATE)
    note.NoteManager:dispatchEvent(note.NoteManager.MAIL_INIT)
end

-- 增加邮件和更新邮件
function addMail(self, msg)
    local mailVo = self.m_mailDic[msg.id]
    if not mailVo then
        mailVo = LuaPoolMgr:poolGet(mail.MailVo)
        mailVo:setData(msg)
        self.m_mailDic[msg.id] = mailVo
        self:updateMailList(self.m_mailDic)
        note.NoteManager:dispatchEvent(note.NoteManager.MAIL_UPDATE)
        self:dispatchEvent(MAIL_UPDATE)
    end
    mailVo:setData(msg)
    self:checkFlag()

end

-- 删除邮件
function delMail(self, idList)
    for _, v in pairs(idList) do
        local mailVo = self.m_mailDic[v]
        if mailVo ~= nil then
            if mailVo:getHasAward() then
                for _, propsVo in ipairs(mailVo.awardList) do
                    LuaPoolMgr:poolRecover(propsVo)
                end
            end
            for i, vo in ipairs(self.mMailList) do
                if vo == mailVo then
                    table.remove(self.mMailList, i)
                end
            end
            LuaPoolMgr:poolRecover(mailVo)
            self.m_mailDic[v] = nil

        end
    end
    self:checkFlag()
    self:dispatchEvent(MAIL_UPDATE)
end

-- 阅读邮件
function readMail(self, idList)
    for _, v in ipairs(idList) do
        local mailVo = self.m_mailDic[v]
        if mailVo ~= nil then
            mailVo.state = 1
        end
    end
    self:checkFlag()
    self:dispatchEvent(MAIL_UPDATE_RED)
end

-- 领取附件的邮件
function parseGetAwardMail(self, idList)
    local list = {}
    for _, v in ipairs(idList) do
        local mailVo = self.m_mailDic[v]
        if mailVo ~= nil then
            mailVo.state = 2
            for i, v in ipairs(mailVo.awardList) do
                table.insert(list, v)
            end
        end
    end
    ShowAwardPanel:showPropsList(list)
    self:checkFlag()
    self:dispatchEvent(MAIL_UPDATE)
end

-- 获取所有邮件dic
function getMailDic(self)
    return self.m_mailDic
end

-- 通过id获取vo
function getMailVoById(self, id)
    if not self.m_mailDic then
        self:dispatchEvent(MAIL_UPDATE)
    end
    return self.m_mailDic[id]
end

-- 获取所有邮件列表(过滤了已过期的)
function getMailList(self)
    if self.mIsSort then
        self.mIsSort = false
        self:updateMailList(self.m_mailDic)
    end
    return self.mMailList
end

function sortMail(a, b)
    if a.date > b.date then return true end
    if a.date < b.date then return false end
    if a.id < b.id then return true end
    if a.id > b.id then return false end
end

-- 一键领取获得的奖励
function getAwardList(self, idList)
    local list = {}
    for _, v in ipairs(idList) do
        local mailVo = self.m_mailDic[v]
        if mailVo ~= nil and mailVo:getHasAward() then
            table.merge(list, mailVo.awardList)
        end
    end
    return list
end

-- 一键删除的邮件id列表
function getKeyDelIdList(self)
    local list = {}
    for _, mailVo in pairs(self.m_mailDic) do
        if (not mailVo:getHasAward() and mailVo.state == 1) or mailVo.state == 2 then
            if mailVo.isCollection == false then
                table.insert(list, mailVo.id)
            end
        end
    end
    return list
end

-- 一键领取的邮件id列表
function getKeyAwardIdList(self)
    local list = {}
    for _, mailVo in pairs(self.m_mailDic) do
        if mailVo.state ~= 2 and mailVo:getHasAward() then
            table.insert(list, mailVo.id)
        end
    end
    return list
end

-- 更新列表
function updateMailList(self, mailic)
    local list = {}
    local rededlist = {}--无红点列表
    self.mMailList = {}
    for k, vo in pairs(self.m_mailDic) do
        local gameTime = GameManager:getClientTime()
        --5.18热更新补偿邮件处理导致服务器时间更新晚于邮件，后期移除
        if (not gameTime) then
            return
        end
        local time = vo:getExpiredTime() - gameTime
        if time > 0 then
            if vo:getIsFlag() then
                table.insert(self.mMailList, vo)
            else
                table.insert(rededlist, vo)
            end
        end
    end
    table.sort(self.mMailList, self.sortMail)
    table.sort(rededlist, self.sortMail)
    for _, mailVo in ipairs(rededlist) do
        table.insert(self.mMailList, mailVo)
    end
end

function checkFlag(self)
    local isFlag = false
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL)
    if isOpen then
        for _, mailVo in pairs(self.m_mailDic) do
            local time = mailVo:getExpiredTime() - GameManager:getClientTime()
            if mailVo:getIsFlag() and time > 0 then
                isFlag = true
                break
            end
        end
    end

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_MAIL, isFlag)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]