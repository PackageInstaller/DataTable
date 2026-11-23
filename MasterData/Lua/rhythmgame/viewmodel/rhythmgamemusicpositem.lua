RhythmGameMusicPosItem = {};

RhythmGameMusicPosItem.__index = RhythmGameMusicPosItem;

local objs = {
    light = { path = "Light", type = "GameObject" },
};

function RhythmGameMusicPosItem.New()
    local self = {};
    setmetatable(self, RhythmGameMusicPosItem);
    return self;
end

function RhythmGameMusicPosItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function RhythmGameMusicPosItem:SetData(data)
    local pos = PlayerRhythmGameMgr.GetMusicPos();
    SetActive(self.light, data.data == pos);
end

function RhythmGameMusicPosItem:Clear()

end

function RhythmGameMusicPosItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end