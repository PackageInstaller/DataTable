FoodComposeItem = {};

FoodComposeItem.__index = FoodComposeItem;

local objs = {
    group = { path = "Group", type = "GameObject" },
    iconTF = { path = "Group/Icon", type = "Transform" },
    icon = { path = "Group/Icon", type = "RawImage" },
    light = { path = "Group/Light", type = "GameObject" },
    max = { path = "Group/Max", type = "GameObject" },
    hecheng = { path = "FX_hecheng", type = "GameObject" },
    toufang = { path = "FX_toufang", type = "GameObject" },
}

function FoodComposeItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoodComposeItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform:GetComponent("RectTransform");
    self.index = 0;
    self.pos = Vector3.zero;
    self.rect = {x=0, y=0, mx=0, my=0};
    UITool.Parse(self.gameObject, self, objs);
    self.tween = nil;
    return self;
end

function FoodComposeItem:SetData(index, config, isPut)
    self.index = index;
    self:SetIcon(config.Icon);
    self.pos.x = ((index - 1) % 7) * 111 - 380 + 55;
    self.pos.y = math.floor((index - 1) / 7) * -111 + 220 - 55;
    self.transform.localPosition = self.pos;
    self.rect.x = self.pos.x - 55;
    self.rect.y = self.pos.y - 55;
    self.rect.mx = self.pos.x + 55;
    self.rect.my = self.pos.y + 55;
    self:SetStatus(true);
    self:SetLight(false);
    self:SetHint(false);
    self:SetMax(config.IfMax == 1);
    SetActive(self.toufang, isPut);
end

function FoodComposeItem:SetIcon(resId)
    self.icon.texture = FoodComposeMgr.GetTexture(resId);
end

function FoodComposeItem:InRect(pos)
    return pos.x >= self.rect.x and pos.x <= self.rect.mx and pos.y >= self.rect.y and pos.y <= self.rect.my;
end

function FoodComposeItem:SetStatus(status)
    SetActive(self.group, status);
    self:SetHint(false);
end

function FoodComposeItem:SetLight(status)
    SetActive(self.light, status);
    SetActive(self.hecheng, status);
    self:SetHint(false);
end

function FoodComposeItem:SetHint(status)
    self.iconTF.localScale = Vector3.one;
    self:ClearTween();
    if (status) then
        self.tween = self.iconTF:DOScale(1.3, 0.5):SetEase(CS.DG.Tweening.Ease.InOutCubic):SetLoops(-1, LoopType.Yoyo);
    end
end

function FoodComposeItem:SetMax(status)
    SetActive(self.max, status);
end

function FoodComposeItem:ClearTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
end

function FoodComposeItem:Clear()
    self.index = 0;
    self.icon.texture = nil;
    self:ClearTween();
    self:SetStatus(false);
end

function FoodComposeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end