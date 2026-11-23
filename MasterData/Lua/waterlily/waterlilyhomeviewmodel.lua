require("Waterlily/WaterlilyConst")
local this = {};

local objs = {

    characterObj = { path = "root/Character", type = "GameObject" },
    spineCharacter = { path = "root/Character/Body", type = "UISpineCharacter" },
    sleepCharacter = { path = "root/SleepCharacter", type = "GameObject" },
    sandTableBtn = { path = "root/Middle/Right/SandTable", type = "Button" },
    sandTableRedDot = { path = "root/Middle/Right/SandTable/RedDot", type = "GameObject" },
    levelBtn = { path = "root/Middle/Right/Level", type = "Button" },
    levelRedDot = { path = "root/Middle/Right/Level/RedDot", type = "GameObject" },
    signInBtn = { path = "root/Middle/Left/SignIn", type = "Button" },
    signInRedDot = { path = "root/Middle/Left/SignIn/RedDot", type = "GameObject" },
    shopBtn = { path = "root/Middle/Left/Shop", type = "Button" },
    shopRedDot = { path = "root/Middle/Left/Shop/RedDot", type = "GameObject" },
    dayText = { path = "root/Middle/TitleGroup/TextTime", type = "Text" },
    guessPanelBtn = { path = "root/Middle/Right/GuessPanelBtn", type = "Button" },
    collectBtn = { path = "root/Middle/TitleGroup/CollectBtn", type = "Button" },
    collectText = { path = "root/Middle/TitleGroup/CollectText", type = "Text" },
};


this.SetData = function()  
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.Waterlily);
        local time = daqin.expireTime - LuaMgr.Timestamp();
        d, h, m = GetTimeDHM(time);
    end
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.dayText.text = string.format(timeStr);
    this.OnUpdateMedalCollect()    
    for key, value in pairs(WaterlilyConst.DaliyTipRedID) do
        if RedMgr.Singleton:CheckRedCondition(value) then
            RedMgr.Singleton:UpdateClientRedData(value, PlayerWaterlilyMgr.CheckGuessAllFinishRedNum(value))
        else
            RedMgr.Singleton:UpdateClientRedData(value, 0)
        end
    end
    PlayerMedalMgr.CheckMedalPopup(WaterlilyConst.MedalActivityID)
end

this.OnUpdateMedalCollect = function ()
    local medalActivityID = WaterlilyConst.MedalActivityID
    local finishMedalCount = DataExHelper.GetMedalFinishCount(medalActivityID)
    this.medalList = DataExHelper.GetMedalList(medalActivityID)
    this.collectText.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount, #this.medalList)
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        LuaMgr.Back(ActivityKey.Waterlily)
    else
        LuaMgr.Back()
    end
end


this.OnClickLevel = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WaterlilySelectLvViewModel);        
        if RedMgr.Singleton:CheckRedCondition(WaterlilyConst.DaliyTipRedID.Level) then
            RedMgr.Singleton:FrushRedCondition(WaterlilyConst.DaliyTipRedID.Level)
        end
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WaterlilyPlayViewModel)
        if RedMgr.Singleton:CheckRedCondition(WaterlilyConst.DaliyTipRedID.SandTable) then
            RedMgr.Singleton:FrushRedCondition(WaterlilyConst.DaliyTipRedID.SandTable)
        end
    end
end


this.OnClickShop = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WaterlilyShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel);
    end
end

this.OnClickGuessPanelBtn =function ()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WaterlilyGuessSelectPanel);
        if RedMgr.Singleton:CheckRedCondition(WaterlilyConst.DaliyTipRedID.Guess) then
            RedMgr.Singleton:FrushRedCondition(WaterlilyConst.DaliyTipRedID.Guess)
        end
    end
end

this.OnClickCollectBtn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ActivityCollectPanel, WaterlilyConst.MedalActivityID, "#878D14");
    end
end

this.OnCheckStatusSwatch = function()
    local curHour = LuaMgr.GetNowHour()

    if curHour < 8 or curHour >= 18 then
        if this.sleepCharacter.activeSelf == false then
            SetActive(this.sleepCharacter, true)
            SetActive(this.characterObj, false)
        end
    else
        if this.characterObj.activeSelf == false then
            SetActive(this.characterObj, true)
            SetActive(this.sleepCharacter, false)
            local skinId2 = "ED90701"
            this.spineCharacter:SetBattle(skinId2, skinId2, "-1", 0, function()
                this.spineCharacter:Play("idle", true, nil);
            end)
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.levelBtn, this.OnClickLevel);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.guessPanelBtn, this.OnClickGuessPanelBtn);
        LuaMgr.AddClick(this.collectBtn, this.OnClickCollectBtn);
        LuaMgr.AddUIEventListener(UIEventConst.MedalCollectUpdate, this.OnUpdateMedalCollect)
        RedMgr.Singleton:RegisterViewModel(UIName.WaterlilyHomeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetWaterlilyRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
        if (this.spineGO == nil) then
            local path = "Assets/_BundleResources/UI/KV/KV21.prefab";
            this.spineGO = LuaMgr.GetPrefab(path);

            this.spineGO.transform.localScale = Vector3(1, 1, 1);
            local logo = this.spineGO.transform:Find("KV21/logo")
            logo.gameObject:SetActive(false)
        end
        this.OnCheckStatusSwatch()
        LuaMgr.AddTimer(TimerConst.WaterlilyStatusSwatch, this.OnCheckStatusSwatch, 300, -1, false);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.WaterlilyStatusSwatch);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.levelBtn, this.OnClickLevel);
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.guessPanelBtn, this.OnClickGuessPanelBtn);
        LuaMgr.RemoveClick(this.collectBtn, this.OnClickCollectBtn);
        LuaMgr.RemoveUIEventListener(UIEventConst.MedalCollectUpdate, this.OnUpdateMedalCollect)
        RedMgr.Singleton:RemoveViewModel(UIName.WaterlilyHomeViewModel);        
        if (this.spineGO ~= nil and not LuaMgr.IsObjectNull(this.spineGO)) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end        
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})