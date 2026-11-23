TeamWeaponInfoAttrItem = {};

TeamWeaponInfoAttrItem.__index = TeamWeaponInfoAttrItem;

local objs = {
    Name = { path = "Name", type = "Text" },
    Value = { path = "Value", type = "Text" },
}

function TeamWeaponInfoAttrItem.New(obj)
    local self = {};
    setmetatable(self, TeamWeaponInfoAttrItem);
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject, true)
    return self
end

function TeamWeaponInfoAttrItem:SetData(nameStr, valueStr)
    self.Name.text = nameStr;
    self.Value.text = valueStr;
end

function TeamWeaponInfoAttrItem:Clear()
end

function TeamWeaponInfoAttrItem:Destroy()
    self.gameObject = nil;
end