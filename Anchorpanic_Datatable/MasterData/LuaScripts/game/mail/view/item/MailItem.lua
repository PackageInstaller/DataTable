--[[ 
-----------------------------------------------------
@filename       : MailItem
@Description    : 邮件列表
@date           : 2020-08-20 17:28:27
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.mail.view.item.MailItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.gridList = {}
    self.isSelectId=0
end

-- override 虚拟列表被激活时自动调用
function active(self)
    super.active(self)
    self:updateData()
end
-- override 虚拟列表被非激活时自动调用
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.MAIL_DEL_REQ, self.onDelete, self)
    GameDispatcher:removeEventListener(EventName.OPEN_MAIL_CONTENT_PANEL, self.updateState, self)
    mail.MailManager:removeEventListener(mail.MailManager.MAIL_UPDATE_RED, self.updateRedState, self)
end


function setData(self, param)
    super.setData(self, param)
    self.mBtnBg = self:getChildGO("mBtnBg")
    self.mImgGm = self:getChildGO("mImgGm")
    self.mImgLine = self:getChildGO("mImgLine")
    self.mRedDot = self:getChildTrans("mRedDot")
    self.mImgPropGo = self:getChildGO("mPropImg")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mImgPropSelect = self:getChildGO("mImgPropSelect")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtValid = self:getChildGO("mTxtValid"):GetComponent(ty.Text)
    self.mTxtOverTime = self:getChildGO("mTxtOverTime"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mPropImg = self:getChildGO("mPropImg"):GetComponent(ty.AutoRefImage)
    self.mTxtValidTime = self:getChildGO("mTxtValidTime"):GetComponent(ty.Text)
    self:addOnClick(self.mBtnBg, self.onOpenContent)
    self:updateData()
    GameDispatcher:addEventListener(EventName.MAIL_DEL_REQ, self.onDelete, self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIL_CONTENT_PANEL, self.updateState, self)
    mail.MailManager:addEventListener(mail.MailManager.MAIL_UPDATE_RED, self.updateRedState, self)
end

function updateMailState(self,isSelect)
    local color = (isSelect == true) and gs.ColorUtil.GetColor("404548ff") or gs.ColorUtil.GetColor("ffffffff")
    self.mBtnSelect:SetActive(isSelect)
    self.mBtnBg:SetActive(not isSelect)
    self.mPropImg.color = color
    self.mImgIcon.color = color
    self.mTxtTitle.color = color
    self.mTxtValid.color = color
    self.mTxtOverTime.color = color
    self.mTxtValidTime.color = color
    self:updateRedState()
    if self.data:isRead() then
        self.mImgIcon:SetImg(UrlManager:getPackPath("mail/mail_21.png"), true)
    else
        self.mImgIcon:SetImg(UrlManager:getPackPath("mail/mail_20.png"), true)
    end
end

function updateRedState(self)
    if self.data:getIsFlag() then
        RedPointManager:add(self.mRedDot, nil, 0, 0)
    else
        RedPointManager:remove(self.mRedDot)
    end
end

function updateState(self,id)
    local isShow=false
    if id~=nil then
        self.isSelectId = id
    end
    if (self.isSelectId == self.data.id)then
        isShow=true
    end
    self:updateMailState(isShow)
end

function updateData(self)
    self.mImgLine:SetActive(true)
    self.mTxtValidTime.text = self.data:getFormatTimeBySeconds()
    local title = string.omit(self.data.title, 9)
    self.mTxtTitle.text = title
    local time = self.data:getExpiredTime() - GameManager:getClientTime()
    self.mTxtOverTime.text = self.data:getSendTimeStr()
    --小于一天的才添加
    if time < 60 * 60 * 24 then
        self:__setTime()
        LoopManager:addTimer(1, 0, self, self.__setTime)
    end
    self:updateState()
    if self.data:getHasAwardTip() then
        self.mImgPropGo:SetActive(true)
    else
        self.mImgPropGo:SetActive(false)
    end
    self.mImgPropSelect:SetActive(self.mImgPropGo.activeSelf == true)
end

function onDelete(self,id)
    if id~=self.data.id then
        return
    end
    RedPointManager:remove(self.mRedDot)
    LoopManager:removeTimer(self, self.__setTime)
    self:deActive()
end

function __setTime(self)
    local mailVo = self.data
    local time = mailVo:getExpiredTime() - GameManager:getClientTime()
    self.mTxtOverTime.text = mailVo:getSendTimeStr()
    if time < 0 then
        GameDispatcher:dispatchEvent(EventName.MAIL_DEL_REQ, { self.data.id })
        return
    end
end

function onOpenContent(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIL_CONTENT_PANEL, self.data.id)
    end
end

function onGetAward(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.MAIL_AWARD_REQ, { self.data.id })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]