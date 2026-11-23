FoundationCharacter = {};

FoundationCharacter.__index = FoundationCharacter;



FoundationCharacter.VoiceType = {
    Enter = "enterInstallationLine",
    Idle = "installationLine_1",
    Click = "installationLine_2",
}
FoundationCharacter.voicePath = "Assets/_BundleResources/Character/"

FoundationCharacter.New = function(container)
    local self = {};
    setmetatable(self, FoundationCharacter);
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/UI/Foundation/FoundationCharacter.prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.ai = nil;
    self.character = nil;
    self.id = "";
    self.live = true;
    self.characterId = "";
    self.data = nil;
    self.buildingId = "";
    self.talk = nil;
    self.msg = nil;
    self.friendly = nil;
    self.friendFull = nil;
    self.comfort = nil;
    self.interact = nil;
    self.linePath = "";
    self.lineText = "";
    self.characterConfig = nil;
    self.OnLineTimer = function()
        if (self.linePath ~= "") then
            AudioMgr.Singleton:PlayVoice(self.linePath, true, false);
            if (self.lineText ~= "") then
                local time = AudioMgr.Singleton:GetClipTime(self.linePath);
                FoundationCharacterMgr.SetCharacterMsg(self, LuaMgr.GetLangText(self.lineText), time);
            else
                self:HideMsg();
            end
        end
    end
    return self;
end

function FoundationCharacter:SetData(id, characterId, skinId, buildingId, data, shadow)
    self.id = id;
    self.characterId = characterId;
    self.buildingId = buildingId;
    self.skinId=skinId;
    self.data = data;
    self.gameObject.name = id;
    self.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, skinId, self.transform);
    if (self.character ~= nil) then

        self.character:SetShadow(shadow);
        self.character:SetDistortZIntensity(true);
        self.characterConfig = ConfigMgr.Config.FoundationCharacterMap[characterId];
        self.character:SetRotation(0, 180, 0);
        self.character:Play(self.characterConfig.Idle, 1, true, nil);
    end
end

function FoundationCharacter:RoomRotation(roomId)
    if (self.character == nil) then return end

    local roomConfig = ConfigMgr.Config.roomMap[roomId];
    if (roomConfig == nil) then return end

    local spineTF = self.character.transform:Find("Spine");
    if (spineTF == nil) then return end
    
    spineTF.localRotation = UnityEngine.Quaternion.Euler(roomConfig.Rotation, 0, 0);
end

function FoundationCharacter:SetAI(ai, grid, moves, data)
    self.ai = ai;
    self.ai:SetData(self, grid, moves, data);
end

function FoundationCharacter:SetAIWalk(targetPos, endCallback)
    self.ai:Move(targetPos, endCallback);
end

function FoundationCharacter:SetTalk(talk)
    self.talk = talk;
    self.talk:SetData(self);
end

function FoundationCharacter:RemoveTalk()
    if (self.talk ~= nil) then
        self.talk:Clear();
        self.talk = nil;
    end
end

function FoundationCharacter:SetMsg(msg, content, time)
    self.msg = msg;
    self.msg:SetData(self, content, time);
end

function FoundationCharacter:HideMsg()
    if (self.msg ~= nil) then
        self.msg:Hide();
    end
end

function FoundationCharacter:RemoveMsg()
    if (self.msg ~= nil) then
        self.msg:Clear();
        self.msg = nil;
    end
end

function FoundationCharacter:SetFriendly(friendly)
    self.friendly = friendly;
    self.friendly:SetData(self);
end

function FoundationCharacter:SetFriendFull(friendFull)
    self.friendFull = friendFull;
    self.friendFull:SetData(self);
end

function FoundationCharacter:HideFriendly()
    self.friendly:Hide();
end

function FoundationCharacter:RemoveFriendly()
    if (self.friendly ~= nil) then
        self.friendly:Clear();
        self.friendly = nil;
    end
end

function FoundationCharacter:RemoveFriendFull()
    if (self.friendFull ~= nil) then
        self.friendFull:Clear();
        self.friendFull = nil;
    end
end

function FoundationCharacter:SetComfort(comfort)
    self.comfort = comfort;
    self.comfort:SetData(self);
end

function FoundationCharacter:HideComfort()
    self.comfort:Hide();
end

