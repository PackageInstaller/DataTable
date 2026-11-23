FoundationFriendlyItem = {};

FoundationFriendlyItem.__index = FoundationFriendlyItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    count = { path = "Count", type = "Text" },
    progressGO = { path = "Progress", type = "GameObject" },
    progressBar = { path = "Progress/Bar", type = "Image" },
    max = { path = "Max", type = "GameObject" },
    msg = { path = "Msg", type = "GameObject" },
}

function FoundationFriendlyItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationFriendlyItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    return self;
end

function FoundationFriendlyItem:SetData(data)
    local characterData = DataMgr.Player.characters[data.characterId];
    if (characterData == nil) then return end
    
    local skinId = HeroMgr.GetCharacterSkin(data.characterId);
    self.icon.texture = GetCharacterTexture(data.characterId, skinId);
    self.count.text = "+" .. data.count;
    local isMaxLevel = characterData.prestigeLevel >= 10;
    SetActive(self.msg, isMaxLevel);
    if (not isMaxLevel) then
        local hg = DataMgr.Player.weeklyCount["prest_" .. data.characterId] or 0;
        local maxHG = ConfigMgr.Config.constants.MaxPrestigeByWorkPerWeek;
        self.progressBar.fillAmount = hg / maxHG;
        SetActive(self.max, hg >= maxHG);
    else
        SetActive(self.max, false);
    end
    SetActive(self.progressGO, not isMaxLevel);
    SetActive(self.gameObject, true);
end

function FoundationFriendlyItem:Clear()
    self.icon.texture = nil;
    SetActive(self.gameObject, false);
end

function FoundationFriendlyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end