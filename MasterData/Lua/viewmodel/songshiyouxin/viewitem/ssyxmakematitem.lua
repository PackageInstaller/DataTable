






SSYXMakeMatItem = {}
SSYXMakeMatItem.__index = SSYXMakeMatItem

local objs = {
    matIcon = {path = "MatIcon", type = UITool.Image},
    num = {path = "Num", type = UITool.Text}
}

SSYXMakeMatItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXMakeMatItem)
    if obj ~= nil then
        self.gameObject = obj
        self:Init()
    end
    return self
end

function SSYXMakeMatItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local tempEnoughFlag = self.gameObject.transform:Find("EnoughFlag")
    if tempEnoughFlag ~= nil then
        self.enoughFlagObj = tempEnoughFlag.gameObject
    end
end

function SSYXMakeMatItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    if self.enoughFlagObj ~= nil then
        SetActive(self.enoughFlagObj, self.data.ConsumeIsEnough)
    end
    if self.data.IsInBag == true then
        local texture = GetItemTexture(self.data.ID)
        local sprite = LuaMgr.Texture2DToSprite(texture)
        self.matIcon.sprite = sprite
    else
        local config = SSYXData.GetItemConfig(self.data.ID)
        self.matIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, config.Icon)
    end
    self.num.text = self.data.NumText
end

function SSYXMakeMatItem:SetSelectFlag(isSelected)
    if self.selectFlagObj ~= nil then
        SetActive(self.selectFlagObj, isSelected == true)
    end
end

function SSYXMakeMatItem:ClearItems()
    self.data = nil
end

function SSYXMakeMatItem:Clear()
    self:ClearItems()
end

function SSYXMakeMatItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end