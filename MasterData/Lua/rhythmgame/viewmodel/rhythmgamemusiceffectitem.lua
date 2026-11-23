RhythmGameMusicEffectItem = {};

RhythmGameMusicEffectItem.__index = RhythmGameMusicEffectItem;

local objs = {
    iconGO = { path = "Icon", type = "GameObject" },
    iconImg = { path = "Icon", type = "RawImage" },
    addGO = { path = "Add", type = "GameObject" },
};

function RhythmGameMusicEffectItem.New()
    local self = {};
    setmetatable(self, RhythmGameMusicEffectItem);
    return self;
end

function RhythmGameMusicEffectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function RhythmGameMusicEffectItem:SetData(data)
    if (data.data.id == -1) then
        SetActive(self.iconGO, false);
        SetActive(self.addGO, true);
    else
        self.iconImg.texture = GetRhythmEquipTexture(data.data.icon);
        SetActive(self.iconGO, true);
        SetActive(self.addGO, false);
    end
end

function RhythmGameMusicEffectItem:Clear()
    self.iconImg.texture = nil;
end

function RhythmGameMusicEffectItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end