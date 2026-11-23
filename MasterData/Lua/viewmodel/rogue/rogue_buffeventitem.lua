Rogue_BuffEventItem = {};

Rogue_BuffEventItem.__index = Rogue_BuffEventItem;

local objs = {
    canGetBgGo = { path = "Group/Bg_2", type = "GameObject" },
    canGetBtn = { path = "Group/Bg_2", type = "UIButtonClick" },
    iconTexture = { path = "Group/Icon", type = "RawImage" },
    NameText = { path = "Group/Name", type = "Text" },
    DescText = { path = "Group/Scroll View/Viewport/Content", type = "Text" },
    RewardIconGo = { path = "Group/RewardIcon", type = "GameObject" },
    MaskGo = { path = "Group/Mask", type = "GameObject" },
};

function Rogue_BuffEventItem.New()
    local self = {};
    setmetatable(self, Rogue_BuffEventItem);
    return self;
end

function Rogue_BuffEventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.callback ~= nil) then
            self.data.callback(self.data.id)
        end
    end
    LuaMgr.AddClick(self.canGetBtn, self.OnClickItem);
end

function Rogue_BuffEventItem:SetData(data)
    self.data = data.data.data;
    self.iconTexture.texture = self.data.icon
    self.NameText.text = self.data.name
    self.DescText.text = self.data.desc
    self:SetStatus(self.data.status)
end


function Rogue_BuffEventItem:SetStatus(status)
    SetActive(self.canGetBgGo, status == 2)
    SetActive(self.RewardIconGo, status == 2)
    SetActive(self.MaskGo, status == 0)
end

function Rogue_BuffEventItem:Clear()
    self.data = nil;
end

function Rogue_BuffEventItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.canGetBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end