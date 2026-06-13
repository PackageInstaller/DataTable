local mailUiItemCtrl = BaseClass("mailUiItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = mailUiItemCtrl
-- 邮件view
function M:Init()
    self._view.GetBtn:onClick(Bind(self, self._OnClickGetBtn))
    self._view.reviewBtn:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    self._data = data
    if data == nil then
        return
    end
    self._data = data
    self._view.title:SetText(data:GetTitle())
    self._view.valueText:SetText(data:GetContent())
    self._view.timeText:SetText(data:GetTime())
    self._view.fromText:SetText(data:GetSenderName())
    self._view.itemTip:SetActive(data:GethasItem() and data:Getstate() ~= protocol.MailState.MS_EXTRACT)

    local mailCanGetItem = (data:Getstate() == protocol.MailState.MS_NEW or data:Getstate() == protocol.MailState.MS_OPEN)
    self._view.GetBtn:SetActive(mailCanGetItem and data:GethasItem())
    local highLight = data:Getstate() == protocol.MailState.MS_NEW or ( data:Getstate() == protocol.MailState.MS_OPEN and data:GethasItem())
    -- self._view.Mask:SetActive(false)
    -- self._view.ReadIcon:SetActive(not highLight)
    -- self._view.UnreadIcon:SetActive(highLight)

    if  data:GethasItem() then
        if  data:Getstate() == protocol.MailState.MS_NEW then
            self._view.mailView:SetState(3)
        elseif data:Getstate() == protocol.MailState.MS_OPEN then
            self._view.mailView:SetState(5)
        else
            self._view.mailView:SetState(4)
        end
    else
        if  data:Getstate() == protocol.MailState.MS_NEW then
            self._view.mailView:SetState(1)
        else
            self._view.mailView:SetState(2)
        end
    end


end

function M:_OnClickItem(go)
    if self._data:Getstate() == protocol.MailState.MS_NEW then
        local mailIds = {self._data:GetId()}
        local items = self._data:GetItem()
        if items == nil or #items ==0 then
            MailDataMgr:OpenMails(mailIds,true)
        else
            MailDataMgr:OpenMails(mailIds,false)
        end
    end
    UIContextMgr:GetInstance():Show("MailPopupCtrl", self._data)
end

function M:_OnClickGetBtn(go)
    local temIds = {}
    table.insert(temIds,self._data:GetId())
    MailDataMgr:OpenMails(temIds,true)
end

return mailUiItemCtrl
