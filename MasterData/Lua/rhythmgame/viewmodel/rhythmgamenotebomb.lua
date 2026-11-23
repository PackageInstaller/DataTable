RhythmGameNoteBomb = {};

RhythmGameNoteBomb.__index = RhythmGameNoteBomb;

RhythmGameNoteBomb.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteBomb);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.scale = self.transform.localScale;
    return self;
end

function RhythmGameNoteBomb:SetData(data)
    
end

function RhythmGameNoteBomb:SetDirection(isLeft)
    self.scale.x = isLeft and 1 or -1;
    self.transform.localScale = self.scale;
end

function RhythmGameNoteBomb:Clear()
    
end

function RhythmGameNoteBomb:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end