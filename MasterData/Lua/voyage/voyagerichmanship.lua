VoyageRichManShip = {};

VoyageRichManShip.__index = VoyageRichManShip;

VoyageRichManShip.New = function(ship, parent)
    local self = {};
    setmetatable(self, VoyageRichManShip);
    self.gameObject = LuaMgr.GetPrefab(string.format("Assets/_BundleResources/Voyage/%s.prefab", ship));
    self.transform = self.gameObject.transform;
    self.transform:SetParent(parent, false);
    self.data = nil;
    self.path = nil;
    self.callback = nil;
    self.index = 0;
    self.pos = nil;
    self.direction = nil;
    self.distance = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.effectNum1 = nil;
    self.effectNum2 = nil;
    self.effectNum3 = nil;
    self.effectNumCallback = function(data)
        SetActive(self.effectNum1, false);
        SetActive(self.effectNum2, false);
        SetActive(self.effectNum3, false);
        self:Move(data.path, data.callback);
    end
    return self;
end

function VoyageRichManShip:SetData(data, pos, dir)
    self.data = data;
    if (dir ~= nil) then
        local p = pos - dir;
        self.transform.localRotation = Quaternion.LookRotation(p.normalized);
    end
    self.transform.localPosition = pos;
end

function VoyageRichManShip:Update()
    self:OnMove();
end

function VoyageRichManShip:Move(path, callback)
    if (path ~= nil) then
        self.path = path;
        self.callback = callback;
        self.index = 1;
    else
        if (self.index >= #self.path) then
            self.path = nil;
            if (self.callback ~= nil) then
                local tempCallback = self.callback;
                self.callback = nil;
                tempCallback();
            end
            return;
        end
        self.index = self.index + 1;
    end
    self.pos = self.transform.localPosition;
    local grid = self.path[self.index];
    local p = self.pos - grid.pos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
    local time = self.distance * 0.25;
    self.endTime = self.startTime + time;
    self.transform.localRotation = Quaternion.LookRotation(self.direction);
end

function VoyageRichManShip:OnMove()
    if (self.path == nil) then return end
    
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.transform.localPosition = p;
    else
        local grid = self.path[self.index];
        if (grid ~= nil) then
            self.transform.localPosition = grid.pos;
        end
        self:Move(nil);
    end
end

function VoyageRichManShip:InitNum()
    self.effectNum1 = self.transform:Find("effect_Num01").gameObject;
    SetActive(self.effectNum1, false);
    self.effectNum2 = self.transform:Find("effect_Num02").gameObject;
    SetActive(self.effectNum2, false);
    self.effectNum3 = self.transform:Find("effect_Num03").gameObject;
    SetActive(self.effectNum3, false);
end

function VoyageRichManShip:MoveNum(path, callback, num)
    SetActive(self.effectNum1, num == 1);
    SetActive(self.effectNum2, num == 2);
    SetActive(self.effectNum3, num == 3);
    VoyageRichManTimeMgr.AddTime(0.8, self.effectNumCallback, {path=path, callback=callback});
end

function VoyageRichManShip:Clear()
    self.data = nil;
    self.path = nil;
    self.callback = nil;
    self.pos = nil;
    self.direction = nil;
end

function VoyageRichManShip:Destroy()
    self.effectNum1 = nil;
    self.effectNum2 = nil;
    self.effectNum3 = nil;
    self.effectNumCallback = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end