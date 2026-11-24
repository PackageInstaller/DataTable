SeasonSLGOverviewGridLevelUpItem = {};

SeasonSLGOverviewGridLevelUpItem.__index = SeasonSLGOverviewGridLevelUpItem;

local objs = {
    txtTitle = { path = "Group/obj/title", type = "Text" },
    txtDesc = { path = "Group/obj/desc", type = "Text" },
    btnAction = { path = "Group/actionbutton", type = "Button" },
    goNormal = { path = "Group/actionbutton/Normal", type = "GameObject" },
    goSelected = { path = "Group/actionbutton/Selected", type = "GameObject" },
    goDisabled = { path = "Group/actionbutton/Disabled", type = "GameObject" },
    goLevel = { path = "Group/Level", type = "GameObject" },
    txtLevel = { path = "Group/Level/levelText", type = "Text" },
};

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

function SeasonSLGOverviewGridLevelUpItem.New()
    local self = {};
    setmetatable(self, SeasonSLGOverviewGridLevelUpItem);
    self.onClick = nil;
    return self;
end

function SeasonSLGOverviewGridLevelUpItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.callBack ~= nil then
            self.data.callBack(self.data);
        end
    end
    if self.btnAction ~= nil then
        LuaMgr.AddClick(self.btnAction, self.onClick);
    end
end

function SeasonSLGOverviewGridLevelUpItem:SetData(pdata)
    self.data = nil;
    if pdata ~= nil then
        self.data = pdata.data;
    end
    if self.data == nil then
        return;
    end

    SetText(self.txtTitle, self.data.title);
    SetText(self.txtDesc, self.data.desc);
    self:RefreshLevel();
    self:RefreshActionState();
end

function SeasonSLGOverviewGridLevelUpItem:RefreshLevel()
    local levelText = self.data.levelText;
    SetText(self.txtLevel, levelText);
    SetActive(self.goLevel, not IsNullOrEmpty(levelText));
end

function SeasonSLGOverviewGridLevelUpItem:RefreshActionState()
    local disabled = self.data.disabled == true;
    local selected = self.data.selected == true;

    SetActive(self.goNormal, not selected and not disabled);
    SetActive(self.goSelected, selected and not disabled);
    SetActive(self.goDisabled, disabled);
end

function SeasonSLGOverviewGridLevelUpItem:Clear()
    self.data = nil;
end

function SeasonSLGOverviewGridLevelUpItem:Destroy()
    if self.btnAction ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btnAction, self.onClick);
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end