function FoundationCharacter:RemoveComfort()
    if (self.comfort ~= nil) then
        self.comfort:Clear();
        self.comfort = nil;
    end
end

function FoundationCharacter:SetInteract(interact, type)
    self.interact = interact;
    self.interact:SetData(self, type);
end

function FoundationCharacter:HideInteract()
    if (self.interact ~= nil) then
        self.interact:Hide();
    end
end

function FoundationCharacter:RemoveInteract()
    if (self.interact ~= nil) then
        self.interact:Clear();
        self.interact = nil;
    end
end

function FoundationCharacter:Update()
    if (self.ai ~= nil) then
        self.ai:Update();
    end
    if (self.talk ~= nil) then
        self.talk:Update(self);
    end
    if (self.msg ~= nil) then
        self.msg:Update(self);
    end
    if (self.friendly ~= nil) then
        self.friendly:Update(self);
    end
    if (self.friendFull ~= nil) then
        self.friendFull:Update(self);
    end
    if (self.comfort ~= nil) then
        self.comfort:Update(self);
    end
    if (self.interact ~= nil) then
        self.interact:Update(self);
    end
end

function FoundationCharacter:Clear()
    LuaMgr.RemoveTimer(TimerConst.FoundationCharacterLineDelay);
    self.data = nil;
    if (self.ai ~= nil) then
        self.ai:Clear();
        self.ai = nil;
    end
    self:RemoveTalk();
    self:RemoveMsg();
    self:RemoveFriendly();
    self:RemoveFriendFull();
    self:RemoveComfort();
    self:RemoveInteract();
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

function FoundationCharacter:Click()
    if (self.characterConfig == nil) then return end
    
    self.ai:Play(self.characterConfig.Action);
    self:PlayVoice();
end

function FoundationCharacter:PlayVoice()
    if (self.characterConfig == nil) then
        self:PlayVoiceByType(FoundationCharacter.VoiceType.Click)
        return 
    end
    
    local len = #self.characterConfig.ClickSound;
    if (len > 0) then
        LuaMgr.RemoveTimer(TimerConst.FoundationCharacterLineDelay);
        FoundationMgr.StopVoice();
        local index = math.random(1, len);
        local line = self.characterConfig.ClickSound[index];
        local delay = tonumber(line[2]);
        self.linePath = string.format("Assets/_BundleResources/Character/%s/Audio/character_%s_%s001.mp3", self.characterId, line[1], self.characterId);
        self.lineText = line[3];
        if (delay > 0) then
            LuaMgr.AddTimer(TimerConst.FoundationCharacterLineDelay, self.OnLineTimer, delay * 0.001, 1, false);
        else
            self.OnLineTimer();
        end
    else
        self:PlayVoiceByType(FoundationCharacter.VoiceType.Click)
    end
end



function FoundationCharacter:PlayVoiceByType(type)
    local andioSkin = self:GatSkinID()
    local audioName = string.format("character_%s_%s", type, andioSkin)
    local characterId = self.characterConfig.Id
    local audioType = "Audio"
    local dataCharacter = DataMgr.Player.characters[characterId]
    if dataCharacter then
        local saying_type = dataCharacter.LinesType
        local sayingResLine = ConfigMgr.Config.RESLinesMap[characterId]
        if saying_type == "" then
            saying_type = sayingResLine.Linestype[1]
        end
        audioType = saying_type == sayingResLine.Linestype[1] and "Audio" or "Audio_" .. saying_type;
    end
    local path = string.format("%s%s/%s/%s.mp3", FoundationCharacter.voicePath, characterId, audioType, audioName);
    local playRes = AudioMgr.Singleton:PlayVoice(path, true, false)
    if IsNullOrEmpty(playRes) then
        andioSkin = self:GatSkinID(true)
        audioName = string.format("character_%s_%s", type, andioSkin)
        path = string.format("%s%s/%s/%s.mp3", FoundationCharacter.voicePath, characterId, audioType, audioName);
        AudioMgr.Singleton:PlayVoice(path, true, false)
    end
end

function FoundationCharacter:GatSkinID(isDefault)
    local characterId = self.characterConfig.Id
    local skinID = HeroManager.GetCharacterSkin(characterId);
    local cfgCharacterLines = ConfigMgr.Config.characterLines[skinID];
    if cfgCharacterLines == nil or isDefault == true then
        skinID = characterId .. "001";
    end
    return skinID;
end