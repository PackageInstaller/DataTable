RhythmGameEvaluate = {};

RhythmGameEvaluate.__index = RhythmGameEvaluate;

local normalColor = UnityEngine.Color(1,1,1,1);
local disableColor = UnityEngine.Color(1,1,1,0);

RhythmGameEvaluate.New = function(prefab, parent)
    local self = {};
    setmetatable(self, RhythmGameEvaluate);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.image = self.transform:GetComponent("Image");
    self.scaleTween = nil;
    self.colorTween = nil;
    self.scaleComplete = function()
        self.colorTween = self.image:DOColor(disableColor, 0.2):SetDelay(1):OnComplete(self.colorComplete);
    end
    self.colorComplete = function()
        RhythmGameUIMgr.AddEvaluate(self);
    end
    return self;
end

function RhythmGameEvaluate:SetData(type)
    self.image.sprite = LuaMgr.GetSprite("RhythmGame", type);
    self.image.color = normalColor;
    self.image:SetNativeSize();
    self.transform.localScale = Vector3.zero;
    self.scaleTween = self.transform:DOScale(1, 0.3):SetEase(Ease.InOutCubic):OnComplete(self.scaleComplete);
end

function RhythmGameEvaluate:Clear()
    self.image.sprite = nil;
    if (self.scaleTween ~= nil) then
        self.scaleTween:Kill(false);
        self.scaleTween = nil;
    end
    if (self.colorTween ~= nil) then
        self.colorTween:Kill(false);
        self.colorTween = nil;
    end
end

function RhythmGameEvaluate:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end