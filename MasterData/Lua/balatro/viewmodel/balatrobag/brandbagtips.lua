









BrandBagTips = {}
BrandBagTips.__index = BrandBagTips

local objs = {
    name = {path = "BG/Name", type = BalatroUtil.Text},
    des = {path = "BG/Des", type = BalatroUtil.Text},
    getMothed = {path = "BG/GetMothed", type = BalatroUtil.GameObject}
}

function BrandBagTips.New(object)

    local self = {}
    setmetatable(self, BrandBagTips)
    self.gameObject = object
    UITool.Parse(self.gameObject, self, objs)
    return self
end


function BrandBagTips:SetData(data)
    self.name.text = data:GetName()
    self.des.text = data:GetDes()
    SetActive(self.getMothed, data:GetOwnStatus() == BalatroUtil.BalatroOwnStatus.None)
end