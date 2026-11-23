RhythmGamePauseNoteItem = {};

RhythmGamePauseNoteItem.__index = RhythmGamePauseNoteItem;

local objs = {
    button = { path = "", type = "Button" },
    select = { path = "Select", type = "GameObject" },
}

function RhythmGamePauseNoteItem.New(gameObject, data)
    local self = {};
    setmetatable(self, RhythmGamePauseNoteItem);
    self.gameObject = gameObject;
    self.data = data;
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGamePauseNoteSelect, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function RhythmGamePauseNoteItem:SetData()
    SetActive(self.select, self.data.select);
end

function RhythmGamePauseNoteItem:Clear()

end

function RhythmGamePauseNoteItem:Destroy()
    self.data = nil;
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end