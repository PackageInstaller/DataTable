RhythmGameNoteDoubleClick = {};

RhythmGameNoteDoubleClick.__index = RhythmGameNoteDoubleClick;

RhythmGameNoteDoubleClick.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteDoubleClick);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.itemImg = self.transform:GetComponent("Image");
    self.scale = self.transform.localScale;
    return self;
end

function RhythmGameNoteDoubleClick:SetData(data)

end

function RhythmGameNoteDoubleClick:SetDirection(isLeft)
    self.scale.x = isLeft and 1 or -1;
    self.transform.localScale = self.scale;
end

function RhythmGameNoteDoubleClick:Clear()

end

function RhythmGameNoteDoubleClick:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end