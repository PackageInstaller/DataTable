





CommonItemCountIcon = {}
CommonItemCountIcon.__index = CommonItemCountIcon

local objs = {
    countText = {path = "", type = UITool.Text},
    iconImage = {path = "Icon", type = UITool.RawImage}
}

function CommonItemCountIcon.New(item, index)
    local self = {}
    setmetatable(self, CommonItemCountIcon)
    if IsObjectNull(item) == false then
        self.gameObject = item
        self.index = index
        self:Init()
    end
    return self
end

function CommonItemCountIcon:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function CommonItemCountIcon:SetData(data, prefix)
    self.data = data.data or data
    self.countText.text = string.format("%s%d", prefix or "", data.count)
    self.iconImage.texture = GetItemHomeIcon(data.id)
end