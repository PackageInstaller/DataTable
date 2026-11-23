





CardAttrItem = {}

CardAttrItem.__index = CardAttrItem

local objs = {
    attrIcon = {path = "AttrIcon", type = "Image"},
    attrName = {path = "AttrName", type = "Text"},
    attrValue = {path = "AttrValue", type = "Text"},
}

function CardAttrItem.New(prefab, parent)
    local self = {}
    setmetatable(self, CardAttrItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    return self
end

function CardAttrItem:SetData(data)
    self.data = data
    if self.data.state == 3 then
        self.attrValue.color = UnityEngine.Color(212/255,107/255,55/255,1)
    else
        self.attrValue.color = UnityEngine.Color(142/255,141/255,141/255,1)
    end
    self.attrIcon.sprite = LuaMgr.GetSprite("AttributeIcon",self.data.icon)
    self.attrName.text = self.data.name
    self.attrValue.text = "+"..self.data.value..self.data.type
    self.gameObject:SetActive(true)
end

function CardAttrItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function CardAttrItem:Destroy()
    self.data = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end