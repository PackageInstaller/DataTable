RhythmGameNoteReverse = {};

RhythmGameNoteReverse.__index = RhythmGameNoteReverse;

RhythmGameNoteReverse.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteReverse);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.scale = self.transform.localScale;
    return self;
end

function RhythmGameNoteReverse:SetData(data)
    
end

function RhythmGameNoteReverse:SetDirection(isLeft)
    self.scale.x = isLeft and 1 or -1;
    self.transform.localScale = self.scale;
end

function RhythmGameNoteReverse:Clear()

end

function RhythmGameNoteReverse:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end