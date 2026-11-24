require("SeasonSLG/SeasonSLGDailyRecordEventItem")

local PANEL_NAME = "SeasonSLGDailyRecordPopupViewModel"

local this = {
    vm = nil,
    eventItems = {},
    eventItemTemplate = nil,
    eventItemTemplatePos = nil,
    eventItemTemplateWidth = 242,
};

local ui = {}

local data = {}

local command = {}

local function GetPanelName()
    return UIName ~= nil and UIName.SeasonSLGDailyRecordPopupViewModel or PANEL_NAME;
end

local function FindTransform(root, path)
    if root == nil then
        return nil;
    end
    if IsNullOrEmpty(path) then
        return root.transform;
    end
    return root.transform:Find(path);
end

local function FindComponent(root, path, componentName)
    local transform = FindTransform(root, path);
    if transform == nil then
        return nil;
    end
    if componentName == "GameObject" or componentName == nil then
        return transform.gameObject;
    end
    return transform:GetComponent(componentName);
end

local function SetText(text, value)
    if text ~= nil then
        text.text = value or "";
    end
end

local function SetFillAmount(image, value)
    if image ~= nil then
        image.fillAmount = value or 0;
    end
end

local function AddClick(btn, callback)
    if btn ~= nil then
        LuaMgr.AddClick(btn, callback);
    end
end

local function RemoveClick(btn, callback)
    if btn ~= nil then
        LuaMgr.RemoveClick(btn, callback);
    end
end

this.InitUI = function(prefab)
    ui.root = FindComponent(prefab, "root", "GameObject");
    ui.middle = FindComponent(prefab, "root/Middle", "GameObject");
    ui.btnMask = FindComponent(prefab, "root/btnMask", "Button");

    ui.txtActiveCount = FindComponent(prefab, "root/Middle/active/activeCount", "Text");
    ui.txtDispatchCount = FindComponent(prefab, "root/Middle/dispatch/dispatchCount", "Text");
    ui.txtBossDamage = FindComponent(prefab, "root/Middle/boss/bossDamage", "Text");

    ui.txtProgressRate = FindComponent(prefab, "root/Middle/mapExlore/txtProgressRate", "Text");
    ui.txtProgressRateChange = FindComponent(prefab, "root/Middle/mapExlore/txtProgressRateChange", "Text");
    ui.imgProgress = FindComponent(prefab, "root/Middle/mapExlore/progress/goProgress", "Image");

    ui.txtYear = FindComponent(prefab, "root/Middle/txtYear", "Text");
    ui.txtMAndD = FindComponent(prefab, "root/Middle/txtMAndD", "Text");
    ui.scrollRect = FindComponent(prefab, "root/Middle/Scroll View", "ScrollRect");
    ui.eventContent = FindComponent(prefab, "root/Middle/Scroll View/Viewport/Content", "RectTransform");
    this.eventContentMinHeight = ui.eventContent ~= nil and ui.eventContent.sizeDelta.y or 300;

    this.eventItemTemplate = FindComponent(prefab, "template/eventItem", "GameObject");
    if this.eventItemTemplate ~= nil then
        local rect = this.eventItemTemplate:GetComponent("RectTransform");
        this.eventItemTemplatePos = rect.anchoredPosition;
        this.eventItemTemplateWidth = rect.sizeDelta.x;
        SetActive(this.eventItemTemplate, false);
    end
end

this.ClearUI = function()
    ui = {};
    this.eventItemTemplate = nil;
    this.eventItemTemplatePos = nil;
end

this.AddEvents = function()
    AddClick(ui.btnMask, this.OnClickClose);
    LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.RefreshWorldExplore);
end

this.RemoveEvents = function()
    RemoveClick(ui.btnMask, this.OnClickClose);
    LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGWorldProgressChange, this.RefreshWorldExplore);
end

this.OnClickClose = function()
    LuaMgr.HidePanel(GetPanelName());
