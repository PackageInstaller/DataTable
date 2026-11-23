FoundationCharacterInteract = {};

FoundationCharacterInteract.__index = FoundationCharacterInteract;

local objs = {
    cleanGO = { path = "Clean", type = "GameObject" },
    cleanBtn = { path = "Clean", type = "Button" },
    messageGO = { path = "Message", type = "GameObject" },
    messageBtn = { path = "Message", type = "Button" },
    messageText = { path = "Message/Text", type = "Text" },
    rewardGO = { path = "Reward", type = "GameObject" },
    rewardBtn = { path = "Reward", type = "Button" },
};

FoundationCharacterInteract.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterInteract);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterInteract.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.character = nil;
    self.InteractResponse = function(result)
        self:Hide();
        local resultData = json.decode(result);
        if (resultData ~= nil and resultData.result ~= nil) then
            if (not IsNull(resultData.result.Rewards)) then
                local reward = json.encode(resultData.result.Rewards);
                LuaMgr.ShowItemRewared(reward);
            end
        end
    end
    self.OnClickInteract = function()
        if (self.type == ActivityRoomInteract.Message) then
            PlayerFoundationMgr.Interact(self.type, self.InteractResponse, nil, self.character.characterId);
        else
            PlayerFoundationMgr.Interact(self.type, self.InteractResponse);
        end
    end
    LuaMgr.AddClick(self.cleanBtn, self.OnClickInteract);
    LuaMgr.AddClick(self.messageBtn, self.OnClickInteract);
    LuaMgr.AddClick(self.rewardBtn, self.OnClickInteract);
    return self;
end

function FoundationCharacterInteract:SetData(character, type)
    self.character = character;
    self.type = type;
    SetActive(self.cleanGO, false);
    SetActive(self.messageGO, false);
    SetActive(self.rewardGO, false);
    if (type == ActivityRoomInteract.Clean) then
        SetActive(self.cleanGO, true);
    elseif (type == ActivityRoomInteract.Message) then
        local msg = FoundationRoomCtrl.GetInteractMessage();
        if (msg ~= nil) then
            self.messageText.text = LuaMgr.GetLangText(msg.Textlan);
        else
            self.messageText.text = "";
        end
        SetActive(self.messageGO, true);
    elseif (type == ActivityRoomInteract.Reward) then
        SetActive(self.rewardGO, true);
    end
    self:SetPosition(character);
    self.gameObject:SetActive(true);
end

function FoundationCharacterInteract:Hide()
    if (self.gameObject.activeSelf) then
        self.gameObject:SetActive(false);
    end
end

function FoundationCharacterInteract:IsShow()
    return self.gameObject.activeSelf;
end

function FoundationCharacterInteract:Update(character)
    self:SetPosition(character);
end

function FoundationCharacterInteract:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    self.pos.x = p.x + 10;
    self.pos.y = p.y - 5;
    self.transform.localPosition = self.pos;
end

function FoundationCharacterInteract:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    self.character = nil;
    if (self.gameObject ~= nil) then
        if (self.OnClickInteract ~= nil) then
            LuaMgr.RemoveClick(self.cleanBtn, self.OnClickInteract);
            LuaMgr.RemoveClick(self.messageBtn, self.OnClickInteract);
            LuaMgr.RemoveClick(self.rewardBtn, self.OnClickInteract);
            self.OnClickInteract = nil;
        end
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end