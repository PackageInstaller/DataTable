SeasonSLGOverviewFilterItem = {};

SeasonSLGOverviewFilterItem.__index = SeasonSLGOverviewFilterItem;

local objs = {
    btnClick = { path = "", type = "Button" },
    goNormal = { path = "goNormal", type = "GameObject" },
    goSelected = { path = "goSelected", type = "GameObject" },
    goDisabled = { path = "goDisabled", type = "GameObject" },
    txtNormalName = { path = "goNormal/txtName", type = "Text" },
    txtSelectedName = { path = "goSelected/txtName", type = "Text" },
    txtDisabledName = { path = "goDisabled/txtName", type = "Text" },
};

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

function SeasonSLGOverviewFilterItem.New()
    local self = {};
    setmetatable(self, SeasonSLGOverviewFilterItem);
    self.onClick = nil;
    return self;
end

function SeasonSLGOverviewFilterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.callBack ~= nil then
            self.data.callBack(self.data);
        end
    end
    LuaMgr.AddClick(self.btnClick, self.onClick);
end

function SeasonSLGOverviewFilterItem:SetData(pdata)
    self.data = nil;
    if pdata ~= nil then
        self.data = pdata.data;
    end
    if self.data == nil then
        return;
    end

    local name = self.data.name;
    local disabled = self.data.disabled == true;
    local selected = self.data.selected == true;

    SetText(self.txtNormalName, name);
    SetText(self.txtSelectedName, name);
    SetText(self.txtDisabledName, name);

    SetActive(self.goNormal, not selected and not disabled);
    SetActive(self.goSelected, selected and not disabled);
    SetActive(self.goDisabled, disabled);
end

function SeasonSLGOverviewFilterItem:Clear()
    self.data = nil;
end

function SeasonSLGOverviewFilterItem:Destroy()
    if self.btnClick ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btnClick, self.onClick);
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end