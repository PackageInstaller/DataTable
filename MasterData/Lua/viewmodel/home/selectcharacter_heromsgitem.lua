





SelectCharacter_HeroMsgItem = {}
SelectCharacter_HeroMsgItem.__index = SelectCharacter_HeroMsgItem

local objs = {
    select1 = {path = "Select1",type = "GameObject"},
    msgBg = {path = "MsgBg",type = "Image"},
    msgText = {path = "MsgBg/Text",type = "Text"},
    using = {path = "Using",type = "GameObject"},
    usingText = {path = "Using/Text",type = "Text"},
    select2 = {path = "Select2",type = "GameObject"},
    nameText = {path = "MsgName/Text",type = "Text"},
    introText = {path = "MsgIntro/Text",type = "Text"},
    msgBtn = {path = "MsgBg",type = "Button"},
}

function SelectCharacter_HeroMsgItem.New()
    local self = {}
    setmetatable(self, SelectCharacter_HeroMsgItem)
    return self
end

function SelectCharacter_HeroMsgItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.msgCommand = function()
        if self.callBack ~= nil then
            self.callBack(self.index,self.data)
        end
    end
    LuaMgr.AddClick(self.msgBtn,self.msgCommand)
end

function SelectCharacter_HeroMsgItem:SetData(data)
    self.data = data.data.data
    self.index = data.id
    self.characterId = data.data.characterId
    self.usingID = data.data.usingID
    self.callBack = data.data.callBack
    self.select = data.data.select
    self.lineStr = data.data.lineStr
    self.msgBg.sprite = LuaMgr.GetSprite("HeroMsgBg","Msg_"..self.data.ID)
    self.msgText.text = self.lineStr
    self.nameText.text = LuaMgr.GetLangText(self.data.NameLan)
    self.introText.text = LuaMgr.GetLangText(self.data.GetwayLan)
    self:SetSelectState()
    SetActive(self.using,self.usingID == self.data.ID)
    self.usingText.text = ConfigMgr.LangGlobal("25603")
    self.gameObject:SetActive(true)
end

function SelectCharacter_HeroMsgItem:SetSelectState()
    SetActive(self.select1,self.select)
    SetActive(self.select2,self.select)
end

function SelectCharacter_HeroMsgItem:Clear()
    self.data = nil
    self.characterId = nil
    self.usingID = nil
    self.callBack = nil
    self.index = nil
    self.select = nil
    self.lineStr = nil
    self.gameObject:SetActive(false)
end

function SelectCharacter_HeroMsgItem:Destroy()
    if (self.msgCommand ~= nil) then
        LuaMgr.RemoveClick(self.msgBtn, self.msgCommand)
        self.msgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end