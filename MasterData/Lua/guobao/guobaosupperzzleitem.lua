GuoBaoSupperzzleItem = {};

GuoBaoSupperzzleItem.__index = GuoBaoSupperzzleItem;

local eulerAngles = Vector3(0,0,0);

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Icon", type = "RawImage" },
    unknowTF = { path = "Unknow", type = "Transform" },
};

function GuoBaoSupperzzleItem.New()
    local self = {};    
    setmetatable(self, GuoBaoSupperzzleItem);
    return self;
end

function GuoBaoSupperzzleItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuoBaoSupperzzleSelect, self);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    self.angle = 0;
    self.tween = nil;
    self.getAngle = function()
        return self.angle;
    end
    self.setAngle = function(angle)
        eulerAngles.y = angle;
        self.unknowTF.localEulerAngles = eulerAngles;
    end
    self.angleComplete = function()
        self:ClearTween();
        self:Hide(0.25);
    end
end

function GuoBaoSupperzzleItem:SetData(data)
    self.data = data.data;
    self.icon.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Archives/%s.png", self.data.id));
    eulerAngles.y = 0;
    self.unknowTF.localEulerAngles = eulerAngles;
end

function GuoBaoSupperzzleItem:ClearTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
end

function GuoBaoSupperzzleItem:Show(keep)
    self.data.status = true;
    self:ClearTween();
    self.angle = 0;
    self.tween = DOTWeen.To(self.getAngle, self.setAngle, 90, 0.25):SetEase(Ease.Linear);
    if (not keep) then
        self.tween.onComplete = self.angleComplete;
    end
end

function GuoBaoSupperzzleItem:Hide(delay)
    self.data.status = false;
    self.angle = 90;
    self:ClearTween();
    self.tween = DOTWeen.To(self.getAngle, self.setAngle, 0, 0.25):SetEase(Ease.Linear);
    self.tween:SetDelay(delay);
end

function GuoBaoSupperzzleItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self:ClearTween();
end

function GuoBaoSupperzzleItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end