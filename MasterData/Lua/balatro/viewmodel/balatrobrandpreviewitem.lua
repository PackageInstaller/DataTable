











BalatroBrandPreviewItem = {}
BalatroBrandPreviewItem.__index = BalatroBrandPreviewItem

local objs = {
    nameTxt = {path = "BrandName", type = BalatroUtil.Text},
    desTxt = {path = "BrandDes", type = BalatroUtil.Text},
    icon = {path = "BrandIcon", type = BalatroUtil.Image},
    invalidFlag = {path = "BrandIcon/InvalidFlag", type = BalatroUtil.Image},
}

function BalatroBrandPreviewItem.New(obj, parent)

    local self = {}
    setmetatable(self, BalatroBrandPreviewItem)
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.gameObject, true)
    return self
end



function BalatroBrandPreviewItem:SetData(data, type)
    self:Clear()
    SetActive(self.gameObject, true)
    self.data = data
    if self.data == nil then
        return
    end
    local nameStr, desStr, iconSprite
    if type == BalatroUtil.BrandPreviewType.BalatroBrand then

        local tempData = self.data
        nameStr = tempData:GetName()
        desStr = tempData:GetDes()
        iconSprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, tempData:GetResName())
    else

        local tempData = self.data
        nameStr = tempData:GetName()
        desStr = tempData:GetDes()
        iconSprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, tempData:GetResName())
    end
    self.nameTxt.text = tostring(nameStr)
    self.desTxt.text = tostring(desStr)
    self.icon.sprite = iconSprite
end

function BalatroBrandPreviewItem:Clear()
end

function BalatroBrandPreviewItem:Destroy()
    if (self.OnClickItem ~= nil) then
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end