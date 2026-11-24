SeasonSLGDailyRecordEventItem = {};

SeasonSLGDailyRecordEventItem.__index = SeasonSLGDailyRecordEventItem;

local objs = {
    txtDesc = { path = "", type = "Text" },
    rectRoot = { path = "", type = "RectTransform" },
    playerGo = { path = "player", type = "GameObject" },
    txtPlayerPrefix = { path = "player", type = "Text" },
    rectPlayer = { path = "player", type = "RectTransform" },
    txtName = { path = "player/txtName", type = "Text" },
    rectName = { path = "player/txtName", type = "RectTransform" },
    goNameBg = { path = "player/goNameBg", type = "GameObject" },
    rectNameBg = { path = "player/goNameBg", type = "RectTransform" },
};

local MIN_ITEM_HEIGHT = 30;
local MIN_NAME_BG_WIDTH = 60;
local NAME_RESERVED_EXTRA = 10;
local NBSP = string.char(194, 160);

function SeasonSLGDailyRecordEventItem.New()
    local self = {};
    setmetatable(self, SeasonSLGDailyRecordEventItem);
    return self;
end

function SeasonSLGDailyRecordEventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.baseNameBgWidth = self.rectNameBg ~= nil and self.rectNameBg.sizeDelta.x or 0;
    self.baseNameWidth = self.rectName ~= nil and self.rectName.sizeDelta.x or 0;
    self.basePlayerWidth = self.rectPlayer ~= nil and self.rectPlayer.sizeDelta.x or 160;
    self.baseRootWidth = self.rectRoot ~= nil and self.rectRoot.sizeDelta.x or 242;
    self.nameBgLeft = self:GetNameBgLeft(self.baseNameBgWidth);
    self.nameTextLeft = self:GetNameTextLeft();
    self.nameBgLeftPadding = math.max(0, self.nameTextLeft - self.nameBgLeft);
    self.nameBgRightPadding = math.max(0, self.baseNameBgWidth - self.nameBgLeftPadding - self.baseNameWidth);
end

function SeasonSLGDailyRecordEventItem:SetData(data)
    self.data = data ~= nil and data.data or data;
    if self.data == nil then
        return MIN_ITEM_HEIGHT;
    end

    local desc = self.data.desc or "";
    local name = self.data.name;
    local hasName = not IsNullOrEmpty(name);
    local prefix = self.data.prefix or LuaMgr.GetLangText("SeasonSLGDailyRecordEventItem_0");
    local spaces = "";

    SetActive(self.playerGo, hasName);
    if hasName then
        if self.txtPlayerPrefix ~= nil then
            self.txtPlayerPrefix.text = prefix;
        end
        if self.txtName ~= nil then
            self.txtName.text = name;
        end
        spaces = self:BuildPrefixSpaces(self:RefreshNameBgWidth());
    end

    if self.txtDesc ~= nil then
        self.txtDesc.text = spaces .. desc;
    end

    local height = self:GetPreferredHeight();
    if self.rectRoot ~= nil then
        self.rectRoot.sizeDelta = Vector2(self.baseRootWidth, height);
    end
    return height;
end

function SeasonSLGDailyRecordEventItem:RefreshNameBgWidth()
    local nameWidth = 0;
    if self.txtName ~= nil then
        nameWidth = self.txtName.preferredWidth;
    end

    if self.rectName ~= nil then
        self.rectName.sizeDelta = Vector2(nameWidth, self.rectName.sizeDelta.y);
    end

    local bgWidth = math.max(MIN_NAME_BG_WIDTH, nameWidth + 14);
    if self.rectNameBg ~= nil then
        self.rectNameBg.sizeDelta = Vector2(bgWidth, self.rectNameBg.sizeDelta.y);
    end

    return self:GetNameRightEdge(bgWidth) + NAME_RESERVED_EXTRA;
end

function SeasonSLGDailyRecordEventItem:GetNameTextLeft()
    if self.rectPlayer == nil or self.rectName == nil then
        return 0;
    end

    local playerLeft = self.rectPlayer.anchoredPosition.x;
    local textAnchorX = self.rectPlayer.sizeDelta.x * self.rectName.anchorMin.x;
    return playerLeft + textAnchorX + self.rectName.anchoredPosition.x - self.baseNameWidth * self.rectName.pivot.x;
end

function SeasonSLGDailyRecordEventItem:GetNameBgLeft(bgWidth)
    if self.rectPlayer == nil or self.rectNameBg == nil then
        return 0;
    end

    local playerLeft = self.rectPlayer.anchoredPosition.x;
    local bgAnchorX = self.rectPlayer.sizeDelta.x * self.rectNameBg.anchorMin.x;
    return playerLeft + bgAnchorX + self.rectNameBg.anchoredPosition.x - bgWidth * self.rectNameBg.pivot.x;
end

function SeasonSLGDailyRecordEventItem:GetNameRightEdge(bgWidth)
    if self.rectPlayer == nil or self.rectNameBg == nil then
        return self.basePlayerWidth or 160;
    end

    return self:GetNameBgLeft(bgWidth) + bgWidth;
end

function SeasonSLGDailyRecordEventItem:BuildPrefixSpaces(reservedWidth)
    if self.txtDesc == nil then
        return "";
    end

    local spaceWidth = 5;
    if spaceWidth <= 0 then
        spaceWidth = self.txtDesc.fontSize * 0.5;
    end

    local spaceCount = math.ceil((reservedWidth or 0) / spaceWidth);
    return string.rep(NBSP, spaceCount);
end

function SeasonSLGDailyRecordEventItem:GetPreferredHeight()
    if self.txtDesc == nil then
        return MIN_ITEM_HEIGHT;
    end

    local height = math.ceil(self.txtDesc.preferredHeight);
    if height < MIN_ITEM_HEIGHT then
        height = MIN_ITEM_HEIGHT;
    end
    return height;
end

function SeasonSLGDailyRecordEventItem:Clear()
    self.data = nil;
end

function SeasonSLGDailyRecordEventItem:Destroy()
    self:Clear();
    if self.gameObject ~= nil then
        LuaMgr.DestroyImmediateGO(self.gameObject);
    end
    self.gameObject = nil;
end