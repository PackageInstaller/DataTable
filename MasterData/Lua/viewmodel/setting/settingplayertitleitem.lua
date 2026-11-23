





SettingPlayerTitleItem = {}

SettingPlayerTitleItem.__index = SettingPlayerTitleItem

local objs = {
    bgButton = {path = "Image", type = "Button"},
    title = {path = "Title", type = "Image"},
    text = {path = "Text",type = "Text"},
    select = {path = "Select",type = "GameObject"},
    textPos = {path = "Text",type = "RectTransform"},
}

function SettingPlayerTitleItem.New(prefab, parent)
    local self = {}
    setmetatable(self, SettingPlayerTitleItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.bgCommand = function()
        if self.callBack ~= nil then
            self.callBack(self.data.id)
        end
    end
    LuaMgr.AddClick(self.bgButton,self.bgCommand)
    return self
end

function SettingPlayerTitleItem:SetData(data,callBack)
    self.data = data
    self.callBack = callBack
    self.title.sprite = LuaMgr.GetSprite("PlayerTitle",self.data.img)
    self.text.text = LuaMgr.GetLangText(self.data.namelan)
    if self.data.img == "Title_40001" then
        self.textPos.anchoredPosition = Vector2(2,1)
    else
        self.textPos.anchoredPosition = Vector2(10,1)
    end
    SetActive(self.select,self.data.select)
    self.gameObject:SetActive(true)
end

function SettingPlayerTitleItem:Clear()
    self.data = nil
    self.callBack = nil
    self.gameObject:SetActive(false)
end

function SettingPlayerTitleItem:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.bgButton, self.bgCommand)
        self.bgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end