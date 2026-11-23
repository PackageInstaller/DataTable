





SSYXProductItem = {}
SSYXProductItem.__index = SSYXProductItem

local objs = {
    productIcon = {path = "ProductIcon", type = UITool.Image},
    productName = {path = "ProductName", type = UITool.Text}
}

SSYXProductItem.New = function(prefab)

    local self = {}
    setmetatable(self, SSYXProductItem)
    if prefab ~= nil then
        self.gameObject = prefab
        self:Init()
    end
    return self
end

function SSYXProductItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local newFlag = self.gameObject.transform:Find("NewFlag")
    self.newFlagObj = newFlag ~= nil and newFlag.gameObject or nil
    SetActive(self.newFlagObj, false)
end

function SSYXProductItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    local config = SSYXData.GetItemConfig(self.data.ID)
    self.productIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, config.Icon)
    self.productName.text = LuaMgr.GetLangText(config.NameLan)
end

function SSYXProductItem:ClearItems()
end

function SSYXProductItem:Clear()
    self:ClearItems()
end

function SSYXProductItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end