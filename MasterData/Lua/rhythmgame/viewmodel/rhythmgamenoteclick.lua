RhythmGameNoteClick = {};

RhythmGameNoteClick.__index = RhythmGameNoteClick;

RhythmGameNoteClick.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteClick);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.scale = self.transform.localScale;
    return self;
end

function RhythmGameNoteClick:SetData(data)
    
end

function RhythmGameNoteClick:SetDirection(isLeft)
    self.scale.x = isLeft and 1 or -1;
    self.transform.localScale = self.scale;
end

function RhythmGameNoteClick:Clear()

end

function RhythmGameNoteClick:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end