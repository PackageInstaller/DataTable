RhythmGameItemEffect = {};

RhythmGameItemEffect.__index = RhythmGameItemEffect;

local objs = {
    button = { path = "Image", type = "Button" },

    icon = { path = "Icon", type = "RawImage" },
}

function RhythmGameItemEffect.New()
    local self = {};
    setmetatable(self, RhythmGameItemEffect);
    return self;
end

function RhythmGameItemEffect:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameItemEffect, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameItemEffect:SetData(data)
    self.data = data.data;



end

function RhythmGameItemEffect:Clear()
    self.data = nil;
    self.icon.texture = nil;
end

function RhythmGameItemEffect:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end