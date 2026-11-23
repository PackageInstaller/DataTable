RhythmGameNoteHide = {};

RhythmGameNoteHide.__index = RhythmGameNoteHide;

RhythmGameNoteHide.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteHide);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.itemImg = self.transform:GetComponent("Image");
    self.color = UnityEngine.Color(1,1,1,1);
    self.scale = self.transform.localScale;
    return self;
end

function RhythmGameNoteHide:SetData(data)
    if self.color.a == data then
        return
    end
    self.color.a = data
    self.itemImg.color = self.color;
end

function RhythmGameNoteHide:SetDirection(isLeft)
    self.scale.x = isLeft and 1 or -1;
    self.transform.localScale = self.scale;
end

function RhythmGameNoteHide:Clear()

end

function RhythmGameNoteHide:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end