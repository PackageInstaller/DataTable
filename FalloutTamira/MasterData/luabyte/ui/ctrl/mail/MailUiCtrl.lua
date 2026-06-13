local MailUiCtrl = BaseClass("MailUiCtrl",BaseUICtrl)
local M = MailUiCtrl

local circular = require("Framework.UI.Component.CircularScrollView")
local itemCtrl = require("UI.Ctrl.mail.mailUiItemCtrl")
local itemView = require("UI.View.mail.MailitemPrefabView")
local tInsert = table.insert

function M:Init()
    self._view.sc:Init(itemCtrl, itemView)
    --self._loopScroll = circular.New(self._view.sc)
    --self._loopScroll:Init(itemCtrl, itemView)
    self:AddListener()
end

--进入
function M:OnEnter()
    self._UpdateMailsHander = EventMgr:AddListener(UIMessageNames.SYSTEM_UPDATEMAILS, Bind(self, self._UpdateMails))
    MailDataMgr:GetMails(Bind(self,self.InitView))
    GameHelper.DoPlayerAction(PlayerAction.OpenMail)
end

function M:OnDeviceBack()
    self:Close()
    return true 
end


--添加按钮事件
function M:AddListener()
    self._view.closeBtn:onClick(Bind(self, self.ClickBackBtn))
    self._view.getAllBtn:onClick(Bind(self, self.ClickGetAllBtn))
    self._view.deleteAllBtn:onClick(Bind(self, self.ClickDestroyAllBtn))
end

--初始化UI列表
function M:InitView(allMail)
    self.luaMailTable = {}
    for key, value in pairs(allMail) do
        --luaMailTable[key] = value
        tInsert(self.luaMailTable,value)
    end
    --self._loopScroll:SetDataList(luaMailTable)
    table.sort(self.luaMailTable,function(a, b) 
        if  a:Getstate() == b:Getstate() then 
            if  (a:GetTimeTick() == b:GetTimeTick()) then
                return (a:GetId() < b:GetId())
            else
                return (a:GetTimeTick() > b:GetTimeTick())
            end
        else
            return (a:Getstate() < b:Getstate() ) 
        end


    end)
    self._view.sc:SetDataList(self.luaMailTable)
    self._view.NoMail.gameObject:SetActive(#self.luaMailTable == 0)
    self._view.tipText:SetText("<size=45>"..#self.luaMailTable.."</size>/100")
end

--点击返回按钮
function M:ClickBackBtn()

end

--点击全部领取按钮
function M:ClickGetAllBtn()
    local ids={}
    for index, value in ipairs(self.luaMailTable) do
        if value:Getstate() == protocol.MailState.MS_NEW or value:Getstate() == protocol.MailState.MS_OPEN then
            if value:GethasItem() then
                tInsert(ids,value:GetId())
            end
        end
    end
    MailDataMgr:OpenMails(ids,true)
end

--点击删除全部邮件
function M:ClickDestroyAllBtn()
    local ids={}
    for index, value in ipairs(self.luaMailTable) do
        if value:Getstate() == protocol.MailState.MS_EXTRACT then
                tInsert(ids,value:GetId())
        elseif value:Getstate() == protocol.MailState.MS_OPEN  then
            if not value:GethasItem() then
                tInsert(ids,value:GetId())
            end
        end
    end
    if ids ~= nil and #ids >0 then
        MailDataMgr:DelMails(ids)
    end
end

--更新顶栏UI啥的
function M:UpdateTitle()

end

--更新item
function M:UpdateMailItem(_mailid)
    local maildata = MailDataMgr:GetMailDataById(_mailid)
    if maildata == nil then--被删除
        for index, value in ipairs(self.luaMailTable) do
            if value:GetId() == _mailid then
                table.remove(self.luaMailTable,index)
            end
        end
    else
        if not table.contains(self.luaMailTable,maildata) then --新邮件
            tInsert(self.luaMailTable,maildata)
        end
        table.sort(self.luaMailTable,function(a, b) 
            return (a:Getstate() < b:Getstate() ) 
        end)
        for index, value in ipairs(self.luaMailTable) do
            if value:GetId() == _mailid then
                self.luaMailTable[index] = maildata
            end
        end
    end
    self._view.sc:SetDataList(self.luaMailTable)
    -- self._view.sc:UpdateList()
    self._view.sc:ReFreshLayout()
    self._view.NoMail.gameObject:SetActive(#self.luaMailTable == 0)
    self._view.tipText:SetText("<size=45>"..#self.luaMailTable.."</size>/100")

end

--事件通知更新单封邮件
function M:_UpdateMail(_mailid)
    self:UpdateMailItem(_mailid)
end

--事件通知更新多封邮件
function M:_UpdateMails(_mailids)
    for _, value in pairs(_mailids) do
        self:UpdateMailItem(value)
    end

    if #_mailids == 1 then
        local maildata = MailDataMgr:GetMailDataById(_mailids[1])
        if maildata == nil then
            UIContextMgr:GetInstance():Close("MailPopupCtrl")
        end
    end
end

--关闭
function M:OnClose()
    EventMgr:RemoveListener(UIMessageNames.SYSTEM_UPDATEMAILS, self._UpdateMailsHander)
    self._UpdateMailsHander= nil
end

return MailUiCtrl