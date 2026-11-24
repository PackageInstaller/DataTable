SeasonSLGOverviewCardItem = {};

SeasonSLGOverviewCardItem.__index = SeasonSLGOverviewCardItem;

local objs = {
    txtTitle = { path = "Group/obj/title", type = "Text" },
    txtDesc = { path = "Group/obj/desc", type = "Text" },
    btnAction = { path = "Group/actionbutton", type = "Button" },
    goNormal = { path = "Group/actionbutton/Normal", type = "GameObject" },
    goSelected = { path = "Group/actionbutton/Selected", type = "GameObject" },
    goDisabled = { path = "Group/actionbutton/Disabled", type = "GameObject" },
    goCountDown = { path = "Group/countDown", type = "GameObject" },
    txtCountDown = { path = "Group/countDown/countDownText", type = "Text" },
};

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

local function FormatCountDownTime(timeLeft)
    timeLeft = math.max(0, math.floor(timeLeft or 0));
    local day, hour, minute, second = GetTimeDHMS2(timeLeft);
    if day > 0 then
        return string.format("%d:%02d:%02d:%02d", day, hour, minute, second);
    end
    return string.format("%02d:%02d:%02d", hour, minute, second);
end

function SeasonSLGOverviewCardItem.New()
    local self = {};
    setmetatable(self, SeasonSLGOverviewCardItem);
    self.onClick = nil;
    self.countDown = nil;
    return self;
end

function SeasonSLGOverviewCardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.callBack ~= nil then
            self.data.callBack(self.data);
        end
    end
    self.OnCountDownTimer = function()
        self:RefreshCountDown();
    end
    if self.btnAction ~= nil then
        LuaMgr.AddClick(self.btnAction, self.onClick);
    end
end

function SeasonSLGOverviewCardItem:SetData(pdata)
    self:StopCountDown();
    self.data = nil;
    if pdata ~= nil then
        self.data = pdata.data;
    end
    if self.data == nil then
        SetActive(self.goCountDown, false);
        return;
    end

    SetText(self.txtTitle, self.data.title);
    SetText(self.txtDesc, self.data.desc);
    self:RefreshActionState();
    self:StartCountDown();
    if not IsNull(self.data.haveGoto) and self.data.haveGoto then
        SetActive(self.btnAction.gameObject,true)
    else
        SetActive(self.btnAction.gameObject,false)
    end
end

function SeasonSLGOverviewCardItem:RefreshActionState()
    local disabled = self.data.disabled == true;
    local selected = self.data.selected == true;

    SetActive(self.goNormal, not selected and not disabled);
    SetActive(self.goSelected, selected and not disabled);
    SetActive(self.goDisabled, disabled);
end

function SeasonSLGOverviewCardItem:StartCountDown()
    self.countDown = tonumber(self.data.countDown);
    if self.countDown == nil then
        SetText(self.txtCountDown, "");
        SetActive(self.goCountDown, false);
        return;
    end

    SetActive(self.goCountDown, true);
    self:RefreshCountDown();
    if self.countDown - LuaMgr.Timestamp() > 0 then
        LuaMgr.AddTimer(TimerConst.SeasonSLGOverviewCardCountDown, self.OnCountDownTimer, 1, -1, true);
    end
end

function SeasonSLGOverviewCardItem:RefreshCountDown()
    if self.data == nil or self.countDown == nil then
        return;
    end

    local timeLeft = self.countDown - LuaMgr.Timestamp();
    if timeLeft <= 0 then
        self:StopCountDown();
        SetText(self.txtCountDown, "");
        SetActive(self.goCountDown, false);
        return;
    end

    SetText(self.txtCountDown, FormatCountDownTime(timeLeft));
end

function SeasonSLGOverviewCardItem:StopCountDown()
    if self.countDown ~= nil then
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGOverviewCardCountDown);
    end
    self.countDown = nil;
end

function SeasonSLGOverviewCardItem:Clear()
    self:StopCountDown();
    self.data = nil;
    self.countDown = nil;
end

function SeasonSLGOverviewCardItem:Destroy()
    self:StopCountDown();
    if self.btnAction ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.btnAction, self.onClick);
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end