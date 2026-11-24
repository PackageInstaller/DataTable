SeasonSLGBuffItem = {};

SeasonSLGBuffItem.__index = SeasonSLGBuffItem;

local objs = {
    icon = { path = "bg/name/icon", type = "Image" },
    name = { path = "bg/name", type = "Text" },
    des  = { path = "bg/desc",  type = "Text" },
};

function SeasonSLGBuffItem.New()
    local self = {};
    setmetatable(self, SeasonSLGBuffItem);
    return self;
end

function SeasonSLGBuffItem:Init()

    SetActive(self.gameObject, true);
    for k, v in pairs(objs) do
        local target = nil;
        if v.path == "" then
            target = self.gameObject.transform;
        else
            target = self.gameObject.transform:Find(v.path);
        end
        if target == nil then
            self[k] = nil;
        elseif v.type == "Transform" then
            self[k] = target;
        elseif v.type == nil or v.type == "GameObject" then
            self[k] = target.gameObject;
        else
            self[k] = target:GetComponent(v.type);
        end
    end
end

function SeasonSLGBuffItem:SetData(pdata)
    self.data = pdata ~= nil and pdata.data or nil;
    if self.data == nil then
        return;
    end
    if self.icon ~= nil then
        self.icon.sprite = self.data.buffIcon or DefaultSprite;
    end
    if self.name ~= nil then
        self.name.text = self.data.buffName or "";
    end
    if self.des ~= nil then
        self.des.text = self.data.buffDesc or "";
    end
end

function SeasonSLGBuffItem:Clear()
    self.data = nil;
end


function SeasonSLGBuffItem:Destroy()
    self.data = nil;
    self.icon = nil;
    self.name = nil;
    self.des = nil;
end