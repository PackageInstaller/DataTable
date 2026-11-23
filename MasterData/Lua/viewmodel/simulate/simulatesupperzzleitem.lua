SimulateSupperzzleItem = {};

SimulateSupperzzleItem.__index = SimulateSupperzzleItem;

local eulerAngles = Vector3(0,0,0);

local objs = {
    button = { path = "", type = "Button" },
    icon = { path = "Icon", type = "RawImage" },
    unknowTF = { path = "Unknow", type = "Transform" },
};

function SimulateSupperzzleItem.New()
    local self = {};    
    setmetatable(self, SimulateSupperzzleItem);
    return self;
end

function SimulateSupperzzleItem:Init()    
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

function SimulateSupperzzleItem:SetData(data)
    self.data = data.data;
    self.icon.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Archives/%s.png", self.data.id));
    eulerAngles.y = 0;
    self.unknowTF.localEulerAngles = eulerAngles;
end

function SimulateSupperzzleItem:ClearTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
end

function SimulateSupperzzleItem:Show(keep)
    self.data.status = true;
    self:ClearTween();
    self.angle = 0;
    self.tween = DOTWeen.To(self.getAngle, self.setAngle, 90, 0.25):SetEase(Ease.Linear);
    if (not keep) then
        self.tween.onComplete = self.angleComplete;
    end
end

function SimulateSupperzzleItem:Hide(delay)
    self.data.status = false;
    self.angle = 90;
    self:ClearTween();
    self.tween = DOTWeen.To(self.getAngle, self.setAngle, 0, 0.25):SetEase(Ease.Linear);
    self.tween:SetDelay(delay);
end

function SimulateSupperzzleItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self:ClearTween();
end

function SimulateSupperzzleItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end