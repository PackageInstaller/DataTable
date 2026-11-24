SeasonSLGOverviewMiniGameItem = {};

SeasonSLGOverviewMiniGameItem.__index = SeasonSLGOverviewMiniGameItem;

local objs = {
    txtTitle = { path = "Group/obj/title", type = "Text" },
    txtScore = { path = "Group/obj/score", type = "Text" },
    goStar1 = { path = "Group/obj/score/star1", type = "GameObject" },
    goStar2 = { path = "Group/obj/score/star2", type = "GameObject" },
    goStar3 = { path = "Group/obj/score/star3", type = "GameObject" },
    btnAction = { path = "Group/actionbutton", type = "Button" },
    goNormal = { path = "Group/actionbutton/Normal", type = "GameObject" },
    goSelected = { path = "Group/actionbutton/Selected", type = "GameObject" },
    goDisabled = { path = "Group/actionbutton/Disabled", type = "GameObject" },
    goFinishedTime = { path = "Group/finishedTime", type = "GameObject" },
    txtFinishedTime = { path = "Group/finishedTime/finishedTimeText", type = "Text" },
};

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

function SeasonSLGOverviewMiniGameItem.New()
    local self = {};
    setmetatable(self, SeasonSLGOverviewMiniGameItem);
    self.onClick = nil;
    return self;
end

function SeasonSLGOverviewMiniGameItem:Init()
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

function SeasonSLGOverviewMiniGameItem:SetData(pdata)
    self.data = nil;
    if pdata ~= nil then
        self.data = pdata.data;
    end
    if self.data == nil then
        return;
    end

    SetText(self.txtTitle, self.data.title);
    SetText(self.txtScore, self.data.scoreText);
    self:RefreshStars();
    self:RefreshActionState();
    self:RefreshFinishedTime();
end

function SeasonSLGOverviewMiniGameItem:RefreshStars()
    local starCount = tonumber(self.data.starCount) or 0;
    SetActive(self.goStar1, starCount >= 1);
    SetActive(self.goStar2, starCount >= 2);
    SetActive(self.goStar3, starCount >= 3);
end

function SeasonSLGOverviewMiniGameItem:RefreshActionState()
    local disabled = self.data.disabled == true;
    local selected = self.data.selected == true;

    SetActive(self.goNormal, not selected and not disabled);
    SetActive(self.goSelected, selected and not disabled);
    SetActive(self.goDisabled, disabled);
end

function SeasonSLGOverviewMiniGameItem:RefreshFinishedTime()
    local finishedText = self.data.finishedTimeText;
    SetText(self.txtFinishedTime, finishedText);
    SetActive(self.goFinishedTime, not IsNullOrEmpty(finishedText));
end

function SeasonSLGOverviewMiniGameItem:Clear()
    self.data = nil;
end

function SeasonSLGOverviewMiniGameItem:Destroy()
    if self.btnAction ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btnAction, self.onClick);
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end