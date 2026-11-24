WorldTaskProgressItem = {};

WorldTaskProgressItem.__index = WorldTaskProgressItem;
local objs = {
    sprite = { path = "root/Image", type = "Image" },
    btn = { path = "root", type = "Button" },
    desc = {path = "root/des",type = "Text"},
};

function WorldTaskProgressItem.New()
    local self = {};
    setmetatable(self, WorldTaskProgressItem);
    self.onClick = nil
    return self;
end

function WorldTaskProgressItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.onClick ~= nil then
            self.data.itemTransform = self.gameObject.transform
            self.data.onClick(self.data)
        end
    end
    LuaMgr.AddClick(self.btn, self.onClick)
end

function WorldTaskProgressItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    if self.sprite ~= nil then
        local index = tonumber(self.data.index) or 1
        self.sprite.sprite = LuaMgr.GetSprite("SLGSeason", string.format("sjz-zlfy-rw-qfrw_buff_%02d", index))
    end
    if self.desc ~= nil then







        self.desc.text = LuaMgr.GetLangText(self.data.config.DescLan)
    end
    if self.btn ~= nil then
        self.btn.interactable = true
    end
end


function WorldTaskProgressItem:Clear()
    self.data = nil;

end

function WorldTaskProgressItem:Destroy()
    if self.btn ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btn, self.onClick)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end