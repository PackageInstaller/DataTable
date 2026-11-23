FoodComposeFoodItem = {};

FoodComposeFoodItem.__index = FoodComposeFoodItem;

local objs = {
    icon = { path = "", type = "RawImage" },
}

function FoodComposeFoodItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoodComposeFoodItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject.transform:GetComponent("RectTransform");
    self.isLive = false;
    self.tweenMove = nil;
    self.tweenScale = nil;
    self.callback = nil;
    self.OnComplete = function()
        self:ClearTween();
        self.isLive = false;
        if (self.callback ~= nil) then
            self.callback();
        end
    end
    return self;
end

function FoodComposeFoodItem:SetData(resId, p1, p2, callback)
    self.callback = callback;
    self.icon.texture = FoodComposeMgr.GetTexture(resId);
    self.transform.localPosition = p1;
    self.tweenMove = self.transform:DOLocalMove(p2, 1):SetEase(CS.DG.Tweening.Ease.InOutCubic);
    self.tweenMove.onComplete = self.OnComplete;
    self.transform.localScale = Vector3.one;
    self.tweenScale = self.transform:DOScale(0.5, 1):SetEase(CS.DG.Tweening.Ease.InOutCubic);
    self.isLive = true;
    self.gameObject:SetActive(true);
end

function FoodComposeFoodItem:ClearTween()
    if (self.tweenMove ~= nil) then
        self.tweenMove:Kill(false);
        self.tweenMove = nil;
    end
    if (self.tweenScale ~= nil) then
        self.tweenScale:Kill(false);
        self.tweenScale = nil;
    end
end

function FoodComposeFoodItem:Clear()
    self.icon.texture = nil;
    self.callback = nil;
    self:ClearTween();
    self.gameObject:SetActive(false);
end

function FoodComposeFoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end