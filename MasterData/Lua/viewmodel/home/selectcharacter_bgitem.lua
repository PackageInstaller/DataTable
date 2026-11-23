SelectCharacter_BgItem = {};

SelectCharacter_BgItem.__index = SelectCharacter_BgItem;

local objs = {
    button = {path = "", type = "Button"},
    normal = { path = "group/Normal", type = "GameObject" },
    select = { path = "group/Select", type = "GameObject" },
    bgPic = { path = "group/BgPic", type = "RawImage" },
    nameGO = { path = "group/Name", type = "GameObject" },
    nameText = { path = "group/Name/Text", type = "Text" },
    lockNameGO = { path = "group/LockName", type = "GameObject" },
    lockNameText = { path = "group/LockName/Text", type = "Text" },
    preview = { path = "group/Preview", type = "GameObject" },
    unlock = { path = "group/Unlock", type = "GameObject" },
    lock = { path = "group/Lock", type = "GameObject" },
    useGO = { path = "group/Use", type = "GameObject" },
    useText = { path = "group/Use/Text", type = "Text" },
    dot = { path = "group/Dot", type = "GameObject" },
}

function SelectCharacter_BgItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_BgItem);
    return self;
end

function SelectCharacter_BgItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local isLock = self:IsLock();
        local key = DataMgr.Player.uid .. "_BgSwitch_" .. self.data.config.Id
        PlayerPrefs.SetInt(key,1)
        SetActive(self.dot, false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SelectCharacterSelectBg, self.data.config, isLock);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function SelectCharacter_BgItem:SetData(data)
    self.data = data.data;
    SetActive(self.normal, not self.data.select);
    SetActive(self.select, self.data.select);
    local bgPath = string.format("Assets/_BundleResources/Images/Home/%s.png", self.data.config.Image);
    self.bgPic.texture = LuaMgr.GetTexture(bgPath);
    local nameStr = LuaMgr.GetLangText(self.data.config.NameLan);
    self.nameText.text = nameStr;
    self.lockNameText.text = nameStr;
    local isLock = self:IsLock();
    local isUnlock = self:IsUnlock();
    if (isLock) then
        SetActive(self.nameGO, false);
        SetActive(self.lockNameGO, true);
        if (isUnlock) then
            SetActive(self.lock, false);
        else
            SetActive(self.lock, true);
        end
    else
        SetActive(self.nameGO, true);
        SetActive(self.lockNameGO, false);
        SetActive(self.lock, false);
    end
    SetActive(self.preview, self.data.select);
    if (isLock and isUnlock) then
        SetActive(self.unlock, true);
        self.bgPic.color = UnityEngine.Color(1,1,1,0.5);
    else
        SetActive(self.unlock, false);
        self.bgPic.color = UnityEngine.Color(1,1,1,1);
    end
    self.useText.text = ConfigMgr.LangGlobal("15959");
    SetActive(self.useGO, DataMgr.Player.currentBgImage == self.data.config.Id);

    if not isLock then
        local key = DataMgr.Player.uid .. "_BgSwitch_" .. self.data.config.Id
        SetActive(self.dot, self.data.config.DefaultUnlock == 0 and tonumber(self.data.config.Id) > 1006 and (not PlayerPrefs.HasKey(key) or PlayerPrefs.GetInt(key) == 0))
    else
        SetActive(self.dot, false)
    end
end

function SelectCharacter_BgItem:IsUnlock()
    local unlockItem1 = self.data.config.UnlockItem1;
    if (not IsNull(unlockItem1) and #unlockItem1 >= 2) then
        local count = PlayerItemMgr.GetItemCountById(unlockItem1[1]);
        return count >= tonumber(unlockItem1[2]);
    end
    local unlockItem2 = self.data.config.UnlockItem2;
    if (not IsNull(unlockItem2) and #unlockItem2 >= 2) then
        local count = PlayerItemMgr.GetItemCountById(unlockItem2[1]);
        return count >= tonumber(unlockItem2[2]);
    end
    return false;
end

function SelectCharacter_BgItem:IsLock()
    return DataMgr.Player.bgImages[self.data.config.Id] == nil;
end

function SelectCharacter_BgItem:Clear()
    self.data = nil;
end

function SelectCharacter_BgItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
end