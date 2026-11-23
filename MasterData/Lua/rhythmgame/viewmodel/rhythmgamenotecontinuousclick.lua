RhythmGameNoteContinuousClick = {};

RhythmGameNoteContinuousClick.__index = RhythmGameNoteContinuousClick;

RhythmGameNoteContinuousClick.New = function(type, prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameNoteContinuousClick);
    self.type = type;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.itemTF = self.transform:Find("Item"):GetComponent("RectTransform");
    self.itemSize = self.itemTF.sizeDelta;
    self.endTF = self.itemTF:Find("End"):GetComponent("RectTransform");
    self.itemImg = self.itemTF:GetComponent("Image");
    self.iconTF = self.itemTF:Find("Icon");
    self.iconImg = self.iconTF:GetComponent("Image");
    self.endTF = self.itemTF:Find("End");
    self.endImg = self.endTF:GetComponent("Image");
    self.scale = Vector3.one;
    self.color = UnityEngine.Color(1,1,1,1);
    return self;
end

function RhythmGameNoteContinuousClick:SetData(data, dir, status)
    self.itemSize.x = data;
    self.itemTF.sizeDelta = self.itemSize;
    self.scale.x = dir;
    self.itemTF.localScale = self.scale;
    if (status) then
        self.color.r = 1;
        self.color.g = 1;
        self.color.b = 1;
    else
        self.color.r = 0.5;
        self.color.g = 0.5;
        self.color.b = 0.5;
    end
    self.itemImg.color = self.color;
    self.iconImg.color = self.color;
    self.endImg.color = self.color;
end

function RhythmGameNoteContinuousClick:SetDirection(isLeft)
    
end

function RhythmGameNoteContinuousClick:Clear()
    
end

function RhythmGameNoteContinuousClick:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end