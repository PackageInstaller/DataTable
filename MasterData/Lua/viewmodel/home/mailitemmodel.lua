





MailItemModel = {}

MailItemModel.__index = MailItemModel
local objs = {
    unread = {path = "Animation/Unread",type = "GameObject"},
    title_1 = {path = "Animation/Unread/Title",type = "Text"},
    haveRead = {path = "Animation/HaveRead",type = "GameObject"},
    title_2 = {path = "Animation/HaveRead/Title",type = "Text"},
    choose = {path = "Animation/Choose",type = "GameObject"},
    title_3 = {path = "Animation/Choose/Title",type = "Text"},
    headIcon = {path = "Animation/HeadIcon",type = "Image"},
    fromText = {path = "Animation/From",type = "Text"},
    timeText = {path = "Animation/Time",type = "Text"},
    redPoint = {path = "Animation/RedPoint",type = "GameObject"},
    button = {path = "Animation/Btn",type = "Button"},
    isLikeObj={path = "Animation/like",type = "GameObject"},
}

function MailItemModel.New()
    local self = {}
    setmetatable(self, MailItemModel)
    return self
end

function MailItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MailItemChoose, self.index)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function MailItemModel:SetData(data)
    self.data = data.data
    self.index = data.data.index
    self.select = data.data.select
    if type(self.data.data.items) == "function" then
        self.data.data.items = {}
    end
    SetActive(self.choose,self.select)
    SetActive(self.redPoint,self:SetRed())
    SetActive(self.unread,self.data.data.status == 0)
    SetActive(self.haveRead,self.data.data.status ~= 0)
    SetActive(self.isLikeObj,self.data.data.isFavorite)
    local titleStr = self.data.data.theme
    self.title_1.text,self.title_2.text,self.title_3.text = titleStr,titleStr,titleStr
    self.headIcon.sprite = LuaMgr.GetSprite("MailSender","sender"..self.data.data.sender)
    self.fromText.text = ConfigMgr.Config.senders[self.data.data.sender].nickname
    self.timeText.text = self:GetTime(self.data.data)
    self.gameObject:SetActive(true)
end

function MailItemModel:GetTime(data)
    local expireTime=data.expireTime

    if data.isFavorite or expireTime >= 2019657600 then
        return ""
    end
    local residueTime = expireTime - LuaMgr.Timestamp()
    if residueTime >= 86400 then
        return math.floor(residueTime / 86400)..LuaMgr.GetLangText("MailViewModel_2")
    elseif residueTime < 86400 and residueTime >= 3600 then
        return math.floor(residueTime / 3600)..LuaMgr.GetLangText("MailViewModel_3")
    elseif residueTime < 3600 and residueTime >= 60 then
        return math.floor(residueTime / 60)..LuaMgr.GetLangText("MailViewModel_4")
    elseif residueTime < 60 then
        return LuaMgr.GetLangText("MailViewModel_5")
    end
end


function MailItemModel:SetRed()
    if self.data.data.status == 0 then
        return true
    elseif self.data.data.status ~= 2 and next(self.data.data.items) ~= nil then
        return true
    else
        return false
    end
end

function MailItemModel:OpenChoose()
    SetActive(self.choose,true)
end

function MailItemModel:CloseChoose()
    SetActive(self.choose,false)
end

function MailItemModel:Clear()
    self.data = nil
    self.index = nil
    self.gameObject:SetActive(false)
end

function MailItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end