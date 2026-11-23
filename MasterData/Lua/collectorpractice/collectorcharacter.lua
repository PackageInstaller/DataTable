
CollectorCharacter = {};
CollectorCharacter.__index = CollectorCharacter;
CollectorCharacter.New = function(container)
    local self = {};
    setmetatable(self, CollectorCharacter);
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/UI/Foundation/FoundationCharacter.prefab");
    self.transform = self.gameObject.transform;
    self.transform.localEulerAngles = Vector3(42.6, 0, 4)
    self.transform.position = Vector3.zero
    self.transform:SetParent(container, false);
    self.ai = nil;
    self.character = nil;
    self.Move = false
    self.id = "";
    return self;
end

function CollectorCharacter:SetData(id, characterId, skinId, pos)
    self.id = id;
    self.gameObject.name = id;
    self.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, skinId, self.transform);
    if (self.character ~= nil) then


        self.transform.localPosition = pos;
        self.character:Play("house_idle", true, nil);
    end
end

function CollectorCharacter:SetDirection(dir)
    self.character:SetScale(Vector3(dir, 1, 1));
end

function CollectorCharacter:SetAI(ai, config)
    self.ai = ai;
    self.ai:SetData(self, config);
end

function CollectorCharacter:Update()
    if (self.ai ~= nil) then
        self.ai:Update();
    end
end

function CollectorCharacter:Clear()
    self.data = nil;
    if (self.ai ~= nil) then
        self.ai:Clear();
        self.ai = nil;
    end
    if (self.character ~= nil) then
        self.character:Clear();
        self.character = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end


function CollectorCharacter:Click()
    print("click " .. self.id);
    self.ai:Play("house_show");
end