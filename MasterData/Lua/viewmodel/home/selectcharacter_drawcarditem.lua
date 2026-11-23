





SelectCharacter_DrawCardItem = {}
SelectCharacter_DrawCardItem.__index = SelectCharacter_DrawCardItem

local objs = {
    darwPic = {path = "DarwPic",type = "RawImage"},
    using = {path = "Using",type = "GameObject"},
    usingText = {path = "Using/Text",type = "Text"},
    select = {path = "Select2",type = "GameObject"},
    nameText = {path = "Name/Text",type = "Text"},
    darwBtn = {path = "DarwPic",type = "Button"},
    lock = {path = "Lock",type = "GameObject"},
}

function SelectCharacter_DrawCardItem.New()
    local self = {}
    setmetatable(self, SelectCharacter_DrawCardItem)
    return self
end

function SelectCharacter_DrawCardItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.drawCommand = function()
        if self.callBack ~= nil then
            self.callBack(self.data,self.lock.activeSelf)
        end
    end
    LuaMgr.AddClick(self.darwBtn,self.drawCommand)
end

function SelectCharacter_DrawCardItem:SetData(data)
    self.data = data.data.data
    self.callBack = data.data.callBack
    self.darwPic.texture = LuaMgr.GetTexture(Path.DrawCardBg_Path..self.data.Id..".png")
    self.nameText.text = LuaMgr.GetLangText(self.data.NameLan)
    SetActive(self.select,data.data.select)
    SetActive(self.using,self.data.Id == DataMgr.Player.GachaSkin)
    SetActive(self.lock,DataMgr.Player.GachaSkinMap[self.data.Id] == nil)
    self.usingText.text = ConfigMgr.LangGlobal("25603")
    self.gameObject:SetActive(true)
end

function SelectCharacter_DrawCardItem:Clear()
    self.data = nil
    self.callBack = nil
    self.gameObject:SetActive(false)
end

function SelectCharacter_DrawCardItem:Destroy()
    if (self.drawCommand ~= nil) then
        LuaMgr.RemoveClick(self.darwBtn, self.drawCommand)
        self.drawCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end