end

this.Refresh = function()
    local viewData = this.BuildViewData();
    this.RefreshDate(viewData.dateTime);
    this.RefreshFakeStats(viewData);
    this.RefreshWorldExplore();
    this.RefreshEvents(viewData.eventList);
end

this.BuildViewData = function()
    return {
        dateTime = LuaMgr.Timestamp(),
        activeCount = "25000",
        dispatchCount = "25000",
        bossDamage = "25000",
        eventList = this.BuildFakeEventList(),
    };
end

this.BuildFakeEventList = function()
    return {
        { desc = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_0") },
        { prefix = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_1"), name = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_3"), desc = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_2") },
        { desc = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_4") },
        { prefix = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_5"), name = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_6"), desc = LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_7") },
    };
end

this.RefreshDate = function(timestamp)
    timestamp = tonumber(timestamp) or LuaMgr.Timestamp();
    local date = os.date("!*t", timestamp + 8 * 3600);
    SetText(ui.txtYear, string.format(LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_8"), date.year));
    SetText(ui.txtMAndD, string.format(LuaMgr.GetLangText("SeasonSLGDailyRecordPopupViewModel_9"), date.month, date.day));
end

this.RefreshFakeStats = function(viewData)
    SetText(ui.txtActiveCount, viewData.activeCount);
    SetText(ui.txtDispatchCount, viewData.dispatchCount);
    SetText(ui.txtBossDamage, viewData.bossDamage);
end

this.RefreshWorldExplore = function()
    local progress = 0;
    if SeasonSLGTimeEventMgr ~= nil and SeasonSLGTimeEventMgr.GetWorldProgress ~= nil then
        progress = tonumber(SeasonSLGTimeEventMgr.GetWorldProgress()) or 0;
    end

    local progressValue = progress / 10000.0;
    local progressText = tostring(100 - progress / 100.0) .. "%";
    SetText(ui.txtProgressRate, progressText);
    SetText(ui.txtProgressRateChange, "+0%");
    SetFillAmount(ui.imgProgress, progressValue);
end

this.RefreshEvents = function(eventList)
    this.ClearEvents();
    if this.eventItemTemplate == nil or ui.eventContent == nil or eventList == nil then
        return;
    end

    local offsetY = 0;
    local spacing = 10;
    local posX = 0;

    for i = 1, #eventList do
        local gameObject = LuaMgr.InstantiateGO(this.eventItemTemplate, ui.eventContent, false);
        if gameObject ~= nil then
            SetActive(gameObject, true);
            local item = SeasonSLGDailyRecordEventItem.New();
            item.gameObject = gameObject;
            item.transform = gameObject.transform;
            item:Init();
            local height = item:SetData(eventList[i]);
            local rect = gameObject:GetComponent("RectTransform");
            rect.anchoredPosition = Vector2(posX, -offsetY);
            table.insert(this.eventItems, item);
            offsetY = offsetY + height + spacing;
        end
    end

    if ui.eventContent ~= nil then
        local contentHeight = math.max(offsetY, this.eventContentMinHeight or 300);
        ui.eventContent.sizeDelta = Vector2(ui.eventContent.sizeDelta.x, contentHeight);
    end
    if ui.scrollRect ~= nil then
        ui.scrollRect.verticalNormalizedPosition = 1;
    end
end

this.ClearEvents = function()
    for i = #this.eventItems, 1, -1 do
        local item = this.eventItems[i];
        if item ~= nil then
            item:Destroy();
        end
        this.eventItems[i] = nil;
    end
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.InitUI(vm.behaviour);
    end,
    before_active = function(vm)
        this.AddEvents();
        this.Refresh();
    end,
    before_deactive = function(vm)
        this.RemoveEvents();
        this.ClearEvents();
    end,
    before_destroy = function()
        this.ClearEvents();
        this.ClearUI();
        this.vm = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})