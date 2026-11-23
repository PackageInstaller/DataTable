GuoBaoCharacter = {};

GuoBaoCharacter.__index = GuoBaoCharacter;

GuoBaoCharacter.New = function(container)
    local self = {};
    setmetatable(self, GuoBaoCharacter);
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/UI/GuoBao/GuoBaoCharacter.prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.ai = nil;
    self.character = nil;
    self.id = "";
    self.live = true;
    self.characterId = "";
    self.data = nil;
    self.characterConfig = nil;
    return self;
end

function GuoBaoCharacter:SetData(id, characterId, skinId, data, shadow)
    self.id = id;
    self.characterId = characterId;
    self.data = data;
    self.gameObject.name = id;
    self.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, skinId, self.transform);
    if (self.character ~= nil) then

        self.character:SetShadow(shadow);
        self.character:SetDistortZIntensity(true);
        if (data == "npc" or data == "") then
            self.characterConfig = ConfigMgr.Config.FoundationCharacterMap[characterId];
        else
            self.characterConfig = data;
        end
        self.character:SetRotation(0, 180, 0);
        self.character:Play(self.characterConfig.Idle, 1, true, nil);
    end
end

function GuoBaoCharacter:RoomRotation()
    if (IsObjectNull(self.character)) then return end

    local spineTF = self.character.transform:Find("Spine");
    if (spineTF == nil) then return end

    spineTF.localRotation = UnityEngine.Quaternion.Euler(21, 0, 0);
end

function GuoBaoCharacter:SetAI(ai, data)
    self.ai = ai;
    self.ai:SetData(self, data);
end

function GuoBaoCharacter:Update()
    if (self.ai ~= nil) then
        self.ai:Update();
    end
end

function GuoBaoCharacter:Clear()
    LuaMgr.RemoveTimer(TimerConst.GuoBaoCharacterLineDelay);
    self.data = nil;
    if (self.ai ~= nil) then
        self.ai:Clear();
        self.ai = nil;
    end
    if (self.character ~= nil) then
        self.character:Clear();
        self.character = nil;
    end
    self.linePath = "";
    self.characterConfig = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end

function GuoBaoCharacter:Click()
    self.ai:Play(self.characterConfig.Action);
    self:PlayVoice();
end

function GuoBaoCharacter:PlayVoice()
    local len = #self.characterConfig.ClickSound;
    if (len > 0) then
        LuaMgr.RemoveTimer(TimerConst.GuoBaoCharacterLineDelay);
        GuoBaoMgr.StopVoice();
        local index = math.random(1, len);
        local line = self.characterConfig.ClickSound[index];
        local delay = tonumber(line[2]);
        self.linePath = string.format("Assets/_BundleResources/Character/%s/Audio/character_%s_%s001.mp3", self.characterId, line[1], self.characterId);
        self.lineText = line[3];
        if (delay > 0) then
            LuaMgr.AddTimer(TimerConst.GuoBaoCharacterLineDelay, self.OnLineTimer, delay * 0.001, 1, false);
        else
            self.OnLineTimer();
        end
    end
end